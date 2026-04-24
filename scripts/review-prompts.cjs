#!/usr/bin/env node
const fs = require('fs');
const path = require('path');
const { getJobPromptTemplate, getMajorPromptTemplate } = require('./prompt-templates.cjs');

const OLLAMA_URL = process.env.OLLAMA_URL || 'http://localhost:11434';
const OLLAMA_MODEL = process.env.OLLAMA_MODEL || 'gemma4:26b';
const LORA_NAME = 'cwbeaver.safetensors';
const LORA_DIR = path.join(process.env.COMFYUI_MODELS || 'C:\\Users\\user\\Documents\\ComfyUI\\models', 'loras');
const DEFAULT_OUTPUT = path.join(__dirname, '..', '.prompt-reviews');

function parseArgs() {
  const args = {};
  for (const arg of process.argv.slice(2)) {
    if (!arg.startsWith('--')) continue;
    const [key, ...rest] = arg.slice(2).split('=');
    args[key] = rest.length ? rest.join('=') : true;
  }
  return args;
}

function loadDevVars() {
  const devVarsPath = path.join(__dirname, '..', 'dev.vars');
  const vars = {};
  if (!fs.existsSync(devVarsPath)) return vars;
  for (const line of fs.readFileSync(devVarsPath, 'utf8').split('\n')) {
    const trimmed = line.trim();
    if (!trimmed || trimmed.startsWith('#')) continue;
    const eqIdx = trimmed.indexOf('=');
    if (eqIdx > 0) {
      vars[trimmed.slice(0, eqIdx).trim()] = trimmed.slice(eqIdx + 1).trim();
    }
  }
  return vars;
}

function hasLoraFile() {
  return fs.existsSync(path.join(LORA_DIR, LORA_NAME));
}

async function checkOllama() {
  try {
    const res = await fetch(`${OLLAMA_URL}/api/tags`);
    if (!res.ok) return false;
    const data = await res.json();
    return !!data.models?.some(m => m.name === OLLAMA_MODEL || m.name.startsWith(OLLAMA_MODEL.split(':')[0]));
  } catch {
    return false;
  }
}

async function generatePromptOllama(systemPrompt) {
  const res = await fetch(`${OLLAMA_URL}/api/chat`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({
      model: OLLAMA_MODEL,
      messages: [
        { role: 'system', content: 'You are an expert image prompt writer. Follow all instructions precisely and output only the requested paragraph.' },
        { role: 'user', content: systemPrompt },
      ],
      stream: false,
      think: false,
      options: { temperature: 0.7, top_p: 0.9, num_predict: 2048 },
    }),
  });
  if (!res.ok) throw new Error(`Ollama HTTP ${res.status}`);
  const data = await res.json();
  const rawContent = data.message?.content || '';
  const rawThinking = data.message?.thinking || '';
  const text = (rawContent || rawThinking).trim().replace(/^["']|["']$/g, '').trim();
  if (!text) throw new Error('Ollama 응답이 비어 있습니다.');
  return text;
}

async function generatePromptGemini(systemPrompt, apiKey) {
  const res = await fetch(
    `https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=${apiKey}`,
    {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        contents: [{ parts: [{ text: systemPrompt }] }],
        generationConfig: { temperature: 0.7, maxOutputTokens: 1000, topP: 0.9 },
      }),
    }
  );
  if (!res.ok) throw new Error(`Gemini HTTP ${res.status}`);
  const data = await res.json();
  const text = data.candidates?.[0]?.content?.parts?.[0]?.text?.trim()?.replace(/^["']|["']$/g, '').trim();
  if (!text) throw new Error('Gemini 응답이 비어 있습니다.');
  return text;
}

function analyzePrompt(type, prompt) {
  const abstractTerms = ['performing duties', 'consulting', 'analyzing', 'overseeing', 'studying', 'learning'];
  return {
    mentionsCenter: /middle third|center(?:ed)? in the (?:middle )?third|center(?:ed)? in the frame|center of the frame/i.test(prompt),
    themeOk: type === 'majors' ? /(emerald|jade|green)/i.test(prompt) : /(indigo|blue-violet|navy)/i.test(prompt),
    hasEnvironmentDensity: /(featuring|surrounded by|beside|next to|background).*?,.*?,/i.test(prompt),
    hasConcreteToolCue: /(holding|using|grips|adjusting|operating|arranging|polishing|stamping|tightening|soldering|pipetting|sculpting)/i.test(prompt),
    abstractTerms: abstractTerms.filter(term => prompt.toLowerCase().includes(term)),
  };
}

async function main() {
  const args = parseArgs();
  const type = args.type || 'jobs';
  const slugs = String(args.slugs || '').split(',').map(s => s.trim()).filter(Boolean);
  const noLora = !!args['no-lora'];
  const outputDir = args.output ? path.resolve(args.output) : DEFAULT_OUTPUT;
  const devVars = loadDevVars();
  const loraOk = !noLora && hasLoraFile();

  if (!slugs.length) {
    throw new Error('검토할 slug 목록이 필요합니다. 예: --type=jobs --slugs=소방관,치과의사,대중무용수');
  }

  fs.mkdirSync(outputDir, { recursive: true });

  const ollamaOk = await checkOllama();
  if (!ollamaOk && !devVars.GEMINI_API_KEY) {
    throw new Error('Ollama와 Gemini 모두 사용할 수 없어 프롬프트를 생성할 수 없습니다.');
  }

  const results = [];
  for (const slug of slugs) {
    const systemPrompt = type === 'majors'
      ? getMajorPromptTemplate(slug, { useLora: loraOk })
      : getJobPromptTemplate(slug, { useLora: loraOk });

    let prompt = null;
    let source = null;

    if (ollamaOk) {
      try {
        prompt = await generatePromptOllama(systemPrompt);
        source = 'ollama';
      } catch {}
    }

    if (!prompt && devVars.GEMINI_API_KEY) {
      prompt = await generatePromptGemini(systemPrompt, devVars.GEMINI_API_KEY);
      source = 'gemini';
    }

    results.push({
      slug,
      type,
      prompt,
      source,
      lora: loraOk,
      analysis: analyzePrompt(type, prompt || ''),
      localImageCommand: `node scripts/local-image-gen.cjs --type=${type} --slug=${slug} --local-only`,
    });
  }

  const timestamp = new Date().toISOString().replace(/[:.]/g, '-');
  const jsonPath = path.join(outputDir, `prompt-review-${timestamp}.json`);
  const mdPath = path.join(outputDir, `prompt-review-${timestamp}.md`);
  fs.writeFileSync(jsonPath, JSON.stringify({ generatedAt: new Date().toISOString(), results }, null, 2), 'utf8');

  const lines = [];
  lines.push(`# Prompt Review`);
  lines.push('');
  lines.push(`- generatedAt: ${new Date().toISOString()}`);
  lines.push(`- type: ${type}`);
  lines.push(`- loraDetected: ${loraOk}`);
  lines.push('');

  for (const item of results) {
    lines.push(`## ${item.slug}`);
    lines.push('');
    lines.push(`- prompt source: ${item.source}`);
    lines.push(`- centered mention: ${item.analysis.mentionsCenter ? 'yes' : 'no'}`);
    lines.push(`- theme mention: ${item.analysis.themeOk ? 'yes' : 'no'}`);
    lines.push(`- concrete action/tool cue: ${item.analysis.hasConcreteToolCue ? 'yes' : 'no'}`);
    lines.push(`- rich environment cue: ${item.analysis.hasEnvironmentDensity ? 'yes' : 'no'}`);
    lines.push(`- abstract term risk: ${item.analysis.abstractTerms.length ? item.analysis.abstractTerms.join(', ') : 'none'}`);
    lines.push(`- local image test command: \`${item.localImageCommand}\``);
    lines.push('');
    lines.push('```text');
    lines.push(item.prompt || '');
    lines.push('```');
    lines.push('');
  }

  fs.writeFileSync(mdPath, lines.join('\n'), 'utf8');

  console.log(`프롬프트 리뷰 JSON: ${jsonPath}`);
  console.log(`프롬프트 리뷰 Markdown: ${mdPath}`);
}

main().catch(err => {
  console.error(err.message);
  process.exit(1);
});

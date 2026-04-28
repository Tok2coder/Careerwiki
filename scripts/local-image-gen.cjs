#!/usr/bin/env node
/**
 * ?棺??짆?쏆춾?????癲ル슣?? ??獄쏅똻?????? ???袁⑹뵫?繹??? *
 * ??ш끽維???ш낄援θキ? Ollama (gemma4:26b) ??????됰꽡 ??Gemini API
 * ????癲ル슣??:   ComfyUI (z-image-turbo) ??????됰꽡 ??Evolink API
 * ????겾??   wrangler r2 + DB ????녿ぅ??熬곣뫀肄? *
 * Usage:
 *   node scripts/local-image-gen.cjs --type=jobs --slug=???⑤베??嶺뚮ㅎ?????怨뺣물?袁⑸즵獒?? *   node scripts/local-image-gen.cjs --type=majors --slug=????묊뵓???ㅼ뒧亦????㏓븕
 *   node scripts/local-image-gen.cjs --type=howto --slug=howto-?濡ろ뜑??댁쾸??ｋ읁????thumb --prompt="Isometric 3D..."
 *   node scripts/local-image-gen.cjs --type=jobs --slug=???⑤베??嶺뚮ㅎ?????怨뺣물?袁⑸즵獒??--prompt-only
 *   node scripts/local-image-gen.cjs --type=jobs --slug=???⑤베??嶺뚮ㅎ?????怨뺣물?袁⑸즵獒??--no-lora
 */

const fs = require('fs');
const path = require('path');
const { execSync, spawn } = require('child_process');
const { getJobPromptTemplate, getMajorPromptTemplate } = require('./prompt-templates.cjs');

// ?????? Config ????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
const OLLAMA_URL = process.env.OLLAMA_URL || 'http://localhost:11434';
const OLLAMA_MODEL = process.env.OLLAMA_MODEL || 'gemma4:26b';
const COMFYUI_URL = process.env.COMFYUI_URL || 'http://127.0.0.1:8000';
const COMFYUI_FALLBACK_URL = process.env.COMFYUI_FALLBACK_URL || 'http://127.0.0.1:8001';
const COMFYUI_APP = process.env.COMFYUI_APP || path.join(process.env.LOCALAPPDATA || '', 'Programs', 'ComfyUI', 'ComfyUI.exe');
const COMFYUI_ROOT = process.env.COMFYUI_ROOT || path.join(process.env.LOCALAPPDATA || '', 'Programs', 'ComfyUI', 'resources', 'ComfyUI');
const COMFYUI_PYTHON = process.env.COMFYUI_PYTHON || path.join(process.env.USERPROFILE || '', 'Documents', 'ComfyUI', '.venv', 'Scripts', 'python.exe');
const COMFYUI_MAIN = process.env.COMFYUI_MAIN || path.join(COMFYUI_ROOT, 'main.py');
const COMFYUI_BASE_DIR = process.env.COMFYUI_BASE_DIR || path.join(process.env.USERPROFILE || '', 'Documents', 'ComfyUI');
const COMFYUI_USER_DIR = process.env.COMFYUI_USER_DIR || path.join(COMFYUI_BASE_DIR, 'user');
const COMFYUI_START_MODE = process.env.COMFYUI_START_MODE || 'python-first';
const COMFYUI_CHECKPOINT = 'z_image_turbo_bf16.safetensors';
const COMFYUI_CLIP = 'qwen_3_4b.safetensors';
const COMFYUI_VAE = 'ae.safetensors';
const LORA_NAME = 'cwbeaver.safetensors';
const COMFYUI_MODELS_DIR = process.env.COMFYUI_MODELS
  || path.join(COMFYUI_BASE_DIR, 'models');
const LORA_DIR = path.join(COMFYUI_MODELS_DIR, 'loras');
const COMFYUI_WORKFLOW_PATH = process.env.COMFYUI_WORKFLOW_PATH
  || path.join(COMFYUI_USER_DIR, 'default', 'workflows', 'Careerwiki-ZIT-workflow .json');
const COMFYUI_HOST = (() => {
  try { return new URL(COMFYUI_URL).hostname || '127.0.0.1'; } catch { return '127.0.0.1'; }
})();
const COMFYUI_PORT = (() => {
  try { return Number(new URL(COMFYUI_URL).port || 80); } catch { return 8000; }
})();
const COMFYUI_START_TIMEOUT = 120000;

const PROD_URL = 'https://careerwiki.org';
const IMAGE_WIDTH = 1200;
const IMAGE_HEIGHT = 675;
const POLLING_INTERVAL = 5000;   // 5s
const MAX_POLL_ATTEMPTS = 60;    // 5min

const TMP_DIR = path.join(__dirname, '..', '.tmp-images');
const MANAGED_COMFYUI_FILE = path.join(__dirname, '..', '.tmp-managed-comfyui.json');
let managedComfyuiPid = null;
let keepManagedComfyui = false;
let cachedWorkflowSettings = null;

// ?????? Helpers ??????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
function log(tag, msg) { console.log(`[${tag}] ${msg}`); }
function warn(tag, msg) { console.warn(`[${tag}] ???レ탴??${msg}`); }
function err(tag, msg) { console.error(`[${tag}] ??${msg}`); }
function ok(tag, msg) { console.log(`[${tag}] ??${msg}`); }

function parseArgs() {
  const args = {};
  for (const arg of process.argv.slice(2)) {
    if (arg.startsWith('--')) {
      const [key, ...rest] = arg.slice(2).split('=');
      args[key] = rest.length ? rest.join('=') : true;
    }
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

function sleep(ms) { return new Promise(r => setTimeout(r, ms)); }

function emitResult(result) {
  if (process.env.CW_BRIDGE === '1') {
    console.log(`__CW_RESULT__${JSON.stringify(result)}`);
  }
  emitResult(result);
}

function resolveCliPath(inputPath, fallbackPath) {
  const raw = inputPath || fallbackPath;
  if (!raw) return null;
  return path.isAbsolute(raw) ? raw : path.resolve(path.join(__dirname, '..'), raw);
}

function generateFileKey(type, slug, ext = 'webp') {
  const prefix = type === 'majors' ? 'major' : 'job';
  const folder = type === 'majors' ? 'majors' : 'jobs';
  const safeSlug = slug.replace(/\//g, '_');
  return `${folder}/${prefix}-${safeSlug}.${ext}`;
}

function hasLoraFile() {
  return fs.existsSync(path.join(LORA_DIR, LORA_NAME));
}

function getComfyUICandidateUrls() {
  return [...new Set([COMFYUI_FALLBACK_URL, COMFYUI_URL].filter(Boolean))];
}

function getDefaultWorkflowSettings() {
  return {
    unet_name: COMFYUI_CHECKPOINT,
    weight_dtype: 'default',
    clip_name: COMFYUI_CLIP,
    clip_type: 'sd3',
    vae_name: COMFYUI_VAE,
    lora_name: LORA_NAME,
    strength_model: 0.95,
    strength_clip: 0.8,
    auraflow_shift: 3,
    width: IMAGE_WIDTH,
    height: IMAGE_HEIGHT,
    batch_size: 1,
    steps: 10,
    cfg: 1,
    sampler_name: 'euler_cfg_pp',
    scheduler: 'normal',
    denoise: 1,
    negative_prompt: 'text, labels, signage, numbers, logos, photorealistic humans, blurry, low quality, deformed, wink, laugh, smile',
  };
}

function loadWorkflowSettings() {
  if (cachedWorkflowSettings) return cachedWorkflowSettings;

  const defaults = getDefaultWorkflowSettings();
  if (!fs.existsSync(COMFYUI_WORKFLOW_PATH)) {
    cachedWorkflowSettings = defaults;
    return cachedWorkflowSettings;
  }

  try {
    const raw = fs.readFileSync(COMFYUI_WORKFLOW_PATH, 'utf8');
    const parsed = JSON.parse(raw);
    const graph = parsed?.definitions?.subgraphs?.[0] || parsed;
    const nodes = Array.isArray(graph?.nodes) ? graph.nodes : [];
    if (!nodes.length) {
      cachedWorkflowSettings = defaults;
      return cachedWorkflowSettings;
    }

    const findNode = (type, predicate = null) =>
      nodes.find(node => node?.type === type && (!predicate || predicate(node)));

    const unetNode = findNode('UNETLoader');
    const clipNode = findNode('CLIPLoader');
    const vaeNode = findNode('VAELoader');
    const loraNode = findNode('LoraLoader');
    const auraNode = findNode('ModelSamplingAuraFlow');
    const latentNode = findNode('EmptyLatentImage');
    const samplerNode = findNode('KSampler');
    const negativeNode = findNode('CLIPTextEncode', node =>
      typeof node?.widgets_values?.[0] === 'string'
      && node.widgets_values[0].toLowerCase().includes('text, labels')
    );

    cachedWorkflowSettings = {
      unet_name: unetNode?.widgets_values?.[0] || defaults.unet_name,
      weight_dtype: unetNode?.widgets_values?.[1] || defaults.weight_dtype,
      clip_name: clipNode?.widgets_values?.[0] || defaults.clip_name,
      clip_type: clipNode?.widgets_values?.[1] || defaults.clip_type,
      vae_name: vaeNode?.widgets_values?.[0] || defaults.vae_name,
      lora_name: loraNode?.widgets_values?.[0] || defaults.lora_name,
      strength_model: Number(loraNode?.widgets_values?.[1] ?? defaults.strength_model),
      strength_clip: Number(loraNode?.widgets_values?.[2] ?? defaults.strength_clip),
      auraflow_shift: Number(auraNode?.widgets_values?.[0] ?? defaults.auraflow_shift),
      width: Number(latentNode?.widgets_values?.[0] ?? defaults.width),
      height: Number(latentNode?.widgets_values?.[1] ?? defaults.height),
      batch_size: Number(latentNode?.widgets_values?.[2] ?? defaults.batch_size),
      steps: Number(samplerNode?.widgets_values?.[2] ?? defaults.steps),
      cfg: Number(samplerNode?.widgets_values?.[3] ?? defaults.cfg),
      sampler_name: samplerNode?.widgets_values?.[4] || defaults.sampler_name,
      scheduler: samplerNode?.widgets_values?.[5] || defaults.scheduler,
      denoise: Number(samplerNode?.widgets_values?.[6] ?? defaults.denoise),
      negative_prompt: negativeNode?.widgets_values?.[0]?.trim() || defaults.negative_prompt,
    };
    return cachedWorkflowSettings;
  } catch (e) {
    warn('COMFYUI', `???⑤슣????鸚???棺??짆?삠궘?????됰꽡, ??れ삀???筌????? ${e.message}`);
    cachedWorkflowSettings = defaults;
    return cachedWorkflowSettings;
  }
}

// ?????? Connectivity checks ????????????????????????????????????????????????????????????????????????????????????????????????????
async function checkOllama() {
  try {
    const res = await fetch(`${OLLAMA_URL}/api/tags`);
    if (!res.ok) return false;
    const data = await res.json();
    const found = data.models?.some(m => m.name === OLLAMA_MODEL || m.name.startsWith(OLLAMA_MODEL.split(':')[0]));
    return !!found;
  } catch { return false; }
}

async function checkComfyUI(url = COMFYUI_URL) {
  try {
    const res = await fetch(`${url}/system_stats`);
    return res.ok;
  } catch { return false; }
}

async function findAvailableComfyUIUrl() {
  for (const url of getComfyUICandidateUrls()) {
    if (await checkComfyUI(url)) return url;
  }
  return null;
}

function saveManagedComfyUIInfo(info) {
  fs.writeFileSync(MANAGED_COMFYUI_FILE, JSON.stringify(info, null, 2), 'utf8');
}

function clearManagedComfyUIInfo() {
  try { fs.unlinkSync(MANAGED_COMFYUI_FILE); } catch {}
}

async function waitForComfyUIReady(timeoutMs = COMFYUI_START_TIMEOUT) {
  const startedAt = Date.now();
  while (Date.now() - startedAt < timeoutMs) {
    if (await checkComfyUI(COMFYUI_URL)) return true;
    await sleep(2000);
  }
  return false;
}

function startComfyUI() {
  try {
    const tryStartPython = () => {
      if (!fs.existsSync(COMFYUI_PYTHON) || !fs.existsSync(COMFYUI_MAIN)) return null;
      fs.mkdirSync(COMFYUI_USER_DIR, { recursive: true });
      const logPath = path.join(COMFYUI_USER_DIR, `codex-comfyui-${COMFYUI_PORT}.log`);
      const logFd = fs.openSync(logPath, 'a');
      log('COMFYUI', `ComfyUI Python ???筌?????덈틖: ${COMFYUI_MAIN}`);
      const child = spawn(
        COMFYUI_PYTHON,
        [
          COMFYUI_MAIN,
          '--listen',
          COMFYUI_HOST,
          '--port',
          String(COMFYUI_PORT),
          '--base-directory',
          COMFYUI_BASE_DIR,
          '--user-directory',
          COMFYUI_USER_DIR,
        ],
        {
          cwd: COMFYUI_ROOT,
          detached: true,
          stdio: ['ignore', logFd, logFd],
          windowsHide: true,
          env: {
            ...process.env,
            HF_HUB_DISABLE_TELEMETRY: '1',
            DO_NOT_TRACK: '1',
          },
        }
      );
      child.unref();
      saveManagedComfyUIInfo({
        pid: child.pid,
        mode: 'python-main',
        startedAt: new Date().toISOString(),
        endpoint: COMFYUI_URL,
        logPath,
      });
      return { success: true, pid: child.pid, mode: 'python-main', logPath };
    };

    const tryStartDesktop = () => {
      if (!fs.existsSync(COMFYUI_APP)) return null;
      log('COMFYUI', `ComfyUI Desktop ???筌?????덈틖: ${COMFYUI_APP}`);
      const child = spawn(COMFYUI_APP, [], {
        cwd: path.dirname(COMFYUI_APP),
        detached: true,
        stdio: 'ignore',
        windowsHide: true,
      });
      child.unref();
      saveManagedComfyUIInfo({
        pid: child.pid,
        mode: 'desktop-app',
        startedAt: new Date().toISOString(),
        endpoint: COMFYUI_URL,
      });
      return { success: true, pid: child.pid, mode: 'desktop-app' };
    };

    const attempts = COMFYUI_START_MODE === 'desktop-first'
      ? [tryStartDesktop, tryStartPython]
      : [tryStartPython, tryStartDesktop];

    for (const attempt of attempts) {
      const result = attempt();
      if (result) return result;
    }

    return { success: false, error: 'ComfyUI ????덈틖 ????????獒?Python ??????용끏????嶺뚮ㅏ援앲キ??癲ル슓??젆???????⑤８?????덊렡.' };
  } catch (e) {
    return { success: false, error: e.message };
  }
}

async function ensureComfyUI(autoStart = true) {
  if (await checkComfyUI()) {
    return { ok: true, startedByScript: false };
  }
  if (!autoStart) {
    return { ok: false, startedByScript: false, error: 'ComfyUI??좊읈? ????덈틖 濚욌꼬?댄꺍????ш끽維筌????덊렡.' };
  }

  const started = startComfyUI();
  if (!started.success) {
    return { ok: false, startedByScript: false, error: started.error };
  }

  const ready = await waitForComfyUIReady();
  if (!ready) {
    return { ok: false, startedByScript: true, pid: started.pid, error: 'ComfyUI ???筌?????덈틖 ??120?????怨좊군 API??좊읈? 濚욌꼬裕뼘????逾녜뇡??? ????⒱봼??????' };
  }

  managedComfyuiPid = started.pid;
  return { ok: true, startedByScript: true, pid: started.pid, mode: started.mode };
}

function stopManagedComfyUI() {
  if (!managedComfyuiPid || keepManagedComfyui) return;
  try {
    process.kill(managedComfyuiPid);
    ok('COMFYUI', `???筌?????덈틖??ComfyUI ???ろ꼤嶺? PID ${managedComfyuiPid}`);
  } catch (e) {
    warn('COMFYUI', `ComfyUI ???筌????ろ꼤嶺?????됰꽡: ${e.message}`);
  } finally {
    managedComfyuiPid = null;
    clearManagedComfyUIInfo();
  }
}

process.on('exit', stopManagedComfyUI);
process.on('SIGINT', () => {
  stopManagedComfyUI();
  process.exit(130);
});
process.on('SIGTERM', () => {
  stopManagedComfyUI();
  process.exit(143);
});

async function printStatus(ollamaOk, comfyuiOk, loraOk, devVars) {
  console.log('\n==================================================');
  console.log('   CareerWiki Local Image Generator');
  console.log('==================================================');
  console.log('Ollama  (' + OLLAMA_MODEL + ')    ' + (ollamaOk ? 'ON' : 'OFF -> FAIL (Ollama-only)'));
  console.log('ComfyUI (z-image-turbo)   ' + (comfyuiOk ? 'ON' : 'OFF -> Evolink fallback'));
  console.log('LoRA    (cwbeaver)        ' + (loraOk ? 'Found' : 'Not found (optional)'));
  console.log('Evolink API key           ' + (devVars.EVOLINK_API_KEY ? 'Ready' : 'Missing'));
  console.log('==================================================\n');
}

// ?????? Phase 1: Prompt Generation ??????????????????????????????????????????????????????????????????????????????????????

async function generatePromptOllama(systemPrompt) {
  log('PROMPT', `Ollama (${OLLAMA_MODEL})????ш끽維???ш낄援θキ???獄쏅똻??濚?..`);
  try {
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
        think: false, // Gemma 4 thinking 癲ル슢?꾤땟????????濚밸Ŧ遊????content??癲ル슣???????쑩?젆?        options: { temperature: 0.7, top_p: 0.9, num_predict: 2048 },
      }),
    });
    if (!res.ok) throw new Error(`HTTP ${res.status}`);
    const data = await res.json();
    // Gemma 4: thinking 癲ル슢?꾤땟????쎾퐲?content??좊읈? ?????thinking?????쑩?젆?????????源낆쓱
    const rawContent = data.message?.content || '';
    const rawThinking = data.message?.thinking || '';
    const text = (rawContent || rawThinking).trim().replace(/^["']|["']$/g, '').trim();
    if (!text) throw new Error('?????쑩?젆?(content+thinking 癲ル슢?꾤땟?嶺?????룹젂???源낆쓱)');
    ok('PROMPT', `Ollama ??ш끽維???ш낄援θキ???獄쏅똻????ш끽維??(${text.length}??`);
    return { success: true, prompt: text, source: 'ollama' };
  } catch (e) {
    warn('PROMPT', `Ollama ????됰꽡: ${e.message}`);
    return { success: false, error: e.message };
  }
}

// Gemini 프롬프트 폴백 제거됨 (브리지·CLI 모두 Ollama 단일 경로).
// 이유: dev.vars의 GEMINI_API_KEY는 로컬 개발용이고 prod에선 별개라 디버깅 혼선이
// 잦았다. 클라우드 폴백이 필요하면 서버측 /api/admin/image/regenerate
// (autoImageService.ts) 경로가 담당한다.

//?????? Phase 2: Image Generation ????????????????????????????????????????????????????????????????????????????????????????

function buildComfyUIWorkflow(prompt, useLora) {
  // z-image-turbo??diffusion model???棺??짆?삠궘?(FLUX-style UNet ?袁⑸젻泳??
  const workflow = {
    '1': {
      inputs: { unet_name: COMFYUI_CHECKPOINT, weight_dtype: 'default' },
      class_type: 'UNETLoader',
      _meta: { title: 'Load Diffusion Model' },
    },
    '2': {
      inputs: { clip_name: COMFYUI_CLIP, type: 'sd3' },
      class_type: 'CLIPLoader',
      _meta: { title: 'Load CLIP' },
    },
    '3': {
      inputs: { vae_name: COMFYUI_VAE },
      class_type: 'VAELoader',
      _meta: { title: 'Load VAE' },
    },
  };

  let modelRef = ['1', 0]; // unet output
  let clipRef = ['2', 0];  // clip output
  let nextId = 4;

  // LoRA ?嶺뚮ㅎ?볠뤃?(?釉뚰???쨨?븐눊猿?)
  if (useLora) {
    workflow[String(nextId)] = {
      inputs: {
        lora_name: LORA_NAME,
        strength_model: 0.95,
        strength_clip: 0.8,
        model: modelRef,
        clip: clipRef,
      },
      class_type: 'LoraLoader',
      _meta: { title: 'Load LoRA (cwbeaver)' },
    };
    modelRef = [String(nextId), 0];
    clipRef = [String(nextId), 1];
    nextId++;
  }

  const samplingId = String(nextId++);
  workflow[samplingId] = {
    inputs: { model: modelRef, shift: 3 },
    class_type: 'ModelSamplingAuraFlow',
    _meta: { title: 'Model Sampling (AuraFlow)' },
  };
  modelRef = [samplingId, 0];

  // Positive prompt
  const positiveId = String(nextId++);
  workflow[positiveId] = {
    inputs: { text: prompt, clip: clipRef },
    class_type: 'CLIPTextEncode',
    _meta: { title: 'Positive Prompt' },
  };

  // Negative prompt
  const negativeId = String(nextId++);
  workflow[negativeId] = {
    inputs: { text: 'text, labels, signage, numbers, logos, photorealistic humans, blurry, low quality, deformed, wink, laugh, smile', clip: clipRef },
    class_type: 'CLIPTextEncode',
    _meta: { title: 'Negative Prompt' },
  };

  // Empty latent
  const latentId = String(nextId++);
  workflow[latentId] = {
    inputs: { width: IMAGE_WIDTH, height: IMAGE_HEIGHT, batch_size: 1 },
    class_type: 'EmptyLatentImage',
    _meta: { title: 'Empty Latent Image' },
  };

  // KSampler
  const samplerId = String(nextId++);
  workflow[samplerId] = {
    inputs: {
      seed: Math.floor(Math.random() * 2147483647),
      steps: 10,
      cfg: 1,
      sampler_name: 'euler_cfg_pp',
      scheduler: 'normal',
      denoise: 1,
      model: modelRef,
      positive: [positiveId, 0],
      negative: [negativeId, 0],
      latent_image: [latentId, 0],
    },
    class_type: 'KSampler',
    _meta: { title: 'KSampler' },
  };

  // VAE Decode
  const decodeId = String(nextId++);
  workflow[decodeId] = {
    inputs: { samples: [samplerId, 0], vae: ['3', 0] },
    class_type: 'VAEDecode',
    _meta: { title: 'VAE Decode' },
  };

  // Save Image
  const saveId = String(nextId++);
  workflow[saveId] = {
    inputs: { filename_prefix: 'careerwiki', images: [decodeId, 0] },
    class_type: 'SaveImage',
    _meta: { title: 'Save Image' },
  };

  return workflow;
}

async function generateImageComfyUI(prompt, useLora) {
  log('IMAGE', 'ComfyUI??????癲ル슣?? ??獄쏅똻??濚?..');
  try {
    const workflow = buildComfyUIWorkflow(prompt, useLora);
    const res = await fetch(`${COMFYUI_URL}/prompt`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ prompt: workflow }),
    });
    if (!res.ok) {
      const errText = await res.text();
      throw new Error(`HTTP ${res.status}: ${errText.slice(0, 200)}`);
    }
    const { prompt_id } = await res.json();
    log('IMAGE', `ComfyUI ??筌?痢????筌믨퉭?? ${prompt_id}`);

    // ComfyUI history polling
    for (let i = 0; i < MAX_POLL_ATTEMPTS; i++) {
      await sleep(POLLING_INTERVAL);
      try {
        const histRes = await fetch(`${COMFYUI_URL}/history/${prompt_id}`);
        if (!histRes.ok) continue;
        const history = await histRes.json();
        const entry = history[prompt_id];
        if (!entry) continue;

        if (entry.status?.status_str === 'error') {
          throw new Error('ComfyUI ??獄쏅똻??????? ' + JSON.stringify(entry.status?.messages || ''));
        }

        if (entry.status?.completed || entry.status?.status_str === 'success') {
          // ????癲ル슣?? ????앗낆땡???⑤베毓??          const outputs = entry.outputs || {};
          let filename = null;
          let subfolder = '';
          for (const nodeId of Object.keys(outputs)) {
            const images = outputs[nodeId]?.images;
            if (images && images.length > 0) {
              filename = images[0].filename;
              subfolder = images[0].subfolder || '';
              break;
            }
          }
          if (!filename) throw new Error('[NO_FILE] ComfyUI output image filename not found');

          // ????癲ル슣?? ???源낅??棺??짆?삠궘?          const imgUrl = `${COMFYUI_URL}/view?filename=${encodeURIComponent(filename)}&subfolder=${encodeURIComponent(subfolder)}&type=output`;
          const imgRes = await fetch(imgUrl);
          if (!imgRes.ok) throw new Error(`????癲ル슣?? ???源낅??棺??짆?삠궘?????됰꽡: HTTP ${imgRes.status}`);
          const imgBuf = Buffer.from(await imgRes.arrayBuffer());

          ok('IMAGE', `ComfyUI ????癲ル슣?? ??獄쏅똻????ш끽維??(${(imgBuf.length / 1024).toFixed(0)}KB)`);
          return { success: true, buffer: imgBuf, source: 'comfyui', filename };
        }
      } catch (pollErr) {
        if (pollErr.message.startsWith('ComfyUI ') || pollErr.message.includes('[NO_FILE]')) throw pollErr;
        // transient poll error — retry in next iteration
      }
      if (i % 6 === 5) log('IMAGE', `????濚?.. (${(i + 1) * 5}??`);
    }
    throw new Error('????癲ル슣?? ??獄쏅똻??????ш끽維???(5??');
  } catch (e) {
    warn('IMAGE', `ComfyUI ????됰꽡: ${e.message}`);
    return { success: false, error: e.message };
  }
}

// Override the earlier hardcoded workflow builder with settings loaded from the saved ComfyUI workflow.
function buildComfyUIWorkflow(prompt, useLora) {
  const settings = loadWorkflowSettings();
  const workflow = {
    '1': {
      inputs: { unet_name: settings.unet_name, weight_dtype: settings.weight_dtype },
      class_type: 'UNETLoader',
      _meta: { title: 'Load Diffusion Model' },
    },
    '2': {
      inputs: { clip_name: settings.clip_name, type: settings.clip_type },
      class_type: 'CLIPLoader',
      _meta: { title: 'Load CLIP' },
    },
    '3': {
      inputs: { vae_name: settings.vae_name },
      class_type: 'VAELoader',
      _meta: { title: 'Load VAE' },
    },
  };

  let modelRef = ['1', 0];
  let clipRef = ['2', 0];
  let nextId = 4;

  if (useLora) {
    workflow[String(nextId)] = {
      inputs: {
        lora_name: settings.lora_name,
        strength_model: settings.strength_model,
        strength_clip: settings.strength_clip,
        model: modelRef,
        clip: clipRef,
      },
      class_type: 'LoraLoader',
      _meta: { title: 'Load LoRA (cwbeaver)' },
    };
    modelRef = [String(nextId), 0];
    clipRef = [String(nextId), 1];
    nextId++;
  }

  const samplingId = String(nextId++);
  workflow[samplingId] = {
    inputs: { model: modelRef, shift: settings.auraflow_shift },
    class_type: 'ModelSamplingAuraFlow',
    _meta: { title: 'Model Sampling (AuraFlow)' },
  };
  modelRef = [samplingId, 0];

  const positiveId = String(nextId++);
  workflow[positiveId] = {
    inputs: { text: prompt, clip: clipRef },
    class_type: 'CLIPTextEncode',
    _meta: { title: 'Positive Prompt' },
  };

  const negativeId = String(nextId++);
  workflow[negativeId] = {
    inputs: { text: settings.negative_prompt, clip: clipRef },
    class_type: 'CLIPTextEncode',
    _meta: { title: 'Negative Prompt' },
  };

  const latentId = String(nextId++);
  workflow[latentId] = {
    inputs: { width: settings.width, height: settings.height, batch_size: settings.batch_size },
    class_type: 'EmptyLatentImage',
    _meta: { title: 'Empty Latent Image' },
  };

  const samplerId = String(nextId++);
  workflow[samplerId] = {
    inputs: {
      seed: Math.floor(Math.random() * 2147483647),
      steps: settings.steps,
      cfg: settings.cfg,
      sampler_name: settings.sampler_name,
      scheduler: settings.scheduler,
      denoise: settings.denoise,
      model: modelRef,
      positive: [positiveId, 0],
      negative: [negativeId, 0],
      latent_image: [latentId, 0],
    },
    class_type: 'KSampler',
    _meta: { title: 'KSampler' },
  };

  const decodeId = String(nextId++);
  workflow[decodeId] = {
    inputs: { samples: [samplerId, 0], vae: ['3', 0] },
    class_type: 'VAEDecode',
    _meta: { title: 'VAE Decode' },
  };

  const saveId = String(nextId++);
  workflow[saveId] = {
    inputs: { filename_prefix: 'careerwiki', images: [decodeId, 0] },
    class_type: 'SaveImage',
    _meta: { title: 'Save Image' },
  };

  return workflow;
}

async function generateImageComfyUIWithRetry(prompt, useLora) {
  log('IMAGE', 'ComfyUI??????癲ル슣?? ??獄쏅똻??濚?..');
  let lastError = null;

  for (const comfyUrl of getComfyUICandidateUrls()) {
    try {
      if (!(await checkComfyUI(comfyUrl))) continue;

      const workflow = buildComfyUIWorkflow(prompt, useLora);
      const res = await fetch(`${comfyUrl}/prompt`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ prompt: workflow }),
      });
      if (!res.ok) {
        const errText = await res.text();
        throw new Error(`HTTP ${res.status}: ${errText.slice(0, 200)}`);
      }

      const { prompt_id } = await res.json();
      log('IMAGE', `ComfyUI ??筌?痢????筌믨퉭??(${comfyUrl}): ${prompt_id}`);

      for (let i = 0; i < MAX_POLL_ATTEMPTS; i++) {
        await sleep(POLLING_INTERVAL);
        try {
          const histRes = await fetch(`${comfyUrl}/history/${prompt_id}`);
          if (!histRes.ok) continue;
          const history = await histRes.json();
          const entry = history[prompt_id];
          if (!entry) continue;

          if (entry.status?.status_str === 'error') {
            throw new Error('ComfyUI ??獄쏅똻??????? ' + JSON.stringify(entry.status?.messages || ''));
          }

          if (entry.status?.completed || entry.status?.status_str === 'success') {
            const outputs = entry.outputs || {};
            let filename = null;
            let subfolder = '';
            for (const nodeId of Object.keys(outputs)) {
              const images = outputs[nodeId]?.images;
              if (images && images.length > 0) {
                filename = images[0].filename;
                subfolder = images[0].subfolder || '';
                break;
              }
            }
            if (!filename) throw new Error('[NO_FILE] ComfyUI output image filename not found');

            const imgUrl = `${comfyUrl}/view?filename=${encodeURIComponent(filename)}&subfolder=${encodeURIComponent(subfolder)}&type=output`;
            const imgRes = await fetch(imgUrl);
            if (!imgRes.ok) throw new Error(`????癲ル슣?? ???源낅??棺??짆?삠궘?????됰꽡: HTTP ${imgRes.status}`);
            const imgBuf = Buffer.from(await imgRes.arrayBuffer());

            ok('IMAGE', `ComfyUI ????癲ル슣?? ??獄쏅똻????ш끽維??(${(imgBuf.length / 1024).toFixed(0)}KB)`);
            return { success: true, buffer: imgBuf, source: 'comfyui', filename, endpoint: comfyUrl };
          }
        } catch (pollErr) {
          if (pollErr.message.startsWith('ComfyUI ') || pollErr.message.includes('[NO_FILE]')) throw pollErr;
        }
        if (i % 6 === 5) log('IMAGE', `????濚?. (${(i + 1) * 5}?? ${comfyUrl})`);
      }

      throw new Error(`ComfyUI ????ш끽維???(${(MAX_POLL_ATTEMPTS * POLLING_INTERVAL) / 1000}??`);
    } catch (e) {
      lastError = e;
      warn('IMAGE', `ComfyUI ????됰꽡 (${comfyUrl}): ${e.message}`);
    }
  }

  return { success: false, error: lastError?.message || 'ComfyUI failed on all endpoints' };
}

async function generateImageEvolink(prompt, apiKey) {
  log('FALLBACK', 'ComfyUI failed, using Evolink API');
  try {
    const genRes = await fetch('https://api.evolink.ai/v1/images/generations', {
      method: 'POST',
      headers: { Authorization: `Bearer ${apiKey}`, 'Content-Type': 'application/json' },
      body: JSON.stringify({
        model: 'z-image-turbo',
        prompt,
        size: '16:9',
        seed: Math.floor(Math.random() * 2147483647),
        nsfw_check: false,
      }),
    });
    if (!genRes.ok) throw new Error(`HTTP ${genRes.status}`);
    const genData = await genRes.json();
    const taskId = genData.id;
    if (!taskId) throw new Error('Missing taskId');
    log('FALLBACK', `Evolink task: ${taskId}`);

    for (let i = 0; i < 30; i++) {
      await sleep(2000);
      const statusRes = await fetch(`https://api.evolink.ai/v1/tasks/${taskId}`, {
        headers: { Authorization: `Bearer ${apiKey}` },
      });
      if (!statusRes.ok) continue;
      const statusData = await statusRes.json();

      if (statusData.status === 'completed') {
        const imgUrl = statusData.results?.[0] || statusData.data?.url || statusData.data?.urls?.[0];
        if (!imgUrl) throw new Error('Missing image URL');
        const imgRes = await fetch(imgUrl);
        if (!imgRes.ok) throw new Error(`Download failed: HTTP ${imgRes.status}`);
        const imgBuf = Buffer.from(await imgRes.arrayBuffer());
        ok('FALLBACK', `Evolink image generation done (${(imgBuf.length / 1024).toFixed(0)}KB)`);
        return { success: true, buffer: imgBuf, source: 'evolink' };
      }
      if (statusData.status === 'failed') {
        throw new Error(statusData.error?.message || 'Generation failed');
      }
    }

    throw new Error('Evolink timed out (60s)');
  } catch (e) {
    err('FALLBACK', `Evolink failed: ${e.message}`);
    return { success: false, error: e.message };
  }
}

// ?????? Phase 3: Upload & DB ??????????????????????????????????????????????????????????????????????????????????????????????????

function uploadToR2(localPath, fileKey) {
  log('UPLOAD', `R2 ????겾?? ${fileKey}`);
  try {
    execSync(
      `npx wrangler r2 object put "careerwiki-uploads/${fileKey}" --file="${localPath}" --content-type="image/webp"`,
      { cwd: path.join(__dirname, '..'), stdio: 'pipe', encoding: 'utf8' }
    );
    ok('UPLOAD', 'R2 upload complete');
    return true;
  } catch (e) {
    err('UPLOAD', `R2 ????겾??????됰꽡: ${e.message}`);
    return false;
  }
}

async function updateDB(type, slug, imageUrl, imagePrompt, generationMeta) {
  log('DB', `DB update: ${type}/${slug}`);
  try {
    const table = type === 'majors' ? 'majors' : 'jobs';
    const timestamp = Date.now();
    const fullImageUrl = `${imageUrl}?v=${timestamp}`;
    const metaJson = JSON.stringify(generationMeta || {}).replace(/'/g, "''");
    const updateQuery = `UPDATE ${table} SET image_url = '${fullImageUrl.replace(/'/g, "''")}', image_prompt = '${(imagePrompt || '').replace(/'/g, "''")}', merged_profile_json = json_set(COALESCE(merged_profile_json, '{}'), '$.image_url', '${fullImageUrl.replace(/'/g, "''")}', '$.image_generation_meta', json('${metaJson}')) WHERE slug = '${slug.replace(/'/g, "''")}'`;
    execSync(
      `npx wrangler d1 execute careerwiki-kr --remote --command "${updateQuery.replace(/"/g, '\\"')}"`,
      { cwd: path.join(__dirname, '..'), stdio: 'pipe', encoding: 'utf8' }
    );
    ok('DB', `DB update done: ${fullImageUrl}`);
    return { success: true, imageUrl: fullImageUrl };
  } catch (e) {
    err('DB', `DB update failed: ${e.message}`);
    return { success: false, error: e.message };
  }
}

// ?????? Quality Checks ??????????????????????????????????????????????????????????????????????????????????????????????????????????????

function validateImage(buffer) {
  const checks = [];

  // ?????濡ろ떟?癲?(癲ル슔?됭짆??50KB)
  if (buffer.length < 50 * 1024) {
    checks.push(`????癲ル슣?? ????????????甕? ${(buffer.length / 1024).toFixed(0)}KB (癲ル슔?됭짆??50KB)`);
  }

  // PNG ??癰궽쇱읇???源딅굇 ?嶺뚮Ĳ?됮?
    const isPNG = buffer[0] === 0x89 && buffer[1] === 0x50;
  const isJPEG = buffer[0] === 0xFF && buffer[1] === 0xD8;
  const isWEBP = buffer.slice(0, 4).toString() === 'RIFF' && buffer.slice(8, 12).toString() === 'WEBP';

  if (!isPNG && !isJPEG && !isWEBP) {
    checks.push('???レ챺???????癲ル슣?? ?嶺뚮Ĳ?뉛쭛????ш끽維筌????덊렡 (PNG/JPEG/WEBP ??ш끽維筌?');
  }

  return checks;
}

async function verifyR2Upload(fileKey) {
  try {
    // ??? slug??좊읈? ?????URL?? ?嶺뚮ㅎ?듸쭕????ш끽維??    const encodedKey = fileKey.split('/').map(part => encodeURIComponent(part)).join('/');
    const res = await fetch(`${PROD_URL}/uploads/${encodedKey}`, { method: 'HEAD' });
    if (res.ok) {
      ok('VERIFY', `R2 ????癲ル슣?? ???쒋닪????좊읈??? /uploads/${fileKey}`);
      return true;
    }
    warn('VERIFY', `R2 ????癲ル슣?? ???쒋닪????됰씭??: HTTP ${res.status} (CDN ??ш낄援??濚욌꼬?댄꺍???????源낆쓱)`);
    return false;
  } catch (e) {
    warn('VERIFY', `R2 ?濡ろ떟?癲?????됰꽡: ${e.message}`);
    return false;
  }
}

// ?????? Main ??????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????

async function main() {
  const args = parseArgs();
  const type = args.type;       // jobs, majors, howto
  const slug = args.slug;
  const customPrompt = args.prompt && args.prompt !== true ? args.prompt : null;
  const promptOnly = !!args['prompt-only'];
  const noLora = !!args['no-lora'];
  const localOnly = !!args['local-only'];
  const keepComfyui = !!args['keep-comfyui'];
  const autoComfyui = !args['no-auto-comfyui'];
  const outputDir = resolveCliPath(args['output-dir'], path.join('.generated-images', type === 'howto' ? 'jobs' : type || 'jobs'));

  keepManagedComfyui = keepComfyui;

  if (!type || !slug) {
    console.error('Usage: node scripts/local-image-gen.cjs --type=jobs|majors|howto --slug=SLUG [--prompt="..."] [--prompt-only] [--local-only] [--output-dir=.generated-images] [--no-lora] [--keep-comfyui] [--no-auto-comfyui]');
    process.exit(1);
  }

  const effectiveType = type === 'howto' ? 'jobs' : type; // howto??jobs ??????????
  if (!['jobs', 'majors'].includes(effectiveType)) {
    err('MAIN', `??嚥?援??type: ${type}. jobs, majors, howto 濚????ャ뀕???筌뚯뼚???`);
    process.exit(1);
  }

  const devVars = loadDevVars();
  const ollamaOk = await checkOllama();
  let comfyuiOk = !!(await findAvailableComfyUIUrl());
  let comfyuiState = { startedByScript: false };
  if (!promptOnly && !comfyuiOk && autoComfyui) {
    comfyuiState = await ensureComfyUI(true);
    comfyuiOk = comfyuiState.ok;
    if (comfyuiState.startedByScript && comfyuiOk) {
      ok('COMFYUI', 'ComfyUI API auto-started');
    } else if (comfyuiState.error) {
      warn('COMFYUI', comfyuiState.error);
    }
  }
  const loraOk = !noLora && hasLoraFile();

  await printStatus(ollamaOk, comfyuiOk, loraOk, devVars);
  // 가드: Ollama가 죽었고 customPrompt도 없으면 진행 불가 (Gemini 폴백 제거됨)
  if (!ollamaOk && !customPrompt) {
    err('MAIN', 'Ollama 미동작 — 프롬프트 생성 불가. Ollama를 띄우거나 --prompt 인자를 넘기세요.');
    process.exit(1);
  }
  if (!comfyuiOk && !devVars.EVOLINK_API_KEY && !promptOnly) {
    err('MAIN', 'ComfyUI ??⑥ル땾鶯?+ Evolink API ?????⑤챶苡? ????癲ル슣?? ??獄쏅똻????됰씭??.');
    process.exit(1);
  }

  const result = {
    success: false,
    imageUrl: null,
    imagePrompt: null,
    source: { prompt: null, image: null },
    lora: loraOk,
    localPath: null,
    runtime: {
      comfyuiAutoStarted: !!comfyuiState.startedByScript,
      comfyuiKeptRunning: keepComfyui,
    },
  };

  // ???? Phase 1: Prompt ????
  let imagePrompt = customPrompt;

  if (!imagePrompt) {
    // 癲ル슣???罹??덉떻???ш낄猷쀦쾮?㏃땡筌뚯슙???slug???????⑤베?繞?(??癰궽살쐿??slug ??숆강筌???????
    const itemName = slug;
    const systemPrompt = effectiveType === 'majors'
      ? getMajorPromptTemplate(itemName, { useLora: loraOk })
      : getJobPromptTemplate(itemName, { useLora: loraOk });

    // 1癲? Ollama
    if (ollamaOk) {
      const ollamaResult = await generatePromptOllama(systemPrompt);
      if (ollamaResult.success) {
        imagePrompt = ollamaResult.prompt;
        result.source.prompt = 'ollama';
      }
    }
    if (!imagePrompt) {
      err('MAIN', '프롬프트 생성 실패 (Ollama 응답 비어있음 또는 미동작)');
      process.exit(1);
    }
  } else {
    result.source.prompt = 'custom';
    log('PROMPT', `??節뗪콬??? ??ш끽維???ш낄援θキ?????(${imagePrompt.length}??`);
  }

  result.imagePrompt = imagePrompt;
  console.log(`\n?????ш끽維???ш낄援θキ?(${imagePrompt.length}??:\n${imagePrompt.slice(0, 300)}${imagePrompt.length > 300 ? '...' : ''}\n`);

  if (promptOnly) {
    result.success = true;
    emitResult(result);
    process.exit(0);
  }

  // ???? Phase 2: Image Generation ????
  let imgBuffer = null;

  // 1癲? ComfyUI
  if (comfyuiOk) {
    const comfyResult = await generateImageComfyUIWithRetry(imagePrompt, loraOk);
    if (comfyResult.success) {
      imgBuffer = comfyResult.buffer;
      result.source.image = 'comfyui';
    }
  }

  // 2癲? Evolink fallback
  if (!imgBuffer && devVars.EVOLINK_API_KEY) {
    const evolinkResult = await generateImageEvolink(imagePrompt, devVars.EVOLINK_API_KEY);
    if (evolinkResult.success) {
      imgBuffer = evolinkResult.buffer;
      result.source.image = 'evolink';
    }
  }

  if (!imgBuffer) {
    err('MAIN', '????癲ル슣?? ??獄쏅똻??????됰꽡 (ComfyUI + Evolink 癲ル슢?꾤땟?嶺?????됰꽡)');
    result.success = false;
    emitResult(result);
    process.exit(1);
  }

  // ???? Quality Check ????
  const issues = validateImage(imgBuffer);
  if (issues.length > 0) {
    warn('QUALITY', '????癲ル슣?? ???源녿뼥 ?濡ろ뜑???');
    issues.forEach(i => warn('QUALITY', `  - ${i}`));
  }

  // ???? Phase 3: Save & Upload ????
  // ?嶺뚮Ĳ?????濡ろ뜏???
    const isPNG = imgBuffer[0] === 0x89 && imgBuffer[1] === 0x50;
  const ext = isPNG ? 'png' : 'webp';
  const fileKey = generateFileKey(effectiveType, slug, ext);
  const safeBaseName = `${effectiveType}-${slug.replace(/[/\\]/g, '_')}.${ext}`;

  if (localOnly) {
    fs.mkdirSync(outputDir, { recursive: true });
    const localPath = path.join(outputDir, safeBaseName);
    fs.writeFileSync(localPath, imgBuffer);
    result.success = true;
    result.localPath = localPath;
    log('SAVE', 'Local test image saved: ' + localPath + ' (' + (imgBuffer.length/1024).toFixed(0) + 'KB)');
    console.log('\\n' + '='.repeat(50));
    ok('DONE', 'Image generation completed');
    emitResult(result);
    process.exit(0);
  }

  if (!fs.existsSync(TMP_DIR)) fs.mkdirSync(TMP_DIR, { recursive: true });
  const tmpPath = path.join(TMP_DIR, safeBaseName);

  fs.writeFileSync(tmpPath, imgBuffer);
  log('SAVE', `?棺??짆?쏆춾????? ${tmpPath} (${(imgBuffer.length / 1024).toFixed(0)}KB)`);

  // R2 ????겾??
    const uploaded = uploadToR2(tmpPath, fileKey);
  if (!uploaded) {
    warn('MAIN', `R2 ????겾??????됰꽡. ?棺??짆?쏆춾?????癲ル슣?????怨뚮옖??? ${tmpPath}`);
    result.success = false;
    emitResult(result);
    process.exit(1);
  }

  // R2 ???쒋닪???濡ろ떟?癲?  await sleep(2000); // CDN ??ш낄援??????  await verifyR2Upload(fileKey);

  // DB ????녿ぅ??熬곣뫀肄?(howto??DB ????녿ぅ??熬곣뫀肄????袁⑤툞)
  const imageUrl = `/uploads/${fileKey}`;
  if (type !== 'howto') {
    const dbResult = await updateDB(effectiveType, slug, imageUrl, imagePrompt, {
      generatedAt: new Date().toISOString(),
      generatedBy: 'local-image-gen',
      promptSource: result.source.prompt,
      imageSource: result.source.image,
      loraApplied: result.lora,
      workflowPath: COMFYUI_WORKFLOW_PATH,
    });
    if (dbResult.success) {
      result.imageUrl = dbResult.imageUrl;
    } else {
      warn('MAIN', 'DB ????녿ぅ??熬곣뫀肄?????됰꽡. R2???獒?????겾??筌먲퐣?.');
      result.imageUrl = imageUrl;
    }
  } else {
    result.imageUrl = imageUrl;
    log('DB', 'HowTo ????癲ル슣?? ??DB ????녿ぅ??熬곣뫀肄????袁⑤툞 (??嚥▲꺃彛?????');
  }

  // ??ш끽維??  result.success = true;
  console.log('\\n' + '='.repeat(50));
  ok('DONE', 'Image generation completed');
  emitResult(result);

  // tmp ?嶺뚮㉡?섌걡?  try { fs.unlinkSync(tmpPath); } catch {}
  try { fs.rmdirSync(TMP_DIR); } catch {}

  process.exit(0);
}

main().catch(e => {
  err('FATAL', e.message);
  process.exit(1);
});


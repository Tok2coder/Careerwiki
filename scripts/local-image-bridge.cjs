#!/usr/bin/env node

const http = require('http');
const https = require('https');
const fs = require('fs');
const path = require('path');
const { spawn } = require('child_process');
const { getJobPromptTemplate, getMajorPromptTemplate } = require('./prompt-templates.cjs');

const HOST = process.env.CW_LOCAL_BRIDGE_HOST || '127.0.0.1';
const PORT = Number(process.env.CW_LOCAL_BRIDGE_PORT || 3210);
// HTTP 폴백 포트 — mkcert 인증서가 발급된 환경에서는 3210을 HTTPS로 쓰고
// 과도기 호환을 위해 3211에 HTTP도 열어둔다. 인증서 없으면 3210을 HTTP로 사용.
const HTTP_FALLBACK_PORT = Number(process.env.CW_LOCAL_BRIDGE_HTTP_PORT || 3211);
const CERT_DIR = path.join(__dirname, 'certs');
const CERT_KEY_PATH = path.join(CERT_DIR, 'bridge-key.pem');
const CERT_CRT_PATH = path.join(CERT_DIR, 'bridge-cert.pem');
const ROOT = path.join(__dirname, '..');
const PROD_URL = process.env.CW_LOCAL_BRIDGE_SITE || 'https://careerwiki.org';
const OLLAMA_URL = process.env.OLLAMA_URL || 'http://localhost:11434';
const OLLAMA_MODEL = process.env.OLLAMA_MODEL || 'gemma4:26b';
const COMFYUI_URLS = [
  process.env.COMFYUI_FALLBACK_URL || 'http://127.0.0.1:8001',
  process.env.COMFYUI_URL || 'http://127.0.0.1:8000',
].filter(Boolean);
const COMFYUI_PRIMARY_URL = COMFYUI_URLS[0];
const COMFYUI_BASE_DIR = process.env.COMFYUI_BASE_DIR || path.join(process.env.USERPROFILE || '', 'Documents', 'ComfyUI');
const COMFYUI_USER_DIR = process.env.COMFYUI_USER_DIR || path.join(COMFYUI_BASE_DIR, 'user');
const COMFYUI_APP_DIR = process.env.COMFYUI_APP_DIR || path.join(process.env.USERPROFILE || '', 'ComfyUI');
const COMFYUI_WORKFLOW_PATH = process.env.COMFYUI_WORKFLOW_PATH
  || path.join(COMFYUI_USER_DIR, 'default', 'workflows', 'Careerwiki-ZIT-workflow .json');
const COMFYUI_PYTHON = process.env.COMFYUI_PYTHON
  || path.join(COMFYUI_BASE_DIR, '.venv', 'Scripts', 'python.exe');
const COMFYUI_MAIN = process.env.COMFYUI_MAIN || path.join(COMFYUI_APP_DIR, 'main.py');
const LORA_DIR = path.join(COMFYUI_BASE_DIR, 'models', 'loras');
const LORA_NAME = 'cwbeaver.safetensors';
const OLLAMA_EXE = process.env.OLLAMA_EXE
  || path.join(process.env.LOCALAPPDATA || '', 'Programs', 'Ollama', 'ollama.exe');
const OLLAMA_APP_EXE = process.env.OLLAMA_APP_EXE
  || path.join(process.env.LOCALAPPDATA || '', 'Programs', 'Ollama', 'ollama app.exe');
const ALLOWED_ORIGINS = new Set([
  'https://careerwiki.org',
  'http://localhost:8788',
  'http://127.0.0.1:8788',
]);
const POLL_MS = 5000;
const MAX_POLLS = 60;
const SERVICE_BOOT_TIMEOUT_MS = 180000;

// ComfyUI 온디맨드 기동 + 유휴 자동 종료 설정
const COMFY_IDLE_TIMEOUT_MS = (Number(process.env.CW_COMFY_IDLE_MINUTES) || 15) * 60 * 1000;
const COMFY_IDLE_CHECK_MS = 60 * 1000; // 1분마다 유휴 체크
const COMFY_STARTUP_MAX_MS = 3 * 60 * 1000; // 3분

let ollamaBootPromise = null;
let comfyBootPromise = null;
// 마지막으로 ComfyUI를 "사용한" 시각 (generateComfyImage 진입 시 갱신)
let comfyuiLastUsed = 0;
// 우리 브리지가 직접 spawn한 ComfyUI 자식 프로세스 PID 집합
const comfyuiSpawnedPids = new Set();

function sendJson(res, status, body, origin = '') {
  res.writeHead(status, {
    'Content-Type': 'application/json; charset=utf-8',
    'Access-Control-Allow-Origin': ALLOWED_ORIGINS.has(origin) ? origin : 'https://careerwiki.org',
    'Access-Control-Allow-Methods': 'GET,POST,OPTIONS',
    'Access-Control-Allow-Headers': 'Content-Type',
    // Chrome LNA: 'private' (RFC1918) / 'local' (link-local) / 'loopback' (127.0.0.1)
    // 스펙 진화 과정에서 127.0.0.1이 private → local → loopback 으로 재분류됨.
    // 세 값을 모두 allow 해 두면 어떤 Chrome 버전이든 preflight 통과한다.
    'Access-Control-Allow-Private-Network': 'true',
    'Access-Control-Allow-Local-Network': 'true',
    'Access-Control-Max-Age': '86400',
    'Vary': 'Origin',
  });
  res.end(JSON.stringify(body));
}

function parseBody(req) {
  return new Promise((resolve, reject) => {
    let data = '';
    req.on('data', chunk => {
      data += chunk;
      if (data.length > 1024 * 1024) {
        reject(new Error('payload too large'));
        req.destroy();
      }
    });
    req.on('end', () => {
      try {
        resolve(data ? JSON.parse(data) : {});
      } catch (error) {
        reject(error);
      }
    });
    req.on('error', reject);
  });
}

function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

async function fetchOk(url) {
  try {
    const res = await fetch(url);
    return res.ok;
  } catch {
    return false;
  }
}

async function waitForService(checkFn, timeoutMs, label) {
  const start = Date.now();
  while (Date.now() - start < timeoutMs) {
    if (await checkFn()) return true;
    await sleep(2000);
  }
  throw new Error(`${label} did not become ready in time`);
}

function spawnDetached(command, args, options = {}) {
  const child = spawn(command, args, {
    detached: true,
    stdio: 'ignore',
    windowsHide: true,
    ...options,
  });
  child.unref();
  return child;
}

async function ensureOllamaRunning() {
  if (await fetchOk(`${OLLAMA_URL}/api/tags`)) return true;
  if (ollamaBootPromise) return ollamaBootPromise;

  ollamaBootPromise = (async () => {
    if (fs.existsSync(OLLAMA_EXE)) {
      spawnDetached(OLLAMA_EXE, ['serve']);
    } else if (fs.existsSync(OLLAMA_APP_EXE)) {
      spawnDetached(OLLAMA_APP_EXE, []);
    } else {
      throw new Error(`Ollama executable not found. Checked ${OLLAMA_EXE}`);
    }

    await waitForService(
      () => fetchOk(`${OLLAMA_URL}/api/tags`),
      SERVICE_BOOT_TIMEOUT_MS,
      'Ollama'
    );
    return true;
  })();

  try {
    return await ollamaBootPromise;
  } finally {
    ollamaBootPromise = null;
  }
}

async function ensureComfyUiRunning() {
  for (const comfyUrl of COMFYUI_URLS) {
    if (await fetchOk(`${comfyUrl}/system_stats`)) return comfyUrl;
  }
  if (comfyBootPromise) return comfyBootPromise;

  comfyBootPromise = (async () => {
    if (!fs.existsSync(COMFYUI_PYTHON)) {
      throw new Error(`ComfyUI Python not found: ${COMFYUI_PYTHON}`);
    }
    if (!fs.existsSync(COMFYUI_MAIN)) {
      throw new Error(`ComfyUI main.py not found: ${COMFYUI_MAIN}`);
    }

    const primary = new URL(COMFYUI_PRIMARY_URL);
    const port = primary.port || '8001';
    const host = primary.hostname || '127.0.0.1';

    console.log(`[CW-BRIDGE] ComfyUI on-demand start at ${COMFYUI_PRIMARY_URL} (idle timeout ${Math.round(COMFY_IDLE_TIMEOUT_MS / 60000)}m)`);
    const child = spawnDetached(
      COMFYUI_PYTHON,
      [
        COMFYUI_MAIN,
        '--listen',
        host,
        '--port',
        port,
        '--base-directory',
        COMFYUI_BASE_DIR,
        '--user-directory',
        COMFYUI_USER_DIR,
        '--disable-auto-launch',
        '--log-stdout',
      ],
      { cwd: COMFYUI_APP_DIR }
    );
    if (child && child.pid) {
      comfyuiSpawnedPids.add(child.pid);
      child.on('exit', () => comfyuiSpawnedPids.delete(child.pid));
    }

    await waitForService(
      () => fetchOk(`${COMFYUI_PRIMARY_URL}/system_stats`),
      COMFY_STARTUP_MAX_MS,
      'ComfyUI'
    );
    console.log(`[CW-BRIDGE] ComfyUI ready`);
    return COMFYUI_PRIMARY_URL;
  })();

  try {
    return await comfyBootPromise;
  } finally {
    comfyBootPromise = null;
  }
}

// Windows taskkill로 ComfyUI 프로세스 강제 종료
function killComfyProcesses() {
  if (comfyuiSpawnedPids.size === 0) return;
  for (const pid of comfyuiSpawnedPids) {
    try {
      // /T = 자식 프로세스까지 / /F = 강제
      spawn('taskkill', ['/PID', String(pid), '/T', '/F'], {
        stdio: 'ignore',
        windowsHide: true,
      });
      console.log(`[CW-BRIDGE] ComfyUI idle shutdown: taskkill PID ${pid}`);
    } catch (err) {
      console.error(`[CW-BRIDGE] taskkill failed for PID ${pid}:`, err?.message);
    }
  }
  comfyuiSpawnedPids.clear();
}

// 1분마다 유휴 체크 — 기동 중이 아니고, 인스턴스가 살아있고,
// 마지막 사용 이후 COMFY_IDLE_TIMEOUT_MS가 지났으면 종료
setInterval(async () => {
  if (comfyBootPromise) return; // 기동 중에는 스킵
  if (comfyuiLastUsed === 0) return; // 한 번도 사용 안 함
  const idleMs = Date.now() - comfyuiLastUsed;
  if (idleMs < COMFY_IDLE_TIMEOUT_MS) return;
  // 현재 ready인 인스턴스가 있는지 확인 (없으면 이미 죽은 상태 → 스킵)
  let anyReady = false;
  for (const url of COMFYUI_URLS) {
    if (await fetchOk(`${url}/system_stats`)) { anyReady = true; break; }
  }
  if (!anyReady) return;
  console.log(`[CW-BRIDGE] ComfyUI idle ${Math.round(idleMs / 60000)}m > ${Math.round(COMFY_IDLE_TIMEOUT_MS / 60000)}m — shutting down`);
  killComfyProcesses();
  comfyuiLastUsed = 0;
}, COMFY_IDLE_CHECK_MS).unref();

function loadDevVars() {
  const vars = {};
  const devVarsPath = path.join(ROOT, 'dev.vars');
  if (!fs.existsSync(devVarsPath)) return vars;
  for (const line of fs.readFileSync(devVarsPath, 'utf8').split(/\r?\n/)) {
    const trimmed = line.trim();
    if (!trimmed || trimmed.startsWith('#')) continue;
    const idx = trimmed.indexOf('=');
    if (idx > 0) vars[trimmed.slice(0, idx).trim()] = trimmed.slice(idx + 1).trim();
  }
  return vars;
}

function hasLoraFile() {
  return fs.existsSync(path.join(LORA_DIR, LORA_NAME));
}

function generateFileKey(type, slug, ext = 'webp') {
  const folder = type === 'majors' ? 'majors' : 'jobs';
  const prefix = type === 'majors' ? 'major' : 'job';
  return `${folder}/${prefix}-${slug.replace(/\//g, '_')}.${ext}`;
}

function getDefaultWorkflowSettings() {
  return {
    unet_name: 'z_image_turbo_bf16.safetensors',
    weight_dtype: 'default',
    clip_name: 'qwen_3_4b.safetensors',
    clip_type: 'sd3',
    vae_name: 'ae.safetensors',
    lora_name: LORA_NAME,
    strength_model: 0.95,
    strength_clip: 0.8,
    auraflow_shift: 3,
    width: 1200,
    height: 672,
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
  const defaults = getDefaultWorkflowSettings();
  if (!fs.existsSync(COMFYUI_WORKFLOW_PATH)) return defaults;
  try {
    const parsed = JSON.parse(fs.readFileSync(COMFYUI_WORKFLOW_PATH, 'utf8'));
    const graph = parsed?.definitions?.subgraphs?.[0] || parsed;
    const nodes = Array.isArray(graph?.nodes) ? graph.nodes : [];
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
    return {
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
  } catch {
    return defaults;
  }
}

function buildComfyWorkflow(prompt, useLora) {
  const settings = loadWorkflowSettings();
  const workflow = {
    '1': { inputs: { unet_name: settings.unet_name, weight_dtype: settings.weight_dtype }, class_type: 'UNETLoader' },
    '2': { inputs: { clip_name: settings.clip_name, type: settings.clip_type }, class_type: 'CLIPLoader' },
    '3': { inputs: { vae_name: settings.vae_name }, class_type: 'VAELoader' },
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
    };
    modelRef = [String(nextId), 0];
    clipRef = [String(nextId), 1];
    nextId++;
  }
  workflow[String(nextId)] = {
    inputs: { model: modelRef, shift: settings.auraflow_shift },
    class_type: 'ModelSamplingAuraFlow',
  };
  modelRef = [String(nextId), 0];
  nextId++;
  workflow[String(nextId)] = {
    inputs: { text: prompt, clip: clipRef },
    class_type: 'CLIPTextEncode',
  };
  const positiveId = String(nextId);
  nextId++;
  workflow[String(nextId)] = {
    inputs: { text: settings.negative_prompt, clip: clipRef },
    class_type: 'CLIPTextEncode',
  };
  const negativeId = String(nextId);
  nextId++;
  workflow[String(nextId)] = {
    inputs: { width: settings.width, height: settings.height, batch_size: settings.batch_size },
    class_type: 'EmptyLatentImage',
  };
  const latentId = String(nextId);
  nextId++;
  workflow[String(nextId)] = {
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
  };
  const samplerId = String(nextId);
  nextId++;
  workflow[String(nextId)] = {
    inputs: { samples: [samplerId, 0], vae: ['3', 0] },
    class_type: 'VAEDecode',
  };
  const decodeId = String(nextId);
  nextId++;
  workflow[String(nextId)] = {
    inputs: { filename_prefix: 'careerwiki', images: [decodeId, 0] },
    class_type: 'SaveImage',
  };
  return workflow;
}

async function generatePrompt(systemPrompt, devVars) {
  await ensureOllamaRunning();
  try {
    const res = await fetch(`${OLLAMA_URL}/api/chat`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        model: OLLAMA_MODEL,
        messages: [
          { role: 'system', content: 'You are an expert image prompt writer. Output only the final paragraph.' },
          { role: 'user', content: systemPrompt },
        ],
        stream: false,
        think: false,
        options: { temperature: 0.7, top_p: 0.9, num_predict: 2048 },
      }),
    });
    if (res.ok) {
      const data = await res.json();
      const prompt = (data.message?.content || data.message?.thinking || '').trim();
      if (prompt) return { prompt, source: 'ollama' };
    }
  } catch {}

  if (!devVars.GEMINI_API_KEY) {
    throw new Error('Ollama failed and GEMINI_API_KEY is missing');
  }

  const res = await fetch(
    `https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=${devVars.GEMINI_API_KEY}`,
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
  const prompt = data.candidates?.[0]?.content?.parts?.[0]?.text?.trim();
  if (!prompt) throw new Error('Gemini prompt generation failed');
  return { prompt, source: 'gemini' };
}

async function generateComfyImage(prompt, useLora) {
  await ensureComfyUiRunning();
  // 유휴 타이머 리셋: 생성 시작 시점을 "마지막 사용"으로 기록
  comfyuiLastUsed = Date.now();
  for (const comfyUrl of COMFYUI_URLS) {
    try {
      const stats = await fetch(`${comfyUrl}/system_stats`);
      if (!stats.ok) continue;
      const workflow = buildComfyWorkflow(prompt, useLora);
      const res = await fetch(`${comfyUrl}/prompt`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ prompt: workflow }),
      });
      if (!res.ok) continue;
      const { prompt_id } = await res.json();
      for (let i = 0; i < MAX_POLLS; i++) {
        await sleep(POLL_MS);
        const historyRes = await fetch(`${comfyUrl}/history/${prompt_id}`);
        if (!historyRes.ok) continue;
        const history = await historyRes.json();
        const entry = history[prompt_id];
        if (!entry) continue;
        if (entry.status?.status_str === 'error') break;
        if (entry.status?.completed || entry.status?.status_str === 'success') {
          const outputs = entry.outputs || {};
          for (const nodeId of Object.keys(outputs)) {
            const images = outputs[nodeId]?.images;
            if (images && images.length > 0) {
              const image = images[0];
              const viewUrl = `${comfyUrl}/view?filename=${encodeURIComponent(image.filename)}&subfolder=${encodeURIComponent(image.subfolder || '')}&type=output`;
              const imgRes = await fetch(viewUrl);
              if (!imgRes.ok) throw new Error(`ComfyUI image download failed: HTTP ${imgRes.status}`);
              const buffer = Buffer.from(await imgRes.arrayBuffer());
              comfyuiLastUsed = Date.now();
              return { buffer, source: 'comfyui' };
            }
          }
        }
      }
    } catch {}
  }
  return null;
}

async function generateLocal(type, slug) {
  // 로컬 전용. Evolink/외부 이미지 폴백 없음 (서버 폴백이 담당).
  const devVars = loadDevVars();
  const useLora = hasLoraFile();
  const systemPrompt = type === 'majors'
    ? getMajorPromptTemplate(slug, { useLora })
    : getJobPromptTemplate(slug, { useLora });
  const promptResult = await generatePrompt(systemPrompt, devVars);
  const imageResult = await generateComfyImage(promptResult.prompt, useLora);
  if (!imageResult) {
    throw new Error('ComfyUI image generation returned no image (cold-start failed or LoRA missing)');
  }
  const isPng = imageResult.buffer[0] === 0x89 && imageResult.buffer[1] === 0x50;
  const mimeType = isPng ? 'image/png' : 'image/webp';
  const settings = loadWorkflowSettings();
  return {
    success: true,
    imageBase64: imageResult.buffer.toString('base64'),
    mimeType,
    prompt: promptResult.prompt,
    source: { prompt: promptResult.source, image: imageResult.source },
    loraApplied: useLora,
    width: settings.width,
    height: settings.height,
  };
}

async function getBridgeHealth() {
  const lora = hasLoraFile();
  const workflowLoaded = fs.existsSync(COMFYUI_WORKFLOW_PATH);
  const ollamaReady = await fetchOk(`${OLLAMA_URL}/api/tags`);
  const comfyReachable = [];
  for (const comfyUrl of COMFYUI_URLS) {
    comfyReachable.push({
      url: comfyUrl,
      ready: await fetchOk(`${comfyUrl}/system_stats`),
    });
  }

  const warming = !!comfyBootPromise;
  return {
    success: true,
    service: 'careerwiki-local-image-bridge',
    ollama: { ready: ollamaReady, url: OLLAMA_URL, model: OLLAMA_MODEL },
    comfyui: {
      workflowPath: COMFYUI_WORKFLOW_PATH,
      workflowLoaded,
      instances: comfyReachable,
      warming,
      idleTimeoutMinutes: Math.round(COMFY_IDLE_TIMEOUT_MS / 60000),
      lastUsedAt: comfyuiLastUsed ? new Date(comfyuiLastUsed).toISOString() : null,
    },
    lora: {
      ready: lora,
      name: LORA_NAME,
      path: path.join(LORA_DIR, LORA_NAME),
    },
  };
}

async function requestHandler(req, res) {
  const origin = req.headers.origin || '';

  if (req.method === 'OPTIONS') {
    // Chrome Local Network Access preflight (public origin → private IP) 처리.
    // 요청 헤더 `Access-Control-Request-Private-Network: true`가 오면 로그에 남기고,
    // 응답은 sendJson이 이미 `Access-Control-Allow-Private-Network: true`를 항상 포함하므로 그대로 204 반환.
    const reqPrivateNet = (req.headers['access-control-request-private-network'] || '').toLowerCase();
    if (reqPrivateNet === 'true') {
      console.log(`[CW-BRIDGE] LNA preflight (${req.url}) from origin=${origin || '(none)'} → allow-private-network`);
    }
    sendJson(res, 204, {}, origin);
    return;
  }

  if (req.method === 'GET' && req.url === '/api/health') {
    sendJson(res, 200, await getBridgeHealth(), origin);
    return;
  }

  if (req.method === 'POST' && req.url === '/api/generate-image') {
    try {
      const body = await parseBody(req);
      const { type, slug } = body || {};
      if (!type || !slug || !['jobs', 'majors'].includes(type)) {
        sendJson(res, 400, { success: false, error: 'type 또는 slug가 유효하지 않습니다.' }, origin);
        return;
      }
      const result = await generateLocal(type, slug);
      sendJson(res, 200, result, origin);
      return;
    } catch (error) {
      sendJson(res, 500, {
        success: false,
        error: error instanceof Error ? error.message : '로컬 이미지 생성에 실패했습니다.',
      }, origin);
      return;
    }
  }

  sendJson(res, 404, { success: false, error: 'not found' }, origin);
}

// 인증서 로드 시도. mkcert로 발급한 파일이 있으면 HTTPS 서버를 띄우고,
// 없으면 HTTP 하나만 띄우는 레거시 동작으로 폴백한다.
function loadTlsOptions() {
  try {
    if (fs.existsSync(CERT_KEY_PATH) && fs.existsSync(CERT_CRT_PATH)) {
      return {
        key: fs.readFileSync(CERT_KEY_PATH),
        cert: fs.readFileSync(CERT_CRT_PATH),
      };
    }
  } catch (err) {
    console.warn(`[CW-BRIDGE] TLS cert read failed: ${err.message}`);
  }
  return null;
}

const tlsOptions = loadTlsOptions();

if (tlsOptions) {
  // HTTPS 기본 — Chrome LNA를 우회하려면 public origin → Secure Context만 가능
  https.createServer(tlsOptions, requestHandler).listen(PORT, HOST, () => {
    console.log(`[CW-BRIDGE] listening on https://${HOST}:${PORT} (mkcert TLS)`);
  });
  // HTTP 폴백 포트 — curl/테스트 및 과도기 호환용
  http.createServer(requestHandler).listen(HTTP_FALLBACK_PORT, HOST, () => {
    console.log(`[CW-BRIDGE] legacy HTTP fallback on http://${HOST}:${HTTP_FALLBACK_PORT}`);
  });
} else {
  console.warn('[CW-BRIDGE] TLS cert not found in scripts/certs/. Run mkcert per docs — falling back to HTTP only.');
  http.createServer(requestHandler).listen(PORT, HOST, () => {
    console.log(`[CW-BRIDGE] listening on http://${HOST}:${PORT} (HTTP-only fallback)`);
  });
}
console.log(`[CW-BRIDGE] ComfyUI on-demand mode; idle timeout=${Math.round(COMFY_IDLE_TIMEOUT_MS / 60000)}m (env CW_COMFY_IDLE_MINUTES)`);


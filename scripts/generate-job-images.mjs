/**
 * generate-job-images.mjs — 76개 이미지 재생성 (올바른 JOB_PROMPT_TEMPLATE 사용)
 *
 * 대상: image_prompt 길이 < 300인 CAREERNET 직업 (기존 generate-job-images.mjs의 잘못된 프롬프트로 생성된 것들)
 * 방식: geminiService.ts의 JOB_PROMPT_TEMPLATE + gemini-2.0-flash → Evolink → R2 덮어쓰기
 *
 * 사용법: node scripts/generate-job-images.mjs
 */

import { execSync, spawnSync } from 'child_process';
import { writeFileSync, readFileSync, unlinkSync, existsSync, mkdirSync } from 'fs';
import { tmpdir } from 'os';
import { join, dirname } from 'path';
import { fileURLToPath } from 'url';

const __dirname = dirname(fileURLToPath(import.meta.url));
const CWD = join(__dirname, '..');
const MAX_BUFFER = 10 * 1024 * 1024;

// .dev.vars에서 API 키 읽기 (메인 프로젝트 루트)
const devVarsPath = join(CWD, '.dev.vars');
const devVars = readFileSync(devVarsPath, 'utf-8');
const GEMINI_KEY = devVars.match(/GEMINI_API_KEY=(.+)/)?.[1]?.trim();
const EVOLINK_KEY = devVars.match(/EVOLINK_API_KEY=(.+)/)?.[1]?.trim();

if (!GEMINI_KEY || !EVOLINK_KEY) {
  console.error('❌ API 키 누락: .dev.vars에 GEMINI_API_KEY, EVOLINK_API_KEY 필요');
  process.exit(1);
}

const TEMP_DIR = join(CWD, 'temp_images_regen');
if (!existsSync(TEMP_DIR)) mkdirSync(TEMP_DIR, { recursive: true });

// ============================================================
// geminiService.ts의 JOB_PROMPT_TEMPLATE 그대로 복사
// ============================================================
const JOB_PROMPT_TEMPLATE = `You will create ONE paragraph describing an image prompt based on the job "{jobName}".
Follow all rules silently. Do NOT output lists, examples, or meta-text.

RULES (DO NOT OUTPUT THESE):

1) FIXED CHARACTER STYLE
Always describe the beaver exactly as:
"a small cute baby beaver with tiny teeth, big round glossy eyes, soft rounded cheeks, short limbs, light-brown fluffy fur and a creamy belly, drawn in simple 2D cartoon style."
The style must never shift to realism, chibi, furry-detail, or alternative aesthetics.

2) JOB-SPECIFIC ACTION (MANDATORY)
The beaver must be shown performing ONE clear, physical, job-specific action appropriate for "{jobName}".
The action must involve direct, visible interaction with professional tools, devices, machinery, or materials that are genuinely used in this job.
The action must be concrete and visually obvious (e.g., tightening, assembling, calibrating, soldering, operating, adjusting, monitoring, sketching, programming, extinguishing).
Do NOT use abstract actions such as "performing duties," "consulting," "analyzing," or "overseeing."

3) PROFESSIONAL EQUIPMENT & UNIFORM
If the job normally requires a uniform, protective gear, or standard professional attire, the beaver must be wearing an appropriate simplified version of that uniform.
If the job requires specialized equipment (e.g., VR headsets, medical devices, safety helmets, lab coats, harnesses), the beaver must be clearly wearing or using that equipment as part of the action.

4) JOB-SPECIFIC ENVIRONMENT
Describe a wide, detailed workplace that is unmistakably associated with "{jobName}".
Include specific professional tools, machines, instruments, materials, or architectural elements unique to this job.
Avoid generic phrases such as "professional workplace," "relevant tools," or "appropriate equipment."

5) CHARACTER SIZE
The beaver should appear small and natural within the scene, occupying approximately **12% of the frame**, allowing the environment and professional context to dominate visually.

6) VISUAL STYLE
2D stylized realism with soft painterly shading, gentle gradients, atmospheric haze, and cinematic rim light.
Dark-mode palette: deep navy, muted violet, soft teal glow accents.
The background should be rich and detailed but never overpower the character.

7) PROHIBITED
No text, labels, signage, numbers, lists, meta commentary, logos, or photorealistic humans or animals.

OUTPUT
Produce ONE concise paragraph (<2000 characters) describing the final scene.
Do NOT mention rules or provide explanations.`;

// ============================================================
// 유틸리티
// ============================================================
function parseWranglerOutput(raw) {
  const clean = raw.replace(/\x1B\[[0-9;]*[mGKHF]/g, '');
  const startIdx = clean.indexOf('[');
  const endIdx = clean.lastIndexOf(']');
  if (startIdx === -1 || endIdx === -1) return [];
  try {
    const parsed = JSON.parse(clean.substring(startIdx, endIdx + 1));
    return parsed[0]?.results || [];
  } catch {
    return [];
  }
}

function runQuery(sql) {
  try {
    const raw = execSync(
      `npx wrangler d1 execute careerwiki-kr --remote --command "${sql.replace(/"/g, '\\"').replace(/\r?\n/g, ' ')}"`,
      { cwd: CWD, encoding: 'utf-8', timeout: 30000, maxBuffer: MAX_BUFFER }
    );
    return parseWranglerOutput(raw);
  } catch (e) {
    console.error(`쿼리 실패: ${(e.stdout || e.message || '').substring(0, 200)}`);
    return [];
  }
}

function runSqlFile(sql) {
  const tmpFile = join(tmpdir(), `job_img_regen_${Date.now()}.sql`);
  try {
    writeFileSync(tmpFile, sql, 'utf-8');
    const raw = execSync(
      `npx wrangler d1 execute careerwiki-kr --remote --file="${tmpFile}"`,
      { cwd: CWD, encoding: 'utf-8', timeout: 30000, maxBuffer: MAX_BUFFER }
    );
    return raw.includes('Executed') || raw.includes('success');
  } catch (e) {
    console.error(`SQL 실패: ${(e.stdout || e.message || '').substring(0, 200)}`);
    return false;
  } finally {
    try { unlinkSync(tmpFile); } catch {}
  }
}

// Gemini 2.0 flash로 이미지 프롬프트 생성 (JOB_PROMPT_TEMPLATE 사용)
async function generatePrompt(jobName) {
  const systemPrompt = JOB_PROMPT_TEMPLATE.replace(/\{jobName\}/g, jobName);
  const body = {
    contents: [{ parts: [{ text: systemPrompt }] }],
    generationConfig: { temperature: 0.7, maxOutputTokens: 1000, topP: 0.9 }
  };

  try {
    const resp = await fetch(
      `https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=${GEMINI_KEY}`,
      { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(body) }
    );
    if (!resp.ok) {
      console.error(`   Gemini 오류: HTTP ${resp.status}`);
      return null;
    }
    const data = await resp.json();
    const text = data.candidates?.[0]?.content?.parts?.[0]?.text?.trim();
    if (!text) return null;
    return text.replace(/^["']|["']$/g, '').trim();
  } catch (e) {
    console.error(`   Gemini 예외: ${e.message}`);
    return null;
  }
}

// Evolink 이미지 생성 요청
async function requestEvolinkImage(prompt) {
  try {
    const resp = await fetch('https://api.evolink.ai/v1/images/generations', {
      method: 'POST',
      headers: { 'Authorization': `Bearer ${EVOLINK_KEY}`, 'Content-Type': 'application/json' },
      body: JSON.stringify({ model: 'z-image-turbo', prompt, size: '16:9', nsfw_check: false })
    });
    if (!resp.ok) { console.error(`   Evolink 오류: ${resp.status}`); return null; }
    const data = await resp.json();
    return data.id || null;
  } catch (e) {
    console.error(`   Evolink 예외: ${e.message}`);
    return null;
  }
}

// Evolink 태스크 폴링
async function pollEvolinkTask(taskId, jobName, maxAttempts = 40) {
  for (let i = 0; i < maxAttempts; i++) {
    await new Promise(r => setTimeout(r, 2000));
    try {
      const resp = await fetch(`https://api.evolink.ai/v1/tasks/${taskId}`, {
        headers: { 'Authorization': `Bearer ${EVOLINK_KEY}` }
      });
      if (!resp.ok) continue;
      const data = await resp.json();
      const status = (data.status || '').toLowerCase();
      if (status === 'completed' || status === 'success' || status === 'done') {
        const url = data.results?.[0] || data.data?.url || data.data?.urls?.[0] || data.output?.url;
        if (url) return url;
      }
      if (status === 'failed' || status === 'error') return null;
      if (i % 5 === 0) process.stdout.write(`   [${(i + 1) * 2}s] ${jobName} 생성 중...\n`);
    } catch { continue; }
  }
  return null;
}

// 이미지 다운로드
async function downloadImage(url, localPath) {
  try {
    const resp = await fetch(url);
    if (!resp.ok) return false;
    const buffer = Buffer.from(await resp.arrayBuffer());
    writeFileSync(localPath, buffer);
    return true;
  } catch (e) {
    console.error(`   다운로드 예외: ${e.message}`);
    return false;
  }
}

// R2 업로드 (덮어쓰기)
function uploadToR2(localPath, slug) {
  const r2Key = `uploads/jobs/job-${slug}.webp`;
  try {
    execSync(
      `npx wrangler r2 object put careerwiki-uploads/${r2Key} --file="${localPath}" --content-type image/webp --remote`,
      { cwd: CWD, stdio: 'pipe', timeout: 60000 }
    );
    return `/uploads/jobs/job-${slug}.webp`;
  } catch (e) {
    console.error(`   R2 업로드 실패: ${e.message.substring(0, 150)}`);
    return null;
  }
}

// ============================================================
// 메인
// ============================================================
async function main() {
  console.log('\n🎬 76개 직업 이미지 재생성 시작 (올바른 JOB_PROMPT_TEMPLATE 사용)\n');

  // 기존 잘못된 프롬프트(200자 미만)로 생성된 CAREERNET 직업
  const jobs = runQuery(
    `SELECT id, name, slug FROM jobs WHERE primary_source='CAREERNET' AND image_url IS NOT NULL AND image_prompt IS NOT NULL AND length(image_prompt) < 300`
  );

  console.log(`📋 처리 대상: ${jobs.length}개 직업`);
  if (jobs.length === 0) { console.log('✅ 모두 정상 처리됨'); return; }

  let succeeded = 0, failed = 0;
  const failedJobs = [];

  for (let i = 0; i < jobs.length; i++) {
    const job = jobs[i];
    console.log(`\n[${i + 1}/${jobs.length}] 📝 ${job.name} (slug: ${job.slug})`);
    const remaining = (jobs.length - i - 1) * 50;
    console.log(`   남은 예상: ${Math.floor(remaining / 60)}분 ${remaining % 60}초`);

    // Step 1: 올바른 JOB_PROMPT_TEMPLATE으로 Gemini 2.0 flash 프롬프트 생성
    process.stdout.write(`   Gemini 2.0-flash 프롬프트 생성 중...`);
    const prompt = await generatePrompt(job.name);
    if (!prompt) {
      console.log(` ❌ 프롬프트 생성 실패`);
      failed++; failedJobs.push(job.name);
      continue;
    }
    console.log(` ✅ (${prompt.length}자)`);

    // Step 2: Evolink 이미지 생성 요청
    process.stdout.write(`   Evolink 이미지 생성 요청...`);
    const taskId = await requestEvolinkImage(prompt);
    if (!taskId) {
      console.log(` ❌ 태스크 생성 실패`);
      failed++; failedJobs.push(job.name);
      continue;
    }
    console.log(` ✅ (${taskId.substring(0, 20)}...)`);

    // Step 3: 완료 폴링
    const imageUrl = await pollEvolinkTask(taskId, job.name);
    if (!imageUrl) {
      console.log(`   ❌ 이미지 생성 타임아웃/실패`);
      failed++; failedJobs.push(job.name);
      continue;
    }
    console.log(`   ✅ 이미지 URL 획득`);

    // Step 4: 다운로드
    const filename = `job-${job.slug}.webp`;
    const localPath = join(TEMP_DIR, filename);
    process.stdout.write(`   다운로드 중...`);
    if (!await downloadImage(imageUrl, localPath)) {
      console.log(` ❌ 다운로드 실패`);
      failed++; failedJobs.push(job.name);
      continue;
    }
    console.log(` ✅`);

    // Step 5: R2 덮어쓰기
    process.stdout.write(`   R2 덮어쓰기 중...`);
    const r2Url = uploadToR2(localPath, job.slug);
    if (!r2Url) {
      console.log(` ❌ R2 업로드 실패`);
      failed++; failedJobs.push(job.name);
      continue;
    }
    console.log(` ✅ → ${r2Url}`);

    // Step 6: DB image_prompt + image_url 갱신 (버전 쿼리스트링으로 캐시 버스팅)
    const escapedPrompt = prompt.replace(/'/g, "''");
    const newUrl = `/uploads/jobs/job-${job.slug}.webp?v=${Date.now()}`;
    const ok = runSqlFile(
      `UPDATE jobs SET image_prompt = '${escapedPrompt}', image_url = '${newUrl}' WHERE id = '${job.id}';`
    );
    if (ok) {
      console.log(`   ✅ DB 갱신 완료`);
      succeeded++;
      try { unlinkSync(localPath); } catch {}
    } else {
      console.log(`   ❌ DB 갱신 실패`);
      failed++; failedJobs.push(job.name);
    }

    // API 레이트 리밋 방지
    if (i < jobs.length - 1) await new Promise(r => setTimeout(r, 3000));
  }

  console.log('\n' + '='.repeat(60));
  console.log(`✅ 성공: ${succeeded}개 | ❌ 실패: ${failed}개`);
  if (failedJobs.length > 0) {
    console.log(`\n실패한 직업:\n${failedJobs.map(n => `  - ${n}`).join('\n')}`);
  }
  console.log('='.repeat(60) + '\n');
}

main().catch(console.error);

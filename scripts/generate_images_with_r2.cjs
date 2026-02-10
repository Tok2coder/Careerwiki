/**
 * 이미지 생성 + R2 영구 저장 스크립트
 * 
 * Evolink API로 이미지 생성 후, R2에 업로드하여 영구 저장
 * (Evolink 임시 URL은 일정 기간 후 삭제됨)
 * 
 * 사용법: node scripts/generate_images_with_r2.cjs
 */

const Database = require('better-sqlite3');
const path = require('path');
const fs = require('fs');
const { execSync } = require('child_process');

const dbPath = path.resolve(__dirname, '../.wrangler/state/v3/d1/miniflare-D1DatabaseObject/926ac646196f97cbbf82a014f1749799d60a709010a65dbb289e4b2e6132a340.sqlite');
const db = new Database(dbPath);

// .dev.vars에서 API 키 읽기
const devVarsPath = path.resolve(__dirname, '../.dev.vars');
const devVars = fs.readFileSync(devVarsPath, 'utf-8');
const apiKeyMatch = devVars.match(/EVOLINK_API_KEY=(.+)/);
if (!apiKeyMatch) {
  console.error('❌ EVOLINK_API_KEY를 .dev.vars에서 찾을 수 없습니다.');
  process.exit(1);
}
const API_KEY = apiKeyMatch[1].trim();

// R2 Public URL (Cloudflare Pages에서 자동 제공되는 URL 또는 커스텀 도메인)
// careerwiki.org에서 R2 이미지를 서빙하려면 커스텀 도메인 설정 필요
// 일단 로컬 R2 저장만 하고, 실제 URL은 나중에 설정
const R2_PUBLIC_BASE = 'https://pub-careerwiki.r2.dev'; // 이 값은 실제 R2 public URL로 변경 필요

// 임시 디렉토리
const TEMP_DIR = path.resolve(__dirname, '../temp_images');
if (!fs.existsSync(TEMP_DIR)) {
  fs.mkdirSync(TEMP_DIR, { recursive: true });
}

// 이미지 생성 요청
async function requestImage(prompt, jobName) {
  try {
    const response = await fetch('https://api.evolink.ai/v1/images/generations', {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${API_KEY}`,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        model: 'z-image-turbo',
        prompt: prompt,
        size: '1280x720',
        nsfw_check: false
      })
    });

    if (!response.ok) {
      const error = await response.text();
      console.log(`❌ ${jobName} API 오류: ${response.status}`);
      return null;
    }

    const taskData = await response.json();
    return taskData.id;
  } catch (error) {
    console.log(`❌ ${jobName} 오류: ${error.message}`);
    return null;
  }
}

// 태스크 상태 확인
async function checkTaskStatus(taskId, jobName) {
  let attempts = 0;
  const maxAttempts = 30;

  while (attempts < maxAttempts) {
    await new Promise(resolve => setTimeout(resolve, 2000));
    attempts++;

    try {
      const response = await fetch(`https://api.evolink.ai/v1/tasks/${taskId}`, {
        headers: { 'Authorization': `Bearer ${API_KEY}` }
      });

      if (!response.ok) continue;

      const status = await response.json();

      if (status.status === 'completed') {
        const imageUrl = status.results?.[0] || status.data?.url || status.data?.urls?.[0];
        if (imageUrl) return imageUrl;
      } else if (status.status === 'failed') {
        return null;
      }

      if (attempts % 5 === 0) {
        console.log(`   [${attempts}] ${jobName}: ${status.progress || 0}%`);
      }
    } catch (error) {
      continue;
    }
  }
  return null;
}

// 이미지 다운로드
async function downloadImage(url, localPath) {
  try {
    const response = await fetch(url);
    if (!response.ok) {
      console.log(`❌ 이미지 다운로드 실패: ${response.status}`);
      return false;
    }
    const buffer = Buffer.from(await response.arrayBuffer());
    fs.writeFileSync(localPath, buffer);
    return true;
  } catch (error) {
    console.log(`❌ 다운로드 오류: ${error.message}`);
    return false;
  }
}

// R2에 업로드 (wrangler 명령 사용)
function uploadToR2(localPath, r2Key) {
  try {
    // --local 플래그로 로컬 R2에 업로드 (개발 환경)
    execSync(`npx wrangler r2 object put careerwiki-uploads/${r2Key} --file="${localPath}" --local`, {
      cwd: path.resolve(__dirname, '..'),
      stdio: 'pipe'
    });
    return true;
  } catch (error) {
    console.log(`❌ R2 업로드 실패: ${error.message}`);
    return false;
  }
}

// 메인 함수
async function generateImagesWithR2() {
  // 이미지가 없고 프롬프트가 있는 직업들 조회
  const jobs = db.prepare(`
    SELECT slug, name, image_prompt
    FROM jobs
    WHERE (image_url IS NULL OR image_url = '' OR image_url LIKE '%evolink%')
      AND image_prompt IS NOT NULL
      AND image_prompt != ''
    ORDER BY id
  `).all();

  if (jobs.length === 0) {
    console.log('✅ 모든 직업에 이미지가 있습니다.');
    db.close();
    return;
  }

  console.log(`\n🎬 이미지 생성 + R2 저장 대상: ${jobs.length}개 직업`);
  console.log('='.repeat(60));

  let completed = 0;
  let failed = 0;
  const startTime = Date.now();

  for (let i = 0; i < jobs.length; i++) {
    const job = jobs[i];
    const elapsed = Math.floor((Date.now() - startTime) / 1000);
    const eta = jobs.length > 1 && i > 0 ? Math.floor(elapsed / i * (jobs.length - i)) : 0;
    
    console.log(`\n[${i + 1}/${jobs.length}] 📝 ${job.name} (ETA: ${Math.floor(eta / 60)}분 ${eta % 60}초)`);

    // 1. 이미지 생성 요청
    const taskId = await requestImage(job.image_prompt, job.name);
    if (!taskId) {
      console.log(`❌ ${job.name} 태스크 생성 실패`);
      failed++;
      continue;
    }

    console.log(`🎨 생성 중...`);

    // 2. 상태 확인 및 이미지 URL 획득
    const evolinkUrl = await checkTaskStatus(taskId, job.name);
    if (!evolinkUrl) {
      console.log(`❌ ${job.name} 이미지 생성 실패`);
      failed++;
      continue;
    }

    // 3. 이미지 다운로드
    const filename = `job-${job.slug}.webp`;
    const localPath = path.join(TEMP_DIR, filename);
    
    console.log(`📥 다운로드 중...`);
    const downloaded = await downloadImage(evolinkUrl, localPath);
    if (!downloaded) {
      console.log(`❌ ${job.name} 다운로드 실패`);
      failed++;
      continue;
    }

    // 4. R2에 업로드
    const r2Key = `jobs/${filename}`;
    console.log(`☁️ R2 업로드 중...`);
    const uploaded = uploadToR2(localPath, r2Key);
    if (!uploaded) {
      console.log(`❌ ${job.name} R2 업로드 실패`);
      failed++;
      // 로컬 파일 삭제
      fs.unlinkSync(localPath);
      continue;
    }

    // 5. DB 업데이트 (로컬 R2 경로로 저장 - 나중에 퍼블릭 URL로 변환 필요)
    // 로컬에서는 /r2/jobs/job-xxx.webp 형태로 접근
    const r2Url = `/r2/jobs/${filename}`;
    db.prepare('UPDATE jobs SET image_url = ? WHERE slug = ?').run(r2Url, job.slug);
    
    console.log(`✅ ${job.name} 완료! → ${r2Url}`);
    completed++;

    // 로컬 임시 파일 삭제
    fs.unlinkSync(localPath);

    // API 제한 고려 5초 대기
    await new Promise(resolve => setTimeout(resolve, 5000));
  }

  const totalTime = Math.floor((Date.now() - startTime) / 1000);
  console.log('\n' + '='.repeat(60));
  console.log(`✅ 완료: ${completed}개 / ❌ 실패: ${failed}개`);
  console.log(`⏱️ 총 소요 시간: ${Math.floor(totalTime / 60)}분 ${totalTime % 60}초`);

  // 임시 디렉토리 정리
  if (fs.existsSync(TEMP_DIR) && fs.readdirSync(TEMP_DIR).length === 0) {
    fs.rmdirSync(TEMP_DIR);
  }

  db.close();
}

generateImagesWithR2().catch(console.error);











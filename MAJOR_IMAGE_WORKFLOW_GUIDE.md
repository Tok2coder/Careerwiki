# 🎨 CareerWiki 전공 이미지 작업 가이드

> **AI 지시사항**: 이 문서는 전공 이미지 생성 및 R2 저장 가이드입니다.
> 사용자가 "전공 이미지 시작해"라고 하면 아래 워크플로우를 따르세요.

---

## 📊 현재 상황

| 항목 | 개수 | 상태 |
|------|------|------|
| 총 전공 수 | 608개 | - |
| 프롬프트 완료 | 608개 | ✅ 100% |
| 이미지 생성 | 0개 | ⬜ 대기 |
| R2 업로드 | 0개 | ⬜ 대기 |

**프롬프트는 이미 완료됨! 이미지 생성 + R2 저장만 필요**

---

## 📁 파일 위치

| 용도 | 경로 |
|------|------|
| 이미지 생성 + R2 저장 스크립트 | `scripts/generate_major_images_r2.cjs` |
| 상태 확인 스크립트 | `scripts/check_major_images.cjs` |

---

## 🤖 AI 작업 워크플로우

### 사용자가 "전공 이미지 시작해"라고 하면:

```
1. scripts/generate_major_images_r2.cjs 실행 (백그라운드)
2. 진행 상황 모니터링
3. 완료 후 결과 보고
```

---

## 📜 이미지 생성 + R2 저장 스크립트

**파일명**: `scripts/generate_major_images_r2.cjs`

```javascript
/**
 * 전공 이미지 생성 + R2 저장 스크립트
 * 
 * - Evolink API로 이미지 생성
 * - 즉시 R2에 업로드 (영구 저장)
 * - DB에 /uploads/ 경로로 저장
 * 
 * 사용법: node scripts/generate_major_images_r2.cjs
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

// 임시 디렉토리
const TEMP_DIR = path.resolve(__dirname, '../temp_major_images');
if (!fs.existsSync(TEMP_DIR)) {
  fs.mkdirSync(TEMP_DIR, { recursive: true });
}

// 이미지 생성 요청
async function requestImage(prompt) {
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
    if (!response.ok) return null;
    const taskData = await response.json();
    return taskData.id;
  } catch {
    return null;
  }
}

// 태스크 상태 확인
async function checkTaskStatus(taskId) {
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
        return status.results?.[0] || status.data?.url || status.data?.urls?.[0];
      } else if (status.status === 'failed') {
        return null;
      }
    } catch {
      continue;
    }
  }
  return null;
}

// 이미지 다운로드
async function downloadImage(url, localPath) {
  try {
    const response = await fetch(url);
    if (!response.ok) return false;
    const buffer = Buffer.from(await response.arrayBuffer());
    fs.writeFileSync(localPath, buffer);
    return true;
  } catch {
    return false;
  }
}

// R2에 업로드 (로컬)
function uploadToR2Local(localPath, r2Key) {
  try {
    execSync(`npx wrangler r2 object put careerwiki-uploads/${r2Key} --file="${localPath}" --local`, {
      cwd: path.resolve(__dirname, '..'),
      stdio: 'pipe'
    });
    return true;
  } catch {
    return false;
  }
}

// 메인 함수
async function generateMajorImages() {
  // 이미지가 없고 프롬프트가 있는 전공들 조회
  const majors = db.prepare(`
    SELECT id, slug, name, image_prompt
    FROM majors
    WHERE (image_url IS NULL OR image_url = '')
      AND image_prompt IS NOT NULL
      AND image_prompt != ''
    ORDER BY id
  `).all();

  if (majors.length === 0) {
    console.log('✅ 모든 전공에 이미지가 있습니다.');
    db.close();
    return;
  }

  console.log(`\n🎬 전공 이미지 생성: ${majors.length}개`);
  console.log('='.repeat(60));

  let completed = 0;
  let failed = 0;
  const startTime = Date.now();

  for (let i = 0; i < majors.length; i++) {
    const major = majors[i];
    const elapsed = Math.floor((Date.now() - startTime) / 1000);
    const eta = i > 0 ? Math.floor(elapsed / i * (majors.length - i)) : 0;
    
    console.log(`\n[${i + 1}/${majors.length}] ${major.name} (ETA: ${Math.floor(eta/60)}분)`);

    // slug가 없으면 id 사용
    const fileSlug = major.slug || major.id;
    const filename = `major-${fileSlug}.webp`;
    const localPath = path.join(TEMP_DIR, filename);
    const r2Key = `majors/${filename}`;

    // 1. 이미지 생성
    console.log('  🎨 생성 중...');
    const taskId = await requestImage(major.image_prompt);
    if (!taskId) {
      console.log('  ❌ 태스크 생성 실패');
      failed++;
      continue;
    }

    const imageUrl = await checkTaskStatus(taskId);
    if (!imageUrl) {
      console.log('  ❌ 이미지 생성 실패');
      failed++;
      continue;
    }

    // 2. 다운로드
    console.log('  📥 다운로드...');
    const downloaded = await downloadImage(imageUrl, localPath);
    if (!downloaded) {
      console.log('  ❌ 다운로드 실패');
      failed++;
      continue;
    }

    // 3. R2 업로드
    console.log('  ☁️ R2 업로드...');
    const uploaded = uploadToR2Local(localPath, r2Key);
    if (!uploaded) {
      console.log('  ❌ R2 업로드 실패');
      failed++;
      if (fs.existsSync(localPath)) fs.unlinkSync(localPath);
      continue;
    }

    // 4. DB 업데이트
    db.prepare('UPDATE majors SET image_url = ? WHERE id = ?').run(`/uploads/majors/${filename}`, major.id);
    console.log('  ✅ 완료!');
    completed++;

    // 임시 파일 삭제
    if (fs.existsSync(localPath)) fs.unlinkSync(localPath);

    // API 제한 고려 5초 대기
    await new Promise(resolve => setTimeout(resolve, 5000));
  }

  const totalTime = Math.floor((Date.now() - startTime) / 1000);
  console.log('\n' + '='.repeat(60));
  console.log(`✅ 완료: ${completed}개`);
  console.log(`❌ 실패: ${failed}개`);
  console.log(`⏱️ 소요 시간: ${Math.floor(totalTime / 60)}분 ${totalTime % 60}초`);

  // 임시 디렉토리 정리
  if (fs.existsSync(TEMP_DIR) && fs.readdirSync(TEMP_DIR).length === 0) {
    fs.rmdirSync(TEMP_DIR);
  }

  db.close();
}

generateMajorImages().catch(console.error);
```

---

## 🔍 검증 명령어

### 전체 상태 확인
```bash
npx wrangler d1 execute careerwiki-db --local --command "SELECT COUNT(*) as total, COUNT(CASE WHEN image_url IS NOT NULL AND image_url != '' THEN 1 END) as with_images FROM majors"
```

### 특정 전공 확인
```bash
npx wrangler d1 execute careerwiki-db --local --command "SELECT name, image_url FROM majors WHERE name LIKE '%컴퓨터%' LIMIT 5"
```

---

## ⚠️ 중요 사항

1. **Evolink 이미지 임시 저장**: Evolink API 이미지는 3-4일 후 삭제됨
2. **R2 즉시 저장**: 생성 즉시 R2에 업로드하여 영구 저장
3. **경로 형식**: `/uploads/majors/major-{slug}.webp`
4. **예상 시간**: 608개 × ~15초 = 약 2.5시간

---

## 🚀 빠른 시작

```bash
# 1. 스크립트 실행 (백그라운드)
node scripts/generate_major_images_r2.cjs

# 2. 진행 상황 확인
npx wrangler d1 execute careerwiki-db --local --command "SELECT COUNT(*) FROM majors WHERE image_url IS NOT NULL AND image_url != ''"

# 3. 완료 후 템플릿 버전 올리기
# src/constants/template-versions.ts에서 MAJOR 버전 +1
```

---

## 📋 프롬프트 예시 (이미 DB에 저장됨)

전공 프롬프트는 이미 608개 모두 DB에 저장되어 있습니다.
확인:
```bash
npx wrangler d1 execute careerwiki-db --local --command "SELECT name, SUBSTR(image_prompt, 1, 100) as prompt_preview FROM majors LIMIT 3"
```

---

**문서 생성일**: 2025-12-19










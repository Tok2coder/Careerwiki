#!/usr/bin/env node
/**
 * fix-detailready-objects.cjs
 *
 * detailReady 배열 항목이 객체({text:"..."}, {curriculum:"..."}, {title:"...",text:"...",...})로
 * 저장된 직업을 찾아 plain string으로 변환하여 편집 API로 저장.
 *
 * Usage: node scripts/fix-detailready-objects.cjs [--dry-run]
 */

'use strict';

const { execSync } = require('child_process');
const https = require('https');

const DRY_RUN = process.argv.includes('--dry-run');
const ADMIN_SECRET = 'careerwiki-admin-2026';
const API_HOST = 'careerwiki.org';

// 객체 항목에서 텍스트를 추출
function extractText(item, subKey) {
  if (typeof item === 'string') return item;
  if (item && typeof item === 'object') {
    if (item[subKey] && typeof item[subKey] === 'string') return item[subKey];
    if (item.text && typeof item.text === 'string') return item.text;
    if (item.title && typeof item.title === 'string') return item.title;
    if (item.name && typeof item.name === 'string') return item.name;
    if (item.value && typeof item.value === 'string') return item.value;
  }
  return null;
}

// 배열 변환: 객체가 하나라도 있으면 전체 변환, 모두 string이면 null 반환 (수정 불필요)
function normalizeArray(arr, subKey) {
  if (!Array.isArray(arr)) return null;
  let hasObject = false;
  for (const item of arr) {
    if (typeof item !== 'string') { hasObject = true; break; }
  }
  if (!hasObject) return null;
  return arr.map(item => extractText(item, subKey)).filter(Boolean);
}

function httpPost(path, payload) {
  return new Promise((resolve, reject) => {
    const body = JSON.stringify(payload);
    const req = https.request({
      hostname: API_HOST,
      path,
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-Admin-Secret': ADMIN_SECRET,
        'Content-Length': Buffer.byteLength(body),
      }
    }, (res) => {
      let data = '';
      res.on('data', chunk => { data += chunk; });
      res.on('end', () => resolve({ status: res.statusCode, body: data }));
    });
    req.on('error', reject);
    req.write(body);
    req.end();
  });
}

function sleep(ms) {
  return new Promise(r => setTimeout(r, ms));
}

async function main() {
  console.log(`\n=== detailReady 객체 항목 일괄 수정 스크립트 ===`);
  console.log(`모드: ${DRY_RUN ? 'DRY-RUN (수정 안 함)' : '실제 수정'}\n`);

  // 1. 영향받은 직업 목록 조회
  console.log('📋 영향받은 직업 조회 중...');
  let rows;
  try {
    const raw = execSync(
      `npx wrangler d1 execute careerwiki-kr --remote --json --command ` +
      `"SELECT id, name, slug, user_contributed_json FROM jobs WHERE is_active=1 AND ` +
      `(user_contributed_json LIKE '%\\"curriculum\\":[{%' OR ` +
      `user_contributed_json LIKE '%\\"training\\":[{%' OR ` +
      `user_contributed_json LIKE '%\\"recruit\\":[{%') LIMIT 300"`,
      { encoding: 'utf8', cwd: 'C:\\Users\\user\\Careerwiki', timeout: 90000, stdio: ['pipe', 'pipe', 'ignore'] }
    );
    const parsed = JSON.parse(raw);
    rows = parsed[0]?.results || [];
  } catch (e) {
    console.error('DB 쿼리 실패:', e.message);
    process.exit(1);
  }

  console.log(`총 ${rows.length}개 직업 발견\n`);

  let successCount = 0;
  let skipCount = 0;
  let failCount = 0;
  const failed = [];

  for (const row of rows) {
    const { id, name } = row;
    let ucj;
    try {
      ucj = JSON.parse(row.user_contributed_json);
    } catch {
      console.log(`  ⚠️  [${name}] UCJ 파싱 실패 — 건너뜀`);
      skipCount++;
      continue;
    }

    const dr = ucj.detailReady;
    if (!dr || typeof dr !== 'object') {
      skipCount++;
      continue;
    }

    const subKeys = ['curriculum', 'recruit', 'training', 'certificate', 'researchList'];
    const fixedDr = { ...dr };
    let changed = false;

    for (const sub of subKeys) {
      const fixed = normalizeArray(dr[sub], sub);
      if (fixed !== null) {
        fixedDr[sub] = fixed;
        changed = true;
        console.log(`  🔧 [${name}] detailReady.${sub}: ${dr[sub].length}개 항목 → string 변환`);
      }
    }

    if (!changed) {
      skipCount++;
      continue;
    }

    if (DRY_RUN) {
      console.log(`  ✅ [DRY] [${name}] 변환 완료 (저장 안 함)`);
      successCount++;
      continue;
    }

    // 2. 편집 API 호출
    try {
      const result = await httpPost(`/api/job/${id}/edit`, {
        fields: { detailReady: fixedDr },
        changeSummary: 'detailReady 배열 항목 객체→string 일괄 변환 (렌더링 버그 수정)'
      });

      if (result.status === 200) {
        console.log(`  ✅ [${name}] 저장 완료`);
        successCount++;
      } else {
        const preview = result.body.substring(0, 120);
        console.log(`  ❌ [${name}] API 실패 (${result.status}): ${preview}`);
        failCount++;
        failed.push({ name, id, status: result.status, body: preview });
      }
    } catch (err) {
      console.log(`  ❌ [${name}] 네트워크 오류: ${err.message}`);
      failCount++;
      failed.push({ name, id, error: err.message });
    }

    // Rate limit 방지 (5req/s 이하)
    await sleep(250);
  }

  console.log(`\n=== 완료 ===`);
  console.log(`✅ 성공: ${successCount}개`);
  console.log(`⏭️  건너뜀 (변환 불필요): ${skipCount}개`);
  console.log(`❌ 실패: ${failCount}개`);

  if (failed.length > 0) {
    console.log(`\n실패 목록:`);
    failed.forEach(f => console.log(`  - ${f.name} (${f.id}): ${f.status || ''}${f.error || ''}`));
    process.exit(1);
  }
}

main().catch(err => {
  console.error('스크립트 오류:', err);
  process.exit(1);
});

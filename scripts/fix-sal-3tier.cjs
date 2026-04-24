#!/usr/bin/env node
/**
 * fix-sal-3tier.cjs
 *
 * DB의 overviewSalary.sal이 3구간 포맷(하위/평균/상위)이 아닌 직업을
 * 고용24 API callOpenApiSvcInfo212D04 로 원본 데이터를 조회해 복구한다.
 *
 * 처리 흐름:
 *   1. DB 조회 → sal이 '하위'/'평균' 미포함인 직업 전체
 *   2. 직업명으로 고용24 list API 검색 → jobCd 확보
 *   3. D04 로 3구간 sal 조회
 *   4. overviewSalary.sal 만 업데이트 (다른 필드 절대 건드리지 않음)
 *   5. 결과 보고
 *
 * 사용법:
 *   node scripts/fix-sal-3tier.cjs --dry-run   # 변경 없이 대상 목록만 출력
 *   node scripts/fix-sal-3tier.cjs --execute   # 실제 업데이트 실행
 */

'use strict';

const { execSync } = require('child_process');
const https = require('https');

const DRY_RUN = process.argv.includes('--dry-run');
const EXECUTE = process.argv.includes('--execute');

if (!DRY_RUN && !EXECUTE) {
  console.error('Usage:');
  console.error('  node scripts/fix-sal-3tier.cjs --dry-run');
  console.error('  node scripts/fix-sal-3tier.cjs --execute');
  process.exit(1);
}

// API key/secret은 반드시 환경 변수로만 공급. 하드코딩 금지.
//   export GOYONG24_JOB_API_KEY=xxx
//   export ADMIN_SECRET=xxx
// (.dev.vars 파일에서도 자동 로딩)
const fs = require('fs');
function loadDevVars() {
  // worktree, worktree parents, 메인 레포 순으로 탐색
  const candidates = [
    require('path').resolve(__dirname, '..', '.dev.vars'),
    require('path').resolve(__dirname, '..', '..', '.dev.vars'),
    require('path').resolve(__dirname, '..', '..', '..', '.dev.vars'),
    require('path').resolve(__dirname, '..', '..', '..', '..', '.dev.vars'),
  ];
  for (const p of candidates) {
    if (!fs.existsSync(p)) continue;
    for (const line of fs.readFileSync(p, 'utf8').split('\n')) {
      const m = line.match(/^\s*([A-Z_][A-Z0-9_]*)\s*=\s*(.+?)\s*$/);
      if (m && !process.env[m[1]]) process.env[m[1]] = m[2];
    }
    return;
  }
}
loadDevVars();

const GOYONG24_JOB_API_KEY = process.env.GOYONG24_JOB_API_KEY;
const ADMIN_SECRET = process.env.ADMIN_SECRET;
if (!GOYONG24_JOB_API_KEY) {
  console.error('❌ GOYONG24_JOB_API_KEY 환경 변수가 필요합니다 (.dev.vars 또는 export).');
  process.exit(2);
}
if (!ADMIN_SECRET) {
  console.error('❌ ADMIN_SECRET 환경 변수가 필요합니다 (.dev.vars 또는 export).');
  process.exit(2);
}

const GOYONG24_BASE = 'https://www.work24.go.kr/cm/openApi/call/wk';
const API_BASE = 'https://careerwiki.org';

// ---- 유틸 ----------------------------------------------------------------

function sleep(ms) {
  return new Promise(r => setTimeout(r, ms));
}

function d1Query(sql) {
  const escaped = sql.replace(/"/g, '\\"');
  const raw = execSync(
    `npx wrangler d1 execute careerwiki-kr --remote --json --command "${escaped}"`,
    { encoding: 'utf8', cwd: require('path').join(__dirname, '..') }
  );
  const lines = raw.split('\n');
  const jsonStart = lines.findIndex(l => l.trim().startsWith('['));
  const parsed = JSON.parse(lines.slice(jsonStart).join('\n'));
  return parsed[0].results;
}

function httpsGet(url) {
  return new Promise((resolve, reject) => {
    https.get(url, (res) => {
      let buf = '';
      res.on('data', c => { buf += c; });
      res.on('end', () => resolve(buf));
    }).on('error', reject);
  });
}

function httpsPost(path, body) {
  return new Promise((resolve, reject) => {
    const data = JSON.stringify(body);
    const url = new URL(API_BASE + path);
    const req = https.request({
      hostname: url.hostname,
      path: url.pathname,
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Content-Length': Buffer.byteLength(data),
        'X-Admin-Secret': ADMIN_SECRET,
      },
    }, (res) => {
      let buf = '';
      res.on('data', c => { buf += c; });
      res.on('end', () => {
        try { resolve({ status: res.statusCode, body: JSON.parse(buf) }); }
        catch { resolve({ status: res.statusCode, body: buf }); }
      });
    });
    req.on('error', reject);
    req.write(data);
    req.end();
  });
}

function getXmlValue(xml, tag) {
  const m = xml.match(new RegExp(`<${tag}>([\\s\\S]*?)<\\/${tag}>`));
  return m ? m[1].trim() : null;
}

function extractXmlList(xml, tag) {
  const items = [];
  const re = new RegExp(`<${tag}>([\\s\\S]*?)<\\/${tag}>`, 'g');
  let m;
  while ((m = re.exec(xml)) !== null) {
    items.push(m[1]);
  }
  return items;
}

// ---- 고용24 API ----------------------------------------------------------

async function searchJobByName(name) {
  const encoded = encodeURIComponent(name);
  const url = `${GOYONG24_BASE}/callOpenApiSvcInfo212L01.do?authKey=${GOYONG24_JOB_API_KEY}&returnType=XML&target=JOBCD&srchType=K&keyword=${encoded}`;
  const xml = await httpsGet(url);
  const items = extractXmlList(xml, 'jobList');
  const matches = [];
  for (const item of items) {
    const jobCd = getXmlValue(item, 'jobCd');
    const jobNm = getXmlValue(item, 'jobNm');
    if (jobCd && jobNm) {
      matches.push({ jobCd, jobNm });
    }
  }
  return matches;
}

async function fetchSal(jobCd) {
  const url = `${GOYONG24_BASE}/callOpenApiSvcInfo212D04.do?authKey=${GOYONG24_JOB_API_KEY}&returnType=XML&target=JOBDTL&jobGb=1&jobCd=${jobCd}&dtlGb=4`;
  const xml = await httpsGet(url);
  return getXmlValue(xml, 'sal');
}

function is3Tier(sal) {
  if (!sal) return false;
  return sal.includes('하위') && sal.includes('평균') && sal.includes('상위');
}

function findExactMatch(matches, name) {
  // 완전 일치 우선
  let m = matches.find(x => x.jobNm === name);
  if (m) return m;
  // 공백·부호 제거 후 비교
  const normalize = s => s.replace(/[\s·\-–—·　]/g, '').toLowerCase();
  m = matches.find(x => normalize(x.jobNm) === normalize(name));
  return m || null;
}

// ---- 메인 ---------------------------------------------------------------

async function main() {
  console.log('\n=== fix-sal-3tier ===');
  console.log(`모드: ${DRY_RUN ? 'DRY-RUN (변경 없음)' : 'EXECUTE (실제 업데이트)'}`);

  // 1. 대상 직업 조회
  console.log('\n[Step 1] DB에서 3구간 미포맷 sal 직업 조회...');
  const rows = d1Query(
    "SELECT id, name, slug, " +
    "json_extract(merged_profile_json, '$.overviewSalary') as sal_full, " +
    "json_extract(user_contributed_json, '$._sources') as ucj_sources " +
    "FROM jobs " +
    "WHERE is_active=1 " +
    "AND json_extract(merged_profile_json, '$.overviewSalary.sal') IS NOT NULL " +
    "AND json_extract(merged_profile_json, '$.overviewSalary.sal') NOT LIKE '%하위%' " +
    "AND json_extract(merged_profile_json, '$.overviewSalary.sal') NOT LIKE '%평균%' " +
    "ORDER BY name"
  );

  console.log(`  대상: ${rows.length}개`);

  const results = {
    success: [],
    skipNoMatch: [],
    skipNo3Tier: [],
    skipAlready: [],
    failed: [],
  };

  // 2. 각 직업 처리
  console.log('\n[Step 2] 고용24 API 조회 및 업데이트...\n');

  for (let i = 0; i < rows.length; i++) {
    const row = rows[i];
    let salObj;
    try {
      salObj = row.sal_full ? JSON.parse(row.sal_full) : {};
    } catch {
      salObj = {};
    }

    const currentSal = salObj.sal || '';
    process.stdout.write(`[${i + 1}/${rows.length}] ${row.name}... `);

    // 혹시 이미 3구간인 경우 (필터 뒤에도 드물게 있을 수 있음)
    if (is3Tier(currentSal)) {
      process.stdout.write('이미 3구간 포맷 → 스킵\n');
      results.skipAlready.push({ name: row.name, reason: '이미 3구간' });
      continue;
    }

    try {
      // 고용24 검색
      await sleep(300);
      const matches = await searchJobByName(row.name);
      const match = findExactMatch(matches, row.name);

      if (!match) {
        process.stdout.write(`고용24 매칭 없음 (검색결과: ${matches.length}개) → 스킵\n`);
        results.skipNoMatch.push({
          name: row.name,
          slug: row.slug,
          currentSal,
          reason: `고용24 검색 결과 없음 (${matches.length}개 검색됨: ${matches.map(m => m.jobNm).join(', ') || '없음'})`,
        });
        continue;
      }

      // D04 sal 조회
      await sleep(300);
      const newSal = await fetchSal(match.jobCd);

      if (!is3Tier(newSal)) {
        process.stdout.write(`3구간 데이터 없음 (sal: ${(newSal||'').slice(0,50)}) → 스킵\n`);
        results.skipNo3Tier.push({
          name: row.name,
          slug: row.slug,
          currentSal,
          jobCd: match.jobCd,
          newSal,
          reason: '고용24 D04에도 3구간 포맷 없음',
        });
        continue;
      }

      // 업데이트할 overviewSalary 구성 (sal만 교체, 나머지 필드 유지)
      const updatedSalary = { ...salObj, sal: newSal };

      // 기존 _sources 가져오기
      let existingSources = {};
      try {
        existingSources = row.ucj_sources ? JSON.parse(row.ucj_sources) : {};
      } catch { /* ignore */ }

      process.stdout.write(`매칭: ${match.jobNm} (${match.jobCd})\n`);
      console.log(`    이전: ${currentSal}`);
      console.log(`    이후: ${newSal}`);

      if (DRY_RUN) {
        results.success.push({
          name: row.name,
          slug: row.slug,
          id: row.id,
          jobCd: match.jobCd,
          before: currentSal,
          after: newSal,
          revision: null,
        });
        continue;
      }

      // 실제 API 호출
      const res = await httpsPost(`/api/job/${row.id}/edit`, {
        fields: { overviewSalary: updatedSalary },
        sources: existingSources,
      });

      if (res.status >= 200 && res.status < 300) {
        const revision = res.body?.revision?.id || res.body?.id || null;
        console.log(`    ✅ 저장 성공 (HTTP ${res.status}) revision: ${revision}`);
        results.success.push({
          name: row.name,
          slug: row.slug,
          id: row.id,
          jobCd: match.jobCd,
          before: currentSal,
          after: newSal,
          revision,
        });
      } else {
        console.log(`    ❌ 저장 실패 (HTTP ${res.status}): ${JSON.stringify(res.body).slice(0, 200)}`);
        results.failed.push({
          name: row.name,
          id: row.id,
          reason: `HTTP ${res.status}: ${JSON.stringify(res.body).slice(0, 200)}`,
        });
      }

      await sleep(500);

    } catch (err) {
      process.stdout.write(`에러 → 스킵\n`);
      console.log(`    ❌ 에러: ${err.message}`);
      results.failed.push({ name: row.name, id: row.id, reason: err.message });
    }
  }

  // 3. 결과 보고
  console.log('\n' + '='.repeat(60));
  console.log('=== 최종 결과 보고 ===');
  console.log('='.repeat(60));
  console.log(`\n전체 대상:          ${rows.length}개`);
  console.log(`성공 복구:          ${results.success.length}개`);
  console.log(`스킵 (고용24 없음): ${results.skipNoMatch.length}개`);
  console.log(`스킵 (3구간 없음):  ${results.skipNo3Tier.length}개`);
  console.log(`스킵 (이미 정상):   ${results.skipAlready.length}개`);
  console.log(`실패:               ${results.failed.length}개`);

  if (results.success.length > 0) {
    console.log('\n--- 성공 복구 목록 ---');
    results.success.forEach((r, i) => {
      console.log(`  ${i + 1}. ${r.name} (${r.slug})${r.revision ? ` revision: ${r.revision}` : ''}`);
      console.log(`     이전: ${r.before}`);
      console.log(`     이후: ${r.after}`);
    });

    const revisions = results.success.filter(r => r.revision).map(r => r.revision);
    if (revisions.length > 0) {
      console.log(`\nRevision 번호: ${revisions.join(', ')}`);
    }
  }

  if (results.skipNoMatch.length > 0) {
    console.log('\n--- 스킵 (고용24 매칭 없음) ---');
    results.skipNoMatch.forEach(r => {
      console.log(`  - ${r.name}: ${r.reason}`);
    });
  }

  if (results.skipNo3Tier.length > 0) {
    console.log('\n--- 스킵 (3구간 데이터 없음) ---');
    results.skipNo3Tier.forEach(r => {
      console.log(`  - ${r.name} (${r.jobCd}): ${r.reason}`);
    });
  }

  if (results.failed.length > 0) {
    console.log('\n--- 실패 목록 ---');
    results.failed.forEach(r => {
      console.log(`  - ${r.name}: ${r.reason}`);
    });
  }

  console.log('\n' + '='.repeat(60) + '\n');

  if (DRY_RUN) {
    console.log('[DRY-RUN 완료] --execute 플래그로 재실행하면 실제 업데이트됩니다.\n');
  }
}

main().catch(err => {
  console.error('Fatal:', err);
  process.exit(1);
});

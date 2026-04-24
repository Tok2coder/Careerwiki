#!/usr/bin/env node
/**
 * salary-etl-phase2.cjs — Phase 2 Work24 배치 ETL
 *
 * 목표: B (중간값 없음) + C (전혀 없음) 직업의 임금을 Work24 salProspect(D04) API로 보완.
 *
 * 엄격한 준수 사항:
 *   1. A 스킵: wage 숫자 있거나 3구간 sal 있는 직업은 절대 안 건드림
 *   2. wage 절대 덮어쓰지 않음 (null일 때만 신규 설정)
 *   3. overviewSalary 외 UCJ 필드 절대 안 건드림
 *   4. enhance 배치 19/20/21 직업 제외 (병렬 편집 충돌 방지)
 *   5. AI 생성 금지 — Work24 실제 응답만 사용
 *   6. Work24에 매칭 안 되는 long-tail 방치 OK
 *
 * 로직:
 *   1. Work24 list API로 전체 직업 목록 수집 (1회)
 *   2. B+C 타겟 직업 쿼리 (enhance 배치 제외)
 *   3. 각 타겟 이름을 정규화 후 Work24 목록과 매칭
 *   4. 매칭된 것만 D04 호출 → 3구간 sal 받기
 *   5. 3구간 포맷 확인 후 overviewSalary 업데이트
 *
 * 사용법:
 *   node scripts/salary-etl-phase2.cjs --dry-run
 *   node scripts/salary-etl-phase2.cjs --execute
 *   node scripts/salary-etl-phase2.cjs --execute --limit=50   # 처음 N개만 (테스트용)
 */

'use strict';

const { execSync } = require('child_process');
const https = require('https');
const fs = require('fs');
const path = require('path');

// ---- .dev.vars 로딩 -----------------------------------------------------

function loadDevVars() {
  const candidates = [
    path.resolve(__dirname, '..', '.dev.vars'),
    path.resolve(__dirname, '..', '..', '.dev.vars'),
    path.resolve(__dirname, '..', '..', '..', '.dev.vars'),
    path.resolve(__dirname, '..', '..', '..', '..', '.dev.vars'),
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

// ---- CLI args -----------------------------------------------------------

const DRY_RUN = process.argv.includes('--dry-run');
const EXECUTE = process.argv.includes('--execute');
const limitArg = process.argv.find(a => a.startsWith('--limit='));
const LIMIT = limitArg ? parseInt(limitArg.split('=')[1], 10) : null;

if (!DRY_RUN && !EXECUTE) {
  console.error('Usage:');
  console.error('  node scripts/salary-etl-phase2.cjs --dry-run');
  console.error('  node scripts/salary-etl-phase2.cjs --execute [--limit=N]');
  process.exit(1);
}

const GOYONG24_KEY = process.env.GOYONG24_JOB_API_KEY;
const ADMIN_SECRET = process.env.ADMIN_SECRET;
if (!GOYONG24_KEY) { console.error('❌ GOYONG24_JOB_API_KEY 누락'); process.exit(2); }
if (!ADMIN_SECRET) { console.error('❌ ADMIN_SECRET 누락'); process.exit(2); }

const GOYONG24_BASE = 'https://www.work24.go.kr/cm/openApi/call/wk';
const API_BASE = 'https://careerwiki.org';
const PROJECT_ROOT = path.join(__dirname, '..');

// ---- enhance 배치 19/20/21 제외 직업명 (완전 일치) ----------------------

const ENHANCE_BATCH_EXCLUDE = new Set([
  '응용 소프트웨어 개발자',
  '시스템 소프트웨어 개발자',
  '웹 개발자',
  '모바일 앱 개발자',
  '게임 프로그래머',
  '게임 기획자',
  '게임 그래픽 디자이너',
  '게임개발프로듀서',
  '인공지능 엔지니어',
]);

// ---- 유틸 ---------------------------------------------------------------

const sleep = (ms) => new Promise(r => setTimeout(r, ms));

function d1Query(sql) {
  const cmd = `npx wrangler d1 execute careerwiki-kr --remote --json --command "${sql.replace(/"/g, '\\"')}"`;
  const raw = execSync(cmd, { encoding: 'utf8', cwd: PROJECT_ROOT, timeout: 120000, maxBuffer: 64 * 1024 * 1024 });
  const lines = raw.split('\n');
  const jsonStart = lines.findIndex(l => l.trim().startsWith('['));
  return JSON.parse(lines.slice(jsonStart).join('\n'))[0].results;
}

function httpsGet(url) {
  return new Promise((resolve, reject) => {
    https.get(url, (res) => {
      let buf = '';
      res.on('data', c => buf += c);
      res.on('end', () => resolve(buf));
    }).on('error', reject);
  });
}

function httpsPost(pathPart, body) {
  return new Promise((resolve, reject) => {
    const data = JSON.stringify(body);
    const url = new URL(API_BASE + pathPart);
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
      res.on('data', c => buf += c);
      res.on('end', () => {
        try { resolve({ status: res.statusCode, body: JSON.parse(buf) }); }
        catch { resolve({ status: res.statusCode, body: buf }); }
      });
    });
    req.on('error', reject);
    req.write(data); req.end();
  });
}

function xmlAll(xml, tag) {
  const items = [];
  const re = new RegExp(`<${tag}>([\\s\\S]*?)<\\/${tag}>`, 'g');
  let m; while ((m = re.exec(xml)) !== null) items.push(m[1]);
  return items;
}

function xmlVal(xml, tag) {
  const m = xml.match(new RegExp(`<${tag}>([\\s\\S]*?)<\\/${tag}>`));
  return m ? m[1].trim() : null;
}

// 이름 정규화: 공백·기호 제거 후 소문자
function normalizeName(s) {
  if (!s) return '';
  return s
    .replace(/[\s·\-–—\/()_\[\]\u3000]/g, '')
    .replace(/·/g, '')
    .toLowerCase()
    .trim();
}

// 3구간 포맷 확인
function is3Tier(sal) {
  if (!sal) return false;
  return /하위\(25%\)/.test(sal) && /평균\(50%\)/.test(sal) && /상위\(25%\)/.test(sal);
}

// 3구간에서 중간값(만원 단위 숫자) 추출
function extractMedian(sal) {
  if (!sal) return null;
  const m = sal.match(/평균\(50%\)\s*([\d,]+)\s*만원/);
  if (!m) return null;
  return m[1].replace(/,/g, '');
}

function formatWage(num) {
  if (!num) return null;
  const n = parseInt(num, 10);
  return Number.isFinite(n) ? n.toLocaleString('ko-KR') : null;
}

// ---- Work24 API --------------------------------------------------------

async function fetchWork24List() {
  const url = `${GOYONG24_BASE}/callOpenApiSvcInfo212L01.do?authKey=${GOYONG24_KEY}&returnType=XML&target=JOBCD&srchType=K&keyword=`;
  const xml = await httpsGet(url);
  const items = xmlAll(xml, 'jobList').map(entry => ({
    jobCd: xmlVal(entry, 'jobCd'),
    jobNm: xmlVal(entry, 'jobNm'),
    jobClcdNm: xmlVal(entry, 'jobClcdNM') || xmlVal(entry, 'jobClcdNm'),
  })).filter(j => j.jobCd && j.jobNm);
  return items;
}

async function fetchSalProspect(jobCd) {
  const url = `${GOYONG24_BASE}/callOpenApiSvcInfo212D04.do?authKey=${GOYONG24_KEY}&returnType=XML&target=JOBDTL&jobGb=1&jobCd=${jobCd}&dtlGb=4`;
  const xml = await httpsGet(url);
  return xmlVal(xml, 'sal');
}

// ---- 메인 --------------------------------------------------------------

async function main() {
  console.log('\n=== salary-etl-phase2 ===');
  console.log(`모드: ${DRY_RUN ? 'DRY-RUN' : 'EXECUTE'}${LIMIT ? ` (limit=${LIMIT})` : ''}`);
  console.log(`실행: ${new Date().toISOString()}\n`);

  // Step 1: Work24 전체 직업 목록 수집
  console.log('[Step 1] Work24 list API 호출 (empty keyword) ...');
  const work24Jobs = await fetchWork24List();
  console.log(`  Work24 전체: ${work24Jobs.length}개`);

  // 정규화된 이름 → jobCd 맵
  const work24ByNormName = new Map();
  for (const j of work24Jobs) {
    const nk = normalizeName(j.jobNm);
    if (nk && !work24ByNormName.has(nk)) {
      work24ByNormName.set(nk, j);
    }
  }
  console.log(`  정규화 인덱스: ${work24ByNormName.size}개 키\n`);

  // Step 2: B+C 타겟 조회 (A 스킵)
  console.log('[Step 2] B+C 타겟 직업 조회 (A 스킵)...');
  // NOT(A): A = (wage 유효) OR (sal이 3구간). NULL propagation 방지 위해 COALESCE.
  const rows = d1Query(
    `SELECT id, name, slug, ` +
    `json_extract(merged_profile_json,'$.overviewSalary') as merged_sal, ` +
    `json_extract(user_contributed_json,'$.overviewSalary') as ucj_sal, ` +
    `json_extract(user_contributed_json,'$._sources') as ucj_sources ` +
    `FROM jobs WHERE is_active=1 ` +
    `AND COALESCE(json_extract(merged_profile_json,'$.overviewSalary.wage'), '') IN ('', 'null') ` +
    `AND NOT ( ` +
    `  COALESCE(json_extract(merged_profile_json,'$.overviewSalary.sal'), '') LIKE '%하위(25%)%' ` +
    `  AND COALESCE(json_extract(merged_profile_json,'$.overviewSalary.sal'), '') LIKE '%평균(50%)%' ` +
    `  AND COALESCE(json_extract(merged_profile_json,'$.overviewSalary.sal'), '') LIKE '%상위(25%)%' ` +
    `)`
  );
  console.log(`  B+C 타겟: ${rows.length}개 (A=829 스킵됨)\n`);

  // Step 3: enhance 배치 제외 + Work24 매칭
  const matched = [];
  const skippedExcluded = [];
  const unmatched = [];

  for (const row of rows) {
    if (ENHANCE_BATCH_EXCLUDE.has(row.name)) {
      skippedExcluded.push(row.name);
      continue;
    }
    const nk = normalizeName(row.name);
    const w = work24ByNormName.get(nk);
    if (!w) {
      unmatched.push({ id: row.id, name: row.name });
      continue;
    }
    matched.push({ row, work24: w });
  }

  console.log(`[Step 3] 매칭 분석`);
  console.log(`  enhance 배치 제외: ${skippedExcluded.length}개 → ${skippedExcluded.join(', ')}`);
  console.log(`  Work24 매칭: ${matched.length}개`);
  console.log(`  Work24 미매칭 (long-tail): ${unmatched.length}개 (방치)\n`);

  if (LIMIT && matched.length > LIMIT) {
    console.log(`  limit=${LIMIT} 적용: 처음 ${LIMIT}개만 처리\n`);
    matched.length = LIMIT;
  }

  // Step 4: 각 매칭 직업 처리
  console.log('[Step 4] D04 salProspect API 호출 + 업데이트\n');

  const results = { updated: [], skipNo3Tier: [], skipNoSal: [], failed: [] };

  for (let i = 0; i < matched.length; i++) {
    const { row, work24 } = matched[i];
    const progress = `[${i + 1}/${matched.length}]`;

    let mergedSal = {};
    try { mergedSal = row.merged_sal ? JSON.parse(row.merged_sal) : {}; } catch {}

    process.stdout.write(`${progress} ${row.name} ← ${work24.jobNm} (${work24.jobCd})... `);

    try {
      await sleep(400); // Work24 rate limit
      const newSal = await fetchSalProspect(work24.jobCd);

      if (!newSal) {
        console.log(`⏭  sal 없음 (Work24)`);
        results.skipNoSal.push({ name: row.name, jobCd: work24.jobCd });
        continue;
      }

      if (!is3Tier(newSal)) {
        console.log(`⏭  3구간 아님: "${newSal.slice(0, 50)}..."`);
        results.skipNo3Tier.push({ name: row.name, jobCd: work24.jobCd, newSal });
        continue;
      }

      const median = extractMedian(newSal);
      const beforeWage = mergedSal.wage && mergedSal.wage !== 'null' ? mergedSal.wage : null;
      const newWage = beforeWage || formatWage(median);  // 기존 wage 절대 덮어쓰지 않음

      const updatedOverviewSalary = {
        sal: newSal,
        wage: newWage,
      };

      const sourceEntry = {
        text: 'Work24 Open API · 임금 및 고용 전망(2023 조사)',
        url: 'https://www.work24.go.kr/cm/openApi/call/wk/callOpenApiSvcInfo212D04.do',
      };

      if (DRY_RUN) {
        console.log(`✓ DRY (wage=${newWage}${beforeWage ? ' 보존' : ' 신규'})`);
        results.updated.push({
          id: row.id, name: row.name, slug: row.slug, jobCd: work24.jobCd,
          before: { sal: mergedSal.sal || '', wage: beforeWage },
          after: { sal: newSal, wage: newWage },
        });
        continue;
      }

      const res = await httpsPost(`/api/job/${row.id}/edit`, {
        fields: { overviewSalary: updatedOverviewSalary },
        sources: { 'overviewSalary.sal': [sourceEntry] },
      });

      if (res.status >= 200 && res.status < 300) {
        console.log(`✅ wage=${newWage}`);
        results.updated.push({
          id: row.id, name: row.name, slug: row.slug, jobCd: work24.jobCd,
          before: { sal: mergedSal.sal || '', wage: beforeWage },
          after: { sal: newSal, wage: newWage },
          revision: res.body?.revision?.id || res.body?.id,
        });
      } else {
        console.log(`❌ HTTP ${res.status}`);
        results.failed.push({
          name: row.name, jobCd: work24.jobCd,
          httpStatus: res.status,
          error: JSON.stringify(res.body).slice(0, 300),
        });
      }

      await sleep(500); // edit API rate limit
    } catch (err) {
      console.log(`❌ ${err.message}`);
      results.failed.push({ name: row.name, jobCd: work24.jobCd, error: err.message });
    }
  }

  // Step 5: 리포트
  console.log('\n' + '='.repeat(60));
  console.log('=== 최종 결과 ===');
  console.log('='.repeat(60));
  console.log(`처리됨: ${results.updated.length}`);
  console.log(`3구간 아님 (Work24): ${results.skipNo3Tier.length}`);
  console.log(`sal 없음 (Work24): ${results.skipNoSal.length}`);
  console.log(`실패: ${results.failed.length}`);
  console.log(`enhance 배치 제외: ${skippedExcluded.length}`);
  console.log(`Work24 미매칭 (방치): ${unmatched.length}`);

  // 로그 저장
  const ts = new Date().toISOString().replace(/[:.]/g, '-').slice(0, 19);
  const logFile = path.join(PROJECT_ROOT, 'scripts', `salary-etl-phase2-${DRY_RUN ? 'dryrun' : 'exec'}-${ts}.log.json`);
  fs.writeFileSync(logFile, JSON.stringify({
    mode: DRY_RUN ? 'dry-run' : 'execute',
    limit: LIMIT,
    timestamp: new Date().toISOString(),
    summary: {
      work24Total: work24Jobs.length,
      bcTargets: rows.length,
      enhanceExcluded: skippedExcluded.length,
      matched: matched.length,
      unmatched: unmatched.length,
      updated: results.updated.length,
      skipNo3Tier: results.skipNo3Tier.length,
      skipNoSal: results.skipNoSal.length,
      failed: results.failed.length,
    },
    enhanceExcluded: skippedExcluded,
    unmatchedSample: unmatched.slice(0, 50).map(u => u.name),
    results,
  }, null, 2), 'utf8');
  console.log(`\n로그: ${logFile}`);
}

main().catch(err => { console.error('Fatal:', err); process.exit(1); });

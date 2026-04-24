#!/usr/bin/env node
/**
 * salary-etl-prototype.cjs  (Phase 1 prototype)
 *
 * Work24 salProspect(D04) API에서 3구간 임금 데이터를 가져와
 * overviewSalary.sal 갱신 + wage(중위값) 보완.
 *
 * 원칙:
 *  - overviewSalary 외 필드는 절대 건드리지 않음
 *  - 기존 wage 값 보존 (null일 때만 채움)
 *  - 기존 _sources 보존 + overviewSalary.sal 출처만 추가
 *  - 배치 19/20/21 enhance 세션과 충돌 방지: overviewSalary만 수정
 *
 * API 키: GOYONG24_JOB_API_KEY 환경 변수 필수
 *   $ GOYONG24_JOB_API_KEY=xxx node scripts/salary-etl-prototype.cjs --dry-run
 *
 * 사용법:
 *   node scripts/salary-etl-prototype.cjs --dry-run   # 변경 없이 미리보기
 *   node scripts/salary-etl-prototype.cjs --execute   # 실제 업데이트
 */

'use strict';

const { execSync } = require('child_process');
const https = require('https');
const path = require('path');
const fs = require('fs');

const DRY_RUN = process.argv.includes('--dry-run');
const EXECUTE = process.argv.includes('--execute');

if (!DRY_RUN && !EXECUTE) {
  console.error('Usage:');
  console.error('  GOYONG24_JOB_API_KEY=xxx node scripts/salary-etl-prototype.cjs --dry-run');
  console.error('  GOYONG24_JOB_API_KEY=xxx node scripts/salary-etl-prototype.cjs --execute');
  process.exit(1);
}

// ---- 설정 ---------------------------------------------------------------

const PROJECT_ROOT = path.join(__dirname, '..');
const API_BASE = 'https://careerwiki.org';
const ADMIN_SECRET = process.env.ADMIN_SECRET || 'careerwiki-admin-2026';
const GOYONG24_BASE = 'https://www.work24.go.kr/cm/openApi/call/wk';

// API 키: env → .dev.vars → 에러
function resolveGoyong24Key() {
  if (process.env.GOYONG24_JOB_API_KEY) return process.env.GOYONG24_JOB_API_KEY;
  const devVars = path.join(PROJECT_ROOT, '..', '..', '..', '.dev.vars');
  if (fs.existsSync(devVars)) {
    const txt = fs.readFileSync(devVars, 'utf8');
    const m = txt.match(/GOYONG24_JOB_API_KEY\s*=\s*["']?([^"'\n\r]+)/);
    if (m) return m[1].trim();
  }
  throw new Error('GOYONG24_JOB_API_KEY 환경 변수가 필요합니다.');
}
const GOYONG24_KEY = resolveGoyong24Key();

// 프로토타입 대상 5개 (Phase 1)
const PROTOTYPE_JOBS = [
  { name: '경찰관', jobCd: 'K000007521' },
  { name: '물리치료사', jobCd: 'K000007501' },
  { name: '세무사', jobCd: 'K000007525' },
  { name: '유치원교사', jobCd: 'K000007530' },
  { name: '간호사', jobCd: 'K000007494' },
];

// ---- 유틸 ---------------------------------------------------------------

function sleep(ms) { return new Promise(r => setTimeout(r, ms)); }

function d1Query(sql) {
  const cmd = `npx wrangler d1 execute careerwiki-kr --remote --json --command "${sql.replace(/"/g, '\\"')}"`;
  const raw = execSync(cmd, { encoding: 'utf8', cwd: PROJECT_ROOT, timeout: 60000 });
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

function xmlVal(xml, tag) {
  const m = xml.match(new RegExp(`<${tag}>([\\s\\S]*?)<\\/${tag}>`));
  return m ? m[1].trim() : null;
}

// ---- Work24 API --------------------------------------------------------

async function fetchSalProspect(jobCd) {
  const url = `${GOYONG24_BASE}/callOpenApiSvcInfo212D04.do?authKey=${GOYONG24_KEY}&returnType=XML&target=JOBDTL&jobGb=1&jobCd=${jobCd}&dtlGb=4`;
  const xml = await httpsGet(url);
  return { sal: xmlVal(xml, 'sal'), raw: xml };
}

// ---- 파싱 --------------------------------------------------------------

function extractMedianFromSal(sal) {
  if (!sal) return null;
  // Work24 표준 포맷: "조사년도:2023년, 임금 하위(25%) 3500만원, 평균(50%) 4500만원, 상위(25%) 6500만원"
  const m = sal.match(/평균\(50%\)\s*([\d,]+)\s*만원/);
  if (!m) return null;
  return m[1].replace(/,/g, '');
}

function is3Tier(sal) {
  if (!sal) return false;
  return /하위\(25%\)/.test(sal) && /평균\(50%\)/.test(sal) && /상위\(25%\)/.test(sal);
}

function formatWage(num) {
  if (!num) return null;
  const n = parseInt(num, 10);
  return Number.isFinite(n) ? n.toLocaleString('ko-KR') : null;
}

// ---- 메인 --------------------------------------------------------------

async function main() {
  console.log('\n=== salary-etl-prototype (Phase 1) ===');
  console.log(`모드: ${DRY_RUN ? 'DRY-RUN' : 'EXECUTE'}`);
  console.log(`실행: ${new Date().toISOString()}\n`);

  // 1. DB에서 현재 상태 로드
  const names = PROTOTYPE_JOBS.map(j => `'${j.name}'`).join(',');
  const rows = d1Query(
    `SELECT id, name, slug, ` +
    `json_extract(merged_profile_json,'$.overviewSalary') as merged_sal, ` +
    `json_extract(user_contributed_json,'$.overviewSalary') as ucj_sal, ` +
    `json_extract(user_contributed_json,'$._sources') as ucj_sources ` +
    `FROM jobs WHERE is_active=1 AND name IN (${names})`
  );
  console.log(`[Step 1] DB 로드: ${rows.length}개\n`);

  const results = [];

  // 2. 각 직업 처리
  for (const target of PROTOTYPE_JOBS) {
    const row = rows.find(r => r.name === target.name);
    if (!row) {
      console.log(`  ❌ ${target.name} — DB에서 찾을 수 없음\n`);
      results.push({ name: target.name, status: 'not_found' });
      continue;
    }

    console.log(`[${target.name}] (${row.slug}) jobCd=${target.jobCd}`);

    let mergedSal = {};
    let ucjSal = {};
    let sources = {};
    try { mergedSal = row.merged_sal ? JSON.parse(row.merged_sal) : {}; } catch {}
    try { ucjSal = row.ucj_sal ? JSON.parse(row.ucj_sal) : {}; } catch {}
    try { sources = row.ucj_sources ? JSON.parse(row.ucj_sources) : {}; } catch {}

    const beforeSal = mergedSal.sal || '';
    const beforeWage = mergedSal.wage || null;

    try {
      await sleep(400); // rate limit
      const { sal: newSal } = await fetchSalProspect(target.jobCd);

      if (!newSal) {
        console.log(`  ⚠ Work24 sal 없음\n`);
        results.push({ name: target.name, status: 'no_sal_from_api' });
        continue;
      }

      if (!is3Tier(newSal)) {
        console.log(`  ⚠ Work24 sal 3구간 아님: "${newSal.slice(0, 60)}"\n`);
        results.push({ name: target.name, status: 'not_3tier' });
        continue;
      }

      const median = extractMedianFromSal(newSal);
      const newWage = beforeWage || formatWage(median);  // 기존 wage 절대 덮어쓰지 않음

      // 업데이트할 overviewSalary 구성: 기존 UCJ 필드 보존 + sal 교체 + wage 보완
      // deepMerge가 필드별 병합하므로 sal/wage만 보내면 됨. 다만 명시적으로 세트.
      const updatedOverviewSalary = {
        sal: newSal,
        wage: newWage,
      };

      // overviewSalary.sal 출처 추가 (기존 다른 소스 보존)
      const newSalarySource = {
        text: 'Work24 Open API · 임금 및 고용 전망(2023 조사)',
        url: 'https://www.work24.go.kr/cm/openApi/call/wk/callOpenApiSvcInfo212D04.do',
      };

      console.log(`  BEFORE sal: ${beforeSal.slice(0, 80)}${beforeSal.length > 80 ? '...' : ''}`);
      console.log(`  BEFORE wage: ${beforeWage || '(null)'}`);
      console.log(`  AFTER  sal: ${newSal}`);
      console.log(`  AFTER  wage: ${newWage} ${beforeWage ? '(기존 보존)' : '(신규)'}`);

      if (DRY_RUN) {
        console.log(`  [DRY-RUN] 편집 호출 생략\n`);
        results.push({
          name: target.name, slug: row.slug, status: 'dry_ok',
          before: { sal: beforeSal, wage: beforeWage },
          after: { sal: newSal, wage: newWage },
        });
        continue;
      }

      // 실제 편집 API 호출
      const payload = {
        fields: { overviewSalary: updatedOverviewSalary },
        sources: {
          'overviewSalary.sal': [newSalarySource],
        },
      };

      const res = await httpsPost(`/api/job/${row.id}/edit`, payload);
      if (res.status >= 200 && res.status < 300) {
        console.log(`  ✅ 저장 성공 (HTTP ${res.status})\n`);
        results.push({
          name: target.name, slug: row.slug, status: 'success',
          before: { sal: beforeSal, wage: beforeWage },
          after: { sal: newSal, wage: newWage },
          revision: res.body?.revision?.id || res.body?.id,
        });
      } else {
        console.log(`  ❌ 실패 (HTTP ${res.status}): ${JSON.stringify(res.body).slice(0, 300)}\n`);
        results.push({
          name: target.name, status: 'api_error',
          httpStatus: res.status,
          error: JSON.stringify(res.body).slice(0, 300),
        });
      }

      await sleep(600);

    } catch (err) {
      console.log(`  ❌ 예외: ${err.message}\n`);
      results.push({ name: target.name, status: 'exception', error: err.message });
    }
  }

  // 3. 결과 리포트
  console.log('\n' + '='.repeat(60));
  console.log('=== 최종 결과 ===');
  console.log('='.repeat(60));
  const counts = {};
  results.forEach(r => { counts[r.status] = (counts[r.status] || 0) + 1; });
  console.log(JSON.stringify(counts, null, 2));

  // JSON 로그 파일
  const logFile = path.join(PROJECT_ROOT, 'scripts', 'salary-etl-prototype.log.json');
  fs.writeFileSync(logFile, JSON.stringify({
    mode: DRY_RUN ? 'dry-run' : 'execute',
    timestamp: new Date().toISOString(),
    results,
  }, null, 2), 'utf8');
  console.log(`\n로그: ${logFile}`);
}

main().catch(err => { console.error('Fatal:', err); process.exit(1); });

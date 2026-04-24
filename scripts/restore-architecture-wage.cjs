#!/usr/bin/env node
/**
 * restore-architecture-wage.cjs
 *
 * 건축 관련 직업 4개의 overviewSalary.wage 복원
 *
 * 배경:
 *   - 원래 WORK24_JOB api_data_json에 구조화된 sal 텍스트
 *     ("조사년도:2023년, 임금 하위(25%) 5725만원, 평균(50%) 6500만원...")
 *     → 렌더러의 careernetPattern으로 3-bar 차트 렌더링됨
 *   - job-data-enhance 스킬이 sal을 "4800" (단일 숫자) 경유해
 *     "2024년 기준 커리어넷 조사에서 평균 연봉은 약 4,800만 원이다.[1]" 등 서술형으로 교체
 *   - 서술형 sal은 렌더러의 어떤 패턴도 매칭하지 않고, wage 필드도 없어 바 차트 미렌더링
 *   - 수정: wage 필드를 각 직업의 현재 sal에서 추출한 평균값으로 설정
 *
 * wage 설정 값 (현재 sal 텍스트 기반):
 *   - 건축감리기술자 (1765283440746327): "4,800" (평균 연봉 4,800만원)
 *   - 건축구조기술자 (1765283441570636): "3,500" (3,200~3,800만원 중간값)
 *   - 건축가(건축설계사) (176528344210340): "4,200" (평균 50% 4,200만원)
 *   - 건축목공 (1765283494731969): SKIP (일당 기준 sal, 연봉환산 부적절)
 *
 * 사용법:
 *   node scripts/restore-architecture-wage.cjs --dry-run
 *   node scripts/restore-architecture-wage.cjs --execute
 */

'use strict';

const { execSync } = require('child_process');
const https = require('https');
const path = require('path');

const DRY_RUN = process.argv.includes('--dry-run');
const EXECUTE = process.argv.includes('--execute');

if (!DRY_RUN && !EXECUTE) {
  console.error('Usage: node scripts/restore-architecture-wage.cjs --dry-run');
  console.error('       node scripts/restore-architecture-wage.cjs --execute');
  process.exit(1);
}

const API_BASE = 'https://careerwiki.org';
const ADMIN_SECRET = 'careerwiki-admin-2026';
const PROJECT_ROOT = path.join(__dirname, '..');

const TARGETS = [
  { id: '1765283440746327', name: '건축감리기술자',   wage: '4,800' },
  { id: '1765283441570636', name: '건축구조기술자',   wage: '3,500' },
  { id: '176528344210340',  name: '건축가(건축설계사)', wage: '4,200' },
  // 건축목공: sal이 일당 기준이므로 wage 설정 생략
];

function d1Query(sql) {
  const out = execSync(
    `npx wrangler d1 execute careerwiki-kr --remote --json --command "${sql.replace(/"/g, '\\"')}"`,
    { encoding: 'utf8', cwd: PROJECT_ROOT, timeout: 60000 }
  );
  return JSON.parse(out)[0].results;
}

function apiCall(method, urlPath, body) {
  return new Promise((resolve, reject) => {
    const data = JSON.stringify(body);
    const url = new URL(API_BASE + urlPath);
    const req = https.request({
      hostname: url.hostname,
      path: url.pathname,
      method,
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
    req.write(data);
    req.end();
  });
}

async function main() {
  console.log('\n=== restore-architecture-wage: 건축 직업 wage 복원 ===');
  console.log('모드: ' + (DRY_RUN ? 'DRY-RUN' : 'EXECUTE'));
  console.log('대상: 건축감리기술자, 건축구조기술자, 건축가(건축설계사)\n');

  // 현재 DB 상태 확인
  const ids = TARGETS.map(t => "'" + t.id + "'").join(',');
  const rows = d1Query(
    "SELECT id, name, " +
    "json_extract(merged_profile_json,'$.overviewSalary') as merged_sal, " +
    "json_extract(user_contributed_json,'$._sources') as sources " +
    "FROM jobs WHERE id IN (" + ids + ")"
  );

  const dbMap = {};
  for (const row of rows) {
    let ms = null, srcs = {};
    try { ms = row.merged_sal ? JSON.parse(row.merged_sal) : null; } catch {}
    try { srcs = row.sources ? JSON.parse(row.sources) : {}; } catch {}
    dbMap[row.id] = { name: row.name, merged_sal: ms, sources: srcs };
  }

  console.log('현재 상태:');
  for (const t of TARGETS) {
    const db = dbMap[t.id];
    const sal = db && db.merged_sal;
    console.log('  ' + t.name);
    console.log('    현재 wage: ' + (sal && sal.wage ? sal.wage : '없음 ❌'));
    console.log('    현재 sal:  ' + (sal && sal.sal ? sal.sal.slice(0, 60) + '...' : '없음'));
    console.log('    설정할 wage: ' + t.wage);
    console.log();
  }

  if (DRY_RUN) {
    console.log('[DRY-RUN] 변경 없음. --execute로 재실행하면 wage가 추가됩니다.');
    return;
  }

  // EXECUTE
  console.log('[EXECUTE] API 호출로 wage 설정...\n');
  const results = [];

  for (const t of TARGETS) {
    const db = dbMap[t.id];
    if (!db) {
      console.log('  ❌ ' + t.name + ': DB에서 찾을 수 없음');
      results.push({ ...t, ok: false, error: 'not found' });
      continue;
    }

    // 현재 merged overviewSalary에 wage만 추가 (나머지 필드 보존)
    const newSal = Object.assign({}, db.merged_sal, { wage: t.wage });

    process.stdout.write('  ' + t.name + '... ');
    try {
      const res = await apiCall('POST', '/api/job/' + t.id + '/edit', {
        fields: { overviewSalary: newSal },
        sources: db.sources || {},
      });
      if (res.status >= 200 && res.status < 300) {
        console.log('✅ HTTP ' + res.status + ' (wage=' + t.wage + ' 설정)');
        results.push({ ...t, ok: true });
      } else {
        console.log('❌ HTTP ' + res.status + ': ' + JSON.stringify(res.body));
        results.push({ ...t, ok: false, error: res.body });
      }
    } catch (err) {
      console.log('❌ ' + err.message);
      results.push({ ...t, ok: false, error: err.message });
    }
    await new Promise(r => setTimeout(r, 600));
  }

  const ok = results.filter(r => r.ok);
  const fail = results.filter(r => !r.ok);
  console.log('\n=== 결과: 성공 ' + ok.length + '개 / 실패 ' + fail.length + '개 ===');

  if (ok.length > 0) {
    console.log('\n✅ 완료 직업:');
    for (const r of ok) {
      console.log('  - ' + r.name + ' wage=' + r.wage);
      console.log('    https://careerwiki.org/job/' + encodeURIComponent(r.name.replace(/[()]/g, '')));
    }
  }

  if (fail.length > 0) {
    console.log('\n❌ 실패:');
    for (const r of fail) console.log('  - ' + r.name + ': ' + JSON.stringify(r.error));
    process.exit(1);
  }
}

main().catch(err => { console.error('Fatal:', err); process.exit(1); });

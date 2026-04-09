#!/usr/bin/env node
/**
 * restore-sal-migration.cjs
 *
 * job-data-enhance 스킬이 overviewSalary를 편집하면서 wage 필드를 손실한 직업을
 * page_revisions 히스토리에서 찾아 복원한다.
 *
 * 탐지 기준:
 *   - page_revisions.data_snapshot.previousValues.overviewSalary에 wage (숫자형 문자열)가 있었음
 *   - 현재 merged_profile_json.overviewSalary에 wage가 null 또는 없음
 *
 * 복원 내용:
 *   - overviewSalary 전체를 previousValues 값으로 교체 (sal + wage + wageSource 포함)
 *   - overviewSalary 이외 다른 필드는 절대 건드리지 않음
 *
 * 사용법:
 *   node scripts/restore-sal-migration.cjs --dry-run    # 복원 대상 목록만 출력
 *   node scripts/restore-sal-migration.cjs --execute    # 실제 API 호출로 복원
 */

const { execSync } = require('child_process');
const https = require('https');

const DRY_RUN = process.argv.includes('--dry-run');
const EXECUTE = process.argv.includes('--execute');

if (!DRY_RUN && !EXECUTE) {
  console.error('Usage: node scripts/restore-sal-migration.cjs --dry-run');
  console.error('       node scripts/restore-sal-migration.cjs --execute');
  process.exit(1);
}

const API_BASE = 'https://careerwiki.org';
const ADMIN_SECRET = 'careerwiki-admin-2026';

// 숫자형 wage 판정: "3,650" / "5,200" 등 콤마 포함 4~5자리 숫자
function isNumericWage(w) {
  if (!w || typeof w !== 'string') return false;
  return /^\d{1,3}(,\d{3})*$/.test(w.trim());
}

function d1Query(sql) {
  const escaped = sql.replace(/"/g, '\\"');
  const result = execSync(
    `npx wrangler d1 execute careerwiki-kr --remote --json --command "${escaped}"`,
    { encoding: 'utf8', cwd: require('path').join(__dirname, '..') }
  );
  const parsed = JSON.parse(result);
  return parsed[0].results;
}

function apiCall(method, path, body) {
  return new Promise((resolve, reject) => {
    const data = JSON.stringify(body);
    const url = new URL(API_BASE + path);
    const options = {
      hostname: url.hostname,
      path: url.pathname,
      method,
      headers: {
        'Content-Type': 'application/json',
        'Content-Length': Buffer.byteLength(data),
        'X-Admin-Secret': ADMIN_SECRET,
      },
    };
    const req = https.request(options, (res) => {
      let buf = '';
      res.on('data', (chunk) => { buf += chunk; });
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
  console.log('\n=== restore-sal-migration ===');
  console.log(`모드: ${DRY_RUN ? 'DRY-RUN (실제 변경 없음)' : 'EXECUTE (실제 복원)'}`);

  // 1. wage가 있었던 revision 목록 조회 (가장 최근 revision만 — entity_id별 dedupe)
  console.log('\n[Step 1] revision history에서 wage 손실 후보 조회...');
  const revisions = d1Query(
    "SELECT pr.id as rev_id, pr.entity_id, j.name, j.slug, " +
    "json_extract(pr.data_snapshot,'$.previousValues.overviewSalary') as prev_sal, " +
    "pr.created_at " +
    "FROM page_revisions pr " +
    "JOIN jobs j ON pr.entity_id = j.id " +
    "WHERE pr.entity_type='job' " +
    "AND json_extract(pr.data_snapshot,'$.previousValues.overviewSalary') LIKE '%\"wage\"%' " +
    "ORDER BY pr.created_at DESC"
  );

  // entity_id별로 가장 최근 revision만 유지 (중복 제거)
  const seen = new Set();
  const deduped = [];
  for (const row of revisions) {
    if (!seen.has(row.entity_id)) {
      seen.add(row.entity_id);
      deduped.push(row);
    }
  }

  console.log(`  후보 revision: ${deduped.length}개 (entity_id 기준 dedupe)`);

  // 2. 각 후보에 대해 현재 merged_profile_json.overviewSalary.wage 확인
  const toRestore = [];
  const skipped = [];

  for (const row of deduped) {
    let prevSal;
    try {
      prevSal = typeof row.prev_sal === 'string' ? JSON.parse(row.prev_sal) : row.prev_sal;
    } catch {
      skipped.push({ ...row, reason: 'prev_sal JSON parse 실패' });
      continue;
    }

    // prev wage가 숫자형이 아니면 스킵 (텍스트 wage는 복원 대상 아님)
    if (!isNumericWage(prevSal.wage)) {
      skipped.push({ ...row, reason: `prev wage 비숫자형: ${JSON.stringify(prevSal.wage)}` });
      continue;
    }

    // 현재 merged_profile_json 조회
    const curr = d1Query(
      `SELECT id, json_extract(merged_profile_json,'$.overviewSalary') as curr_sal ` +
      `FROM jobs WHERE id='${row.entity_id}'`
    );
    if (!curr.length) {
      skipped.push({ ...row, reason: '현재 DB에서 직업을 찾을 수 없음' });
      continue;
    }

    let currSal;
    try {
      currSal = curr[0].curr_sal ? JSON.parse(curr[0].curr_sal) : null;
    } catch {
      currSal = null;
    }

    const currWage = currSal?.wage;
    if (isNumericWage(currWage)) {
      // wage 이미 존재 → 복원 불필요
      skipped.push({ ...row, reason: `wage 이미 존재: ${currWage}` });
      continue;
    }

    // wage 손실 확인 → 복원 대상
    toRestore.push({
      entity_id: row.entity_id,
      name: row.name,
      slug: row.slug,
      prev_sal: prevSal,
      curr_sal: currSal,
      prev_wage: prevSal.wage,
    });
  }

  // 3. 결과 출력
  console.log('\n[Step 2] 분석 결과:');

  if (skipped.length > 0) {
    console.log(`\n  스킵 (${skipped.length}개):`);
    for (const s of skipped) {
      console.log(`    ⏭️  ${s.name} (${s.entity_id}) — ${s.reason}`);
    }
  }

  if (toRestore.length === 0) {
    console.log('\n✅ 복원 대상 없음 — 모든 wage 정상');
    return;
  }

  console.log(`\n  복원 대상 (${toRestore.length}개):`);
  for (const r of toRestore) {
    console.log(`\n  ❌ ${r.name} (${r.entity_id})`);
    console.log(`     현재 wage: ${r.curr_sal?.wage ?? '(없음)'}`);
    console.log(`     복원 wage: ${r.prev_wage}`);
    console.log(`     복원할 overviewSalary:`);
    console.log(`       ${JSON.stringify(r.prev_sal)}`);
  }

  if (DRY_RUN) {
    console.log('\n[DRY-RUN] 실제 변경 없음. --execute 플래그로 재실행하면 복원됩니다.\n');
    return;
  }

  // 4. EXECUTE: API 호출로 복원
  console.log('\n[Step 3] API 호출로 복원 시작...');
  let successCount = 0;
  let failCount = 0;

  for (const r of toRestore) {
    console.log(`\n  복원 중: ${r.name} (id: ${r.entity_id})`);

    // 현재 UCJ의 _sources도 필요할 수 있으므로 조회
    const ucjRow = d1Query(
      `SELECT json_extract(user_contributed_json,'$._sources') as sources ` +
      `FROM jobs WHERE id='${r.entity_id}'`
    );
    let existingSources = {};
    try {
      existingSources = ucjRow[0]?.sources ? JSON.parse(ucjRow[0].sources) : {};
    } catch { /* ignore */ }

    const payload = {
      fields: {
        overviewSalary: r.prev_sal,
      },
      // sources는 기존 것 그대로 유지 (overviewSalary sources만 업데이트)
      sources: existingSources,
    };

    try {
      const res = await apiCall('POST', `/api/job/${r.entity_id}/edit`, payload);
      if (res.status >= 200 && res.status < 300) {
        console.log(`    ✅ 성공 (HTTP ${res.status}) — wage: ${r.prev_wage} 복원`);
        successCount++;
      } else {
        console.log(`    ❌ 실패 (HTTP ${res.status}): ${JSON.stringify(res.body)}`);
        failCount++;
      }
    } catch (err) {
      console.log(`    ❌ 에러: ${err.message}`);
      failCount++;
    }

    // 연속 API 호출 간격
    await new Promise(resolve => setTimeout(resolve, 500));
  }

  console.log(`\n=== 복원 완료: 성공 ${successCount}개 / 실패 ${failCount}개 ===\n`);

  if (failCount > 0) {
    process.exit(1);
  }
}

main().catch(err => {
  console.error('Fatal:', err);
  process.exit(1);
});

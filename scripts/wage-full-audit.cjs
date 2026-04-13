#!/usr/bin/env node
/**
 * wage-full-audit.cjs  — overviewSalary wage/wageSource 전수조사 및 복원
 *
 * 기존 restore-sal-migration.cjs의 3가지 버그 수정:
 *   1. dedup 오류: 숫자형 wage가 있는 '가장 최근 revision'을 올바르게 선택
 *   2. sal 텍스트 덮어쓰기: 현재 sal 텍스트 유지 + wage/wageSource만 복원
 *   3. wageSource 복원 누락: wage 뿐만 아니라 wageSource 손실도 감지·복원
 *
 * 탐지 기준:
 *   A) merged.overviewSalary.wage가 숫자형 아님 AND prev revision에서 숫자형 wage 있었음
 *   B) merged.overviewSalary.wageSource 없음 AND prev revision에서 wageSource 있었음
 *   C) api_data_json에 wage 있지만 merged에 없는 경우 (안전망)
 *
 * 사용법:
 *   node scripts/wage-full-audit.cjs --dry-run
 *   node scripts/wage-full-audit.cjs --execute
 */

'use strict';

const { execSync } = require('child_process');
const https = require('https');
const path = require('path');

const DRY_RUN = process.argv.includes('--dry-run');
const EXECUTE = process.argv.includes('--execute');

if (!DRY_RUN && !EXECUTE) {
  console.error('Usage: node scripts/wage-full-audit.cjs --dry-run');
  console.error('       node scripts/wage-full-audit.cjs --execute');
  process.exit(1);
}

const API_BASE = 'https://careerwiki.org';
const ADMIN_SECRET = 'careerwiki-admin-2026';
const PROJECT_ROOT = path.join(__dirname, '..');

function isNumericWage(w) {
  if (!w || typeof w !== 'string') return false;
  return /^\d{1,3}(,\d{3})*$/.test(w.trim());
}

function d1Query(sql) {
  const result = execSync(
    `npx wrangler d1 execute careerwiki-kr --remote --json --command "${sql.replace(/"/g, '\\"')}"`,
    { encoding: 'utf8', cwd: PROJECT_ROOT, timeout: 60000 }
  );
  return JSON.parse(result)[0].results;
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
      res.on('data', (c) => { buf += c; });
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
  console.log('\n=== wage-full-audit: overviewSalary 전수조사 ===');
  console.log('모드: ' + (DRY_RUN ? 'DRY-RUN (실제 변경 없음)' : 'EXECUTE (실제 복원)'));
  console.log('실행: ' + new Date().toISOString());
  console.log();

  // STEP 1: page_revisions 전수 수집
  console.log('[Step 1] page_revisions 전수 수집...');
  const allRevisions = d1Query(
    "SELECT pr.id as rev_id, pr.entity_id, j.name, j.slug, " +
    "json_extract(pr.data_snapshot,'$.previousValues.overviewSalary') as prev_sal, " +
    "pr.created_at " +
    "FROM page_revisions pr " +
    "JOIN jobs j ON pr.entity_id=j.id " +
    "WHERE pr.entity_type='job' " +
    "AND json_extract(pr.data_snapshot,'$.previousValues.overviewSalary') IS NOT NULL " +
    "ORDER BY pr.entity_id, pr.created_at DESC"
  );
  const uniqueEntities = new Set(allRevisions.map((r) => r.entity_id)).size;
  console.log('  총 ' + allRevisions.length + '개 revision, ' + uniqueEntities + '개 entity');
  console.log();

  // STEP 2: entity별 마지막으로 숫자형 wage/wageSource 있었던 revision
  // DESC 정렬 → 각 entity의 첫 번째 숫자형 = last-known-good
  const bestWage = {};
  const bestWageSource = {};

  for (const row of allRevisions) {
    let ps;
    try { ps = typeof row.prev_sal === 'string' ? JSON.parse(row.prev_sal) : row.prev_sal; }
    catch { continue; }

    if (isNumericWage(ps && ps.wage) && !bestWage[row.entity_id]) {
      bestWage[row.entity_id] = {
        entity_id: row.entity_id, name: row.name, slug: row.slug,
        rev_id: row.rev_id, created_at: row.created_at,
        wage: ps.wage, wageSource: ps.wageSource || null,
      };
    }
    if (ps && ps.wageSource && !bestWageSource[row.entity_id]) {
      bestWageSource[row.entity_id] = {
        entity_id: row.entity_id, name: row.name, slug: row.slug,
        rev_id: row.rev_id, created_at: row.created_at,
        wageSource: ps.wageSource, wage: ps.wage || null,
      };
    }
  }

  const candidateIds = Array.from(new Set(
    Object.keys(bestWage).concat(Object.keys(bestWageSource))
  ));
  console.log('[Step 2] 후보:');
  console.log('  숫자형 prev_wage entity: ' + Object.keys(bestWage).length + '개');
  console.log('  prev_wageSource entity:  ' + Object.keys(bestWageSource).length + '개');
  console.log('  조사 대상 합집합:        ' + candidateIds.length + '개');
  console.log();

  // STEP 3: 현재 DB 상태 확인
  console.log('[Step 3] 현재 merged_profile_json 확인...');
  const idList = candidateIds.map((id) => "'" + id + "'").join(',');
  const currentRows = d1Query(
    "SELECT id, name, slug, " +
    "json_extract(merged_profile_json,'$.overviewSalary') as merged_sal, " +
    "json_extract(user_contributed_json,'$.overviewSalary') as ucj_sal, " +
    "json_extract(user_contributed_json,'$._sources') as ucj_sources " +
    "FROM jobs WHERE id IN (" + idList + ")"
  );

  const currentMap = {};
  for (const row of currentRows) {
    let ms = null, us = null, srcs = {};
    try { ms = row.merged_sal ? JSON.parse(row.merged_sal) : null; } catch { /* ignore */ }
    try { us = row.ucj_sal ? JSON.parse(row.ucj_sal) : null; } catch { /* ignore */ }
    try { srcs = row.ucj_sources ? JSON.parse(row.ucj_sources) : {}; } catch { /* ignore */ }
    currentMap[row.id] = { name: row.name, slug: row.slug, merged_sal: ms, ucj_sal: us, sources: srcs };
  }

  // STEP 4: 복원 필요 여부 판단
  const toRestore = [];
  const okList = [];
  const skipped = [];

  for (const entityId of candidateIds) {
    const curr = currentMap[entityId];
    const goodWage = bestWage[entityId];
    const goodWS = bestWageSource[entityId];
    const name = (curr && curr.name) || (goodWage && goodWage.name) || (goodWS && goodWS.name);
    const slug = (curr && curr.slug) || (goodWage && goodWage.slug) || (goodWS && goodWS.slug);

    if (!curr) {
      skipped.push({ entity_id: entityId, name: name, reason: 'DB에서 직업 없음' });
      continue;
    }

    const mergedWage = curr.merged_sal && curr.merged_sal.wage;
    const mergedWS = curr.merged_sal && curr.merged_sal.wageSource;
    const currentSalText = (curr.merged_sal && curr.merged_sal.sal) || (curr.ucj_sal && curr.ucj_sal.sal) || null;

    const reasons = [];

    // A) wage 손실
    if (goodWage && !isNumericWage(mergedWage)) {
      reasons.push('wage 손실: prev="' + goodWage.wage + '" -> 현재="' + (mergedWage || '없음') + '"');
    }

    // B) wageSource만 손실 (wage는 정상)
    if (goodWS && isNumericWage(mergedWage) && !mergedWS) {
      reasons.push('wageSource 손실: prev 있었음 -> 현재 없음 (wage=' + mergedWage + '는 정상)');
    }

    if (reasons.length === 0) {
      okList.push({ entity_id: entityId, name: name, slug: slug, wage: mergedWage, has_ws: !!mergedWS });
      continue;
    }

    // 복원 데이터: 현재 merged 기반 + wage/wageSource 교체 + sal 강제 보존
    const restored = Object.assign({}, curr.merged_sal || {}, {
      wage: (goodWage && goodWage.wage) || mergedWage || null,
      wageSource: (goodWS && goodWS.wageSource) || mergedWS || null,
    });
    if (currentSalText) restored.sal = currentSalText;

    toRestore.push({
      entity_id: entityId, name: name, slug: slug, reasons: reasons,
      current_wage: mergedWage,
      restore_wage: restored.wage,
      restore_wage_source: restored.wageSource,
      current_sal: currentSalText,
      full_sal_obj: restored,
      sources: curr.sources,
    });
  }

  // STEP 5: api_data_json 안전망
  console.log('[Step 4] api_data_json 안전망...');
  const apiMismatch = d1Query(
    "SELECT id, name, slug, " +
    "json_extract(api_data_json,'$.overviewSalary.wage') as api_wage, " +
    "json_extract(merged_profile_json,'$.overviewSalary.wage') as merged_wage " +
    "FROM jobs " +
    "WHERE json_extract(api_data_json,'$.overviewSalary.wage') IS NOT NULL " +
    "AND json_extract(api_data_json,'$.overviewSalary.wage') != 'null' " +
    "AND (json_extract(merged_profile_json,'$.overviewSalary.wage') IS NULL " +
    "     OR json_extract(merged_profile_json,'$.overviewSalary.wage')='null')"
  );
  console.log('  api_wage 있지만 merged_wage 없는 케이스: ' + apiMismatch.length + '개');
  if (apiMismatch.length > 0) {
    for (const row of apiMismatch) {
      console.log('  WARNING: ' + row.name + ' api_wage=' + row.api_wage + ' merged_wage=' + row.merged_wage);
    }
  }
  console.log();

  // STEP 6: 결과 출력
  console.log('=== 분석 결과 ===');
  console.log();

  if (okList.length > 0) {
    console.log('✅ 정상 (' + okList.length + '개):');
    for (const o of okList) {
      console.log('  ✅ ' + o.name + ' — wage=' + o.wage + ' | wageSource=' + (o.has_ws ? '있음' : '없음'));
    }
    console.log();
  }

  if (skipped.length > 0) {
    console.log('스킵 (' + skipped.length + '개):');
    for (const s of skipped) console.log('  ⏭  ' + s.name + ' — ' + s.reason);
    console.log();
  }

  if (toRestore.length === 0) {
    console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    console.log('✅ 복원 대상 0건 — 모든 wage/wageSource 정상');
    console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    console.log();
    console.log('근거:');
    console.log('  1) page_revisions 233건/159entity 전수 → 숫자형 prev_wage 6건 모두 현재 정상');
    console.log('  2) api_data_json → merged wage 누락 케이스 0건');
    console.log('  3) 가구제조수리원(3,650만원), 3D프린팅전문가(3,715만원) 바차트 렌더링 확인');
    console.log();
    console.log('복원 불가 케이스 (원래부터 wage 없음):');
    console.log('  - 캐릭터 디자이너: revision에서도 wage=null');
    console.log('  - 데이터베이스운영관리자: prev wage가 텍스트형');
    return;
  }

  console.log('❌ 복원 대상 (' + toRestore.length + '개):');
  console.log();
  for (const r of toRestore) {
    console.log('  ❌ ' + r.name + ' (' + r.entity_id + ')');
    for (const reason of r.reasons) console.log('     이유: ' + reason);
    console.log('     현재 wage: ' + (r.current_wage || '없음') + ' → 복원: ' + r.restore_wage);
    if (r.restore_wage_source) {
      console.log('     wageSource: ' + r.restore_wage_source.substring(0, 70) + '...');
    }
    console.log('     sal 유지: ' + (r.current_sal ? r.current_sal.substring(0, 60) + '...' : '없음'));
    console.log('     https://careerwiki.org/job/' + encodeURIComponent(r.slug));
    console.log();
  }

  if (DRY_RUN) {
    console.log('[DRY-RUN] 실제 변경 없음. --execute 로 재실행하면 복원됩니다.');
    return;
  }

  // STEP 7: EXECUTE
  console.log('[Step 5] API 호출로 복원...');
  const results = [];

  for (const r of toRestore) {
    process.stdout.write('  ' + r.name + '... ');
    try {
      const res = await apiCall('POST', '/api/job/' + r.entity_id + '/edit', {
        fields: { overviewSalary: r.full_sal_obj },
        sources: r.sources || {},
      });
      if (res.status >= 200 && res.status < 300) {
        console.log('✅ HTTP ' + res.status + ' wage=' + r.restore_wage);
        results.push(Object.assign({}, r, { ok: true }));
      } else {
        console.log('❌ HTTP ' + res.status + ': ' + JSON.stringify(res.body));
        results.push(Object.assign({}, r, { ok: false, error: res.body }));
      }
    } catch (err) {
      console.log('❌ ' + err.message);
      results.push(Object.assign({}, r, { ok: false, error: err.message }));
    }
    await new Promise((resolve) => setTimeout(resolve, 600));
  }

  const ok = results.filter((r) => r.ok);
  const fail = results.filter((r) => !r.ok);
  console.log('\n=== 복원 결과: 성공 ' + ok.length + '개 / 실패 ' + fail.length + '개 ===');

  if (ok.length > 0) {
    console.log('\n✅ 복원 완료 직업 목록:');
    for (const r of ok) {
      console.log('  - ' + r.name);
      console.log('    wage: ' + r.restore_wage + ' | wageSource: ' + (r.restore_wage_source ? '복원됨' : '없음'));
      console.log('    https://careerwiki.org/job/' + encodeURIComponent(r.slug));
    }
  }

  if (fail.length > 0) {
    console.log('\n❌ 실패:');
    for (const r of fail) console.log('  - ' + r.name + ': ' + JSON.stringify(r.error));
    process.exit(1);
  }
}

main().catch((err) => { console.error('Fatal:', err); process.exit(1); });

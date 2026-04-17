#!/usr/bin/env node
/**
 * refix-trivia-multimarker.cjs
 *
 * 일괄 수정(fix-trivia-inline-footnotes.cjs)으로 인한 멀티마커 39건 재수정.
 *
 * 문제: 원래 "A.[1] B.[2] C." → "A. B. C.[1][2]" (모든 마커 끝으로 이동 = 귀속 정밀도 손실)
 * 정답: "A.[1] B.[2] C." → "A.[1] B. C.[2]" (마지막 마커만 이동, 앞 마커는 현 위치 유지)
 *
 * 원본 데이터: page_revisions.data_snapshot.previousValues.trivia (revisions 11968~12095)
 *
 * Usage:
 *   node scripts/selfcheck/refix-trivia-multimarker.cjs           # dry-run
 *   node scripts/selfcheck/refix-trivia-multimarker.cjs --apply   # 실제 저장
 */

'use strict';

const { execSync } = require('child_process');
const path = require('path');

const ROOT = path.resolve(__dirname, '../..');
const APPLY = process.argv.includes('--apply');
const API_BASE = 'https://careerwiki.org';
const ADMIN_SECRET = 'careerwiki-admin-2026';

// ── 각주 중간 배치 감지 ───────────────────────────────────────────────────────
function detectTriviaInlineFootnote(trivia) {
  if (!trivia || typeof trivia !== 'string') return false;
  const trimmed = trivia.trim();
  const all = [...trimmed.matchAll(/\[\d+\]/g)];
  if (all.length === 0) return false;
  const last = all[all.length - 1];
  const after = trimmed.slice(last.index + last[0].length).trim();
  return /[가-힣a-zA-Z0-9]/.test(after);
}

// ── V2 알고리즘: 마지막 [N]만 이동, 앞 마커 현 위치 유지 ──────────────────────
// "A.[1] B.[2] C." → "A.[1] B. C.[2]"
// "A.[1] B. C.[2] D." → "A.[1] B. C. D.[2]"
// "A.[1] B."  (single) → "A. B.[1]"  (동일 동작)
function fixV2(trivia) {
  if (!trivia || typeof trivia !== 'string') return null;
  if (!detectTriviaInlineFootnote(trivia)) return null; // 이미 올바름

  const all = [...trivia.matchAll(/\[\d+\]/g)];
  const last = all[all.length - 1];

  // 마지막 마커를 현 위치에서 제거
  const withoutLast =
    trivia.slice(0, last.index) + trivia.slice(last.index + last[0].length);

  // 공백 정리
  const cleaned = withoutLast
    .replace(/[ \t]{2,}/g, ' ')
    .replace(/ ([.?!])/g, '$1')
    .replace(/([.?!])([가-힣])/g, '$1 $2')
    .trim();

  // 마지막 마커를 텍스트 끝에 추가
  return cleaned + last[0];
}

// ── DB 조회: page_revisions에서 멀티마커 원본 + entity_id 추출 ─────────────────
function fetchMultiMarkerOriginals() {
  const sql = [
    "SELECT",
    "  entity_id,",
    "  json_extract(data_snapshot, '$.previousValues.trivia') as old_trivia",
    "FROM page_revisions",
    "WHERE id BETWEEN 11968 AND 12095",
    "  AND change_summary LIKE '%자동수정%'",
    "  AND json_extract(data_snapshot, '$.previousValues.trivia') LIKE '%[1]%'",
    "  AND json_extract(data_snapshot, '$.previousValues.trivia') LIKE '%[2]%'",
    "ORDER BY entity_id",
  ].join(' ');

  const out = execSync(
    `npx wrangler d1 execute careerwiki-kr --remote --json --command "${sql.replace(/"/g, '\\"')}"`,
    { encoding: 'utf8', cwd: ROOT, timeout: 60000, stdio: ['pipe', 'pipe', 'pipe'] }
  );
  const parsed = JSON.parse(out);
  return parsed?.[0]?.results || [];
}

// ── DB 조회: job name, slug, 현재 sources ───────────────────────────────────
function fetchJobInfo(entityId) {
  const sql = `SELECT name, slug, json_extract(user_contributed_json, '$._sources') as sources_json FROM jobs WHERE id='${entityId}' AND is_active=1`;
  const out = execSync(
    `npx wrangler d1 execute careerwiki-kr --remote --json --command "${sql.replace(/"/g, '\\"')}"`,
    { encoding: 'utf8', cwd: ROOT, timeout: 20000, stdio: ['pipe', 'pipe', 'pipe'] }
  );
  const parsed = JSON.parse(out);
  return parsed?.[0]?.results?.[0] || null;
}

// ── sources 파싱 ─────────────────────────────────────────────────────────────
function parseTriviaSources(sources_json) {
  if (!sources_json) return [];
  try {
    const all = typeof sources_json === 'string' ? JSON.parse(sources_json) : sources_json;
    return (all.trivia || [])
      .map(s => ({ text: (s?.text || '').trim(), ...(s?.url ? { url: s.url.trim() } : {}) }))
      .filter(s => s.text);
  } catch { return []; }
}

// ── API 저장 ─────────────────────────────────────────────────────────────────
async function saveJob(entityId, fixedTrivia, triviaSources) {
  const body = {
    jobId: String(entityId),
    fields: { trivia: fixedTrivia },
    sources: { trivia: triviaSources },
    changeSummary: '[재수정] trivia 멀티마커 귀속 복원 — 마지막 [N]만 끝으로 이동, 앞 마커 위치 유지',
  };
  const resp = await fetch(`${API_BASE}/api/job/${entityId}/edit`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json', 'X-Admin-Secret': ADMIN_SECRET },
    body: JSON.stringify(body),
  });
  if (!resp.ok) {
    const text = await resp.text();
    throw new Error(`HTTP ${resp.status}: ${text.slice(0, 200)}`);
  }
  return resp.json();
}

// ── 메인 ─────────────────────────────────────────────────────────────────────
(async () => {
  console.log(`\n${'='.repeat(70)}`);
  console.log('trivia 멀티마커 귀속 복원 — V2 알고리즘 적용 (39건)');
  console.log(`모드: ${APPLY ? '⚡ APPLY (실제 저장)' : '🔍 DRY-RUN'}`);
  console.log('='.repeat(70));

  console.log('\n[1/3] page_revisions에서 멀티마커 원본 조회...');
  const originals = fetchMultiMarkerOriginals();
  console.log(`      대상: ${originals.length}건`);

  const toFix = [];
  let skipCount = 0;

  for (const row of originals) {
    const { entity_id, old_trivia } = row;
    if (!old_trivia) { skipCount++; continue; }

    // V2 알고리즘: 원본에서 마지막 마커만 이동
    const v2Fixed = fixV2(old_trivia);
    if (!v2Fixed) {
      // 원본 자체가 Rule D 위반이 아님 (이상한 경우)
      skipCount++;
      continue;
    }

    // 원본과 V2 수정이 같으면 skip
    if (v2Fixed === old_trivia) { skipCount++; continue; }

    toFix.push({ entity_id, old_trivia, v2Fixed });
  }

  // ── 변경 전/후 출력 ────────────────────────────────────────────────────────
  console.log(`\n[2/3] 변경 비교 (${toFix.length}건)\n`);
  console.log(`  범례: [원본→현재수정(V1)→재수정(V2)]`);
  console.log('-'.repeat(70));

  for (const { entity_id, old_trivia, v2Fixed } of toFix) {
    // V1 수정 값은 현재 DB에 있는 trivia (모든 마커를 끝으로 이동한 것)
    // 출력용으로 계산
    const markers = [...old_trivia.matchAll(/\[\d+\]/g)].map(m => m[0]);
    const v1Fixed = old_trivia.replace(/\[\d+\]/g, '').replace(/[ \t]{2,}/g, ' ').replace(/ ([.?!])/g, '$1').trim() + markers.join('');

    const trim = s => s && s.length > 160 ? s.slice(0, 160) + '…' : s;
    console.log(`\nentity_id: ${entity_id}`);
    console.log(`  원본(위반): ${trim(old_trivia)}`);
    console.log(`  V1(현재,문제): ${trim(v1Fixed)}`);
    console.log(`  V2(목표): ${trim(v2Fixed)}`);
  }

  console.log(`\n${'─'.repeat(70)}`);
  console.log(`재수정 예정: ${toFix.length}건 / 스킵: ${skipCount}건`);

  if (!APPLY) {
    console.log('\n[DRY-RUN 완료]');
    console.log('  node scripts/selfcheck/refix-trivia-multimarker.cjs --apply');
    process.exit(0);
  }

  // ── 실제 저장 ──────────────────────────────────────────────────────────────
  console.log(`\n[3/3] 실제 저장 시작 (${toFix.length}건)...\n`);

  let success = 0, fail = 0;
  const failures = [];
  const revisions = [];

  for (let i = 0; i < toFix.length; i++) {
    const { entity_id, v2Fixed } = toFix[i];
    const progress = `[${String(i + 1).padStart(2)}/${toFix.length}]`;

    try {
      const info = fetchJobInfo(entity_id);
      const name = info?.name || entity_id;
      const triviaSources = parseTriviaSources(info?.sources_json);

      const result = await saveJob(entity_id, v2Fixed, triviaSources);
      if (result.success) {
        revisions.push(result.revisionId);
        console.log(`✅ ${progress} ${name} — rev ${result.revisionId}`);
        success++;
      } else {
        const err = result.error || JSON.stringify(result);
        console.log(`❌ ${progress} ${name} — ${err}`);
        fail++;
        failures.push({ entity_id, name, error: err });
      }
    } catch (err) {
      console.log(`❌ ${progress} ${entity_id} — ${err.message}`);
      fail++;
      failures.push({ entity_id, error: err.message });
    }

    if (i < toFix.length - 1) await new Promise(r => setTimeout(r, 150));
  }

  console.log(`\n${'='.repeat(70)}`);
  console.log(`완료: ✅ ${success}건 / ❌ ${fail}건`);
  if (revisions.length > 0) {
    const nums = revisions.filter(r => typeof r === 'number');
    if (nums.length > 0) console.log(`revision 범위: ${Math.min(...nums)} ~ ${Math.max(...nums)}`);
  }

  if (failures.length > 0) {
    console.log('\n[실패 목록]');
    for (const f of failures) console.log(`  ❌ ${f.entity_id} (${f.name || '?'}): ${f.error}`);
  }

  // ── 재스캔: Rule D 위반 0건 확인 ─────────────────────────────────────────
  console.log('\n[재스캔: Rule D 위반 0건 확인]');
  try {
    const scan = execSync(
      `node "${path.join(ROOT, 'scripts/selfcheck/scan-trivia-inline-footnotes.cjs')}"`,
      { encoding: 'utf8', cwd: ROOT, timeout: 120000, stdio: ['pipe', 'pipe', 'pipe'] }
    );
    console.log(scan);
    console.log('✅ 위반 0건 확인');
  } catch (err) {
    const out = (err.stdout || '') + (err.stderr || '');
    console.log(out || err.message);
    console.log('⚠️  위반 잔존 — 위 목록 확인 필요');
  }

  process.exit(fail > 0 ? 1 : 0);
})();

#!/usr/bin/env node
/**
 * fix-trivia-inline-footnotes.cjs
 *
 * UCJ trivia 필드에서 중간에 배치된 [N] 각주를 마지막 문장 끝으로 이동하는 일괄 수정.
 * 룰 D 위반 130건 일괄 처리.
 *
 * Usage:
 *   node scripts/selfcheck/fix-trivia-inline-footnotes.cjs           # dry-run (기본)
 *   node scripts/selfcheck/fix-trivia-inline-footnotes.cjs --apply   # 실제 저장
 */

'use strict';

const { execSync } = require('child_process');
const path = require('path');

const ROOT = path.resolve(__dirname, '../..');
const APPLY = process.argv.includes('--apply');
const API_BASE = 'https://careerwiki.org';
const ADMIN_SECRET = 'careerwiki-admin-2026';

// ── 각주 중간 배치 감지 (detect-patterns.cjs와 동일) ─────────────────────────
function detectTriviaInlineFootnote(trivia) {
  if (!trivia || typeof trivia !== 'string') return false;
  const trimmed = trivia.trim();
  const all = [...trimmed.matchAll(/\[\d+\]/g)];
  if (all.length === 0) return false;
  const last = all[all.length - 1];
  const after = trimmed.slice(last.index + last[0].length).trim();
  return /[가-힣a-zA-Z0-9]/.test(after);
}

// ── trivia 각주 위치 교정 ────────────────────────────────────────────────────
// 모든 [N] 마커를 등장 순서대로 추출 → 텍스트에서 제거 → 마지막 문장 끝에 재배치
// V2 알고리즘: 마지막 [N]만 끝으로 이동, 앞 마커는 현 위치 유지
// - 단일마커: "A.[1] B." → "A. B.[1]"
// - 멀티마커: "A.[1] B.[2] C." → "A.[1] B. C.[2]"  ← 귀속 정밀도 보존
// (V1 오류: 모든 마커를 끝으로 이동 → 멀티마커 귀속 정밀도 손실)
function fixTriviaFootnotes(trivia) {
  if (!trivia || typeof trivia !== 'string') return null;
  if (!detectTriviaInlineFootnote(trivia)) return null; // 이미 올바름

  const all = [...trivia.matchAll(/\[\d+\]/g)];
  const last = all[all.length - 1];

  // 마지막 마커만 현 위치에서 제거
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

// ── DB 조회: 위반 목록 (trivia만) ────────────────────────────────────────────
// sources_json을 여기서 함께 조회하면 출력이 수 MB에 달해 ENOBUFS 발생.
// 위반 확인 후 apply 모드에서만 per-job으로 sources를 별도 조회한다.
function fetchViolations() {
  const sql = [
    "SELECT id, name, slug,",
    "  json_extract(user_contributed_json, '$.trivia') as trivia",
    "FROM jobs",
    "WHERE is_active=1",
    "  AND json_extract(user_contributed_json, '$.trivia') IS NOT NULL",
    "  AND json_extract(user_contributed_json, '$.trivia') != ''",
    "ORDER BY name",
  ].join(' ');

  const out = execSync(
    `npx wrangler d1 execute careerwiki-kr --remote --json --command "${sql.replace(/"/g, '\\"')}"`,
    { encoding: 'utf8', cwd: ROOT, timeout: 90000, stdio: ['pipe', 'pipe', 'pipe'] }
  );
  const parsed = JSON.parse(out);
  const rows = parsed?.[0]?.results || [];
  return rows.filter(r => r.trivia && detectTriviaInlineFootnote(r.trivia));
}

// ── DB 조회: 특정 job의 trivia sources ───────────────────────────────────────
function fetchJobSources(jobId) {
  const sql = `SELECT json_extract(user_contributed_json, '$._sources') as sources_json FROM jobs WHERE id='${jobId}' AND is_active=1`;
  const out = execSync(
    `npx wrangler d1 execute careerwiki-kr --remote --json --command "${sql.replace(/"/g, '\\"')}"`,
    { encoding: 'utf8', cwd: ROOT, timeout: 30000, stdio: ['pipe', 'pipe', 'pipe'] }
  );
  const parsed = JSON.parse(out);
  const row = parsed?.[0]?.results?.[0];
  return row?.sources_json || null;
}

// ── sources 파싱: 기존 trivia 소스 추출 ──────────────────────────────────────
function parseTriviaSources(sources_json) {
  if (!sources_json) return [];
  try {
    const allSources = typeof sources_json === 'string' ? JSON.parse(sources_json) : sources_json;
    const raw = allSources.trivia || [];
    // id 제거, text/url만 전달 (API가 id를 재할당함)
    return raw
      .map(s => ({
        text: (s?.text || '').trim(),
        ...(s?.url ? { url: s.url.trim() } : {}),
      }))
      .filter(s => s.text);
  } catch {
    return [];
  }
}

// ── API 저장 (Node.js fetch 사용 — Windows curl -d Mojibake 방지) ─────────────
async function saveJob(job, fixedTrivia, triviaSources) {
  const body = {
    jobId: String(job.id),
    fields: { trivia: fixedTrivia },
    sources: { trivia: triviaSources },
    changeSummary: '[자동수정] trivia 각주 위치 교정 — 룰 D: [N]을 마지막 문장 끝으로 이동',
  };

  const resp = await fetch(`${API_BASE}/api/job/${job.id}/edit`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'X-Admin-Secret': ADMIN_SECRET,
    },
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
  console.log(`trivia 각주 중간 배치 일괄 수정 — 룰 D`);
  console.log(`모드: ${APPLY ? '⚡ APPLY (실제 저장)' : '🔍 DRY-RUN (미리보기만)'}`);
  console.log('='.repeat(70));

  // ── 위반 목록 조회 ─────────────────────────────────────────────────────────
  console.log('\n[1/4] DB에서 위반 목록 조회 중...');
  const violations = fetchViolations();
  console.log(`      위반 건수: ${violations.length}개`);

  if (violations.length === 0) {
    console.log('\n✅ 위반 없음 — 작업 불필요');
    process.exit(0);
  }

  // ── 변경 사항 계산 + 특이 케이스 분류 ───────────────────────────────────────
  const toFix = [];
  const specialCases = [];
  let skipCount = 0;

  for (const job of violations) {
    const fixed = fixTriviaFootnotes(job.trivia);
    if (!fixed) {
      console.warn(`  ⚠️  스킵 (fix 반환 null): ${job.name}`);
      skipCount++;
      continue;
    }

    // sources는 apply 모드에서 저장 직전 per-job으로 조회 (dry-run에서는 미조회)
    const markers = [...job.trivia.matchAll(/\[\d+\]/g)].map(m => m[0]);
    const noSentenceEnd = !/[.?!]/.test(job.trivia.replace(/\[\d+\]/g, ''));
    // sources 여부는 dry-run에서 확인 불가 → apply 직전에 체크
    const noSources = false; // placeholder, 실제 확인은 apply 시

    const specialReasons = [
      markers.length > 1 ? `마커 ${markers.length}개 (${markers.join('')}) → 모두 끝으로 이동` : '',
      noSentenceEnd ? '마침표 없음 → 텍스트 맨 끝 배치' : '',
    ].filter(Boolean);

    if (specialReasons.length > 0) {
      specialCases.push({ name: job.name, slug: job.slug, reasons: specialReasons });
    }

    toFix.push({ job, fixed, markers });
  }

  // ── 변경 전/후 비교 출력 ──────────────────────────────────────────────────
  console.log(`\n[2/4] 변경 전/후 비교 (전체 ${toFix.length}건)`);
  console.log('-'.repeat(70));

  for (const { job, fixed, markers } of toFix) {
    const before = job.trivia.length > 180 ? job.trivia.slice(0, 180) + '…' : job.trivia;
    const afterStr = fixed.length > 180 ? fixed.slice(0, 180) + '…' : fixed;
    console.log(`\n${job.name} (${job.slug})`);
    console.log(`  전: ${before}`);
    console.log(`  후: ${afterStr}`);
    if (markers.length > 1) {
      console.log(`  ℹ️  마커 ${markers.length}개 이동: ${markers.join(' ')}`);
    }
  }

  // ── 특이 케이스 요약 ──────────────────────────────────────────────────────
  if (specialCases.length > 0) {
    console.log(`\n${'─'.repeat(70)}`);
    console.log(`[특이 케이스] ${specialCases.length}건`);
    for (const sc of specialCases) {
      console.log(`  ⚠️  ${sc.name} (${sc.slug})`);
      for (const r of sc.reasons) {
        console.log(`       · ${r}`);
      }
    }
  }

  console.log(`\n${'─'.repeat(70)}`);
  console.log(`수정 예정: ${toFix.length}건 / 스킵: ${skipCount}건`);

  if (!APPLY) {
    console.log('\n[DRY-RUN 완료] 실제 저장하려면 --apply 플래그를 추가하세요.');
    console.log('  node scripts/selfcheck/fix-trivia-inline-footnotes.cjs --apply');
    process.exit(0);
  }

  // ── 실제 저장 ─────────────────────────────────────────────────────────────
  console.log(`\n[3/4] 실제 저장 시작 (${toFix.length}건, 순차 처리)...\n`);

  const DELAY_MS = 150; // 직업 간 딜레이 (API 과부하 방지)
  let successCount = 0;
  let failCount = 0;
  const failures = [];
  const revisions = [];

  for (let i = 0; i < toFix.length; i++) {
    const { job, fixed } = toFix[i];
    const progress = `[${String(i + 1).padStart(3)}/${toFix.length}]`;

    try {
      // apply 직전에 per-job으로 sources 조회 (dry-run 단계에서는 조회 불필요)
      const sourcesJson = fetchJobSources(job.id);
      const triviaSources = parseTriviaSources(sourcesJson);
      if (triviaSources.length === 0) {
        process.stdout.write(`  ⚠️  ${job.name} — UCJ trivia sources 없음 (각주는 이동하나 sources 미등록 상태 유지)\n`);
      }
      const result = await saveJob(job, fixed, triviaSources);
      if (result.success) {
        const rev = result.revisionId || '?';
        revisions.push(rev);
        console.log(`✅ ${progress} ${job.name} — rev ${rev}`);
        successCount++;
      } else {
        const err = result.error || JSON.stringify(result);
        console.log(`❌ ${progress} ${job.name} — ${err}`);
        failCount++;
        failures.push({ name: job.name, slug: job.slug, error: err });
      }
    } catch (err) {
      console.log(`❌ ${progress} ${job.name} — ${err.message}`);
      failCount++;
      failures.push({ name: job.name, slug: job.slug, error: err.message });
    }

    if (i < toFix.length - 1) {
      await new Promise(r => setTimeout(r, DELAY_MS));
    }
  }

  // ── 저장 요약 ──────────────────────────────────────────────────────────────
  console.log(`\n${'='.repeat(70)}`);
  console.log(`저장 완료: ✅ ${successCount}건 성공 / ❌ ${failCount}건 실패`);
  if (revisions.length > 0) {
    const minRev = Math.min(...revisions.filter(r => typeof r === 'number'));
    const maxRev = Math.max(...revisions.filter(r => typeof r === 'number'));
    if (!isNaN(minRev) && !isNaN(maxRev)) {
      console.log(`revision 범위: ${minRev} ~ ${maxRev}`);
    }
  }

  if (failures.length > 0) {
    console.log(`\n[실패 목록]`);
    for (const f of failures) {
      console.log(`  ❌ ${f.name} (${f.slug}): ${f.error}`);
    }
  }

  // ── 전수 재스캔 ───────────────────────────────────────────────────────────
  console.log(`\n[4/4] 전수 재스캔 (위반 0건 확인)...\n`);
  try {
    const scanResult = execSync(
      `node "${path.join(ROOT, 'scripts/selfcheck/scan-trivia-inline-footnotes.cjs')}"`,
      { encoding: 'utf8', cwd: ROOT, timeout: 120000, stdio: ['pipe', 'pipe', 'pipe'] }
    );
    console.log(scanResult);
    console.log('\n✅ 재스캔 완료 — 위반 0건 확인');
  } catch (err) {
    // scan이 위반 있으면 exit 1로 throw
    const output = (err.stdout || '') + (err.stderr || '');
    console.log(output || err.message);
    console.log('\n⚠️  재스캔 후 아직 위반이 남아있습니다 — 위 목록 확인 필요');
    process.exit(1);
  }

  // ── 확인용 링크 ───────────────────────────────────────────────────────────
  const sampleJobs = toFix
    .filter((_, i) => i % Math.max(1, Math.floor(toFix.length / 6)) === 0)
    .slice(0, 6);

  if (sampleJobs.length > 0) {
    console.log('\n[확인용 링크 (샘플)]');
    for (const { job } of sampleJobs) {
      console.log(`  https://careerwiki.org/job/${job.slug}`);
    }
  }

  process.exit(failCount > 0 ? 1 : 0);
})();

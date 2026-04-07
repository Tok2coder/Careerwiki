/**
 * 무출처 문장 배치 수정 - 2차 (잔여 이슈)
 *
 * 처리 대상:
 * A. trivia 배열 반환 문제 — merged API에서 string 읽기
 * B. JOB_NOT_FOUND 3개 (mlops, ux, 노년) — 하드코딩 entityId
 * C. 가정교사/가축사육자 trivia NO_MARKER — sources 여부 확인 후 처리
 */

import fs from 'fs';
import { execSync } from 'child_process';

const BASE = 'https://careerwiki.org';
const SECRET = 'careerwiki-admin-2026';

// ──────────────────────────────────────────────
// 하드코딩 entityId 맵 (슬러그 기반 entityId 직업들)
// ──────────────────────────────────────────────
const HARDCODED_IDS = {
  'mlops-엔지니어':    'U_mlops엔지니어_mn8yypfr',
  'ux-디자인-컨설턴트': '1775053184416',
  '노년-플래너':       '1775053184431',
  'sns-마케터':        '1775053184581',
};

// ──────────────────────────────────────────────
// 수정 대상 (trivia + JOB_NOT_FOUND jobs)
// T=TRAILING_SENTENCE, N=NO_MARKER
// ──────────────────────────────────────────────
const JOBS = [
  // JOB_NOT_FOUND 재시도 (way + trivia)
  { slug: 'mlops-엔지니어',         fields: { way: 'T', trivia: 'T' } },
  { slug: 'ux-디자인-컨설턴트',     fields: { way: 'T', trivia: 'T' } },
  { slug: '노년-플래너',            fields: { way: 'T' } },

  // trivia 배열 문제 — 잔여 TRAILING_SENTENCE
  { slug: 'it-컨설턴트',            fields: { trivia: 'T' } },
  { slug: 'it기술지원전문가',        fields: { trivia: 'T' } },
  { slug: 'sns-마케터',             fields: { trivia: 'T' } },
  { slug: '가구조립-및-검사원',     fields: { trivia: 'T' } },
  { slug: '가구조립원',             fields: { trivia: 'T' } },
  { slug: '가사관리사',             fields: { trivia: 'T' } },
  { slug: '가수',                   fields: { trivia: 'T' } },

  // trivia NO_MARKER
  { slug: '가정교사',               fields: { trivia: 'N' } },
  { slug: '가축사육자',             fields: { trivia: 'N' } },
];

// ──────────────────────────────────────────────
// 헬퍼
// ──────────────────────────────────────────────

function truncateAtLastMarker(text) {
  if (!text || typeof text !== 'string') return null;
  const markers = [...text.matchAll(/\[\d+\]/g)];
  if (!markers.length) return null;
  const last = markers[markers.length - 1];
  return text.substring(0, last.index + last[0].length).trim();
}

async function getMergedData(slug) {
  const r = await fetch(`${BASE}/api/jobs/${encodeURIComponent(slug)}`);
  if (!r.ok) return null;
  const d = await r.json();
  return d.success ? d.data : null;
}

async function getEditData(slug) {
  const r = await fetch(`${BASE}/api/job/${encodeURIComponent(slug)}/edit-data`,
    { headers: { 'X-Admin-Secret': SECRET } });
  if (!r.ok) return null;
  const d = await r.json();
  return d.success ? { entityId: d.entityId, data: d.data || {}, sources: d.data?._sources || {} } : null;
}

function coerceToString(val) {
  if (typeof val === 'string') return val;
  if (Array.isArray(val) && val.length > 0 && typeof val[0] === 'string') return val[0];
  return null;
}

function postEdit(entityId, fields, sources, slug) {
  // 하드코딩 ID 우선 사용
  const actualId = HARDCODED_IDS[slug] || entityId;
  const payload = JSON.stringify({ fields, sources });
  const tmpFile = `C:/temp/fix2_${String(actualId).replace(/[^a-z0-9_]/gi,'_').substring(0,40)}.json`;
  fs.writeFileSync(tmpFile, payload, 'utf8');
  const encodedId = encodeURIComponent(String(actualId));
  try {
    const out = execSync(
      `curl -s -X POST "${BASE}/api/job/${encodedId}/edit" ` +
      `-H "Content-Type: application/json; charset=utf-8" ` +
      `-H "X-Admin-Secret: ${SECRET}" ` +
      `--data-binary @${tmpFile}`,
      { encoding: 'utf8' }
    );
    fs.unlinkSync(tmpFile);
    return JSON.parse(out);
  } catch (e) {
    try { fs.unlinkSync(tmpFile); } catch {}
    return { success: false, error: e.message };
  }
}

// ──────────────────────────────────────────────
// 메인 처리
// ──────────────────────────────────────────────

async function processJob(job) {
  const { slug, fields: fieldIssues } = job;
  const log = { slug, changes: [], skipped: [], errors: [] };

  const [merged, edit] = await Promise.all([getMergedData(slug), getEditData(slug)]);
  if (!merged || !edit) {
    log.errors.push('API 조회 실패');
    return log;
  }

  const { entityId, data: editData, sources } = edit;
  const fieldsToUpdate = {};
  const sourcesToUpdate = {};

  for (const [fieldPath, issueType] of Object.entries(fieldIssues)) {
    // trivia는 merged API에서 string으로, 다른 필드는 edit-data 우선
    let rawValue;
    if (fieldPath === 'way' || fieldPath === 'trivia') {
      rawValue = merged[fieldPath];
    } else {
      const parts = fieldPath.split('.');
      let cur = editData;
      for (const p of parts) { if (cur == null) break; cur = cur[p]; }
      rawValue = cur ?? merged[fieldPath]; // edit-data에 없으면 merged fallback
    }

    const currentText = coerceToString(rawValue);
    const fieldSources = sources[fieldPath] || [];

    if (!currentText) {
      log.skipped.push(`${fieldPath}: 텍스트 없음 (raw type=${typeof rawValue})`);
      continue;
    }

    if (issueType === 'T') {
      const truncated = truncateAtLastMarker(currentText);
      if (!truncated) {
        log.skipped.push(`${fieldPath}: 마커 없음`);
        continue;
      }
      if (truncated === currentText.trim()) {
        log.skipped.push(`${fieldPath}: 이미 정상 (마지막 [N] 이후 텍스트 없음)`);
        continue;
      }

      const removedLen = currentText.trim().length - truncated.length;
      log.changes.push({
        field: fieldPath,
        action: 'TRUNCATE',
        removedChars: removedLen,
        before: '...' + currentText.trim().slice(-80),
        after: '...' + truncated.slice(-50),
      });

      fieldsToUpdate[fieldPath] = truncated;
      sourcesToUpdate[fieldPath] = fieldSources;

    } else if (issueType === 'N') {
      if (fieldSources.length > 0) {
        const withMarker = currentText.trim() + '[1]';
        log.changes.push({
          field: fieldPath,
          action: 'ADD_MARKER',
          detail: `[1] 추가 (source: ${(fieldSources[0]?.text || fieldSources[0]?.url || '?').substring(0, 50)})`,
          before: currentText.trim().substring(0, 80),
          after: withMarker.substring(0, 80),
        });
        fieldsToUpdate[fieldPath] = withMarker;
        sourcesToUpdate[fieldPath] = fieldSources;
      } else {
        log.changes.push({
          field: fieldPath,
          action: 'REMOVE',
          detail: '소스 없음 — 필드 제거',
          before: currentText.trim().substring(0, 80),
          after: '(null)',
        });
        fieldsToUpdate[fieldPath] = null;
        sourcesToUpdate[fieldPath] = [];
      }
    }
  }

  if (Object.keys(fieldsToUpdate).length === 0) {
    log.skipped.push('변경 사항 없음');
    return log;
  }

  const result = postEdit(entityId, fieldsToUpdate, sourcesToUpdate, slug);
  if (result.success) {
    log.saved = true;
  } else {
    log.errors.push(`저장 실패: ${result.error || JSON.stringify(result)}`);
  }

  return log;
}

async function main() {
  console.log('무출처 문장 배치 수정 2차 시작');
  console.log(`대상: ${JOBS.length}개 직업\n`);

  const allLogs = [];

  for (const job of JOBS) {
    process.stdout.write(`처리: ${job.slug}... `);
    const log = await processJob(job);

    if (log.errors.length > 0) {
      console.log(`❌ ${log.errors.join(', ')}`);
    } else if (log.changes.length > 0) {
      const actions = log.changes.map(c => `${c.field}[${c.action}]`).join(', ');
      console.log(`✅ ${log.changes.length}건 (${actions})`);
    } else {
      console.log(`⏭  ${log.skipped.join('; ')}`);
    }

    allLogs.push(log);
    await new Promise(r => setTimeout(r, 500));
  }

  console.log('\n' + '='.repeat(70));
  const saved = allLogs.filter(l => l.saved);
  const failed = allLogs.filter(l => l.errors.length > 0);
  const skip = allLogs.filter(l => l.changes.length === 0 && l.errors.length === 0);

  console.log(`✅ 성공: ${saved.length}개 | ❌ 실패: ${failed.length}개 | ⏭  스킵: ${skip.length}개`);

  const byAction = {};
  for (const log of allLogs) {
    for (const c of log.changes) {
      byAction[c.action] = (byAction[c.action] || 0) + 1;
    }
  }
  if (Object.keys(byAction).length > 0) {
    console.log('액션:', Object.entries(byAction).map(([k,v])=>`${k}=${v}건`).join(', '));
  }

  console.log('\n[상세 로그]\n');
  for (const log of allLogs.filter(l => l.changes.length > 0 || l.errors.length > 0)) {
    const status = log.saved ? '✅' : (log.errors.length > 0 ? '❌' : '?');
    console.log(`━━ ${status} ${log.slug}`);
    for (const c of log.changes) {
      console.log(`  [${c.action}] ${c.field}${c.removedChars ? ` (제거 ${c.removedChars}자)` : ''}`);
      if (c.detail) console.log(`    ${c.detail}`);
      console.log(`    B: "${c.before}"`);
      console.log(`    A: "${c.after}"`);
    }
    for (const e of log.errors) console.log(`  ❌ ${e}`);
    console.log('');
  }

  // JSON 저장
  const all2 = JSON.parse(fs.readFileSync('scripts/unsourced-fix-report.json','utf8'));
  const combined = [...all2, ...allLogs];
  fs.writeFileSync('scripts/unsourced-fix-report.json', JSON.stringify(combined, null, 2), 'utf8');
  console.log('리포트 업데이트: scripts/unsourced-fix-report.json');
}

main().catch(console.error);

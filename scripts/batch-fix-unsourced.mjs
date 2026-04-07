/**
 * 무출처 문장 배치 수정 스크립트
 *
 * 처리 원칙:
 *   TRAILING_SENTENCE → 마지막 [N] 이후 텍스트 제거 (truncate)
 *   NO_MARKER → _sources가 있으면 [1] 추가; 없으면 필드 제거
 *
 * way 필드: 읽기는 /api/jobs/{slug} (merged), 출처는 edit-data API
 * 기타 필드: edit-data API data + _sources
 */

import fs from 'fs';
import { execSync } from 'child_process';

const BASE = 'https://careerwiki.org';
const SECRET = 'careerwiki-admin-2026';

// ──────────────────────────────────────────────
// 수정 대상 목록 (test-unsourced-detection.mjs 결과 기반)
// type: T=TRAILING_SENTENCE, N=NO_MARKER
// ──────────────────────────────────────────────
const JOBS = [
  { slug: 'it-컨설턴트',              fields: { way:'T', 'overviewSalary.sal':'T', trivia:'T' } },
  { slug: 'it기술지원전문가',          fields: { 'overviewSalary.sal':'T', trivia:'T' } },
  { slug: 'it테스터-및-it-qa전문가',  fields: { 'overviewSalary.sal':'T' } },
  { slug: 'mlops-엔지니어',           fields: { way:'T', trivia:'T' } },
  { slug: 'sns-마케터',               fields: { trivia:'T' } },
  { slug: 'ux-디자인-컨설턴트',       fields: { way:'T', trivia:'T' } },
  { slug: '가구-디자이너',            fields: { way:'T' } },
  { slug: '가구조립-및-검사원',       fields: { way:'T', 'overviewSalary.sal':'T', 'overviewProspect.main':'T', trivia:'T' } },
  { slug: '가구조립원',               fields: { way:'T', 'overviewSalary.sal':'T', trivia:'T' } },
  { slug: '가사관리사',               fields: { 'overviewSalary.sal':'T', trivia:'T' } },
  { slug: '가사도우미',               fields: { way:'T', 'overviewSalary.sal':'T' } },
  { slug: '가상현실전문가',           fields: { 'overviewSalary.sal':'T', 'overviewProspect.main':'T' } },
  { slug: '가수',                     fields: { way:'T', 'overviewSalary.sal':'T', trivia:'T' } },
  { slug: '가정교사',                 fields: { way:'T', 'overviewSalary.sal':'T', 'overviewProspect.main':'N', trivia:'N' } },
  { slug: '가축사육자',               fields: { 'overviewSalary.sal':'T', 'overviewProspect.main':'N', trivia:'N' } },
  { slug: '가축사육종사원',           fields: { way:'N', 'overviewSalary.sal':'T', 'overviewProspect.main':'T' } },
  { slug: '게임-그래픽-디자이너',     fields: { 'overviewSalary.sal':'T' } },
  { slug: '게임-기획자',              fields: { way:'T', 'overviewSalary.sal':'T' } },
  { slug: '노년-플래너',              fields: { way:'T' } },
  { slug: '노무사',                   fields: { 'overviewSalary.sal':'T' } },
  { slug: '노점-및-이동판매원',       fields: { 'overviewSalary.sal':'T' } },
  { slug: '농업교사',                 fields: { 'overviewSalary.sal':'T' } },
];

// ──────────────────────────────────────────────
// 헬퍼
// ──────────────────────────────────────────────

function truncateAtLastMarker(text) {
  if (!text || typeof text !== 'string') return null;
  const markers = [...text.matchAll(/\[\d+\]/g)];
  if (!markers.length) return null; // 마커 없음
  const last = markers[markers.length - 1];
  return text.substring(0, last.index + last[0].length).trim();
}

function getNestedField(obj, path) {
  if (obj[path] !== undefined) return obj[path];
  const parts = path.split('.');
  let cur = obj;
  for (const p of parts) {
    if (cur == null) return undefined;
    cur = cur[p];
  }
  return cur;
}

function setNestedField(obj, path, value) {
  const parts = path.split('.');
  if (parts.length === 1) { obj[path] = value; return; }
  const [head, ...rest] = parts;
  if (!obj[head]) obj[head] = {};
  setNestedField(obj[head], rest.join('.'), value);
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

function postEdit(entityId, fields, sources, jobName) {
  const payload = JSON.stringify({ fields, sources });
  const tmpFile = `C:/temp/unsrc_${String(entityId).replace(/[^a-z0-9_]/gi,'_').substring(0,40)}.json`;
  fs.writeFileSync(tmpFile, payload, 'utf8');
  const encodedId = encodeURIComponent(String(entityId));
  try {
    const out = execSync(
      `curl -s -X POST "${BASE}/api/job/${encodedId}/edit" ` +
      `-H "Content-Type: application/json; charset=utf-8" ` +
      `-H "X-Admin-Secret: ${SECRET}" ` +
      `--data-binary @${tmpFile}`,
      { encoding: 'utf8' }
    );
    fs.unlinkSync(tmpFile);
    const result = JSON.parse(out);
    return result;
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

  // 1. 데이터 조회
  const [merged, edit] = await Promise.all([getMergedData(slug), getEditData(slug)]);
  if (!merged || !edit) {
    log.errors.push('API 조회 실패');
    return log;
  }

  const { entityId, data: editData, sources } = edit;
  const fieldsToUpdate = {};
  const sourcesToUpdate = {};

  // 2. 각 필드 처리
  for (const [fieldPath, issueType] of Object.entries(fieldIssues)) {
    // 현재 텍스트 가져오기 (way는 merged에서, 나머지는 edit-data에서)
    let currentText;
    if (fieldPath === 'way') {
      currentText = merged.way || '';
    } else {
      currentText = getNestedField(editData, fieldPath) || '';
    }

    const fieldSources = sources[fieldPath] || [];

    if (!currentText || typeof currentText !== 'string') {
      log.skipped.push(`${fieldPath}: 텍스트 없음 또는 비문자열 (type=${typeof currentText})`);
      continue;
    }

    if (issueType === 'T') {
      // TRAILING_SENTENCE: 마지막 [N] 이후 제거
      const truncated = truncateAtLastMarker(currentText);
      if (!truncated) {
        log.skipped.push(`${fieldPath}: 마커 없음 (예상과 다름)`);
        continue;
      }
      if (truncated === currentText.trim()) {
        log.skipped.push(`${fieldPath}: 이미 정상`);
        continue;
      }

      const removedLen = currentText.trim().length - truncated.length;
      log.changes.push({
        field: fieldPath,
        action: 'TRUNCATE',
        removedChars: removedLen,
        before: currentText.trim().substring(Math.max(0, currentText.trim().length - 80)),
        after: truncated.substring(Math.max(0, truncated.length - 50)),
      });

      setNestedField(fieldsToUpdate, fieldPath, truncated);
      sourcesToUpdate[fieldPath] = fieldSources;

    } else if (issueType === 'N') {
      // NO_MARKER: 소스 있으면 [1] 추가, 없으면 제거
      if (fieldSources.length > 0) {
        // 텍스트 끝에 [1] 추가
        const withMarker = currentText.trim() + '[1]';
        log.changes.push({
          field: fieldPath,
          action: 'ADD_MARKER',
          detail: `[1] 추가 (source: ${fieldSources[0]?.text?.substring(0, 40) || fieldSources[0]?.url?.substring(0, 40) || '?'})`,
          before: currentText.trim().substring(0, 80),
          after: withMarker.substring(0, 80),
        });
        setNestedField(fieldsToUpdate, fieldPath, withMarker);
        sourcesToUpdate[fieldPath] = fieldSources;
      } else {
        // 소스 없음 → 필드 제거 (null로 설정)
        log.changes.push({
          field: fieldPath,
          action: 'REMOVE',
          detail: '소스 없는 무출처 필드 제거',
          before: currentText.trim().substring(0, 80),
          after: '(null — 제거)',
        });
        setNestedField(fieldsToUpdate, fieldPath, null);
        sourcesToUpdate[fieldPath] = [];
      }
    }
  }

  // 3. 변경 사항이 없으면 스킵
  if (Object.keys(fieldsToUpdate).length === 0) {
    log.skipped.push('변경할 내용 없음');
    return log;
  }

  // 4. POST
  const result = postEdit(entityId, fieldsToUpdate, sourcesToUpdate, slug);
  if (result.success) {
    log.saved = true;
  } else {
    log.errors.push(`저장 실패: ${result.error || JSON.stringify(result)}`);
  }

  return log;
}

// ──────────────────────────────────────────────
// 실행
// ──────────────────────────────────────────────

async function main() {
  console.log('무출처 문장 배치 수정 시작');
  console.log(`대상: ${JOBS.length}개 직업\n`);

  const allLogs = [];

  for (const job of JOBS) {
    process.stdout.write(`처리: ${job.slug}... `);
    const log = await processJob(job);

    if (log.errors.length > 0) {
      console.log(`❌ ${log.errors.join(', ')}`);
    } else if (log.changes.length > 0) {
      const actions = log.changes.map(c => `${c.field}[${c.action}]`).join(', ');
      console.log(`✅ ${log.changes.length}건 수정 (${actions})`);
    } else {
      console.log(`⏭  스킵 (${log.skipped.join(', ')})`);
    }

    allLogs.push(log);
    await new Promise(r => setTimeout(r, 500));
  }

  // ── 최종 리포트 ──────────────────────────────
  console.log('\n' + '='.repeat(70));
  console.log('배치 수정 완료 리포트');
  console.log('='.repeat(70));

  const saved = allLogs.filter(l => l.saved);
  const failed = allLogs.filter(l => l.errors.length > 0);
  const skipped = allLogs.filter(l => l.changes.length === 0 && l.errors.length === 0);

  console.log(`✅ 성공: ${saved.length}개 직업`);
  console.log(`❌ 실패: ${failed.length}개`);
  console.log(`⏭  스킵: ${skipped.length}개`);

  // 액션 유형별 집계
  const byAction = {};
  for (const log of allLogs) {
    for (const c of log.changes) {
      byAction[c.action] = (byAction[c.action] || 0) + 1;
    }
  }
  console.log('\n[액션 유형별]');
  for (const [action, count] of Object.entries(byAction)) {
    console.log(`  ${action}: ${count}건`);
  }

  // 상세 변경 로그
  console.log('\n[상세 변경 로그]\n');
  for (const log of allLogs.filter(l => l.changes.length > 0)) {
    const status = log.saved ? '✅' : (log.errors.length > 0 ? '❌' : '?');
    console.log(`━━ ${status} ${log.slug}`);
    for (const c of log.changes) {
      console.log(`  [${c.action}] ${c.field}`);
      if (c.removedChars) console.log(`    제거 ${c.removedChars}자`);
      if (c.detail) console.log(`    ${c.detail}`);
      console.log(`    before: "...${c.before}"`);
      console.log(`    after:  "...${c.after}"`);
    }
    if (log.errors.length > 0) {
      console.log(`  오류: ${log.errors.join(', ')}`);
    }
    console.log('');
  }

  if (failed.length > 0) {
    console.log('[실패 목록]');
    for (const log of failed) {
      console.log(`  ${log.slug}: ${log.errors.join(', ')}`);
    }
  }

  // JSON 리포트 저장
  const reportPath = 'scripts/unsourced-fix-report.json';
  fs.writeFileSync(reportPath, JSON.stringify(allLogs, null, 2), 'utf8');
  console.log(`\n리포트 저장: ${reportPath}`);
}

main().catch(console.error);

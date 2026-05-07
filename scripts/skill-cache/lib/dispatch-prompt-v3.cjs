// scripts/skill-cache/lib/dispatch-prompt-v3.cjs
//
// v3 dispatch prompt generator (옵션 B' 최소안전 절감).
//
// 단일 source of truth — cycle 빌더 / dispatch helper / 수동 dispatch 모두 이 함수를 호출해야 함.
// 7 안전 룰은 SAFETY_RULES 함수에 hardcode — 호출자가 파라미터로 빼낼 수 없음.
//
// pilot 검증 (2026-05-06):
//   - 3직업 평균 ~107K tokens/call (vs v2 baseline 1.18M = -91%)
//   - audit-deep CLEAN 100% / fact-source warn-only OK / WebFetch ≥ URL count
//   - 토큰 절감 출처: 인라인 안전 룰 (SKILL.md 재read 회피) + 명확 DONE/RETRY (clarification 라운드 0)
//
// 사용 (lib import):
//   const { buildDispatchPrompt, MAIN_HEAD_MIN } = require('./lib/dispatch-prompt-v3.cjs');
//   const prompt = buildDispatchPrompt({
//     slug: '바리스타',
//     id: '1765283309704378',
//     audit: { totalUrls: 15, externalHosts: 15, uniqueHosts: 4, deepClean: true, patterns: [] },
//     factSource: { classification: 'PARTIAL', suspect: 1, gen: 0, detailLines: [...] },
//     keyTask: 'detailReady.training 본문 fact "KCRC" ↔ 출처 1:1 정합성 매핑 또는 일반화',
//   });

'use strict';

// 빌더 사용 시점에 이 commit 이상이 origin/main HEAD인지 확인 강제.
// HEAD 갱신 시 이 상수만 바꾸면 prompt 자동 동기화.
const MAIN_HEAD_MIN = '2af54bf';

// 안전 룰 7개 + 보조 (origin 절대 금지, 단축 처리 금지).
// 이 블록은 호출자가 override 불가. 누락하면 builder가 작동 안 함.
function SAFETY_RULES(slug) {
  return [
    '## 안전 룰 (prompt 박음 — SKILL.md 의존 X)',
    '',
    '**🚨 WebFetch 강제** — 모든 _sources URL은 등록 *전* WebFetch tool_use ≥ 1회 필수. tool_uses 카운트 < URL 카운트 → DONE 무효. LLM 일반 지식으로 URL 추정 절대 금지.',
    '',
    '**🚨 hallucinated 도메인 블랙리스트 (등록 전 WebFetch 의무)** — kgta.or.kr / k-lpn.or.kr / kpba.co.kr / kindergarten.go.kr boardid 추정 / humanrights.go.kr boardid 추정 / gamejob.co.kr ASP path / careers.* deep path / learn.unity.com pathway 추정 등.',
    '',
    `**🚨 Phase 0-SYNC 필수** — \`git fetch origin main && git log --oneline origin/main | head -3\`. main HEAD ${MAIN_HEAD_MIN} 이상 확인. 미만이면 즉시 \`git pull origin main\`.`,
    '',
    '**🚨 origin 도메인 절대 금지** — `career.go.kr` / `work.go.kr` / `work24.go.kr` / **`wagework.go.kr`** / `job.go.kr` 1건이라도 즉시 FAIL. wagework은 외부 host 카운트 X. validate `[originDomain]` 0건 stdout 첨부 필수.',
    '',
    '**🚨 Phase 4-SRC-FACT** — 본문 구체 fact (회사명·통계·연도·금액·순위) ↔ 출처 1:1 정합성. 협회 root URL은 fact cover X. 매핑 못 하면 (a) deep URL 찾기 (b) fact 일반화 (c) fact 제거. 한 sentence 1 마커 max.',
    '',
    `**🚨 Phase 5-AUDIT-DEEP** — \`node scripts/skill-cache/audit-sources-deep.cjs --slug=${slug}\`. 9패턴 + originDomain 모두 0 확인. 1+ 발견 시 Phase 1 재시작 (단축 금지).`,
    '',
    '**🚨 LLM 자가검증 1줄로 통과 절대 금지** — validate-job-edit.cjs / audit-sources-deep.cjs / Node.js fetch 키워드 매칭 등 결정적 스크립트로만 검증. self-report 라벨 ("CLEAN", "DONE")만으로 통과 X.',
    '',
    '**🚨 Root URL 출처 금지 (룰 13, 2026-05-07)** — 협회/회사/학술 publisher root URL은 fact cover X. path depth ≥ 2 + WebFetch 본문 fact 등장 둘 다 만족 필수. 못 만족하면 (a) deep page 찾기 (b) fact 일반화 (c) fact 제거. 정부 부처 root는 룰 F가 별도 처리. validate `[rootURL]` FAIL 차단.',
    '',
    '**🚨 Wikipedia Quota — 위키 점유율 ≤ 30% (룰 14, 2026-05-07)** — 직업당 글로벌 출처 풀에서 `*.wikipedia.org` / `namu.wiki` / `*.wikia.com` / `*.fandom.com` 점유율 > 30% 즉시 FAIL. 1차 출처(협회 deep / 정부 통계 / 학술 / 1차 미디어 deep article) 우선. 위키는 보조. validate `[wikiQuota]` FAIL 차단.',
    '',
    '**🔴 단축 처리 금지** — 토큰 부족 ≠ minimal POST 사유. validate FAIL 시 본문 재작성. minimal POST (마커만 부착) → server-side `[minimalPOST]` FAIL.',
  ].join('\n');
}

function PHASE_STEPS(slug, id) {
  return [
    '## Phase 핵심 (자세히는 SKILL.md Phase 0~5)',
    '1. **Phase 0-PRE** START_TRACKING bash 직접 실행',
    '2. **Phase 0-DIAG** `merged_profile_json` 기준 + `json_type` 분기',
    '3. **Phase 1** 17필드 draft (lookup.cjs --type=cert|org 먼저, WebFetch 강제)',
    '4. **Phase 2** `scripts/validate-job-edit.cjs` PASS + stdout 첨부 ([originDomain] 0 확인)',
    `5. **Phase 3** POST \`https://careerwiki.org/api/job/${id}/edit\` + \`X-Admin-Secret: careerwiki-admin-2026\` (Node.js fetch + UTF-8 / curl 절대 X)`,
    '6. **Phase 4** `full-quality-audit.cjs` PASS + Phase 4-SRC-FACT 매핑 검증',
    `7. **Phase 5-DEDUP** \`auto-dedup-sweep.cjs --slug=${slug} --apply\``,
    '8. **Phase 5-AUDIT-DEEP** CLEAN + END_TRACKING + UCJ 17필드 self-report + `[job-data-enhance]` 마커 부착',
    '',
    '**필수 만족**: 외부 host ≥ 3 (origin 카운트 X) / careerTree 손대지 X (별도 사이클) / detailReady 항목별 [N]+_sources',
  ].join('\n');
}

function DONE_RETRY(slug) {
  return [
    '## DONE/RETRY 형식',
    '',
    '**clean 시 (이 형식 그대로 마지막 줄에 출력)**:',
    '```',
    `DONE: ${slug} rev={N} deep-audit=CLEAN externalHosts={N≥3} (dup=0 orphan=0 originDomain=0 listPage=0 rawURL=0 brokenRef=0 bracket=0 moji=0 idxGap=NO srcNULL=NO)`,
    '출처: WebFetch tool_uses={K} ≥ URL count={N} / fact-source 잔여={S→0 또는 일반화 처리}',
    '```',
    '',
    `**FAIL 시**: \`RETRY: ${slug} 사유: {validate FAIL pattern 또는 deep-audit pattern 상세}\``,
    '',
    'enhance = DB만 — git/deploy 불필요. 작업 완료 후 위 DONE/RETRY 라인을 마지막에 출력하여 종료하세요.',
  ].join('\n');
}

// 호출자 인자: { slug, id, audit, factSource, keyTask, auditDate }
//   slug, id: 필수 (string)
//   audit: { totalUrls, externalHosts, uniqueHosts, deepClean, patterns: ['brokenRef×4', ...], detailLines: [...] }
//   factSource: { classification: 'MATCH'|'PARTIAL'|'MISMATCH'|'NO_FACT', suspect, gen, detailLines: [...] }
//   keyTask: 1줄 요약 (string)
//   auditDate: 'YYYY-MM-DD' (default = today)
//
// validation: slug/id 누락 → throw. 안전 룰 7개는 SAFETY_RULES에 hardcode.
function buildDispatchPrompt(opts) {
  if (!opts || typeof opts !== 'object') throw new Error('buildDispatchPrompt: opts required');
  const { slug, id, audit = {}, factSource = {}, keyTask = '', auditDate } = opts;
  if (!slug) throw new Error('buildDispatchPrompt: slug required');
  if (!id) throw new Error('buildDispatchPrompt: id required');

  const date = auditDate || new Date().toISOString().slice(0, 10);

  // 사고 패턴 라인
  const patternsLine = audit.deepClean
    ? 'deep-audit CLEAN (구조 OK)'
    : (audit.patterns && audit.patterns.length > 0 ? audit.patterns.join(' / ') : '미측정');
  const detailLines = (audit.detailLines && audit.detailLines.length > 0)
    ? audit.detailLines.map(l => '  - ' + l).join('\n')
    : '';

  // fact-source 라인
  const fsClass = factSource.classification || 'UNKNOWN';
  const fsSuspect = (factSource.suspect != null) ? factSource.suspect : '?';
  const fsGen = (factSource.gen != null) ? factSource.gen : '?';
  const fsDetailLines = (factSource.detailLines && factSource.detailLines.length > 0)
    ? factSource.detailLines.map(l => '  - ' + l).join('\n')
    : '';

  const headerLines = [
    '/job-data-enhance 1직업 풀 사이클 — 단축 절대 금지',
    '',
    '이 prompt는 v3 template (옵션 B\' 최소안전 절감) 자동 생성. /job-data-enhance skill이 가용하면 그대로 invoke해서 SKILL.md 워크플로우를 따르고, 가용하지 않으면 .claude/skills/job-data-enhance/SKILL.md를 직접 read하여 Phase 0~5 진행하세요.',
    '',
    `### ${slug} (id=${id})`,
    `- URL: https://careerwiki.org/job/${slug}`,
    `- 사고 패턴 (deep audit ${date}): ${patternsLine}`,
  ];
  if (detailLines) headerLines.push(detailLines);
  headerLines.push(
    `- audit 메트릭: totalUrls=${audit.totalUrls ?? '?'}, externalHosts=${audit.externalHosts ?? '?'}, uniqueHosts=${audit.uniqueHosts ?? '?'}`,
    `- fact-source 분류: ${fsClass} (suspectFacts=${fsSuspect} generalDomain=${fsGen})`,
  );
  if (fsDetailLines) headerLines.push(fsDetailLines);
  if (keyTask) headerLines.push(`- 핵심 작업: ${keyTask}`);

  return [
    headerLines.join('\n'),
    '',
    SAFETY_RULES(slug),
    '',
    PHASE_STEPS(slug, id),
    '',
    DONE_RETRY(slug),
  ].join('\n');
}

// 안전 룰 9개 keyword를 hardcode — 호출자가 결과 prompt에 모두 포함됐는지 자가 검증 가능.
// 빌더 또는 정합성 테스트가 generated prompt를 이 키워드로 grep해서 누락 0 확인.
const SAFETY_RULE_KEYWORDS = [
  'WebFetch 강제',                                 // 1
  'hallucinated 도메인 블랙리스트',                  // 2
  'Phase 0-SYNC',                                 // 3
  'Phase 4-SRC-FACT',                             // 4
  'Phase 5-AUDIT-DEEP',                           // 5
  'LLM 자가검증 1줄로 통과 절대 금지',               // 6
  'origin 도메인 절대 금지',                        // 7 (보조: origin 차단)
  'Root URL 출처 금지',                            // 8 (룰 13, 2026-05-07)
  'Wikipedia Quota',                              // 9 (룰 14, 2026-05-07)
];

function verifySafetyRulesPresent(prompt) {
  const missing = SAFETY_RULE_KEYWORDS.filter(kw => !prompt.includes(kw));
  return { ok: missing.length === 0, missing };
}

module.exports = {
  buildDispatchPrompt,
  verifySafetyRulesPresent,
  MAIN_HEAD_MIN,
  SAFETY_RULE_KEYWORDS,
};

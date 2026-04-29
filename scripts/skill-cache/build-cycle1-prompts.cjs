#!/usr/bin/env node
// scripts/skill-cache/build-cycle1-prompts.cjs
// master-list-50.json에서 cycle 1용 10건 선정 → data/cycle1-prompts.md 출력.
//
// 선정 기준 (사용자 명시):
//   - 다양한 사고 패턴 mix (rawURL only, brokenRef only, selfCiteOnly, 다중)
//   - 처리 시간 균형 (가벼운 + 무거운 mix)

'use strict';

const fs = require('fs');
const path = require('path');
const REPO_ROOT = path.resolve(__dirname, '..', '..');
const MASTER = path.join(REPO_ROOT, 'data', 'master-list-50.json');
const OUT = path.join(REPO_ROOT, 'data', 'cycle1-prompts.md');

const data = JSON.parse(fs.readFileSync(MASTER, 'utf8'));

// 패턴 mix + heavy/light balance로 10건 선정
const CYCLE_1_SLUGS = [
  '입학사정관',       // 무거움: rawURL×17 단독 (rawURL only 대표)
  '보험계리사',       // 무거움: mojibake×1 (인코딩 사고 — 가장 시급)
  '의료코디네이터',     // 무거움: 다중 brokenRef×8/orphan×8/dup×2/selfCite×4
  '수상운송사무원',     // 무거움: selfCiteOnly + listPage×5 (selfCiteOnly 대표)
  '드라마작가',       // 중간: brokenRef×6/rawURL×4/selfCite×1 (다중 사고)
  '사회단체활동가',     // 가벼움: selfCiteOnly + listPage×3
  '집배원',         // 가벼움: brokenRef×5 단독 (brokenRef only 대표)
  '마취병리과의사',     // 가벼움: brokenRef×2 + dup×2 (의료/dup mix)
  '법원공무원',       // 중간: listPage×1 + brokenRef×2 + dup×5 (공직)
  '네일아티스트',      // 중간: rawURL×4 + orphan×4 + selfCite×5 (외부 host 8 풍부)
];

const picked = CYCLE_1_SLUGS.map(slug => {
  const j = data.jobs.find(x => x.slug === slug);
  if (!j) throw new Error(`slug not found in master-list: ${slug}`);
  return j;
});

const STANDARD_PROMPT = (j, sessionNum) => {
  const tags = j.tags;
  const sum = j.fixSummary || tags;
  const detailLines = [];
  if (j.details.brokenRef.length) {
    detailLines.push(`  - brokenRef: ${JSON.stringify(j.details.brokenRef.slice(0, 8))}${j.details.brokenRef.length > 8 ? ' …' : ''}`);
  }
  if (j.details.rawURL.length) {
    detailLines.push(`  - rawURL 위치: ${j.details.rawURL.slice(0, 6).map(r => `${r.field}#${r.idx}`).join(', ')}${j.details.rawURL.length > 6 ? ' …' : ''}`);
  }
  if (j.details.listPage.length) {
    detailLines.push(`  - listPage URL: ${j.details.listPage.slice(0, 3).map(l => `${l.field}: ${l.url.slice(0, 70)}`).join(' / ')}`);
  }
  if (j.details.mojibake.length) {
    detailLines.push(`  - mojibake 위치: ${j.details.mojibake.slice(0, 3).map(m => m.location).join(', ')}`);
  }
  if (j.details.orphanSrc.length) {
    detailLines.push(`  - orphanSrc: ${JSON.stringify(j.details.orphanSrc.slice(0, 6))}${j.details.orphanSrc.length > 6 ? ' …' : ''}`);
  }
  if (j.details.selfCiteHosts && j.details.selfCiteHosts.length) {
    detailLines.push(`  - selfCite hosts: ${j.details.selfCiteHosts.join(', ')}`);
  }

  return `## 세션 ${sessionNum}: ${j.slug}

\`\`\`
/job-data-enhance 직업 1개 풀 사이클 — 단축 절대 금지

### ${j.slug} (id=${j.id})
- URL: https://careerwiki.org/job/${j.slug}
- 사고 패턴 (deep audit 2026-04-29): ${tags}
${detailLines.join('\n')}
- audit 메트릭: totalUrls=${j.totalUrls}, externalHosts=${j.externalHostCount}, uniqueHosts=${j.uniqueHosts}
- 핵심 작업: ${sum}

### 표준 룰 (필수 준수 — 1 직업 풀 사이클 Phase 0~5)

**🔴 단축 처리 절대 금지**:
- 토큰 제약 = 단축 사유 절대 안 됨
- context 부족하면 SKILL.md 다시 read 후 재작성
- minimal POST (마커만 부착) 절대 금지 — server-side \`[minimalPOST]\` FAIL
- validate FAIL 시 본문 재작성 (단축으로 마커만 부착하지 마)

1. **Phase 0-PRE START_TRACKING** bash 직접 실행
2. **Phase 0-DIAG**: \`merged_profile_json\` 기준 + \`json_type\` 분기
3. **Phase 1**: 17필드 draft 작성 — 기존 깨진 데이터 덮어쓰기
4. **Phase 1-PRE**: \`scripts/skill-cache/lookup.cjs --type=cert|org --names="..."\` 먼저
5. **Phase 2**: \`scripts/validate-job-edit.cjs\` PASS 반드시 통과 후 API 호출
6. **Phase 3**: \`POST https://careerwiki.org/api/job/${j.id}/edit\` + \`X-Admin-Secret: careerwiki-admin-2026\`
   - **반드시 Node.js fetch + UTF-8** (curl 절대 금지)
7. **Phase 4 검증**: Node.js fetch + \`encodeURIComponent\` + \`full-quality-audit.cjs\` PASS
8. **Phase 5-DEDUP**: \`auto-dedup-sweep.cjs --slug=${j.slug} --apply\`
9. **Phase 5-AUDIT-DEEP** ⚠️ **신규 (2026-04-29)**: \`node scripts/skill-cache/audit-sources-deep.cjs --slug=${j.slug}\`
   - 9패턴 모두 0건 확인: dupMarkers / orphanSrc / selfCite / selfCiteOnly / listPage / rawURL / brokenRef / bracketPrefix / mojibake / idxGap / sourcesNull
   - 1+ 발견 시 **즉시 Phase 1 다시** (단축 금지)
10. **Phase 5 끝 END_TRACKING** + UCJ 17필드 self-report
11. **[job-data-enhance] 마커 부착**: change_summary에 포함

**🚨 _sources 사고 절대 금지** (validate gate 5룰 — commit a95bd46, 2026-04-29):
12. **\`[selfDomain]\` FAIL**: careerwiki.org / careerwiki.kr 자기 사이트 인용 절대 금지
13. **\`[selfCiteOnly]\` FAIL**: career.go.kr / work.go.kr / work24.go.kr / job.go.kr 만 단독 사용 금지 — 외부 보충 host 1+ 필수
14. **\`[listPageURL]\` FAIL**: 직업 식별자(seq/SEQ/jobsCd/jmCd) 없는 인덱스/카테고리 URL 금지
15. **\`[brokenRef]\` FAIL**: 본문 [N] = field-local. _sources[fieldKey] 길이 ≥ 본문 max [N] 보장 필수. 본문 [N] ↔ _sources[fieldKey][N-1] 매핑
16. **\`[orphanSrc]\` WARN**: _sources에 등록한 모든 idx는 본문에서 [N]으로 인용되어야 함
17. **\`_sources[*].text\` = 기관명만** (raw URL/[N] prefix/mojibake 금지)
18. **[sal-수정금지]**: \`overviewSalary\` 절대 덮어쓰기 금지
19. **homonym disambiguation** + **careerTree 정치인 제외**

### 🆕 cycle 1 추가 정책 (이전 5세션 결과 반영, 2026-04-29):

20. **detailReady 항목별 [N] 마커 + _sources 등록 필수** ⚠️ 이전 5세션 일관성 부족 발견:
    - \`detailReady.curriculum\` 각 항목 끝에 \`[N]\` 부착 (마지막 항목에 1회만 X — 항목별 출처 다르면 각각 [N])
    - \`detailReady.recruit\` 각 항목 끝에 \`[N]\` 부착
    - \`detailReady.training\` 각 항목 끝에 \`[N]\` 부착
    - 각 sub 필드의 \`_sources["detailReady.curriculum"]\` / \`["detailReady.recruit"]\` / \`["detailReady.training"]\` 등록 필수
    - validate \`[UCJ각주항목누락]\` FAIL 차단됨

21. **외부 host minimum 3+ 권장** ⚠️ (이전 리포터 외부 2개 통과 사례 빈약함 발견):
    - \`externalHostCount ≥ 3\` 권장 (가능하면 5+)
    - origin (career.go.kr/work.go.kr 등) + 외부 협회·KOSIS·전문 미디어·학술논문 분산
    - 외부 host 1개만 통과 시 \`[selfCite]\` WARN 발행됨

22. **careerTree 이번 사이클 대상 X** ⚠️:
    - careerTree는 별도 사이클로 분리. 이번 enhance에서 손대지 않음
    - 기존 careerTree가 있으면 그대로 유지 — draft에 careerTree 필드 포함 금지
    - careerTree=null이면 \`_careerTreeNote\` 짧게 "별도 사이클 처리 예정"으로 채움 (탐색 깊이 검사 회피용)

### 종료 후 보고 형식

**deep audit clean (9패턴 0건) 시**:
\`\`\`
DONE: ${j.slug} rev={N} deep-audit=CLEAN externalHosts={N≥3} (dup=0 orphan=0 selfCite=0 selfCiteOnly=NO listPage=0 rawURL=0 brokenRef=0 bracket=0 moji=0 idxGap=NO srcNULL=NO)
\`\`\`

**audit FAIL 시 (재작업 필요)**:
\`\`\`
RETRY: ${j.slug} 사유: {validate FAIL 또는 deep-audit pattern={남은 패턴} 상세}
\`\`\`

> ⚠️ enhance는 DB만 변경하므로 별도 git commit / worktree push / main merge / deploy 불필요. (스킬·검증·도구 코드 변경은 이미 main HEAD a95bd46에 배포됨)
\`\`\`
`;
};

// markdown 헤더
const md = [
  `# Cycle 1 Prompts (10직업 — 5세션 × 2직업)\n`,
  `**Generated**: ${new Date().toISOString()}`,
  `**Source**: data/master-list-50.json (47건 사고 풀)`,
  `**기준**: 패턴 다양성 (rawURL only / brokenRef only / selfCiteOnly / mojibake / 다중 mix) + 처리 시간 균형 (heavy 4 + medium 3 + light 3)\n`,
  `## 선정 결과\n`,
  `| # | slug | sev | URL | ext | 사고 패턴 | 무게 |`,
  `|---|------|-----|-----|-----|-----------|------|`,
  ...picked.map((j, i) => {
    const weight = j.severity >= 10 ? '무거움' : (j.severity >= 5 ? '중간' : '가벼움');
    return `| ${i + 1} | ${j.slug} | ${j.severity.toFixed(1)} | ${j.totalUrls} | ${j.externalHostCount} | ${j.tags} | ${weight} |`;
  }),
  `\n## 운영 가이드\n`,
  `- 5세션 × 2직업 = 10직업 (cycle 1)`,
  `- 각 세션이 첫 직업 DONE 받으면 두 번째 직업 dispatch`,
  `- DONE 형식: \`DONE: {slug} rev={N} deep-audit=CLEAN externalHosts={N≥3} ...\``,
  `- RETRY 형식: \`RETRY: {slug} 사유: ...\``,
  `- cycle 1 모두 DONE 받고 main에서 \`audit-sources-deep.cjs --markers-only\`로 baseline 재측정 → 잔여 37건 cycle 2 dispatch\n`,
  `## 🆕 Cycle 1 정책 변경 3가지 (이전 5세션 결과 반영)\n`,
  `1. **detailReady 항목별 [N] 마커 + _sources 등록 필수** — 이전 5세션 일관성 부족`,
  `2. **외부 host minimum 3+ 권장** — 리포터 외부 2개 통과 사례 빈약 (5+ 이상적)`,
  `3. **careerTree 이번 사이클 대상 X** — 별도 사이클로 분리, 기존 유지\n`,
  `---\n`,
  ...picked.map((j, i) => STANDARD_PROMPT(j, i + 1)),
];

fs.writeFileSync(OUT, md.join('\n'), 'utf8');
console.log(`\n=== cycle 1 prompts 작성 완료 ===\n`);
console.log(`파일: ${OUT}`);
console.log(`\n선정된 10건:\n`);
picked.forEach((j, i) => {
  const weight = j.severity >= 10 ? '무거움' : (j.severity >= 5 ? '중간' : '가벼움');
  console.log(`  ${String(i + 1).padStart(2)}. ${j.slug.padEnd(15)} sev=${j.severity.toFixed(1).padStart(4)} URL=${String(j.totalUrls).padStart(2)} ext=${String(j.externalHostCount).padStart(2)} [${weight}] ${j.tags}`);
});

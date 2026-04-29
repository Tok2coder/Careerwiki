#!/usr/bin/env node
// scripts/skill-cache/build-cycle2-prompts.cjs
// cycle 2 — 5세션 × 5직업 = 25직업, single-job mode prompt 생성.
// cycle 1과 동일 형식 (Phase 0-SYNC + originDomain + Phase 4-SRC + wagework BOLD).
//
// 사용:
//   node scripts/skill-cache/build-cycle2-prompts.cjs

'use strict';

const fs = require('fs');
const path = require('path');
const REPO_ROOT = path.resolve(__dirname, '..', '..');
const MASTER = path.join(REPO_ROOT, 'data', 'master-list-50.json');
const OUT = path.join(REPO_ROOT, 'data', 'cycle2-prompts.md');

const data = JSON.parse(fs.readFileSync(MASTER, 'utf8'));

// cycle 2 — 5세션 × 5직업 분배 (severity + 패턴 다양성 + heavy/light mix).
// 세션 매핑은 cycle 1과 동일 worktree (수의사보조원/만화가/사서/경제학연구원/리포터).
const SESSIONS = [
  {
    worktree: '수의사보조원',
    jobs: [
      '서예가',         // 무거움 sev=10 — brokenRef×7/rawURL×3
      '직업상담사',      // 중간 sev=9 — brokenRef×6/rawURL×3
      '번역가',         // 중간 sev=8 — brokenRef×5/rawURL×3
      '바리스타',        // 가벼움 sev=4 — brokenRef×1/rawURL×3
      '영화시나리오작가',  // 가벼움 sev=2 — brokenRef×2/dup×4
    ],
  },
  {
    worktree: '만화가',
    jobs: [
      '재료공학기술자',     // 무거움 sev=10 — brokenRef×7/rawURL×3
      '화학공학기술자',     // 중간 sev=9 — brokenRef×6/rawURL×3
      '섬유제조기계조작원',  // 중간 sev=8 — selfCiteOnly+listPage×3
      '방송작가',         // 가벼움 sev=4 — brokenRef×1/rawURL×3
      '항공기조종사',      // 가벼움 sev=2 — rawURL×2/selfCite×4
    ],
  },
  {
    worktree: '사서',
    jobs: [
      '자동차공학기술자',   // 중간 sev=9 — brokenRef×5/rawURL×4
      '성직자',          // 중간 sev=8 — selfCiteOnly+listPage×3
      '피부관리사',        // 중간 sev=8 — brokenRef×4/rawURL×4
      '방사선과의사',      // 가벼움 sev=4 — brokenRef×4/dup×2
      '토목감리기술자',     // 가벼움 sev=3 — brokenRef×2/orphan×2/dup×4
    ],
  },
  {
    worktree: '경제학연구원',
    jobs: [
      '전자공학기술자',     // 중간 sev=9 — brokenRef×5/rawURL×4
      '유치원-원장-및-원감', // 중간 sev=8 — selfCiteOnly+listPage×3
      '외교관',          // 가벼움 sev=4 — rawURL×4/selfCite×4 (외부 host 10 풍부)
      '패션모델',         // 가벼움 sev=3 — rawURL×3/selfCite×4 (외부 host 8)
      '교도관',          // 가벼움 sev=1.5 — rawURL×1/orphan×1
    ],
  },
  {
    worktree: '리포터',
    jobs: [
      '전기가스수도관리자',  // 중간 sev=8 — selfCiteOnly+listPage×3
      '조사전문가',        // 중간 sev=8 — selfCiteOnly+listPage×3
      '선박기관사',        // 가벼움 sev=4 — brokenRef×4
      '일반의사',         // 가벼움 sev=4 — brokenRef×1/rawURL×3
      '소믈리에',         // 가벼움 sev=4 — brokenRef×1/rawURL×3
    ],
  },
];

const picked = SESSIONS.flatMap(s => s.jobs).map(slug => {
  const j = data.jobs.find(x => x.slug === slug);
  if (!j) throw new Error(`slug not found in master-list: ${slug}`);
  return j;
});

const STANDARD_PROMPT = (j, sessionLabel) => {
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

  return `### ${sessionLabel}: ${j.slug}

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

**🚨 Phase 0-SYNC (반드시 실행)**:
\`\`\`bash
git fetch origin main && git log --oneline origin/main | head -3
# main HEAD가 43a0f03 이상 확인. 미만이면 즉시 git pull origin main
# audit-sources-deep.cjs SyntaxError fix 반영됨 (43a0f03)
# 룰 13 [originDomain]: wagework.go.kr 포함 origin 1건이라도 FAIL
\`\`\`

**🚨 wagework.go.kr 명시 — 절대 origin** (사회학연구원 round 3 사고 사례):
- \`wagework.go.kr\` (한국노동연구원 임금직업정보 / 워크피디아) = career.go.kr/work.go.kr와 동일하게 origin 도메인
- **wagework은 외부 host 카운트에 절대 포함 금지** — enhance가 자주 외부로 잘못 인식
- Phase 2 validate stdout 직접 첨부해서 [originDomain] 0건 확인 (단축 처리 금지)

1. **Phase 0-PRE START_TRACKING** bash 직접 실행
2. **Phase 0-DIAG**: \`merged_profile_json\` 기준 + \`json_type\` 분기
3. **Phase 1**: 17필드 draft 작성 — 기존 깨진 데이터 덮어쓰기
4. **Phase 1-PRE**: \`scripts/skill-cache/lookup.cjs --type=cert|org --names="..."\` 먼저
5. **Phase 2**: \`scripts/validate-job-edit.cjs\` PASS 반드시 통과 후 API 호출
6. **Phase 3**: \`POST https://careerwiki.org/api/job/${j.id}/edit\` + \`X-Admin-Secret: careerwiki-admin-2026\`
   - **반드시 Node.js fetch + UTF-8** (curl 절대 금지)
7. **Phase 4 검증**: Node.js fetch + \`encodeURIComponent\` + \`full-quality-audit.cjs\` PASS
8. **Phase 5-DEDUP**: \`auto-dedup-sweep.cjs --slug=${j.slug} --apply\`
9. **Phase 5-AUDIT-DEEP**: \`node scripts/skill-cache/audit-sources-deep.cjs --slug=${j.slug}\`
   - 9패턴 + originDomain 모두 0건 확인
   - 1+ 발견 시 **즉시 Phase 1 다시** (단축 금지)
10. **Phase 5 끝 END_TRACKING** + UCJ 17필드 self-report
11. **[job-data-enhance] 마커 부착**: change_summary에 포함

**🚨 _sources 사고 절대 금지** (validate gate — commit 43a0f03):
12. **\`[selfDomain]\` FAIL**: careerwiki.org / careerwiki.kr 자기 사이트 인용 절대 금지
13. **\`[originDomain]\` FAIL** ⚠️ **격상**: career.go.kr / work.go.kr / work24.go.kr / **wagework.go.kr** / job.go.kr 및 \`*.go.kr\` + 직업키워드(job/career/work/wage/employ) — **1건이라도 즉시 FAIL**
14. **\`[listPageURL]\` FAIL**: 직업 식별자(seq/SEQ/jobsCd/jmCd) 없는 인덱스/카테고리 URL 금지
15. **\`[brokenRef]\` FAIL**: 본문 [N] = field-local. _sources[fieldKey] 길이 ≥ 본문 max [N] 보장 필수. 본문 [N] ↔ _sources[fieldKey][N-1] 매핑
16. **\`[orphanSrc]\` WARN**: _sources에 등록한 모든 idx는 본문에서 [N]으로 인용되어야 함
17. **\`_sources[*].text\` = 기관명만** (raw URL/[N] prefix/mojibake 금지)
18. **[sal-수정금지]**: \`overviewSalary\` 절대 덮어쓰기 금지
19. **homonym disambiguation** + **careerTree 정치인 제외**

### 🆕 Cycle 2 정책 (cycle 1 결과 누적 반영)

20. **detailReady 항목별 [N] 마커 + _sources 등록 필수**:
    - \`detailReady.curriculum\` / \`recruit\` / \`training\` 각 항목 끝 \`[N]\` 부착
    - 각 sub 필드 \`_sources["detailReady.X"]\` 등록 필수
    - validate \`[UCJ각주항목누락]\` FAIL 차단됨

21. **외부 host minimum 3+ 권장** (5+ 이상적):
    - 외부 1차 출처(협회·KOSIS·전문 미디어·학술논문·정부 부처 정책 페이지 등)로 구성
    - **origin 도메인은 외부 host 카운트에 포함 안 됨**

22. **careerTree 이번 사이클 대상 X**:
    - careerTree는 별도 사이클로 분리. draft에 careerTree 필드 포함 금지
    - careerTree=null이면 \`_careerTreeNote\` 짧게 "별도 사이클 처리 예정"으로 채움

### 🆕 Phase 4-SRC: 출처 검증 강제

23. **모든 _sources URL 자동 fetch + 키워드 매칭 검증 필수**:
    - status 200이 아니거나 body 비정상이면 FAIL
    - 본문 [N]에서 인용한 핵심 명사 1~2개가 출처 페이지에 등장하는지 LLM이 직접 확인
    - WebFetch 차단(SPA/한국 차단/robots) 시 LLM 자가 검증 강제 — "이 URL이 이 내용을 정말 커버하는지" 1줄 명시
    - 검증 못한 URL은 _sources에 등록 금지 — **출처 조작 절대 금지**
    - DONE 보고에 출처 검증 결과 포함

### 종료 후 보고 형식

**deep audit clean (9패턴 + originDomain 0건) 시**:
\`\`\`
DONE: ${j.slug} rev={N} deep-audit=CLEAN externalHosts={N≥3} (dup=0 orphan=0 originDomain=0 listPage=0 rawURL=0 brokenRef=0 bracket=0 moji=0 idxGap=NO srcNULL=NO)
출처 검증: N/N URL 200 OK + 키워드 매칭 PASS
\`\`\`

**audit FAIL 시**:
\`\`\`
RETRY: ${j.slug} 사유: {validate FAIL 또는 deep-audit pattern={남은 패턴} 상세}
\`\`\`

> ⚠️ enhance는 DB만 변경하므로 별도 git commit / worktree push / main merge / deploy 불필요.
\`\`\`
`;
};

// markdown header + 세션별 grouping
const md = [
  `# Cycle 2 Prompts (25직업 — 5세션 × 5직업)\n`,
  `**Generated**: ${new Date().toISOString()}`,
  `**Source**: data/master-list-50.json (47건 사고 풀, cycle 1 처리 16건 제외 → 잔여 31건 중 25건)`,
  `**main HEAD**: 43a0f03 이상 (audit-sources-deep.cjs SyntaxError fix 반영)`,
  `**운영 룰**: 한 세션 5직업, 동시 1직업 (single-job mode), 5세션 동시\n`,
  `## 세션별 분배 (5세션 × 5직업 = 25직업)\n`,
];
SESSIONS.forEach((s, sIdx) => {
  md.push(`### 세션 ${sIdx + 1}: ${s.worktree} worktree`);
  md.push(``);
  md.push(`| # | slug | sev | URL | ext | 사고 패턴 | 무게 |`);
  md.push(`|---|------|-----|-----|-----|-----------|------|`);
  s.jobs.forEach((slug, jIdx) => {
    const j = data.jobs.find(x => x.slug === slug);
    const weight = j.severity >= 9 ? '무거움' : (j.severity >= 5 ? '중간' : '가벼움');
    md.push(`| ${jIdx + 1} | ${j.slug} | ${j.severity.toFixed(1)} | ${j.totalUrls} | ${j.externalHostCount} | ${j.tags} | ${weight} |`);
  });
  md.push(``);
});
md.push(`## 운영 가이드\n`);
md.push(`- 각 세션이 직업 1개를 single-job 풀 사이클로 처리 → DONE/RETRY 보고`);
md.push(`- 오케스트레이터가 DONE 받으면 같은 세션에 다음 직업 send_message`);
md.push(`- cycle 2 (25건) 끝나면 cycle 3 (잔여 6건) 자동 dispatch`);
md.push(`- cycle 3 = 5세션 × 1.2직업 평균 (1세션이 추가 1건 처리)\n`);
md.push(`---\n`);

// 세션별 prompt 출력
SESSIONS.forEach((s, sIdx) => {
  md.push(`# 세션 ${sIdx + 1} (${s.worktree} worktree) — 5직업\n`);
  md.push(`> **dispatch 순서**: 5직업을 순차로 send_message. 첫 직업 DONE 받고 다음 직업 send.\n`);
  s.jobs.forEach((slug, jIdx) => {
    const j = data.jobs.find(x => x.slug === slug);
    md.push(STANDARD_PROMPT(j, `세션 ${sIdx + 1} — 직업 ${jIdx + 1}/5`));
  });
  md.push(`---\n`);
});

fs.writeFileSync(OUT, md.join('\n'), 'utf8');
console.log(`\n=== cycle 2 prompts 작성 완료 ===\n`);
console.log(`파일: ${OUT}`);
console.log(`\n5세션 × 5직업 = 25직업 분배:\n`);
SESSIONS.forEach((s, sIdx) => {
  console.log(`[세션 ${sIdx + 1}] ${s.worktree} worktree:`);
  s.jobs.forEach((slug, jIdx) => {
    const j = data.jobs.find(x => x.slug === slug);
    const weight = j.severity >= 9 ? '무거움' : (j.severity >= 5 ? '중간' : '가벼움');
    console.log(`   ${jIdx + 1}/5. ${j.slug.padEnd(20)} sev=${j.severity.toFixed(1).padStart(4)} URL=${String(j.totalUrls).padStart(2)} ext=${String(j.externalHostCount).padStart(2)} [${weight}] ${j.tags}`);
  });
  console.log('');
});

// cycle 3용 잔여
const used = new Set(SESSIONS.flatMap(s => s.jobs));
const CYCLE1_DONE = new Set([
  '입학사정관','보험계리사','의료코디네이터','수상운송사무원','드라마작가',
  '사회단체활동가','집배원','마취병리과의사','법원공무원','네일아티스트',
  '마케팅전문가','전문의사','방송연출가','사회학연구원','역사학연구원',
  '전화교환원'
]);
const cycle3Pool = data.jobs.filter(j => !used.has(j.slug) && !CYCLE1_DONE.has(j.slug));
console.log(`cycle 3 잔여: ${cycle3Pool.length}건`);
console.log(`잔여 직업: ${cycle3Pool.map(j => j.slug).join(', ')}`);

#!/usr/bin/env node
// scripts/skill-cache/build-cycle3-prompts.cjs
// cycle 3 — 자투리 6직업, 5세션에 1직업+1세션이 추가 1건.

'use strict';

const fs = require('fs');
const path = require('path');
const REPO_ROOT = path.resolve(__dirname, '..', '..');
const MASTER = path.join(REPO_ROOT, 'data', 'master-list-50.json');
const OUT = path.join(REPO_ROOT, 'data', 'cycle3-prompts.md');

const data = JSON.parse(fs.readFileSync(MASTER, 'utf8'));

// cycle 3 — 잔여 6건. 5세션에 1직업씩 + 1세션이 추가 1건.
// 분배 기준: 외부 host 풍부한 직업(외교관/행사기획자/교도관/기상연구원/토목공학)을
// 같은 worktree로 묶지 않도록 균형. 마지막 1건은 가장 light한 곳에.
const SESSIONS = [
  {
    worktree: '수의사보조원',
    jobs: ['행사기획자'],            // sev=4 외부 19 (가장 풍부)
  },
  {
    worktree: '만화가',
    jobs: ['전기공학기술자'],         // sev=4 외부 4
  },
  {
    worktree: '사서',
    jobs: ['기상연구원'],            // sev=1.5 외부 12
  },
  {
    worktree: '경제학연구원',
    jobs: ['섬유공학기술자'],         // sev=1 외부 3
  },
  {
    worktree: '리포터',
    jobs: ['토목공학기술자', '항공공학기술자'],  // sev=1+1 — 가벼움 2건
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
- validate FAIL 시 본문 재작성

**🚨 Phase 0-SYNC**:
\`\`\`bash
git fetch origin main && git log --oneline origin/main | head -3
# main HEAD 43a0f03 이상 확인. 미만이면 git pull origin main
\`\`\`

**🚨 wagework.go.kr 명시 — 절대 origin** (사회학연구원 round 3 사고):
- wagework은 외부 host 카운트에 절대 포함 금지
- Phase 2 validate stdout 첨부 강제

1. **Phase 0-PRE START_TRACKING** bash 직접 실행
2. **Phase 0-DIAG**: \`merged_profile_json\` 기준
3. **Phase 1**: 17필드 draft 작성
4. **Phase 1-PRE**: \`lookup.cjs --type=cert|org\` 먼저
5. **Phase 2**: \`validate-job-edit.cjs\` PASS + stdout 첨부
6. **Phase 3**: \`POST https://careerwiki.org/api/job/${j.id}/edit\` (Node.js fetch + UTF-8)
7. **Phase 4**: \`full-quality-audit.cjs\` PASS
8. **Phase 5-DEDUP**: \`auto-dedup-sweep.cjs --slug=${j.slug} --apply\`
9. **Phase 5-AUDIT-DEEP**: \`audit-sources-deep.cjs --slug=${j.slug}\`, 9패턴+originDomain=0
10. **END_TRACKING** + UCJ 17필드 self-report
11. **[job-data-enhance] 마커 부착**

**🚨 _sources 사고 절대 금지** (validate gate — commit 43a0f03):
12-19. selfDomain / **originDomain (wagework 1건이라도 FAIL)** / listPageURL / brokenRef / orphanSrc / text=기관명 / sal-수정금지 / homonym + careerTree 정치인

### 🆕 Cycle 정책
20. detailReady 항목별 [N] + _sources 등록 필수
21. 외부 host minimum 3+ (origin 카운트 안 됨)
22. careerTree 손대지 않음
23. Phase 4-SRC URL fetch + 키워드 매칭 검증

### 종료 후 보고
**clean 시**:
\`\`\`
DONE: ${j.slug} rev={N} deep-audit=CLEAN externalHosts={N≥3} (dup=0 orphan=0 originDomain=0 listPage=0 rawURL=0 brokenRef=0 bracket=0 moji=0 idxGap=NO srcNULL=NO)
출처 검증: N/N URL 200 OK + 키워드 매칭 PASS
\`\`\`

**FAIL 시**: \`RETRY: ${j.slug} 사유: {...}\`

> ⚠️ enhance는 DB만 변경 — git/deploy 불필요
\`\`\`
`;
};

const md = [
  `# Cycle 3 Prompts (6직업 — 자투리 마지막 사이클)\n`,
  `**Generated**: ${new Date().toISOString()}`,
  `**Source**: data/master-list-50.json — cycle 1 (16) + cycle 2 (25) 후 잔여 6건`,
  `**main HEAD**: 43a0f03 이상 (cycle 2와 동일)`,
  `**운영 룰**: 4세션 × 1직업 + 1세션 × 2직업 (리포터 worktree가 자투리 1건 처리)\n`,
  `## 세션별 분배 (cycle 3 = 6직업)\n`,
];
SESSIONS.forEach((s, sIdx) => {
  md.push(`### 세션 ${sIdx + 1}: ${s.worktree} worktree (${s.jobs.length}직업)`);
  md.push(``);
  md.push(`| # | slug | sev | URL | ext | 사고 패턴 |`);
  md.push(`|---|------|-----|-----|-----|-----------|`);
  s.jobs.forEach((slug, jIdx) => {
    const j = data.jobs.find(x => x.slug === slug);
    md.push(`| ${jIdx + 1} | ${j.slug} | ${j.severity.toFixed(1)} | ${j.totalUrls} | ${j.externalHostCount} | ${j.tags} |`);
  });
  md.push(``);
});
md.push(`## 운영 가이드\n`);
md.push(`- cycle 2 끝나면 자동 cycle 3 dispatch (사용자 GO 안 기다림)`);
md.push(`- 세션 5 (리포터 worktree)가 토목공학+항공공학 2건 처리 (둘 다 sev=1, 가벼운 작업)`);
md.push(`- cycle 3 끝나면 master-list-50 47건 모두 처리 완료\n`);
md.push(`---\n`);

SESSIONS.forEach((s, sIdx) => {
  md.push(`# 세션 ${sIdx + 1} (${s.worktree} worktree) — ${s.jobs.length}직업\n`);
  s.jobs.forEach((slug, jIdx) => {
    const j = data.jobs.find(x => x.slug === slug);
    md.push(STANDARD_PROMPT(j, `세션 ${sIdx + 1} — 직업 ${jIdx + 1}/${s.jobs.length}`));
  });
  md.push(`---\n`);
});

fs.writeFileSync(OUT, md.join('\n'), 'utf8');
console.log(`\n=== cycle 3 prompts 작성 완료 ===\n`);
console.log(`파일: ${OUT}`);
console.log(`\n5세션 × 평균 1.2직업 = 6직업 분배:\n`);
SESSIONS.forEach((s, sIdx) => {
  console.log(`[세션 ${sIdx + 1}] ${s.worktree} worktree (${s.jobs.length}직업):`);
  s.jobs.forEach((slug, jIdx) => {
    const j = data.jobs.find(x => x.slug === slug);
    console.log(`   ${jIdx + 1}/${s.jobs.length}. ${j.slug.padEnd(20)} sev=${j.severity.toFixed(1).padStart(4)} URL=${String(j.totalUrls).padStart(2)} ext=${String(j.externalHostCount).padStart(2)} | ${j.tags}`);
  });
  console.log('');
});

#!/usr/bin/env node
// scripts/skill-cache/dispatch-next-9.cjs
// 마스터 리스트에서 다음 9개 enhance 후보 추출 + dispatch prompt 생성.
//
// 정책:
//   1) A 카테고리 (마커 보유 + 부분 보강) 우선 — 누락 필드 적은 순
//   2) B_light (마커 없음 + 1-2 누락) 다음 — 빠른 보강 가능
//   3) B_heavy (마커 없음 + 3+ 누락) 마지막 — 풀 사이클
//
// 사용:
//   node scripts/skill-cache/dispatch-next-9.cjs                (다음 9개 + dispatch prompt)
//   node scripts/skill-cache/dispatch-next-9.cjs --cohort=IT/SW (특정 cohort)
//   node scripts/skill-cache/dispatch-next-9.cjs --skip=N       (앞 N개 건너뜀)
//   node scripts/skill-cache/dispatch-next-9.cjs --json         (JSON만 출력)

const fs = require('fs');
const path = require('path');

const REPO_ROOT = path.resolve(__dirname, '..', '..');
const MASTER_PATH = path.join(REPO_ROOT, 'data', 'enhance-master-list.json');

const args = process.argv.slice(2).reduce((acc, a) => {
  const m = a.match(/^--([^=]+)(?:=(.+))?$/);
  if (m) acc[m[1]] = m[2] ?? true;
  return acc;
}, {});

const SKIP = parseInt(args.skip || '0');
const PICK = 9;

if (!fs.existsSync(MASTER_PATH)) {
  console.error(`마스터 리스트 부재: ${MASTER_PATH}`);
  console.error('먼저 실행: node scripts/skill-cache/build-master-list.cjs');
  process.exit(2);
}
const master = JSON.parse(fs.readFileSync(MASTER_PATH, 'utf8'));

// 우선순위 큐 — A → B_light → B_heavy
const queue = [
  ...master.category_a_field_only.map(j => ({ ...j, _src: 'A' })),
  ...master.category_b_light.map(j => ({ ...j, _src: 'B_light' })),
  ...master.category_b_heavy.map(j => ({ ...j, _src: 'B_heavy' })),
];

// cohort 필터
let pool = queue;
if (args.cohort) {
  pool = queue.filter(j => j.cohort === args.cohort);
  if (pool.length === 0) {
    console.error(`cohort '${args.cohort}'에 해당 직업 없음. 가능 cohort:`);
    const cohorts = [...new Set(queue.map(j => j.cohort))].sort();
    cohorts.forEach(c => console.error(`  ${c}`));
    process.exit(2);
  }
}

const picked = pool.slice(SKIP, SKIP + PICK);

if (picked.length === 0) {
  console.error('큐 소진 — 모든 직업 처리 완료 (또는 SKIP이 너무 큼).');
  process.exit(0);
}

if (args.json) {
  console.log(JSON.stringify({ skip: SKIP, picked: picked.length, items: picked }, null, 2));
  process.exit(0);
}

// 응집도 grouping — 같은 cohort 직업끼리 묶기 (3개 단위)
const cohortGroups = {};
for (const item of picked) {
  if (!cohortGroups[item.cohort]) cohortGroups[item.cohort] = [];
  cohortGroups[item.cohort].push(item);
}
const sortedCohorts = Object.entries(cohortGroups).sort((a, b) => b[1].length - a[1].length);

console.log(`=== 다음 9개 enhance 후보 (skip=${SKIP}) ===\n`);

console.log('## 직업별 권고\n');
console.log('| # | slug | 카테고리 | sal | 누락 필드 | --field-only | cohort |');
console.log('|---|------|----------|-----|-----------|--------------|--------|');
picked.forEach((item, i) => {
  const fo = item.field_only_csv || '(없음 — 마커 부착)';
  const mode = item._src === 'B_heavy' ? '풀 사이클' : `--field-only=${fo}`;
  console.log(`| ${i + 1} | ${item.slug} | ${item._src} | ${item.sal_status} | ${item.missing_fields.join(', ')} | ${mode} | ${item.cohort} |`);
});

console.log('\n## 응집도 cohort 묶음\n');
for (const [cohort, items] of sortedCohorts) {
  console.log(`### ${cohort} (${items.length}개)`);
  items.forEach(it => console.log(`  - ${it.slug} (${it._src}, missing=${it.missing_fields.length})`));
}

console.log('\n## 표준 룰 (subagent dispatch 시 prompt 포함)\n');
console.log(`1. **Phase 0-DIAG 강화**: \`json_type\` 분기 + text 형식은 \`length()\` 검사`);
console.log(`2. **Phase 0-PRE START_TRACKING** bash 직접 실행 — \`data/skill-runs.jsonl\` append`);
console.log(`3. **Phase 0-MODE**: A·B_light → \`--field-only=<csv>\` / B_heavy → 풀 사이클`);
console.log(`4. **Phase 1-PRE**: \`scripts/skill-cache/lookup.cjs --type=cert|org\` 먼저`);
console.log(`5. **Phase 5-DEDUP**: \`scripts/skill-cache/auto-dedup-sweep.cjs --slug=<slug> --apply\``);
console.log(`6. **Phase 5 끝 END_TRACKING** bash 직접 실행`);
console.log(`7. **[sal-수정금지]**: \`overviewSalary\` 절대 덮어쓰기 금지`);
console.log(`8. **homonym disambiguation**: 슬러그 별 RULE 0 12케이스 + audit-image-prompts 사전`);
console.log(`9. **careerTree 정치인 제외**: 역대 대통령 절대, 다른 정치인 직업 적합성 검토 후`);
console.log(`10. **편집 API**: POST \`https://careerwiki.org/api/job/{id}/edit\` + \`X-Admin-Secret: careerwiki-admin-2026\``);
console.log(`11. **Phase 4 검증**: Node.js fetch + encodeURIComponent (curl 한글 URL 절대 금지)`);

console.log('\n## 다음 batch 발굴 명령\n');
console.log(`\`\`\`bash`);
console.log(`node scripts/skill-cache/dispatch-next-9.cjs --skip=${SKIP + PICK}`);
console.log(`\`\`\``);
console.log(`\n남은 큐: ${pool.length - SKIP - picked.length}개 (전체 ${pool.length})`);

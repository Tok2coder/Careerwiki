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

// 3개씩 3 batch로 묶기 — 같은 cohort 우선 묶음, fallback은 순차
function buildBatches(items) {
  const batches = [[], [], []];
  // 1) cohort 단위로 ≥3개인 그룹 우선 배정
  const remaining = [...items];
  let bi = 0;
  for (const [cohort, group] of sortedCohorts) {
    if (group.length >= 3 && bi < 3) {
      batches[bi] = group.slice(0, 3);
      // remove from remaining
      for (const it of batches[bi]) {
        const idx = remaining.indexOf(it);
        if (idx !== -1) remaining.splice(idx, 1);
      }
      bi++;
    }
  }
  // 2) 남은 배치는 순차 (mixed)
  while (bi < 3 && remaining.length > 0) {
    batches[bi] = remaining.splice(0, 3);
    bi++;
  }
  return batches.filter(b => b.length > 0);
}
const batches = buildBatches(picked);

// 직업별 careerTree 인물 hint (cohort 기반 — 정치인 제외 룰 적용)
function careerTreeHint(slug, cohort) {
  if (cohort === '의료/보건') return '의대 교수·해외 의사 (정치인 제외)';
  if (cohort === 'IT/SW') return '국내외 SW 엔지니어·CTO (예: 이해진, 김범수 등 검증 후)';
  if (cohort === '디자인/예술') return '국내 디자이너·예술인 (정치 활동 없는 인물)';
  if (cohort === '학자/연구') return '학회 회장·정부출연연 원장·해외 석학';
  if (cohort === '미디어/방송') return '기자·PD·작가 (방송 활동 우선, 정치 활동 회피)';
  if (cohort === '스포츠') return '국가대표·올림픽 메달리스트·코치';
  if (cohort === '법조') return '판사·변호사 (정치인 전향 인물 회피)';
  if (cohort === '금융') return '은행장·증권사 임원·CFO';
  if (cohort === '동물/반려') return '수의사·동물 행동 전문가';
  if (cohort === '식음료/요식') return '셰프·바리스타 챔피언·미슐랭 인증';
  if (cohort === '미용/뷰티') return 'K-뷰티 아티스트·인플루언서 (검증된 직업 활동)';
  return '직업 도메인 인물 (역대 대통령 절대 제외, 다른 정치인은 직업 적합성 검토)';
}

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

// === 3 batch subagent dispatch prompt (즉시 페이스트 가능) ===
const STANDARD_RULES = `### 표준 룰 (필수 준수)
1. **Phase 0-DIAG**: \`merged_profile_json\` 기준 + \`json_type\` 분기 — text 형식은 \`length()\` 검사
2. **Phase 0-PRE START_TRACKING** bash 직접 실행 — \`data/skill-runs.jsonl\` append 의무
3. **Phase 0-MODE**: A·B_light → \`--field-only=<csv>\` 부분 보강 / B_heavy → 풀 사이클
4. **Phase 1-PRE**: \`scripts/skill-cache/lookup.cjs --type=cert|org --names="..."\` 먼저 (LLM WebFetch 전)
5. **Phase 5-DEDUP**: \`scripts/skill-cache/auto-dedup-sweep.cjs --slug=<slug> --apply\` END_TRACKING 전
6. **Phase 5 끝 END_TRACKING** bash 직접 실행
7. **[sal-수정금지]**: \`overviewSalary\` 절대 덮어쓰기 금지
8. **homonym disambiguation**: SKILL.md RULE 0 12케이스 + \`audit-image-prompts.cjs\` 사전 점검
9. **careerTree 정치인 제외**: 역대 대통령 절대 제외, 다른 정치인은 직업 적합성 검토 후
10. **편집 API**: \`POST https://careerwiki.org/api/job/{id}/edit\` + 헤더 \`X-Admin-Secret: careerwiki-admin-2026\` (fields+sources 동시 전송)
11. **Phase 4 검증**: Node.js fetch + \`encodeURIComponent\` (curl 한글 URL 절대 금지)
12. **검증 통과 게이트**: \`full-quality-audit.cjs\` PASS + UCJ 17필드 self-report`;

console.log('\n---\n');
console.log('## 🚀 Subagent dispatch prompts (3 batch — 즉시 페이스트)\n');
batches.forEach((batch, idx) => {
  // batch cohort 추론 — 동일 cohort면 표시, 아니면 mixed
  const cohorts = [...new Set(batch.map(j => j.cohort))];
  const batchTitle = cohorts.length === 1 ? cohorts[0] : `mixed (${cohorts.join(' / ')})`;
  console.log(`### 배치 ${idx + 1} · ${batchTitle} (${batch.length}개)\n`);
  console.log('```');
  console.log(`/job-data-enhance 다음 ${batch.length}개 직업 enhance 처리.`);
  console.log('');
  batch.forEach(item => {
    const mode = item._src === 'B_heavy' ? '풀 사이클' : `--field-only=${item.field_only_csv}`;
    console.log(`### ${item.slug} (id=${item.id})`);
    console.log(`- 카테고리: ${item._src} | sal: ${item.sal_status} | missing: ${item.missing_fields.join(', ')}`);
    console.log(`- 모드: ${mode}`);
    if (item.missing_fields.includes('careerTree')) {
      console.log(`- careerTree 인물 권고: ${careerTreeHint(item.slug, item.cohort)}`);
    }
    if (item.missing_fields.includes('sidebarOrgs') || item.missing_fields.includes('sidebarCerts')) {
      const types = [];
      if (item.missing_fields.includes('sidebarOrgs')) types.push('org');
      if (item.missing_fields.includes('sidebarCerts')) types.push('cert');
      console.log(`- URL 룩업: \`node scripts/skill-cache/lookup.cjs --type=${types.join('|')} --names="..."\``);
    }
    console.log('');
  });
  console.log(STANDARD_RULES);
  console.log('');
  console.log('각 직업 처리 후 Phase 5 검증 통과 + END_TRACKING 호출 + 최종 self-report 17필드 표.');
  console.log('```\n');
});

console.log('\n## 다음 batch 발굴 명령\n');
console.log(`\`\`\`bash`);
console.log(`node scripts/skill-cache/dispatch-next-9.cjs --skip=${SKIP + PICK}`);
console.log(`\`\`\``);
console.log(`\n남은 큐: ${pool.length - SKIP - picked.length}개 (전체 ${pool.length})`);

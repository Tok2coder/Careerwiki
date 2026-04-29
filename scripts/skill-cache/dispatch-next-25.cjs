#!/usr/bin/env node
// scripts/skill-cache/dispatch-next-25.cjs
// 5 세션 × 5 직업 enhance dispatch helper.
//
// 모드:
//   --cohort-priority : 인기 cohort 우선 (의료/보건 → IT/SW → 디자인/예술 → 금융 → 학자/연구)
//   --cohort=<name>   : 단일 cohort
//   (default)         : 우선순위 큐 (A → B_light → B_heavy)
//
// 사용:
//   node scripts/skill-cache/dispatch-next-25.cjs                            (default 25개)
//   node scripts/skill-cache/dispatch-next-25.cjs --cohort-priority          (인기 cohort 25개)
//   node scripts/skill-cache/dispatch-next-25.cjs --cohort=의료/보건 --skip=0
//   node scripts/skill-cache/dispatch-next-25.cjs --skip=25                  (다음 25)
//   node scripts/skill-cache/dispatch-next-25.cjs --stagger=30               (세션 dispatch 권장 간격 표시)
//   node scripts/skill-cache/dispatch-next-25.cjs --json                     (JSON만)

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
const PICK = 25;
const SESSIONS = 5;
const PER_SESSION = 5;
const STAGGER = parseInt(args.stagger || '30');

// 인기 cohort 우선순위 (10 cohort)
const COHORT_PRIORITY = [
  '의료/보건', 'IT/SW', '디자인/예술', '금융', '학자/연구',
  '미디어/방송', '운송/물류', '기계/정비', '법조', '기타 서비스',
];

if (!fs.existsSync(MASTER_PATH)) {
  console.error(`마스터 리스트 부재: ${MASTER_PATH}`);
  console.error('먼저 실행: node scripts/skill-cache/build-master-list.cjs');
  process.exit(2);
}
const master = JSON.parse(fs.readFileSync(MASTER_PATH, 'utf8'));

// 사용자 KPI = 마커 적용 여부 (admin "스킬 적용" 컬럼).
// 처리 대상 = 마커 미적용 직업 (B_light + B_heavy = 6650).
// A 카테고리는 이미 마커 보유 → 기본 skip.
// `--include-a` 명시 시에만 A 포함.
const includeA = !!args['include-a'];

const queue = includeA
  ? [
      ...master.category_a_field_only.map(j => ({ ...j, _src: 'A' })),
      ...master.category_b_light.map(j => ({ ...j, _src: 'B_light' })),
      ...master.category_b_heavy.map(j => ({ ...j, _src: 'B_heavy' })),
    ]
  : [
      ...master.category_b_light.map(j => ({ ...j, _src: 'B_light' })),
      ...master.category_b_heavy.map(j => ({ ...j, _src: 'B_heavy' })),
    ];

// 모드별 pool 결정
let pool;
if (args.cohort) {
  pool = queue.filter(j => j.cohort === args.cohort);
  if (pool.length === 0) {
    console.error(`cohort '${args.cohort}'에 해당 직업 없음. 가능 cohort:`);
    [...new Set(queue.map(j => j.cohort))].sort().forEach(c => console.error(`  ${c}`));
    process.exit(2);
  }
} else if (args['cohort-priority']) {
  // 우선순위 cohort 직업 + cohort 순서 정렬
  pool = queue.filter(j => COHORT_PRIORITY.includes(j.cohort));
  pool.sort((a, b) => {
    const ca = COHORT_PRIORITY.indexOf(a.cohort);
    const cb = COHORT_PRIORITY.indexOf(b.cohort);
    if (ca !== cb) return ca - cb;
    return a.missing_fields.length - b.missing_fields.length;
  });
} else {
  pool = queue;
}

const picked = pool.slice(SKIP, SKIP + PICK);

if (picked.length === 0) {
  console.error('큐 소진 — 모든 직업 처리 완료 (또는 SKIP이 너무 큼).');
  process.exit(0);
}

if (args.json) {
  console.log(JSON.stringify({ skip: SKIP, mode: args['cohort-priority'] ? 'cohort-priority' : (args.cohort || 'default'), picked: picked.length, items: picked }, null, 2));
  process.exit(0);
}

// 5 세션 × 5 직업 분할 — cohort 경계 안 넘김
function buildSessions(items) {
  const sessions = [];
  const remaining = [...items];

  // cohort별 그룹화
  const byCohort = {};
  for (const it of remaining) {
    if (!byCohort[it.cohort]) byCohort[it.cohort] = [];
    byCohort[it.cohort].push(it);
  }

  // cohort 우선순위 (priority 모드면 COHORT_PRIORITY 순서, 아니면 빈도 순)
  const cohortKeys = args['cohort-priority']
    ? COHORT_PRIORITY.filter(c => byCohort[c])
    : Object.keys(byCohort).sort((a, b) => byCohort[b].length - byCohort[a].length);

  // 각 cohort에서 5개 단위로 세션 생성 — 5개 안 되면 mixed로 합침
  const buffer = []; // mixed용 잔여 직업
  for (const cohort of cohortKeys) {
    const group = byCohort[cohort];
    while (group.length >= PER_SESSION && sessions.length < SESSIONS) {
      sessions.push({ cohort, items: group.splice(0, PER_SESSION) });
    }
    // 5개 미만 잔여는 buffer로
    buffer.push(...group);
  }

  // buffer를 mixed 세션으로 묶기 (5개씩)
  while (buffer.length > 0 && sessions.length < SESSIONS) {
    const slice = buffer.splice(0, PER_SESSION);
    const cohorts = [...new Set(slice.map(i => i.cohort))];
    sessions.push({
      cohort: cohorts.length === 1 ? cohorts[0] : `mixed (${cohorts.join(' / ')})`,
      items: slice,
    });
  }
  return sessions;
}

const sessions = buildSessions(picked);

// careerTree 인물 hint (cohort 기반)
function careerTreeHint(slug, cohort) {
  if (cohort === '의료/보건') return '의대 교수·병원장·해외 의사 (정치인 전향자 회피)';
  if (cohort === 'IT/SW') return '국내외 SW 엔지니어·CTO·창업자 (예: 이해진, 김범수 등 검증 후)';
  if (cohort === '디자인/예술') return '국내외 디자이너·예술인 (정치 활동 없는 인물)';
  if (cohort === '학자/연구') return '학회 회장·정부출연연 원장·해외 석학';
  if (cohort === '미디어/방송') return '기자·PD·작가 (방송 활동 우선)';
  if (cohort === '스포츠') return '국가대표·올림픽 메달리스트·코치';
  if (cohort === '법조') return '판사·변호사 (정치인 전향 인물 회피)';
  if (cohort === '금융') return '은행장·증권사 임원·CFO·재무담당';
  if (cohort === '동물/반려') return '수의사·동물 행동 전문가';
  if (cohort === '식음료/요식') return '셰프·바리스타 챔피언·미슐랭 인증';
  if (cohort === '미용/뷰티') return 'K-뷰티 아티스트·인플루언서 (검증된 직업 활동)';
  if (cohort === '관광/호텔') return '호텔 대표·관광 명장·여행 인플루언서';
  if (cohort === '건축/건설') return '건축가·시공 명장·문화재 수리 전문';
  if (cohort === '기계/정비') return '기능 명장·정비 전문 인플루언서';
  if (cohort === '운송/물류') return '운송업 임원·전문 드라이버';
  if (cohort === '농림수산') return '농부·어부·임업인 (검증된 직업 활동)';
  if (cohort === '교육') return '교사·교수·강사 (정치 활동 회피)';
  return '직업 도메인 인물 (역대 대통령 절대 제외, 다른 정치인은 직업 적합성 검토)';
}

// homonym 주의 사전 (자주 등장 동음이의)
const HOMONYM_NOTES = {
  '신부': '신부=Catholic priest (NOT bride)',
  '검사': '검사=prosecutor (NOT inspection/test)',
  '약사': '약사=pharmacist',
  '사육사': '사육사=animal trainer at zoo',
  '모델': '모델=runway model (NOT 3D model/schema)',
  '박사': '박사=PhD scholar (NOT medical doctor)',
  '강사': '강사=lecturer/instructor',
  '기사': '기사=technician/engineer/driver (NOT newspaper article)',
  '심판': '심판=sports referee (NOT courtroom judge)',
  '감독': '감독=film director or sports head coach',
  '간호사': '간호사 ↔ 간호조무사 ↔ 간호인 분리 직업',
  '수의사': '수의사 ↔ 수의사보조원 ↔ 수의테크니션 분리',
  '간판': '간판제작 vs 광고 디자인 분리',
};

const STANDARD_RULES = `### 표준 룰 (필수 준수 — 모든 5 직업 공통, 풀 사이클 Phase 0~5)
1. **Phase 0-PRE START_TRACKING** bash 직접 실행 — \`data/skill-runs.jsonl\` append 의무
2. **Phase 0-DIAG**: \`merged_profile_json\` 기준 + \`json_type\` 분기 — text 형식은 \`length()\` 검사
3. **Phase 1**: 17필드 draft 작성 (모든 누락 필드 보강 — way·trivia·sidebarOrgs/Certs·youtubeLinks·careerTree 등)
4. **Phase 1-PRE**: \`scripts/skill-cache/lookup.cjs --type=cert|org --names="..."\` 먼저 (LLM WebFetch 전)
5. **Phase 2**: \`scripts/validate-job-edit.cjs\` PASS 통과 후 편집 API 호출
6. **Phase 3**: \`POST https://careerwiki.org/api/job/{id}/edit\` + 헤더 \`X-Admin-Secret: careerwiki-admin-2026\` (fields+sources 동시 전송)
7. **Phase 4 검증**: Node.js fetch + \`encodeURIComponent\` (curl 한글 URL 절대 금지) + \`full-quality-audit.cjs\` PASS
8. **Phase 5-DEDUP**: \`scripts/skill-cache/auto-dedup-sweep.cjs --slug=<slug> --apply\` END_TRACKING 전
9. **Phase 5 끝 END_TRACKING** bash 직접 실행 + UCJ 17필드 self-report
10. **[job-data-enhance] 마커 부착**: change_summary에 \`[job-data-enhance]\` 포함 — 사용자 KPI 게이트
11. **[sal-수정금지]**: \`overviewSalary\` 절대 덮어쓰기 금지 (sal=NULL이면 보강 안 함)
12. **homonym disambiguation**: SKILL.md RULE 0 12케이스 + \`audit-image-prompts.cjs\` 사전 점검
13. **careerTree 정치인 제외**: 역대 대통령 절대, 다른 정치인은 직업 적합성 검토 후`;

console.log(`=== 다음 ${PICK}개 enhance 후보 (skip=${SKIP}, ${args['cohort-priority'] ? 'cohort-priority' : (args.cohort ? `cohort=${args.cohort}` : 'default')}, mode=풀 사이클${includeA ? ', include-A' : ''}) ===\n`);
console.log(`사용자 KPI: [job-data-enhance] 마커 적용 (admin "스킬 적용" 컬럼). 마커 미적용 직업만 처리.`);
console.log(`5 세션 × 5 직업 분할 / 권장 stagger: ${STAGGER}초\n`);

console.log('## 직업별 권고 표 (전체 25개 — 모두 풀 사이클)\n');
console.log('| # | slug | cat | sal | 참고 누락 (보강 대상) | cohort |');
console.log('|---|------|-----|-----|----------------------|--------|');
picked.forEach((item, i) => {
  console.log(`| ${i + 1} | ${item.slug} | ${item._src} | ${item.sal_status} | ${item.missing_fields.join(', ')} | ${item.cohort} |`);
});

// 5 세션 dispatch prompts
console.log('\n---\n## 🚀 5 세션 dispatch prompts (즉시 페이스트, 모두 풀 사이클)\n');
console.log(`**권장 stagger**: 각 세션 dispatch 사이 ${STAGGER}초 간격 (burst rate limit 회피)\n`);

sessions.forEach((sess, idx) => {
  console.log(`### 세션 ${idx + 1} · ${sess.cohort} (${sess.items.length}개)\n`);
  console.log('```');
  console.log(`/job-data-enhance 다음 ${sess.items.length}개 직업 풀 사이클 (Phase 0~5) enhance 처리 (cohort: ${sess.cohort}).`);
  console.log(`목표: [job-data-enhance] 마커 부착 + 17필드 보완 + admin "스킬 적용" 컬럼 ✓.`);
  console.log('');
  sess.items.forEach((item) => {
    const url = `https://careerwiki.org/job/${item.slug}`;
    console.log(`### ${item.slug} (id=${item.id})`);
    console.log(`- URL: ${url}`);
    console.log(`- 카테고리: ${item._src} | sal: ${item.sal_status} | 참고 누락: ${item.missing_fields.join(', ')}`);
    if (item.missing_fields.includes('careerTree')) {
      console.log(`- careerTree 인물 권고: ${careerTreeHint(item.slug, item.cohort)}`);
    }
    if (item.missing_fields.includes('sidebarOrgs') || item.missing_fields.includes('sidebarCerts')) {
      const types = [];
      if (item.missing_fields.includes('sidebarOrgs')) types.push('org');
      if (item.missing_fields.includes('sidebarCerts')) types.push('cert');
      console.log(`- URL 룩업 권장: \`node scripts/skill-cache/lookup.cjs --type=${types.join('|')} --names="..."\``);
    }
    if (HOMONYM_NOTES[item.slug]) {
      console.log(`- ⚠️ homonym 주의: ${HOMONYM_NOTES[item.slug]}`);
    }
    console.log('');
  });
  console.log(STANDARD_RULES);
  console.log('');
  console.log('각 직업 처리 후 Phase 5 검증 통과 + END_TRACKING 호출 + 17필드 self-report + [job-data-enhance] 마커 확인.');
  console.log('```\n');
});

// JSON 파일 저장 (자동화·재현 가능성 위해)
if (args['save-batch']) {
  const batchN = args['save-batch'];
  const batchPath = path.join(REPO_ROOT, 'data', `dispatch-batch-${batchN}.json`);
  fs.writeFileSync(batchPath, JSON.stringify({
    generated_at: new Date().toISOString(),
    skip: SKIP,
    mode: args['cohort-priority'] ? 'cohort-priority' : (args.cohort || 'default'),
    include_a: includeA,
    pool_size: pool.length,
    sessions: sessions.map((s, i) => ({
      session_num: i + 1,
      cohort: s.cohort,
      items: s.items,
    })),
  }, null, 2));
  console.log(`💾 JSON 저장: data/dispatch-batch-${batchN}.json`);
}

console.log('---\n');
console.log(`## 운영 가이드\n`);
console.log(`### 5 세션 동시 운영`);
console.log(`- 세션 1 dispatch → ${STAGGER}초 대기 → 세션 2 dispatch → ... → 세션 5`);
console.log(`- 권장 이유: 5 세션 동시 dispatch 시 API rate limit (burst 5/min 등) 또는 D1 동시성 conflict 회피`);
console.log(`- 세션당 진행 시간 추산 (풀 사이클): B_light 4-6분/직업 / B_heavy 6-10분/직업`);
console.log(`- 5 직업 세션당 시간: B_light 20-30분 / B_heavy 30-50분`);
console.log('');
console.log(`### 다음 batch 발굴 명령`);
console.log(`\`\`\`bash`);
console.log(`node scripts/skill-cache/dispatch-next-25.cjs --skip=${SKIP + PICK}${args['cohort-priority'] ? ' --cohort-priority' : ''}${args.cohort ? ` --cohort=${args.cohort}` : ''}`);
console.log(`\`\`\``);
console.log('');
console.log(`### 큐 진행 상태`);
console.log(`- 현재 모드 풀 크기: ${pool.length}`);
console.log(`- 처리 완료: ${SKIP + picked.length}`);
console.log(`- 남은 큐: ${pool.length - SKIP - picked.length}`);
console.log(`- 전체 enhance 후보: ${queue.length}`);

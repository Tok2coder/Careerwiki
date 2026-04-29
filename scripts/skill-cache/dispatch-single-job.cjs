#!/usr/bin/env node
// scripts/skill-cache/dispatch-single-job.cjs
// 1 직업 단일 dispatch prompt 생성 — 디스패처(orchestrator)가 5 세션에 1직업/세션 배정 + DONE/RETRY 보고 후 다음 배정.
//
// queue: data/dispatch-queue.json (retry → master_cohort 우선순위)
//
// 사용:
//   node scripts/skill-cache/dispatch-single-job.cjs                       (queue 다음 1 직업)
//   node scripts/skill-cache/dispatch-single-job.cjs --skip=N              (앞 N 건너뜀)
//   node scripts/skill-cache/dispatch-single-job.cjs --pick=5              (앞 5건 한꺼번에 출력 — 5 세션 동시 dispatch용)
//   node scripts/skill-cache/dispatch-single-job.cjs --slug=조선공학기술자  (특정 직업)
//   node scripts/skill-cache/dispatch-single-job.cjs --queue=retry         (retry만)
//   node scripts/skill-cache/dispatch-single-job.cjs --queue=master_cohort (master만)
//   node scripts/skill-cache/dispatch-single-job.cjs --json

const fs = require('fs');
const path = require('path');

const REPO_ROOT = path.resolve(__dirname, '..', '..');
const QUEUE_PATH = path.join(REPO_ROOT, 'data', 'dispatch-queue.json');
const args = process.argv.slice(2).reduce((acc, a) => {
  const m = a.match(/^--([^=]+)(?:=(.+))?$/);
  if (m) acc[m[1]] = m[2] ?? true;
  return acc;
}, {});

const SKIP = parseInt(args.skip || '0');
const PICK = parseInt(args.pick || '1');
const QUEUE = args.queue || 'retry';

if (!fs.existsSync(QUEUE_PATH)) {
  console.error(`queue 부재: ${QUEUE_PATH}`);
  console.error('먼저 생성: data/dispatch-queue.json (retry/master_cohort/completed/failed 구조)');
  process.exit(2);
}
const queue = JSON.parse(fs.readFileSync(QUEUE_PATH, 'utf8'));

// master-list fallback (queue.master_cohort 비어있을 때)
//   - data/enhance-master-list.json 사용
//   - cohort 우선순위: 의료/보건 → IT/SW → 디자인/예술 → 금융 → 학자/연구 → 미디어/방송 → 운송/물류 → 기계/정비 → 법조 → 기타 서비스
//   - 각 cohort 내 우선순위: A 카테고리(마커 보유 + 부분 보강) → B_light → B_heavy
//   - 이미 retry queue에 있던 직업은 제외
const COHORT_PRIORITY = [
  '의료/보건', 'IT/SW', '디자인/예술', '금융', '학자/연구',
  '미디어/방송', '운송/물류', '기계/정비', '법조', '기타 서비스',
];

function loadMasterCohort() {
  const masterPath = path.join(REPO_ROOT, 'data', 'enhance-master-list.json');
  if (!fs.existsSync(masterPath)) return [];
  const master = JSON.parse(fs.readFileSync(masterPath, 'utf8'));
  // 사용자 KPI = [job-data-enhance] 마커 적용 여부.
  // A 카테고리는 이미 마커 보유 (사용자 정책: 마커 미적용 직업만 처리).
  // 기본: B_light + B_heavy + A_marker_pending (마커 부착만 필요한 25)
  // --include-a 옵션 시 A 포함
  const includeA = !!args['include-a'];
  const all = includeA
    ? [
        ...((master.category_a_field_only || []).map(j => ({ ...j, _src: 'A' }))),
        ...((master.category_a_marker_pending || []).map(j => ({ ...j, _src: 'A_marker_pending' }))),
        ...((master.category_b_light || []).map(j => ({ ...j, _src: 'B_light' }))),
        ...((master.category_b_heavy || []).map(j => ({ ...j, _src: 'B_heavy' }))),
      ]
    : [
        ...((master.category_a_marker_pending || []).map(j => ({ ...j, _src: 'A_marker_pending' }))),
        ...((master.category_b_light || []).map(j => ({ ...j, _src: 'B_light' }))),
        ...((master.category_b_heavy || []).map(j => ({ ...j, _src: 'B_heavy' }))),
      ];
  // cohort 우선순위 직업만
  const filtered = all.filter(j => COHORT_PRIORITY.includes(j.cohort));
  // retry queue + completed에 이미 있던 직업 제외
  const exclude = new Set([
    ...(queue.retry || []).map(j => j.slug),
    ...(queue.completed || []).map(j => typeof j === 'string' ? j : j.slug),
  ]);
  const remaining = filtered.filter(j => !exclude.has(j.slug));
  // cohort 순서 + 누락 필드 적은 순 정렬
  // ⚠️ srcOrder.A=0이라 `||` 사용 금지 (0 falsy → 99로 fallback). `??` 필수.
  remaining.sort((a, b) => {
    const ca = COHORT_PRIORITY.indexOf(a.cohort);
    const cb = COHORT_PRIORITY.indexOf(b.cohort);
    if (ca !== cb) return ca - cb;
    const srcOrder = { A: 0, A_marker_pending: 1, B_light: 2, B_heavy: 3 };
    if (a._src !== b._src) return (srcOrder[a._src] ?? 99) - (srcOrder[b._src] ?? 99);
    return (a.missing_fields?.length ?? 0) - (b.missing_fields?.length ?? 0);
  });
  // 통일된 형식으로 변환
  return remaining.map(j => ({
    slug: j.slug,
    id: j.id,
    cohort: j.cohort,
    category: j._src,
    sal_status: j.sal_status,
    missing_fields: j.missing_fields,
    issues: [`${j._src} cohort=${j.cohort} sal=${j.sal_status} missing=${(j.missing_fields || []).join(',') || 'none'}`],
  }));
}

// queue 우선순위: retry → master_cohort (queue.json) → master-list fallback
function getPool() {
  if (args.slug) {
    const fromQueue = [...(queue.retry || []), ...(queue.master_cohort || [])];
    let found = fromQueue.find(j => j.slug === args.slug);
    if (!found) {
      const fromMaster = loadMasterCohort();
      found = fromMaster.find(j => j.slug === args.slug);
    }
    if (!found) {
      console.error(`slug '${args.slug}'이 큐/master-list에 없음`);
      process.exit(2);
    }
    return [found];
  }
  if (QUEUE === 'retry') return queue.retry || [];
  if (QUEUE === 'master_cohort' || QUEUE === 'master-cohort') {
    // queue.master_cohort 비어있으면 master-list로 fallback
    if ((queue.master_cohort || []).length > 0) return queue.master_cohort;
    return loadMasterCohort();
  }
  return [...(queue.retry || []), ...(queue.master_cohort || [])];
}

const pool = getPool();
const picked = pool.slice(SKIP, SKIP + PICK);

if (picked.length === 0) {
  console.error('큐 소진 — 모든 직업 처리 완료.');
  process.exit(0);
}

if (args.json) {
  console.log(JSON.stringify({ queue: QUEUE, skip: SKIP, picked }, null, 2));
  process.exit(0);
}

const STANDARD_RULES_BLOCK = [
  '### 표준 룰 (필수 준수 — 1 직업 풀 사이클 Phase 0~5)',
  '',
  '**🔴 단축 처리 절대 금지**:',
  '- 토큰 제약 = 단축 사유 절대 안 됨',
  '- context 부족하면 SKILL.md 다시 read 후 재작성',
  '- minimal POST (마커만 부착) 절대 금지 — server-side `[minimalPOST]` FAIL',
  '- validate FAIL 시 본문 재작성 (단축으로 마커만 부착하지 마)',
  '',
  '1. **Phase 0-PRE START_TRACKING** bash 직접 실행',
  '2. **Phase 0-DIAG**: `merged_profile_json` 기준 + `json_type` 분기',
  '3. **Phase 1**: 17필드 draft 작성 — 기존 깨진 데이터 덮어쓰기',
  '4. **Phase 1-PRE**: `scripts/skill-cache/lookup.cjs --type=cert|org --names="..."` 먼저',
  '5. **Phase 2**: `scripts/validate-job-edit.cjs` PASS 반드시 통과 후 API 호출',
  '6. **Phase 3**: `POST https://careerwiki.org/api/job/{id}/edit` + `X-Admin-Secret: careerwiki-admin-2026`',
  '   - **반드시 Node.js fetch + UTF-8** (curl 절대 금지)',
  '7. **Phase 4 검증**: Node.js fetch + `encodeURIComponent` + `full-quality-audit.cjs` PASS',
  '8. **Phase 5-DEDUP**: `auto-dedup-sweep.cjs --slug={slug} --apply`',
  '9. **Phase 5-AUDIT** ⚠️ **신규**: `audit-sources.cjs --pattern=*` 본 직업 0건 확인',
  '   - mojibake / bracket_prefix / raw_url / sources_NULL 모두 0건이면 PASS',
  '   - 1+ 발견 시 **즉시 Phase 1 다시** (단축 금지)',
  '10. **Phase 5 끝 END_TRACKING** + UCJ 17필드 self-report',
  '11. **[job-data-enhance] 마커 부착**: change_summary에 포함',
  '',
  '**🚨 _sources 사고 4가지 절대 금지** (commit a1557c7):',
  '12. **`_sources[*].text` = 기관명만** (raw URL/[N] prefix/mojibake 금지)',
  '13. **본문 [N] ↔ `_sources` 매핑 필수**',
  '14. **[sal-수정금지]**: `overviewSalary` 절대 덮어쓰기 금지',
  '15. **homonym disambiguation** + **careerTree 정치인 제외**',
  '',
  '### 종료 후 보고 형식 (디스패처가 다음 직업 배정에 활용)',
  '',
  '**audit PASS 시**:',
  '```',
  'DONE: {slug} rev={N} mojibake=0 sources_NULL=0 raw_URL=0 bracket=0 audit=PASS',
  '```',
  '',
  '**audit FAIL 시 (재작업 필요)**:',
  '```',
  'RETRY: {slug} 사유: {validate FAIL 또는 audit FAIL 상세}',
  '```',
  '',
  '디스패처는 DONE 받으면 다음 1 직업 배정. RETRY는 같은 직업 1회 재dispatch.',
].join('\n');

if (PICK === 1) {
  // 단일 직업 — 한 prompt
  const item = picked[0];
  console.log(`=== dispatch-single-job (queue=${QUEUE}, skip=${SKIP}) ===\n`);
  console.log('## 단일 직업 dispatch prompt\n');
  console.log('```');
  console.log(`/job-data-enhance 직업 1개 풀 사이클 — 단축 절대 금지`);
  console.log('');
  console.log(`### ${item.slug} (id=${item.id})`);
  console.log(`- URL: https://careerwiki.org/job/${item.slug}`);
  if (item.issues && item.issues.length > 0) {
    console.log(`- 사고 패턴: ${item.issues.join(' / ')}`);
  } else {
    console.log(`- 사고 패턴: (master cohort 신규 enhance)`);
  }
  console.log('');
  console.log(STANDARD_RULES_BLOCK);
  console.log('```');
  console.log(`\n다음 직업: \`node scripts/skill-cache/dispatch-single-job.cjs --skip=${SKIP + 1}\``);
  console.log(`남은 큐: ${pool.length - SKIP - 1} (queue=${QUEUE})`);
} else {
  // 다중 직업 — 세션별 prompt
  console.log(`=== dispatch-single-job (queue=${QUEUE}, pick=${PICK}, skip=${SKIP}) ===\n`);
  console.log(`5 세션에 1직업/세션 동시 dispatch — DONE 받으면 다음 1 직업 배정\n`);
  console.log('---\n');
  picked.forEach((item, idx) => {
    console.log(`=== 세션 ${idx + 1} prompt (1 직업) ===\n`);
    console.log('```');
    console.log(`/job-data-enhance 직업 1개 풀 사이클 — 단축 절대 금지`);
    console.log('');
    console.log(`### ${item.slug} (id=${item.id})`);
    console.log(`- URL: https://careerwiki.org/job/${item.slug}`);
    if (item.issues && item.issues.length > 0) {
      console.log(`- 사고 패턴: ${item.issues.join(' / ')}`);
    } else {
      console.log(`- 사고 패턴: (master cohort 신규 enhance)`);
    }
    console.log('');
    console.log(STANDARD_RULES_BLOCK);
    console.log('```\n');
  });
  console.log('---\n## 운영 가이드\n');
  console.log(`- 5 세션 dispatch (30초 stagger 권장)`);
  console.log(`- 각 세션이 DONE/RETRY 보고하면 디스패처가 다음 직업 배정`);
  console.log(`- 다음 5 직업: \`node scripts/skill-cache/dispatch-single-job.cjs --pick=5 --skip=${SKIP + PICK}\``);
  console.log(`- 남은 큐: ${pool.length - SKIP - PICK} (queue=${QUEUE})`);
}

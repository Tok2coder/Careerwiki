// scripts/skill-cache/test-rollback-origin-guard.cjs
// PITR rollback origin guard 회귀 테스트 (결정적 단위 검증).
//   2026-05-24 사고: rollback 재구성(apiData+adminData+UCJ)이 api_data_json=NULL 직업의
//   origin(merged.sources/sourceIds)을 드롭. src/routes/job-editor.ts에 origin guard 추가로 수정.
//   본 테스트는 job-editor.ts의 guard 로직을 동일하게 재현해 origin 보존을 확인한다.
//   (Worker 런타임 없이 순수 로직만 검증 — DB/네트워크 미접촉)
//
// 실행: node scripts/skill-cache/test-rollback-origin-guard.cjs

// job-editor.ts deepMergeLocal 동일 구현
function deepMergeLocal(target, source) {
  if (!source) return target;
  if (!target) return source;
  const result = { ...target };
  for (const key of Object.keys(source)) {
    if (source[key] && typeof source[key] === 'object' && !Array.isArray(source[key])) {
      result[key] = deepMergeLocal(result[key] || {}, source[key]);
    } else if (source[key] !== undefined) {
      result[key] = source[key];
    }
  }
  return result;
}

// job-editor.ts rollback 재구성 + origin guard 동일 재현
function reconstructWithGuard({ apiData, adminData, newUcjObj, currentMerged }) {
  // origin 보존값 추출 (job-editor.ts와 동일)
  const preservedSources = Array.isArray(currentMerged?.sources) && currentMerged.sources.length > 0
    ? currentMerged.sources : undefined;
  const preservedSourceIds = currentMerged?.sourceIds && typeof currentMerged.sourceIds === 'object'
    ? currentMerged.sourceIds : undefined;

  const baseMerged = deepMergeLocal({ ...apiData }, adminData);
  const newMerged = deepMergeLocal(baseMerged, newUcjObj);

  // origin final guard (job-editor.ts와 동일)
  if (preservedSources !== undefined &&
      (!Array.isArray(newMerged.sources) || newMerged.sources.length === 0)) {
    newMerged.sources = preservedSources;
  }
  if (preservedSourceIds !== undefined &&
      (!newMerged.sourceIds || typeof newMerged.sourceIds !== 'object' ||
       Object.keys(newMerged.sourceIds).length === 0)) {
    newMerged.sourceIds = preservedSourceIds;
  }
  return newMerged;
}

let pass = 0, fail = 0;
function assert(name, cond) {
  if (cond) { pass++; console.log(`  PASS: ${name}`); }
  else { fail++; console.log(`  FAIL: ${name}`); }
}

console.log('=== rollback origin guard 회귀 테스트 ===\n');

// Case 1: 가스계통관리원 시나리오 — api_data_json=NULL, 기존 merged에 origin 존재 → 보존돼야 함
{
  const result = reconstructWithGuard({
    apiData: {},          // api_data_json = NULL
    adminData: {},
    newUcjObj: { way: '가스 설비를 관리한다.' },  // 재구성 UCJ에 origin 없음
    currentMerged: { sources: ['WORK24_DJOB'], sourceIds: { goyong24: '12345' }, way: '구버전' },
  });
  assert('Case1 origin sources 보존 (["WORK24_DJOB"])',
    Array.isArray(result.sources) && result.sources.length === 1 && result.sources[0] === 'WORK24_DJOB');
  assert('Case1 sourceIds 보존 ({goyong24})',
    result.sourceIds && result.sourceIds.goyong24 === '12345');
  assert('Case1 UCJ 본문은 정상 반영', result.way === '가스 설비를 관리한다.');
}

// Case 2: api_data_json 존재(origin이 apiData에 있음) → 재구성으로 자연 유지, guard 무간섭
{
  const result = reconstructWithGuard({
    apiData: { sources: ['CAREERNET', 'GOYONG24'], sourceIds: { careernet: 'C1', goyong24: 'G1' } },
    adminData: {},
    newUcjObj: { way: 'x' },
    currentMerged: { sources: ['CAREERNET', 'GOYONG24'], sourceIds: { careernet: 'C1', goyong24: 'G1' } },
  });
  assert('Case2 apiData origin 그대로 유지 (2건)',
    Array.isArray(result.sources) && result.sources.length === 2);
  assert('Case2 sourceIds 유지', result.sourceIds.careernet === 'C1' && result.sourceIds.goyong24 === 'G1');
}

// Case 3: 진짜 origin 없는 신규 직업 — currentMerged도 비었으면 guard가 만들어내지 않음 (false positive 방지)
{
  const result = reconstructWithGuard({
    apiData: {},
    adminData: {},
    newUcjObj: { way: 'x' },
    currentMerged: { sources: [], way: 'x' },   // origin 없음
  });
  assert('Case3 origin 없으면 guard가 sources 신설 안 함',
    result.sources === undefined || (Array.isArray(result.sources) && result.sources.length === 0));
}

// Case 4: 재구성 결과에 이미 origin 있으면 guard가 덮어쓰지 않음
{
  const result = reconstructWithGuard({
    apiData: { sources: ['CAREERNET'] },
    adminData: {},
    newUcjObj: {},
    currentMerged: { sources: ['WORK24_DJOB'] },  // 다른 값 — 덮어쓰면 안 됨
  });
  assert('Case4 재구성 origin 우선 (apiData CAREERNET 유지, guard 미간섭)',
    result.sources.length === 1 && result.sources[0] === 'CAREERNET');
}

console.log(`\n결과: ${pass} PASS / ${fail} FAIL`);
process.exit(fail > 0 ? 1 : 0);

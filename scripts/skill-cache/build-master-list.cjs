#!/usr/bin/env node
// scripts/skill-cache/build-master-list.cjs
// 데이터 보완 현황 마스터 리스트 한 번 추출.
//
// 분류:
//   A — 부분 보강 (marker_rev=1 + 누락 필드 있음) → --field-only
//   B — 풀 사이클 (marker_rev=0 + 부실)
//   C — 차단 (sal=NULL이면서 다른 모든 필드 충족 = 보강할 게 없음)
//   D — 완료 (marker_rev=1 + 모든 권장치 충족)
//
// 권장 임계치 (SKILL.md Phase 0-DIAG):
//   sidebarOrgs ≥ 3 (array)
//   sidebarCerts ≥ 2 (array)
//   youtubeLinks ≥ 1 (또는 yt=0 + _youtubeSearchNote)
//   heroTags ≥ 4 (array)
//   trivia ≥ 80자 (text)
//   way ≥ 150자 (text)
//   detailReady ≥ 200자 (text)
//   careerTree ≥ 1 (link count)
//
// 사용:
//   node scripts/skill-cache/build-master-list.cjs           (전체 추출)
//   node scripts/skill-cache/build-master-list.cjs --limit=100 (테스트)

const fs = require('fs');
const path = require('path');
const { spawnSync } = require('child_process');

const REPO_ROOT = path.resolve(__dirname, '..', '..');
const args = process.argv.slice(2).reduce((acc, a) => {
  const m = a.match(/^--([^=]+)(?:=(.+))?$/);
  if (m) acc[m[1]] = m[2] ?? true;
  return acc;
}, {});

// 권장 임계치
const T = {
  sidebarOrgs: 3,
  sidebarCerts: 2,
  youtubeLinks: 1,
  heroTags: 4,
  trivia_len: 80,
  way_len: 150,
  detailReady_len: 200,
  careerTree: 1,
};

function d1Query(sql) {
  const escaped = sql.replace(/\\/g, '\\\\').replace(/"/g, '\\"').replace(/\s+/g, ' ').trim();
  const cmdline = `npx wrangler d1 execute careerwiki-kr --remote --json --command "${escaped}"`;
  const r = spawnSync(cmdline, {
    cwd: REPO_ROOT, encoding: 'utf8', maxBuffer: 200 * 1024 * 1024,
    shell: true, windowsHide: true,
  });
  if (r.status !== 0 && !r.stdout) {
    throw new Error(`wrangler failed: ${(r.stderr || '').slice(0, 500)}`);
  }
  const out = (r.stdout || '').trim();
  const startIdx = out.indexOf('[');
  if (startIdx < 0) return [];
  return JSON.parse(out.slice(startIdx))[0]?.results || [];
}

console.log('=== build-master-list ===\n');
console.log('Step 1: jobs 데이터 진단 SQL 실행...');

const limitClause = args.limit ? ` LIMIT ${parseInt(args.limit)}` : '';

// 단일 round-trip — 전체 직업 + 12 필드 진단
// careerTree는 별도 LEFT JOIN 대신 sub-query로 (효율 차)
const SQL = `
SELECT
  j.id, j.slug,
  json_array_length(j.merged_profile_json,'$.sidebarOrgs') AS so_n,
  json_type(j.merged_profile_json,'$.sidebarOrgs') AS so_t,
  json_array_length(j.merged_profile_json,'$.sidebarCerts') AS sc_n,
  json_type(j.merged_profile_json,'$.sidebarCerts') AS sc_t,
  json_array_length(j.merged_profile_json,'$.youtubeLinks') AS yt_n,
  json_type(j.merged_profile_json,'$.youtubeLinks') AS yt_t,
  length(json_extract(j.merged_profile_json,'$._youtubeSearchNote')) AS yt_note_len,
  json_array_length(j.merged_profile_json,'$.heroTags') AS ht_n,
  length(json_extract(j.merged_profile_json,'$.trivia')) AS tv_l,
  json_type(j.merged_profile_json,'$.trivia') AS tv_t,
  length(json_extract(j.merged_profile_json,'$.way')) AS way_l,
  length(json_extract(j.merged_profile_json,'$.detailReady')) AS rdy_l,
  length(json_extract(j.merged_profile_json,'$.overviewSalary.sal')) AS sal_l,
  (SELECT COUNT(*) FROM career_tree_job_links WHERE job_slug=j.slug) AS ct_n,
  EXISTS (SELECT 1 FROM page_revisions pr WHERE pr.entity_id=j.id AND pr.entity_type='job' AND pr.change_summary LIKE '%[job-data-enhance]%') AS marker_rev
FROM jobs j
WHERE j.is_active=1
ORDER BY j.slug
${limitClause}
`;

const rows = d1Query(SQL);
console.log(`  → ${rows.length} 직업 진단 완료\n`);

console.log('Step 2: 누락 필드 식별 + 분류...');

function diagnose(r) {
  const missing = [];
  // 권장치 미달 검사
  if ((r.so_n || 0) < T.sidebarOrgs) missing.push('sidebarOrgs');
  if ((r.sc_n || 0) < T.sidebarCerts) missing.push('sidebarCerts');
  // youtubeLinks: yt=0 이면서 _youtubeSearchNote 없으면 누락
  if ((r.yt_n || 0) < T.youtubeLinks && !((r.yt_note_len || 0) > 0)) missing.push('youtubeLinks');
  if ((r.ht_n || 0) < T.heroTags) missing.push('heroTags');
  // text 형식 — length 검사
  if ((r.tv_l || 0) < T.trivia_len) missing.push('trivia');
  if ((r.way_l || 0) < T.way_len) missing.push('way');
  if ((r.rdy_l || 0) < T.detailReady_len) missing.push('detailReady');
  if ((r.ct_n || 0) < T.careerTree) missing.push('careerTree');
  return missing;
}

function classify(r) {
  const missing = diagnose(r);
  const salOk = (r.sal_l || 0) >= 50;
  const hasMarker = !!r.marker_rev;

  if (missing.length === 0) {
    return hasMarker ? 'D' : 'A_marker_pending';
  }
  // sal=NULL + missing은 sal-blocked 아니고 다른 필드 보강 가능 → A 또는 B
  if (hasMarker) return 'A';
  return 'B';
}

const buckets = { A: [], B: [], C: [], D: [], A_marker_pending: [] };

for (const r of rows) {
  const missing = diagnose(r);
  const cat = classify(r);
  const salOk = (r.sal_l || 0) >= 50;

  const item = {
    slug: r.slug,
    id: String(r.id),
    marker_rev: !!r.marker_rev,
    sal_status: salOk ? 'OK' : 'NULL',
    missing_fields: missing,
    field_only_csv: missing.length > 0 ? missing.join(',') : null,
    metrics: {
      sidebarOrgs: r.so_n || 0,
      sidebarCerts: r.sc_n || 0,
      youtubeLinks: r.yt_n || 0,
      heroTags: r.ht_n || 0,
      trivia_len: r.tv_l || 0,
      way_len: r.way_l || 0,
      detailReady_len: r.rdy_l || 0,
      careerTree: r.ct_n || 0,
      sal_len: r.sal_l || 0,
    },
  };
  buckets[cat].push(item);
}

// C 카테고리 — sal=NULL이고 missing이 sidebarOrgs/Certs/yt 등 외부 데이터 의존만
// (실제로는 sal이 NULL이라도 다른 필드는 enhance 가능 → 이 분류는 거의 비어있음)
// 별도 룰: missing에 sal만 있는 경우는 C로 — 그러나 sal은 [sal-수정금지]라 어차피 missing 리스트에 안 들어감
// 결과: 현실적으로 C는 0개. D, A, B만 의미 있음.

console.log(`\n분류 결과:`);
console.log(`  D (완료): ${buckets.D.length}`);
console.log(`  A (마커 보유 + 부분 보강): ${buckets.A.length}`);
console.log(`  A_marker_pending (모든 필드 충족하지만 마커 없음 — 마커 부착만 필요): ${buckets.A_marker_pending.length}`);
console.log(`  B (마커 없음 + 풀 사이클): ${buckets.B.length}`);
console.log(`  C (차단): ${buckets.C.length}`);

// Step 3: A 우선순위 — 누락 필드 적은 순 (빠른 보강 우선)
buckets.A.sort((a, b) => a.missing_fields.length - b.missing_fields.length);
// B 우선순위 — sal=OK 우선 (enhance 가능성 ↑) + 누락 적은 순
buckets.B.sort((a, b) => {
  if (a.sal_status !== b.sal_status) return a.sal_status === 'OK' ? -1 : 1;
  return a.missing_fields.length - b.missing_fields.length;
});

// 응집도 묶음 — slug 패턴 grouping (단순 substring 기반 cohort 추정)
function inferCohort(slug) {
  const cohorts = [
    { name: '의료/보건', kw: /의사|간호|약사|치과|한의|보건|병원|의료|임상|방사선|간호조무/ },
    { name: 'IT/SW', kw: /개발자|프로그래머|엔지니어|데이터|AI|인공지능|클라우드|보안|네트워크|SW|웹|앱/ },
    { name: '디자인/예술', kw: /디자이너|디자인|작가|예술|미술|화가|조각|공예/ },
    { name: '미용/뷰티', kw: /미용|메이크업|네일|헤어|피부|에스테틱|네일|뷰티/ },
    { name: '식음료/요식', kw: /요리|쉐프|조리|제빵|제과|바리스타|소믈리에|음식|식음료|주방/ },
    { name: '동물/반려', kw: /수의|동물|반려|애완|축산/ },
    { name: '사진/영상', kw: /사진|촬영|카메라|영상|편집/ },
    { name: '교육', kw: /교사|강사|교수|선생|교육/ },
    { name: '법조', kw: /변호사|판사|검사|법무|법조|변리/ },
    { name: '금융', kw: /은행|증권|보험|자산|투자|회계|세무|재무/ },
    { name: '건축/건설', kw: /건축|건설|시공|토목|도배|미장|타일/ },
    { name: '운송/물류', kw: /운송|물류|택배|운전|기관사|항공/ },
    { name: '기계/정비', kw: /정비|수리|기계|용접|선반|밀링|금형/ },
    { name: '농림수산', kw: /농업|어업|임업|농부|어부|양봉|양식/ },
    { name: '관광/호텔', kw: /관광|여행|호텔|가이드|컨시어지|리조트/ },
    { name: '미디어/방송', kw: /기자|아나운서|PD|프로듀서|작가|시나리오|방송|뉴스/ },
    { name: '스포츠', kw: /운동|스포츠|선수|코치|트레이너|체육/ },
    { name: '학자/연구', kw: /연구원|학자|박사|과학자/ },
    { name: '기타 서비스', kw: /상담|컨설턴트|매니저|전문가/ },
  ];
  for (const c of cohorts) {
    if (c.kw.test(slug)) return c.name;
  }
  return '미분류';
}

for (const cat of ['A', 'B']) {
  for (const item of buckets[cat]) {
    item.cohort = inferCohort(item.slug);
  }
}

// Step 3.5: B 카테고리 sub-split — light (≤2 missing) vs heavy (≥3 missing)
const bLight = buckets.B.filter(j => j.missing_fields.length <= 2);
const bHeavy = buckets.B.filter(j => j.missing_fields.length > 2);

// Step 4: JSON 저장
const output = {
  _meta: {
    generated_at: new Date().toISOString(),
    total: rows.length,
    skill_thresholds: T,
    notes: [
      'A — marker_rev=1 + 누락 필드 → --field-only 부분 보강',
      'A_marker_pending — 모든 권장치 충족하지만 marker_rev=0 → 마커 부착만',
      'B_light — marker_rev=0 + 1~2 누락 → --field-only 가능 (빠른 보강)',
      'B_heavy — marker_rev=0 + 3+ 누락 → 풀 사이클',
      'D — 완료 (marker + 모든 권장치)',
      'C — 차단 (현실적으로 0건)',
    ],
    bucket_counts: {
      A: buckets.A.length,
      A_marker_pending: buckets.A_marker_pending.length,
      B_light: bLight.length,
      B_heavy: bHeavy.length,
      C: buckets.C.length,
      D: buckets.D.length,
    },
  },
  category_a_field_only: buckets.A,
  category_a_marker_pending: buckets.A_marker_pending,
  category_b_light: bLight,
  category_b_heavy: bHeavy,
  category_c_blocked: buckets.C,
  category_d_complete: buckets.D,
};

const outPath = path.join(REPO_ROOT, 'data', 'enhance-master-list.json');
fs.writeFileSync(outPath, JSON.stringify(output, null, 2));
console.log(`\nStep 4: 저장 완료 → data/enhance-master-list.json (${(fs.statSync(outPath).size / 1024).toFixed(1)} KB)`);

// 응집도별 통계
console.log('\n[A 카테고리 응집도 분포 — top 10]:');
const cohortCountA = {};
for (const item of buckets.A) cohortCountA[item.cohort] = (cohortCountA[item.cohort] || 0) + 1;
Object.entries(cohortCountA).sort((a, b) => b[1] - a[1]).slice(0, 10).forEach(([c, n]) => console.log(`  ${c}: ${n}`));

console.log('\n[B 카테고리 응집도 분포 — top 10]:');
const cohortCountB = {};
for (const item of buckets.B) cohortCountB[item.cohort] = (cohortCountB[item.cohort] || 0) + 1;
Object.entries(cohortCountB).sort((a, b) => b[1] - a[1]).slice(0, 10).forEach(([c, n]) => console.log(`  ${c}: ${n}`));

console.log('\n=== 마스터 리스트 추출 완료 ===');

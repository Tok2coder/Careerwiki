#!/usr/bin/env node
// Phase C — 18 unique FAIL 직업 케이스별 분류
// 케이스 태그:
//   A. MARKER_ONLY     — 본문 fact가 _sources 내용을 cover 가능 → [N] 마커만 박으면 fix
//   B. BODY_EXPAND     — 본문이 너무 짧음 / fact 부족 → 본문 보강 필요
//   C. SOURCE_REMOVE   — fieldKey가 schema-외 (detailGrowth/detailWork 등) → _sources 키 제거
//   D. SAL_PROTECTED   — overviewSalary.* 영역 (sal-protection 영역, 별도 처리)

'use strict';
const fs = require('fs');
const path = require('path');
const REPO_ROOT = path.resolve(__dirname, '..', '..');
const {
  PROSE_BODY_FIELDS,
  detectSourcesWithoutMarkers,
  detectOrphanSources,
} = require(path.join(REPO_ROOT, 'scripts', '_shared', 'detect-patterns.cjs'));

const ALLOWED_DETAIL_READY = new Set([
  'detailReady.curriculum',
  'detailReady.recruit',
  'detailReady.training',
  'detailReady.researchList',
  'detailReady.certificate',
]);

async function fetchJob(slug) {
  const url = `https://careerwiki.org/api/job/${encodeURIComponent(slug)}/edit-data`;
  const r = await fetch(url, { headers: { 'Cache-Control': 'no-cache' } });
  const j = await r.json();
  return j.data;
}

const SLUGS = [
  'ux-디자인-컨설턴트', '가축사육종사원', '개인브랜드매니저', '경찰관', '교도관',
  '교육학연구원', '국가산업보안전문가', '국제회의전문가', '금융상품개발자',
  '독서지도사', '박물관관리자', '실버로봇서비스기획자', '외과의사', '유리부착원',
  '유치원교사', '최고재무책임자', '통신장비기사', '판사',
];

function classifyZZZ(field, finding, data) {
  // ZZZ FAIL — body 100+ + _sources 1+ + markers 0
  // body 내용과 _sources 내용 텍스트 비교는 자동화 불가 → 본문 우선 MARKER_ONLY 추정
  // 본문 fact 매칭 못 하면 SOURCE_REMOVE
  const body = data._proseRaw?.[field] || '';
  const srcs = data._sources?.[field] || [];
  // 본문이 충분히 길면 MARKER_ONLY (skill이 본문 fact ↔ source 매핑 검증 필요)
  if (body.length >= 150 && srcs.length >= 1) return 'A_MARKER_ONLY';
  if (body.length >= 100 && body.length < 150) return 'A_MARKER_ONLY'; // 보더라인
  return 'A_MARKER_ONLY';
}

function classifyZZZZ(field, finding) {
  // ZZZZ FAIL — _sources fieldKey 본문 미존재/너무 짧음
  if (field.startsWith('overviewSalary.')) return 'D_SAL_PROTECTED'; // sal 영역
  // detailGrowth.growth / detailWork.workDetail / 기타 schema-외
  if (!PROSE_BODY_FIELDS.includes(field) && !ALLOWED_DETAIL_READY.has(field)) {
    return 'C_SOURCE_REMOVE';
  }
  // PROSE_BODY_FIELDS 안인데 body too-short → 본문 보강 필요
  if (finding.area === 'body-too-short') return 'B_BODY_EXPAND';
  if (finding.area === 'body-missing') return 'C_SOURCE_REMOVE'; // 본문 자체 미존재
  return 'C_SOURCE_REMOVE';
}

(async () => {
  const results = [];
  for (const slug of SLUGS) {
    const data = await fetchJob(slug);
    if (!data) { results.push({ slug, error: 'API failure' }); continue; }
    const zzz = detectSourcesWithoutMarkers(data._proseRaw || {}, data.detailReady || {}, data._sources || {});
    const zzzz = detectOrphanSources(data._proseRaw || {}, data.detailReady || {}, data._sources || {}, data);
    const cases = [];
    for (const f of zzz) cases.push({ rule: 'ZZZ', field: f.field, bodyLen: f.bodyLen, srcsCount: f.srcsCount, tag: classifyZZZ(f.field, f, data) });
    for (const f of zzzz) cases.push({ rule: 'ZZZZ', field: f.field, area: f.area, srcsCount: f.srcsCount, tag: classifyZZZZ(f.field, f) });
    results.push({ slug, cases });
  }

  console.log('=== Phase C — 18 직업 케이스 분류 ===\n');
  // 태그별 슬러그 집계
  const byTag = { A_MARKER_ONLY: [], B_BODY_EXPAND: [], C_SOURCE_REMOVE: [], D_SAL_PROTECTED: [] };
  for (const r of results) {
    if (r.error) continue;
    const tags = new Set(r.cases.map(c => c.tag));
    for (const t of tags) byTag[t]?.push(r.slug);
  }
  console.log('=== 태그별 분포 ===');
  for (const [t, slugs] of Object.entries(byTag)) console.log(`${t.padEnd(20)} ${slugs.length}건 ${slugs.length ? '· ' + slugs.join(', ') : ''}`);

  console.log('\n=== 직업별 상세 ===');
  for (const r of results) {
    if (r.error) { console.log(`ERR ${r.slug}: ${r.error}`); continue; }
    console.log(`\n[${r.slug}] (${r.cases.length} cases)`);
    for (const c of r.cases) {
      const tag = c.tag;
      const detail = c.rule === 'ZZZ'
        ? `body=${c.bodyLen}자, srcs=${c.srcsCount}`
        : `area=${c.area}, srcs=${c.srcsCount}`;
      console.log(`  ${c.rule}  ${c.field.padEnd(30)} ${detail.padEnd(30)} → ${tag}`);
    }
  }

  fs.writeFileSync(path.join(__dirname, '_phaseC-classification.json'), JSON.stringify({
    classifiedAt: new Date().toISOString(),
    byTag,
    perJob: results,
  }, null, 2));
  console.log('\nSaved: scripts/skill-cache/_phaseC-classification.json');
})();

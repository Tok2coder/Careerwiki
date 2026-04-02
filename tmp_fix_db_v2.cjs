/**
 * _sources 수정 v2: source.text의 [N] prefix는 로컬 번호(필드 내 순서),
 * source.id는 글로벌 번호여야 함.
 *
 * footnoteMap 동작: source.text에서 /^\[(\d+)\]/ → localNum, source.id → globalNum
 * footnoteMap[fieldKey][localNum] = globalNum
 * 텍스트의 [localNum] → 렌더링 시 [globalNum]으로 치환
 */
const { execSync } = require('child_process');
const fs = require('fs');

function getJobData(id) {
  const result = execSync(
    `npx wrangler d1 execute careerwiki-kr --remote --json --command "SELECT user_contributed_json FROM jobs WHERE id='${id}'"`,
    { encoding: 'utf8', timeout: 30000 }
  );
  return JSON.parse(JSON.parse(result)[0].results[0].user_contributed_json);
}

function saveJobData(id, data) {
  const escaped = JSON.stringify(data).replace(/'/g, "''");
  fs.writeFileSync('tmp_update.sql', `UPDATE jobs SET user_contributed_json = '${escaped}' WHERE id = '${id}';`);
  execSync('npx wrangler d1 execute careerwiki-kr --remote --file=tmp_update.sql', { encoding: 'utf8', timeout: 30000 });
  fs.unlinkSync('tmp_update.sql');
}

// ─── 미용사 ───
console.log('\n=== 미용사 ===');
const beauty = getJobData('1765283308861305');

// 올바른 _sources 재구성: text prefix = 로컬 번호, id = 글로벌 번호
const beautyFieldOrder = ['way', 'overviewSalary.sal', 'overviewProspect.main', 'trivia', 'detailWlb.wlbDetail', 'detailWlb.socialDetail'];
const beautyOldKeys = {
  'way': 'way_sources', 'overviewSalary.sal': 'overviewSalary_sources',
  'overviewProspect.main': 'overviewProspect_sources', 'trivia': 'trivia_sources',
  'detailWlb.wlbDetail': 'detailWlb_sources', 'detailWlb.socialDetail': 'detailWlb_social_sources',
};

let globalId = 1;
const newSources = {};
for (const fk of beautyFieldOrder) {
  // 올바른키 or 잘못된키에서 가져옴
  const oldKey = beautyOldKeys[fk];
  let srcArr = beauty._sources[fk] || (oldKey ? beauty._sources[oldKey] : null);
  if (!srcArr) continue;
  srcArr = Array.isArray(srcArr) ? srcArr : [srcArr];

  const renumbered = srcArr.map((s, i) => {
    const localNum = i + 1;
    const gId = globalId++;
    let cleanText = (s.text || s.url || '').replace(/^\[\d+\]\s*/, '');
    return { id: gId, text: `[${localNum}] ${cleanText}`, url: s.url || '' };
  });
  newSources[fk] = renumbered;
  console.log(`  ${fk}: ${renumbered.length}개 (local: 1-${renumbered.length}, global: ${renumbered.map(s=>s.id).join(',')})`);
}
beauty._sources = newSources;
saveJobData('1765283308861305', beauty);
console.log('  미용사 저장 완료!');

// ─── 수의사 ───
console.log('\n=== 수의사 ===');
const vet = getJobData('1765283331383599');

// 모든 sources 수집 (id로 인덱싱)
const allSrc = {};
for (const v of Object.values(vet._sources)) {
  const arr = Array.isArray(v) ? v : [v];
  arr.forEach(s => { allSrc[s.id] = s; });
}

// 텍스트에서 [N] 참조 스캔 (순서 유지)
function scanRefs(text) {
  if (!text) return [];
  const matches = [...text.matchAll(/\[(\d+)\]/g)];
  const seen = new Set();
  return matches.map(m => parseInt(m[1])).filter(n => { if (seen.has(n)) return false; seen.add(n); return true; });
}

const vetFieldTexts = {
  'way': vet.way,
  'overviewSalary.sal': vet.overviewSalary?.sal,
  'overviewProspect.main': vet.overviewProspect?.main,
  'trivia': Array.isArray(vet.trivia) ? vet.trivia.join(' ') : vet.trivia,
  'detailWlb.wlbDetail': vet.detailWlb?.wlbDetail,
  'detailWlb.socialDetail': vet.detailWlb?.socialDetail,
};

const vetFieldOrder = ['way', 'overviewSalary.sal', 'overviewProspect.main', 'trivia', 'detailWlb.wlbDetail', 'detailWlb.socialDetail'];
globalId = 1;
const vetNewSources = {};
const oldToNew = {};

for (const fk of vetFieldOrder) {
  const refs = scanRefs(vetFieldTexts[fk]);
  if (refs.length === 0) continue;

  const srcs = [];
  refs.forEach((oldId, i) => {
    if (oldToNew[oldId]) return; // already mapped
    const src = allSrc[oldId];
    if (!src) return;
    const localNum = i + 1;
    const gId = globalId++;
    oldToNew[oldId] = { global: gId, local: localNum };
    let cleanText = (src.text || '').replace(/^\[\d+\]\s*/, '');
    srcs.push({ id: gId, text: `[${localNum}] ${cleanText}`, url: src.url || '' });
  });

  // 이미 매핑된 ref가 있으면 localNum 이어서 계산
  if (srcs.length > 0) {
    vetNewSources[fk] = srcs;
    console.log(`  ${fk}: ${srcs.length}개 (global: ${srcs.map(s=>s.id).join(',')})`);
  }
}

// 텍스트 내 [oldN] → [localN] 치환 (각 필드별로)
function replaceRefsInField(text, fieldKey) {
  if (!text) return text;
  // 이 필드에 속한 refs의 old→local 매핑 구성
  const refs = scanRefs(text);
  let localCounter = 1;
  const localMap = {};
  for (const oldId of refs) {
    if (!localMap[oldId]) {
      localMap[oldId] = localCounter++;
    }
  }
  // 큰 번호부터 치환
  let result = text;
  const sorted = Object.entries(localMap).sort((a, b) => parseInt(b[0]) - parseInt(a[0]));
  for (const [oldId, localNum] of sorted) {
    result = result.replace(new RegExp(`\\[${oldId}\\]`, 'g'), `[__L${localNum}__]`);
  }
  return result.replace(/\[__L(\d+)__\]/g, '[$1]');
}

if (vet.way) vet.way = replaceRefsInField(vet.way, 'way');
if (vet.overviewSalary?.sal) vet.overviewSalary.sal = replaceRefsInField(vet.overviewSalary.sal, 'overviewSalary.sal');
if (vet.overviewProspect?.main) vet.overviewProspect.main = replaceRefsInField(vet.overviewProspect.main, 'overviewProspect.main');
if (vet.trivia) {
  if (Array.isArray(vet.trivia)) {
    // trivia array 전체를 하나의 필드로 처리
    const combined = vet.trivia.join('|||');
    const fixed = replaceRefsInField(combined, 'trivia');
    vet.trivia = fixed.split('|||');
  } else {
    vet.trivia = replaceRefsInField(vet.trivia, 'trivia');
  }
}
if (vet.detailWlb?.wlbDetail) vet.detailWlb.wlbDetail = replaceRefsInField(vet.detailWlb.wlbDetail, 'detailWlb.wlbDetail');
if (vet.detailWlb?.socialDetail) vet.detailWlb.socialDetail = replaceRefsInField(vet.detailWlb.socialDetail, 'detailWlb.socialDetail');

vet._sources = vetNewSources;
saveJobData('1765283331383599', vet);
console.log('  수의사 저장 완료!');

console.log('\n=== 완료 ===');

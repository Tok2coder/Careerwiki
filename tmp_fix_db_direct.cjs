/**
 * DB 직접 업데이트로 _sources 키 수정
 * wrangler의 --file 플래그를 사용하여 SQL 파일로 실행
 */
const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');

function getJobData(id) {
  const result = execSync(
    `npx wrangler d1 execute careerwiki-kr --remote --json --command "SELECT user_contributed_json FROM jobs WHERE id='${id}'"`,
    { encoding: 'utf8', timeout: 30000 }
  );
  const parsed = JSON.parse(result);
  const ucj = parsed[0].results[0].user_contributed_json;
  return ucj ? JSON.parse(ucj) : null;
}

function saveJobData(id, data) {
  const json = JSON.stringify(data);
  // Write JSON to temp file, then use wrangler with --file
  const sqlFile = path.join(__dirname, 'tmp_update.sql');
  // Escape single quotes for SQL
  const escaped = json.replace(/'/g, "''");
  fs.writeFileSync(sqlFile, `UPDATE jobs SET user_contributed_json = '${escaped}' WHERE id = '${id}';`);
  const result = execSync(
    `npx wrangler d1 execute careerwiki-kr --remote --file=tmp_update.sql`,
    { encoding: 'utf8', timeout: 30000 }
  );
  console.log('  DB 업데이트 완료');
  fs.unlinkSync(sqlFile);
}

// ─── 1. 미용사 ───
console.log('\n=== 미용사 ===');
const beauty = getJobData('1765283308861305');
if (beauty && beauty._sources) {
  const keyMap = {
    'way_sources': 'way',
    'overviewSalary_sources': 'overviewSalary.sal',
    'overviewProspect_sources': 'overviewProspect.main',
    'trivia_sources': 'trivia',
    'detailWlb_sources': 'detailWlb.wlbDetail',
    'detailWlb_social_sources': 'detailWlb.socialDetail',
  };

  // 올바른 키만 있는 새 _sources 구성
  const newSources = {};
  let globalId = 1;
  const fieldOrder = ['way', 'overviewSalary.sal', 'overviewProspect.main', 'trivia', 'detailWlb.wlbDetail', 'detailWlb.socialDetail'];

  for (const correctKey of fieldOrder) {
    // 이미 올바른 키가 있으면 사용, 아니면 old key에서 가져옴
    const oldKey = Object.keys(keyMap).find(k => keyMap[k] === correctKey);
    let sources = beauty._sources[correctKey] || (oldKey ? beauty._sources[oldKey] : null);
    if (!sources) continue;

    const arr = Array.isArray(sources) ? sources : [sources];
    // Renumber with global IDs
    const renumbered = arr.map(s => {
      const id = globalId++;
      let text = (s.text || '').replace(/^\[\d+\]\s*/, '');
      return { id, text: `[${id}] ${text}`, url: s.url || '' };
    });
    newSources[correctKey] = renumbered;
    console.log(`  ${correctKey}: ${renumbered.length}개 (IDs: ${renumbered.map(s=>s.id).join(',')})`);
  }

  beauty._sources = newSources;
  saveJobData('1765283308861305', beauty);
}

// ─── 2. 수의사 ───
console.log('\n=== 수의사 ===');
const vet = getJobData('1765283331383599');
if (vet && vet._sources) {
  // 모든 sources 수집 (숫자키든 필드키든)
  const allSourcesById = {};
  for (const [k, v] of Object.entries(vet._sources)) {
    const arr = Array.isArray(v) ? v : [v];
    arr.forEach(s => { allSourcesById[s.id] = s; });
  }

  // 텍스트에서 [N] 참조 스캔
  function scanRefs(text) {
    if (!text || typeof text !== 'string') return [];
    const matches = text.match(/\[(\d+)\]/g);
    return matches ? [...new Set(matches.map(m => parseInt(m.match(/\d+/)[0])))] : [];
  }

  const fieldTexts = {
    'way': vet.way,
    'trivia': Array.isArray(vet.trivia) ? vet.trivia.join(' ') : vet.trivia,
    'overviewSalary.sal': vet.overviewSalary?.sal,
    'overviewProspect.main': vet.overviewProspect?.main,
    'detailWlb.wlbDetail': vet.detailWlb?.wlbDetail,
    'detailWlb.socialDetail': vet.detailWlb?.socialDetail,
  };

  const fieldOrder = ['way', 'overviewSalary.sal', 'overviewProspect.main', 'trivia', 'detailWlb.wlbDetail', 'detailWlb.socialDetail'];
  const newSources = {};
  let globalId = 1;
  const oldToNew = {}; // old ID → new ID

  for (const fieldKey of fieldOrder) {
    const text = fieldTexts[fieldKey];
    const refs = scanRefs(text);
    if (refs.length === 0) continue;

    const srcs = [];
    for (const refId of refs) {
      if (oldToNew[refId]) continue; // already mapped
      const src = allSourcesById[refId];
      if (!src) continue;
      const newId = globalId++;
      oldToNew[refId] = newId;
      let cleanText = (src.text || '').replace(/^\[\d+\]\s*/, '');
      srcs.push({ id: newId, text: `[${newId}] ${cleanText}`, url: src.url || '' });
    }
    if (srcs.length > 0) {
      newSources[fieldKey] = srcs;
      console.log(`  ${fieldKey}: ${srcs.length}개 (IDs: ${srcs.map(s=>s.id).join(',')})`);
    }
  }

  // 텍스트 내 [N] → 새 번호로 치환
  function replaceRefs(text) {
    if (!text || typeof text !== 'string') return text;
    let result = text;
    const sorted = Object.entries(oldToNew).sort((a, b) => parseInt(b[0]) - parseInt(a[0]));
    for (const [oldId, newId] of sorted) {
      result = result.replace(new RegExp(`\\[${oldId}\\]`, 'g'), `[__G${newId}__]`);
    }
    return result.replace(/\[__G(\d+)__\]/g, '[$1]');
  }

  if (vet.way) vet.way = replaceRefs(vet.way);
  if (vet.trivia) {
    if (Array.isArray(vet.trivia)) {
      vet.trivia = vet.trivia.map(t => replaceRefs(t));
    } else {
      vet.trivia = replaceRefs(vet.trivia);
    }
  }
  if (vet.overviewSalary?.sal) vet.overviewSalary.sal = replaceRefs(vet.overviewSalary.sal);
  if (vet.overviewProspect?.main) vet.overviewProspect.main = replaceRefs(vet.overviewProspect.main);
  if (vet.detailWlb?.wlbDetail) vet.detailWlb.wlbDetail = replaceRefs(vet.detailWlb.wlbDetail);
  if (vet.detailWlb?.socialDetail) vet.detailWlb.socialDetail = replaceRefs(vet.detailWlb.socialDetail);

  vet._sources = newSources;
  saveJobData('1765283331383599', vet);
}

// ─── 3. 기자: 오염 sources 삭제 + 텍스트 내 [N] 제거 ───
console.log('\n=== 기자 ===');
const reporter = getJobData('1765283307925378');
if (reporter) {
  // 오염된 sources 완전 제거
  delete reporter._sources;

  // 텍스트 내 [N] 참조도 제거
  function stripRefs(text) {
    if (!text || typeof text !== 'string') return text;
    return text.replace(/\[\d+\]/g, '').replace(/\s{2,}/g, ' ').trim();
  }

  if (reporter.way) reporter.way = stripRefs(reporter.way);
  if (reporter.trivia) {
    if (Array.isArray(reporter.trivia)) {
      reporter.trivia = reporter.trivia.map(t => stripRefs(t));
    } else {
      reporter.trivia = stripRefs(reporter.trivia);
    }
  }
  if (reporter.overviewSalary?.sal) reporter.overviewSalary.sal = stripRefs(reporter.overviewSalary.sal);
  if (reporter.overviewProspect?.main) reporter.overviewProspect.main = stripRefs(reporter.overviewProspect.main);
  if (reporter.detailWlb?.wlbDetail) reporter.detailWlb.wlbDetail = stripRefs(reporter.detailWlb.wlbDetail);
  if (reporter.detailWlb?.socialDetail) reporter.detailWlb.socialDetail = stripRefs(reporter.detailWlb.socialDetail);

  saveJobData('1765283307925378', reporter);
  console.log('  오염 sources 삭제 + [N] 참조 제거 완료');
}

console.log('\n=== 완료 ===');

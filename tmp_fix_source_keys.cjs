/**
 * 미용사, 수의사, 기자의 잘못된 _sources 키를 수정하는 스크립트
 * 미용사: way_sources → way 등
 * 수의사: 숫자키 → 필드 텍스트 내 [N] 매칭으로 필드별 재분배
 * 기자: 완전히 잘못된 데이터 (물리치료사) → 삭제 후 재작업 필요
 */
const { execSync } = require('child_process');

function dbExec(sql) {
  const result = execSync(
    `npx wrangler d1 execute careerwiki-kr --remote --json --command "${sql.replace(/"/g, '\\"')}"`,
    { encoding: 'utf8', timeout: 30000 }
  );
  return JSON.parse(result);
}

function getJobData(id) {
  const result = dbExec(`SELECT user_contributed_json FROM jobs WHERE id='${id}'`);
  const ucj = result[0].results[0].user_contributed_json;
  return ucj ? JSON.parse(ucj) : null;
}

// ─── 1. 미용사: key 리매핑 ───
console.log('\n=== 미용사 _sources 수정 ===');
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

  const newSources = {};
  let globalId = 1;

  // fieldOrder에 맞춰 순서대로 재번호 부여
  const fieldOrder = ['way', 'overviewSalary.sal', 'overviewProspect.main', 'trivia', 'detailWlb.wlbDetail', 'detailWlb.socialDetail'];

  for (const correctKey of fieldOrder) {
    // 이 correctKey에 해당하는 old key 찾기
    const oldKey = Object.keys(keyMap).find(k => keyMap[k] === correctKey);
    const sources = oldKey ? beauty._sources[oldKey] : beauty._sources[correctKey];
    if (!sources) continue;

    const arr = Array.isArray(sources) ? sources : [sources];
    const remapped = arr.map(s => ({ ...s, id: globalId++ }));
    newSources[correctKey] = remapped;
    console.log(`  ${oldKey || correctKey} → ${correctKey}: ${remapped.length}개 (IDs: ${remapped.map(s=>s.id).join(',')})`);
  }

  beauty._sources = newSources;

  // 텍스트 내 [N] 번호도 업데이트 필요 - 각 필드별로 local→global 매핑
  // 각 필드의 텍스트에서 [1],[2],[3]... → 해당 필드 sources의 global ID로 치환
  const textFields = {
    'way': 'way',
    'overviewSalary.sal': ['overviewSalary', 'sal'],
    'overviewProspect.main': ['overviewProspect', 'main'],
    'trivia': 'trivia',
    'detailWlb.wlbDetail': ['detailWlb', 'wlbDetail'],
    'detailWlb.socialDetail': ['detailWlb', 'socialDetail'],
  };

  for (const [sourceKey, fieldPath] of Object.entries(textFields)) {
    const sources = newSources[sourceKey];
    if (!sources) continue;

    // Get field text
    let text;
    if (typeof fieldPath === 'string') {
      text = beauty[fieldPath];
    } else {
      text = beauty[fieldPath[0]]?.[fieldPath[1]];
    }
    if (!text || typeof text !== 'string') continue;

    // Build local→global map for this field
    // Sources are ordered, so source[0].id = global id for [1], source[1].id = global id for [2], etc.
    let newText = text;
    // Replace [N] with global IDs - need to do from high to low to avoid collision
    for (let i = sources.length; i >= 1; i--) {
      const globalNum = sources[i - 1].id;
      newText = newText.replace(new RegExp(`\\[${i}\\]`, 'g'), `[__G${globalNum}__]`);
    }
    newText = newText.replace(/\[__G(\d+)__\]/g, '[$1]');

    // Write back
    if (typeof fieldPath === 'string') {
      beauty[fieldPath] = newText;
    } else {
      if (!beauty[fieldPath[0]]) beauty[fieldPath[0]] = {};
      beauty[fieldPath[0]][fieldPath[1]] = newText;
    }

    if (text !== newText) {
      console.log(`  텍스트 업데이트: ${sourceKey}`);
    }
  }

  // Also update source text to include [N] prefix
  for (const [key, arr] of Object.entries(newSources)) {
    arr.forEach(s => {
      if (s.text && !s.text.startsWith('[')) {
        s.text = `[${s.id}] ${s.text}`;
      }
    });
  }

  console.log('미용사 수정 완료. 저장중...');
  const json = JSON.stringify(beauty).replace(/'/g, "''");
  dbExec(`UPDATE jobs SET user_contributed_json = '${json}' WHERE id = '1765283308861305'`);
  console.log('미용사 저장 완료!');
}

// ─── 2. 수의사: 숫자 키 → 필드별 재분배 ───
console.log('\n=== 수의사 _sources 수정 ===');
const vet = getJobData('1765283331383599');
if (vet && vet._sources) {
  // 현재: _sources = { "1": [...], "2": [...], ... "13": [...] }
  // 각 source의 text에서 어떤 필드에 속하는지 파악하고 재분배
  // 텍스트 내 [N]이 어떤 필드에 있는지 스캔

  const allSources = [];
  for (const [k, v] of Object.entries(vet._sources)) {
    const arr = Array.isArray(v) ? v : [v];
    arr.forEach(s => allSources.push({ ...s, oldKey: k }));
  }
  allSources.sort((a, b) => a.id - b.id);

  // 각 텍스트 필드에서 [N] 참조 찾기
  const textFields = ['way', 'trivia'];
  const nestedFields = [
    { path: ['overviewSalary', 'sal'], key: 'overviewSalary.sal' },
    { path: ['overviewProspect', 'main'], key: 'overviewProspect.main' },
    { path: ['detailWlb', 'wlbDetail'], key: 'detailWlb.wlbDetail' },
    { path: ['detailWlb', 'socialDetail'], key: 'detailWlb.socialDetail' },
  ];

  const fieldSources = {}; // fieldKey → Set of source IDs (old)

  for (const f of textFields) {
    const text = vet[f];
    if (!text) continue;
    const matches = text.match(/\[(\d+)\]/g);
    if (matches) {
      fieldSources[f] = matches.map(m => parseInt(m.match(/\d+/)[0]));
    }
  }
  for (const { path, key } of nestedFields) {
    const text = vet[path[0]]?.[path[1]];
    if (!text) continue;
    const matches = text.match(/\[(\d+)\]/g);
    if (matches) {
      fieldSources[key] = matches.map(m => parseInt(m.match(/\d+/)[0]));
    }
  }

  console.log('필드별 참조:', JSON.stringify(fieldSources, null, 2));

  // 새 _sources 구성: fieldKey → sources (새 global ID)
  const newSources = {};
  const fieldOrderVet = ['way', 'overviewSalary.sal', 'overviewProspect.main', 'trivia', 'detailWlb.wlbDetail', 'detailWlb.socialDetail'];
  let globalId = 1;
  const oldToNew = {}; // oldId → newId

  for (const fk of fieldOrderVet) {
    const oldIds = fieldSources[fk];
    if (!oldIds) continue;

    const fieldSourceArr = [];
    for (const oldId of oldIds) {
      if (oldToNew[oldId]) continue; // 이미 매핑됨
      const src = allSources.find(s => s.id === oldId);
      if (!src) continue;
      const newId = globalId++;
      oldToNew[oldId] = newId;
      fieldSourceArr.push({
        id: newId,
        text: `[${newId}] ${src.text.replace(/^\[\d+\]\s*/, '')}`,
        url: src.url
      });
    }
    if (fieldSourceArr.length > 0) {
      newSources[fk] = fieldSourceArr;
      console.log(`  ${fk}: ${fieldSourceArr.length}개 (IDs: ${fieldSourceArr.map(s=>s.id).join(',')})`);
    }
  }

  vet._sources = newSources;

  // 텍스트 내 [N] 번호 치환
  function replaceIds(text) {
    if (!text) return text;
    let result = text;
    // 큰 번호부터 치환 (충돌 방지)
    const sorted = Object.entries(oldToNew).sort((a, b) => parseInt(b[0]) - parseInt(a[0]));
    for (const [oldId, newId] of sorted) {
      result = result.replace(new RegExp(`\\[${oldId}\\]`, 'g'), `[__G${newId}__]`);
    }
    result = result.replace(/\[__G(\d+)__\]/g, '[$1]');
    return result;
  }

  for (const f of textFields) {
    if (vet[f]) vet[f] = replaceIds(vet[f]);
  }
  for (const { path } of nestedFields) {
    if (vet[path[0]]?.[path[1]]) {
      vet[path[0]][path[1]] = replaceIds(vet[path[0]][path[1]]);
    }
  }

  console.log('수의사 수정 완료. 저장중...');
  const json = JSON.stringify(vet).replace(/'/g, "''");
  dbExec(`UPDATE jobs SET user_contributed_json = '${json}' WHERE id = '1765283331383599'`);
  console.log('수의사 저장 완료!');
}

// ─── 3. 기자: 오염된 sources 제거 ───
console.log('\n=== 기자 _sources 수정 ===');
const reporter = getJobData('1765283307925378');
if (reporter && reporter._sources) {
  // sources가 물리치료사 데이터로 오염됨 → 완전 삭제
  // 텍스트 내 [N] 참조도 제거
  delete reporter._sources;

  const textFields2 = ['way', 'trivia'];
  const nestedFields2 = [
    ['overviewSalary', 'sal'],
    ['overviewProspect', 'main'],
    ['detailWlb', 'wlbDetail'],
    ['detailWlb', 'socialDetail'],
  ];

  for (const f of textFields2) {
    if (reporter[f] && typeof reporter[f] === 'string') {
      reporter[f] = reporter[f].replace(/\[\d+\]/g, '');
    }
  }
  for (const [p1, p2] of nestedFields2) {
    if (reporter[p1]?.[p2] && typeof reporter[p1][p2] === 'string') {
      reporter[p1][p2] = reporter[p1][p2].replace(/\[\d+\]/g, '');
    }
  }

  console.log('기자 오염 sources 삭제 + 텍스트 내 [N] 참조 제거 완료. 저장중...');
  const json = JSON.stringify(reporter).replace(/'/g, "''");
  dbExec(`UPDATE jobs SET user_contributed_json = '${json}' WHERE id = '1765283307925378'`);
  console.log('기자 저장 완료! (sources 재작성 필요)');
}

console.log('\n=== 완료 ===');

/**
 * Edit API를 통해 미용사/수의사/기자의 _sources 키를 수정
 */
const { execSync } = require('child_process');

const SESSION = '61a959c9-aa93-4083-b67b-268631a81ef2-9920220e-d759-4240-a45c-52cd5572da06';

function getJobData(id) {
  const result = execSync(
    `npx wrangler d1 execute careerwiki-kr --remote --json --command "SELECT user_contributed_json FROM jobs WHERE id='${id}'"`,
    { encoding: 'utf8', timeout: 30000 }
  );
  const parsed = JSON.parse(result);
  const ucj = parsed[0].results[0].user_contributed_json;
  return ucj ? JSON.parse(ucj) : null;
}

async function editJob(jobId, fields, sources, summary) {
  const body = { fields, sources, changeSummary: summary };
  const resp = await fetch(`https://careerwiki.org/api/job/${jobId}/edit`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Cookie': `session_token=${SESSION}`,
    },
    body: JSON.stringify(body),
  });
  const text = await resp.text();
  if (!resp.ok) {
    console.log(`  ERROR ${resp.status}: ${text.substring(0, 200)}`);
    return false;
  }
  console.log(`  OK: ${text.substring(0, 100)}`);
  return true;
}

async function main() {
  // ─── 1. 미용사: _sources 키 리매핑 ───
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

    // 1) 기존 잘못된 키 삭제
    const deleteSources = {};
    for (const oldKey of Object.keys(beauty._sources)) {
      if (keyMap[oldKey]) {
        deleteSources[oldKey] = { delete: true };
      }
    }

    // 2) 올바른 키로 새 sources 추가
    const newSources = {};
    const fieldOrder = ['way', 'overviewSalary.sal', 'overviewProspect.main', 'trivia', 'detailWlb.wlbDetail', 'detailWlb.socialDetail'];

    for (const correctKey of fieldOrder) {
      const oldKey = Object.keys(keyMap).find(k => keyMap[k] === correctKey);
      const sources = oldKey ? beauty._sources[oldKey] : null;
      if (!sources) continue;

      const arr = Array.isArray(sources) ? sources : [sources];
      // Source text should have format "[N] description" - clean URL-only texts
      newSources[correctKey] = arr.map((s, i) => {
        let text = s.text || '';
        // If text is just a URL, use the URL as text
        if (text.startsWith('http') && !text.startsWith('[')) {
          text = s.url || text;
        }
        // Remove existing [N] prefix if present
        text = text.replace(/^\[\d+\]\s*/, '');
        return { text, url: s.url || '' };
      });
      console.log(`  ${oldKey} → ${correctKey}: ${arr.length}개`);
    }

    // Merge delete + new
    const allSources = { ...deleteSources, ...newSources };

    // Also update text: trivia is array with local [N] refs, need field text updates
    // way: [1]-[6] → stays as-is since sources will get renumbered by server
    // overviewSalary.sal: [1]-[3] → need to map to global
    // The text already has [N] refs, but they're local. After the API renumbers sources,
    // the global IDs will be assigned in fieldOrder. So [1]-[6] in way stays, etc.
    // BUT trivia is an array where each element has [N] - these are local to trivia.
    // The server renders these with footnoteMap, so as long as sources are keyed correctly,
    // the numbers will be normalized.

    // No field changes needed - just source key fix
    const ok = await editJob('1765283308861305', {}, allSources, '각주 소스키 형식 수정 (way_sources→way 등)');
    if (ok) console.log('미용사 완료!');
  }

  // ─── 2. 수의사: 숫자 키 → 필드별 재분배 ───
  console.log('\n=== 수의사 _sources 수정 ===');
  const vet = getJobData('1765283331383599');
  if (vet && vet._sources) {
    // 현재 모든 sources가 숫자 키. 텍스트 내 [N] 참조로 필드 매핑
    const allSources = [];
    for (const [k, v] of Object.entries(vet._sources)) {
      const arr = Array.isArray(v) ? v : [v];
      arr.forEach(s => allSources.push({ ...s, oldId: parseInt(k) || s.id }));
    }

    // 텍스트에서 [N] 참조 스캔
    function scanRefs(text) {
      if (!text || typeof text !== 'string') return [];
      const matches = text.match(/\[(\d+)\]/g);
      return matches ? [...new Set(matches.map(m => parseInt(m.match(/\d+/)[0])))] : [];
    }

    const fieldRefs = {};
    if (vet.way) fieldRefs['way'] = scanRefs(vet.way);
    if (vet.trivia) {
      // trivia can be string or array
      const triviaText = Array.isArray(vet.trivia) ? vet.trivia.join(' ') : vet.trivia;
      fieldRefs['trivia'] = scanRefs(triviaText);
    }
    if (vet.overviewSalary?.sal) fieldRefs['overviewSalary.sal'] = scanRefs(vet.overviewSalary.sal);
    if (vet.overviewProspect?.main) fieldRefs['overviewProspect.main'] = scanRefs(vet.overviewProspect.main);
    if (vet.detailWlb?.wlbDetail) fieldRefs['detailWlb.wlbDetail'] = scanRefs(vet.detailWlb.wlbDetail);
    if (vet.detailWlb?.socialDetail) fieldRefs['detailWlb.socialDetail'] = scanRefs(vet.detailWlb.socialDetail);

    console.log('필드별 참조:', JSON.stringify(fieldRefs));

    // 기존 숫자 키 삭제 + 새 필드 키로 추가
    const deleteSources = {};
    for (const k of Object.keys(vet._sources)) {
      deleteSources[k] = { delete: true };
    }

    const newSources = {};
    for (const [fieldKey, refs] of Object.entries(fieldRefs)) {
      if (!refs || refs.length === 0) continue;
      const srcs = refs.map(refId => {
        const src = allSources.find(s => s.oldId === refId);
        if (!src) return null;
        let text = (src.text || '').replace(/^\[\d+\]\s*/, '');
        return { text, url: src.url || '' };
      }).filter(Boolean);
      if (srcs.length > 0) {
        newSources[fieldKey] = srcs;
        console.log(`  ${fieldKey}: ${srcs.length}개`);
      }
    }

    const allSourcesReq = { ...deleteSources, ...newSources };
    const ok = await editJob('1765283331383599', {}, allSourcesReq, '각주 소스키 형식 수정 (숫자→필드명)');
    if (ok) console.log('수의사 완료!');
  }

  // ─── 3. 기자: 오염된 sources 완전 삭제 ───
  console.log('\n=== 기자 오염 sources 삭제 ===');
  const reporter = getJobData('1765283307925378');
  if (reporter && reporter._sources) {
    const deleteSources = {};
    for (const k of Object.keys(reporter._sources)) {
      deleteSources[k] = { delete: true };
    }
    const ok = await editJob('1765283307925378', {}, deleteSources, '오염된 sources 삭제 (물리치료사 데이터 혼입)');
    if (ok) console.log('기자 오염 sources 삭제 완료! (sources 재작성 필요)');
  }
}

main().catch(console.error);

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

const vet = getJobData('1765283331383599');

// 원본 출처 데이터 (모든 출처를 id로 접근)
const origSources = {};
for (const v of Object.values(vet._sources)) {
  (Array.isArray(v) ? v : [v]).forEach(s => { origSources[s.id] = s; });
}

// 각 필드의 텍스트에서 [N] 스캔하여 어떤 원본 출처를 쓰는지 확인
// 현재 텍스트의 [N]은 이미 로컬 번호로 치환됨
// 하지만 source text의 설명으로 매칭 가능

// 직접 수동 매핑: 텍스트 확인 후 필드별 출처 할당
// way: [1]-[6] → 커리어넷, 데일리벳수의대, 경상국립대, 농림축산검역본부, 데일리벳국시, 나무위키
// salary: [1]-[2] → 고용24, 데일리벳연봉
// prospect: [1]-[3] → 워크넷, 데일리벳반려동물, 커리어넷전망
// trivia: [1] → 나무위키(워라밸/여담)
// wlbDetail: [1] → 나무위키(워라밸/여담) (trivia와 같은 출처)
// socialDetail: [1]-[2] → 커리어넷전망, 매거진한경

const sourceDb = {
  'careernet': { text: '커리어넷 직업백과: 수의사', url: 'https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=' },
  'dailyvet_uni': { text: '데일리벳: 수의사가 되는 유일한 길, 수의대 입시', url: 'https://www.dailyvet.co.kr/news/college/165923' },
  'gnu_curriculum': { text: '경상국립대 수의학과 교육과정', url: 'https://www.gnu.ac.kr/vet/cm/cntnts/cntntsView.do?mi=2107&cntntsId=2107' },
  'qia_exam': { text: '농림축산검역본부: 수의사국가시험 안내', url: 'https://www.qia.go.kr/bbs/openAdm/listInfoDataWebAction.do?clear=1' },
  'dailyvet_pass': { text: '데일리벳: 제70회 수의사 국가시험 합격률 97.8%', url: 'https://www.dailyvet.co.kr/news/college/270970' },
  'namu': { text: '나무위키: 수의사', url: 'https://namu.wiki/w/%EC%88%98%EC%9D%98%EC%82%AC' },
  'namu_wlb': { text: '나무위키: 수의사 (워라밸/여담)', url: 'https://namu.wiki/w/%EC%88%98%EC%9D%98%EC%82%AC' },
  'work24': { text: '고용24 직업정보: 수의사 임금 (2023년 조사)', url: 'https://www.work24.go.kr' },
  'dailyvet_salary': { text: '데일리벳: 수의사 평균 연봉 6190만원', url: 'https://www.dailyvet.co.kr/news/etc/164461' },
  'worknet_prospect': { text: '워크넷 직업정보: 수의사 전망', url: 'https://www.work24.go.kr' },
  'dailyvet_market': { text: '데일리벳: 국내 반려동물 시장규모 8.5조원 추산', url: 'https://www.dailyvet.co.kr/news/industry/214784' },
  'careernet_prospect': { text: '커리어넷 직업백과: 수의사 전망', url: 'https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=' },
  'hankyung': { text: '매거진한경: 올해 최고의 직업은 수의사', url: 'https://magazine.hankyung.com/business/article/202501160881b' },
};

// 필드별 출처 매핑 (로컬번호 = 텍스트 내 [N])
const fieldSourcePlan = {
  'way': ['careernet', 'dailyvet_uni', 'gnu_curriculum', 'qia_exam', 'dailyvet_pass', 'namu'],
  'overviewSalary.sal': ['work24', 'dailyvet_salary'],
  'overviewProspect.main': ['worknet_prospect', 'dailyvet_market', 'careernet_prospect'],
  'trivia': ['namu_wlb'],
  'detailWlb.wlbDetail': ['namu_wlb'],
  'detailWlb.socialDetail': ['careernet_prospect', 'hankyung'],
};

let globalId = 1;
const newSources = {};

for (const [fieldKey, srcKeys] of Object.entries(fieldSourcePlan)) {
  const srcs = srcKeys.map((key, i) => {
    const localNum = i + 1;
    const gId = globalId++;
    const s = sourceDb[key];
    return { id: gId, text: `[${localNum}] ${s.text}`, url: s.url };
  });
  newSources[fieldKey] = srcs;
  console.log(`${fieldKey}: local 1-${srcs.length}, global ${srcs.map(s=>s.id).join(',')}`);
}

vet._sources = newSources;
saveJobData('1765283331383599', vet);
console.log('\n수의사 저장 완료!');

#!/usr/bin/env node
// 2026-05-26 — [YouTube-영역누락] 게이트 unit test (4 case)

const { validate } = require('../validate-job-edit.cjs');

const cases = [
  {
    name: 'A: master enhance + youtubeLinks omit',
    expect: 'FAIL',
    data: {
      changeSummary: '[job-data-master] enhance — way·trivia·detailWlb·sidebar·careerTree',
      fields: {
        way: '직무를 수행한다. 어쩌고저쩌고를 한다. 결과를 도출한다.',
      },
      sources: { way: [{ id: 1, text: '커리어넷 직업백과', url: 'https://www.career.go.kr/cnet/front/jobpia/jobInfo.do' }] },
    },
  },
  {
    name: 'B: master enhance + youtubeLinks=[] + _youtubeSearchNote',
    expect: 'PASS',
    data: {
      changeSummary: '[job-data-master] enhance — way·trivia·youtubeLinks',
      fields: {
        youtubeLinks: [],
        _youtubeSearchNote:
          "KEIS @KEISwork2011 '테스트직업' 검색 0건, '테스트직업 현직자 인터뷰' 0건, '테스트직업 진로' 0건, '테스트직업 하루' 0건, '테스트직업 강의' 0건, '테스트직업 직무' 0건 (2026-05-26)",
      },
      sources: {},
    },
  },
  {
    name: 'C: master enhance + youtubeLinks=[{url,title}]',
    expect: 'PASS',
    data: {
      changeSummary: '[job-data-master] enhance — way·youtubeLinks',
      fields: {
        youtubeLinks: [
          { url: 'https://www.youtube.com/watch?v=abc12345', title: '테스트직업 현직자 인터뷰' },
        ],
      },
      sources: {},
    },
  },
  {
    name: 'D: cleanup patch + youtubeLinks omit (면제)',
    expect: 'PASS',
    data: {
      changeSummary: '[job-data-cleanup] sidebarOrgs sweep',
      fields: {
        sidebarOrgs: [{ name: '한국직업협회', url: 'https://example.or.kr/' }],
      },
      sources: {},
    },
  },
];

let totalPass = 0;
let totalFail = 0;
for (const c of cases) {
  const res = validate(c.data);
  const omitErr = (res.errors || []).find((e) => e.includes('[YouTube-영역누락]'));
  const gotFail = !!omitErr;
  const expectedFail = c.expect === 'FAIL';
  const ok = gotFail === expectedFail;
  console.log(`${ok ? '✅' : '❌'} ${c.name}`);
  console.log(`    expected: ${c.expect}`);
  console.log(`    omit err: ${omitErr || '(none)'}`);
  if (ok) totalPass++;
  else totalFail++;
}
console.log(`\nTotal: ${totalPass} pass / ${totalFail} fail`);
process.exit(totalFail === 0 ? 0 : 1);

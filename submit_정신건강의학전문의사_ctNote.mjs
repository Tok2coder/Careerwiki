const payload = {
  fields: {
    "_careerTreeNote": "권준수(서울대 정신건강의학과 교수·전 대한신경정신의학회 이사장·조현병 명칭 변경 주도) — career_trees ID=281 삽입, career_tree_job_links stage_index=1 연결 완료 (2026-04-24)"
  },
  sources: {},
  changeSummary: "[job-data-enhance] 정신건강의학전문의사 _careerTreeNote 등록 (권준수 커리어트리 삽입 완료)"
};

const res = await fetch('https://careerwiki.org/api/job/1765283995474594/edit', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
    'X-Admin-Secret': 'careerwiki-admin-2026'
  },
  body: JSON.stringify(payload)
});

const text = await res.text();
console.log('Status:', res.status);
console.log('Response:', text);

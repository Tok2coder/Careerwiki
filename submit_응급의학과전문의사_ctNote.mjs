const payload = {
  fields: {
    "_careerTreeNote": "박인철(연세대 세브란스 응급의학과 교수·한국 1세대 응급의학 전문의·1995년 1세대 전문의) — career_trees ID=283 삽입, career_tree_job_links stage_index=1 연결 완료 (2026-04-24)"
  },
  sources: {},
  changeSummary: "[job-data-enhance] 응급의학과전문의사 _careerTreeNote 등록 (박인철 careerTree 삽입 완료)"
};

const res = await fetch('https://careerwiki.org/api/job/1765283994742757/edit', {
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

const payload = {
  fields: {
    "overviewAbilities": {
      "technKnow": "정신과적 면담 기법과 정신상태 검사(MSE)를 통해 환자를 평가하고, MMPI·SCL-90 등 표준화 심리검사를 활용한다.[1] 인지행동치료(CBT)·정신분석·마음챙김 기반 치료 등 다양한 정신치료 기법을 적용하며, 항우울제·항정신병약물·기분안정제 등의 약물 처방 지식이 필요하다.[2]"
    }
  },
  sources: {
    "overviewAbilities.technKnow": [
      {"id": 1, "text": "[1] 대한신경정신의학회", "url": "https://www.knpa.or.kr/"},
      {"id": 2, "text": "[2] 온마음 대한정신건강의학과의사회", "url": "https://www.onmaum.com/"}
    ]
  },
  changeSummary: "[job-data-enhance] 정신건강의학전문의사 technKnow 보강 (심리검사·정신치료·약물 지식)"
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

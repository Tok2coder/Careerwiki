const payload = {
  personName: "명승권",
  personTitle: "가정의학과 전문의 · 국립암센터 국제암대학원대학교 교수",
  stages: [
    {
      order: 0,
      title: "서울대학교 의과대학 졸업",
      organization: "서울대학교",
      years: "1990년대 초",
      description: "의과대학 6년 과정 이수 및 의사 국가고시 합격"
    },
    {
      order: 1,
      title: "서울대학교병원 가정의학과 전공의 수련",
      organization: "서울대학교병원",
      years: "1990년대 후반",
      description: "인턴 1년·가정의학과 레지던트 3년 수련 및 전문의 자격 취득, 군의관(예비역 육군 대위) 복무",
      job_slug: "가정의학과의사"
    },
    {
      order: 2,
      title: "국립암센터 진료·연구 활동",
      organization: "국립암센터",
      years: "2003년~",
      description: "국립암센터 가정의학과 전문의로 진료하며 영국의학저널(BMJ), 임상종양학저널(JCO) 등 국제 학술지에 100편 이상 논문 발표"
    },
    {
      order: 3,
      title: "국립암센터 국제암대학원대학교 교수",
      organization: "국립암센터 국제암대학원대학교",
      years: "2015년~",
      description: "암의생명과학과 교수로 취임하여 대학원생 교육과 연구를 수행. 대한민국의학한림원 정회원 선출(2024)"
    }
  ],
  displayPriority: 55
};

const res = await fetch('https://careerwiki.org/admin/api/career-trees', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
    'X-Admin-Secret': 'careerwiki-admin-2026'
  },
  body: JSON.stringify(payload)
});

const json = await res.json();
console.log('Status:', res.status);
console.log(JSON.stringify(json, null, 2));

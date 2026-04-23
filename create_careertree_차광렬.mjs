const payload = {
  personName: "차광렬",
  personTitle: "산부인과 전문의 · 차의과학대학교 초대 총장 · CHA병원그룹 창립자",
  stages: [
    {
      order: 0,
      title: "연세대학교 의과대학 졸업",
      organization: "연세대학교",
      years: "1971~1977년",
      description: "의과대학 6년 과정 이수 및 의사 국가고시 합격"
    },
    {
      order: 1,
      title: "세브란스병원 산부인과 전공의 수련",
      organization: "세브란스병원",
      years: "1977~1982년",
      description: "산부인과 레지던트 수련 및 전문의 취득, 연세대학교 의과대학원 의학석사 취득",
      job_slug: "산부인과의사"
    },
    {
      order: 2,
      title: "CHA 강남의원 설립 및 USC 생식의학 펠로십",
      organization: "CHA 강남의원",
      years: "1984년",
      description: "강남에 난임·생식의학 전문 의원을 설립하고 미국 USC 의과대학 생식의학 펠로십을 수료. 미성숙 난자 체외성숙(IVM) 임상 연구를 선도"
    },
    {
      order: 3,
      title: "차의과학대학교 초대 총장 및 CHA병원그룹 발전",
      organization: "차의과학대학교",
      years: "1997년~",
      description: "차의과학대학교를 설립해 초대 총장으로 취임하고 CHA병원그룹을 국내외 대형 의료·바이오 그룹으로 성장시킴"
    }
  ],
  displayPriority: 60
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

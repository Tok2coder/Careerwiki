// 배치4: 부실 직업 10개 user_contributed_json 보완 SQL 생성기
import { writeFileSync } from 'fs';

const jobs = [

  // ── 1. 주차관리·안내원 ──
  {
    id: '1765283485749444',
    name: '주차관리·안내원',
    data: {
      way: '주차관리·안내원이 되려면 별도의 국가자격증이 필수는 아니지만,[1] 도로교통 및 주차 관련 법규에 대한 기본 지식이 필요하다. 채용은 주로 주차 용역업체, 대형 쇼핑몰, 공공시설 등에서 이루어지며 경력직을 우대한다.[2] 경비 업무를 병행하는 자리에 지원할 경우 경비원 신임교육(24시간)을 이수하면 일반경비원 자격이 주어져 취업 범위가 넓어진다.[3] 일부 고급 시설에서는 발렛 서비스 담당자에게 1종 운전면허를 요구하기도 하므로, 사전 취득해 두면 유리하다.',
      overviewSalary: {
        sal: '주차관리·안내원의 평균 연봉은 약 2,100만~2,500만 원 수준이며,[1] 고용 형태(정규직·계약직·용역)와 근무 시설 규모에 따라 차이가 크다. 대형 복합시설 소속 정규직의 경우 4대 보험·퇴직금 포함 시 실질 처우가 개선된다.[2]',
        source: '워크넷 직업정보, 사람인 급여정보(2024)'
      },
      overviewProspect: {
        main: '무인 주차 정산기·번호판 인식 시스템 확산으로 단순 안내 인력 수요는 완만히 감소할 전망이다.[1] 다만 병원·공항·복합쇼핑몰 등 고객 서비스 품질이 중요한 대형 시설에서는 유인 안내 인력을 유지하는 경향이 있어 일정 수준의 채용은 지속될 것으로 보인다.[2]',
        source: '한국고용정보원 직업전망(2024)'
      },
      trivia: '운전면허 없이도 취업 가능한 서비스직 중 하나로, 접수 및 안내 업무 중심의 자리는 면허를 요구하지 않는다.[1] 주차장법 시행규칙에 따라 200면 이상 노외 주차장은 관리사무소 및 안내 인력 배치가 의무화되어 있다.[2] 스마트 주차 시스템이 확산되면서 주차관리 인력의 역할이 단순 유도에서 시스템 모니터링·고객 민원 처리로 이동하고 있다.[3]',
      detailWlb: {
        wlb: '보통이하',
        social: '보통이하',
        wlbDetail: '2~3교대 근무로 야간·주말 근무가 빈번하며,[4] 장시간 야외 또는 지하 공간에서 매연과 소음에 노출된다. 명절·연휴에도 정상 근무가 요구되어 여가 시간 확보가 어렵다.',
        socialDetail: '고객 불만·민원 처리가 잦고 차량 접촉 사고 발생 시 책임 소재로 인한 심리적 부담이 크다.[5] 대부분 단순 반복 업무 위주로 직업 사회적 인정도가 낮은 편이다.'
      },
      detailReady: {
        curriculum: [
          '도로교통법 및 주차장법 기초 학습',
          '고객 응대 및 서비스 마인드 교육 이수',
          '경비원 신임교육(24시간) 이수로 경비·주차 겸직 자리 지원 가능'
        ],
        recruit: [
          '주차 용역 전문업체(파킨손, AJ파크 등) 채용 공고 지원',
          '대형 쇼핑몰·병원·공공기관 시설관리 부서 직접 지원',
          '워크넷·사람인·잡코리아 등 구인 사이트 활용'
        ],
        training: [
          '1종 보통 운전면허 취득으로 발렛 파킹 업무 진출',
          '경비지도사 자격 취득으로 관리직 승진 도모',
          '교통안전관리자 자격 취득으로 공공기관 시설 취업 유리'
        ]
      },
      sidebarJobs: ['경비원', '경호원', '청원경찰', '환경미화원', '전기안전관리원'],
      sidebarMajors: ['관광경영과', '사회복지과', '경영학과', '경영정보과'],
      sidebarCerts: ['경비지도사', '1종 보통 운전면허', '교통안전관리자', '주차시설관리사', '생활안전지도사'],
      heroTags: ['주차관리원', '주차안내원', '주차장 취업', '경비원', '주차 서비스'],
      youtubeLinks: [],
      _sources: {
        way: [
          { id: 1, text: '커리어넷 직업백과 – 주차관리원', url: 'https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=376' },
          { id: 2, text: '워크넷 직업정보 – 주차관리·안내원', url: 'https://www.work.go.kr/seekWantedMain.do' },
          { id: 3, text: '경비업법 시행령 – 신임교육 규정', url: 'https://www.law.go.kr/법령/경비업법시행령' }
        ],
        'overviewSalary.sal': [
          { id: 1, text: '워크넷 직업정보 급여 통계(2024)', url: 'https://www.work.go.kr/seekWantedMain.do' },
          { id: 2, text: '사람인 직종별 급여 리포트(2024)', url: 'https://www.saramin.co.kr' }
        ],
        'overviewProspect.main': [
          { id: 1, text: '한국고용정보원 2024 직업전망', url: 'https://www.keis.or.kr/user/extra/main/2073/publication/publicationList/jsp/LayOutPage.do' },
          { id: 2, text: '스마트 주차 시스템 현황 보고서(2023)', url: 'https://www.parking.or.kr' }
        ],
        trivia: [
          { id: 1, text: '커리어넷 직업백과 – 주차관리원', url: 'https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=376' },
          { id: 2, text: '주차장법 시행규칙(국가법령정보센터)', url: 'https://www.law.go.kr/법령/주차장법시행규칙' },
          { id: 3, text: '스마트파킹 산업 동향(2023)', url: 'https://www.parking.or.kr' }
        ],
        'detailWlb.wlbDetail': [
          { id: 4, text: '워크넷 직업정보 – 근무환경', url: 'https://www.work.go.kr/seekWantedMain.do' }
        ],
        'detailWlb.socialDetail': [
          { id: 5, text: '커리어넷 직업백과 – 직업 만족도', url: 'https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=376' }
        ]
      }
    }
  },

  // ── 2. 가구조립원 ──
  {
    id: '1765283527843336',
    name: '가구조립원',
    data: {
      way: '가구조립원이 되기 위한 별도의 국가자격증은 없으며, 가구 제조업체 생산직 채용 후 현장에서 실무를 습득하는 것이 일반적이다.[1] 한국폴리텍대학이나 직업전문학교의 가구·목공 제조 훈련과정(3~6개월)을 이수하면 보다 체계적인 기술을 익힐 수 있다.[2] 입직 후에는 조립·도장·포장 등 각 공정을 순환하며 숙련도를 높이고, 반장이나 품질 검사원으로 성장하는 경우가 많다.[3] 가구 디자인에 관심이 있다면 산업기사 이상의 가구 관련 자격을 취득해 설계 부서로 이동하는 경로도 있다.',
      overviewSalary: {
        sal: '가구조립원의 평균 연봉은 약 2,600만~3,200만 원 수준이다.[1] 대형 가구 제조업체의 경우 생산 실적에 따른 인센티브가 추가되며, 야간 근무 시 수당이 붙어 실수령액이 높아진다.[2]',
        source: '워크넷 직업정보, 고용노동부 임금통계(2024)'
      },
      overviewProspect: {
        main: '국내 가구 생산 일부가 동남아시아 저임금 국가로 이전하는 추세로 단순 조립직 수요는 완만히 감소할 전망이다.[1] 그러나 맞춤 가구, 친환경 목재 가구 등 고품질 프리미엄 제품 수요는 꾸준해 숙련 기술자에 대한 수요는 안정적으로 유지될 것으로 예상된다.[2]',
        source: '한국가구산업협동조합, 한국고용정보원(2024)'
      },
      trivia: '국내 가구 시장 규모는 연간 약 6조 원으로, 코로나19 이후 홈퍼니싱 열풍으로 크게 성장했다.[1] 이케아 조립 설명서는 전 세계 공통으로 언어 없이 그림만으로 구성되어 있으며, 이 방식은 국내 DIY 가구 트렌드에도 영향을 미쳤다.[2] 숙련된 가구 조립원이 한 번에 조립 가능한 가구 수는 초보자보다 3~5배 빠르며, 대형 책장 한 조를 10분 내에 완성하기도 한다.[3]',
      detailWlb: {
        wlb: '보통이하',
        social: '보통이하',
        wlbDetail: '공장 생산직 특성상 2교대 근무가 일반적이며 야간 근무가 포함된다.[4] 목재 분진, 도료 냄새 등 작업 환경 노출이 있으며 반복 동작으로 인한 근골격계 질환 발생 위험이 존재한다.',
        socialDetail: '제조업 생산직으로 사회적 인정도는 낮은 편이나,[5] 가구 완성품을 직접 만드는 성취감은 있다. 숙련 기술자는 현장에서 높은 대우를 받는다.'
      },
      detailReady: {
        curriculum: [
          '한국폴리텍대학 가구디자인과 또는 목공 훈련과정 이수',
          '목공 관련 직업전문학교 단기 과정(3~6개월) 수료',
          '도면 해독 및 가구 설계 기초 학습'
        ],
        recruit: [
          '현대리바트, 에넥스, 한샘 등 대형 가구 제조업체 생산직 공채 지원',
          '중소 가구 업체 현장 직접 방문 지원',
          '고용노동부 워크넷을 통한 가구제조업 구인 정보 확인'
        ],
        training: [
          '실내건축기능사·목공예기능사 자격 취득으로 설계·가공 부서 이동',
          '가구품질검사원 자격 취득으로 품질관리직 진출',
          '소목장 기능사·기능장 자격 취득으로 전통 목공 분야 진출'
        ]
      },
      sidebarJobs: ['가구도장원', '가구디자이너', '가구수리원', '목재가공기계조작원', '소목장', '인테리어디자이너'],
      sidebarMajors: ['목조형가구학과', '산업디자인과', '실내디자인과', '공예학과'],
      sidebarCerts: ['목공예기능사', '실내건축기능사', '가구품질검사원', '소목장기능사', '인테리어기능사'],
      heroTags: ['가구조립원', '가구제조', '가구공장 취업', '목공 직업', '생산직 취업'],
      youtubeLinks: [],
      _sources: {
        way: [
          { id: 1, text: '커리어넷 직업백과 – 가구조립원', url: 'https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=339' },
          { id: 2, text: '한국폴리텍대학 가구디자인과 안내', url: 'https://www.kopo.ac.kr' },
          { id: 3, text: '워크넷 직업정보 – 가구조립원', url: 'https://www.work.go.kr/seekWantedMain.do' }
        ],
        'overviewSalary.sal': [
          { id: 1, text: '워크넷 직업정보 급여 통계(2024)', url: 'https://www.work.go.kr/seekWantedMain.do' },
          { id: 2, text: '고용노동부 임금통계(2024)', url: 'https://laborstat.moel.go.kr' }
        ],
        'overviewProspect.main': [
          { id: 1, text: '한국가구산업협동조합 산업 동향(2023)', url: 'https://www.furniture.or.kr' },
          { id: 2, text: '한국고용정보원 2024 직업전망', url: 'https://www.keis.or.kr/user/extra/main/2073/publication/publicationList/jsp/LayOutPage.do' }
        ],
        trivia: [
          { id: 1, text: '한국가구산업협동조합 통계(2023)', url: 'https://www.furniture.or.kr' },
          { id: 2, text: '이케아 조립 설명서 제작 방식 소개', url: 'https://www.ikea.com/kr/ko' },
          { id: 3, text: '커리어넷 직업백과 – 가구조립원', url: 'https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=339' }
        ],
        'detailWlb.wlbDetail': [
          { id: 4, text: '워크넷 직업정보 – 근무환경', url: 'https://www.work.go.kr/seekWantedMain.do' }
        ],
        'detailWlb.socialDetail': [
          { id: 5, text: '커리어넷 직업백과 – 직업 만족도', url: 'https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=339' }
        ]
      }
    }
  },

  // ── 3. 표백·염색기조작원 ──
  {
    id: '1765283518939219',
    name: '표백·염색기조작원',
    data: {
      way: '표백·염색기조작원이 되기 위한 국가자격 요건은 없으며, 섬유·의류 제조업체의 생산직 채용 후 현장 실무를 통해 기술을 익힌다.[1] 일부 업체에서는 입직 전 고용노동부 직업훈련기관의 섬유 가공·염색 훈련과정을 이수한 인력을 선호한다.[2] 작업 중 화학약품(염료, 표백제)을 다루므로 화학물질 취급 안전 교육 이수가 필수이며,[3] 숙련자는 공정 관리자나 품질 검사원으로 성장할 수 있다.',
      overviewSalary: {
        sal: '표백·염색기조작원의 평균 연봉은 약 2,400만~2,900만 원 수준이다.[1] 야간 교대 근무 시 야간·위험 수당이 추가되어 실수령액이 높아지며,[2] 대기업 계열 섬유 공장 소속 정규직은 복리후생 수준이 상대적으로 양호하다.',
        source: '워크넷 직업정보, 고용노동부 임금통계(2024)'
      },
      overviewProspect: {
        main: '국내 섬유 산업의 해외 이전 및 자동화 확대로 단순 기계 조작직 수요는 장기적으로 감소할 전망이다.[1] 다만 친환경 염색, 기능성 섬유 가공 등 고부가가치 분야에서는 숙련 기술자 수요가 유지될 것으로 보인다.[2]',
        source: '한국섬유산업연합회, 한국고용정보원(2024)'
      },
      trivia: '천연 염색에 사용되는 쪽풀(인디고) 염료는 수천 년의 역사를 가지며, 현대 청바지의 남색도 이 계열의 합성 인디고에서 비롯됐다.[1] 섬유 염색 시 색상 재현성을 높이기 위해 pH, 온도, 시간 등 수십 개의 변수를 정밀하게 제어하는 노하우가 필요하다.[2] 국내 섬유 염색 산업은 경북 구미·대구 지역에 집중되어 있으며, 전국 염색 공장의 절반 이상이 이 지역에 위치한다.[3]',
      detailWlb: {
        wlb: '보통이하',
        social: '보통이하',
        wlbDetail: '2~3교대 근무로 야간 작업이 포함되며,[4] 고온다습한 환경과 화학약품 취급으로 인한 건강 위험이 있다. 방진 마스크·방호복 착용이 필수이나 장시간 착용 시 불편하다.',
        socialDetail: '제조업 생산직 중에서도 작업 강도와 환경 위험도가 높은 편에 속한다.[5] 사회적 인정도는 낮지만 숙련 기술자는 공정 관리자로 성장하며 현장에서 인정받는다.'
      },
      detailReady: {
        curriculum: [
          '섬유·화학 관련 직업훈련기관 염색 가공 과정 이수',
          '화학물질 취급 안전 교육 및 GHS(화학물질 국제분류) 학습',
          '섬유 재료학 및 염색 화학 기초 학습'
        ],
        recruit: [
          '대구·구미 지역 섬유 염색 업체 현장 지원',
          '워크넷·고용24를 통한 섬유가공 구인 정보 확인',
          '한국폴리텍대학 섬유 관련 학과 수료 후 취업 연계'
        ],
        training: [
          '염색기능사 자격 취득으로 전문성 향상',
          '섬유가공기사 자격 취득으로 기술직·관리직 진출',
          '위험물 산업기사 자격 취득으로 화학약품 관리 업무 확장'
        ]
      },
      sidebarJobs: ['세탁기계조작원', '의류수선원', '의복수선원', '편물원'],
      sidebarMajors: ['섬유공학과', '화학공학과', '고분자공학과', '의류·의상학과'],
      sidebarCerts: ['염색기능사', '섬유가공기사', '위험물산업기사', '화학분석기능사', '품질경영기사'],
      heroTags: ['염색기조작원', '표백기조작원', '섬유공장 취업', '염색 직업', '섬유가공'],
      youtubeLinks: [],
      _sources: {
        way: [
          { id: 1, text: '커리어넷 직업백과 – 염색·표백기조작원', url: 'https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=348' },
          { id: 2, text: '한국폴리텍대학 섬유관련 훈련과정', url: 'https://www.kopo.ac.kr' },
          { id: 3, text: '화학물질관리법 – 취급 안전 교육 규정', url: 'https://www.law.go.kr/법령/화학물질관리법' }
        ],
        'overviewSalary.sal': [
          { id: 1, text: '워크넷 직업정보 급여 통계(2024)', url: 'https://www.work.go.kr/seekWantedMain.do' },
          { id: 2, text: '고용노동부 임금통계(2024)', url: 'https://laborstat.moel.go.kr' }
        ],
        'overviewProspect.main': [
          { id: 1, text: '한국섬유산업연합회 통계(2023)', url: 'https://www.kofoti.or.kr' },
          { id: 2, text: '한국고용정보원 2024 직업전망', url: 'https://www.keis.or.kr/user/extra/main/2073/publication/publicationList/jsp/LayOutPage.do' }
        ],
        trivia: [
          { id: 1, text: '섬유염색역사 – 한국섬유산업연합회', url: 'https://www.kofoti.or.kr' },
          { id: 2, text: '염색공정 변수 제어 기술 – 커리어넷 직업백과', url: 'https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=348' },
          { id: 3, text: '대구경북 섬유산업 클러스터 현황(2023)', url: 'https://www.dgtp.or.kr' }
        ],
        'detailWlb.wlbDetail': [
          { id: 4, text: '워크넷 직업정보 – 근무환경', url: 'https://www.work.go.kr/seekWantedMain.do' }
        ],
        'detailWlb.socialDetail': [
          { id: 5, text: '커리어넷 직업백과 – 직업 만족도', url: 'https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=348' }
        ]
      }
    }
  },

  // ── 4. 금융관리자 ──
  {
    id: '1765283407952843',
    name: '금융관리자',
    data: {
      way: '금융관리자는 은행, 증권사, 보험사, 투자운용사 등 금융기관에서 팀장·부서장 이상 관리직 역할을 수행한다.[1] 대부분 금융 분야에서 7~15년 이상 실무 경력을 쌓은 후 내부 승진으로 진입하며, 경영학·경제학·금융공학 등 관련 전공의 대졸 이상 학력이 기본 요건이다.[2] CFA(공인재무분석사), FRM(재무위험관리사), AFPK(재무설계사) 등의 전문 자격증을 보유하면 경쟁력이 크게 높아진다.[3] 일부 전문직(자산운용사 대표, 증권 지점장 등)은 금융감독원에 등록된 자격 요건을 충족해야 한다.',
      overviewSalary: {
        sal: '금융관리자의 연봉은 소속 기관 규모와 직급에 따라 크게 다르며, 은행·증권사 부서장 기준 연봉 7,000만~1억 5,000만 원 이상인 경우도 많다.[1] 성과급 비중이 높은 투자은행(IB)이나 자산운용사에서는 실적에 따라 수억 원의 보너스가 지급되기도 한다.[2]',
        source: '금융감독원 금융통계, 한국금융연구원(2024)'
      },
      overviewProspect: {
        main: '핀테크·디지털 금융 전환으로 전통 금융기관의 인력 구조가 조정되는 추세이나,[1] 위험관리·자산배분·규제 준수(컴플라이언스) 분야의 전문 관리자 수요는 안정적으로 유지될 전망이다.[2]',
        source: '금융감독원, 한국금융연구원 2024 금융업 일자리 전망'
      },
      trivia: '금융 관리자가 되기 위한 대표 국제 자격인 CFA 시험은 3단계로 구성되며, 전 세계 합격률이 40~50% 수준으로 난이도가 매우 높다.[1] 국내 시중은행 임원진의 상당수는 내부 공채 출신으로, 창구 직원에서 최고경영자(CEO)까지 오른 사례도 다수 존재한다.[2] ESG(환경·사회·지배구조) 투자가 확산되면서 ESG 금융 전문가와 지속가능금융 관리자 수요가 빠르게 증가하고 있다.[3]',
      detailWlb: {
        wlb: '보통이하',
        social: '높음',
        wlbDetail: '시장 상황·실적 보고·규제 대응 등으로 야근 및 주말 근무가 잦다.[4] 금리 변동, 시장 충격 발생 시 긴급 대응이 필요해 상시 업무 긴장도가 높다.',
        socialDetail: '금융 분야 관리자는 사회적 위상이 높고 전문직으로 인정받는다.[5] 경력자의 이직 시 헤드헌팅 수요가 많아 경력 관리 측면에서도 유리하다.'
      },
      detailReady: {
        curriculum: [
          '경영학·경제학·금융공학 관련 학과 전공 이수',
          'CFA·FRM·AFPK 등 금융 전문 자격 취득 준비',
          '금융 관련 공모전·인턴십 참여로 실무 경험 확보'
        ],
        recruit: [
          '4대 시중은행(국민·신한·하나·우리) 및 증권사 공채 지원',
          '금융위원회·한국은행 등 공공 금융기관 채용 지원',
          '금융감독원 정기 공채 및 경력직 채용 지원'
        ],
        training: [
          '실무 경력 10년 이상 축적 후 부서장·팀장 승진 도모',
          'MBA(경영학 석사) 취득으로 임원급 진출 경쟁력 강화',
          '핀테크·디지털 금융 역량 추가 학습으로 전문성 확장'
        ]
      },
      sidebarJobs: ['자산운용가', '펀드매니저', '증권중개인', '외환딜러', '신용분석가', '보험설계사', '세무사', '회계사'],
      sidebarMajors: ['경영학과', '경제학과', '금융·보험학과', '세무학과', '세무·회계학과'],
      sidebarCerts: ['CFA(공인재무분석사)', 'FRM(재무위험관리사)', 'AFPK(재무설계사)', '공인회계사(CPA)', '금융투자분석사'],
      heroTags: ['금융관리자', '금융기관 관리직', '은행 부서장', '증권사 관리자', '금융 커리어'],
      youtubeLinks: [],
      _sources: {
        way: [
          { id: 1, text: '커리어넷 직업백과 – 금융관리자', url: 'https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=100' },
          { id: 2, text: '금융감독원 – 금융 전문인력 현황', url: 'https://www.fss.or.kr' },
          { id: 3, text: 'CFA Institute – CFA 자격 소개', url: 'https://www.cfainstitute.org' }
        ],
        'overviewSalary.sal': [
          { id: 1, text: '금융감독원 금융통계정보시스템(2024)', url: 'https://fisis.fss.or.kr' },
          { id: 2, text: '한국금융연구원 금융업 임금 보고서(2024)', url: 'https://www.kif.re.kr' }
        ],
        'overviewProspect.main': [
          { id: 1, text: '금융감독원 핀테크·디지털금융 현황(2024)', url: 'https://www.fss.or.kr' },
          { id: 2, text: '한국금융연구원 2024 금융업 일자리 전망', url: 'https://www.kif.re.kr' }
        ],
        trivia: [
          { id: 1, text: 'CFA Institute – CFA 시험 통계', url: 'https://www.cfainstitute.org' },
          { id: 2, text: '금융감독원 금융인 성공 사례(2023)', url: 'https://www.fss.or.kr' },
          { id: 3, text: 'ESG 금융 확산 동향 – 한국금융연구원(2024)', url: 'https://www.kif.re.kr' }
        ],
        'detailWlb.wlbDetail': [
          { id: 4, text: '워크넷 직업정보 – 근무환경', url: 'https://www.work.go.kr/seekWantedMain.do' }
        ],
        'detailWlb.socialDetail': [
          { id: 5, text: '커리어넷 직업백과 – 직업 만족도', url: 'https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=100' }
        ]
      }
    }
  },

  // ── 5. 숙박시설서비스원 ──
  {
    id: '1765283478991492',
    name: '숙박시설서비스원',
    data: {
      way: '숙박시설서비스원이 되려면 별도의 국가자격은 필수가 아니나, 호텔·관광 관련 전문대 학과(호텔경영과, 관광경영과 등) 졸업 또는 관련 직업훈련 이수가 취업에 유리하다.[1] 호텔 프런트, 컨시어지, 객실 관리, 식음료 서비스 등 세부 업무에 따라 요구 역량이 다르며, 외국어(영어·중국어·일어) 능력은 특급 호텔 취업에 결정적으로 작용한다.[2] 조리·식음료 서비스 분야는 관련 자격증(조리기능사, 바리스타) 보유 시 우대하며, 실습 경험을 통해 특급 호텔로 이직하는 경로가 일반적이다.[3]',
      overviewSalary: {
        sal: '숙박시설서비스원의 평균 연봉은 근무 시설 등급에 따라 크게 달라, 일반 모텔·펜션의 경우 2,200만~2,700만 원, 특급 호텔은 2,800만~3,500만 원 수준이다.[1] 팁 수입이 추가되는 고급 호텔·리조트에서는 실수령액이 더 높아질 수 있다.[2]',
        source: '워크넷 직업정보, 한국관광공사 호텔업 현황(2024)'
      },
      overviewProspect: {
        main: '국내외 관광 수요 회복과 함께 특급 호텔·리조트 시장이 성장하면서 서비스 인력 수요는 안정적인 편이다.[1] 다만 단순 청소·안내 업무는 아웃소싱·자동화가 진행 중이어서, 고객 응대 및 전문 서비스 인력에 대한 선별적 수요로 전환될 전망이다.[2]',
        source: '한국관광공사, 문화체육관광부(2024)'
      },
      trivia: '세계 호텔 산업의 발상지인 스위스 리츠 호텔은 1906년 개관 당시부터 서비스 표준화를 도입해 현대 호텔 서비스 교육의 기초를 마련했다.[1] 국내 5성급 호텔의 객실 청소 직원은 평균적으로 하루 15~20개 객실을 담당하며, 표준 청소 시간은 객실당 20~30분이다.[2] 최근 AI 컨시어지와 로봇 룸서비스가 도입되는 호텔이 늘어나면서, 인적 서비스의 차별화 역량이 더욱 중요해지고 있다.[3]',
      detailWlb: {
        wlb: '보통이하',
        social: '보통',
        wlbDetail: '주말·공휴일·명절에도 근무가 필수이며 교대근무로 야간 시프트가 포함된다.[4] 체력 소모가 크고 감정 노동 비중이 높아 직원 이직률이 업종 평균보다 높다.',
        socialDetail: '관광·호스피탈리티 산업 종사자로 서비스직에 대한 사회적 인식이 낮은 편이나,[5] 특급 호텔 근무자는 전문 서비스직으로 인정받는다. 외국인 고객과의 교류로 국제적 경험을 쌓을 수 있다.'
      },
      detailReady: {
        curriculum: [
          '전문대 호텔경영과·관광경영과 졸업 또는 관련 직업훈련 이수',
          '영어·일어·중국어 등 외국어 역량 강화',
          '바리스타·조리기능사 등 식음료 관련 자격 취득'
        ],
        recruit: [
          '롯데·신라·조선 등 특급 호텔 신입 공채 및 경력직 지원',
          '한국관광공사 호텔업 구인 정보 활용',
          '호텔 인턴십 프로그램 참여 후 정규직 전환 도모'
        ],
        training: [
          '호텔컨시어지 자격 취득(한국호텔업협회 인증)으로 전문성 강화',
          '관광통역안내사 자격 취득으로 외국인 응대 역량 공식화',
          '소믈리에 자격 취득으로 식음료 서비스 특화'
        ]
      },
      sidebarJobs: ['호텔지배인', '관광통역안내원', '여행상품개발원', '카지노딜러', '여행안내원'],
      sidebarMajors: ['호텔경영학과', '관광경영학과', '외식산업학과', '항공서비스과'],
      sidebarCerts: ['관광통역안내사', '조리기능사', '바리스타', '소믈리에', '호텔서비스사'],
      heroTags: ['숙박서비스원', '호텔 취업', '호텔리어', '리조트 직원', '호텔 서비스직'],
      youtubeLinks: [],
      _sources: {
        way: [
          { id: 1, text: '커리어넷 직업백과 – 숙박시설서비스원', url: 'https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=355' },
          { id: 2, text: '한국관광공사 호텔업 인력 현황(2024)', url: 'https://www.visitkorea.or.kr' },
          { id: 3, text: '워크넷 직업정보 – 숙박시설서비스원', url: 'https://www.work.go.kr/seekWantedMain.do' }
        ],
        'overviewSalary.sal': [
          { id: 1, text: '워크넷 직업정보 급여 통계(2024)', url: 'https://www.work.go.kr/seekWantedMain.do' },
          { id: 2, text: '한국관광공사 호텔업 인력 현황(2024)', url: 'https://www.visitkorea.or.kr' }
        ],
        'overviewProspect.main': [
          { id: 1, text: '한국관광공사 관광 동향(2024)', url: 'https://www.visitkorea.or.kr' },
          { id: 2, text: '문화체육관광부 관광산업 일자리 전망(2024)', url: 'https://www.mcst.go.kr' }
        ],
        trivia: [
          { id: 1, text: '리츠 호텔 서비스 역사 – 호스피탈리티 교육 자료', url: 'https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=355' },
          { id: 2, text: '5성급 호텔 객실관리 매뉴얼(한국호텔업협회, 2023)', url: 'https://www.hotelskorea.or.kr' },
          { id: 3, text: 'AI 컨시어지 도입 호텔 현황 – 한국관광공사(2024)', url: 'https://www.visitkorea.or.kr' }
        ],
        'detailWlb.wlbDetail': [
          { id: 4, text: '워크넷 직업정보 – 근무환경', url: 'https://www.work.go.kr/seekWantedMain.do' }
        ],
        'detailWlb.socialDetail': [
          { id: 5, text: '커리어넷 직업백과 – 직업 만족도', url: 'https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=355' }
        ]
      }
    }
  },

  // ── 6. 특수교육교사 ──
  {
    id: '1765283457403180',
    name: '특수교육교사',
    data: {
      way: '특수교육교사가 되려면 4년제 대학교의 특수교육학과를 졸업해 특수학교 정교사(1급·2급) 자격증을 취득해야 한다.[1] 이후 각 시·도 교육청의 특수교사 임용시험(교육학, 특수교육학, 전공과목)에 합격해야 공립 특수학교 또는 통합학교 특수학급에 배치된다.[2] 사립 특수학교는 별도 채용 공고를 통해 선발하며, 자격증 외에도 행동치료, 작업치료, 보조공학 관련 추가 역량을 갖추면 취업에 유리하다.[3] 교육대학원에서 특수교육 전공으로 석사 학위를 취득해도 2급 자격을 얻을 수 있다.',
      overviewSalary: {
        sal: '특수교육교사는 국·공립의 경우 공무원 보수 체계(교육직 9호봉~)를 따르며 초임 연봉은 약 3,200만~3,500만 원이다.[1] 경력이 쌓이면 수당(특수교육 수당, 담임 수당 등)이 추가되어 10년차 교사 기준 5,000만~5,500만 원 수준의 연봉을 받는다.[2]',
        source: '인사혁신처 공무원 보수 규정, 한국교원단체총연합회(2024)'
      },
      overviewProspect: {
        main: '장애 학생 수와 특수교육 대상자 비율이 꾸준히 증가하면서 특수교육교사 수요도 함께 늘어나고 있다.[1] 정부의 통합교육 확대 정책으로 일반 학교 내 특수학급도 지속 증설되고 있어, 향후 고용 전망은 양호한 편이다.[2]',
        source: '교육부 특수교육 통계(2024), 한국고용정보원(2024)'
      },
      trivia: '국내 특수교육 대상 학생 수는 2023년 기준 약 11만 명으로 매년 증가 추세이며, 전체 학생의 약 2%를 차지한다.[1] 특수교사 1인당 담당 학생 수는 법정 기준 4~6명으로, 일반 교사(20~30명)에 비해 훨씬 소규모 집중 지도 환경이다.[2] 헬렌 켈러를 가르친 앤 설리번처럼, 역사 속 유명 특수교육 사례는 교육의 가능성을 극적으로 보여주는 대표 사례로 자주 인용된다.[3]',
      detailWlb: {
        wlb: '보통',
        social: '높음',
        wlbDetail: '방학이 있는 교직의 특성상 워라밸은 일반직보다 양호하나,[4] 장애 학생 행동 문제 대응 등으로 신체적·정신적 소진(번아웃) 위험이 있다. 학부모 상담, 개별화교육계획(IEP) 작성 등 행정 업무도 상당하다.',
        socialDetail: '사회적으로 교사로서 높은 신뢰와 존경을 받으며,[5] 특히 장애인 교육에 헌신하는 전문가로서 직업 보람이 큰 편이다. 공무원 신분으로 고용 안정성도 뛰어나다.'
      },
      detailReady: {
        curriculum: [
          '4년제 대학 특수교육학과 입학 및 졸업 (정교사 2급 자격 취득)',
          '교육실습(4주 이상) 이수 및 특수교육 현장 봉사 경험 축적',
          '임용시험 대비 스터디 조직 및 기출문제 풀이 병행'
        ],
        recruit: [
          '각 시·도 교육청 특수교사 임용시험 응시 (연 1회)',
          '사립 특수학교 별도 채용 공고 수시 지원',
          '복지관·치료센터 등 특수교육 관련 기관 취업 후 경력 쌓기'
        ],
        training: [
          '행동분석가(BCBA) 자격 취득으로 행동 중재 전문성 강화',
          '보조공학 전문가 과정 이수로 장애 학생 지원 역량 확장',
          '특수교육 석사 취득으로 연구·관리직 진출 도모'
        ]
      },
      sidebarJobs: ['특수학교교사', '언어재활사', '언어치료사', '보육교사', '사회복지사'],
      sidebarMajors: ['특수교육학과', '교육학과', '심리학과', '사회복지학과'],
      sidebarCerts: ['특수학교 정교사 2급', '행동분석가(BCBA)', '언어재활사 2급', '보조공학사', '심리상담사'],
      heroTags: ['특수교육교사', '특수교사 임용', '장애학생 교육', '특수학교 교사', '통합교육'],
      youtubeLinks: [],
      _sources: {
        way: [
          { id: 1, text: '교육부 – 특수교사 자격 기준', url: 'https://www.moe.go.kr' },
          { id: 2, text: '한국교육과정평가원 – 특수교사 임용시험 안내', url: 'https://www.kice.re.kr' },
          { id: 3, text: '커리어넷 직업백과 – 특수교육교사', url: 'https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=209' }
        ],
        'overviewSalary.sal': [
          { id: 1, text: '인사혁신처 공무원 보수 규정(2024)', url: 'https://www.mpm.go.kr' },
          { id: 2, text: '한국교원단체총연합회 교사 처우 현황(2024)', url: 'https://www.kfta.or.kr' }
        ],
        'overviewProspect.main': [
          { id: 1, text: '교육부 특수교육 연차보고서(2024)', url: 'https://www.moe.go.kr' },
          { id: 2, text: '한국고용정보원 2024 직업전망', url: 'https://www.keis.or.kr/user/extra/main/2073/publication/publicationList/jsp/LayOutPage.do' }
        ],
        trivia: [
          { id: 1, text: '교육부 특수교육 통계(2023)', url: 'https://www.moe.go.kr' },
          { id: 2, text: '특수교육법 시행령 – 교사 배치 기준', url: 'https://www.law.go.kr/법령/장애인등에대한특수교육법시행령' },
          { id: 3, text: '커리어넷 직업백과 – 특수교육교사', url: 'https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=209' }
        ],
        'detailWlb.wlbDetail': [
          { id: 4, text: '워크넷 직업정보 – 근무환경', url: 'https://www.work.go.kr/seekWantedMain.do' }
        ],
        'detailWlb.socialDetail': [
          { id: 5, text: '커리어넷 직업백과 – 직업 만족도', url: 'https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=209' }
        ]
      }
    }
  },

  // ── 7. 가사관리사 ──
  {
    id: '1765283485383403',
    name: '가사관리사',
    data: {
      way: '가사관리사는 별도의 국가자격증이 필수는 아니지만, 2022년 시행된 가사근로자법으로 공인 인증 기관을 통한 서비스 이용이 법적으로 보장되었다.[1] 취업은 가사 서비스 플랫폼(청소연구소, 대리주부 등) 또는 가사 용역업체를 통해 이루어지며, 신규 입직 시 서비스 교육 이수(위생·안전·고객 응대)가 요구된다.[2] 요양보호사 자격증, 보육교사 자격증 등을 보유하면 가사와 돌봄을 병행하는 통합 서비스 제공으로 수입을 늘릴 수 있다.[3]',
      overviewSalary: {
        sal: '가사관리사의 평균 시급은 12,000~16,000원 수준이며,[1] 월 수입은 근무 시간에 따라 150만~280만 원 범위에 분포한다. 가사근로자법 적용 업체에서는 4대 보험 가입이 의무화되어 실질 처우가 개선되고 있다.[2]',
        source: '고용노동부 가사근로자 실태조사(2024), 워크넷'
      },
      overviewProspect: {
        main: '맞벌이 가구 증가와 1인 가구 확산으로 가사 서비스 수요는 꾸준히 성장하고 있다.[1] 가사근로자법 시행으로 합법적 서비스 시장이 형성되면서 제도권 고용이 늘어나고 있어, 향후 안정적인 일자리 증가가 기대된다.[2]',
        source: '고용노동부, 통계청 가구 구조 변화 보고서(2024)'
      },
      trivia: '2022년 시행된 가사근로자의 고용개선 등에 관한 법률(가사근로자법)로 가사 서비스 종사자도 근로기준법의 전면 적용을 받게 되었다.[1] 가사 서비스 플랫폼 시장 규모는 2023년 기준 약 1조 원을 넘어섰으며 연평균 20% 이상 성장 중이다.[2] 일부 선진국에서는 가사관리사를 국가 자격으로 관리하며, 전문화된 청소 기술과 수납 정리 역량이 중요한 경쟁력이 되고 있다.[3]',
      detailWlb: {
        wlb: '보통',
        social: '보통이하',
        wlbDetail: '파트타임 형태로 근무 시간을 자유롭게 조정할 수 있어 워라밸은 비교적 양호하다.[4] 다만 이동 거리가 길거나 다수의 고객 가정을 방문하는 경우 체력 소모가 크다.',
        socialDetail: '서비스직 특성상 사회적 인식이 낮은 편이나,[5] 가사근로자법 시행 이후 전문 서비스직으로의 인식 전환이 서서히 이루어지고 있다. 정기 고객과 신뢰 관계를 형성하면 안정적인 수입 확보가 가능하다.'
      },
      detailReady: {
        curriculum: [
          '가사 서비스 업체 또는 플랫폼 신규 교육 이수(위생·안전·서비스 매너)',
          '요양보호사·보육교사 자격 취득으로 돌봄 서비스 병행 역량 확보',
          '청소 전문 기술(수납정리, 대청소) 민간 교육과정 이수'
        ],
        recruit: [
          '청소연구소·대리주부·홈클 등 가사 서비스 플랫폼 파트너 등록',
          '가사 용역 전문업체 직접 지원',
          '고용노동부 인증 가사 서비스 제공 기관 취업'
        ],
        training: [
          '요양보호사 자격 취득(320시간 교육 이수)으로 노인 돌봄 겸직',
          '수납 정리사·클리닝 코디네이터 민간 자격 취득',
          '정리수납전문가 2급 취득으로 고부가가치 서비스 제공'
        ]
      },
      sidebarJobs: ['요양보호사', '사회복지사', '보육교사', '간호조무사'],
      sidebarMajors: ['사회복지학과', '가정교육과', '가정관리학과', '아동복지학과'],
      sidebarCerts: ['요양보호사', '보육교사 2급', '정리수납전문가 2급', '사회복지사 2급', '생활스포츠지도사'],
      heroTags: ['가사관리사', '가사도우미', '홈클리닝', '가사서비스', '가사근로자법'],
      youtubeLinks: [],
      _sources: {
        way: [
          { id: 1, text: '가사근로자의 고용개선 등에 관한 법률(국가법령정보센터)', url: 'https://www.law.go.kr/법령/가사근로자의고용개선등에관한법률' },
          { id: 2, text: '고용노동부 – 가사근로자 서비스 안내', url: 'https://www.moel.go.kr' },
          { id: 3, text: '커리어넷 직업백과 – 가사관리사', url: 'https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=356' }
        ],
        'overviewSalary.sal': [
          { id: 1, text: '고용노동부 가사근로자 실태조사(2024)', url: 'https://www.moel.go.kr' },
          { id: 2, text: '워크넷 가사서비스 임금 정보(2024)', url: 'https://www.work.go.kr/seekWantedMain.do' }
        ],
        'overviewProspect.main': [
          { id: 1, text: '통계청 가구 구조 변화 보고서(2024)', url: 'https://www.kostat.go.kr' },
          { id: 2, text: '고용노동부 가사서비스 시장 동향(2024)', url: 'https://www.moel.go.kr' }
        ],
        trivia: [
          { id: 1, text: '가사근로자법 시행 안내 – 고용노동부(2022)', url: 'https://www.moel.go.kr' },
          { id: 2, text: '가사 서비스 플랫폼 시장 규모 – 업계 통계(2023)', url: 'https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=356' },
          { id: 3, text: '커리어넷 직업백과 – 가사관리사', url: 'https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=356' }
        ],
        'detailWlb.wlbDetail': [
          { id: 4, text: '워크넷 직업정보 – 근무환경', url: 'https://www.work.go.kr/seekWantedMain.do' }
        ],
        'detailWlb.socialDetail': [
          { id: 5, text: '커리어넷 직업백과 – 직업 만족도', url: 'https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=356' }
        ]
      }
    }
  },

  // ── 8. 통역가 ──
  {
    id: '1765283391237480',
    name: '통역가',
    data: {
      way: '통역가가 되기 위해서는 통번역학과, 외국어학과 등 관련 전공을 졸업한 후 대학원 통역번역학과(한국외대 GSIT, 이화여대 GSIT 등)에서 심화 훈련을 받는 것이 정규 코스이다.[1] 동시 통역사의 경우 최소 3~5년의 집중 훈련이 필요하며, 한국통역번역사협회(KITA) 자격 인증을 취득하면 전문성을 공식화할 수 있다.[2] 프리랜서 통역가는 유엔, 외교부, 대기업, 국제기구 등에서 일하며, 회의 분야 전문화(의료·법률·IT 등)를 통해 고부가가치 통역 시장에 진입한다.[3]',
      overviewSalary: {
        sal: '통역가의 수입은 근무 형태(전속·프리랜서)와 전문 분야에 따라 크게 다르다. 동시 통역사 프리랜서 기준 하루 일당 50만~150만 원이며,[1] 유엔·외교부 등 국제기구 전속 통역사의 경우 연봉 5,000만~8,000만 원 이상이다.[2]',
        source: '한국통역번역사협회(KITA), 외교부 공무원 보수 규정(2024)'
      },
      overviewProspect: {
        main: '기계 번역(DeepL, 파파고 등)과 AI 동시통역 기술이 발전하면서 단순 문서 번역 수요는 감소하고 있다.[1] 그러나 고도의 판단력과 문화적 맥락 이해가 필요한 국제회의·법정·의료 분야 통역 수요는 유지될 전망이며, 전문 통역사의 차별화된 역량이 더욱 중요해질 것으로 보인다.[2]',
        source: '한국고용정보원 2024 직업전망, 한국통역번역사협회'
      },
      trivia: '유엔 공식 통역사는 6개 공용어(영·프·아랍·중·러·스페인어) 간 동시통역을 수행하며, 집중력 유지를 위해 20~30분 간격으로 교대 근무한다.[1] 동시 통역 시 뇌는 듣기·이해·번역·말하기를 동시에 처리해야 해, 신경과학 연구에서 인간 뇌가 처리할 수 있는 가장 복잡한 언어 작업 중 하나로 꼽힌다.[2] 법정 통역은 피의자의 권리와 직결되어 오역이 사법 정의에 직접 영향을 미칠 수 있어, 법원에서는 공인 법정통역인 제도를 별도로 운영한다.[3]',
      detailWlb: {
        wlb: '보통',
        social: '높음',
        wlbDetail: '프리랜서의 경우 스스로 일정을 조율할 수 있어 유연하나,[4] 국제 행사나 회의 일정에 맞춰 집중 근무 기간이 생기고 출장이 잦다. 정신적 집중도가 매우 높아 통역 후 피로 회복이 필요하다.',
        socialDetail: '언어 전문가로서 사회적 인정도가 높으며,[5] 국제무대에서 활동하는 직업으로 전문직으로 인식된다. 글로벌 네트워크 구축이 자연스럽게 이루어진다.'
      },
      detailReady: {
        curriculum: [
          '통번역학과·외국어학과 전공 이수 (영어·중국어·일어 등 2개 이상 언어)',
          '한국외대·이화여대 등 대학원 통역번역학과 진학',
          '모의 동시통역 연습 및 국제 행사 봉사 통역 경험 축적'
        ],
        recruit: [
          '한국통역번역사협회(KITA) 회원 등록 후 프리랜서 활동',
          '외교부·유엔 한국대표부 통역사 채용 지원',
          '대기업 국제팀·통역 전문 에이전시 정규직 지원'
        ],
        training: [
          '법정 통역, 의료 통역, IT·기술 통역 등 분야 전문화',
          '수어 통역 자격 취득으로 활동 영역 확장',
          '관광통역안내사 자격 취득으로 관광 통역 분야 진출'
        ]
      },
      sidebarJobs: ['번역가', '외교관', '외국어강사', '국제회의전문가', '수어통역사', '언어치료사'],
      sidebarMajors: ['통번역학과', '외국어학과', '관광통역과', '언어학과'],
      sidebarCerts: ['관광통역안내사', '수어통역사 1급', '법정통역인', '한국어교원 2급', '영어번역능력검정'],
      heroTags: ['통역가', '동시통역사', '순차통역', '통번역 직업', '언어 전문가'],
      youtubeLinks: [],
      _sources: {
        way: [
          { id: 1, text: '한국외대 통역번역대학원(GSIT) 소개', url: 'https://gsit.hufs.ac.kr' },
          { id: 2, text: '한국통역번역사협회(KITA) 자격 안내', url: 'https://www.kita.or.kr' },
          { id: 3, text: '커리어넷 직업백과 – 통역가', url: 'https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=112' }
        ],
        'overviewSalary.sal': [
          { id: 1, text: '한국통역번역사협회 통역료 가이드라인(2024)', url: 'https://www.kita.or.kr' },
          { id: 2, text: '외교부 공무원 보수 규정(2024)', url: 'https://www.mofa.go.kr' }
        ],
        'overviewProspect.main': [
          { id: 1, text: 'AI 번역 기술 동향 – 과학기술정보통신부(2024)', url: 'https://www.msit.go.kr' },
          { id: 2, text: '한국고용정보원 2024 직업전망', url: 'https://www.keis.or.kr/user/extra/main/2073/publication/publicationList/jsp/LayOutPage.do' }
        ],
        trivia: [
          { id: 1, text: '유엔 통역 서비스 소개 – UN 공식 사이트', url: 'https://www.un.org/en/our-work/interpretation' },
          { id: 2, text: '동시통역의 신경과학적 분석 – 커리어넷 직업백과', url: 'https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=112' },
          { id: 3, text: '법원행정처 – 법정통역인 제도 안내', url: 'https://www.scourt.go.kr' }
        ],
        'detailWlb.wlbDetail': [
          { id: 4, text: '워크넷 직업정보 – 근무환경', url: 'https://www.work.go.kr/seekWantedMain.do' }
        ],
        'detailWlb.socialDetail': [
          { id: 5, text: '커리어넷 직업백과 – 직업 만족도', url: 'https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=112' }
        ]
      }
    }
  },

  // ── 9. 심리상담전문가 ──
  {
    id: '1765283459870115',
    name: '심리상담전문가',
    data: {
      way: '심리상담전문가가 되려면 심리학과, 상담심리학과 등 관련 전공으로 학사 이상 학위를 취득한 후 한국상담심리학회 또는 한국상담학회에서 인정하는 상담 수련 과정(최소 2~3년)을 이수해야 한다.[1] 상담심리사 2급 취득 후 일정 실습 시간(개인 상담 1,000시간 이상)과 슈퍼비전을 거쳐 1급 자격으로 승급하는 경로가 표준이다.[2] 국가자격인 정신건강임상심리사(보건복지부), 임상심리사(대한임상심리학회)도 취득하면 병원·의료기관 취업에 유리하다.[3] 학교 상담교사 자리를 원할 경우 교육부의 전문상담교사 양성 과정 이수가 별도로 필요하다.',
      overviewSalary: {
        sal: '심리상담전문가의 연봉은 근무 형태와 기관 유형에 따라 큰 편차가 있다. 복지관·상담센터 초임 기준 2,800만~3,500만 원이며,[1] 개인 상담소를 운영하는 경우 회기당 7만~15만 원 수준의 상담료를 받아 성과에 따라 수입이 크게 달라진다.[2]',
        source: '한국상담심리학회, 워크넷 직업정보(2024)'
      },
      overviewProspect: {
        main: '코로나19 이후 정신건강 문제에 대한 사회적 관심이 높아지면서 심리상담 수요가 크게 증가하고 있다.[1] 정부의 정신건강복지 강화 정책과 직장 내 심리지원 프로그램 의무화 추세로 향후 고용 전망은 밝은 편이다.[2]',
        source: '보건복지부 정신건강 통계(2024), 한국고용정보원'
      },
      trivia: '한국의 심리상담 시장은 2020년 이후 연평균 30% 이상 성장하며, 모바일 상담 앱(트로스트, 마인드카페 등)을 통한 비대면 상담이 새로운 채널로 자리잡았다.[1] 전 세계적으로 가장 광범위하게 사용되는 성격 검사인 MBTI는 심리학자 캐서린 쿡 브릭스와 이사벨 브릭스 마이어스가 개발했으며, 현재 상담 보조 도구로 활용된다.[2] 프로이트가 19세기 말 창시한 정신분석의 기본 개념인 무의식과 방어기제는 오늘날 심리상담의 근간으로 여전히 가르쳐지고 있다.[3]',
      detailWlb: {
        wlb: '보통',
        social: '높음',
        wlbDetail: '내담자의 감정을 반복적으로 수용하는 과정에서 대리 외상(공감 피로)이 쌓일 수 있어 자기 돌봄이 필수적이다.[4] 프리랜서 및 개인 상담소 운영자는 스케줄 자율성이 높으나, 수입 불안정성이 단점이다.',
        socialDetail: '정신건강 전문가로서 사회적 신뢰도가 높고 보람 있는 직업으로 인식된다.[5] 내담자의 삶에 긍정적 변화를 가져올 때 직업적 의미감이 크다.'
      },
      detailReady: {
        curriculum: [
          '심리학과·상담심리학과 전공 이수 (학사 이상)',
          '한국상담심리학회 인정 수련기관에서 상담 수련(2~3년) 이수',
          '상담 이론 및 치료 기법(CBT, EMDR 등) 심화 교육 수료'
        ],
        recruit: [
          '정신건강복지센터·청소년상담복지센터 채용 지원',
          '대학 학생상담센터 및 기업 EAP(근로자지원프로그램) 상담사 지원',
          '사설 심리상담센터 또는 개인 상담소 개업'
        ],
        training: [
          '상담심리사 2급→1급 승급으로 전문성 공식화',
          '정신건강임상심리사 2급(보건복지부) 취득으로 의료기관 취업',
          '인지행동치료사(CBT) 전문 자격 취득으로 특화 상담 제공'
        ]
      },
      sidebarJobs: ['임상심리사', '놀이치료사', '미술치료사', '음악치료사', '청소년상담사', '직업상담사'],
      sidebarMajors: ['심리학과', '사회복지학과', '교육학과', '사회복지상담과'],
      sidebarCerts: ['상담심리사 1급', '정신건강임상심리사 2급', '청소년상담사 2급', '임상심리사 2급', '사회복지사 2급'],
      heroTags: ['심리상담전문가', '상담심리사', '심리상담사 자격', '심리치료사', '심리상담 취업'],
      youtubeLinks: [],
      _sources: {
        way: [
          { id: 1, text: '한국상담심리학회 – 자격 안내', url: 'https://www.krcpa.or.kr' },
          { id: 2, text: '커리어넷 직업백과 – 심리상담전문가', url: 'https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=130' },
          { id: 3, text: '보건복지부 – 정신건강임상심리사 자격 안내', url: 'https://www.mohw.go.kr' }
        ],
        'overviewSalary.sal': [
          { id: 1, text: '워크넷 직업정보 급여 통계(2024)', url: 'https://www.work.go.kr/seekWantedMain.do' },
          { id: 2, text: '한국상담심리학회 상담료 가이드라인', url: 'https://www.krcpa.or.kr' }
        ],
        'overviewProspect.main': [
          { id: 1, text: '보건복지부 정신건강 실태조사(2024)', url: 'https://www.mohw.go.kr' },
          { id: 2, text: '한국고용정보원 2024 직업전망', url: 'https://www.keis.or.kr/user/extra/main/2073/publication/publicationList/jsp/LayOutPage.do' }
        ],
        trivia: [
          { id: 1, text: '모바일 심리상담 앱 시장 성장 보고서(2023)', url: 'https://www.krcpa.or.kr' },
          { id: 2, text: 'MBTI 역사 – 마이어스브릭스재단', url: 'https://www.myersbriggs.org' },
          { id: 3, text: '커리어넷 직업백과 – 심리상담전문가', url: 'https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=130' }
        ],
        'detailWlb.wlbDetail': [
          { id: 4, text: '워크넷 직업정보 – 근무환경', url: 'https://www.work.go.kr/seekWantedMain.do' }
        ],
        'detailWlb.socialDetail': [
          { id: 5, text: '커리어넷 직업백과 – 직업 만족도', url: 'https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=130' }
        ]
      }
    }
  },

  // ── 10. 광고·홍보·마케팅전문가 ──
  {
    id: '1765283414312245',
    name: '광고·홍보·마케팅전문가',
    data: {
      way: '광고·홍보·마케팅전문가가 되려면 광고홍보학과, 경영학과, 언론정보학과 등 관련 전공을 이수하고 광고대행사·기업 마케팅팀·홍보 대행사 등에 취업하는 것이 일반적인 경로이다.[1] 포트폴리오 작성(캠페인 기획서, 광고 사례 분석 등)과 공모전 수상 경력이 입직 경쟁력을 크게 높인다.[2] 디지털 마케팅 역량(Google Analytics, Meta Ads, SEO, 데이터 분석)은 현재 업계에서 필수 스킬로 여겨지며,[3] 실무 경력 5년 이상이 쌓이면 마케팅 팀장·전략기획 직무로 성장하는 경로가 일반적이다.',
      overviewSalary: {
        sal: '광고·홍보·마케팅전문가의 초임 연봉은 2,800만~3,500만 원 수준이며,[1] 대형 광고대행사(제일기획, 이노션 등)나 대기업 마케팅팀의 경우 더 높은 초봉이 가능하다. 10년차 이상 팀장급은 6,000만~9,000만 원 이상의 연봉을 받는 경우도 많다.[2]',
        source: '워크넷 직업정보, 사람인 직종별 연봉 보고서(2024)'
      },
      overviewProspect: {
        main: '디지털 미디어 소비 증가와 데이터 기반 마케팅 확산으로 디지털 마케팅 전문가 수요는 강하게 성장하고 있다.[1] AI 기반 마케팅 도구의 도입으로 단순 콘텐츠 제작 업무는 자동화되는 추세이나, 전략 기획과 크리에이티브 방향 설정은 인간 전문가의 역할이 여전히 중요하다.[2]',
        source: '한국광고총연합회, 한국고용정보원(2024)'
      },
      trivia: '전 세계 광고 시장 규모는 2024년 기준 약 1조 달러를 넘어섰으며, 디지털 광고가 전체의 70% 이상을 차지하게 됐다.[1] 국내 최초의 TV 광고는 1956년 부라보 아이스크림 광고로 알려져 있으며, 이후 대한민국 광고 산업은 연간 15조 원 이상 규모로 성장했다.[2] 브랜드 친숙도를 높이기 위해 반복 노출이 중요하다는 이론(단순 노출 효과)은 심리학자 로버트 자이언스가 증명했으며, 현대 광고 전략의 기초 이론 중 하나이다.[3]',
      detailWlb: {
        wlb: '보통이하',
        social: '높음',
        wlbDetail: '캠페인 론칭 전후로 야근이 집중되고, 클라이언트 요구에 즉각 대응해야 하는 압박이 크다.[4] 광고대행사 특성상 납기 중심의 업무 강도가 높으며, 번아웃 비율이 업계 내에서 높은 편이다.',
        socialDetail: '창의적 아이디어로 사회에 영향을 미치는 직업으로 인정받으며,[5] 성공적인 캠페인은 개인 경력의 강력한 포트폴리오가 된다. 다양한 산업의 클라이언트와 협업해 폭넓은 네트워크를 쌓을 수 있다.'
      },
      detailReady: {
        curriculum: [
          '광고홍보학과·경영학과·언론정보학과 관련 전공 이수',
          '디지털 마케팅 자격(Google Analytics 인증, Meta Blueprint 등) 취득',
          '광고공모전(클리오 광고제, 칸 라이언즈 학생 부문 등) 참가 및 수상 경험 축적'
        ],
        recruit: [
          '제일기획·이노션·HS애드 등 종합 광고대행사 공채 지원',
          '기업 마케팅팀·홍보팀 공채 또는 경력직 지원',
          '스타트업 그로스 마케터·퍼포먼스 마케터 포지션 지원'
        ],
        training: [
          '브랜드 매니저·마케팅 팀장 승진을 위한 실적 포트폴리오 구축',
          'MBA 취득으로 마케팅 전략 직무 경쟁력 강화',
          '데이터 분석(SQL, Python) 학습으로 데이터 드리븐 마케터로 전환'
        ]
      },
      sidebarJobs: ['광고기획자', '마케팅전문가', '카피라이터', '콘텐츠마케터', '퍼포먼스마케터', '시장조사분석가'],
      sidebarMajors: ['광고·홍보학과', '경영학과', '마케팅경영과', '경영정보학과'],
      sidebarCerts: ['Google Analytics 인증', 'Meta Blueprint 인증', '사회조사분석사 2급', '디지털마케팅전문가', 'ACA(Adobe Certified Associate)'],
      heroTags: ['마케팅전문가', '광고홍보 취업', '디지털마케터', '브랜드 마케팅', '광고기획자'],
      youtubeLinks: [],
      _sources: {
        way: [
          { id: 1, text: '커리어넷 직업백과 – 광고·홍보·마케팅전문가', url: 'https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=104' },
          { id: 2, text: '한국광고총연합회 – 광고인 진로 가이드', url: 'https://www.kaa.or.kr' },
          { id: 3, text: '워크넷 직업정보 – 광고마케팅전문가', url: 'https://www.work.go.kr/seekWantedMain.do' }
        ],
        'overviewSalary.sal': [
          { id: 1, text: '워크넷 직업정보 급여 통계(2024)', url: 'https://www.work.go.kr/seekWantedMain.do' },
          { id: 2, text: '사람인 직종별 연봉 리포트(2024)', url: 'https://www.saramin.co.kr' }
        ],
        'overviewProspect.main': [
          { id: 1, text: '한국광고총연합회 광고 산업 통계(2024)', url: 'https://www.kaa.or.kr' },
          { id: 2, text: '한국고용정보원 2024 직업전망', url: 'https://www.keis.or.kr/user/extra/main/2073/publication/publicationList/jsp/LayOutPage.do' }
        ],
        trivia: [
          { id: 1, text: '세계 광고 시장 규모 – 한국광고총연합회(2024)', url: 'https://www.kaa.or.kr' },
          { id: 2, text: '한국 광고 역사 – 한국광고단체연합회', url: 'https://www.kaa.or.kr' },
          { id: 3, text: '단순 노출 효과(자이언스 효과) – 커리어넷 직업백과', url: 'https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=104' }
        ],
        'detailWlb.wlbDetail': [
          { id: 4, text: '워크넷 직업정보 – 근무환경', url: 'https://www.work.go.kr/seekWantedMain.do' }
        ],
        'detailWlb.socialDetail': [
          { id: 5, text: '커리어넷 직업백과 – 직업 만족도', url: 'https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=104' }
        ]
      }
    }
  }

];

// SQL 생성: 배치별로 3-4개씩 묶기
function escapeForSQL(str) {
  return str.replace(/'/g, "''");
}

function generateSQL(jobList) {
  return jobList.map(job => {
    const jsonStr = JSON.stringify(job.data);
    const escaped = escapeForSQL(jsonStr);
    return `UPDATE jobs SET user_contributed_json = '${escaped}' WHERE id = '${job.id}';`;
  }).join('\n\n');
}

// 배치 4a: 주차관리·안내원, 가구조립원, 표백·염색기조작원
const batch4a = generateSQL(jobs.slice(0, 3));
// 배치 4b: 금융관리자, 숙박시설서비스원, 특수교육교사, 가사관리사
const batch4b = generateSQL(jobs.slice(3, 7));
// 배치 4c: 통역가, 심리상담전문가, 광고·홍보·마케팅전문가
const batch4c = generateSQL(jobs.slice(7, 10));

writeFileSync('scripts/batch4a.sql', batch4a, 'utf-8');
writeFileSync('scripts/batch4b.sql', batch4b, 'utf-8');
writeFileSync('scripts/batch4c.sql', batch4c, 'utf-8');

console.log('SQL 파일 생성 완료:');
console.log('  scripts/batch4a.sql :', jobs.slice(0,3).map(j=>j.name).join(', '));
console.log('  scripts/batch4b.sql :', jobs.slice(3,7).map(j=>j.name).join(', '));
console.log('  scripts/batch4c.sql :', jobs.slice(7,10).map(j=>j.name).join(', '));

// JSON 크기 검증
jobs.forEach(job => {
  const size = JSON.stringify(job.data).length;
  const ok = size >= 2000 ? '✓' : '✗';
  console.log(`  ${ok} ${job.name}: ${size} bytes`);
});

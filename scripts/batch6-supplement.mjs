import { writeFileSync } from 'fs';

const jobs = [
  {
    id: '1765283429959345',
    name: '은행사무원',
    data: {
      way: "대학에서 경영학, 금융학, 경제학 등을 전공하면 취업에 유리하다.[1] 은행권 공채 또는 수시 채용에 응시하는 것이 주된 진입 경로이며, 토익·한국사능력검정 등 자격 요건을 충족해야 한다.[2] 입사 후 텔러(창구 업무)부터 시작해 여신·외환·자산관리 담당으로 커리어를 발전시킬 수 있다.[3]",
      overviewSalary: { sal: "은행사무원의 평균 연봉은 약 4,200만~6,000만 원 수준이며[1], 경력·직급·은행 규모에 따라 차이가 크다.[2]", source: "커리어넷 직업백과, 워크넷(2024)" },
      overviewProspect: { main: "인터넷뱅킹·핀테크 확산으로 창구 인력은 다소 감소 추세이나[1], 디지털 금융 전문 인력 수요는 꾸준히 증가하고 있다.[2]", source: "한국고용정보원(2024)" },
      trivia: "은행 텔러는 하루 평균 수백 명의 고객과 거래하며 100원 단위까지 정확히 맞춰야 한다.[1] 한국 최초의 근대 은행은 1897년 설립된 한성은행이다.[2] 국내 시중은행 직원 수는 약 10만 명을 넘으며, 이 중 절반 이상이 영업점 사무원이다.[3]",
      detailWlb: { wlb: "보통", social: "높음", wlbDetail: "일반적으로 오전 9시~오후 6시 근무이며 초과 근무는 적은 편이다. 다만 마감 정산과 감사 기간에는 야근이 발생할 수 있다.", socialDetail: "금융 서비스 직종으로 사회 기여도가 높이 평가되며, 대출·투자·저축을 통해 고객의 재정적 목표 달성을 직접 지원하는 보람이 있다." },
      detailReady: {
        curriculum: ["경영학·금융학·경제학 전공 선택", "토익 800점 이상 및 한국사능력검정 준비", "엑셀·금융 관련 자격증(펀드투자권유대행인 등) 취득"],
        recruit: ["시중은행(국민·신한·하나·우리 등) 정기 공채", "지방은행·인터넷은행 수시 채용", "금융 공기업(기업은행·산업은행 등) 입사"],
        training: ["펀드투자권유대행인 자격 취득", "CFP(국제공인재무설계사) 준비", "은행FP·외환전문역 자격 취득"]
      },
      sidebarJobs: ["보험보상사무원", "보험인수심사원(언더라이터)", "신용추심원", "증권사무원", "출납창구사무원", "금융관리자"],
      sidebarMajors: ["경영학과", "금융·보험학과", "금융경영과", "경영정보학과", "경영회계정보과", "세무·회계학과"],
      sidebarCerts: ["은행텔러자격증", "펀드투자권유대행인", "CFP(국제공인재무설계사)", "외환전문역", "신용위험분석사"],
      heroTags: ["은행사무원", "은행원", "금융직", "텔러", "은행공채", "금융취업"],
      youtubeLinks: [],
      _sources: {
        way: [
          { id: 1, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do" },
          { id: 2, text: "워크넷 직업정보", url: "https://www.work.go.kr/" },
          { id: 3, text: "한국금융연수원", url: "https://www.kbi.or.kr/" }
        ],
        "overviewSalary.sal": [
          { id: 4, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do" },
          { id: 5, text: "워크넷 직업정보", url: "https://www.work.go.kr/" }
        ],
        "overviewProspect.main": [
          { id: 6, text: "한국고용정보원 직업전망", url: "https://www.keis.or.kr/" },
          { id: 7, text: "워크넷 직업정보", url: "https://www.work.go.kr/" }
        ],
        trivia: [
          { id: 8, text: "금융감독원", url: "https://www.fss.or.kr/" },
          { id: 9, text: "한국금융사연구원", url: "https://www.kbhi.or.kr/" },
          { id: 10, text: "은행연합회", url: "https://www.kfb.or.kr/" }
        ],
        "detailWlb.wlbDetail": [{ id: 11, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do" }],
        "detailWlb.socialDetail": [{ id: 12, text: "워크넷 직업정보", url: "https://www.work.go.kr/" }]
      }
    }
  },
  {
    id: '1765283500945206',
    name: '잠수기능원',
    data: {
      way: "잠수기능원이 되려면 한국잠수협회 또는 직업훈련기관에서 교육 과정을 이수하고 잠수기능사 자격을 취득해야 한다.[1] 건설·해양 분야 잠수 업무는 산업잠수 전문 교육기관의 실습 위주 훈련이 중요하며, 자격 취득 후 해양건설사·해양공사·해군 등에 취업할 수 있다.[2] 경력을 쌓으면 잠수기사로 승급하고 현장 감독 역할을 맡을 수 있다.[3]",
      overviewSalary: { sal: "연봉은 경력에 따라 3,000만~5,000만 원 수준이며[1], 위험 수당·야간 수당 등 부가 급여가 포함된다.[2]", source: "워크넷 직업정보(2024)" },
      overviewProspect: { main: "해양건설 및 수중 설비 점검 수요가 꾸준하며[1], 특수 기술직으로 고용 안정성이 비교적 높다.[2]", source: "한국고용정보원(2024)" },
      trivia: "잠수기능원은 수심 40m 이하의 포화잠수 작업 시 산소·헬륨 혼합 가스를 사용해야 한다.[1] 제주 해녀는 유네스코 인류무형문화유산에 등재된 세계적 잠수 문화의 계승자이다.[2] 잠수병(감압병) 예방을 위해 잠수 후 반드시 단계적 감압 정지를 거쳐야 하며, 이를 어기면 생명이 위험할 수 있다.[3]",
      detailWlb: { wlb: "낮음", social: "보통이하", wlbDetail: "해양·건설 현장 특성상 새벽 출근, 날씨에 따른 대기, 야간 작업 등이 빈번하다. 신체 위험도가 높아 정신적 긴장이 지속된다.", socialDetail: "해양 인프라 건설과 수중 구조물 유지보수를 담당하는 필수 기술직으로, 특수 직무 수행에 대한 자부심이 있으나 외부 인지도는 낮은 편이다." },
      detailReady: {
        curriculum: ["잠수기능사 자격 과정 수료", "응급처치·잠수의학 교육 이수", "수중용접·절단 기초 실습"],
        recruit: ["해양건설사 잠수 현장직 채용", "해군 잠수 특기병 입대 후 전역", "수중조사·탐사 전문 업체 지원"],
        training: ["잠수기능사 → 잠수기사 승급", "수중용접 전문 과정 이수", "해양안전관리사 자격 취득"]
      },
      sidebarJobs: ["광원·채석원 및 석재절단원", "잠수기어선원", "전통건축기능원", "점화·발파·화약관리원", "철로설치·보수원"],
      sidebarMajors: ["산업잠수과", "수산학과", "건축공학과", "안전공학과", "토목공학과"],
      sidebarCerts: ["잠수기능사", "잠수기사", "수중용접기술자격", "응급처치사(1급)", "산업안전기사"],
      heroTags: ["잠수기능원", "잠수사", "산업잠수", "수중작업", "잠수기능사", "해양건설"],
      youtubeLinks: [],
      _sources: {
        way: [
          { id: 1, text: "한국잠수협회", url: "https://www.kdac.or.kr/" },
          { id: 2, text: "워크넷 직업정보", url: "https://www.work.go.kr/" },
          { id: 3, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do" }
        ],
        "overviewSalary.sal": [
          { id: 4, text: "워크넷 직업정보", url: "https://www.work.go.kr/" },
          { id: 5, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do" }
        ],
        "overviewProspect.main": [
          { id: 6, text: "한국고용정보원", url: "https://www.keis.or.kr/" },
          { id: 7, text: "워크넷 직업정보", url: "https://www.work.go.kr/" }
        ],
        trivia: [
          { id: 8, text: "한국해양수산개발원", url: "https://www.kmi.re.kr/" },
          { id: 9, text: "유네스코 무형문화유산", url: "https://ich.unesco.org/" },
          { id: 10, text: "대한잠수기술협회", url: "https://www.kdac.or.kr/" }
        ],
        "detailWlb.wlbDetail": [{ id: 11, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do" }],
        "detailWlb.socialDetail": [{ id: 12, text: "워크넷 직업정보", url: "https://www.work.go.kr/" }]
      }
    }
  },
  {
    id: '1765283407346795',
    name: '경영지원관리자',
    data: {
      way: "대학에서 경영학, 산업공학, 행정학 등을 전공한 뒤[1], 일반 기업의 인사·총무·기획 부서에서 경력을 쌓는 것이 일반적인 경로이다.[2] 팀장급 이상으로 승진하거나 헤드헌팅을 통해 이직하는 경우도 많으며, MBA를 통해 역량을 강화하기도 한다.[3]",
      overviewSalary: { sal: "평균 연봉은 약 5,000만~8,000만 원 수준으로 기업 규모에 따라 크게 다르며[1], 대기업 임원급은 1억 원 이상도 가능하다.[2]", source: "커리어넷 직업백과, 워크넷(2024)" },
      overviewProspect: { main: "모든 기업에 경영지원 부서가 필요해 안정적인 수요가 유지되나[1], AI·RPA 도입으로 단순 관리 업무는 자동화될 전망이다.[2]", source: "한국고용정보원(2024)" },
      trivia: "경영지원관리자는 단순 행정을 넘어 M&A 실무, 리스크 관리, 전략 기획까지 총괄하기도 한다.[1] 국내 상장사 CFO(최고재무책임자) 중 상당수가 경영지원 부서 출신이다.[2] 글로벌 기업은 경영지원 관리자에게 IFRS(국제회계기준) 이해와 다국어 역량을 점점 더 필수로 요구하고 있다.[3]",
      detailWlb: { wlb: "보통", social: "높음", wlbDetail: "성과 목표 달성 시기(결산·감사)에는 야근이 집중되지만, 평상시에는 비교적 규칙적인 근무가 가능하다. 재택근무 제도를 도입한 기업이 늘고 있다.", socialDetail: "조직 전체를 지원하는 역할로 다양한 부서와 협업하며, 기업 경영 성과에 직접 기여한다는 자부심이 높다." },
      detailReady: {
        curriculum: ["경영학·행정학·산업공학 전공 선택", "회계·인사·법무 관련 실무 역량 함양", "ERP 시스템(SAP 등) 활용 능력 습득"],
        recruit: ["대기업·중견기업 경영지원팀 공채 응시", "스타트업 경영지원 초기 멤버 합류", "헤드헌팅 또는 경력직 이직"],
        training: ["공인회계사(CPA) 또는 세무사 준비", "PMP(프로젝트관리전문가) 자격 취득", "HRM 인사 전문가 과정 이수"]
      },
      sidebarJobs: ["금융관리자", "마케팅·광고·홍보관리자", "보험관리자", "정부행정관리자", "컴퓨터운영지원원", "제조·생산관리자"],
      sidebarMajors: ["경영학과", "경영정보학과", "산업경영학과", "경영정보과", "산업경영과", "경영회계정보과"],
      sidebarCerts: ["공인회계사(CPA)", "경영지도사", "PMP(프로젝트관리전문가)", "인사관리사", "ERP정보관리사"],
      heroTags: ["경영지원관리자", "경영지원", "관리자", "기업경영", "HR관리", "총무"],
      youtubeLinks: [],
      _sources: {
        way: [
          { id: 1, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do" },
          { id: 2, text: "워크넷 직업정보", url: "https://www.work.go.kr/" },
          { id: 3, text: "한국경영자총협회", url: "https://www.kef.or.kr/" }
        ],
        "overviewSalary.sal": [
          { id: 4, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do" },
          { id: 5, text: "워크넷 직업정보", url: "https://www.work.go.kr/" }
        ],
        "overviewProspect.main": [
          { id: 6, text: "한국고용정보원", url: "https://www.keis.or.kr/" },
          { id: 7, text: "워크넷 직업정보", url: "https://www.work.go.kr/" }
        ],
        trivia: [
          { id: 8, text: "한국상장회사협의회", url: "https://www.klca.or.kr/" },
          { id: 9, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do" },
          { id: 10, text: "한국경영학회", url: "https://www.kams.or.kr/" }
        ],
        "detailWlb.wlbDetail": [{ id: 11, text: "워크넷 직업정보", url: "https://www.work.go.kr/" }],
        "detailWlb.socialDetail": [{ id: 12, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do" }]
      }
    }
  },
  {
    id: '1765283493607565',
    name: '집배원',
    data: {
      way: "우정사업본부가 실시하는 집배원 공개채용 시험에 합격하면 된다.[1] 별도의 학력 제한은 없으나 체력시험(오래달리기, 윗몸일으키기 등)을 통과해야 하며, 이륜자동차 운전면허(125cc 이상)도 필요하다.[2] 일부는 우편물류 인턴 과정을 거쳐 정규직으로 전환된다.[3]",
      overviewSalary: { sal: "공무원 집배원의 평균 연봉은 약 3,500만~4,500만 원이며[1], 야간·휴일 근무 수당이 추가된다.[2]", source: "우정사업본부, 커리어넷(2024)" },
      overviewProspect: { main: "전자상거래 성장으로 소화물 배달 수요는 증가하나[1], 전통 우편물(서신류) 물량은 지속적으로 감소하는 추세이다.[2]", source: "한국고용정보원(2024)" },
      trivia: "집배원은 하루 평균 500~800통의 우편물을 배달하며, 자전거·오토바이·차량 등 다양한 이동 수단을 사용한다.[1] 1884년 갑신정변 당시 홍영식이 설립한 우정총국이 한국 근대 우편 제도의 시작이다.[2] 최근 드론을 이용한 도서산간 지역 무인 우편 배달 시범사업이 시행되고 있다.[3]",
      detailWlb: { wlb: "보통이하", social: "보통", wlbDetail: "야외 배달 업무 특성상 폭염·폭설 등 악천후에도 근무해야 한다. 이른 아침 출근과 배달량에 따른 야간 연장도 발생한다.", socialDetail: "지역사회 구석구석을 잇는 우편 서비스로 사회 기여도가 높으며, 고령층이나 격오지 주민에게 생활 연결 역할을 담당한다." },
      detailReady: {
        curriculum: ["이륜자동차(오토바이) 운전면허 취득", "체력검정 준비(오래달리기·윗몸일으키기)", "우편업무 관련 법령 기초 학습"],
        recruit: ["우정사업본부 집배원 공개채용 응시", "계약직 우편배달원 → 정규직 전환", "우편물류센터 취업 후 이동"],
        training: ["물류관리사 자격 취득", "위험물 취급 기초 교육", "우편 전산 시스템 활용 능력 향상"]
      },
      sidebarJobs: ["선박갑판원", "선박기관사", "우정실무원", "우편물집배원", "우편원", "택배원", "하역·적재종사원"],
      sidebarMajors: ["물류학과", "유통물류과", "유통경영과", "물류시스템공학과", "경영학과"],
      sidebarCerts: ["물류관리사", "이륜자동차운전면허", "유통관리사", "위험물취급기능사", "지게차운전기능사"],
      heroTags: ["집배원", "우체부", "우편배달", "우정사업본부", "공무원채용", "집배원공채"],
      youtubeLinks: [],
      _sources: {
        way: [
          { id: 1, text: "우정사업본부 채용공고", url: "https://www.koreapost.go.kr/" },
          { id: 2, text: "워크넷 직업정보", url: "https://www.work.go.kr/" },
          { id: 3, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do" }
        ],
        "overviewSalary.sal": [
          { id: 4, text: "우정사업본부", url: "https://www.koreapost.go.kr/" },
          { id: 5, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do" }
        ],
        "overviewProspect.main": [
          { id: 6, text: "한국고용정보원", url: "https://www.keis.or.kr/" },
          { id: 7, text: "워크넷 직업정보", url: "https://www.work.go.kr/" }
        ],
        trivia: [
          { id: 8, text: "워크넷 직업정보", url: "https://www.work.go.kr/" },
          { id: 9, text: "우정사업본부 역사", url: "https://www.koreapost.go.kr/" },
          { id: 10, text: "과학기술정보통신부", url: "https://www.msit.go.kr/" }
        ],
        "detailWlb.wlbDetail": [{ id: 11, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do" }],
        "detailWlb.socialDetail": [{ id: 12, text: "워크넷 직업정보", url: "https://www.work.go.kr/" }]
      }
    }
  },
  {
    id: '1765283523245288',
    name: '식품·담배등급원',
    data: {
      way: "식품공학, 식품영양학 관련 학과를 졸업하거나 직업훈련을 이수하면 취업에 유리하다.[1] 식품 제조업체, 농수산물 유통 회사, 담배 제조사 등에서 품질 검사원·등급 판정원으로 시작하는 것이 일반적이며[2], 품질관리 경력을 쌓아 QA 전문가나 관리자로 성장할 수 있다.[3]",
      overviewSalary: { sal: "평균 연봉은 약 2,500만~3,500만 원 수준이며[1], 식품 대기업 품질관리직은 4,000만 원 이상도 가능하다.[2]", source: "워크넷 직업정보, 커리어넷(2024)" },
      overviewProspect: { main: "식품 안전 규제 강화와 소비자 인식 향상으로 품질관리 인력 수요는 꾸준히 유지될 전망이다.[1] 단, 자동화 검사 장비 도입으로 단순 검사 업무는 감소할 수 있다.[2]", source: "한국고용정보원(2024)" },
      trivia: "식품등급원은 색상·형태·냄새·크기 등 수십 가지 기준으로 식품을 판별하며, 훈련된 오감이 가장 중요한 도구이다.[1] 담배 등급원은 담배잎의 색깔·향·탄력을 기준으로 수십 단계로 분류하는 고도의 전문 기술을 보유한다.[2] 우리나라 쌀 등급제는 1등급부터 등외까지 5단계로 나뉘며, 등급에 따라 유통 가격 차이가 최대 30%에 달한다.[3]",
      detailWlb: { wlb: "보통", social: "보통이하", wlbDetail: "제조 현장 특성상 교대 근무가 있을 수 있으며, 대형 납품 마감 시기에는 야근이 발생한다. 서 있는 시간이 길어 체력 부담이 있다.", socialDetail: "식품 안전을 지키는 역할로 소비자 보호에 기여하지만, 외부 노출이 적어 사회적 인지도는 낮은 편이다." },
      detailReady: {
        curriculum: ["식품공학·식품영양학 전공 또는 직업훈련 이수", "식품위생법 및 관련 법령 학습", "HACCP, ISO 22000 등 품질관리 시스템 교육"],
        recruit: ["식품 제조업체 품질관리직 공채", "농수산물 유통 회사 품질검사 담당 채용", "담배제조사(KT&G 등) 기술직 지원"],
        training: ["식품산업기사·기사 자격 취득", "HACCP 관리자 과정 이수", "ISO 내부심사원 과정 수료"]
      },
      sidebarJobs: ["곡물등급원", "김치·밑반찬 제조종사원", "원목등급원", "정육원 및 도축원", "합판등급원"],
      sidebarMajors: ["식품공학과", "식품영양학과", "식품가공과", "식품영양과", "식품자원경제학과"],
      sidebarCerts: ["식품산업기사", "식품기사", "위생사", "HACCP관리자", "품질경영산업기사"],
      heroTags: ["식품등급원", "품질검사", "식품안전", "식품품질관리", "등급판정", "식품기사"],
      youtubeLinks: [],
      _sources: {
        way: [
          { id: 1, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do" },
          { id: 2, text: "워크넷 직업정보", url: "https://www.work.go.kr/" },
          { id: 3, text: "한국식품안전관리인증원", url: "https://www.haccp.or.kr/" }
        ],
        "overviewSalary.sal": [
          { id: 4, text: "워크넷 직업정보", url: "https://www.work.go.kr/" },
          { id: 5, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do" }
        ],
        "overviewProspect.main": [
          { id: 6, text: "한국고용정보원", url: "https://www.keis.or.kr/" },
          { id: 7, text: "식품의약품안전처", url: "https://www.mfds.go.kr/" }
        ],
        trivia: [
          { id: 8, text: "식품의약품안전처", url: "https://www.mfds.go.kr/" },
          { id: 9, text: "KT&G 기술정보", url: "https://www.ktng.com/" },
          { id: 10, text: "국립농산물품질관리원", url: "https://www.naqs.go.kr/" }
        ],
        "detailWlb.wlbDetail": [{ id: 11, text: "워크넷 직업정보", url: "https://www.work.go.kr/" }],
        "detailWlb.socialDetail": [{ id: 12, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do" }]
      }
    }
  },
  {
    id: '1765283430223155',
    name: '보험보상사무원',
    data: {
      way: "대학에서 법학, 경영학, 금융학 등을 전공하면 유리하다.[1] 손해보험사·생명보험사의 공채 또는 수시 채용을 통해 입사하며, 보험 심사·손해사정 업무를 담당하게 된다.[2] 손해사정사 자격을 취득하면 전문성을 크게 높일 수 있으며, 독립 손해사정사로 개업하는 것도 가능하다.[3]",
      overviewSalary: { sal: "평균 연봉은 약 3,500만~5,500만 원이며[1], 대형 보험사 손해사정 전문가는 6,000만 원 이상도 가능하다.[2]", source: "워크넷 직업정보, 커리어넷(2024)" },
      overviewProspect: { main: "보험 산업의 성장과 함께 손해보상 전문 인력 수요는 안정적이며[1], 자동차·의료 분야 보상 업무는 꾸준히 유지될 전망이다.[2]", source: "한국고용정보원(2024)" },
      trivia: "보험보상사무원은 보험 사기 적발 업무도 담당하며, 국내 보험 사기 적발 금액은 연간 1조 원을 넘어선다.[1] 손해사정사는 보험계약자와 보험사 사이에서 손해액을 객관적으로 산정하는 독립적 전문가이다.[2] AI 기술 도입으로 일부 보험사는 단순 보상 심사를 자동화하고 있어, 복잡 사건 처리 역량이 더욱 중요해지고 있다.[3]",
      detailWlb: { wlb: "보통", social: "높음", wlbDetail: "보험 보상 시즌(자연재해·교통사고 다발 시기)에는 업무가 집중되나, 평상시에는 비교적 규칙적인 근무가 가능하다.", socialDetail: "고객의 재정적 위기 상황에서 신속·공정한 보상을 제공하는 역할로 사회적 신뢰와 감사를 받는 직업이다." },
      detailReady: {
        curriculum: ["법학·경영·금융학 전공 선택", "보험 관련 법규 및 약관 학습", "자동차·의료 분야 손해 지식 습득"],
        recruit: ["손해보험사 보상팀 공채 지원", "생명보험사 보험금 심사팀 채용", "손해사정법인 입사"],
        training: ["손해사정사(1종·2종) 자격 취득", "보험계리사 준비", "의료관련 손해 실무 전문 교육"]
      },
      sidebarJobs: ["보험보유계약관리원", "보험인수심사원(언더라이터)", "신용추심원", "은행사무원", "증권사무원", "출납창구사무원"],
      sidebarMajors: ["금융·보험학과", "경영학과", "금융경영과", "법학과", "경영회계정보과"],
      sidebarCerts: ["손해사정사(1종·2종)", "보험계리사", "CFP(국제공인재무설계사)", "보험중개사", "생명보험대리점자격"],
      heroTags: ["보험보상사무원", "손해사정사", "보험사무원", "손해보험", "보험취업", "보상심사"],
      youtubeLinks: [],
      _sources: {
        way: [
          { id: 1, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do" },
          { id: 2, text: "워크넷 직업정보", url: "https://www.work.go.kr/" },
          { id: 3, text: "금융감독원", url: "https://www.fss.or.kr/" }
        ],
        "overviewSalary.sal": [
          { id: 4, text: "워크넷 직업정보", url: "https://www.work.go.kr/" },
          { id: 5, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do" }
        ],
        "overviewProspect.main": [
          { id: 6, text: "한국고용정보원", url: "https://www.keis.or.kr/" },
          { id: 7, text: "보험연구원", url: "https://www.kiri.or.kr/" }
        ],
        trivia: [
          { id: 8, text: "금융감독원 보험사기신고센터", url: "https://www.fss.or.kr/" },
          { id: 9, text: "한국손해사정사회", url: "https://www.kicaa.or.kr/" },
          { id: 10, text: "보험연구원", url: "https://www.kiri.or.kr/" }
        ],
        "detailWlb.wlbDetail": [{ id: 11, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do" }],
        "detailWlb.socialDetail": [{ id: 12, text: "워크넷 직업정보", url: "https://www.work.go.kr/" }]
      }
    }
  },
  {
    id: '1765283499348417',
    name: '건설배관공',
    data: {
      way: "직업훈련기관 또는 건설 현장 견습을 통해 배관 실무를 익히는 것이 기본 경로이다.[1] 배관기능사 자격을 취득하면 취업에 유리하며, 공업배관·가스 분야는 별도의 전문 자격이 필요할 수 있다.[2] 경력을 쌓아 배관기사나 현장 시공관리자로 성장하는 길도 열려 있다.[3]",
      overviewSalary: { sal: "일당 기준 15만~25만 원 수준이며[1], 연간 환산 시 3,500만~5,000만 원 내외이다.[2]", source: "워크넷 직업정보, 대한설비건설협회(2024)" },
      overviewProspect: { main: "건설·플랜트 산업 수요에 연동되며[1], 노후 배관 교체 및 친환경 에너지 인프라 확장으로 꾸준한 수요가 지속될 전망이다.[2]", source: "한국고용정보원(2024)" },
      trivia: "배관공은 물, 가스, 증기, 화학물질 등 다양한 유체를 다루며, 잘못된 배관 하나가 대형 사고로 이어질 수 있다.[1] 국내 최대 규모의 지역난방 배관망은 서울에만 약 800km 이상 매설되어 있다.[2] 고난도 공업용 배관공(피팅·용접 포함)은 해외 플랜트 현장에 파견되어 연간 수천만 원의 출장 수당을 받기도 한다.[3]",
      detailWlb: { wlb: "보통이하", social: "보통이하", wlbDetail: "건설 현장 특성상 이른 아침 출근과 날씨에 따른 야외 작업이 많다. 공사 마감 시기에는 야근과 휴일 근무가 빈번하게 발생한다.", socialDetail: "건물의 급수·배수·가스·소방 시스템을 구성하는 필수 기술직으로, 안전하고 쾌적한 생활환경을 만드는 데 직접 기여한다." },
      detailReady: {
        curriculum: ["배관 직업훈련원 과정 수료", "배관기능사 자격 시험 준비", "가스·용접 기초 기술 습득"],
        recruit: ["건설사 배관 하도급 업체 취업", "플랜트 전문 시공사 현장직 입사", "가스·수도 공사 전문 업체 채용 지원"],
        training: ["배관기사 자격 승급", "가스기능사·가스산업기사 취득", "고압가스 안전관리자 과정 이수"]
      },
      sidebarJobs: ["가스인입배관공", "건축배관공", "공업배관공", "광산배관공", "철도차량배관공", "항공기유압배관공"],
      sidebarMajors: ["건축·설비공학과", "건축설비과", "건설정보과", "건축공학과", "토목공학과"],
      sidebarCerts: ["배관기능사", "배관기사", "가스기능사", "가스산업기사", "고압가스관련기능사"],
      heroTags: ["건설배관공", "배관공", "배관기능사", "배관기사", "설비공", "건설취업"],
      youtubeLinks: [],
      _sources: {
        way: [
          { id: 1, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do" },
          { id: 2, text: "워크넷 직업정보", url: "https://www.work.go.kr/" },
          { id: 3, text: "대한설비건설협회", url: "https://www.kmcca.or.kr/" }
        ],
        "overviewSalary.sal": [
          { id: 4, text: "워크넷 직업정보", url: "https://www.work.go.kr/" },
          { id: 5, text: "대한설비건설협회", url: "https://www.kmcca.or.kr/" }
        ],
        "overviewProspect.main": [
          { id: 6, text: "한국고용정보원", url: "https://www.keis.or.kr/" },
          { id: 7, text: "워크넷 직업정보", url: "https://www.work.go.kr/" }
        ],
        trivia: [
          { id: 8, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do" },
          { id: 9, text: "한국지역난방공사", url: "https://www.kdhc.co.kr/" },
          { id: 10, text: "해외건설협회", url: "https://www.icak.or.kr/" }
        ],
        "detailWlb.wlbDetail": [{ id: 11, text: "워크넷 직업정보", url: "https://www.work.go.kr/" }],
        "detailWlb.socialDetail": [{ id: 12, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do" }]
      }
    }
  },
  {
    id: '1765283494451924',
    name: '전통건축기능원',
    data: {
      way: "전통건축기능원이 되려면 한국전통문화대학교 전통건축학과 등 전문 교육기관을 졸업하거나[1], 문화재청 인정 전통건축 기능 전수 교육을 이수해야 한다.[2] 도제식 전수를 통해 목공·석공·단청 등 특정 분야를 전문화하는 것이 일반적이며, 국가무형문화재 전수자 인정을 목표로 할 수도 있다.[3]",
      overviewSalary: { sal: "경력에 따라 연봉 3,000만~5,000만 원 수준이며[1], 문화재 전문 기능원으로 인정받으면 상당한 프리미엄이 붙는다.[2]", source: "워크넷 직업정보, 커리어넷(2024)" },
      overviewProspect: { main: "문화재 보수·복원 수요는 꾸준히 유지되며[1], 전통건축 기능 인력의 고령화로 신진 기능원에 대한 수요가 증가하고 있다.[2]", source: "문화재청, 한국고용정보원(2024)" },
      trivia: "한식 목구조는 못을 최소화하고 짜임(장부 맞춤)만으로 건물을 지어 수백 년을 견딘다.[1] 경복궁 광화문 복원(2010년)에는 약 300여 명의 전통건축 기능인이 참여해 3년간 수작업으로 완성했다.[2] 단청 안료는 금·은·주사·석청 등 천연 광물에서 추출하며, 각 안료의 제조 방식이 국가 기밀에 준하는 기술로 전수된다.[3]",
      detailWlb: { wlb: "보통이하", social: "보통", wlbDetail: "문화재 보수 현장은 야외 작업이 많고 기후에 영향을 받는다. 문화재 특성상 작업 기간이 길고 세밀한 집중력이 지속 요구된다.", socialDetail: "우리 민족의 건축 문화를 보존하는 소명감이 있으며, 완성된 문화재를 통해 수백 년 뒤에도 남는 작품을 만든다는 자부심이 있다." },
      detailReady: {
        curriculum: ["전통건축학과 입학 또는 문화재 전수교육 이수", "한식목구조·단청·석공 실습 과정 수강", "전통건축 관련 법규·기준 학습"],
        recruit: ["문화재 전문 건설사 기능원 채용", "문화재청 문화재 보수 용역 사업 참여", "국가무형문화재 전수교육관 소속"],
        training: ["목조건축산업기사·기사 취득", "전통건축기능사 자격 취득", "문화재수리기술자 자격 도전"]
      },
      sidebarJobs: ["건축목공", "건축석공", "경량철골공", "전통건축원", "조적원", "철골공", "철근공", "콘크리트공"],
      sidebarMajors: ["건축학과", "건축공학과", "건축과", "건설공학교육과", "건설정보과"],
      sidebarCerts: ["전통건축기능사", "목조건축산업기사", "문화재수리기술자", "단청기능사", "목공예기능사"],
      heroTags: ["전통건축기능원", "전통건축", "한옥", "문화재복원", "목수", "전통목공"],
      youtubeLinks: [],
      _sources: {
        way: [
          { id: 1, text: "한국전통문화대학교", url: "https://www.nuch.ac.kr/" },
          { id: 2, text: "문화재청", url: "https://www.cha.go.kr/" },
          { id: 3, text: "워크넷 직업정보", url: "https://www.work.go.kr/" }
        ],
        "overviewSalary.sal": [
          { id: 4, text: "워크넷 직업정보", url: "https://www.work.go.kr/" },
          { id: 5, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do" }
        ],
        "overviewProspect.main": [
          { id: 6, text: "문화재청", url: "https://www.cha.go.kr/" },
          { id: 7, text: "한국고용정보원", url: "https://www.keis.or.kr/" }
        ],
        trivia: [
          { id: 8, text: "문화재청 한옥기술개발사업단", url: "https://www.cha.go.kr/" },
          { id: 9, text: "문화재청 복원사업 백서", url: "https://www.cha.go.kr/" },
          { id: 10, text: "국립무형유산원", url: "https://www.nihc.go.kr/" }
        ],
        "detailWlb.wlbDetail": [{ id: 11, text: "워크넷 직업정보", url: "https://www.work.go.kr/" }],
        "detailWlb.socialDetail": [{ id: 12, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do" }]
      }
    }
  },
  {
    id: '1765283398495876',
    name: '항공기정비원',
    data: {
      way: "항공정비사가 되려면 항공정비 관련 학과를 졸업하거나 직업훈련기관에서 교육을 이수해야 한다.[1] 국토교통부 항공정비사 면장 취득이 필수이며, 대한항공·아시아나 등 항공사 공채에 응시하는 것이 주된 경로이다.[2] 군 항공 정비 특기병으로 복무한 뒤 전역하여 민간 항공사에 취업하는 방법도 있다.[3]",
      overviewSalary: { sal: "대형 항공사 항공기정비원의 평균 연봉은 약 5,000만~7,000만 원이며[1], 숙련된 면장 보유자는 8,000만 원 이상도 가능하다.[2]", source: "커리어넷 직업백과, 워크넷(2024)" },
      overviewProspect: { main: "항공 여객 수요 회복과 저비용 항공사(LCC) 확대로 항공기정비원 수요는 증가 추세이다.[1] 드론·UAM(도심항공교통) 등 신규 항공 모빌리티의 등장도 새로운 정비 인력 수요를 창출하고 있다.[2]", source: "국토교통부, 한국고용정보원(2024)" },
      trivia: "항공기 한 대를 유지하기 위해 연간 수천 시간의 정비 작업이 수행된다.[1] 항공기 정비 기록은 단 하나라도 누락되면 운항 금지 조치가 내려질 만큼 기록 관리가 엄격하다.[2] 보잉747 항공기의 부품 수는 약 600만 개에 달하며, 정비원은 모든 시스템에 정통해야 한다.[3]",
      detailWlb: { wlb: "보통이하", social: "보통", wlbDetail: "항공기 운항 스케줄에 맞춰 야간·새벽·휴일 근무가 빈번하다. 정밀 작업의 연속으로 집중력 유지에 따른 정신적 피로가 크다.", socialDetail: "수백 명의 안전을 책임지는 항공 안전의 최전선에서 일하며, 항공기 안전 운항에 기여한다는 자부심이 매우 높다." },
      detailReady: {
        curriculum: ["항공정비학과 또는 항공우주공학과 진학", "항공기관·기체·전자계통 이론 학습", "항공사 연계 인턴·실습 과정 이수"],
        recruit: ["대형 항공사(대한항공·아시아나·에어부산 등) 공채", "저비용항공사(LCC) 수시 채용", "MRO(항공정비전문업체) 입사"],
        training: ["항공정비사 면장 취득(국토교통부)", "항공기체·기관·전자기기 자격증 취득", "드론 정비 관련 자격 취득"]
      },
      sidebarJobs: ["선박정비원", "오토바이정비원", "자동차정비원", "자전거판매 및 정비원", "철도기관차·전동차정비원"],
      sidebarMajors: ["항공정비과", "항공우주공학과", "항공학과", "기계공학과", "기계과"],
      sidebarCerts: ["항공정비사면장", "항공산업기사", "항공기체기능사", "항공기관기능사", "드론정비기능사"],
      heroTags: ["항공기정비원", "항공정비사", "항공기면장", "항공사취업", "정비사", "항공정비학과"],
      youtubeLinks: [],
      _sources: {
        way: [
          { id: 1, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do" },
          { id: 2, text: "국토교통부 항공정책실", url: "https://www.molit.go.kr/" },
          { id: 3, text: "워크넷 직업정보", url: "https://www.work.go.kr/" }
        ],
        "overviewSalary.sal": [
          { id: 4, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do" },
          { id: 5, text: "워크넷 직업정보", url: "https://www.work.go.kr/" }
        ],
        "overviewProspect.main": [
          { id: 6, text: "국토교통부", url: "https://www.molit.go.kr/" },
          { id: 7, text: "한국고용정보원", url: "https://www.keis.or.kr/" }
        ],
        trivia: [
          { id: 8, text: "한국항공우주산업진흥협회", url: "https://www.aerospace.or.kr/" },
          { id: 9, text: "국토교통부 항공안전", url: "https://www.molit.go.kr/" },
          { id: 10, text: "Boeing Technical Overview", url: "https://www.boeing.com/" }
        ],
        "detailWlb.wlbDetail": [{ id: 11, text: "워크넷 직업정보", url: "https://www.work.go.kr/" }],
        "detailWlb.socialDetail": [{ id: 12, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do" }]
      }
    }
  },
  {
    id: '1765283412658784',
    name: '건설·채굴관리자',
    data: {
      way: "건설 또는 토목 관련 학과를 졸업하고 현장 경력을 충분히 쌓아야 한다.[1] 건설기사 및 건설관리 관련 자격 취득 후 현장소장이나 공사관리자로 승진하는 것이 일반적인 경로이다.[2] 광업·채굴 분야는 화약류관리기사 등 특수 자격을 갖추어야 관리직에 진입할 수 있다.[3]",
      overviewSalary: { sal: "평균 연봉은 약 5,000만~8,000만 원이며[1], 대형 건설사 현장소장은 1억 원 이상도 가능하다.[2]", source: "워크넷 직업정보, 커리어넷(2024)" },
      overviewProspect: { main: "건설 경기에 직접적으로 영향을 받으나[1], 사회 인프라 유지·보수 수요가 지속적으로 있어 전문 관리자 수요는 안정적이다.[2]", source: "한국고용정보원(2024)" },
      trivia: "건설·채굴관리자는 수백 명의 현장 인력을 통솔하며 공기·원가·품질·안전 4대 관리를 동시에 수행한다.[1] 채굴 현장에서는 발파 계획 수립부터 안전 점검까지 모두 관리자 책임 하에 진행된다.[2] 해외 건설 현장에 파견된 한국인 건설관리자는 전 세계 120개국 이상에서 활동 중이다.[3]",
      detailWlb: { wlb: "보통이하", social: "보통", wlbDetail: "공사 마감 기한에 맞춰 야근과 휴일 근무가 빈번하며, 현장 순회와 다양한 이해관계자 관리로 신체·정신 피로도가 높다.", socialDetail: "도로·건물·인프라를 완성해 도시와 지역사회를 만든다는 자부심이 크며, 완성된 건축물이 수십 년간 사용된다는 성취감이 있다." },
      detailReady: {
        curriculum: ["토목·건축·건설관리학과 전공 선택", "건설현장 인턴·실습 경험 축적", "건설관련 법규 및 안전 기준 학습"],
        recruit: ["대형 건설사 현장관리직 공채 응시", "전문 건설사 경력직 관리자 채용", "공기업(LH·한국도로공사 등) 입사"],
        training: ["토목시공기술사 자격 도전", "건설안전기사 취득", "건설기술인 역량강화 교육 이수"]
      },
      sidebarJobs: ["건설·광업기계설치·정비원", "건설·채굴단순종사원", "전기·가스·수도관리자", "제조·생산관리자"],
      sidebarMajors: ["건축공학과", "토목공학과", "건설공학교육과", "도시건설과", "건설정보과"],
      sidebarCerts: ["건설기사", "토목기사", "건축기사", "건설관리기사", "화약류관리기사"],
      heroTags: ["건설채굴관리자", "현장소장", "건설관리자", "채굴관리", "건설기사", "토목기사"],
      youtubeLinks: [],
      _sources: {
        way: [
          { id: 1, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do" },
          { id: 2, text: "워크넷 직업정보", url: "https://www.work.go.kr/" },
          { id: 3, text: "대한건설협회", url: "https://www.cak.or.kr/" }
        ],
        "overviewSalary.sal": [
          { id: 4, text: "워크넷 직업정보", url: "https://www.work.go.kr/" },
          { id: 5, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do" }
        ],
        "overviewProspect.main": [
          { id: 6, text: "한국고용정보원", url: "https://www.keis.or.kr/" },
          { id: 7, text: "워크넷 직업정보", url: "https://www.work.go.kr/" }
        ],
        trivia: [
          { id: 8, text: "대한건설협회", url: "https://www.cak.or.kr/" },
          { id: 9, text: "화약류 안전관리법령", url: "https://www.law.go.kr/" },
          { id: 10, text: "해외건설협회", url: "https://www.icak.or.kr/" }
        ],
        "detailWlb.wlbDetail": [{ id: 11, text: "워크넷 직업정보", url: "https://www.work.go.kr/" }],
        "detailWlb.socialDetail": [{ id: 12, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do" }]
      }
    }
  }
];

function escapeSql(str) {
  return str.replace(/'/g, "''");
}

let sql = '';
for (const job of jobs) {
  const jsonStr = JSON.stringify(job.data);
  sql += `UPDATE jobs SET user_contributed_json = '${escapeSql(jsonStr)}' WHERE id = '${job.id}';\n`;
}

writeFileSync('./scripts/batch6.sql', sql, 'utf-8');
console.log('SQL generated:', jobs.length, 'jobs');
jobs.forEach(j => console.log(`  ${j.name}: ${JSON.stringify(j.data).length} bytes`));

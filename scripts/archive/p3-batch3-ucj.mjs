// P3 Batch 3: 10개 직업 UCJ 생성 스크립트
// 대상: 인적자원전문가, 비서, 세탁기계조작원, 웹엔지니어, 제조·생산관리자,
//       조사전문가, 선박조립원, 조세행정사무원, 여행사무원, 주입·포장·상표부착기계조작원

import { writeFileSync } from 'fs';

const jobs = [
  {
    id: '1765283413781188',
    name: '인적자원전문가',
    ucj: {
      way: "인적자원전문가(HR전문가)가 되려면 경영학, 인사관리학, 산업심리학, 사회학 등 관련 전공을 졸업하거나 인사·노무 관련 경력을 쌓는 것이 일반적이다.[1] 대기업·중견기업의 인사팀 신입 공채로 입사하거나, 공인노무사(CLA) 자격증을 취득하여 노무법인·인사컨설팅 회사에 취업하는 경로도 있다.[2] 글로벌 기업에서는 SHRM-CP, SPHR 등 국제 HR 인증 보유자를 우대하며, 직무분석·채용·교육훈련·평가·보상·노사관계 등 특정 분야를 전문화하는 방향이 점점 중요해지고 있다.[1] 헤드헌팅 회사나 채용 플랫폼(잡코리아, 원티드) 등에서 리크루터로 커리어를 시작하는 경로도 있다.[2]",
      overviewSalary: {
        sal: "연봉 중위값은 약 4,000만 원이다.[1] 대기업 인사팀 과장급은 6,000만 원 이상이며, HR 컨설팅 파트너는 억대 연봉도 가능하다.[2] 공인노무사 자격 보유 시 노무법인에서 4,500만~6,000만 원대를 받는다.[1]",
        source: "워크넷, 커리어넷 직업백과(2024)"
      },
      overviewProspect: {
        main: "향후 5년간 고용은 보통이상 수준을 유지할 것으로 전망된다.[1] AI·빅데이터 기반 HR 테크(채용 자동화, 성과 분석 시스템)의 도입으로 단순 업무는 줄지만, 전략적 인재 관리와 조직문화 설계 역할의 수요는 오히려 증가하고 있다.[2] ESG 경영 확산과 다양성·포용성(D&I) 이슈로 HR 전문성에 대한 조직의 요구가 높아지는 추세다.[1]",
        source: "커리어넷 직업백과, 한국HR협회(2024)"
      },
      trivia: "HR이라는 용어는 1960년대 미국에서 '직원'을 단순 노동력이 아닌 '인적 자원'으로 바라보는 시각의 전환에서 탄생했다.[1] 구글은 채용 과정에서 구조화 면접(structured interview)을 도입하여 면접관의 주관적 편견을 최소화하는 HR 혁신으로 유명하다.[2] 넷플릭스는 '자유와 책임(Freedom & Responsibility)' 문화를 HR 철학의 핵심으로 삼아, 휴가 일수를 없애고 성과로만 평가하는 방식을 채택했다.[3] 한국에서는 1997년 IMF 외환위기 이후 연공서열 중심의 인사 제도가 성과주의 제도로 급격히 전환되면서 HR 전문가 수요가 크게 늘었다.[1]",
      detailWlb: {
        wlb: "보통이상",
        social: "보통이상",
        wlbDetail: "공채 시즌(상·하반기)이나 조직 개편 시기에는 야근이 집중되지만, 평상시에는 일반 사무직 대비 워라밸이 양호한 편이다. HR 부서는 임직원의 복지를 직접 설계하는 만큼 자신이 만든 제도의 혜택도 누리는 경향이 있다.",
        socialDetail: "조직 구성원의 채용, 교육, 성장, 보상, 퇴직까지 전 생애주기를 관리하는 역할로 사내 신뢰도가 높다. 노사 분쟁 예방, 조직문화 개선 등을 통해 사회 전반의 노동 환경 개선에도 기여한다."
      },
      detailReady: {
        curriculum: [
          "경영학과, 인사관리학과, 산업심리학과 등 관련 전공 입학",
          "공인노무사(CLA) 자격시험 준비: 노동법, 민법, 사회보험법 등",
          "HR 관련 인턴십: 대기업 인사팀, 리쿠르팅 에이전시, 헤드헌팅 회사",
          "Excel·HRIS 시스템(SAP HR, 더존) 활용 능력 및 인사 분석(People Analytics) 기초 학습"
        ],
        recruit: [
          "대기업·중견기업 인사팀 신입 공채",
          "공인노무사 자격 취득 후 노무법인 취업",
          "채용 대행 전문 기업(에이치알피플, 커리어케어 등) 취업",
          "HR 테크 스타트업 또는 HRD 컨설팅 회사 취업"
        ],
        training: [
          "공인노무사 자격 취득 후 전문 노무법인 개업",
          "SHRM-CP(Society for Human Resource Management) 국제 자격 취득",
          "CHO(최고인사책임자) 또는 HR 이사로 관리직 성장",
          "HR 컨설팅 회사 파트너급으로 독립 컨설팅"
        ]
      },
      sidebarJobs: ["노무사", "헤드헌터", "직업상담사", "경영컨설턴트", "비서"],
      sidebarMajors: ["경영학과", "심리학과", "사회학과", "행정학과", "법학과"],
      sidebarCerts: ["공인노무사", "SHRM-CP", "직업상담사", "사회조사분석사", "HRD전문가"],
      heroTags: ["HR전문가", "인사관리", "채용전문가", "HRD", "공인노무사"],
      youtubeLinks: [],
      _sources: {
        way: [
          { id: 1, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=220" },
          { id: 2, text: "워크넷 직업정보", url: "https://www.work.go.kr/empinfo/occInfoSrch/occInfoMain.do" }
        ],
        "overviewSalary.sal": [
          { id: 1, text: "워크넷 직업정보", url: "https://www.work.go.kr/empinfo/occInfoSrch/occInfoMain.do" },
          { id: 2, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=220" }
        ],
        "overviewProspect.main": [
          { id: 1, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=220" },
          { id: 2, text: "한국HR협회", url: "https://www.koreahra.or.kr/" }
        ],
        trivia: [
          { id: 1, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=220" },
          { id: 2, text: "구글 리크루팅 방법론", url: "https://rework.withgoogle.com/" },
          { id: 3, text: "넷플릭스 컬처덱", url: "https://jobs.netflix.com/culture" }
        ],
        "detailWlb.wlbDetail": [
          { id: 1, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=220" }
        ],
        "detailWlb.socialDetail": [
          { id: 1, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=220" }
        ]
      }
    }
  },
  {
    id: '1765283425058548',
    name: '비서',
    ucj: {
      way: "비서가 되려면 비서학과, 비서행정학과, 경영학과 등을 졸업하거나 비서 전문 교육기관에서 교육을 이수하는 것이 유리하다.[1] 한국비서협회 시행 비서 1급·2급 자격증을 취득하면 취업에 도움이 되며, 외국어(영어·중국어·일본어 등) 능력이 특히 중요하다.[2] 대기업·외국계 기업의 경우 공채나 수시 채용을 통해 임원 비서로 입사하며, 중소기업은 총무팀 겸직 형태로 비서 업무를 담당하는 경우가 많다.[1] 초기에는 일반 비서로 시작하여 경력이 쌓이면 사장 비서실, 또는 경영 지원팀 관리직으로 성장하는 경로도 있다.[2]",
      overviewSalary: {
        sal: "연봉 중위값은 약 3,200만 원이다.[1] 대기업 CEO 비서는 4,500만~6,000만 원, 외국계 기업 임원 비서는 5,000만 원 이상도 가능하다.[2] 외국어 능통자와 경력 5년 이상의 경우 연봉 협상력이 높다.[1]",
        source: "워크넷, 한국비서협회(2024)"
      },
      overviewProspect: {
        main: "향후 5년간 고용은 다소 감소할 것으로 전망된다.[1] AI 비서 프로그램(ChatGPT, Copilot 등)의 발전으로 일정 관리·문서 작성 등 단순 업무 자동화가 진행되고 있다.[2] 그러나 고위 임원 비서의 경우 기밀 관리, 대인 관계, 위기 대응 등 인적 역량이 필수여서 완전 대체는 어렵다는 평가다.[1]",
        source: "커리어넷 직업백과(2024)"
      },
      trivia: "비서(秘書)라는 한자어는 '비밀 문서를 관리하는 사람'이라는 뜻으로, 고대 중국 황실에서 기원했다.[1] 미국에서 가장 유명한 비서 중 한 명은 조지 C. 마샬의 비서였던 에블린 우드로, 그는 주요 외교 문서의 기밀을 40년 이상 지켜냈다.[2] 영어 'Secretary'는 라틴어 'secretarius(비밀을 아는 자)'에서 유래했으며, 현재도 장관(Secretary of State)이나 총무(General Secretary)처럼 고위 직책에 쓰인다.[3] 일부 임원 비서는 보스의 건강 관리·식사 주문·자녀 스케줄까지 통합 관리하는 '퍼스널 어시스턴트(PA)' 역할을 겸한다.[1]",
      detailWlb: {
        wlb: "보통이하",
        social: "보통",
        wlbDetail: "임원의 일정에 맞춰 출퇴근 시간이 결정되므로 본인의 퇴근 시간을 스스로 정할 수 없는 경우가 많다. 해외 출장 동행, 야간·주말 긴급 요청 대응 등으로 개인 시간 확보가 어렵다. 특히 대기업 CEO 비서는 24시간 언제든 연락에 응해야 하는 상시 대기 상태에 가깝다.",
        socialDetail: "조직의 핵심 의사결정자를 지원하여 비즈니스 흐름의 润滑油(윤활유) 역할을 한다. 기밀 유지, 신뢰 관계, 전문 서비스 제공으로 조직 운영에 없어서는 안 될 존재지만 표면적으로 드러나지 않는 직업이다."
      },
      detailReady: {
        curriculum: [
          "비서학과, 비서행정학과, 경영학과 등 관련 전공 입학",
          "비서 자격증(1급·2급) 준비: 한국비서협회 시행",
          "영어·중국어·일본어 등 외국어 능력 강화 (TOEIC 800점 이상 권장)",
          "비즈니스 매너, 프로토콜, 프레젠테이션 스킬 교육 이수"
        ],
        recruit: [
          "대기업·공기업 임원 비서 공채 및 수시 채용",
          "외국계 기업 Executive Assistant 채용",
          "헤드헌팅 회사 통한 비서 경력직 이직",
          "중소기업 경영지원팀·총무팀 비서 겸직 채용"
        ],
        training: [
          "CEO 비서실장 또는 경영지원팀 팀장으로 관리직 성장",
          "이벤트 플래너, 프로토콜 전문가로 전문화",
          "기업 커뮤니케이션팀 또는 대외협력팀 이동",
          "독립 프리랜서 PA(Personal Assistant)로 고소득 전문직 전환"
        ]
      },
      sidebarJobs: ["인적자원전문가", "경영컨설턴트", "헤드헌터", "여행사무원", "조세행정사무원"],
      sidebarMajors: ["비서학과", "비서행정학과", "경영학과", "행정학과"],
      sidebarCerts: ["비서1급", "비서2급", "TOEIC 800+", "컴퓨터활용능력", "MOS(Office 자격)"],
      heroTags: ["비서", "임원비서", "경영지원", "PA", "비서자격증"],
      youtubeLinks: [],
      _sources: {
        way: [
          { id: 1, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=185" },
          { id: 2, text: "한국비서협회", url: "https://www.ksa.or.kr/" }
        ],
        "overviewSalary.sal": [
          { id: 1, text: "워크넷 직업정보", url: "https://www.work.go.kr/empinfo/occInfoSrch/occInfoMain.do" },
          { id: 2, text: "한국비서협회", url: "https://www.ksa.or.kr/" }
        ],
        "overviewProspect.main": [
          { id: 1, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=185" },
          { id: 2, text: "고용노동부 직업전망", url: "https://www.moel.go.kr/" }
        ],
        trivia: [
          { id: 1, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=185" },
          { id: 2, text: "세계비서연맹(IAAP)", url: "https://www.iaap-hq.org/" },
          { id: 3, text: "어원사전(Etymology Online)", url: "https://www.etymonline.com/word/secretary" }
        ],
        "detailWlb.wlbDetail": [
          { id: 1, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=185" }
        ],
        "detailWlb.socialDetail": [
          { id: 1, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=185" }
        ]
      }
    }
  },
  {
    id: '1765283521992759',
    name: '세탁기계조작원',
    ucj: {
      way: "세탁기계조작원이 되기 위해 별도의 자격증이나 학력 요건은 없다.[1] 세탁 공장, 대형 세탁업체, 호텔 세탁실, 병원 린넨실 등에서 채용 공고를 통해 취업하며, 현장에서 장비 조작법과 세탁 프로세스를 익히는 방식으로 시작한다.[2] 세탁기사 자격증(환경부)을 취득하면 세탁소 창업이나 고급 세탁 업체 취업에 유리하며, 섬유 소재에 대한 지식이 중요하다.[1] 대형 세탁 업체의 경우 세탁기 정비, 공정 관리, 품질 검사 등 분야로 특화되며 경력에 따라 팀장급으로 성장할 수 있다.[2]",
      overviewSalary: {
        sal: "연봉 중위값은 약 2,600만 원이다.[1] 호텔·병원 등 대형 사업장의 정규직은 3,000만 원 이상이며, 세탁기사 자격 보유 시 임금이 높아진다.[2] 영세 세탁소의 경우 최저임금 수준인 경우도 있다.[1]",
        source: "워크넷, 커리어넷 직업백과(2024)"
      },
      overviewProspect: {
        main: "향후 5년간 고용은 현 수준을 유지하거나 소폭 감소할 것으로 전망된다.[1] 자동화 장비 도입으로 일부 단순 조작 업무가 줄어들고 있으나, 호텔·병원·리조트 등 대형 시설의 세탁 수요는 안정적으로 유지된다.[2] 특수 의류(웨딩드레스·고급 정장) 전문 세탁의 경우 고급 기술이 필요하여 기술 인력 수요가 지속된다.[1]",
        source: "커리어넷 직업백과(2024)"
      },
      trivia: "세탁기가 보급되기 전 19세기 유럽에서는 세탁이 여성 노동자의 가장 힘든 직업 중 하나였다. 빨래판으로 하루 종일 손빨래를 하면 손이 피부가 벗겨질 정도였다.[1] 드라이클리닝(dry cleaning)은 사실 물 없이 하는 것이 아니라 석유계 용제(퍼클로로에틸렌 등)로 세탁하는 방식이다.[2] 최고급 호텔의 린넨(침대보·타월) 세탁비는 객실당 하루 수천 원에 달하며, 이를 위한 산업용 세탁기계의 가격은 한 대에 수천만 원을 넘는다.[3] 일부 특수 직물(캐시미어·실크 등)은 잘못 세탁하면 수십만 원의 의류가 손상되므로, 전문 세탁기계조작원의 섬유 지식이 매우 중요하다.[1]",
      detailWlb: {
        wlb: "보통이하",
        social: "보통이하",
        wlbDetail: "세탁 공장은 이른 새벽부터 가동되어 오전 시간대에 업무가 집중된다. 열과 습도가 높은 환경에서 작업하며 체력 소모가 크다. 화학 용제(드라이클리닝 약품) 노출로 직업병 위험이 있다.",
        socialDetail: "시민의 위생과 의류 관리를 직접 지원하는 직업으로 필요성은 높으나 사회적 인지도가 낮다. 호텔·병원의 감염 관리에 있어 린넨 세탁은 공중보건과 직결되는 중요한 역할이다."
      },
      detailReady: {
        curriculum: [
          "별도 학력·자격 요건 없음; 섬유 소재 기초 지식 선행 학습 권장",
          "세탁기사 자격증 준비 (한국세탁업중앙회 주관)",
          "산업용 세탁기계 조작법 현장 교육",
          "세탁 약품(계면활성제, 드라이클리닝 용제) 취급 안전 교육"
        ],
        recruit: [
          "대형 세탁 전문 업체(크린토피아, 화이트크리닝 등) 채용",
          "호텔·리조트 세탁실(Laundry) 채용",
          "병원 린넨실 세탁 담당 채용",
          "워크넷, 알바천국 등 구인 플랫폼"
        ],
        training: [
          "세탁기사 → 세탁기능사 자격 취득",
          "세탁 공장 팀장·현장 관리자로 승진",
          "세탁소 창업(프랜차이즈 또는 독립 세탁소)",
          "특수 세탁(웨딩드레스·명품 의류·가죽) 전문 기술 습득"
        ]
      },
      sidebarJobs: ["세탁원", "의복수선원", "한복제조원", "양장·양복제조원"],
      sidebarMajors: ["섬유공학과", "패션디자인학과", "환경공학과"],
      sidebarCerts: ["세탁기사", "세탁기능사", "위험물안전관리사", "산업위생관리기사"],
      heroTags: ["세탁기계", "세탁기사", "드라이클리닝", "린넨관리", "세탁공장"],
      youtubeLinks: [],
      _sources: {
        way: [
          { id: 1, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=460" },
          { id: 2, text: "워크넷 직업정보", url: "https://www.work.go.kr/empinfo/occInfoSrch/occInfoMain.do" }
        ],
        "overviewSalary.sal": [
          { id: 1, text: "워크넷 직업정보", url: "https://www.work.go.kr/empinfo/occInfoSrch/occInfoMain.do" },
          { id: 2, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=460" }
        ],
        "overviewProspect.main": [
          { id: 1, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=460" },
          { id: 2, text: "고용노동부 직업전망", url: "https://www.moel.go.kr/" }
        ],
        trivia: [
          { id: 1, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=460" },
          { id: 2, text: "한국세탁업중앙회", url: "https://www.kcleaners.or.kr/" },
          { id: 3, text: "호텔 린넨 관리 가이드라인", url: "https://www.work.go.kr/" }
        ],
        "detailWlb.wlbDetail": [
          { id: 1, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=460" }
        ],
        "detailWlb.socialDetail": [
          { id: 1, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=460" }
        ]
      }
    }
  },
  {
    id: '1765283716761455',
    name: '웹엔지니어',
    ucj: {
      way: "웹엔지니어가 되려면 컴퓨터공학, 소프트웨어학, 정보통신공학 등 관련 전공을 졸업하거나, 부트캠프·독학을 통해 프로그래밍 역량을 쌓는 것이 일반적이다.[1] HTML/CSS/JavaScript(프론트엔드)와 Node.js·Python·Java 등(백엔드) 기술 스택을 익힌 후 포트폴리오를 구축하고 취업한다.[2] GitHub에 개인 프로젝트를 공개하거나, 해커톤·오픈소스 기여 경험이 취업에 중요하게 작용한다.[1] 네카라쿠배(네이버·카카오·라인·쿠팡·배달의민족) 등 IT 대기업은 코딩 테스트와 기술 면접을 통해 채용한다.[2]",
      overviewSalary: {
        sal: "연봉 중위값은 약 4,500만 원이다.[1] 네이버·카카오 등 주요 IT 기업의 신입은 4,000만~5,000만 원대이며, 경력 5년 이상 시니어 엔지니어는 8,000만 원~1억 원 이상도 가능하다.[2] 글로벌 기업(구글, 메타)의 국내 엔지니어는 억대 보상을 받는 경우도 있다.[1]",
        source: "워크넷, 원티드 인사이트(2024)"
      },
      overviewProspect: {
        main: "향후 5년간 고용은 높은 성장세를 유지할 것으로 전망된다.[1] 디지털 전환(DX), AI 서비스 급성장, 전자상거래 확대 등으로 웹 개발 수요가 지속적으로 증가하고 있다.[2] AI 코딩 보조 도구(GitHub Copilot 등) 등장으로 단순 반복 코딩은 자동화되지만, 아키텍처 설계와 AI 통합 역량을 가진 엔지니어 수요는 오히려 증가 추세다.[1]",
        source: "커리어넷 직업백과, 정보통신산업진흥원(2024)"
      },
      trivia: "월드와이드웹(WWW)은 1989년 팀 버너스-리(Tim Berners-Lee)가 CERN 연구소에서 제안한 논문 한 장에서 시작됐으며, 그는 특허를 내지 않고 무료로 공개했다.[1] 전 세계 웹사이트 수는 2024년 기준 약 20억 개이며, 이 중 활성 운영 중인 사이트는 약 2억 개다.[2] 한국의 카카오페이, 토스 등 핀테크 스타트업은 웹엔지니어 한 명이 수십억 원의 기업가치를 만들어내는 레버리지 효과를 입증했다.[3] JavaScript는 1995년 단 10일 만에 만들어진 언어임에도, 2024년 현재 세계에서 가장 많이 사용되는 프로그래밍 언어 1위다.[1]",
      detailWlb: {
        wlb: "보통이상",
        social: "높음",
        wlbDetail: "스타트업의 경우 출시 전후 집중 근무가 발생하지만, 대기업 IT 회사는 재택근무·유연근무 제도가 잘 갖춰져 있다. 전반적으로 IT 직군은 다른 직군 대비 워라밸이 양호한 편이며, 자유로운 근무 문화를 가진 기업이 많다.",
        socialDetail: "전자상거래, 금융, 교육, 의료 등 모든 산업의 디지털화를 뒷받침하는 핵심 직업이다. 개인 개발자 한 명의 앱이 수백만 명의 삶을 변화시키는 임팩트를 만들 수 있어 사회적 기여도가 매우 높다."
      },
      detailReady: {
        curriculum: [
          "컴퓨터공학과, 소프트웨어학과, 정보통신공학과 입학 또는 부트캠프 수강",
          "프론트엔드: HTML/CSS/JavaScript → React/Vue.js 학습",
          "백엔드: Node.js/Python(Django·FastAPI)/Java(Spring) 중 선택 심화",
          "GitHub 포트폴리오 구축: 개인 프로젝트 3개 이상 공개"
        ],
        recruit: [
          "네카라쿠배(네이버·카카오·라인·쿠팡·배민) 코딩테스트·기술 면접",
          "스타트업 채용(원티드, 로켓펀치 플랫폼 활용)",
          "공공기관·SI 기업 웹 개발 인력 채용",
          "해외 원격 근무(Remote) 포지션 지원"
        ],
        training: [
          "시니어 엔지니어 → 테크 리드 → CTO 성장 경로",
          "풀스택 개발자로 확장 후 기술 창업",
          "클라우드 아키텍처(AWS·GCP·Azure) 전문가로 전문화",
          "AI/ML 엔지니어 전환: Python·PyTorch·TensorFlow 학습"
        ]
      },
      sidebarJobs: ["웹개발자", "웹디자이너", "IT컨설턴트", "정보시스템운영자", "데이터베이스관리자"],
      sidebarMajors: ["컴퓨터공학과", "전자공학과", "전기공학과", "산업공학과"],
      sidebarCerts: ["정보처리기사", "AWS Solutions Architect", "컴퓨터활용능력", "SQLD", "리눅스마스터"],
      heroTags: ["웹엔지니어", "웹개발자", "프론트엔드", "백엔드", "풀스택", "React"],
      youtubeLinks: [],
      _sources: {
        way: [
          { id: 1, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=320" },
          { id: 2, text: "원티드 인사이트", url: "https://www.wanted.co.kr/salary" }
        ],
        "overviewSalary.sal": [
          { id: 1, text: "워크넷 직업정보", url: "https://www.work.go.kr/empinfo/occInfoSrch/occInfoMain.do" },
          { id: 2, text: "원티드 인사이트", url: "https://www.wanted.co.kr/salary" }
        ],
        "overviewProspect.main": [
          { id: 1, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=320" },
          { id: 2, text: "정보통신산업진흥원", url: "https://www.nipa.kr/" }
        ],
        trivia: [
          { id: 1, text: "W3C(월드와이드웹컨소시엄)", url: "https://www.w3.org/" },
          { id: 2, text: "인터넷 통계(Netcraft)", url: "https://www.netcraft.com/" },
          { id: 3, text: "한국핀테크산업협회", url: "https://www.fintech.or.kr/" }
        ],
        "detailWlb.wlbDetail": [
          { id: 1, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=320" }
        ],
        "detailWlb.socialDetail": [
          { id: 1, text: "정보통신산업진흥원", url: "https://www.nipa.kr/" }
        ]
      }
    }
  },
  {
    id: '1765283413242494',
    name: '제조·생산관리자',
    ucj: {
      way: "제조·생산관리자가 되려면 기계공학, 산업공학, 전자공학 등 관련 공학계열을 졸업한 후 현장 엔지니어로 경력을 쌓아 관리직으로 성장하는 것이 일반적인 경로다.[1] 생산 현장에서 공정 관리·품질 관리·설비 관리 등을 담당하다가 팀장, 과장 이상의 관리직으로 승진한다.[2] 산업안전기사, 품질경영기사, 생산관리 관련 자격증이 취업 및 승진에 유리하며, 6시그마(Green Belt·Black Belt) 자격도 도움이 된다.[1] MBA(경영학 석사) 취득 후 생산관리 전문 컨설턴트로 전직하는 경로도 있다.[2]",
      overviewSalary: {
        sal: "연봉 중위값은 약 5,200만 원이다.[1] 대기업 생산부서 부장급은 7,000만~9,000만 원이며, 외국계 제조기업 플랜트 매니저는 1억 원 이상도 가능하다.[2] 중소·중견 제조업체는 3,500만~5,000만 원 수준이다.[1]",
        source: "워크넷, 커리어넷 직업백과(2024)"
      },
      overviewProspect: {
        main: "향후 5년간 고용은 보통 수준을 유지할 것으로 전망된다.[1] 스마트팩토리(Smart Factory) 전환이 가속화되면서 IoT·빅데이터·AI를 활용한 생산 관리 역량을 가진 전문가 수요가 증가하고 있다.[2] 전통 제조업의 자동화로 단순 공정 인력이 감소하는 반면, 이를 총괄 관리하는 관리자 수요는 안정적으로 유지된다.[1]",
        source: "커리어넷 직업백과, 산업통상자원부(2024)"
      },
      trivia: "도요타 생산방식(TPS·Toyota Production System)은 '저스트인타임(JIT)'과 '자동화(Jidoka)' 두 원칙을 기반으로 제조업 혁신을 이끌었다.[1] 삼성전자 반도체 공장(팹·FAB)은 24시간 365일 가동되며, 생산관리자 한 명이 수조 원의 설비와 수백 명의 작업자를 총괄 관리한다.[2] 6시그마(Six Sigma)는 모토로라가 개발하고 GE가 대중화한 품질 개선 방법론으로, 백만 개 제품 중 불량을 3.4개 이하로 줄이는 것을 목표로 한다.[3] 한국 제조업의 스마트팩토리 보급률은 2023년 기준 중소기업의 약 30%에 달하며, 정부가 적극 지원 중이다.[1]",
      detailWlb: {
        wlb: "보통이하",
        social: "보통이상",
        wlbDetail: "생산 라인이 24시간 가동되는 공장의 경우 교대근무 관리, 긴급 생산 이슈 대응 등으로 야근과 주말 출근이 잦다. 생산 목표 달성 압박과 품질 이슈 책임으로 지속적인 스트레스가 있다. 공장이 지방에 위치한 경우 가족과의 분리 생활이 필요한 경우도 있다.",
        socialDetail: "국가 제조업 경쟁력의 핵심 역할을 담당한다. 한국 경제를 지탱하는 반도체·자동차·철강·조선 등 주력 산업의 생산 체계를 운영하며, 국민 경제와 직결된 중요한 직업이다."
      },
      detailReady: {
        curriculum: [
          "기계공학과, 산업공학과, 전자공학과 등 공학계열 입학",
          "품질경영기사, 산업안전기사, 생산자동화기사 자격 취득",
          "6시그마 Green Belt(GB) 과정 이수",
          "ERP(SAP, Oracle) 시스템 활용 능력 습득"
        ],
        recruit: [
          "대기업(삼성·현대·LG·SK) 생산관리직 공채",
          "중견·중소 제조업체 현장 엔지니어 입사 후 내부 승진",
          "스마트팩토리 전문 기업 공정 관리 인력 채용",
          "제조업 특화 헤드헌팅을 통한 관리자급 이직"
        ],
        training: [
          "6시그마 Black Belt(BB) 취득 및 품질 컨설턴트로 전문화",
          "MBA 취득 후 생산관리 컨설팅 회사로 전직",
          "스마트팩토리 전문가 과정 이수 (IoT·AI 생산 관리)",
          "공장장(Plant Manager) → COO(최고운영책임자)로 성장"
        ]
      },
      sidebarJobs: ["품질관리사무원", "조사전문가", "IT컨설턴트", "인적자원전문가", "경영컨설턴트"],
      sidebarMajors: ["기계공학과", "산업공학과", "전자공학과", "경영학과"],
      sidebarCerts: ["품질경영기사", "산업안전기사", "생산자동화기사", "6시그마 GB/BB", "정보처리기사"],
      heroTags: ["생산관리", "공장관리", "스마트팩토리", "품질경영", "6시그마"],
      youtubeLinks: [],
      _sources: {
        way: [
          { id: 1, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=195" },
          { id: 2, text: "워크넷 직업정보", url: "https://www.work.go.kr/empinfo/occInfoSrch/occInfoMain.do" }
        ],
        "overviewSalary.sal": [
          { id: 1, text: "워크넷 직업정보", url: "https://www.work.go.kr/empinfo/occInfoSrch/occInfoMain.do" },
          { id: 2, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=195" }
        ],
        "overviewProspect.main": [
          { id: 1, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=195" },
          { id: 2, text: "산업통상자원부", url: "https://www.motie.go.kr/" }
        ],
        trivia: [
          { id: 1, text: "도요타 생산방식(TPS)", url: "https://www.toyota-global.com/company/toyota_traditions/quality/" },
          { id: 2, text: "삼성전자 반도체 생산 현황", url: "https://semiconductor.samsung.com/" },
          { id: 3, text: "6시그마 공식 자료", url: "https://www.isixsigma.com/" }
        ],
        "detailWlb.wlbDetail": [
          { id: 1, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=195" }
        ],
        "detailWlb.socialDetail": [
          { id: 1, text: "산업통상자원부", url: "https://www.motie.go.kr/" }
        ]
      }
    }
  },
  {
    id: '1765283414891152',
    name: '조사전문가',
    ucj: {
      way: "조사전문가가 되려면 통계학, 사회학, 심리학, 경영학, 경제학 등 관련 전공을 졸업하거나, 여론조사·시장조사 전문 기관에서 경력을 쌓는 것이 일반적이다.[1] 사회조사분석사(1급·2급) 자격증은 취업에 직접적으로 도움이 되며, 통계 분석 소프트웨어(SPSS, SAS, R) 활용 능력이 필수다.[2] 여론조사 전문 기업(한국갤럽, 리서치앤리서치, 닐슨코리아 등), 공공기관 통계부서, 대기업 소비자리서치팀 등으로 취업한다.[1] 최근에는 빅데이터 분석, 딥러닝 기반 텍스트 분석 등 디지털 리서치 역량이 중요해지고 있다.[2]",
      overviewSalary: {
        sal: "연봉 중위값은 약 3,500만 원이다.[1] 대기업 소비자리서치팀이나 주요 리서치 기업의 선임급은 5,000만 원 이상이며, 독립 리서치 컨설턴트는 프로젝트당 수익이 크게 높아질 수 있다.[2] 공공기관(통계청·한국리서치 등) 정규직의 경우 안정적인 처우를 받는다.[1]",
        source: "워크넷, 커리어넷 직업백과(2024)"
      },
      overviewProspect: {
        main: "향후 5년간 고용은 보통 수준을 유지할 것으로 전망된다.[1] 빅데이터·AI 분석 기술의 발전으로 전통적인 설문조사 방식은 줄어드는 반면, 디지털 리서치·소셜미디어 분석·행동 데이터 분석 수요가 급증하고 있다.[2] 선거·정책 여론조사의 공공적 수요와 기업의 소비자 인사이트 수요는 지속적으로 유지된다.[1]",
        source: "커리어넷 직업백과, 한국조사연구학회(2024)"
      },
      trivia: "1936년 미국 갤럽(Gallup)은 2백만 명 표본 조사에서 프랭클린 루즈벨트의 당선을 예측한 잡지(Literary Digest)를 꺾고 불과 5만 명의 과학적 표본 조사로 정확한 선거 결과를 맞혔다. 이 사건이 현대 여론조사의 출발점이 됐다.[1] 설문 응답에 영향을 주는 '프레이밍 효과(framing effect)'는 같은 질문을 어떻게 표현하느냐에 따라 응답률이 최대 30%까지 달라진다.[2] 한국 방송사들의 출구조사 예측 정확도는 세계 최고 수준으로, 2024년 총선에서도 개표 시작 직후 95% 이상의 정확도를 보였다.[3] 리서치 산업에서 NPS(Net Promoter Score·순추천지수)는 단 하나의 질문(우리 서비스를 주변에 추천하겠습니까?)으로 고객 충성도를 측정하는 혁신적 방법론이다.[1]",
      detailWlb: {
        wlb: "보통이상",
        social: "보통이상",
        wlbDetail: "프로젝트 마감 기간에는 야근이 집중되지만, 평상시에는 비교적 규칙적인 근무가 가능하다. 클라이언트 보고 일정과 데이터 분석 마감에 따른 스트레스가 있으나, 외근·현장 조사와 사무 업무를 혼합하는 다양한 환경이 특징이다.",
        socialDetail: "사회의 의견과 트렌드를 데이터로 파악하여 정책 결정, 기업 전략, 선거 등 중요한 의사결정에 기여한다. 소비자 인사이트를 제공하여 좋은 제품·서비스 개발을 촉진하는 사회적 가치를 지닌다."
      },
      detailReady: {
        curriculum: [
          "통계학과, 사회학과, 심리학과, 경영학과 등 관련 전공 입학",
          "사회조사분석사 2급 → 1급 단계적 취득",
          "SPSS, R, Python 통계 분석 도구 학습",
          "설문 설계, 표본 추출, 데이터 시각화 프로젝트 경험 쌓기"
        ],
        recruit: [
          "여론조사 전문 기업(한국갤럽, 리서치앤리서치, 닐슨코리아 등) 채용",
          "대기업 소비자조사·인사이트팀 채용",
          "통계청·한국리서치 등 공공기관 채용",
          "광고·마케팅 에이전시 리서치 파트 채용"
        ],
        training: [
          "빅데이터 분석 전문가 자격 취득",
          "UX 리서처로 전문화 (인터뷰·사용성 테스트 전문)",
          "독립 리서치 컨설턴트·리서치 컨설팅 회사 설립",
          "데이터 사이언티스트로 전환: Python·머신러닝 심화 학습"
        ]
      },
      sidebarJobs: ["마케팅전문가", "조사전문가", "인적자원전문가", "경영컨설턴트", "사회단체활동가"],
      sidebarMajors: ["통계학과", "사회학과", "심리학과", "경영학과"],
      sidebarCerts: ["사회조사분석사", "빅데이터분석기사", "데이터분석준전문가(ADsP)", "SPSS Statistics"],
      heroTags: ["여론조사", "시장조사", "소비자리서치", "사회조사분석사", "데이터분석"],
      youtubeLinks: [],
      _sources: {
        way: [
          { id: 1, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=210" },
          { id: 2, text: "워크넷 직업정보", url: "https://www.work.go.kr/empinfo/occInfoSrch/occInfoMain.do" }
        ],
        "overviewSalary.sal": [
          { id: 1, text: "워크넷 직업정보", url: "https://www.work.go.kr/empinfo/occInfoSrch/occInfoMain.do" },
          { id: 2, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=210" }
        ],
        "overviewProspect.main": [
          { id: 1, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=210" },
          { id: 2, text: "한국조사연구학회", url: "https://www.ksr.or.kr/" }
        ],
        trivia: [
          { id: 1, text: "갤럽 공식 사이트", url: "https://www.gallup.com/" },
          { id: 2, text: "한국조사연구학회", url: "https://www.ksr.or.kr/" },
          { id: 3, text: "한국방송학회 선거보도 연구", url: "https://www.kobaco.co.kr/" }
        ],
        "detailWlb.wlbDetail": [
          { id: 1, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=210" }
        ],
        "detailWlb.socialDetail": [
          { id: 1, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=210" }
        ]
      }
    }
  },
  {
    id: '1765283506861391',
    name: '선박조립원',
    ucj: {
      way: "선박조립원이 되려면 조선·기계 관련 직업훈련원에서 용접, 절단, 도장, 조립 기술을 습득하거나, 한국폴리텍대학 조선과에서 교육을 받는 것이 일반적이다.[1] 조선소(현대중공업, 삼성중공업, 대우조선해양·한화오션 등)의 하청 업체에 취업하여 현장 기술을 익히거나, 직접 대기업 공채로 입사하는 경로가 있다.[2] 용접기능사, 특수용접기능사, 배관기능사 등 자격증이 취업에 유리하며, 현장 경력이 기술 수준을 결정하는 직종이다.[1]",
      overviewSalary: {
        sal: "연봉 중위값은 약 3,800만 원이다.[1] 대형 조선소 직영 직원의 경우 각종 수당과 복지를 포함하면 5,000만 원 이상도 가능하다.[2] 하청 업체 소속의 경우 3,000만~3,500만 원 수준이며, 조선업 호황기에는 초과근무 수당으로 상당히 높아진다.[1]",
        source: "워크넷, 한국조선해양플랜트협회(2024)"
      },
      overviewProspect: {
        main: "향후 5년간 고용은 증가할 것으로 전망된다.[1] 글로벌 LNG선·컨테이너선 발주 급증으로 한국 조선 3사가 수주 호황을 맞고 있으며, 숙련 인력 부족이 업계의 핵심 과제로 부상했다.[2] 정부와 조선 업체들이 신규 인력 양성을 적극 지원하고 있어 취업 기회가 확대되고 있다.[1]",
        source: "커리어넷 직업백과, 한국조선해양플랜트협회(2024)"
      },
      trivia: "한국은 세계 조선 시장 점유율 1위 국가로, 2023년 전 세계 발주량의 약 43%를 수주했다.[1] 대형 LNG운반선 한 척의 제조 기간은 약 2~3년이며, 투입 인력은 연인원 수만 명에 달한다.[2] 거제도 현대중공업 조선소는 면적이 약 400만㎡(약 1.4km²)로, 수만 명이 일하는 '도시 속 도시'다.[3] 조선소 선박 블록(block)의 무게는 최대 500톤에 달하며, 이를 정밀하게 조립하는 정밀도는 밀리미터 단위다.[1]",
      detailWlb: {
        wlb: "보통이하",
        social: "보통이상",
        wlbDetail: "조선소 현장은 야외 고소 작업, 밀폐 공간 용접 등 위험하고 열악한 환경이다. 호황기에는 야근과 주말 근무가 빈번하며 하청 구조로 인한 고용 불안정성이 있다. 조선소가 주로 거제·울산·통영 등 지방에 위치하여 가족과의 분리 생활이 필요한 경우도 있다.",
        socialDetail: "LNG 운반선, 컨테이너선, 해양플랜트 등 글로벌 에너지·물류 인프라를 직접 제작하는 핵심 산업 인력이다. 한국 조선업은 세계 최고 수준이며, 선박조립원의 기술이 그 근간을 이루고 있다."
      },
      detailReady: {
        curriculum: [
          "한국폴리텍대학 조선과 또는 직업훈련기관 용접·도장·배관 과정 이수",
          "용접기능사(아크·TIG·MIG) 자격 취득",
          "특수용접기능사, 배관기능사 추가 취득으로 전문화",
          "산업안전보건 교육 이수 (고소작업, 밀폐공간 안전 등)"
        ],
        recruit: [
          "조선 3사(HD현대중공업, 삼성중공업, 한화오션) 직영 채용",
          "조선소 하청 협력업체 채용",
          "정부·조선업체 연계 신규 인력 양성 프로그램 참여",
          "고용노동부 조선업 특화 취업 지원 사업 활용"
        ],
        training: [
          "기능장(용접기능장, 배관기능장) 취득으로 고급 기술자 인정",
          "현장 반장·공장장으로 관리직 성장",
          "선박 검사원, 품질 검사관으로 전문화",
          "조선 기술사 자격 취득 후 해외 조선소 전문 기술 자문"
        ]
      },
      sidebarJobs: ["선박기관사", "제조·생산관리자", "품질관리사무원", "조선기술자"],
      sidebarMajors: ["조선공학과", "기계공학과", "산업공학과"],
      sidebarCerts: ["용접기능사", "특수용접기능사", "배관기능사", "선박건조기능사", "산업안전기사"],
      heroTags: ["선박조립", "조선소", "용접", "HD현대중공업", "조선업", "LNG선"],
      youtubeLinks: [],
      _sources: {
        way: [
          { id: 1, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=340" },
          { id: 2, text: "한국조선해양플랜트협회", url: "https://www.koshipa.or.kr/" }
        ],
        "overviewSalary.sal": [
          { id: 1, text: "워크넷 직업정보", url: "https://www.work.go.kr/empinfo/occInfoSrch/occInfoMain.do" },
          { id: 2, text: "한국조선해양플랜트협회", url: "https://www.koshipa.or.kr/" }
        ],
        "overviewProspect.main": [
          { id: 1, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=340" },
          { id: 2, text: "한국조선해양플랜트협회", url: "https://www.koshipa.or.kr/" }
        ],
        trivia: [
          { id: 1, text: "한국조선해양플랜트협회", url: "https://www.koshipa.or.kr/" },
          { id: 2, text: "HD현대중공업 공식 자료", url: "https://www.hhi.co.kr/" },
          { id: 3, text: "한국산업단지공단", url: "https://www.kicox.or.kr/" }
        ],
        "detailWlb.wlbDetail": [
          { id: 1, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=340" }
        ],
        "detailWlb.socialDetail": [
          { id: 1, text: "한국조선해양플랜트협회", url: "https://www.koshipa.or.kr/" }
        ]
      }
    }
  },
  {
    id: '1765283416514994',
    name: '조세행정사무원',
    ucj: {
      way: "조세행정사무원이 되는 주요 경로는 국세청·관세청·지방자치단체 세무부서의 공무원 시험(9급·7급 세무직 공무원)에 합격하는 것이다.[1] 세무직 공무원 시험은 국어·영어·한국사 외 세법개론, 회계학 과목이 포함되어 있어 관련 지식이 필수다.[2] 또한 세무사 자격증을 취득하여 세무법인 또는 개인 세무사 사무소에서 근무하거나 창업하는 경로도 있다.[1] 대학 세무학과, 경영학과, 회계학과 전공자가 유리하며, 대기업 세무팀·경리팀의 세무 담당 직원으로 취업하는 방법도 있다.[2]",
      overviewSalary: {
        sal: "연봉 중위값은 약 3,800만 원이다.[1] 세무직 공무원 9급 초임은 약 2,600만 원이나 호봉제 적용으로 연차에 따라 안정적으로 증가한다.[2] 세무사 자격 보유 시 세무법인 소속 또는 독립 개업으로 6,000만~1억 원 이상도 가능하다.[1]",
        source: "인사혁신처, 한국세무사회(2024)"
      },
      overviewProspect: {
        main: "향후 5년간 고용은 현 수준을 유지하거나 소폭 감소할 것으로 전망된다.[1] AI 세무 서비스(삼쩜삼·세금신고 자동화 등)의 확산으로 단순 세금 신고 업무는 자동화되는 추세이나, 기업 세무조사·조세 컨설팅 등 복잡한 업무 수요는 유지된다.[2] 국세청의 디지털 전환으로 공무원 수는 줄지만 고급 세무 전문가 수요는 꾸준하다.[1]",
        source: "커리어넷 직업백과, 국세청(2024)"
      },
      trivia: "한국의 국세청 전산시스템(홈택스)은 세계에서 가장 선진적인 전자신고 시스템 중 하나로, 개인 종합소득세 신고의 90% 이상이 온라인으로 이루어진다.[1] 2023년 국세청 신고 기준 국내 총 세수는 약 400조 원으로, 이를 관리하는 세무 공무원 수는 약 2만 명이다.[2] 조세피난처(Tax Haven)를 활용한 역외 탈세를 추적하는 '역외 세무조사'는 고도의 국제 세법 지식이 필요하여 최정예 세무 공무원들이 담당한다.[3] 대한민국 최초의 세금 기록은 삼국시대로 거슬러 올라가며, 조선시대 조세(租稅)는 쌀과 포(布)로 납부했다.[1]",
      detailWlb: {
        wlb: "보통이상",
        social: "보통이상",
        wlbDetail: "세무 신고 시즌(5월 종합소득세 신고, 연말정산 시기)에는 업무가 집중되지만, 공무원 직종의 특성상 전반적인 워라밸은 민간 대비 양호하다. 세무사 사무소의 경우 신고 시즌에는 야근이 빈번하다.",
        socialDetail: "국가 재정의 핵심인 세금을 올바르게 부과·징수하여 사회 전체의 공정한 조세 시스템을 유지하는 역할이다. 불법 탈세 추적과 조세 형평성 확보를 통해 사회적 정의 실현에 기여한다."
      },
      detailReady: {
        curriculum: [
          "세무학과, 회계학과, 경영학과 등 관련 전공 입학",
          "세무직 9급 공무원 시험 준비: 세법개론, 회계학 집중 학습",
          "세무사 자격시험 준비: 1차(회계학·세법학) + 2차(소득세·법인세·부가가치세 등)",
          "재경관리사, 전산세무 자격증 취득으로 실무 역량 강화"
        ],
        recruit: [
          "국세청 세무직 9급·7급 공무원 채용",
          "지방자치단체 지방세 담당 사무원 채용",
          "세무법인·회계법인 취업",
          "대기업 세무팀·경리팀 세무 담당 직원 채용"
        ],
        training: [
          "세무사 자격 취득 후 독립 개업 또는 세무법인 설립",
          "공인회계사(CPA) 자격 추가 취득 후 회계법인 진출",
          "국제 세무(국제 조세 전문가, 역외 세무조사) 전문화",
          "7급→5급 승진 후 세무 행정 고위직 성장"
        ]
      },
      sidebarJobs: ["세무사", "관세사", "정부·공공행정전문가", "조사전문가", "비서"],
      sidebarMajors: ["세무학과", "세무·회계학과", "회계학과", "경영학과", "행정학과"],
      sidebarCerts: ["세무사", "전산세무1급", "재경관리사", "세무직공무원", "공인회계사"],
      heroTags: ["세무", "세무공무원", "세무사", "국세청", "조세행정", "세금"],
      youtubeLinks: [],
      _sources: {
        way: [
          { id: 1, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=230" },
          { id: 2, text: "인사혁신처", url: "https://www.mpm.go.kr/" }
        ],
        "overviewSalary.sal": [
          { id: 1, text: "인사혁신처 공무원보수규정", url: "https://www.mpm.go.kr/" },
          { id: 2, text: "한국세무사회", url: "https://www.kacpta.or.kr/" }
        ],
        "overviewProspect.main": [
          { id: 1, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=230" },
          { id: 2, text: "국세청", url: "https://www.nts.go.kr/" }
        ],
        trivia: [
          { id: 1, text: "국세청 홈택스", url: "https://www.hometax.go.kr/" },
          { id: 2, text: "국세청 통계연보", url: "https://www.nts.go.kr/" },
          { id: 3, text: "국제조세협력센터", url: "https://www.nts.go.kr/" }
        ],
        "detailWlb.wlbDetail": [
          { id: 1, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=230" }
        ],
        "detailWlb.socialDetail": [
          { id: 1, text: "국세청", url: "https://www.nts.go.kr/" }
        ]
      }
    }
  },
  {
    id: '1765283477441606',
    name: '여행사무원',
    ucj: {
      way: "여행사무원이 되려면 관광경영학과, 관광학과 등 관련 전공을 졸업하거나 여행업 관련 직업훈련 과정을 이수하는 것이 유리하다.[1] 대형 여행사(하나투어, 모두투어, 인터파크 등)의 신입 공채 또는 중소 여행사에서 수시 채용하는 경우가 많으며, 외국어(영어·중국어·일본어 등) 능력이 중요하다.[2] 국내여행안내사, 관광통역안내사 자격증이 있으면 취업에 유리하며, 여행 상품 예약 시스템(아마데우스·토파스 등 GDS 시스템) 활용 능력도 필수다.[1] 항공권·호텔·투어 패키지 예약 업무로 시작하여 상품 기획, 해외 현지 운영 등으로 성장하는 경로다.[2]",
      overviewSalary: {
        sal: "연봉 중위값은 약 2,800만 원이다.[1] 인센티브 제도가 있는 경우 판매 실적에 따라 3,500만 원 이상도 가능하다.[2] 대형 여행사 팀장급은 4,000만 원 이상이며, 외국계 항공사 운임 담당은 처우가 더 높다.[1]",
        source: "워크넷, 한국여행업협회(2024)"
      },
      overviewProspect: {
        main: "향후 5년간 고용은 보통 수준을 유지할 것으로 전망된다.[1] 코로나19 이후 해외여행 수요가 빠르게 회복되고 있으며, MZ세대의 개인화·프리미엄 여행 수요 증가로 맞춤형 여행 상품 기획자 수요가 늘고 있다.[2] 온라인 여행 플랫폼의 성장으로 단순 예약 업무는 감소하지만, 복잡한 여행 상품 설계와 고객 서비스 역량은 여전히 필요하다.[1]",
        source: "커리어넷 직업백과, 한국여행업협회(2024)"
      },
      trivia: "전 세계 여행 산업 규모는 코로나19 이전 기준 약 9조 달러(약 1경 2천조 원)로 글로벌 GDP의 약 10%를 차지했다.[1] 여행사에서 사용하는 GDS(Global Distribution System)는 전 세계 항공편·호텔·렌터카 실시간 예약 시스템으로, 아마데우스·세이버·갈릴레오 3대 시스템이 전 세계의 90%를 처리한다.[2] 한국 최초의 근대 여행사는 1912년 일본 JTB(일본교통공사)의 조선 지부로, 100년 이상의 역사를 가지고 있다.[3] '버킷리스트 여행'을 주제로 한 여행 상품은 80세 이상 노인이 주요 고객층으로 성장하면서 실버 투어 시장을 개척하고 있다.[1]",
      detailWlb: {
        wlb: "보통이하",
        social: "보통",
        wlbDetail: "성수기(여름·겨울 방학, 연휴)에는 예약 폭주로 야근이 잦다. 고객 불만(여행 일정 변경, 환불 요청 등) 처리로 감정적 소모가 크다. 해외 여행 상품 담당자는 시차 관계로 야간 연락이 필요할 때도 있다.",
        socialDetail: "국민의 여가와 문화 체험을 연결하는 역할로 삶의 질 향상에 기여한다. 해외 문화 교류와 국제 이해를 증진하는 민간 외교관 역할도 수행한다. 코로나19 이후 여행 산업 회복의 최전선에서 경제 활성화에 기여하고 있다."
      },
      detailReady: {
        curriculum: [
          "관광경영학과, 호텔관광학과, 관광학과 등 관련 전공 입학",
          "국내여행안내사 또는 관광통역안내사 자격증 취득",
          "GDS 시스템(아마데우스·토파스) 활용 교육 이수",
          "외국어(영어·일본어·중국어) 능력 강화"
        ],
        recruit: [
          "하나투어, 모두투어, 노랑풍선 등 대형 여행사 공채",
          "소규모 전문 여행사(허니문·배낭·크루즈 전문) 수시 채용",
          "항공사·호텔 예약 센터 채용",
          "온라인 여행 플랫폼(클룩, 마이리얼트립) 운영 직원 채용"
        ],
        training: [
          "여행 상품 기획자로 성장: 신상품 개발·마케팅 담당",
          "해외 지사 파견 또는 현지 운영 담당(랜드오퍼레이터)",
          "여행사 창업: 틈새 시장(럭셔리·시니어·의료관광 등) 전문",
          "항공사 화물·영업 부문, 호텔 예약·영업팀으로 이직"
        ]
      },
      sidebarJobs: ["여행안내원", "관광통역안내원", "호텔지배인", "비서", "조세행정사무원"],
      sidebarMajors: ["관광경영학과", "관광경영과", "호텔경영학과", "경영학과"],
      sidebarCerts: ["국내여행안내사", "관광통역안내사", "항공운임발권사(IATA)", "TOEIC 700+"],
      heroTags: ["여행사무원", "여행사", "항공권예약", "패키지여행", "관광경영"],
      youtubeLinks: [],
      _sources: {
        way: [
          { id: 1, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=255" },
          { id: 2, text: "한국여행업협회", url: "https://www.kata.or.kr/" }
        ],
        "overviewSalary.sal": [
          { id: 1, text: "워크넷 직업정보", url: "https://www.work.go.kr/empinfo/occInfoSrch/occInfoMain.do" },
          { id: 2, text: "한국여행업협회", url: "https://www.kata.or.kr/" }
        ],
        "overviewProspect.main": [
          { id: 1, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=255" },
          { id: 2, text: "한국여행업협회", url: "https://www.kata.or.kr/" }
        ],
        trivia: [
          { id: 1, text: "세계여행관광위원회(WTTC)", url: "https://wttc.org/" },
          { id: 2, text: "GDS 시스템 정보(IATA)", url: "https://www.iata.org/" },
          { id: 3, text: "한국관광공사", url: "https://kto.visitkorea.or.kr/" }
        ],
        "detailWlb.wlbDetail": [
          { id: 1, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=255" }
        ],
        "detailWlb.socialDetail": [
          { id: 1, text: "한국여행업협회", url: "https://www.kata.or.kr/" }
        ]
      }
    }
  },
  {
    id: '1765283529393623',
    name: '주입·포장·상표부착기계조작원',
    ucj: {
      way: "주입·포장·상표부착기계조작원이 되기 위해 특별한 학력이나 자격증은 필요하지 않다.[1] 식품, 음료, 의약품, 화장품, 생활용품 등 제조업체의 생산 라인에서 채용 공고를 통해 취업하며, 워크넷·사람인·알바천국 등에서 구인 정보를 찾을 수 있다.[2] 기초 기계 조작 능력과 안전 규정 준수 의식이 중요하며, HACCP 교육(식품 제조업체의 경우)이나 위험물 취급 교육을 사전에 받아두면 유리하다.[1] 현장 경험을 쌓으면 설비 보전, 생산 관리 등 상위 직무로 성장할 수 있다.[2]",
      overviewSalary: {
        sal: "연봉 중위값은 약 2,700만 원이다.[1] 대기업 계열 식품·음료 공장의 정규직은 복지 포함 3,500만 원 이상이며, 야간·교대근무 수당이 추가된다.[2] 중소 제조업체나 파견 근무의 경우 최저임금 수준인 경우도 있다.[1]",
        source: "워크넷, 커리어넷 직업백과(2024)"
      },
      overviewProspect: {
        main: "향후 5년간 고용은 다소 감소할 것으로 전망된다.[1] 포장 공정의 자동화·로봇화가 빠르게 진행되고 있어 단순 반복 조작 업무는 점진적으로 줄어들고 있다.[2] 그러나 신제품 출시와 소량·다품종 생산 수요로 인한 유연한 인력 수요는 당분간 유지될 것으로 보인다.[1]",
        source: "커리어넷 직업백과, 한국식품산업협회(2024)"
      },
      trivia: "현대 포장 기술의 분수령은 1959년 알루미늄 캔의 발명으로, 지금도 전 세계에서 하루에 약 10억 개의 알루미늄 캔이 생산된다.[1] 아마존의 물류 창고에서는 로봇 포장 시스템이 초당 수십 개의 상품을 처리하지만, 불규칙한 형태의 상품은 여전히 사람의 손길이 필요하다.[2] 식품 포장 업계에서는 '수축 필름(shrink wrap)'이 처음 소개된 1960년대 이후 위생과 유통기한 연장에 혁명적 변화를 가져왔다.[3] 라면 봉지 포장기계는 분당 최대 200봉지 이상을 처리할 수 있으며, 이를 정상 작동시키고 불량을 관리하는 것이 조작원의 핵심 역할이다.[1]",
      detailWlb: {
        wlb: "보통이하",
        social: "보통이하",
        wlbDetail: "교대근무(2교대·3교대) 형태가 많아 야간근무가 포함되며, 수면 패턴이 불규칙해진다. 생산 라인은 서서 반복 작업하는 특성상 체력 소모가 크고 근골격계 질환 위험이 있다. 소음이 많은 공장 환경에서 장시간 근무한다.",
        socialDetail: "식품·의약품·생활용품 등 국민의 일상 필수품 생산에 직접 기여하는 직업이다. 사회적 인지도는 낮으나, 이들의 작업이 없으면 우리가 소비하는 모든 포장 제품의 생산이 불가능하다."
      },
      detailReady: {
        curriculum: [
          "별도 학력·자격 요건 없음; 기계 조작 기초 능력 필수",
          "HACCP(위해요소중점관리기준) 교육 이수 (식품 업체 필수)",
          "위험물 취급 안전 교육 이수",
          "산업안전보건교육 이수 (현장 배치 전 법정 교육)"
        ],
        recruit: [
          "워크넷·사람인·알바천국 구인 플랫폼",
          "대기업 계열 식품·음료 회사(CJ제일제당, 오뚜기, 농심) 생산직 공채",
          "제조업 파견 전문 업체를 통한 취업",
          "의약품·화장품 제조업체 포장 라인 채용"
        ],
        training: [
          "설비 보전 기술 습득: 전기기능사, 기계정비기능사 취득",
          "생산 라인 리더(반장)로 성장",
          "생산관리직(공정관리·품질관리)으로 전직",
          "식품산업기사, 품질경영기사 취득으로 전문성 강화"
        ]
      },
      sidebarJobs: ["제조·생산관리자", "품질관리사무원", "선박조립원"],
      sidebarMajors: ["기계공학과", "산업공학과", "식품공학과"],
      sidebarCerts: ["HACCP관리사", "위험물산업기사", "식품산업기사", "품질경영기사", "산업안전기사"],
      heroTags: ["포장기계", "생산라인", "식품포장", "제조직", "공장직"],
      youtubeLinks: [],
      _sources: {
        way: [
          { id: 1, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=470" },
          { id: 2, text: "워크넷 직업정보", url: "https://www.work.go.kr/empinfo/occInfoSrch/occInfoMain.do" }
        ],
        "overviewSalary.sal": [
          { id: 1, text: "워크넷 직업정보", url: "https://www.work.go.kr/empinfo/occInfoSrch/occInfoMain.do" },
          { id: 2, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=470" }
        ],
        "overviewProspect.main": [
          { id: 1, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=470" },
          { id: 2, text: "한국식품산업협회", url: "https://www.kfia.or.kr/" }
        ],
        trivia: [
          { id: 1, text: "세계포장기구(WPO)", url: "https://www.worldpackaging.org/" },
          { id: 2, text: "아마존 물류 자동화 자료", url: "https://www.amazon.com/" },
          { id: 3, text: "한국식품산업협회", url: "https://www.kfia.or.kr/" }
        ],
        "detailWlb.wlbDetail": [
          { id: 1, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=470" }
        ],
        "detailWlb.socialDetail": [
          { id: 1, text: "커리어넷 직업백과", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=470" }
        ]
      }
    }
  }
];

// Generate SQL
const sqls = jobs.map(job => {
  const json = JSON.stringify(job.ucj);
  const escaped = json.replace(/'/g, "''");
  return `UPDATE jobs SET user_contributed_json = '${escaped}' WHERE id = '${job.id}';`;
});

const sql = sqls.join('\n\n');
writeFileSync('scripts/p3-batch3-ucj.sql', sql, 'utf8');
console.log(`✅ Generated SQL: ${Buffer.byteLength(sql, 'utf8')} bytes, ${jobs.length} jobs`);
jobs.forEach(j => console.log(`  - ${j.name} (id: ${j.id})`));

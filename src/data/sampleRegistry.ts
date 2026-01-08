import type { DataSource, UnifiedJobDetail, UnifiedMajorDetail } from '../types/unifiedProfiles'
import type { SourceStatusRecord } from '../services/profileDataService'
import type { HowtoGuideDetail } from '../types/howto'
import { composeDetailSlug, resolveDetailIdFromSlug } from '../utils/slug'

interface SampleMeta {
  canonicalSlug: string
  title: string
  description: string
  updatedAt: string
  keywords: string[]
}

interface SampleJobEntry {
  slug: string
  title: string
  snippet: string
  keywords: string[]
  profile: UnifiedJobDetail
  sources: SourceStatusRecord
  partials?: Partial<Record<DataSource, UnifiedJobDetail | null>>
  meta: SampleMeta
}

interface SampleMajorEntry {
  slug: string
  title: string
  snippet: string
  keywords: string[]
  profile: UnifiedMajorDetail
  sources: SourceStatusRecord
  partials?: Partial<Record<DataSource, UnifiedMajorDetail | null>>
  meta: SampleMeta
}

interface SampleHowtoEntry {
  slug: string
  title: string
  snippet: string
  keywords: string[]
  tags: string[]
  guide: HowtoGuideDetail
  meta: SampleMeta
}

export interface SampleSearchItem {
  slug: string
  title: string
  snippet: string
  keywords: string[]
}

const createSyntheticSourceStatus = (): SourceStatusRecord => ({
  CAREERNET: { attempted: false, count: 0, skippedReason: 'synthetic-fallback' },
  GOYONG24: { attempted: false, count: 0, skippedReason: 'synthetic-fallback' }
})

const jobSampleSeed: Record<string, SampleJobEntry> = {
  lawyer: {
    slug: '변호사',
    title: '변호사',
    snippet: '의뢰인의 권리를 대변하고 각종 법률 분쟁을 해결하는 전문가로, 로스쿨·사법연수원 과정을 거쳐 사건 수임과 자문을 수행합니다.',
    keywords: ['변호사', '법률 전문가', '로스쿨', '법조인', '사법연수원'],
    profile: {
      id: 'lawyer',
      sourceIds: {
        careernet: '375',
        goyong24: 'K000007482'
      },
      name: '변호사',
      category: {
        code: '100045',
        name: '법률·경찰·소방·군인'
      },
      sources: ['CAREERNET', 'GOYONG24'],
      classifications: {
        large: '법률 전문가',
        medium: '변호사',
        small: '소송·자문 변호사'
      },
      summary: `변호사는 민사·형사·행정 등 다양한 사건에서 의뢰인의 권리 보호를 위해 법률 자문과 소송 대리를 수행합니다.
사법시험에서 로스쿨 제도로 전환된 이후, 체계적인 교육과 실무 연수를 거쳐 전문성이 강화되었습니다.`,
      duties: `- 의뢰인 상담을 통해 사건의 법적 쟁점을 파악하고 전략을 수립합니다.
- 서면 작성, 증거 정리, 변론 준비 등 소송 절차 전반을 주도합니다.
- 기업 자문, 공익 사건, 조정·중재 등 비송 업무를 수행하며 이해관계자를 조율합니다.
- 최신 판례와 법령 변화를 지속적으로 학습해 리스크를 예방합니다.`,
      way: `사무소와 법원을 오가며 사건 수임부터 종결까지 장기 프로젝트 단위로 일합니다.
사법연수원·로펌 수습 과정을 거쳐 팀 기반으로 업무를 분담하고, 법률 테크 도구를 활용해 판례·자료를 관리합니다.`,
      relatedMajors: [
        { id: 'major:C_10501', name: '법학과' },
        { id: 'major:G_2000049', name: '법률행정학과' }
      ],
      relatedCertificates: ['변호사 자격증', '법무사', '조정·중재 전문가 과정'],
      salary: '신입 평균 연 5,400만원 · 10년차 이상 연 1억 2,000만원 이상 (로펌 규모별 상이)',
      satisfaction: '고용24 커리어 만족도 78점 (2024)',
      prospect: '고용안정 4/5 · 직무전문성 4/5 · AI·법률테크 확산에 따른 역할 재정의 진행 중',
      status: '정규직 중심 · 사건 단위 수임 계약 병행',
      abilities: '법률지식, 논리적 사고, 협상력, 윤리의식',
      knowledge: '민·형사 절차법, 상법, 행정법, 증거법, 윤리규정',
      environment: '법원·검찰청 출석, 로펌/사무소 근무, 온라인 자료조사 병행',
      personality: '공감 능력, 책임감, 스트레스 관리, 커뮤니케이션',
      interests: '사회형(S) + 관습형(C) + 진취형(E)',
      values: '정의, 공정성, 사회 기여',
      technKnow: '전자소송 시스템, 판례 검색 서비스, 계약 자동화, e-Discovery 툴',
      relatedJobs: [
        { id: 'prosecutor', name: '검사' },
        { id: 'in-house-counsel', name: '사내 변호사' },
        { id: 'legal-consultant', name: '법률 컨설턴트' }
      ],
      educationDistribution: {
        middleSchoolOrLess: '0%',
        highSchool: '2%',
        college: '6%',
        university: '62%',
        graduate: '24%',
        doctor: '6%'
      },
      majorDistribution: {
        humanities: '18%',
        social: '44%',
        education: '2%',
        engineering: '4%',
        natural: '6%',
        medical: '2%',
        artsSports: '1%'
      },
      relatedOrganizations: [
        { name: '대한변호사협회', url: 'https://www.koreanbar.or.kr/' },
        { name: '법률구조공단', url: 'https://www.klac.or.kr/' }
      ],
      kecoCodes: [
        { code: '2311', name: '법률 전문가' },
        { code: '2312', name: '법무 관련 관리자' }
      ],
      activitiesImportance: '소송 전략 수립 85점\n의뢰인 커뮤니케이션 82점\n법령·판례 업데이트 80점',
      activitiesLevels: '증거 분석: 전문가\n법정 변론: 상급'
    },
    sources: createSyntheticSourceStatus(),
    meta: {
      canonicalSlug: '변호사',
      title: '변호사 - CareerWiki Phase-1 샘플',
      description: '커리어넷과 고용24 데이터를 기반으로 통합한 변호사 직업 샘플 페이지입니다.',
      updatedAt: '2024-10-12',
      keywords: ['변호사', '법률 전문가', '로스쿨', '법조인', '법률 직업']
    }
  },
  'growth-marketing-director': {
    slug: 'growth-marketing-director',
    title: '그로스 마케팅 디렉터',
    snippet: '데이터 기반 실험과 퍼널 최적화로 ARR 성장률을 끌어올리는 디지털 마케팅 리더',
    keywords: ['그로스 마케팅', 'Growth Marketing', '디지털 마케팅', 'ROAS', '성장 전략'],
    profile: {
      id: 'growth-marketing-director',
      sourceIds: {
        careernet: 'sample-job-001',
        goyong24: 'sample-job-001'
      },
      name: '그로스 마케팅 디렉터',
      category: {
        code: '100042',
        name: '경영·행정·사무직'
      },
      sources: ['CAREERNET', 'GOYONG24'],
      classifications: {
        large: '경영·행정·사무직',
        medium: '마케팅 전문가',
        small: '디지털 마케팅 리더'
      },
      summary: `그로스 마케팅 디렉터는 제품·서비스의 성장 지표를 총괄하며, 실험 문화와 데이터 분석을 결합해 신규 유입부터 리텐션까지의 퍼널을 최적화합니다.

고용24 직업 동향과 커리어넷 직업 사전이 정리한 마케팅·분석 역량을 통합해, Phase 1 환경에서 참고할 수 있는 합성 샘플 데이터로 구성되었습니다.`,
      duties: `- 월간/분기 성장 KPI와 핵심 실험 로드맵을 수립하고 조직과 공유합니다.
- 성과 대시보드, CRM, 데이터 웨어하우스를 연동해 주간 단위로 퍼널 변동을 점검합니다.
- 퍼포먼스 마케팅, 콘텐츠, 프로덕트 팀과 협업해 A/B 테스트와 그로스 실험을 실행합니다.
- 고객 여정에서 병목을 일으키는 지표를 발견하면 신속하게 실험 가설을 정의하고 프로세스를 재설계합니다.`,
      way: `데이터 대시보드를 기반으로 스프린트 단위 실험을 반복하며, 스탠드업과 레트로스펙티브를 통해 학습 사이클을 축적합니다.
원격·하이브리드 환경에서도 협업이 가능하도록 분석 문화를 정착시키고, 투자 대비 성장 효율을 지속적으로 보고합니다.`,
      relatedMajors: [
        { id: 'digital-marketing-major', name: '디지털마케팅학과' },
        { id: 'data-science-major', name: '데이터사이언스학과' }
      ],
      relatedCertificates: ['구글 애널리틱스 GA4', 'SQLD', '디지털마케팅전문가(DMP)'],
      salary: '연 6,500만원 ~ 9,500만원 (상위 25% 기준)',
      satisfaction: '83/100 (사내 설문 합성 데이터)',
      prospect: '데이터 활용과 AI 자동화 확대로 향후 5년간 채용 수요 +22% 전망 (고용24 추정)',
      status: '정규직 중심 · 프로젝트 계약 병행 가능',
      abilities: '수치 해석력, 실험 설계, 크로스 팀 커뮤니케이션',
      knowledge: '마케팅 자동화, SQL, 데이터 시각화, CRM 파이프라인 설계',
      environment: '원격/하이브리드 협업, OKR 기반 실행 문화, 빠른 실험 사이클',
      personality: 'Growth Mindset, 실험과 학습을 즐기는 태도, 팀을 리드하는 설득력',
      interests: '탐구형(Investigative) + 기업형(Enterprising)',
      values: '데이터 투명성, 고객 가치, 반복 가능한 성장 프로세스',
      technKnow: '마케팅 자동화 툴, AI 카피라이팅, 변동성 높은 예산 운영, LTV 예측 모델',
      relatedJobs: [
        { id: 'product-growth-manager', name: '프로덕트 그로스 매니저' },
        { id: 'performance-marketer', name: '퍼포먼스 마케터' },
        { id: 'data-driven-brand-strategist', name: '데이터 기반 브랜드 전략가' }
      ],
      educationDistribution: {
        middleSchoolOrLess: '0%',
        highSchool: '8%',
        college: '12%',
        university: '56%',
        graduate: '24%',
        doctor: '0%'
      },
      majorDistribution: {
        humanities: '12%',
        social: '34%',
        education: '4%',
        engineering: '28%',
        natural: '16%',
        medical: '0%',
        artsSports: '6%'
      },
      relatedOrganizations: [
        { name: '그로스해킹연구회', url: 'https://example.org/growth-community' },
        { name: '한국디지털마케팅협회', url: 'https://example.org/kdma' }
      ],
      kecoCodes: [
        { code: '2432', name: '마케팅 전문가' },
        { code: '2442', name: '시장조사 및 분석가' }
      ],
      activitiesImportance: '데이터 대시보드 검토 78점\n실험 레트로 회고 74점\n경영진 브리핑 72점',
      activitiesLevels: 'A/B 테스트 설계: 전문가\n퍼포먼스 캠페인 운영: 상급'
    },
    sources: createSyntheticSourceStatus(),
    meta: {
      canonicalSlug: 'growth-marketing-director',
      title: '그로스 마케팅 디렉터 - CareerWiki Phase-1 샘플',
      description: '고용24·커리어넷 가이드를 통합한 그로스 마케팅 디렉터 Phase-1 샘플 직업 페이지입니다.',
      updatedAt: '2024-09-15',
      keywords: ['Growth Marketing Director', '디지털 마케터', '그로스 해킹', '경영·사무직']
    }
  },
  'ai-product-strategist': {
    slug: 'ai-product-strategist',
    title: 'AI 프로덕트 전략가',
    snippet: 'AI/ML 기능을 제품 경험에 녹여내는 전략 수립과 실행을 총괄하는 프로덕트 리더 역할',
    keywords: ['AI 프로덕트', 'ML Ops', '데이터 제품 전략', 'AI 윤리', '프로덕트 리더십'],
    profile: {
      id: 'ai-product-strategist',
      sourceIds: {
        careernet: 'sample-job-002',
        goyong24: 'sample-job-002'
      },
      name: 'AI 프로덕트 전략가',
      category: {
        code: '100062',
        name: '정보통신·소프트웨어'
      },
      sources: ['CAREERNET', 'GOYONG24'],
      classifications: {
        large: '정보통신 전문가',
        medium: 'AI 서비스 기획자',
        small: 'AI 프로덕트 매니저'
      },
      summary: `AI 프로덕트 전략가는 고객 가치와 데이터 윤리를 동시에 고려해 AI 기능을 제품에 설계·도입하는 역할을 수행합니다.
Phase 1에서는 커리어넷과 고용24의 IT 직무 설명을 기반으로, 실제 스타트업 현장에서 요구되는 ML 제품 전략 역량을 보강하여 합성 데이터를 구성했습니다.`,
      duties: `- 비즈니스 우선순위에 맞춰 AI/ML 적용 기회를 발굴하고 제품 로드맵을 수립합니다.
- 데이터 사이언스·엔지니어링 팀과 협업해 실험 설계, 모델 성능 검증, 단계별 롤아웃 전략을 총괄합니다.
- 개인정보보호, AI 윤리 이슈를 검토하며 법무/컴플라이언스 팀과 연계해 위험을 사전 차단합니다.
- 주요 KPI(활성 사용자, 전환율, NPS 등) 변화를 추적하며 AI 기능이 비즈니스 성과에 미치는 영향을 측정합니다.`,
      way: `크로스 펑셔널 스쿼드 기반으로 제품·데이터·디자인·마케팅 조직을 연결하며 OKR 체계를 운영합니다.
모델 실험과 A/B 테스트 결과를 데이터 룸에 기록하고, 이해관계자와 주간·월간 리뷰를 진행합니다.`,
      relatedMajors: [
        { id: 'data-science-major', name: '데이터사이언스학과' },
        { id: 'digital-marketing-major', name: '디지털마케팅학과' }
      ],
      relatedCertificates: ['ADsP', 'KOSA AI윤리지도사', 'PMP'],
      salary: '연 7,200만원 ~ 1억 1,000만원 (시니어 기준)',
      satisfaction: '87/100 (Phase-1 인터뷰 합성 데이터)',
      prospect: '글로벌 AI 규제 대비 및 생성형 AI 확산으로 5년 내 고용 수요 +28% 전망 (고용24 추정)',
      status: '정규직 · 전략/프로덕트 본부 소속',
      abilities: '제품 전략 기획, 데이터 해석력, 이해관계자 조율, 윤리적 판단',
      knowledge: 'ML 파이프라인, 데이터 거버넌스, 디자인 씽킹, 제품 수명주기 관리',
      environment: '하이브리드 근무, AI 거버넌스 위원회 참여, 모델 모니터링 대시보드 상시 점검',
      personality: '문제 해결 지향, 커뮤니케이션에 능숙, 책임감 있는 리더십',
      interests: '탐구형(Investigative) + 진취형(Enterprising) + 사회형(Social)',
      values: '고객 중심, 데이터 투명성, 지속 가능한 AI',
      technKnow: 'MLOps 플랫폼, 프롬프트 엔지니어링, Responsible AI 툴킷, 실시간 실험 플랫폼',
      relatedJobs: [
        { id: 'growth-marketing-director', name: '그로스 마케팅 디렉터' },
        { id: 'machine-learning-engineer', name: '머신러닝 엔지니어' },
        { id: 'product-analytics-lead', name: '프로덕트 애널리틱스 리드' }
      ],
      educationDistribution: {
        middleSchoolOrLess: '0%',
        highSchool: '4%',
        college: '10%',
        university: '48%',
        graduate: '32%',
        doctor: '6%'
      },
      majorDistribution: {
        humanities: '6%',
        social: '28%',
        education: '2%',
        engineering: '46%',
        natural: '12%',
        medical: '1%',
        artsSports: '5%'
      },
      relatedOrganizations: [
        { name: '한국인공지능산업협회', url: 'https://example.org/kaia' },
        { name: 'Product-Led AI Forum', url: 'https://example.org/product-led-ai' }
      ],
      kecoCodes: [
        { code: '2511', name: '정보시스템 분석가' },
        { code: '2512', name: '시스템 컨설턴트' }
      ],
      activitiesImportance: 'AI 제품 로드맵 수립 82점\n실험 성과 리뷰 78점\n규제 리스크 검토 74점',
      activitiesLevels: '전략 워크샵 진행: 전문가\nAI 품질 모니터링: 상급'
    },
    sources: createSyntheticSourceStatus(),
    meta: {
      canonicalSlug: 'ai-product-strategist',
      title: 'AI 프로덕트 전략가 - CareerWiki Phase-1 샘플',
      description: 'AI/ML 제품 전략과 거버넌스를 총괄하는 AI 프로덕트 전략가 샘플 직업 페이지입니다.',
      updatedAt: '2024-09-22',
      keywords: ['AI Product Manager', 'AI 전략', '데이터 프로덕트', 'Responsible AI']
    }
  }
}

const majorSampleSeed: Record<string, SampleMajorEntry> = {
  'digital-marketing-major': {
    slug: 'digital-marketing-major',
    title: '디지털마케팅학과',
    snippet: '데이터 기반 브랜딩과 퍼포먼스 전략을 융합해 그로스 팀을 위한 마케터를 양성하는 학과',
    keywords: ['디지털 마케팅', '마케팅 학과', 'Growth', '콘텐츠 전략'],
    profile: {
      id: 'digital-marketing-major',
      sourceIds: {
        careernet: 'sample-major-001',
        goyong24: 'sample-major-001'
      },
      name: '디지털마케팅학과',
      categoryId: 'MK-01',
      categoryName: '상경계열',
      summary: `디지털마케팅학과는 데이터 분석 · 콘텐츠 전략 · 퍼포먼스 운영을 융합해, 빠르게 변화하는 Growth 환경에서 뛰는 마케터를 양성합니다.

고용24 학과 상세와 커리어넷 전공 정보를 참조한 합성 샘플 데이터로 Phase 1에서 접근성 테스트에 활용합니다.`,
      aptitude: '데이터를 근거로 의사결정을 내리고 스토리텔링을 즐기는 탐구/기업형 적성에 적합합니다.',
      relatedMajors: ['경영정보학과', '빅데이터전공', '광고홍보학과'],
      mainSubjects: ['디지털 마케팅 분석', '퍼포먼스 캠페인 실습', '콘텐츠 전략 워크숍', 'CRM 데이터베이스'],
      licenses: ['디지털마케팅전문가(DMP)', 'SQLD', 'GA4 인증'],
      universities: [
        {
          name: 'Careerwiki University',
          department: '디지털마케팅학부',
          universityType: '4년제',
          url: 'https://example.edu/digital-marketing'
        },
        {
          name: '서울디지털대학교',
          department: '마케팅트랙',
          universityType: '원격대',
          url: 'https://example.edu/sdu-marketing'
        }
      ],
      recruitmentStatus: [
        {
          year: '2024',
          universityType: '4년제',
          enrollmentQuota: '80명',
          applicants: '420명',
          graduates: '74명'
        },
        {
          year: '2023',
          universityType: '4년제',
          enrollmentQuota: '70명',
          applicants: '360명',
          graduates: '68명'
        }
      ],
      relatedJobs: ['그로스 마케팅 디렉터', '콘텐츠 마케팅 리드', '데이터 기반 브랜드 전략가'],
      whatStudy: '검색·소셜·커뮤니티 채널 전략을 데이터로 설계하고, 실습형 프로젝트를 통해 퍼널 최적화 기법을 체득합니다.',
      howPrepare: '고등학교 단계에서 통계·경제 과목을 수강하고, 구글 애널리틱스·노션·파이썬 기초를 경험하면 학업에 도움이 됩니다.',
      jobProspect: 'AI 마케팅 도구 확산과 B2B SaaS 시장 확대로 데이터 기반 마케터 수요가 꾸준히 증가하는 추세입니다.',
      salaryAfterGraduation: '4,800만원 (졸업자 평균 추정)',
      employmentRate: '82% (Phase-1 샘플 추정치)',
      sources: ['CAREERNET', 'GOYONG24']
    },
    sources: createSyntheticSourceStatus(),
    meta: {
      canonicalSlug: 'digital-marketing-major',
      title: '디지털마케팅학과 - CareerWiki Phase-1 샘플',
      description: '고용24·커리어넷 학과 정보를 기반으로 구성한 디지털마케팅학과 샘플 전공 페이지입니다.',
      updatedAt: '2024-09-18',
      keywords: ['디지털마케팅학과', 'Growth 팀 학과', '마케팅 데이터']
    }
  },
  'data-science-major': {
    slug: 'data-science-major',
    title: '데이터사이언스학과',
    snippet: '통계·AI·엔지니어링을 통합해 데이터 기반 문제 해결 전문가를 양성하는 융합 학과',
    keywords: ['데이터사이언스', 'AI 전공', '머신러닝', '데이터 엔지니어링', 'Responsible AI'],
    profile: {
      id: 'data-science-major',
      sourceIds: {
        careernet: 'sample-major-002',
        goyong24: 'sample-major-002'
      },
      name: '데이터사이언스학과',
      categoryId: 'ST-02',
      categoryName: '이공계열',
      summary: `데이터사이언스학과는 통계학·컴퓨터공학·AI 윤리를 아우르며 데이터 기반 문제 해결 능력을 기르는 통합형 커리큘럼을 제공합니다.
고용24 학과 정보와 커리어넷 커리큘럼을 참고해 Phase 1 합성 데이터로 구성했습니다.`,
      aptitude: '수리적 사고와 문제 해결을 즐기고, 데이터를 활용한 실험과 협업에 적극적인 탐구/분석형 학생에게 적합합니다.',
      relatedMajors: ['통계학과', '소프트웨어학과', '인공지능학과'],
      mainSubjects: ['확률통계', '머신러닝 개론', '데이터 엔지니어링 실습', '데이터 시각화 프로젝트', 'AI 윤리와 거버넌스'],
      licenses: ['빅데이터분석기사', 'ADsP', 'SQLP'],
      universities: [
        {
          name: 'Careerwiki Institute of Data',
          department: '데이터사이언스대학',
          universityType: '4년제',
          url: 'https://example.edu/data-science'
        },
        {
          name: '한국AI기술원 대학원',
          department: 'AI데이터사이언스전공',
          universityType: '대학원',
          url: 'https://example.edu/ai-data'
        }
      ],
      recruitmentStatus: [
        {
          year: '2024',
          universityType: '4년제',
          enrollmentQuota: '90명',
          applicants: '510명',
          graduates: '82명'
        },
        {
          year: '2023',
          universityType: '4년제',
          enrollmentQuota: '80명',
          applicants: '470명',
          graduates: '76명'
        }
      ],
      relatedJobs: ['AI 프로덕트 전략가', '데이터 사이언티스트', '머신러닝 엔지니어'],
      whatStudy: '선형대수, 통계 추론, Python 기반 데이터 처리, 클라우드 환경에서의 모델 배포, Responsible AI 프레임워크를 학습합니다.',
      howPrepare: '고등학교에서 미적분·통계 과목과 정보 과목을 이수하고, 파이썬·SQL 기초 학습과 데이터 경진대회 경험이 도움이 됩니다.',
      jobProspect: '생성형 AI 상용화와 데이터 거버넌스 규제 강화로 복합 역량을 갖춘 데이터 사이언티스트 수요가 증가하고 있습니다.',
      salaryAfterGraduation: '5,400만원 (졸업자 평균 추정)',
      employmentRate: '88% (Phase-1 합성 추정치)',
      sources: ['CAREERNET', 'GOYONG24']
    },
    sources: createSyntheticSourceStatus(),
    meta: {
      canonicalSlug: 'data-science-major',
      title: '데이터사이언스학과 - CareerWiki Phase-1 샘플',
      description: '데이터 기반 문제 해결 전문가를 양성하는 데이터사이언스학과 합성 샘플 전공 페이지입니다.',
      updatedAt: '2024-09-23',
      keywords: ['데이터사이언스학과', 'AI 학과', '머신러닝 교육', '데이터 거버넌스']
    }
  }
}

interface SampleIndexResult<TEntry> {
  list: TEntry[]
  map: Map<string, TEntry>
}

const buildSampleIndex = <TEntry extends { slug: string; profile: { id: string; name: string }; meta: SampleMeta }>(
  type: 'job' | 'major',
  seed: Record<string, TEntry>
): SampleIndexResult<TEntry> => {
  const list: TEntry[] = []
  const map = new Map<string, TEntry>()

  Object.entries(seed).forEach(([key, value]) => {
    const canonicalSlug = composeDetailSlug(type, value.profile.name, value.profile.id)
    const normalizedEntry = {
      ...value,
      slug: canonicalSlug,
      meta: {
        ...value.meta,
        canonicalSlug: value.meta?.canonicalSlug ?? canonicalSlug
      }
    } as TEntry

    list.push(normalizedEntry)

    const aliases = new Set<string>()
    ;[
      key,
      value.slug,
      value.meta?.canonicalSlug,
      canonicalSlug,
      normalizedEntry.slug,
      normalizedEntry.meta?.canonicalSlug,
      value.profile.id
    ].forEach((alias) => {
      if (alias && typeof alias === 'string') {
        aliases.add(alias)
      }
    })

    aliases.forEach((alias) => {
      map.set(alias, normalizedEntry)
      map.set(alias.toLowerCase(), normalizedEntry)
    })
  })

  return { list, map }
}

const { list: jobSampleList, map: jobSampleMap } = buildSampleIndex('job', jobSampleSeed)
const { list: majorSampleList, map: majorSampleMap } = buildSampleIndex('major', majorSampleSeed)

const findSampleEntry = <TEntry>(type: 'job' | 'major', map: Map<string, TEntry>, slug: string): TEntry | null => {
  if (!slug) return null

  const direct = map.get(slug) ?? map.get(slug.toLowerCase())
  if (direct) {
    return direct
  }

  const resolved = resolveDetailIdFromSlug(type, slug)
  if (resolved && resolved !== slug) {
    return map.get(resolved) ?? map.get(resolved.toLowerCase()) ?? null
  }

  return null
}

const howtoSamples: Record<string, SampleHowtoEntry> = {
  'seo-growth-playbook': {
    slug: 'seo-growth-playbook',
    title: '법무법인 SEO 성장 플레이북',
    snippet: '법무법인 핵심 키워드 SERP 1~2위를 목표로 6주 안에 문의량과 ROAS를 끌어올리는 실행 가이드',
    keywords: ['SEO', '법무법인 마케팅', 'SERP 1위', '콘텐츠 전략', 'Growth'],
    tags: ['SEO', '법률마케팅', 'Growth 전략'],
    guide: {
      slug: 'seo-growth-playbook',
      title: '법무법인 SEO 성장 플레이북',
      heroIcon: 'fa-chart-line',
      thumbnailUrl: 'https://images.unsplash.com/photo-1460925895917-afdab827c52f?w=800&h=450&fit=crop',
      authorName: '운영자',
      summary: '법무법인 핵심 키워드에 대해 SERP 1~2위를 달성하고, 전화·상담 문의량을 3배 이상 끌어올린 실제 Growth 실험 구조를 재현한 샘플 HowTo입니다.',
      tags: ['SEO', '법률마케팅', 'Growth 전략'],
      updatedAt: '2024-09-20',
      estimatedDuration: '6주 실행 로드맵',
      difficulty: '중급 (인하우스 마케터 기준)',
      audience: '법무법인·전문서비스 Growth 팀, 에이전시 리더',
      prerequisites: ['GA4 또는 로그 분석 환경 구축', '키워드 리서치 툴 접근 권한', '콘텐츠 제작 인력 또는 외주 파트너'],
      keyMetrics: [
        { label: '목표 SERP', value: '핵심 키워드 1~2위', hint: '브랜드 + 상업 키워드 조합' },
        { label: '문의량', value: '기준 대비 3배', hint: '유입 채널 믹스 기준' },
        { label: 'ROAS', value: '기준 대비 200%', hint: 'Paid + Organic 합산' }
      ],
      steps: [
        {
          id: 'diagnosis',
          title: '1. 현황 진단 (Week 0)',
          description: 'GA4/서치콘솔 로그를 기반으로 유입 키워드, 전환률, FAQ 패턴을 점검하고, 경쟁 로펌의 SERP 포지션을 분석합니다.',
          keyActions: ['주요 키워드 25개 SERP 위치 기록', '문의 폼/콜로그 전환률 확인', '콘텐츠 톤 & CTA 맵핑'],
          expectedOutcome: '현재 SEO 퍼널 병목과 빠르게 대응할 기회를 확인'
        },
        {
          id: 'alignment',
          title: '2. 전략 정렬 (Week 1)',
          description: '경영진·변호사 파트너와 핵심 서비스 영역을 정의하고, 카테고리/지역 기반 우선순위를 확정합니다.',
          keyActions: ['USP/차별화 포인트 정리', 'FAQ 인터뷰 정리', '콘텐츠 캘린더 초안 합의'],
          expectedOutcome: '비즈니스 목표와 콘텐츠 실험 방향의 정렬'
        },
        {
          id: 'execution',
          title: '3. 실행 & 실험 (Week 2-5)',
          description: '스키마 마크업, FAQ 콘텐츠, 지역 랜딩 페이지를 제작하고, 내부 링크·CTA 최적화를 반복합니다.',
          keyActions: ['콘텐츠 12편 제작 및 업로드', 'FAQ 구조화 데이터 적용', '전화 CTA AB 테스트 실행'],
          expectedOutcome: '유기적 유입 증가와 컨버전 개선 지표 확보'
        },
        {
          id: 'scale',
          title: '4. 측정 & 확장 (Week 6)',
          description: 'SERP, 문의량, ROAS를 측정해 성과를 보고하고, 높은 기여도를 보인 실험을 확장합니다.',
          keyActions: ['SERP 위치 비교 리포트 작성', 'ROAS/CPA 비교', 'B2B 파트너십 또는 PR 확장안 도출'],
          expectedOutcome: '재투자 우선순위와 차기 실험 로드맵 마련'
        }
      ],
      checkpoints: [
        { title: 'SERP Health Check', description: 'GA4/서치콘솔 지표가 목표 궤도를 타고 있는지 주간 점검' },
        { title: '콘텐츠 QA', description: '법률 자문 위험 요소(광고법·표현 규제)를 주차별로 검토' }
      ],
      resources: [
        { label: '키워드 리서치 템플릿 (Notion)', url: 'https://example.org/templates/seo-keyword', description: '로펌 전용 키워드 분류 템플릿' },
        { label: 'SERP 추적용 Data Studio', url: 'https://example.org/datastudio/serp', description: '주요 키워드 SERP 변화 대시보드' },
        { label: '법률광고 심의 체크리스트', url: 'https://example.org/legal-ad-checklist', description: '법률광고 협회 심의 기준 정리' }
      ],
      nextActions: [
        {
          label: '그로스 마케팅 디렉터 역할 살펴보기',
          description: 'SEO 전략을 총괄하는 리더 역할과 필요한 역량을 확인합니다.',
          href: '/job/growth-marketing-director',
          type: 'job'
        },
        {
          label: '디지털마케팅학과 커리큘럼 보기',
          description: '데이터 기반 마케터를 양성하는 전공 과목 구성을 확인합니다.',
          href: '/major/digital-marketing-major',
          type: 'major'
        }
      ],
      telemetryId: 'seo-growth-playbook',
      seo: {
        title: '법무법인 SEO 성장 플레이북 - CareerWiki HowTo 샘플',
        description: 'CareerWiki Phase-1 샘플 HowTo로, 법무법인 핵심 키워드 SERP 1~2위 달성을 위한 6주 Growth 로드맵을 제공합니다.',
        canonicalSlug: 'seo-growth-playbook'
      },
      sampleNote: 'Phase-1 합성 데이터 (CareerNet/고용24 가이드라인 기반)',
      ctaLinks: [
        { label: 'AI 커리어 분석 실행', href: '/analyzer?from=howto-seo', type: 'ai' },
        { label: 'HowTo 전체 목록', href: '/howto', type: 'external' }
      ]
    },
    meta: {
      canonicalSlug: 'seo-growth-playbook',
      title: '법무법인 SEO 성장 플레이북 - CareerWiki Phase-1 샘플',
      description: '법무법인 핵심 키워드 SERP 상위권 달성을 위한 6주 그로스 실행 가이드를 샘플로 제공합니다.',
      updatedAt: '2024-09-20',
      keywords: ['법무법인 SEO', 'Growth 마케팅 플레이북', 'SERP 상위 노출']
    }
  },
  'ai-product-roadmap': {
    slug: 'ai-product-roadmap',
    title: 'AI 프로덕트 로드맵 스프린트',
    snippet: 'AI 기능 실험을 6주 내 설계·검증하고 Responsible AI 기준을 통과시키는 실행 가이드',
    keywords: ['AI 제품 전략', 'Responsible AI', 'MLOps', '프로덕트 실험', '데이터 거버넌스'],
    tags: ['AI 전략', '프로덕트', 'Responsible AI'],
    guide: {
      slug: 'ai-product-roadmap',
      title: 'AI 프로덕트 로드맵 스프린트',
      heroIcon: 'fa-robot',
      thumbnailUrl: 'https://images.unsplash.com/photo-1677442136019-21780ecad995?w=800&h=450&fit=crop',
      authorName: '운영자',
      summary: '생성형 AI 기능을 제품 로드맵에 반영할 때 필요한 전략 정렬, 실험 설계, 책임 있는 출시 절차를 정리한 Phase 1 샘플 HowTo입니다.',
      tags: ['AI 전략', '프로덕트', 'Responsible AI'],
      updatedAt: '2024-09-25',
      estimatedDuration: '6주 실행 로드맵',
      difficulty: '상급 (프로덕트/데이터 리더 기준)',
      audience: 'AI 제품을 운영하는 프로덕트 매니저, 데이터 리더, 전략 조직',
      prerequisites: ['프로덕트 로드맵 수립 경험', '데이터 인프라 접근 권한', 'AI 윤리 가이드라인 초안'],
      keyMetrics: [
        { label: '모델 실험 성과', value: '주요 KPI +15%', hint: '전환율·리텐션 등 제품 지표' },
        { label: 'Responsible AI 체크', value: '100% 충족', hint: '데이터 개인정보·바이어스 점검' },
        { label: '실험 속도', value: '6주 내 MVP 런칭', hint: '아이디어→출시 리드타임 축소' }
      ],
      steps: [
        {
          id: 'vision',
          title: '1. 비전 정렬 (Week 0-1)',
          description: '경영진, 데이터, 법무 조직과 제품 비전을 정렬하고 AI 적용 범위를 정의합니다.',
          keyActions: ['제품 KPI 및 AI 적용 가설 정리', '법무·윤리 담당자와 리스크 워크샵', 'AI 거버넌스 체크리스트 확정'],
          expectedOutcome: 'AI 적용 범위와 성공 지표에 대한 조직 합의'
        },
        {
          id: 'experiment',
          title: '2. 실험 설계 (Week 2-3)',
          description: '데이터 세트, 모델 선택, 오프라인/온라인 실험 구조를 설계하고 모니터링 지표를 선정합니다.',
          keyActions: ['샘플 데이터 정제', 'MVP 모델/프롬프트 설계', 'A/B 실험 및 샌드박스 환경 구성'],
          expectedOutcome: '실험 가능한 MVP와 측정 가능한 KPI 확보'
        },
        {
          id: 'launch',
          title: '3. 제한적 출시 (Week 4)',
          description: '베타 고객에게 기능을 제한적 공개하고 Responsible AI 기준을 통과했는지 검증합니다.',
          keyActions: ['베타 고객 온보딩', '경고/투명성 메시지 UX 점검', '실시간 품질 모니터링 대시보드 구축'],
          expectedOutcome: '안전한 제한적 출시와 초기 피드백 확보'
        },
        {
          id: 'scale',
          title: '4. 학습 & 확장 (Week 5-6)',
          description: '실험 결과를 분석해 모델 개선/운영 전략을 결정하고 재사용 가능한 운영 문서를 정리합니다.',
          keyActions: ['실험 결과 리뷰 세션', '모델 개선 Backlog 정리', '운영 핸드북·알림 정책 업데이트'],
          expectedOutcome: '확장 가능한 AI 운영 프로세스와 반복 가능한 학습 사이클'
        }
      ],
      checkpoints: [
        { title: 'Responsible AI Gate', description: '모델 투명성, 개인정보, 바이어스 점검 체크리스트 통과 여부' },
        { title: '실험 성과 리뷰', description: '주요 KPI 변화와 고객 피드백을 기반으로 다음 스프린트 결정' }
      ],
      resources: [
        { label: 'Responsible AI 체크리스트', url: 'https://example.org/rai-checklist', description: 'AI 윤리/거버넌스 점검 표준' },
        { label: 'MLOps 파이프라인 캔버스', url: 'https://example.org/mlops-canvas', description: '모델 실험과 배포 설계를 돕는 프레임워크' },
        { label: 'AI 실험 로드맵 템플릿', url: 'https://example.org/ai-roadmap', description: '6주 스프린트 일정 템플릿' }
      ],
      nextActions: [
        {
          label: 'AI 프로덕트 전략가 직업 살펴보기',
          description: 'AI 기능을 책임지고 기획·출시하는 역할의 핵심 역량을 확인합니다.',
          href: '/job/ai-product-strategist',
          type: 'job'
        },
        {
          label: '데이터사이언스학과 커리큘럼 보기',
          description: 'AI 프로덕트 팀과 협업할 데이터 전문가 양성 과정을 확인합니다.',
          href: '/major/data-science-major',
          type: 'major'
        }
      ],
      telemetryId: 'ai-product-roadmap',
      seo: {
        title: 'AI 프로덕트 로드맵 스프린트 - CareerWiki HowTo 샘플',
        description: 'AI 기능 실험을 6주 만에 설계·검증하고 Responsible AI 기준을 통과시키는 실행 가이드입니다.',
        canonicalSlug: 'ai-product-roadmap'
      },
      sampleNote: 'Phase-1 합성 데이터 (CareerNet/고용24 직무 가이드라인 기반)',
      ctaLinks: [
        { label: 'AI 커리어 분석 실행', href: '/analyzer?from=howto-ai-product', type: 'ai' },
        { label: '위키에서 관련 직업 보기', href: '/job/ai-product-strategist', type: 'job' }
      ]
    },
    meta: {
      canonicalSlug: 'ai-product-roadmap',
      title: 'AI 프로덕트 로드맵 스프린트 - CareerWiki Phase-1 샘플',
      description: 'Responsible AI 기준과 실험 속도를 동시에 확보하는 AI 프로덕트 로드맵 실행 가이드 샘플입니다.',
      updatedAt: '2024-09-25',
      keywords: ['AI 프로덕트', 'Responsible AI', 'MLOps', 'AI 전략', '프로덕트 로드맵']
    }
  },
  '로스쿨-들어가는-법-–-현실적인-준비-로드맵': {
    slug: '로스쿨-들어가는-법-–-현실적인-준비-로드맵',
    title: '로스쿨 들어가는 법 – 현실적인 준비 로드맵',
    snippet: 'LEET 언어이해·추리논증·논술부터 자기소개서·면접까지, 로스쿨 입학을 위한 단계별 실전 가이드',
    keywords: ['로스쿨', 'LEET', '법학적성시험', '로스쿨 입시', '법조인', '언어이해', '추리논증', '논술', '로스쿨 자기소개서', '로스쿨 면접'],
    tags: ['로스쿨', '입시 준비', 'LEET', '법조인'],
    guide: {
      slug: '로스쿨-들어가는-법-–-현실적인-준비-로드맵',
      title: '로스쿨 들어가는 법 – 현실적인 준비 로드맵',
      heroIcon: 'fa-gavel',
      summary: '한국 로스쿨 입학을 위한 실전 가이드입니다. LEET(법학적성시험) 언어이해·추리논증·논술 영역별 공부법부터 학부 성적, 영어, 자기소개서, 면접까지 단계별로 정리했습니다. 입시 타임라인과 6개월 실천 플랜을 포함해 수험생이 바로 실행할 수 있는 구체적인 전략을 제공합니다.',
      tags: ['로스쿨', '입시 준비', 'LEET', '법조인'],
      updatedAt: '2025-01-06',
      estimatedDuration: '6개월~1년 준비 기간',
      difficulty: '중상급 (대학 졸업 예정자 또는 졸업생 기준)',
      audience: '로스쿨 입학을 준비하는 대학생·졸업생, 법조인을 꿈꾸는 수험생',
      prerequisites: ['4년제 학사학위 또는 동등 학력', 'LEET 시험 응시 계획', '공인 영어 성적 취득 계획', '학부 성적 관리 가능'],
      keyMetrics: [
        { label: 'LEET 성적', value: '언어이해·추리논증·논술', hint: '학교별 반영 비율 상이' },
        { label: '학부 성적', value: 'GPA', hint: '상위권 로스쿨일수록 비중 큼' },
        { label: '영어 성적', value: 'TOEIC/TOEFL/TEPS', hint: '학교별 최저 기준 상이' },
        { label: '서류 평가', value: '자기소개서·추천서·경력', hint: '일관된 스토리 중요' },
        { label: '면접', value: '인성·사고력·커뮤니케이션', hint: '최종 합격 결정 요소' }
      ],
      steps: [
        {
          id: 'overview',
          title: '한눈에 보기: 로스쿨 입학 체크리스트',
          description: '로스쿨 입학에 필요한 기본 요건을 확인합니다. 4년제 학사학위, 해당 연도 LEET 성적, 공인 영어 성적, 학부 성적(GPA), 자기소개서·추천서·경력·봉사활동 등 서류, 면접 준비가 필요합니다. 매년 9월쯤 진행되는 정시 모집에서 가·나군 각 1개교씩 최대 2곳에 지원할 수 있습니다.',
          keyActions: [
            '4년제 학사학위 또는 동등 학력 확인',
            'LEET 시험 일정 확인 (매년 7월경)',
            '공인 영어 성적 유효기간 확인 (보통 2년)',
            '학부 성적(GPA) 현황 점검',
            '가·나군 지원 전략 수립'
          ],
          expectedOutcome: '로스쿨 입학에 필요한 기본 요건과 일정을 파악하고 준비 계획 수립'
        },
        {
          id: 'system-understanding',
          title: '한국 로스쿨 제도와 입시 구조 이해하기',
          description: '로스쿨 입학 기본 자격(4년제 학사학위, LEET 성적, 공인 영어 성적)을 확인하고, 일반전형과 특별전형(저소득층, 장애인, 지방인재 등)의 차이를 이해합니다. 정시 모집의 가·나군 구조를 파악해 지원 전략을 수립합니다.',
          keyActions: [
            '법학전문대학원협의회(akls.kr) 공지 확인',
            '목표 로스쿨별 모집요강 검토',
            '일반전형 vs 특별전형 자격 확인',
            '가·나군 지원 조합 계획'
          ],
          expectedOutcome: '로스쿨 입시 제도와 전형 구조를 완전히 이해하고 자신의 지원 전략 수립'
        },
        {
          id: 'timeline',
          title: '입시 타임라인: 언제 무엇을 준비할까?',
          description: '매년 비슷한 흐름을 따르는 입시 일정을 확인합니다. 3~4월 기본계획 공고, 7월 LEET 시험, 8월 성적 발표, 9월 원서 접수, 11월 면접, 12월 합격자 발표 순서로 진행됩니다. 각 단계별 준비 사항을 미리 파악해 시간을 효율적으로 사용합니다.',
          keyActions: [
            '3~4월: 다음 학년도 입학전형 기본계획 확인',
            '7월: LEET 시험 응시',
            '8월: LEET 성적 확인 및 지원 전략 재조정',
            '9월: 원서 접수 (가·나군 각 1개교)',
            '11월: 면접 준비 및 참여',
            '12월: 합격자 발표 확인'
          ],
          expectedOutcome: '입시 일정에 맞춰 체계적으로 준비할 수 있는 타임라인 확보'
        },
        {
          id: 'evaluation-factors',
          title: '로스쿨 합격을 결정짓는 5대 요소',
          description: '학교마다 비율은 다르지만, LEET 성적(언어이해·추리논증·논술), 학부 성적(GPA), 공인 영어 성적, 서류(자기소개서, 학업계획서, 추천서, 경력·봉사·동아리 등), 면접(인성, 법학적 사고력, 상황 대응력)이 종합평가에 반영됩니다. 이 중 LEET는 수험생이 가장 궁금해하는 영역으로, 실질적인 준비 전략이 중요합니다.',
          keyActions: [
            '목표 로스쿨별 반영 비율 확인',
            'LEET 성적 목표 백분위 설정',
            'GPA 현황 점검 및 개선 방안 수립',
            '영어 성적 목표 점수 설정',
            '서류 및 면접 준비 계획 수립'
          ],
          expectedOutcome: '5대 평가 요소별 목표와 준비 계획을 명확히 수립'
        },
        {
          id: 'leet-preparation',
          title: 'LEET 완전 정리: 언어이해·추리논증·논술',
          description: '법학적성시험(LEET)의 세 영역을 체계적으로 준비합니다. 언어이해는 긴 지문을 읽고 논지·구조·전제·결론을 파악하는 비판적 독해 능력을 측정합니다. 추리논증은 논리 구조 파악과 조건 조합을 통한 결론 도출 능력을 평가합니다. 논술은 제시문 분석 후 문제 상황 정리, 쟁점 도출, 논거 제시, 자기 입장 정리를 논리적으로 서술하는 능력을 측정합니다.',
          keyActions: [
            '언어이해: 비문학 독해 루틴 만들기 (매일 2~3개 지문)',
            '언어이해: 최근 5개년 기출 분석 및 틀린 선지 패턴 수집',
            '추리논증: 형식 논리 기초 정리 (명제, 조건문, 논리적 동치 등)',
            '추리논증: 조건 정리 연습 (표/도식 활용)',
            '논술: 템플릿(틀) 확정 및 구조화된 글쓰기 연습',
            '논술: 기출 답안 베껴 쓰기 + 재작성 연습',
            '전 영역: 시간 관리 훈련 (모의고사 형태)'
          ],
          expectedOutcome: 'LEET 세 영역별 체계적인 공부법을 습득하고 실전 대비 완료'
        },
        {
          id: 'specs-preparation',
          title: '학부 성적·영어·비교과: "스펙"은 어떻게 챙길까?',
          description: '학부 성적(GPA)은 상위권 로스쿨일수록 비중이 큽니다. 재학생은 전공·교양 가리지 않고 성적 관리에 집중하고, 졸업생은 LEET·논술·서류·면접에서 만회 전략을 수립합니다. 영어 성적은 학교별로 인정 시험 종류와 최저 기준이 다르므로, 입시 기준 1년 전까지 목표 학교 리스트를 정하고 공통 인정 시험에 집중합니다. 비교과 활동은 단순히 "많이"가 아니라 "일관된 스토리"가 중요합니다.',
          keyActions: [
            'GPA 현황 점검 및 개선 방안 수립 (재학생)',
            '영어 성적 목표 학교별 최저 기준 확인',
            '공통 인정 시험 1~2개 선정 및 집중 준비',
            '법 관련 활동 정리 (법학 강의, 모의재판, 로스쿨 튜터링 등)',
            '사회·인권·공익 관련 활동 정리 (봉사, 인권 동아리, NGO 인턴 등)',
            '연구·프로젝트 경험 정리 (학부 논문, 프로젝트, 대회 수상 등)',
            '일관된 스토리 라인 구축 (예: 노동인권 관심 → 관련 수업 + 인턴 + 봉사 → 노동법 전공 희망)'
          ],
          expectedOutcome: '학부 성적, 영어, 비교과 활동을 체계적으로 준비하고 일관된 스토리 구축'
        },
        {
          id: 'essay-interview',
          title: '자기소개서·면접: 일관된 스토리 구축하기',
          description: '자기소개서는 "왜 법조인이 되고 싶은가?", "어떤 경험이 법학·법조에 대한 관심으로 이어졌는가?", "로스쿨에서 어떤 분야를 공부하고 싶은가?", "졸업 이후 진로 계획은 무엇인가?" 등의 질문에 정확히 답하는 글이어야 합니다. 사건 중심으로 서술하고, LEET·성적과 연결해 행동 증거를 함께 적는 것이 좋습니다. 면접은 인성·동기 면접, 사례·시사 면접, 집단토론/발표형 면접 등이 있으며, 최근 법·사회 이슈 정리와 모의 면접 연습이 중요합니다.',
          keyActions: [
            '자기소개서 문항을 키워드로 쪼개기',
            '사건 중심 서술 구조 작성 (어려운 상황 → 행동 → 결과 → 배운 점)',
            'LEET·성적과 연결된 행동 증거 포함',
            '최근 법·사회 이슈 정리 (노동, 인권, 환경, 기술과 법 등)',
            '모의 면접 녹화 및 피드백 수집',
            '"모른다"고 말하는 연습 (억지 아는 척 지양)'
          ],
          expectedOutcome: '일관된 스토리를 담은 자기소개서 완성 및 면접 대비 완료'
        },
        {
          id: 'school-selection',
          title: '학교 선택 & 지원 전략',
          description: '각 로스쿨 홈페이지의 입시 결과/통계와 FAQ를 확인해 합격자 평균 스펙, 반영 비율, 면접 방식을 파악합니다. LEET 예상 백분위, GPA, 영어, 비교과를 기준으로 도전/적정/안정 지원 조합을 가·나군에 나눠 배치합니다. 합격 가능성뿐만 아니라 관심 분야 교수진, 지역, 졸업 후 진로망도 고려해 선택하는 것이 장기적으로 유리합니다.',
          keyActions: [
            '목표 로스쿨별 입시 결과/통계 확인',
            '합격자 평균 스펙, 반영 비율, 면접 방식 파악',
            'LEET 예상 백분위 + GPA + 영어 + 비교과 기준으로 지원 조합 수립',
            '도전/적정/안정 조합을 가·나군에 배치',
            '관심 분야 교수진, 지역, 졸업 후 진로망 고려'
          ],
          expectedOutcome: '자신의 스펙에 맞는 최적의 지원 전략 수립'
        },
        {
          id: 'action-plan',
          title: '로스쿨 준비, 이렇게 시작해 보자 (실천용 6개월 플랜 예시)',
          description: 'LEET까지 6~9개월 남았다는 가정 하에 구체적인 실행 플랜을 수립합니다. 1~2개월차에는 LEET 기출 훑어보기와 기본 개념 학습, 3~4개월차에는 최근 5개년 기출 본격 분석과 논술 템플릿 확정, 5~6개월차에는 실전 모의고사와 자기소개서 초안 작성, LEET 이후~원서 접수 전에는 결과 반영 전략 재조정과 면접 대비를 진행합니다.',
          keyActions: [
            '1~2개월차: LEET 기출 2~3개년 훑어보기, 기본 개념 인강/교재 한 바퀴, 비문학·논리 문제 매일 1~2세트',
            '3~4개월차: 최근 5개년 기출 본격 분석, 논술 템플릿 확정 + 주 1회 글쓰기, 영어 성적 미달 시 집중 응시',
            '5~6개월차: 주 2~3회 실전 모의고사, 취약 영역 유형별 보완, 자기소개서 초안 작성 & 활동 정리',
            'LEET 이후~원서 접수 전: LEET 결과 반영해 지원 전략 재조정, 자기소개서/추천서 완성, 면접 대비 스터디 시작'
          ],
          expectedOutcome: '6개월 단위로 구체화된 실행 가능한 준비 플랜 확보'
        },
        {
          id: 'faq',
          title: '자주 묻는 질문',
          description: '로스쿨 준비 시기(대학교 몇 학년부터), 법대 비전공자 지원 가능 여부, LEET 재도전 의미, 가장 중요한 준비 요소 등 수험생이 자주 묻는 질문에 대한 답변을 정리했습니다.',
          keyActions: [
            '로스쿨 준비는 대학교 몇 학년부터 시작하는 게 좋나요? 이상적으로는 2학년 말~3학년 초부터 학점 관리, 영어 성적, 법·사회 관련 활동을 조금씩 준비하는 것이 좋습니다.',
            '법대가 아니어도 로스쿨에 갈 수 있나요? 가능합니다. 로스쿨 제도 자체가 다양한 전공자를 받아들이는 것을 목표로 설계되었습니다. 다만 기초 법학 과목을 교양 수업이나 독학으로 익혀두면 도움이 됩니다.',
            'LEET 점수가 안 나왔는데, 재도전이 의미 있을까요? LEET는 연습량에 비례해 점수가 오르기 쉬운 시험입니다. 언어이해의 오독 패턴 수정, 추리논증의 조건 정리 스킬 향상, 논술의 구조화된 글쓰기 습관을 체계적으로 교정하면 1년 사이에 상당한 점수 상승이 가능합니다.',
            '로스쿨 준비하면서 가장 중요한 한 가지를 꼽는다면? "일관된 스토리"입니다. LEET, 성적, 활동, 자기소개서, 면접에서 모두 "왜 법조인이 되고 싶은지", "어떤 분야의 문제를 해결하고 싶은지"가 같은 방향을 가리킬수록 입학사정관 입장에서는 그 지원자를 더 신뢰하게 됩니다.'
          ],
          expectedOutcome: '자주 묻는 질문에 대한 명확한 답변을 통해 수험생의 궁금증 해소'
        }
      ],
      checkpoints: [
        { title: '3~4월 입학전형 기본계획 확인', description: '법학전문대학원협의회 및 각 로스쿨 홈페이지에서 최신 요강 확인' },
        { title: '7월 LEET 시험 응시', description: 'LEET 시험 준비 완료 여부 점검 및 시험 응시' },
        { title: '8월 LEET 성적 확인', description: 'LEET 성적 발표 후 지원 전략 재조정' },
        { title: '9월 원서 접수', description: '가·나군 각 1개교씩 원서 접수 완료' },
        { title: '11월 면접 준비', description: '면접 대비 스터디 및 모의 면접 완료' },
        { title: '12월 합격자 발표', description: '최종 합격 여부 확인 및 등록 절차 진행' }
      ],
      resources: [
        { label: '법학전문대학원협의회', url: 'https://akls.kr/', description: '로스쿨 입시 일정 및 공지사항 확인' },
        { label: '로스쿨타임즈', url: 'https://www.lawschooltimes.com/', description: '로스쿨 입시 정보 및 합격자 인터뷰' },
        { label: 'LEET 기출 문제집', url: 'https://example.org/leet-past-exams', description: '최근 5개년 LEET 기출 문제 및 해설' },
        { label: '로스쿨 자기소개서 작성 가이드', url: 'https://example.org/lawschool-essay-guide', description: '자기소개서 문항별 작성 팁 및 예시' },
        { label: '로스쿨 면접 준비 자료', url: 'https://example.org/lawschool-interview-prep', description: '면접 유형별 대비 방법 및 최근 법·사회 이슈 정리' }
      ],
      nextActions: [
        {
          label: '변호사 직업 살펴보기',
          description: '로스쿨 졸업 후 변호사가 되기까지의 과정과 필요한 역량을 확인합니다.',
          href: '/job/변호사',
          type: 'job'
        },
        {
          label: '법학과 전공 정보 보기',
          description: '법학 전공 커리큘럼과 로스쿨 진학에 도움이 되는 학부 과정을 확인합니다.',
          href: '/major/법학과',
          type: 'major'
        }
      ],
      telemetryId: 'lawschool-admission-guide',
      seo: {
        title: '로스쿨 들어가는 법 – 현실적인 준비 로드맵 - CareerWiki HowTo',
        description: '한국 로스쿨 입학을 위한 실전 가이드. LEET 언어이해·추리논증·논술 공부법부터 학부 성적, 영어, 자기소개서, 면접까지 단계별 준비 전략을 제공합니다.',
        canonicalSlug: '로스쿨-들어가는-법-–-현실적인-준비-로드맵'
      },
      sampleNote: 'Phase-1 합성 데이터 (로스쿨타임즈, 법학전문대학원협의회 가이드라인 기반)',
      ctaLinks: [
        { label: 'AI 커리어 분석 실행', href: '/analyzer?from=howto-lawschool', type: 'ai' },
        { label: '변호사 직업 상세 보기', href: '/job/변호사', type: 'job' },
        { label: 'HowTo 전체 목록', href: '/howto', type: 'external' }
      ]
    },
    meta: {
      canonicalSlug: '로스쿨-들어가는-법-–-현실적인-준비-로드맵',
      title: '로스쿨 들어가는 법 – 현실적인 준비 로드맵 - CareerWiki Phase-1 샘플',
      description: 'LEET 언어이해·추리논증·논술부터 자기소개서·면접까지, 로스쿨 입학을 위한 단계별 실전 가이드를 샘플로 제공합니다.',
      updatedAt: '2025-01-06',
      keywords: ['로스쿨', 'LEET', '법학적성시험', '로스쿨 입시', '법조인', '언어이해', '추리논증', '논술', '로스쿨 자기소개서', '로스쿨 면접']
    }
  }
}

export const getSampleJobDetail = (slug: string): SampleJobEntry | null =>
  findSampleEntry('job', jobSampleMap, slug)
export const getSampleMajorDetail = (slug: string): SampleMajorEntry | null =>
  findSampleEntry('major', majorSampleMap, slug)
export const getSampleHowtoGuide = (slug: string): SampleHowtoEntry | null => howtoSamples[slug] ?? null

export const listSampleJobSummaries = (): SampleSearchItem[] =>
  jobSampleList.map(({ slug, title, snippet, keywords }) => ({ slug, title, snippet, keywords }))

export const listSampleMajorSummaries = (): SampleSearchItem[] =>
  majorSampleList.map(({ slug, title, snippet, keywords }) => ({ slug, title, snippet, keywords }))

export const listSampleHowtoSummaries = (): Array<SampleSearchItem & { 
  tags: string[]
  thumbnailUrl?: string
  authorName?: string
  authorPictureUrl?: string | null
  updatedAt: string
}> =>
  Object.values(howtoSamples).map(({ slug, title, snippet, keywords, tags, guide }) => ({ 
    slug, 
    title, 
    snippet, 
    keywords, 
    tags,
    thumbnailUrl: guide.thumbnailUrl,
    authorName: guide.authorName,
    authorPictureUrl: null,
    updatedAt: guide.updatedAt
  }))

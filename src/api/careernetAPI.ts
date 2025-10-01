/**
 * CareerNet API Client
 * 한국교육개발원 진로정보망 커리어넷의 오픈API를 활용한 학과/직업 정보 연동
 * https://www.career.go.kr/cnet/front/openapi/
 */

// API 키 (실제 배포 시 환경변수로 관리)
// 아래 키는 예시입니다. 실제 키는 career.go.kr에서 발급받아야 합니다.
const CAREER_NET_API_KEY = process.env.CAREER_NET_API_KEY || 'YOUR_API_KEY_HERE';

// Base URL
const API_BASE_URL = 'https://www.career.go.kr/cnet/openapi';

// API 응답 타입 정의
interface CareerNetResponse<T> {
  content?: T[];
  dataSearch?: {
    content?: T[];
    totalCount?: number;
  };
  error?: string;
}

// 학과정보 타입
export interface Major {
  majorSeq: string;        // 학과 코드
  major: string;           // 학과명
  summary: string;         // 학과 소개
  university?: string;     // 대학명 (리스트)
  department?: string;     // 학과 계열
  salaryAfterGraduation?: string;  // 졸업 후 평균 연봉
  employmentRate?: string; // 취업률
  relatedJob?: string;     // 관련 직업
  aptitude?: string;       // 적성 유형
}

// 직업정보 타입
export interface Job {
  jobdicSeq: string;       // 직업 코드
  jobName: string;         // 직업명
  summary: string;         // 직업 소개
  aptdType?: string;       // 적성유형
  jobCategoryName?: string; // 직업 분류
  avgSalary?: string;      // 평균 연봉
  salaryRange?: string;    // 연봉 범위
  jobOutlook?: string;     // 직업 전망
  relatedMajor?: string;   // 관련 학과
  requiredEducation?: string; // 요구 학력
  requiredCertification?: string; // 필요 자격증
  employmentTrend?: string; // 고용 동향
}

// API 검색 파라미터
export interface SearchParams {
  keyword?: string;        // 검색어
  thisPage?: number;       // 현재 페이지
  perPage?: number;        // 페이지당 결과 수
  category?: string;       // 카테고리 코드
  gubun?: string;          // 구분
}

// 학과 정보 검색
export async function searchMajors(params: SearchParams): Promise<Major[]> {
  try {
    const url = new URL(`${API_BASE_URL}/getOpenApi.json`);
    url.searchParams.append('apiKey', CAREER_NET_API_KEY);
    url.searchParams.append('svcType', 'api');
    url.searchParams.append('svcCode', 'MAJOR');
    url.searchParams.append('gubun', params.gubun || '대학');
    
    if (params.keyword) {
      url.searchParams.append('searchTitle', params.keyword);
    }
    if (params.thisPage) {
      url.searchParams.append('thisPage', params.thisPage.toString());
    }
    if (params.perPage) {
      url.searchParams.append('perPage', params.perPage.toString());
    }
    
    const response = await fetch(url.toString());
    
    if (!response.ok) {
      throw new Error(`API 요청 실패: ${response.statusText}`);
    }
    
    const data: CareerNetResponse<Major> = await response.json();
    
    if (data.error) {
      throw new Error(data.error);
    }
    
    // 응답 구조에 따라 데이터 추출
    const majors = data.dataSearch?.content || data.content || [];
    
    return majors;
  } catch (error) {
    console.error('학과정보 검색 오류:', error);
    
    // API 키가 없을 때 더미 데이터 반환 (개발용)
    if (CAREER_NET_API_KEY === 'YOUR_API_KEY_HERE') {
      return getMockMajors(params.keyword);
    }
    
    throw error;
  }
}

// 학과 상세 정보 조회
export async function getMajorDetail(majorSeq: string): Promise<Major | null> {
  try {
    const url = new URL(`${API_BASE_URL}/getOpenApi.json`);
    url.searchParams.append('apiKey', CAREER_NET_API_KEY);
    url.searchParams.append('svcType', 'api');
    url.searchParams.append('svcCode', 'MAJOR_VIEW');
    url.searchParams.append('gubun', '대학');
    url.searchParams.append('majorSeq', majorSeq);
    
    const response = await fetch(url.toString());
    
    if (!response.ok) {
      throw new Error(`API 요청 실패: ${response.statusText}`);
    }
    
    const data: CareerNetResponse<Major> = await response.json();
    
    if (data.error) {
      throw new Error(data.error);
    }
    
    const content = data.dataSearch?.content || data.content || [];
    return content[0] || null;
  } catch (error) {
    console.error('학과 상세정보 조회 오류:', error);
    
    // API 키가 없을 때 더미 데이터 반환 (개발용)
    if (CAREER_NET_API_KEY === 'YOUR_API_KEY_HERE') {
      return getMockMajorDetail(majorSeq);
    }
    
    throw error;
  }
}

// 직업 정보 검색
export async function searchJobs(params: SearchParams): Promise<Job[]> {
  try {
    const url = new URL(`${API_BASE_URL}/getOpenApi.json`);
    url.searchParams.append('apiKey', CAREER_NET_API_KEY);
    url.searchParams.append('svcType', 'api');
    url.searchParams.append('svcCode', 'JOB');
    url.searchParams.append('gubun', params.gubun || 'job_dic_list');
    
    if (params.keyword) {
      url.searchParams.append('searchJobNm', params.keyword);
    }
    if (params.thisPage) {
      url.searchParams.append('thisPage', params.thisPage.toString());
    }
    if (params.perPage) {
      url.searchParams.append('perPage', params.perPage.toString());
    }
    if (params.category) {
      url.searchParams.append('category', params.category);
    }
    
    const response = await fetch(url.toString());
    
    if (!response.ok) {
      throw new Error(`API 요청 실패: ${response.statusText}`);
    }
    
    const data: CareerNetResponse<Job> = await response.json();
    
    if (data.error) {
      throw new Error(data.error);
    }
    
    // 응답 구조에 따라 데이터 추출
    const jobs = data.dataSearch?.content || data.content || [];
    
    return jobs;
  } catch (error) {
    console.error('직업정보 검색 오류:', error);
    
    // API 키가 없을 때 더미 데이터 반환 (개발용)
    if (CAREER_NET_API_KEY === 'YOUR_API_KEY_HERE') {
      return getMockJobs(params.keyword);
    }
    
    throw error;
  }
}

// 직업 상세 정보 조회
export async function getJobDetail(jobdicSeq: string): Promise<Job | null> {
  try {
    const url = new URL(`${API_BASE_URL}/getOpenApi.json`);
    url.searchParams.append('apiKey', CAREER_NET_API_KEY);
    url.searchParams.append('svcType', 'api');
    url.searchParams.append('svcCode', 'JOB_VIEW');
    url.searchParams.append('gubun', 'job_dic_list');
    url.searchParams.append('jobdicSeq', jobdicSeq);
    
    const response = await fetch(url.toString());
    
    if (!response.ok) {
      throw new Error(`API 요청 실패: ${response.statusText}`);
    }
    
    const data: CareerNetResponse<Job> = await response.json();
    
    if (data.error) {
      throw new Error(data.error);
    }
    
    const content = data.dataSearch?.content || data.content || [];
    return content[0] || null;
  } catch (error) {
    console.error('직업 상세정보 조회 오류:', error);
    
    // API 키가 없을 때 더미 데이터 반환 (개발용)
    if (CAREER_NET_API_KEY === 'YOUR_API_KEY_HERE') {
      return getMockJobDetail(jobdicSeq);
    }
    
    throw error;
  }
}

// 개발용 Mock 데이터 함수들
function getMockMajors(keyword?: string): Major[] {
  const mockMajors: Major[] = [
    {
      majorSeq: '1001',
      major: '컴퓨터공학과',
      summary: '컴퓨터 시스템의 소프트웨어와 하드웨어를 설계, 개발, 응용하는 학문',
      university: '서울대, KAIST, 포항공대',
      department: '공학계열',
      salaryAfterGraduation: '4,500만원',
      employmentRate: '85%',
      relatedJob: '소프트웨어개발자, 시스템엔지니어, 데이터분석가',
      aptitude: '논리적 사고, 수리력'
    },
    {
      majorSeq: '1002',
      major: '경영학과',
      summary: '기업 경영의 원리와 실무를 체계적으로 학습하는 학문',
      university: '연세대, 고려대, 성균관대',
      department: '상경계열',
      salaryAfterGraduation: '4,200만원',
      employmentRate: '78%',
      relatedJob: '경영컨설턴트, 마케터, 회계사',
      aptitude: '의사소통능력, 리더십'
    },
    {
      majorSeq: '1003',
      major: '의예과',
      summary: '인체의 구조와 기능을 연구하고 질병을 진단, 치료하는 학문',
      university: '서울대, 연세대, 가톨릭대',
      department: '의학계열',
      salaryAfterGraduation: '8,000만원',
      employmentRate: '98%',
      relatedJob: '의사, 의학연구원',
      aptitude: '생명과학 지식, 봉사정신'
    }
  ];
  
  if (keyword) {
    return mockMajors.filter(m => 
      m.major.includes(keyword) || 
      m.summary.includes(keyword) ||
      m.relatedJob?.includes(keyword)
    );
  }
  
  return mockMajors;
}

function getMockMajorDetail(majorSeq: string): Major {
  const majors = getMockMajors();
  return majors.find(m => m.majorSeq === majorSeq) || majors[0];
}

function getMockJobs(keyword?: string): Job[] {
  const mockJobs: Job[] = [
    {
      jobdicSeq: '2001',
      jobName: '소프트웨어개발자',
      summary: '컴퓨터 프로그램과 애플리케이션을 설계하고 개발하는 전문가',
      aptdType: '탐구형',
      jobCategoryName: 'IT/소프트웨어',
      avgSalary: '5,000만원',
      salaryRange: '3,500만원 ~ 1억원',
      jobOutlook: '매우 밝음',
      relatedMajor: '컴퓨터공학, 소프트웨어학, 정보통신공학',
      requiredEducation: '학사 이상',
      requiredCertification: '정보처리기사',
      employmentTrend: '상승'
    },
    {
      jobdicSeq: '2002',
      jobName: '데이터분석가',
      summary: '대량의 데이터를 수집, 분석하여 의사결정에 필요한 인사이트를 제공하는 전문가',
      aptdType: '탐구형',
      jobCategoryName: 'IT/데이터',
      avgSalary: '4,800만원',
      salaryRange: '3,800만원 ~ 8,000만원',
      jobOutlook: '매우 밝음',
      relatedMajor: '통계학, 컴퓨터공학, 산업공학',
      requiredEducation: '학사 이상',
      requiredCertification: '데이터분석전문가(ADP)',
      employmentTrend: '급상승'
    },
    {
      jobdicSeq: '2003',
      jobName: '마케팅전문가',
      summary: '시장조사와 분석을 통해 마케팅 전략을 수립하고 실행하는 전문가',
      aptdType: '기업형',
      jobCategoryName: '경영/마케팅',
      avgSalary: '4,500만원',
      salaryRange: '3,200만원 ~ 7,000만원',
      jobOutlook: '밝음',
      relatedMajor: '경영학, 마케팅, 광고홍보학',
      requiredEducation: '학사 이상',
      requiredCertification: '없음',
      employmentTrend: '안정'
    }
  ];
  
  if (keyword) {
    return mockJobs.filter(j => 
      j.jobName.includes(keyword) || 
      j.summary.includes(keyword) ||
      j.relatedMajor?.includes(keyword)
    );
  }
  
  return mockJobs;
}

function getMockJobDetail(jobdicSeq: string): Job {
  const jobs = getMockJobs();
  return jobs.find(j => j.jobdicSeq === jobdicSeq) || jobs[0];
}

// 직업 카테고리 코드
export const JOB_CATEGORIES = {
  '관리직': '100041',
  '경영·행정·사무직': '100042',
  '금융·보험관련직': '100043',
  '교육·연구관련직': '100044',
  '법률·경찰·소방·군인': '100045',
  '보건·의료관련직': '100046',
  '사회복지·종교관련직': '100047',
  '문화·예술·스포츠관련직': '100048',
  '운송·운송관련직': '100049',
  '영업·판매관련직': '100050',
  '경비·청소관련직': '100051',
  '미용·숙박·여행관련직': '100052',
  '음식서비스관련직': '100053',
  '건설관련직': '100054',
  '기계관련직': '100055',
  '재료관련직': '100056',
  '화학·환경관련직': '100057',
  '섬유·의복관련직': '100058',
  '전기·전자관련직': '100059',
  '정보통신관련직': '100060',
  '농림어업관련직': '100061'
};

// 적성유형 코드
export const APTITUDE_TYPES = {
  'IT관련전문직': '104740',
  '공학전문직': '104729',
  '웹·게임·애니메이션관련직': '104733',
  '과학전문직': '104728',
  '의료·보건관련직': '104731',
  '교육관련직': '104730',
  '사회서비스관련직': '104732',
  '경영·금융관련직': '104734',
  '법률·공공서비스관련직': '104735',
  '문화·예술관련직': '104736',
  '서비스관련직': '104737'
};
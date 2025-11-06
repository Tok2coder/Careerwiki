/**
 * CareerNet API Client
 * 한국교육개발원 진로정보망 커리어넷의 오픈API를 활용한 학과/직업 정보 연동
 * https://www.career.go.kr/cnet/front/openapi/
 */

import type {
  JobRelatedEntity,
  MajorUniversityInfo,
  UnifiedJobDetail,
  UnifiedJobSummary,
  UnifiedMajorDetail,
  UnifiedMajorSummary
} from '../types/unifiedProfiles';

// Cloudflare Workers에서는 env 객체에서 환경변수를 가져옴
// 개발 환경에서는 기본값 사용
const getApiKey = (env?: any) => {
  if (env?.CAREER_NET_API_KEY) {
    return env.CAREER_NET_API_KEY;
  }
  // 개발용 기본 키
  return 'd9e0285190fde074bef30031f17f669e';
};

// Base URLs - 직업정보 API(getOpenApi)는 종료됨, 직업백과 API만 사용
const JOBS_ENCYCLOPEDIA_URL = 'https://www.career.go.kr/cnet/front/openapi/job.json';
const API_BASE_URL = 'https://www.career.go.kr/cnet/openapi'; // 학과 정보 API Base URL

// XML 엔티티 디코딩 함수
const decodeXmlEntities = (value?: string | null): string => {
  if (!value) return ''
  return value
    .replace(/&amp;/g, '&')
    .replace(/&lt;/g, '<')
    .replace(/&gt;/g, '>')
    .replace(/&quot;/g, '"')
    .replace(/&#39;/g, "'")
    .replace(/&#xA;/gi, '\n')
    .replace(/&#xD;/gi, '')     // Remove carriage return entirely
    .replace(/&#xd;/gi, '')     // Remove lowercase variant explicitly
}

// 중첩 XML 노드를 재귀적으로 파싱하는 함수
function parseXMLNode(xmlString: string): any {
  // 텍스트 노드인 경우
  if (!xmlString.includes('<')) {
    return decodeXmlEntities(xmlString).trim();
  }
  
  const obj: any = {};
  
  // 모든 태그 찾기
  const tagRegex = /<([^\/>\s]+)>([^<]*(?:<(?!\/\1>)[^<]*)*)<\/\1>/g;
  let match;
  
  while ((match = tagRegex.exec(xmlString)) !== null) {
    const tagName = match[1];
    const tagContent = match[2];
    
    // 중첩된 구조가 있는지 확인
    if (tagContent.includes('<')) {
      // 재귀적으로 파싱
      const parsed = parseXMLNode(tagContent);
      
      // 같은 태그가 여러 개 있으면 배열로 처리
      if (obj[tagName]) {
        if (!Array.isArray(obj[tagName])) {
          obj[tagName] = [obj[tagName]];
        }
        obj[tagName].push(parsed);
      } else {
        obj[tagName] = parsed;
      }
    } else {
      // 단순 텍스트 노드
      const value = decodeXmlEntities(tagContent).trim();
      
      // 같은 태그가 여러 개 있으면 배열로 처리
      if (obj[tagName]) {
        if (!Array.isArray(obj[tagName])) {
          obj[tagName] = [obj[tagName]];
        }
        obj[tagName].push(value);
      } else {
        obj[tagName] = value;
      }
    }
  }
  
  return obj;
}

// XML 파싱 헬퍼 함수
function parseXMLToJSON(xmlString: string): any[] {
  const contents: any[] = [];
  const contentRegex = /<content>([\s\S]*?)<\/content>/g;
  let match;
  
  while ((match = contentRegex.exec(xmlString)) !== null) {
    const content = match[1];
    
    // 중첩 구조를 재귀적으로 파싱
    const parsed = parseXMLNode(content);
    
    if (Object.keys(parsed).length > 0) {
      contents.push(parsed);
    }
  }
  
  return contents;
}

const splitToList = (value?: string): string[] => {
  if (!value) return [];
  return value
    .split(/[\n,;•·\/\u00b7]/)
    .map((item) => item.trim())
    .filter((item) => item.length > 0);
};

const dedupeList = (values: string[]): string[] => Array.from(new Set(values));

const toUniversityEntries = (value?: string): MajorUniversityInfo[] | undefined => {
  const list = dedupeList(splitToList(value));
  if (list.length === 0) return undefined;
  return list.map((name) => ({ name }));
};

const toRelatedEntities = (value?: string): JobRelatedEntity[] | undefined => {
  const list = dedupeList(splitToList(value));
  if (list.length === 0) return undefined;
  return list.map((name) => ({ name }));
};

const getMajorName = (major: Major): string => {
  const fallback = (major as any).mClass || (major as any).facilName || '';
  const name = major.major || fallback;
  return name ? name.trim() : '';
};

const getJobName = (job: Job): string => {
  const fallback = (job as any).job || (job as any).jobName || '';
  const name = job.jobName || fallback;
  return name ? name.trim() : '';
};

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
  university?: string;     // 대학명 (리스트) - deprecated, use universityList
  department?: string;     // 학과 계열
  salaryAfterGraduation?: string;  // 졸업 후 평균 연봉
  employmentRate?: string; // 취업률
  relatedJob?: string;     // 관련 직업
  aptitude?: string;       // 적성 유형
  
  // Phase 1: 추가 필드 (CareerNet 공식 문서 기반)
  
  // 교육 콘텐츠 필드 (우선순위 HIGH)
  relate_subject?: Array<{           // 관련 고교 교과목
    subject_name: string             // 선택 과목 종류명 (예: "공통과목", "일반선택")
    subject_description: string      // 과목이름 (예: "사회, 생활·교양")
  }>
  career_act?: Array<{               // 진로 탐색 활동
    act_name: string                 // 활동 종류명 (예: "법률신문 구독")
    act_description: string          // 활동 설명
  }>
  main_subject?: Array<{             // 대학 주요 교과목
    SBJECT_NM: string                // 교과목명 (예: "민법총칙")
    SBJECT_SUMRY: string             // 교과목 설명
  }>
  enter_field?: Array<{              // 졸업 후 진출분야
    gradeuate: string                // 진출분야명 (오타: gradeuate → graduate)
    description: string              // 진출분야 설명
  }>
  property?: string                  // 학과특성
  
  // 개설대학 상세 정보 (우선순위 HIGH)
  universityList?: Array<{           // 개설대학 상세 (university 대체)
    schoolName: string               // 대학명
    schoolURL?: string               // 학교 URL
    area?: string                    // 지역 (예: "서울특별시")
    campus_nm?: string               // 캠퍼스명 (예: "서울캠퍼스")
    majorName?: string               // 학과명(대학표기)
    totalCount?: string              // 전체수
  }>
  
  // 통계 데이터 (우선순위 MEDIUM)
  chartData?: {                      // 학과전망 통계
    applicant?: Array<{name: string, data: string}>      // 지원자 현황
    gender?: Array<{name: string, data: string}>         // 성별 분포
    employment_rate?: Array<{name: string, data: string}>// 취업률
    field?: Array<{name: string, data: string}>          // 취업 분야
    avg_salary?: Array<{name: string, data: string}>     // 평균 임금
    satisfaction?: Array<{name: string, data: string}>   // 만족도
    after_graduation?: Array<{name: string, data: string}>// 졸업 후 진로
  }
  
  // 특성 통계 (우선순위 LOW)
  GenCD?: {                          // 특성 - 성별비율
    popular?: Array<{
      PCNT1: string                  // 비율 - 정수값
      PCNT2: string                  // 비율 - 소수값
      PCNT: string                   // 비율 - 반올림값
      GEN_NM: string                 // 성별
    }>
    bookmark?: Array<{
      PCNT1: string
      PCNT2: string
      PCNT: string
      GEN_NM: string
    }>
  }
  SchClass?: {                       // 특성 - 학교급별비율
    popular?: Array<{
      PCNT1: string
      PCNT2: string
      PCNT: string
      SCH_CLASS_NM: string           // 학교급명
    }>
    bookmark?: Array<{
      PCNT1: string
      PCNT2: string
      PCNT: string
      SCH_CLASS_NM: string
    }>
  }
  lstMiddleAptd?: {                  // 특성 - 중학생 적성유형
    popular?: Array<{
      RANK: string                   // 순위
      CD_ORDR: string                // 코드 순서
      CD_NM: string                  // 적성유형명
    }>
    bookmark?: Array<{
      RANK: string
      CD_ORDR: string
      CD_NM: string
    }>
  }
  lstHighAptd?: {                    // 특성 - 고등학생 적성유형
    popular?: Array<{
      RANK: string
      CD_ORDR: string
      CD_NM: string
    }>
    bookmark?: Array<{
      RANK: string
      CD_ORDR: string
      CD_NM: string
    }>
  }
  lstVals?: {                        // 특성 - 선호 직업가치
    popular?: Array<{
      RANK: string
      CD_ORDR: string
      CD_NM: string                  // 직업가치명
    }>
    bookmark?: Array<{
      RANK: string
      CD_ORDR: string
      CD_NM: string
    }>
  }
}

// 직업백과 API 전체 응답 타입
export interface JobEncyclopediaResponse {
  baseInfo?: {
    seq?: number
    job_cd?: number
    job_nm?: string
    aptit_name?: string
    emp_job_cd?: string | number
    emp_job_nm?: string
    std_job_cd?: string
    std_job_nm?: string
    rel_job_nm?: string
    wage?: number
    wage_source?: string
    satisfication?: number
    satisfi_source?: string
    social?: string
    wlb?: string
    INTRST_JOB_YN?: string
    views?: number
    likes?: number
    tag?: string
    reg_dt?: string
    edit_dt?: string
  }
  workList?: Array<{ work?: string }>
  abilityList?: Array<{ ability_name?: string; SORT_ORDR?: string }>
  departList?: Array<{ depart_id?: number; depart_name?: string } | null>
  certiList?: Array<{ certi?: string; LINK?: string }>
  aptitudeList?: Array<{ aptitude?: string }>
  interestList?: Array<{ interest?: string }>
  tagList?: string[]
  researchList?: Array<{ research?: string }>
  relVideoList?: Array<{
    video_id?: string
    video_name?: string
    job_cd?: string
    CID?: string
    THUMBNAIL_FILE_SER?: string
    THUMNAIL_PATH?: string
    OUTPATH3?: string
  }>
  relSolList?: Array<{
    cnslt_seq?: number
    cnslt?: string
    SJ?: string
    CN?: string
    TRGET_SE?: string
    REGIST_DT?: string
  }>
  relJinsolList?: Array<{
    SEQ?: number
    ALT?: string
    SUBJECT?: string
    THUMBNAIL?: string
  }>
  jobReadyList?: {
    recruit?: Array<{ recruit?: string }>
    certificate?: Array<{ certificate?: string }>
    training?: Array<{ training?: string }>
    curriculum?: Array<{ curriculum?: string }>
  }
  jobRelOrgList?: Array<{ rel_org?: string; rel_org_url?: string }>
  forecastList?: Array<{ forecast?: string }>
  eduChart?: Array<{ chart_name?: string; chart_data?: string; source?: string }>
  majorChart?: Array<{ major?: string; major_data?: string; source?: string }>
  indicatorChart?: Array<{ indicator?: string; indicator_data?: string; source?: string }>
  performList?: {
    environment?: Array<{
      environment?: string
      inform?: string
      importance?: number
      source?: string
    }>
    perform?: Array<{
      perform?: string
      inform?: string
      importance?: number
      source?: string
    }>
    knowledge?: Array<{
      knowledge?: string
      inform?: string
      importance?: number
      source?: string
    }>
  }
}

// 통합 Job 타입 (호환성 유지)
export interface Job {
  jobdicSeq: string;       // 직업 코드 (seq)
  jobName: string;         // 직업명
  summary: string;         // 직업 소개
  
  // 직업백과 API 전체 응답 (job.json)
  encyclopedia?: JobEncyclopediaResponse
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
export async function searchMajors(params: SearchParams, env?: any): Promise<Major[]> {
  try {
    const url = new URL(`${API_BASE_URL}/getOpenApi`);
    url.searchParams.append('apiKey', getApiKey(env));
    url.searchParams.append('svcType', 'api');
    url.searchParams.append('svcCode', 'MAJOR');
    url.searchParams.append('contentType', 'xml');
    url.searchParams.append('gubun', 'univ_list'); // 이 값이 작동함!
    
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
    
    const xmlData = await response.text();
    
    // XML 파싱
    const majors = parseXMLToJSON(xmlData);
    
    // 필드 매핑 (XML -> 표준 형식)
    return majors.map(major => ({
      majorSeq: major.majorSeq || '',
      major: major.mClass || major.facilName || '',
      summary: major.facilName || '',
      university: '',
      department: major.lClass || '',
      salaryAfterGraduation: '',
      employmentRate: '',
      relatedJob: '',
      aptitude: '',
      
      // 원본 XML 필드도 포함
      ...major
    }));
    
  } catch (error) {
    console.error('학과정보 검색 오류:', error);
    // API 오류 시 더미 데이터 반환
    console.error('학과정보 검색 실패, Mock 데이터 사용');
    return getMockMajors(params.keyword);
  }
}

// 학과 상세 정보 조회
export async function getMajorDetail(majorSeq: string, env?: any): Promise<Major | null> {
  try {
    const url = new URL(`${API_BASE_URL}/getOpenApi`);
    url.searchParams.append('apiKey', getApiKey(env));
    url.searchParams.append('svcType', 'api');
    url.searchParams.append('svcCode', 'MAJOR_VIEW');
    url.searchParams.append('contentType', 'json');  // JSON 형태로 변경
    url.searchParams.append('gubun', 'univ_list');
    url.searchParams.append('majorSeq', majorSeq);
    
    const response = await fetch(url.toString());
    
    if (!response.ok) {
      throw new Error(`API 요청 실패: ${response.statusText}`);
    }
    
    const jsonData = await response.json();
    
    // JSON 파싱
    const majors = jsonData.dataSearch?.content || [];
    
    if (majors.length === 0) {
      return null;
    }
    
    const major = majors[0];
    
    // university 배열을 문자열로 변환 (하위 호환성)
    let universityString = '';
    if (major.university && Array.isArray(major.university)) {
      universityString = major.university
        .map((u: any) => u.schoolName || '')
        .filter((name: string) => name)
        .join(', ');
    }
    
    // university 배열을 상세 정보로 변환 (Phase 1)
    let universityList: Major['universityList'] = undefined;
    if (major.university && Array.isArray(major.university)) {
      universityList = major.university
        .map((u: any) => ({
          schoolName: u.schoolName || '',
          schoolURL: u.schoolURL || undefined,
          area: u.area || undefined,
          campus_nm: u.campus_nm || undefined,
          majorName: u.majorName || undefined,
          totalCount: u.totalCount || undefined
        }))
        .filter(u => u.schoolName);
    }
    
    // 필드 매핑 (JSON 형태는 이미 객체이므로 그대로 사용 가능)
    // 주의: spread operator를 먼저 사용하고, 그 다음에 변환된 필드를 덮어쓴다
    return {
      // 원본 JSON 필드 모두 포함 (중첩 구조 포함)
      // API가 반환하는 모든 필드가 자동으로 포함됨 (relate_subject, career_act, chartData 등)
      ...major,
      
      // 명시적으로 변환이 필요한 필드들 (위의 spread를 덮어씀)
      majorSeq: majorSeq,
      major: major.major || '',
      summary: major.summary || '',
      university: universityString,       // 배열을 문자열로 변환 (하위 호환성)
      universityList: universityList,     // 상세 정보 배열 (Phase 1)
      department: major.department || '',
      salaryAfterGraduation: major.salary || '',
      employmentRate: major.employment || '',
      relatedJob: major.job || '',
      aptitude: major.interest || '',
      
      // Phase 1: 새로운 필드들은 spread operator로 자동 포함됨
      // relate_subject, career_act, main_subject, enter_field, property,
      // chartData, GenCD, SchClass, lstMiddleAptd, lstHighAptd, lstVals
    };
    
  } catch (error) {
    console.error('학과 상세정보 조회 오류:', error);
    // API 오류 시 더미 데이터 반환
    console.error('학과 상세정보 조회 실패, Mock 데이터 사용');
    return getMockMajorDetail(majorSeq);
  }
}

// 직업 정보 검색
export async function searchJobs(params: SearchParams, env?: any): Promise<Job[]> {
  try {
    const url = new URL(`${API_BASE_URL}/getOpenApi`);
    url.searchParams.append('apiKey', getApiKey(env));
    url.searchParams.append('svcType', 'api');
    url.searchParams.append('svcCode', 'JOB');
    url.searchParams.append('contentType', 'xml');
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
    
    const xmlData = await response.text();
    
    // XML 파싱
    const jobs = parseXMLToJSON(xmlData);
    
    // 필드 매핑 (XML -> 표준 형식)
    return jobs.map(job => ({
      jobdicSeq: job.jobdicSeq || '',
      jobName: job.job || job.jobName || '',
      summary: job.summary || '',
      aptdType: job.aptd_type_code || '',
      jobCategoryName: job.profession || '',
      avgSalary: job.salery || '',
      salaryRange: job.salery || '',
      jobOutlook: job.possibility || '',
      relatedMajor: '',
      requiredEducation: '',
      requiredCertification: '',
      employmentTrend: job.equalemployment || '',
      
      // 원본 XML 필드도 포함
      ...job
    }));
    
  } catch (error) {
    console.error('직업정보 검색 오류:', error);
    // API 오류 시 더미 데이터 반환 (개발용)
    console.error('직업정보 검색 실패, Mock 데이터 사용');
    return getMockJobs(params.keyword);
  }
}

// 직업백과 API 조회 (job.json - 유일한 CareerNet API)
export async function getJobEncyclopedia(jobdicSeq: string, env?: any): Promise<JobEncyclopediaResponse | null> {
  try {
    // jobdicSeq 형식 변환
    let seqNumber = jobdicSeq;
    
    // 1. job:C_375 형태인 경우 숫자만 추출
    if (jobdicSeq.includes(':')) {
      const match = jobdicSeq.match(/:([A-Z])_(\d+)/i);
      if (match) {
        seqNumber = match[2]; // 숫자 부분만 추출
      }
    }
    // 2. K000000933 형태인 경우 K 제거하고 숫자 추출
    else if (jobdicSeq.startsWith('K')) {
      const match = jobdicSeq.match(/K(\d+)/);
      if (match) {
        seqNumber = match[1]; // K 뒤의 숫자 부분만
      }
    }
    
    const url = new URL(JOBS_ENCYCLOPEDIA_URL);
    url.searchParams.append('apiKey', getApiKey(env));
    url.searchParams.append('seq', seqNumber); // seq 파라미터 사용
    
    const response = await fetch(url.toString());
    
    if (!response.ok) {
      console.warn(`직업백과 API 요청 실패: ${response.statusText}`);
      return null;
    }
    
    const data = await response.json();
    
    // 직업백과 API 응답은 루트에 바로 모든 필드가 있음
    return data as JobEncyclopediaResponse;
  } catch (error) {
    console.error('직업백과 API 조회 오류:', error);
    return null;
  }
}

// 직업 상세 정보 조회 (직업백과 API만 사용 - getOpenApi는 종료됨)
export async function getJobDetail(jobdicSeq: string, env?: any): Promise<Job | null> {
  try {
    // 직업백과 API 호출
    const encyclopediaData = await getJobEncyclopedia(jobdicSeq, env);
    
    if (!encyclopediaData) {
      console.warn(`직업백과 데이터를 찾을 수 없습니다: ${jobdicSeq}`);
      return null;
    }
    
    // 기본 정보 추출
    const baseInfo = encyclopediaData.baseInfo || {};
    const workList = encyclopediaData.workList || [];
    
    // 하는 일을 summary로 사용
    const summaryText = workList.map(w => w.work).filter(Boolean).join('\n\n');
    
    // Job 인터페이스에 맞게 변환
    const jobData: Job = {
      jobdicSeq: String(baseInfo.seq || jobdicSeq),
      jobName: baseInfo.job_nm || '',
      summary: summaryText,
      
      // 직업백과 전체 데이터 저장
      encyclopedia: encyclopediaData
    };
    
    return jobData;
    
  } catch (error) {
    console.error('직업 상세정보 조회 오류:', error);
    // API 오류 시 더미 데이터 반환 (개발용)
    console.error('직업 상세정보 조회 실패, Mock 데이터 사용');
    return getMockJobDetail(jobdicSeq);
  }
}

export const normalizeCareerNetMajorSummary = (major: Major): UnifiedMajorSummary => {
  const canonicalId = major.majorSeq
    ? `major:C_${major.majorSeq}`
    : `major:C_${getMajorName(major).replace(/\s+/g, '_') || 'unknown'}`;
  const name = getMajorName(major) || canonicalId;

  return {
    id: canonicalId,
    sourceIds: {
      careernet: major.majorSeq || undefined
    },
    name,
    categoryName: major.department?.trim(),
    summary: major.summary?.trim(),
    aptitude: major.aptitude?.trim(),
    relatedMajors: [],
    sources: ['CAREERNET']
  };
};

export const normalizeCareerNetMajorDetail = (major: Major): UnifiedMajorDetail => {
  const summary = normalizeCareerNetMajorSummary(major);
  
  // 개설대학 정보 (universityList 우선, 없으면 university 사용)
  const universities = major.universityList && major.universityList.length > 0
    ? major.universityList.map(u => ({
        name: u.schoolName,
        url: u.schoolURL,
        area: u.area,
        campus: u.campus_nm
      }))
    : toUniversityEntries(major.university);
  
  const relatedJobs = dedupeList(splitToList(major.relatedJob));

  return {
    ...summary,
    universities,
    relatedJobs: relatedJobs.length ? relatedJobs : undefined,
    salaryAfterGraduation: major.salaryAfterGraduation?.trim(),
    employmentRate: major.employmentRate?.trim(),
    
    // Phase 1: 새로운 필드들 추가
    relateSubject: major.relate_subject,
    careerAct: major.career_act,
    mainSubject: major.main_subject,
    enterField: major.enter_field,
    property: major.property?.trim(),
    chartData: major.chartData,
    genCD: major.GenCD,
    schClass: major.SchClass,
    lstMiddleAptd: major.lstMiddleAptd,
    lstHighAptd: major.lstHighAptd,
    lstVals: major.lstVals,
    
    sources: summary.sources
  };
};

export const normalizeCareerNetJobSummary = (job: Job): UnifiedJobSummary => {
  const canonicalId = job.jobdicSeq
    ? `job:C_${job.jobdicSeq}`
    : `job:C_${getJobName(job).replace(/\s+/g, '_') || 'unknown'}`;

  const name = getJobName(job) || canonicalId;

  return {
    id: canonicalId,
    sourceIds: {
      careernet: job.jobdicSeq || undefined
    },
    name,
    category: {
      name: job.jobCategoryName?.trim() || job.profession?.trim()
    },
    sources: ['CAREERNET']
  };
};

export const normalizeCareerNetJobDetail = (job: Job): UnifiedJobDetail => {
  const summary = normalizeCareerNetJobSummary(job);
  const encyc = job.encyclopedia;
  
  if (!encyc) {
    return {
      ...summary,
      summary: job.summary,
      sources: summary.sources
    };
  }
  
  // 관련 학과 추출 (중복 제거)
  const relatedMajors = encyc.departList
    ?.filter((d): d is { depart_id?: number; depart_name?: string } => d !== null && !!d.depart_name)
    .map(d => ({ name: d.depart_name!.trim() }))
    .filter((major, index, self) => 
      index === self.findIndex(m => m.name === major.name)
    );
  
  // 관련 자격증 추출 (중복 및 유사 항목 제거)
  const relatedCertificates = encyc.certiList
    ?.map(c => c.certi?.trim())
    .filter((c): c is string => !!c)
    .reduce((acc: string[], cert: string) => {
      // 자격증 정규화: 괄호 및 특수 문자 제거한 기본 이름 추출
      const normalizedCert = cert.replace(/\([^)]*\)/g, '').trim()
      
      // 이미 같은 기본 이름의 자격증이 있는지 확인
      const existingIndex = acc.findIndex(existing => {
        const normalizedExisting = existing.replace(/\([^)]*\)/g, '').trim()
        return normalizedExisting === normalizedCert
      })
      
      if (existingIndex === -1) {
        // 새로운 자격증 추가
        acc.push(cert)
      } else {
        // 기존 자격증과 비교하여 더 간결한 것 선택
        const existing = acc[existingIndex]
        // 괄호가 없는 버전을 우선
        if (!cert.includes('(') && existing.includes('(')) {
          acc[existingIndex] = cert
        }
        // 같은 조건이면 더 짧은 것 선택
        else if (cert.length < existing.length && !cert.includes('(')) {
          acc[existingIndex] = cert
        }
      }
      
      return acc
    }, []);
  
  // 연관 직업 추출
  const relatedJobs = encyc.baseInfo?.rel_job_nm 
    ? toRelatedEntities(encyc.baseInfo.rel_job_nm)
    : undefined;
  
  // 관련 기관 추출 (중복 제거)
  const relatedOrganizations = encyc.jobRelOrgList
    ?.filter(org => org.rel_org)
    .map(org => ({
      name: org.rel_org!.trim(),
      url: org.rel_org_url?.trim()
    }))
    .filter((org, index, self) => 
      index === self.findIndex(o => o.name === org.name)
    );
  
  // 하는 일 추출
  const workDescriptions = encyc.workList?.map(w => w.work).filter(Boolean).join('\n\n');
  
  // 직업전망 추출
  const forecastText = encyc.forecastList?.map(f => f.forecast).filter(Boolean).join('\n\n');

  return {
    ...summary,
    classifications: {
      large: encyc.baseInfo?.aptit_name
    },
    summary: workDescriptions,
    duties: workDescriptions,
    prospect: forecastText,
    salary: encyc.baseInfo?.wage ? `${encyc.baseInfo.wage}만원` : undefined,
    satisfaction: (encyc.baseInfo?.satisfication !== undefined && encyc.baseInfo?.satisfication !== null) ? String(encyc.baseInfo.satisfication) : undefined,
    abilities: encyc.abilityList?.map(a => a.ability_name).filter(Boolean).join(', '),
    personality: encyc.aptitudeList?.map(a => a.aptitude).filter(Boolean).join(', '),
    interests: encyc.interestList?.map(i => i.interest).filter(Boolean).join(', '),
    relatedMajors,
    relatedCertificates: relatedCertificates?.length ? relatedCertificates : undefined,
    relatedJobs,
    relatedOrganizations: relatedOrganizations?.length ? relatedOrganizations : undefined,
    
    // 직업백과 확장 필드들 (UnifiedJobDetail 타입에 맞게)
    workList: encyc.workList?.map(w => ({
      workName: '',
      workDesc: w.work || ''
    })),
    performList: encyc.performList ? {
      environment: encyc.performList.environment?.map(e => ({
        code: '',
        name: e.environment || '',
        importance: e.importance
      })),
      perform: encyc.performList.perform?.map(p => ({
        code: '',
        name: p.perform || '',
        importance: p.importance
      })),
      knowledge: encyc.performList.knowledge?.map(k => ({
        code: '',
        name: k.knowledge || '',
        importance: k.importance
      }))
    } : undefined,
    abilityList: encyc.abilityList?.map(a => ({
      code: '',
      name: a.ability_name || '',
      score: 0
    })),
    aptitudeList: encyc.aptitudeList?.map(a => ({
      code: '',
      name: a.aptitude || '',
      score: 0
    })),
    interestList: encyc.interestList?.map(i => ({
      code: '',
      name: i.interest || '',
      score: 0
    })),
    jobReadyList: encyc.jobReadyList ? {
      recruit: encyc.jobReadyList.recruit?.map(r => r.recruit).filter((r): r is string => !!r),
      certificate: encyc.jobReadyList.certificate?.map(c => c.certificate).filter((c): c is string => !!c),
      training: encyc.jobReadyList.training?.map(t => t.training).filter((t): t is string => !!t),
      curriculum: encyc.jobReadyList.curriculum?.map(c => c.curriculum).filter((c): c is string => !!c)
    } : undefined,
    forecastList: encyc.forecastList?.map(f => ({
      period: '',
      outlook: f.forecast || '',
      description: ''
    })),
    indicatorChart: encyc.indicatorChart?.map(i => ({
      category: i.indicator || '',
      value: 0,
      description: i.indicator_data || ''
    })),
    relVideoList: encyc.relVideoList?.map(v => ({
      title: v.video_name || '',
      url: v.OUTPATH3 || '',
      thumbnail: v.THUMNAIL_PATH || '',
      duration: ''
    })),
    relSolList: encyc.relSolList?.map(s => ({
      title: s.SJ || '',
      content: s.CN || '',
      url: ''
    })),
    relJinsolList: encyc.relJinsolList?.map(j => ({
      title: j.SUBJECT || '',
      content: '',
      url: ''
    })),
    researchList: encyc.researchList?.map(r => ({
      title: r.research || '',
      author: '',
      date: '',
      url: ''
    })),
    
    sources: summary.sources
  };
};

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

/**
 * 전체 직업 목록 조회 (jobs.json API)
 * 546개의 모든 직업을 페이지네이션을 통해 수집
 */
export async function fetchAllJobsList(env?: any): Promise<Array<{ seq: number; name: string }>> {
  const JOBS_LIST_URL = 'https://www.career.go.kr/cnet/front/openapi/jobs.json';
  const allJobs: Array<{ seq: number; name: string }> = [];
  
  try {
    let page = 1;
    let hasMore = true;
    
    while (hasMore) {
      const url = new URL(JOBS_LIST_URL);
      url.searchParams.append('apiKey', getApiKey(env));
      url.searchParams.append('pageIndex', page.toString());
      
      const response = await fetch(url.toString());
      
      if (!response.ok) {
        console.error(`jobs.json API 요청 실패 (페이지 ${page}): ${response.statusText}`);
        break;
      }
      
      const data = await response.json();
      const jobs = data.jobs || [];
      
      if (jobs.length === 0) {
        hasMore = false;
        break;
      }
      
      // seq와 job_nm 추출
      for (const job of jobs) {
        if (job.seq && job.job_nm) {
          allJobs.push({
            seq: job.seq,
            name: job.job_nm
          });
        }
      }
      
      // 전체 개수에 도달했으면 중단
      if (allJobs.length >= (data.count || 0)) {
        hasMore = false;
      } else {
        page++;
        // Rate limiting
        await new Promise(resolve => setTimeout(resolve, 300));
      }
    }
    
    console.log(`✅ jobs.json API: 총 ${allJobs.length}개 직업 수집 완료`);
    return allJobs;
    
  } catch (error) {
    console.error('jobs.json API 조회 오류:', error);
    return [];
  }
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
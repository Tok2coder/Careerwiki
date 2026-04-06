/**
 * Job Template Structure Designer (v2)
 * 섹션별 병합 규칙 설계 UI
 * - 여러 직업의 예시 데이터 통합 표시
 * - 출처별 색상 구분
 * - 통계 탭 추가
 */

interface FieldInfo {
  name: string
  source: string
  path: string
  description: string
  examples: Array<{ value: any; jobName: string }>
  type: string
}

interface SectionRule {
  ruleType: '1' | '2' | '3'
  fields: string[]
  customRule?: string
  comment?: string
}

interface TemplateSection {
  id: string
  title: string
  subsections: {
    id: string
    title: string
    rule: SectionRule
  }[]
}

const escapeHtml = (value: string = ''): string =>
  value
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#039;')

const formatExampleValue = (value: any, maxLength?: number): string => {
  if (value === null || value === undefined) {
    return ''
  }

  let stringValue: string
  if (typeof value === 'string') {
    stringValue = value
  } else if (typeof value === 'number' || typeof value === 'boolean') {
    stringValue = String(value)
  } else {
    try {
      stringValue = JSON.stringify(value)
    } catch {
      stringValue = String(value)
    }
  }

  if (maxLength && stringValue.length > maxLength) {
    return `${stringValue.slice(0, maxLength)}…`
  }
  return stringValue
}

export function renderJobMergeDesigner(
  careernetSamples: any[],
  goyong24JobSamples: any[],
  goyong24DJobSamples: any[],
  jobName?: string,
  jobSlug?: string
): string {
  // 필드 정보 맵 (path를 키로 사용)
  const fieldMap = new Map<string, FieldInfo>()
  
  // 필드 추출 함수 (여러 샘플에서 예시 수집)
  function extractFields(samples: any[], source: string) {
    // 현재 직업 데이터 먼저 처리 (우선순위)
    const currentJobSamples = samples.filter(s => s._isCurrentJob === true)
    const otherJobSamples = samples.filter(s => s._isCurrentJob !== true)
    
    currentJobSamples.forEach(sample => {
      const jobName = sample._jobName || '알 수 없음'
      extractFieldsRecursive(sample, source, '', jobName, true)
    })
    
    // 다른 직업 예시 데이터 처리
    otherJobSamples.forEach(sample => {
      const jobName = sample._jobName || '알 수 없음'
      extractFieldsRecursive(sample, source, '', jobName, false)
    })
  }
  
  // 리프 노드(개별 값)만 필드로 등록하는 함수
  function extractFieldsRecursive(obj: any, source: string, path: string, jobName: string, isCurrentJob: boolean) {
    if (!obj || typeof obj !== 'object') return
    
    for (const [key, value] of Object.entries(obj)) {
      if (key === '_jobName' || key === '_isCurrentJob') continue // 메타데이터 제외
      
      const fullPath = path ? `${path}.${key}` : key
      const pathKey = `${source}.${fullPath}`
      
      // 값 타입 판별
      const isNull = value === null || value === undefined
      const isArray = Array.isArray(value)
      const isObject = !isNull && !isArray && typeof value === 'object'
      const isPrimitive = !isNull && !isArray && !isObject
      
      // 리프 노드만 등록 (원시값, 배열, null)
      // 객체는 하위로 재귀 탐색만 하고 자체를 필드로 등록하지 않음
      if (isPrimitive || isArray || isNull) {
        let example: any = null
        let fieldType = 'unknown'
        
        if (isNull) {
          example = null
          fieldType = 'null'
        } else if (isArray) {
          // 배열: 첫 번째 요소를 예시로
          example = value.length > 0 ? (typeof value[0] === 'object' ? JSON.stringify(value[0]).slice(0, 150) : value[0]) : null
          fieldType = 'array'
        } else {
          // 원시값
          example = value
          fieldType = typeof value
        }
        
        // 필드 등록
        if (!fieldMap.has(pathKey)) {
          fieldMap.set(pathKey, {
            name: key,
            source,
            path: fullPath,
            description: getFieldDescription(fullPath, source) || key,
            examples: [],
            type: fieldType
          })
        }
        
        const field = fieldMap.get(pathKey)!
        // 예시 추가 (현재 직업 우선, 다른 직업은 5개까지, 중복 제거)
        if (example !== null && example !== undefined && example !== '') {
          // 예시 값 정규화 (비교용)
          const normalizedExample = typeof example === 'string' 
            ? example.trim() 
            : (typeof example === 'object' 
              ? JSON.stringify(example) 
              : String(example))
          
          // 이미 같은 값이 있는지 확인
          const hasDuplicate = field.examples.some(ex => {
            const normalizedExisting = typeof ex.value === 'string'
              ? ex.value.trim()
              : (typeof ex.value === 'object'
                ? JSON.stringify(ex.value)
                : String(ex.value))
            return normalizedExisting === normalizedExample
          })
          
          if (!hasDuplicate) {
            if (isCurrentJob) {
              field.examples.unshift({ value: example, jobName })
            } else if (field.examples.length < 5) {
              field.examples.push({ value: example, jobName })
            }
          }
        }
      }
      
      // 객체면 하위 필드로 재귀 탐색 (객체 자체는 필드로 등록 안 함)
      if (isObject) {
        extractFieldsRecursive(value, source, fullPath, jobName, isCurrentJob)
      }
    }
  }
  
  // 필드 설명 매핑 (완전한 한국어)
  function getFieldDescription(path: string, source: string): string {
    const key = path.split('.').pop() || ''
    
    // 공통 설명
    const commonDesc: Record<string, string> = {
      'seq': '일련번호',
      'job_cd': '직업코드',
      'job_nm': '직업명',
      'jobNm': '직업명',
      'dJobNm': '직업명',
      'name': '이름',
      'summary': '요약',
      'work': '하는 일',
      'duties': '직무',
      'way': '되는 방법',
      'salary': '임금',
      'wage': '연봉',
      'prospect': '전망',
      'status': '현황',
      'knowledge': '지식',
      'environment': '환경',
      'ability': '능력',
      'aptitude': '적성',
      'interest': '흥미',
      'personality': '성격',
      'values': '가치관',
      'importance': '중요도',
      'level': '수준',
      'tag': '태그',
      'views': '조회수',
      'likes': '좋아요',
      'reg_dt': '등록일',
      'edit_dt': '수정일',
    }
    
    if (commonDesc[key]) return commonDesc[key]
    
    // 커리어넷 전용
    if (source === 'CAREERNET') {
      const careernetDesc: Record<string, string> = {
        'aptit_name': '적성 및 흥미 유형',
        'INTRST_JOB_YN': '관심직업 여부',
        'emp_job_nm': '고용코드명',
        'emp_job_cd': '고용코드',
        'social': '사회공헌도',
        'satisfication': '직업만족도',
        'rel_job_nm': '관련직업명',
        'std_job_nm': '표준직업명',
        'std_job_cd': '표준직업코드',
        'wlb': '일가정균형',
        'wage_source': '임금 출처',
        'satisfi_source': '만족도 출처',
        'workList': '업무 목록',
        'abilityList': '핵심능력 목록',
        'ability_name': '능력명',
        'departList': '관련학과 목록',
        'depart_name': '학과명',
        'depart_id': '학과ID',
        'certiList': '자격증 목록',
        'certi': '자격증명',
        'aptitudeList': '적성 목록',
        'interestList': '흥미 목록',
        'tagList': '태그 목록',
        'researchList': '진로탐색 목록',
        'research': '진로탐색 내용',
        'relVideoList': '관련영상 목록',
        'video_name': '영상제목',
        'video_id': '영상ID',
        'relSolList': '진로상담 목록',
        'cnslt': '상담내용',
        'relJinsolList': '진로자료 목록',
        'jobReadyList': '직업준비 정보',
        'recruit': '채용정보',
        'certificate': '자격증',
        'training': '훈련',
        'curriculum': '교육과정',
        'jobRelOrgList': '관련기관 목록',
        'rel_org': '관련기관명',
        'rel_org_url': '관련기관 URL',
        'forecastList': '전망 목록',
        'forecast': '전망 내용',
        'eduChart': '학력분포 차트',
        'chart_name': '차트명',
        'chart_data': '차트데이터',
        'majorChart': '전공분포 차트',
        'major': '전공명',
        'major_data': '전공데이터',
        'indicatorChart': '직업지표 차트',
        'indicator': '지표명',
        'indicator_data': '지표값',
        'performList': '업무수행 목록',
        'perform': '업무수행능력',
        'inform': '설명',
        'baseInfo': '기본정보',
        'encyclopedia': '직업백과',
      }
      if (careernetDesc[key]) return careernetDesc[key]
    }
    
    // 고용24 직업정보
    if (source === 'WORK24_JOB') {
      const work24JobDesc: Record<string, string> = {
        'jobCd': '직업코드',
        'jobLrclNm': '대분류명',
        'jobMdclNm': '중분류명',
        'jobSmclNm': '소분류명',
        'jobSum': '직무개요',
        'execJob': '수행직무',
        'technKnow': '필수 기술 및 지식',
        'edubg': '학력분포',
        'edubgMgraduUndr': '중졸이하',
        'edubgHgradu': '고졸',
        'edubgCgraduUndr': '전문대졸',
        'edubgUgradu': '대졸',
        'edubgGgradu': '대학원졸',
        'edubgDgradu': '박사졸',
        'schDpt': '전공분포',
        'cultLangDpt': '인문계열',
        'socDpt': '사회계열',
        'eduDpt': '교육계열',
        'engnrDpt': '공학계열',
        'natrlDpt': '자연계열',
        'mediDpt': '의학계열',
        'artphyDpt': '예체능계열',
        'relMajorList': '관련전공 목록',
        'majorCd': '전공코드',
        'majorNm': '전공명',
        'relOrgList': '관련기관 목록',
        'orgSiteUrl': '기관URL',
        'orgNm': '기관명',
        'relCertList': '관련자격 목록',
        'certNm': '자격증명',
        'kecoList': 'KECO코드 목록',
        'kecoCd': 'KECO코드',
        'kecoNm': 'KECO명',
        'sal': '임금',
        'jobSatis': '직업만족도',
        'jobProspect': '일자리전망',
        'jobStatus': '일자리현황',
        'jobSumProspect': '전망요약',
        'jobProspectNm': '전망명',
        'jobProspectRatio': '전망비율',
        'jobProspectInqYr': '조사년도',
        'jobStatusList': '일자리현황 목록',
        'jobAbil': '업무수행능력',
        'knowldg': '지식',
        'jobEnv': '업무환경',
        'jobChr': '성격',
        'jobIntrst': '흥미',
        'jobVals': '가치관',
        'jobActvImprtncs': '업무활동 중요도',
        'jobActvLvls': '업무활동 수준',
        'relJobList': '관련직업 목록',
        'summary': '요약',
        'duty': '직무',
        'path': '경로',
        'salProspect': '임금전망',
        'ablKnwEnv': '능력지식환경',
        'chrIntrVals': '성격흥미가치관',
        'actv': '업무활동',
      }
      if (work24JobDesc[key]) return work24JobDesc[key]
    }
    
    // 고용24 직업사전
    if (source === 'WORK24_DJOB') {
      const work24DJobDesc: Record<string, string> = {
        'dJobCd': '직업사전코드',
        'dJobCdSeq': '직업사전순번',
        'dJobNm': '직업명',
        'workSum': '직무개요',
        'doWork': '수행직무',
        'optionJobInfo': '부가직업정보',
        'eduLevel': '교육수준',
        'skillYear': '숙련기간',
        'workStrong': '작업강도',
        'workPlace': '작업장소',
        'physicalAct': '육체활동',
        'workEnv': '작업환경',
        'workFunc1': '직무기능(자료)',
        'workFunc2': '직무기능(사람)',
        'workFunc3': '직무기능(사물)',
        'similarNm': '유사명칭',
        'connectJob': '관련직업',
        'certLic': '자격면허',
        'dJobECd': '고용직업분류코드',
        'dJobECdNm': '고용직업분류명',
        'dJobJCd': '표준직업분류코드',
        'dJobJCdNm': '표준직업분류명',
        'dJobICd': '표준산업분류코드',
        'dJobICdNm': '표준산업분류명',
        'inqYear': '조사년도',
        'etc': '비고',
      }
      if (work24DJobDesc[key]) return work24DJobDesc[key]
    }
    
    // 기본값: 키를 그대로 사용
    return key
  }
  
  // 데이터 추출
  extractFields(careernetSamples, 'CAREERNET')
  extractFields(goyong24JobSamples, 'WORK24_JOB')
  extractFields(goyong24DJobSamples, 'WORK24_DJOB')
  
  // 모든 알려진 필드를 미리 정의 (데이터가 없어도 표시)
  const predefinedFields: Array<{ source: string; path: string; description: string }> = [
    // CAREERNET 필드
    { source: 'CAREERNET', path: 'baseInfo.seq', description: '일련번호' },
    { source: 'CAREERNET', path: 'baseInfo.job_cd', description: '직업코드' },
    { source: 'CAREERNET', path: 'baseInfo.job_nm', description: '직업명' },
    { source: 'CAREERNET', path: 'baseInfo.aptit_name', description: '적성유형명' },
    { source: 'CAREERNET', path: 'baseInfo.emp_job_cd', description: '고용직업분류코드' },
    { source: 'CAREERNET', path: 'baseInfo.emp_job_nm', description: '고용직업분류명' },
    { source: 'CAREERNET', path: 'baseInfo.std_job_cd', description: '표준직업분류코드' },
    { source: 'CAREERNET', path: 'baseInfo.std_job_nm', description: '표준직업분류명' },
    { source: 'CAREERNET', path: 'baseInfo.rel_job_nm', description: '관련직업명' },
    { source: 'CAREERNET', path: 'baseInfo.wage', description: '평균임금' },
    { source: 'CAREERNET', path: 'baseInfo.wage_source', description: '임금출처' },
    { source: 'CAREERNET', path: 'baseInfo.satisfication', description: '직업만족도' },
    { source: 'CAREERNET', path: 'baseInfo.satisfi_source', description: '만족도출처' },
    { source: 'CAREERNET', path: 'baseInfo.social', description: '사회적 평판' },
    { source: 'CAREERNET', path: 'baseInfo.wlb', description: '워라밸 평가' },
    { source: 'CAREERNET', path: 'baseInfo.tag', description: '태그' },
    { source: 'CAREERNET', path: 'baseInfo.views', description: '조회수' },
    { source: 'CAREERNET', path: 'baseInfo.likes', description: '좋아요수' },
    { source: 'CAREERNET', path: 'workList', description: '하는 일 목록' },
    { source: 'CAREERNET', path: 'abilityList', description: '핵심역량 목록' },
    { source: 'CAREERNET', path: 'departList', description: '관련학과 목록' },
    { source: 'CAREERNET', path: 'certiList', description: '관련자격증 목록' },
    { source: 'CAREERNET', path: 'aptitudeList', description: '적성 목록' },
    { source: 'CAREERNET', path: 'interestList', description: '흥미 목록' },
    { source: 'CAREERNET', path: 'tagList', description: '태그 목록' },
    { source: 'CAREERNET', path: 'researchList', description: '진로탐색 목록' },
    { source: 'CAREERNET', path: 'relVideoList', description: '관련영상 목록' },
    { source: 'CAREERNET', path: 'relSolList', description: '관련솔루션 목록' },
    { source: 'CAREERNET', path: 'relJinsolList', description: '관련진솔 목록' },
    { source: 'CAREERNET', path: 'jobReadyList', description: '직업준비 정보' },
    { source: 'CAREERNET', path: 'jobRelOrgList', description: '관련기관 목록' },
    { source: 'CAREERNET', path: 'forecastList', description: '직업전망 목록' },
    { source: 'CAREERNET', path: 'eduChart', description: '학력분포 차트' },
    { source: 'CAREERNET', path: 'majorChart', description: '전공분포 차트' },
    { source: 'CAREERNET', path: 'indicatorChart', description: '직업지표 차트' },
    { source: 'CAREERNET', path: 'performList', description: '업무수행 정보' },
    
    // WORK24_JOB 필드
    { source: 'WORK24_JOB', path: 'summary.jobCd', description: '직업코드' },
    { source: 'WORK24_JOB', path: 'summary.jobNm', description: '직업명' },
    { source: 'WORK24_JOB', path: 'summary.jobLrclNm', description: '대분류명' },
    { source: 'WORK24_JOB', path: 'summary.jobMdclNm', description: '중분류명' },
    { source: 'WORK24_JOB', path: 'summary.jobSmclNm', description: '소분류명' },
    { source: 'WORK24_JOB', path: 'summary.jobSum', description: '직업요약' },
    { source: 'WORK24_JOB', path: 'summary.way', description: '되는방법' },
    { source: 'WORK24_JOB', path: 'summary.sal', description: '평균임금' },
    { source: 'WORK24_JOB', path: 'summary.jobSatis', description: '직업만족도' },
    { source: 'WORK24_JOB', path: 'summary.jobProspect', description: '일자리전망' },
    { source: 'WORK24_JOB', path: 'summary.jobStatus', description: '일자리현황' },
    { source: 'WORK24_JOB', path: 'summary.jobAbil', description: '업무수행능력' },
    { source: 'WORK24_JOB', path: 'summary.knowldg', description: '지식' },
    { source: 'WORK24_JOB', path: 'summary.jobEnv', description: '업무환경' },
    { source: 'WORK24_JOB', path: 'summary.jobChr', description: '성격' },
    { source: 'WORK24_JOB', path: 'summary.jobIntrst', description: '흥미' },
    { source: 'WORK24_JOB', path: 'summary.jobVals', description: '가치관' },
    { source: 'WORK24_JOB', path: 'summary.jobActvImprtncs', description: '업무활동중요도' },
    { source: 'WORK24_JOB', path: 'summary.jobActvLvls', description: '업무활동수준' },
    { source: 'WORK24_JOB', path: 'summary.relMajorList', description: '관련학과 목록' },
    { source: 'WORK24_JOB', path: 'summary.relCertList', description: '관련자격증 목록' },
    { source: 'WORK24_JOB', path: 'summary.relJobList', description: '관련직업 목록' },
    { source: 'WORK24_JOB', path: 'duty.jobSum', description: '직무요약' },
    { source: 'WORK24_JOB', path: 'duty.execJob', description: '수행직무' },
    { source: 'WORK24_JOB', path: 'duty.relJobList', description: '관련직업 목록' },
    { source: 'WORK24_JOB', path: 'path.technKnow', description: '필요기술지식' },
    { source: 'WORK24_JOB', path: 'path.educationDistribution', description: '학력분포' },
    { source: 'WORK24_JOB', path: 'path.majorDistribution', description: '전공분포' },
    { source: 'WORK24_JOB', path: 'path.relMajorList', description: '관련학과 목록' },
    { source: 'WORK24_JOB', path: 'path.relOrgList', description: '관련기관 목록' },
    { source: 'WORK24_JOB', path: 'path.relCertList', description: '관련자격증' },
    { source: 'WORK24_JOB', path: 'path.kecoList', description: 'KECO코드 목록' },
    { source: 'WORK24_JOB', path: 'salProspect.sal', description: '평균임금' },
    { source: 'WORK24_JOB', path: 'salProspect.jobSatis', description: '직업만족도' },
    { source: 'WORK24_JOB', path: 'salProspect.jobProspect', description: '일자리전망' },
    { source: 'WORK24_JOB', path: 'salProspect.jobSumProspect', description: '재직자전망 차트' },
    { source: 'WORK24_JOB', path: 'ablKnwEnv', description: '능력/지식/환경 비교' },
    { source: 'WORK24_JOB', path: 'chrIntrVals', description: '성격/흥미/가치관 비교' },
    { source: 'WORK24_JOB', path: 'actv', description: '업무활동 비교' },
    
    // WORK24_DJOB 필드 (직업사전 API에서 실제 제공하는 필드만)
    { source: 'WORK24_DJOB', path: 'dJobCd', description: '직업사전코드' },
    { source: 'WORK24_DJOB', path: 'dJobCdSeq', description: '직업사전순번' },
    { source: 'WORK24_DJOB', path: 'dJobNm', description: '직업명' },
    { source: 'WORK24_DJOB', path: 'workSum', description: '직무개요' },
    { source: 'WORK24_DJOB', path: 'doWork', description: '수행직무' },
    { source: 'WORK24_DJOB', path: 'optionJobInfo', description: '부가직업정보' },
    { source: 'WORK24_DJOB', path: 'optionJobInfo.eduLevel', description: '교육수준' },
    { source: 'WORK24_DJOB', path: 'optionJobInfo.skillYear', description: '숙련기간' },
    { source: 'WORK24_DJOB', path: 'optionJobInfo.workStrong', description: '작업강도' },
    { source: 'WORK24_DJOB', path: 'optionJobInfo.workPlace', description: '작업장소' },
    { source: 'WORK24_DJOB', path: 'optionJobInfo.physicalAct', description: '육체활동' },
    { source: 'WORK24_DJOB', path: 'optionJobInfo.workEnv', description: '작업환경' },
    { source: 'WORK24_DJOB', path: 'optionJobInfo.workFunc1', description: '직무기능(자료)' },
    { source: 'WORK24_DJOB', path: 'optionJobInfo.workFunc2', description: '직무기능(사람)' },
    { source: 'WORK24_DJOB', path: 'optionJobInfo.workFunc3', description: '직무기능(사물)' },
    { source: 'WORK24_DJOB', path: 'optionJobInfo.similarNm', description: '유사명칭' },
    { source: 'WORK24_DJOB', path: 'optionJobInfo.connectJob', description: '관련직업' },
    { source: 'WORK24_DJOB', path: 'optionJobInfo.certLic', description: '자격면허' },
    { source: 'WORK24_DJOB', path: 'optionJobInfo.dJobECd', description: '고용직업분류코드' },
    { source: 'WORK24_DJOB', path: 'optionJobInfo.dJobECdNm', description: '고용직업분류명' },
    { source: 'WORK24_DJOB', path: 'optionJobInfo.dJobJCd', description: '표준직업분류코드' },
    { source: 'WORK24_DJOB', path: 'optionJobInfo.dJobJCdNm', description: '표준직업분류명' },
    { source: 'WORK24_DJOB', path: 'optionJobInfo.dJobICd', description: '표준산업분류코드' },
    { source: 'WORK24_DJOB', path: 'optionJobInfo.dJobICdNm', description: '표준산업분류명' },
    { source: 'WORK24_DJOB', path: 'optionJobInfo.inqYear', description: '조사년도' },
  ]
  
  // 미리 정의된 필드 중 누락된 것 추가
  predefinedFields.forEach(({ source, path, description }) => {
    const pathKey = `${source}.${path}`
    if (!fieldMap.has(pathKey)) {
      fieldMap.set(pathKey, {
        name: path.split('.').pop() || path,
        source,
        path,
        description,
        examples: [], // 데이터 없음
        type: 'unknown'
      })
    }
  })
  
  // 하위 필드가 있는 상위 객체 필드 제외 (중복 방지)
  const allFieldsRaw = Array.from(fieldMap.values())
  const fieldPaths = new Set(allFieldsRaw.map(f => `${f.source}.${f.path}`))
  
  // 다른 필드의 부모 경로인 필드는 제외
  const filteredByParent = allFieldsRaw.filter(field => {
    const fieldPath = `${field.source}.${field.path}`
    
    // 다른 필드 중 이 필드를 부모로 가지는 것이 있는지 확인
    for (const otherPath of fieldPaths) {
      if (otherPath !== fieldPath && otherPath.startsWith(fieldPath + '.')) {
        // 다른 필드가 이 필드의 하위 경로이면 제외
        return false
      }
    }
    
    return true
  })
  
  // 같은 소스 + 같은 필드명(마지막 키) + 같은 예시값을 가진 중복 필드 제거
  // 우선순위: summary > duty > path > salProspect 등
  const pathPriority: Record<string, number> = {
    'summary': 1,
    'baseInfo': 1,
    'duty': 2,
    'path': 3,
    'salProspect': 4,
    'ablKnwEnv': 5,
    'chrIntrVals': 6,
    'actv': 7,
    'optionJobInfo': 2
  }
  
  const seenFieldSignatures = new Map<string, { priority: number; field: FieldInfo }>()
  
  const allFields = filteredByParent.filter(field => {
    // 예시값 시그니처 생성 (첫 번째 예시값 기준)
    const firstExampleValue = field.examples.length > 0 
      ? (typeof field.examples[0].value === 'string' 
          ? field.examples[0].value.trim() 
          : JSON.stringify(field.examples[0].value))
      : ''
    
    // 시그니처: 소스 + 필드명 + 예시값
    const signature = `${field.source}:${field.name}:${firstExampleValue}`
    
    // 현재 필드의 부모 경로 (첫 번째 세그먼트)
    const parentPath = field.path.split('.')[0]
    const currentPriority = pathPriority[parentPath] || 10
    
    const existing = seenFieldSignatures.get(signature)
    
    if (!existing) {
      // 처음 보는 필드
      seenFieldSignatures.set(signature, { priority: currentPriority, field })
      return true
    } else if (currentPriority < existing.priority) {
      // 더 높은 우선순위 필드가 나타남 → 기존 것 대체
      seenFieldSignatures.set(signature, { priority: currentPriority, field })
      return true
    } else {
      // 중복 필드, 낮은 우선순위 → 제외
      return false
    }
  })
  
  // 중복 제거 후 최종 필터 (낮은 우선순위로 먼저 등록된 것 제거)
  const finalFields = allFields.filter(field => {
    const firstExampleValue = field.examples.length > 0 
      ? (typeof field.examples[0].value === 'string' 
          ? field.examples[0].value.trim() 
          : JSON.stringify(field.examples[0].value))
      : ''
    const signature = `${field.source}:${field.name}:${firstExampleValue}`
    const best = seenFieldSignatures.get(signature)
    return best?.field === field
  })
  
  // 출처별 색상
  const sourceColors: Record<string, { bg: string; border: string; text: string }> = {
    'CAREERNET': { bg: '#e8f5e9', border: '#4CAF50', text: '#2e7d32' },
    'WORK24_JOB': { bg: '#e3f2fd', border: '#2196F3', text: '#1565c0' },
    'WORK24_DJOB': { bg: '#f3e5f5', border: '#9C27B0', text: '#6a1b9a' }
  }
  
  // 출처별 한글명
  const sourceLabels: Record<string, string> = {
    'CAREERNET': '커리어넷 직업백과',
    'WORK24_JOB': '고용24 직업정보',
    'WORK24_DJOB': '고용24 직업사전'
  }
  
  // 필드를 소스별로 그룹화
  const fieldsBySource: Record<string, FieldInfo[]> = {
    'CAREERNET': [],
    'WORK24_JOB': [],
    'WORK24_DJOB': []
  }
  
  finalFields.forEach(field => {
    if (fieldsBySource[field.source]) {
      fieldsBySource[field.source].push(field)
    }
  })
  
  // 필드 HTML 생성
  function renderFieldItem(field: FieldInfo): string {
    const colors = sourceColors[field.source]
    const pathKey = `${field.source}.${field.path}`
    const PREVIEW_LIMIT = 3
    const TRUNCATE_LENGTH = 120

    const hasLongExample = field.examples.some(
      (ex) => formatExampleValue(ex.value).length > TRUNCATE_LENGTH
    )
    const needsToggle = field.examples.length > PREVIEW_LIMIT || hasLongExample

    const renderExample = (ex: { value: any; jobName: string }, limit?: number) => {
      const content = formatExampleValue(ex.value, limit)
      const isExample = ex.jobName.startsWith('[예시]')
      const bgColor = isExample ? '#f5f5f5' : '#e8f5e9'
      const labelColor = isExample ? '#666' : '#2e7d32'
      return `
        <div class="field-example" style="border-left-color:${isExample ? '#ccc' : colors.border}; background:${bgColor};">
          <strong style="color:${labelColor};">${escapeHtml(ex.jobName)}:</strong>
          <span>${escapeHtml(content)}</span>
        </div>
      `
    }

    // 현재 직업의 데이터와 예시 데이터 구분
    const hasCurrentJobData = field.examples.some(ex => !ex.jobName.startsWith('[예시]'))
    
    const previewExamples = (needsToggle ? field.examples.slice(0, PREVIEW_LIMIT) : field.examples)
      .map((ex) => renderExample(ex, needsToggle ? TRUNCATE_LENGTH : undefined))
      .join('')
      || '<div class="field-example-empty">예시 없음 (다른 직업에도 데이터가 없습니다)</div>'

    const fullExamples = needsToggle
      ? field.examples.map((ex) => renderExample(ex)).join('')
      : ''

    const exampleToggleButton = needsToggle
      ? `
        <button type="button" class="example-toggle" data-example-toggle="${pathKey}" data-expanded="false">
          <span class="example-toggle-text">예시 더보기</span>
          <span class="example-toggle-count">${field.examples.length}개</span>
          <i class="fas fa-chevron-down example-toggle-icon" aria-hidden="true"></i>
        </button>
      `
      : ''

    return `
      <div class="field-item" 
           draggable="true"
           data-path="${pathKey}"
           data-source="${field.source}"
           style="background:${colors.bg}; border-color:${colors.border};">
        <div class="field-item-header">
          <div class="field-item-title" style="color:${colors.text};">
            ${field.description}
          </div>
          <button type="button" class="field-toggle-btn" data-field-disable="${field.source}.${field.path}" data-state="active">
            사용 안함
          </button>
        </div>
        <div style="font-size:11px; color:#666; font-family:monospace;">
          ${field.source}.${field.path}
        </div>
        <div style="font-size:10px; color:#999; margin-top:4px;">
          타입: ${field.type} | 예시: ${field.examples.length}개
        </div>
        <div class="field-examples-wrapper">
          <div class="field-examples field-examples-preview" data-example-preview="${pathKey}">
            ${previewExamples}
          </div>
          ${
            needsToggle
              ? `<div class="field-examples field-examples-full" data-example-full="${pathKey}" style="display:none;">
                  ${fullExamples}
                </div>`
              : ''
          }
          ${exampleToggleButton}
        </div>
      </div>
    `
  }

  // 소스별 필드 목록 HTML
  const sourceGroupsHtml = Object.entries(fieldsBySource).map(([source, fields]) => {
    const colors = sourceColors[source]
    return `
      <div class="source-group" data-source="${source}">
        <h3 style="background:${colors.bg}; color:${colors.text}; border-left:4px solid ${colors.border};">
          ${sourceLabels[source]} 
          <span style="font-size:12px; font-weight:normal;">(${fields.length}개 필드)</span>
        </h3>
        <div class="field-list">
          ${fields.map(renderFieldItem).join('')}
        </div>
      </div>
    `
  }).join('')

  const fieldToggleStorageKey = `job-merge-designer:disable:${jobSlug || jobName || 'global'}`

  return `
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>${jobName ? `${jobName} - ` : ''}직업 템플릿 구조 설계 v2</title>
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body { 
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
      background: #f5f5f5;
      overflow: hidden;
    }
    
    .container { display: flex; height: 100vh; height: 100dvh; }

    /* 왼쪽 패널 */
    .fields-panel {
      width: 40%;
      background: white;
      border-right: 1px solid #e0e0e0;
      overflow-y: auto;
      padding: 20px;
    }
    
    .fields-panel h2 {
      font-size: 18px;
      margin-bottom: 16px;
      color: #333;
      position: sticky;
      top: 0;
      background: white;
      padding: 8px 0;
      z-index: 10;
    }
    
    .search-box {
      width: 100%;
      padding: 8px 12px;
      border: 1px solid #ddd;
      border-radius: 4px;
      margin-bottom: 16px;
    }
    
    .source-group {
      margin-bottom: 24px;
    }
    
    .source-group h3 {
      font-size: 14px;
      padding: 10px 12px;
      border-radius: 4px;
      cursor: pointer;
      display: flex;
      justify-content: space-between;
      margin-bottom: 8px;
    }
    
    .source-group h3:hover { opacity: 0.8; }
    .source-group h3::after { content: '▼'; font-size: 10px; }
    .source-group.collapsed h3::after { transform: rotate(-90deg); display: inline-block; }
    .source-group.collapsed .field-list { display: none; }
    
    .field-item {
      padding: 10px;
      margin: 6px 0;
      border: 2px solid;
      border-radius: 6px;
      cursor: grab;
      transition: all 0.2s;
    }
    
    .field-item:hover {
      transform: translateX(4px);
      box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    }
    
    .field-item.dragging { opacity: 0.5; }
    
    /* 오른쪽 패널 */
    .structure-panel {
      width: 60%;
      background: #fafafa;
      overflow-y: auto;
      padding: 20px;
    }
    
    .tab-buttons {
      display: flex;
      gap: 8px;
      margin-bottom: 16px;
      position: sticky;
      top: 0;
      background: #fafafa;
      padding: 8px 0;
      z-index: 10;
      border-bottom: 2px solid #e0e0e0;
    }
    
    .tab-button {
      padding: 10px 20px;
      border: none;
      background: white;
      border-radius: 6px;
      cursor: pointer;
      font-weight: 600;
      transition: all 0.2s;
      border: 2px solid #ddd;
    }
    
    .tab-button:hover { background: #f0f0f0; }
    .tab-button.active { background: #4CAF50; color: white; border-color: #4CAF50; }
    
    .tab-content { display: none; }
    .tab-content.active { display: block; }
    
    .section {
      background: white;
      border: 2px solid #e0e0e0;
      border-radius: 8px;
      padding: 16px;
      margin-bottom: 16px;
    }
    
    .section-header {
      font-size: 16px;
      font-weight: 600;
      color: #333;
      margin-bottom: 12px;
      padding-bottom: 8px;
      border-bottom: 2px solid #e0e0e0;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }
    
    .rule-toggle-btn {
      font-size: 12px;
      padding: 4px 10px;
      background: #fff3cd;
      border: 1px solid #ffc107;
      border-radius: 4px;
      cursor: pointer;
      color: #856404;
      transition: all 0.2s;
    }
    
    .rule-toggle-btn:hover {
      background: #ffc107;
      color: #fff;
    }
    
    .section-rule {
      background: #fffbeb;
      border: 1px solid #fcd34d;
      border-radius: 6px;
      padding: 12px;
      margin-bottom: 12px;
    }
    
    .rule-input {
      width: 100%;
      min-height: 80px;
      padding: 10px;
      border: 1px solid #e5e7eb;
      border-radius: 4px;
      font-size: 13px;
      font-family: inherit;
      resize: vertical;
      background: white;
    }
    
    .rule-input:focus {
      outline: none;
      border-color: #fbbf24;
      box-shadow: 0 0 0 2px rgba(251, 191, 36, 0.2);
    }
    
    .subsection-rule {
      width: 100%;
      min-height: 40px;
      padding: 8px;
      margin-top: 8px;
      border: 1px solid #e5e7eb;
      border-radius: 4px;
      font-size: 12px;
      font-family: inherit;
      resize: vertical;
      background: #fefce8;
    }
    
    .subsection-rule:focus {
      outline: none;
      border-color: #fbbf24;
      box-shadow: 0 0 0 2px rgba(251, 191, 36, 0.2);
    }
    
    .subsection-rule::placeholder {
      color: #a3a3a3;
    }
    
    .subsection {
      background: #f9f9f9;
      border: 1px solid #ddd;
      border-radius: 6px;
      padding: 12px;
      margin-bottom: 12px;
    }
    
    .subsection-title {
      font-size: 14px;
      font-weight: 600;
      color: #555;
      margin-bottom: 8px;
    }
    
    .subsection-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 8px;
    }
    
    .delete-subsection-btn {
      background: #fee2e2;
      border: 1px solid #fca5a5;
      color: #dc2626;
      font-size: 11px;
      padding: 4px 8px;
      border-radius: 4px;
      cursor: pointer;
      transition: all 0.2s;
    }
    
    .delete-subsection-btn:hover {
      background: #fecaca;
      border-color: #f87171;
    }
    
    .add-subsection-btn {
      width: 100%;
      padding: 12px;
      margin-top: 8px;
      background: #f0fdf4;
      border: 2px dashed #86efac;
      border-radius: 6px;
      color: #16a34a;
      font-weight: 600;
      cursor: pointer;
      transition: all 0.2s;
    }
    
    .add-subsection-btn:hover {
      background: #dcfce7;
      border-color: #4ade80;
    }
    
    .subsection-title-input {
      font-size: 14px;
      font-weight: 600;
      color: #555;
      border: 1px solid #e5e7eb;
      border-radius: 4px;
      padding: 4px 8px;
      background: white;
      width: 70%;
    }
    
    .subsection-title-input:focus {
      outline: none;
      border-color: #4CAF50;
      box-shadow: 0 0 0 2px rgba(76, 175, 80, 0.2);
    }
    
    .drop-zone {
      min-height: 60px;
      border: 2px dashed #ccc;
      border-radius: 4px;
      padding: 8px;
      background: white;
      transition: all 0.2s;
    }
    
    .drop-zone.drag-over {
      border-color: #4CAF50;
      background: #e8f5e9;
    }
    
    .dropped-field {
      display: inline-block;
      padding: 6px 12px;
      margin: 4px;
      border-radius: 4px;
      font-size: 12px;
      font-weight: 500;
      border: 2px solid;
      cursor: pointer;
      position: relative;
    }
    
    .dropped-field:hover { opacity: 0.8; }
    
    .remove-field {
      position: absolute;
      top: -6px;
      right: -6px;
      width: 18px;
      height: 18px;
      background: #f44336;
      color: white;
      border-radius: 50%;
      border: none;
      cursor: pointer;
      font-size: 12px;
      line-height: 18px;
      text-align: center;
    }
    
    .export-button {
      width: 100%;
      padding: 12px;
      background: #FF9800;
      color: white;
      border: none;
      border-radius: 6px;
      font-weight: 600;
      cursor: pointer;
      font-size: 14px;
      margin-top: 16px;
    }
    
    .export-button:hover { background: #F57C00; }
    
    /* 통계 탭 */
    .stats-grid {
      display: grid;
      grid-template-columns: repeat(3, 1fr);
      gap: 16px;
      margin-bottom: 24px;
    }
    
    .stat-card {
      background: white;
      border: 2px solid;
      border-radius: 8px;
      padding: 16px;
      text-align: center;
    }
    
    .stat-number {
      font-size: 32px;
      font-weight: bold;
      margin: 8px 0;
    }
    
    .stat-label {
      font-size: 14px;
      color: #666;
    }
    
    .usage-table {
      width: 100%;
      background: white;
      border-radius: 8px;
      overflow: hidden;
      border: 1px solid #e0e0e0;
    }
    
    .usage-table th {
      background: #f5f5f5;
      padding: 12px;
      text-align: left;
      font-weight: 600;
      border-bottom: 2px solid #e0e0e0;
    }
    
    .usage-table td {
      padding: 10px 12px;
      border-bottom: 1px solid #f0f0f0;
    }
    
    .usage-bar {
      height: 8px;
      border-radius: 4px;
      background: #e0e0e0;
      overflow: hidden;
    }
    
    .usage-bar-fill {
      height: 100%;
      transition: width 0.3s;
    }

    .field-item-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      gap: 8px;
      margin-bottom: 4px;
    }

    .field-item-title {
      font-size: 13px;
      font-weight: 600;
    }

    .field-toggle-btn {
      border: 1px solid #d4d4d8;
      background: #fff;
      color: #4b5563;
      font-size: 11px;
      border-radius: 4px;
      padding: 3px 8px;
      cursor: pointer;
      transition: all 0.2s;
    }

    .field-toggle-btn:hover {
      color: #111827;
      border-color: #111827;
    }

    .field-item.disabled {
      opacity: 0.45;
      border-style: dashed;
      background: #f5f5f5 !important;
    }

    .field-item.disabled .field-toggle-btn {
      color: #2563eb;
      border-color: #2563eb;
    }

    .field-examples-wrapper {
      margin-top: 6px;
    }

    .field-examples {
      display: flex;
      flex-direction: column;
      gap: 4px;
      margin-top: 4px;
    }

    .field-example {
      font-size: 11px;
      color: #444;
      padding: 4px 6px;
      background: #f9f9f9;
      border-radius: 4px;
      border-left: 2px solid #e5e7eb;
      word-break: break-all;
    }

    .field-example strong {
      color: #111827;
      font-weight: 600;
      margin-right: 4px;
    }

    .field-example-empty {
      font-size: 11px;
      color: #9ca3af;
      padding: 6px;
      background: #f3f4f6;
      border-radius: 4px;
      text-align: center;
    }

    .example-toggle {
      margin-top: 6px;
      display: inline-flex;
      align-items: center;
      gap: 6px;
      font-size: 11px;
      color: #2563eb;
      border: 1px solid #bfdbfe;
      background: #eff6ff;
      border-radius: 999px;
      padding: 4px 10px;
      cursor: pointer;
      transition: all 0.2s ease;
    }

    .example-toggle:hover {
      background: #dbeafe;
      border-color: #93c5fd;
    }

    .example-toggle-icon {
      transition: transform 0.2s ease;
    }

    .example-toggle-icon.rotated {
      transform: rotate(180deg);
    }
    
    .bulk-toggle-container {
      display: flex;
      gap: 8px;
      margin-bottom: 12px;
      padding-bottom: 12px;
      border-bottom: 1px solid #e5e7eb;
    }
    
    .bulk-toggle-btn {
      font-size: 11px;
      padding: 4px 10px;
      border: 1px solid #d1d5db;
      background: white;
      color: #4b5563;
      border-radius: 4px;
      cursor: pointer;
      transition: all 0.2s;
      white-space: nowrap;
    }
    
    .bulk-toggle-btn:hover {
      background: #f3f4f6;
      border-color: #9ca3af;
    }
    
    .bulk-toggle-btn.active {
      background: #4CAF50;
      color: white;
      border-color: #4CAF50;
    }
    
    .bulk-toggle-btn.active:hover {
      background: #45a049;
    }
    
    .bulk-toggle-btn.disable-all {
      background: #ef4444;
      color: white;
      border-color: #ef4444;
    }
    
    .bulk-toggle-btn.disable-all:hover {
      background: #dc2626;
    }
    
    .bulk-toggle-btn.disable-all.active {
      background: #dc2626;
    }
  </style>
</head>
<body>
  <div class="container">
    <!-- 왼쪽: 사용 가능한 필드 -->
    <div class="fields-panel">
      <h2>📦 사용 가능한 필드 
        <span style="font-size:12px; color:#999;">
          (총 ${finalFields.length}개)
        </span>
      </h2>
      <input type="text" class="search-box" id="searchBox" placeholder="필드 검색...">
      
      <div class="bulk-toggle-container">
        <button class="bulk-toggle-btn active" onclick="toggleAllFields(true)" id="enableAllBtn">전체 사용</button>
        <button class="bulk-toggle-btn disable-all" onclick="toggleAllFields(false)" id="disableAllBtn">전체 사용 안함</button>
      </div>
      
      ${sourceGroupsHtml}
    </div>
    
    <!-- 오른쪽: 템플릿 구조 설계 -->
    <div class="structure-panel">
      ${jobName ? `
        <div style="padding: 16px; background: #f5f5f5; border-bottom: 1px solid #e0e0e0; margin-bottom: 16px;">
          <h1 style="font-size: 20px; margin-bottom: 8px;">${jobName}</h1>
          <div style="font-size: 14px; color: #666;">
            <a href="/job/${jobSlug ? encodeURIComponent(jobSlug) : encodeURIComponent(jobName)}" target="_blank" style="color: #2196F3; text-decoration: none;">
              📄 실제 직업 페이지 보기 →
            </a>
          </div>
        </div>
      ` : ''}
      <div class="tab-buttons">
        <button class="tab-button active" onclick="switchTab('structure')">📐 구조 설계</button>
        <button class="tab-button" onclick="switchTab('stats')">📊 사용 통계</button>
      </div>
      
      <!-- 구조 설계 탭 -->
      <div id="tab-structure" class="tab-content active">
        <div class="section" data-section-group="hero">
          <div class="section-header">
            1. 히어로 섹션
            <button class="rule-toggle-btn" onclick="toggleSectionRule('hero')">📝 규칙</button>
          </div>
          <div class="section-rule" id="rule-hero" style="display:none;">
            <textarea class="rule-input" placeholder="이 섹션의 병합 규칙을 입력하세요...&#10;예: 커리어넷 데이터 우선, 없으면 고용24 직업정보 사용"></textarea>
          </div>
          
          <div class="subsections-container" data-section-group="hero">
            <div class="subsection" data-subsection-id="hero-category">
              <div class="subsection-header">
                <input type="text" class="subsection-title-input" value="1.1. 카테고리" data-title-for="hero-category">
                <button class="delete-subsection-btn" onclick="deleteSubsection('hero-category')">🗑 삭제</button>
              </div>
              <div class="drop-zone" data-section="hero-category"></div>
              <textarea class="subsection-rule" data-rule-for="hero-category" placeholder="이 필드의 규칙..."></textarea>
            </div>
            
            <div class="subsection" data-subsection-id="hero-title">
              <div class="subsection-header">
                <input type="text" class="subsection-title-input" value="1.2. 직업명" data-title-for="hero-title">
                <button class="delete-subsection-btn" onclick="deleteSubsection('hero-title')">🗑 삭제</button>
              </div>
              <div class="drop-zone" data-section="hero-title"></div>
              <textarea class="subsection-rule" data-rule-for="hero-title" placeholder="이 필드의 규칙..."></textarea>
            </div>
            
            <div class="subsection" data-subsection-id="hero-intro">
              <div class="subsection-header">
                <input type="text" class="subsection-title-input" value="1.3. 직업 소개" data-title-for="hero-intro">
                <button class="delete-subsection-btn" onclick="deleteSubsection('hero-intro')">🗑 삭제</button>
              </div>
              <div class="drop-zone" data-section="hero-intro"></div>
              <textarea class="subsection-rule" data-rule-for="hero-intro" placeholder="이 필드의 규칙..."></textarea>
            </div>
            
            <div class="subsection" data-subsection-id="hero-tags">
              <div class="subsection-header">
                <input type="text" class="subsection-title-input" value="1.4. 태그" data-title-for="hero-tags">
                <button class="delete-subsection-btn" onclick="deleteSubsection('hero-tags')">🗑 삭제</button>
              </div>
              <div class="drop-zone" data-section="hero-tags"></div>
              <textarea class="subsection-rule" data-rule-for="hero-tags" placeholder="이 필드의 규칙..."></textarea>
            </div>
          </div>
          <button class="add-subsection-btn" onclick="addSubsection('hero')">+ 서브섹션 추가</button>
        </div>
        
        <div class="section" data-section-group="overview">
          <div class="section-header">
            2.1. 개요 탭
            <button class="rule-toggle-btn" onclick="toggleSectionRule('overview')">📝 규칙</button>
          </div>
          <div class="section-rule" id="rule-overview" style="display:none;">
            <textarea class="rule-input" placeholder="이 섹션의 병합 규칙을 입력하세요...&#10;예: 커리어넷 데이터 우선, 없으면 고용24 직업정보 사용"></textarea>
          </div>
          
          <div class="subsections-container" data-section-group="overview">
            <div class="subsection" data-subsection-id="overview-work">
              <div class="subsection-header">
                <input type="text" class="subsection-title-input" value="2.1.1. 주요 업무" data-title-for="overview-work">
                <button class="delete-subsection-btn" onclick="deleteSubsection('overview-work')">🗑 삭제</button>
              </div>
              <div class="drop-zone" data-section="overview-work"></div>
              <textarea class="subsection-rule" data-rule-for="overview-work" placeholder="이 필드의 규칙..."></textarea>
            </div>
            
            <div class="subsection" data-subsection-id="overview-prospect">
              <div class="subsection-header">
                <input type="text" class="subsection-title-input" value="2.1.2. 커리어 전망" data-title-for="overview-prospect">
                <button class="delete-subsection-btn" onclick="deleteSubsection('overview-prospect')">🗑 삭제</button>
              </div>
              <div class="drop-zone" data-section="overview-prospect"></div>
              <textarea class="subsection-rule" data-rule-for="overview-prospect" placeholder="이 필드의 규칙..."></textarea>
            </div>
            
            <div class="subsection" data-subsection-id="overview-abilities">
              <div class="subsection-header">
                <input type="text" class="subsection-title-input" value="2.1.3. 핵심 능력·자격" data-title-for="overview-abilities">
                <button class="delete-subsection-btn" onclick="deleteSubsection('overview-abilities')">🗑 삭제</button>
              </div>
              <div class="drop-zone" data-section="overview-abilities"></div>
              <textarea class="subsection-rule" data-rule-for="overview-abilities" placeholder="이 필드의 규칙..."></textarea>
            </div>
            
            <div class="subsection" data-subsection-id="overview-aptitude">
              <div class="subsection-header">
                <input type="text" class="subsection-title-input" value="2.1.4. 적성 및 흥미" data-title-for="overview-aptitude">
                <button class="delete-subsection-btn" onclick="deleteSubsection('overview-aptitude')">🗑 삭제</button>
              </div>
              <div class="drop-zone" data-section="overview-aptitude"></div>
              <textarea class="subsection-rule" data-rule-for="overview-aptitude" placeholder="이 필드의 규칙..."></textarea>
            </div>
            
            <div class="subsection" data-subsection-id="overview-salary">
              <div class="subsection-header">
                <input type="text" class="subsection-title-input" value="2.1.5. 임금 정보" data-title-for="overview-salary">
                <button class="delete-subsection-btn" onclick="deleteSubsection('overview-salary')">🗑 삭제</button>
              </div>
              <div class="drop-zone" data-section="overview-salary"></div>
              <textarea class="subsection-rule" data-rule-for="overview-salary" placeholder="이 필드의 규칙..."></textarea>
            </div>
            
            <div class="subsection" data-subsection-id="overview-remarks">
              <div class="subsection-header">
                <input type="text" class="subsection-title-input" value="2.1.6. 여담 (유저 기여)" data-title-for="overview-remarks" disabled>
              </div>
              <div style="padding:12px; background:#fff3cd; border-radius:4px; color:#856404; font-size:13px;">
                💬 이 섹션은 사용자 기여 공간입니다. 필드를 추가하지 마세요.
              </div>
            </div>
          </div>
          <button class="add-subsection-btn" onclick="addSubsection('overview')">+ 서브섹션 추가</button>
        </div>
        
        <div class="section" data-section-group="details">
          <div class="section-header">
            2.2. 상세정보 탭
            <button class="rule-toggle-btn" onclick="toggleSectionRule('details')">📝 규칙</button>
          </div>
          <div class="section-rule" id="rule-details" style="display:none;">
            <textarea class="rule-input" placeholder="이 섹션의 병합 규칙을 입력하세요...&#10;예: 커리어넷 데이터 우선, 없으면 고용24 직업정보 사용"></textarea>
          </div>
          
          <div class="subsections-container" data-section-group="details">
            <div class="subsection" data-subsection-id="detail-work">
              <div class="subsection-header">
                <input type="text" class="subsection-title-input" value="2.2.1. 업무 상세" data-title-for="detail-work">
                <button class="delete-subsection-btn" onclick="deleteSubsection('detail-work')">🗑 삭제</button>
              </div>
              <div class="drop-zone" data-section="detail-work"></div>
              <textarea class="subsection-rule" data-rule-for="detail-work" placeholder="이 필드의 규칙..."></textarea>
            </div>
            
            <div class="subsection" data-subsection-id="detail-education">
              <div class="subsection-header">
                <input type="text" class="subsection-title-input" value="2.2.2. 학력·전공 분포" data-title-for="detail-education">
                <button class="delete-subsection-btn" onclick="deleteSubsection('detail-education')">🗑 삭제</button>
              </div>
              <div class="drop-zone" data-section="detail-education"></div>
              <textarea class="subsection-rule" data-rule-for="detail-education" placeholder="이 필드의 규칙..."></textarea>
            </div>
            
            <div class="subsection" data-subsection-id="detail-indicators">
              <div class="subsection-header">
                <input type="text" class="subsection-title-input" value="2.2.3. 한국의 직업지표" data-title-for="detail-indicators">
                <button class="delete-subsection-btn" onclick="deleteSubsection('detail-indicators')">🗑 삭제</button>
              </div>
              <div class="drop-zone" data-section="detail-indicators"></div>
              <textarea class="subsection-rule" data-rule-for="detail-indicators" placeholder="이 필드의 규칙..."></textarea>
            </div>
            
            <div class="subsection" data-subsection-id="detail-wlb">
              <div class="subsection-header">
                <input type="text" class="subsection-title-input" value="2.2.4. 워라밸 & 사회적 평가" data-title-for="detail-wlb">
                <button class="delete-subsection-btn" onclick="deleteSubsection('detail-wlb')">🗑 삭제</button>
              </div>
              <div class="drop-zone" data-section="detail-wlb"></div>
              <textarea class="subsection-rule" data-rule-for="detail-wlb" placeholder="이 필드의 규칙..."></textarea>
            </div>
            
            <div class="subsection" data-subsection-id="detail-ready">
              <div class="subsection-header">
                <input type="text" class="subsection-title-input" value="2.2.5. 직업 준비하기" data-title-for="detail-ready">
                <button class="delete-subsection-btn" onclick="deleteSubsection('detail-ready')">🗑 삭제</button>
              </div>
              <div class="drop-zone" data-section="detail-ready"></div>
              <textarea class="subsection-rule" data-rule-for="detail-ready" placeholder="이 필드의 규칙..."></textarea>
            </div>
            
            <div class="subsection" data-subsection-id="detail-classification">
              <div class="subsection-header">
                <input type="text" class="subsection-title-input" value="2.2.6. 직업 분류" data-title-for="detail-classification">
                <button class="delete-subsection-btn" onclick="deleteSubsection('detail-classification')">🗑 삭제</button>
              </div>
              <div class="drop-zone" data-section="detail-classification"></div>
              <textarea class="subsection-rule" data-rule-for="detail-classification" placeholder="이 필드의 규칙..."></textarea>
            </div>
          </div>
          <button class="add-subsection-btn" onclick="addSubsection('details')">+ 서브섹션 추가</button>
        </div>
        
        <div class="section" data-section-group="characteristics">
          <div class="section-header">
            2.3. 업무특성 탭
            <button class="rule-toggle-btn" onclick="toggleSectionRule('characteristics')">📝 규칙</button>
          </div>
          <div class="section-rule" id="rule-characteristics" style="display:none;">
            <textarea class="rule-input" placeholder="이 섹션의 병합 규칙을 입력하세요...&#10;예: 커리어넷 데이터 우선, 없으면 고용24 직업정보 사용"></textarea>
          </div>
          
          <div class="subsections-container" data-section-group="characteristics">
            <div class="subsection" data-subsection-id="char-knowledge">
              <div class="subsection-header">
                <input type="text" class="subsection-title-input" value="2.3.1. 필수 지식" data-title-for="char-knowledge">
                <button class="delete-subsection-btn" onclick="deleteSubsection('char-knowledge')">🗑 삭제</button>
              </div>
              <div class="drop-zone" data-section="char-knowledge"></div>
              <textarea class="subsection-rule" data-rule-for="char-knowledge" placeholder="이 필드의 규칙..."></textarea>
            </div>
            
            <div class="subsection" data-subsection-id="char-status">
              <div class="subsection-header">
                <input type="text" class="subsection-title-input" value="2.3.2. 고용 현황" data-title-for="char-status">
                <button class="delete-subsection-btn" onclick="deleteSubsection('char-status')">🗑 삭제</button>
              </div>
              <div class="drop-zone" data-section="char-status"></div>
              <textarea class="subsection-rule" data-rule-for="char-status" placeholder="이 필드의 규칙..."></textarea>
            </div>
            
            <div class="subsection" data-subsection-id="char-environment">
              <div class="subsection-header">
                <input type="text" class="subsection-title-input" value="2.3.3. 근무 환경" data-title-for="char-environment">
                <button class="delete-subsection-btn" onclick="deleteSubsection('char-environment')">🗑 삭제</button>
              </div>
              <div class="drop-zone" data-section="char-environment"></div>
              <textarea class="subsection-rule" data-rule-for="char-environment" placeholder="이 필드의 규칙..."></textarea>
            </div>
            
            <div class="subsection" data-subsection-id="char-performance">
              <div class="subsection-header">
                <input type="text" class="subsection-title-input" value="2.3.4. 업무 수행 지표" data-title-for="char-performance">
                <button class="delete-subsection-btn" onclick="deleteSubsection('char-performance')">🗑 삭제</button>
              </div>
              <div class="drop-zone" data-section="char-performance"></div>
              <textarea class="subsection-rule" data-rule-for="char-performance" placeholder="이 필드의 규칙..."></textarea>
            </div>
          </div>
          <button class="add-subsection-btn" onclick="addSubsection('characteristics')">+ 서브섹션 추가</button>
        </div>
        
        <div class="section" data-section-group="sidebar">
          <div class="section-header">
            3. 사이드바
            <button class="rule-toggle-btn" onclick="toggleSectionRule('sidebar')">📝 규칙</button>
          </div>
          <div class="section-rule" id="rule-sidebar" style="display:none;">
            <textarea class="rule-input" placeholder="이 섹션의 병합 규칙을 입력하세요...&#10;예: 커리어넷 데이터 우선, 없으면 고용24 직업정보 사용"></textarea>
          </div>
          
          <div class="subsections-container" data-section-group="sidebar">
            <div class="subsection" data-subsection-id="sidebar-jobs">
              <div class="subsection-header">
                <input type="text" class="subsection-title-input" value="3.1. 연관 직업" data-title-for="sidebar-jobs">
                <button class="delete-subsection-btn" onclick="deleteSubsection('sidebar-jobs')">🗑 삭제</button>
              </div>
              <div class="drop-zone" data-section="sidebar-jobs"></div>
              <textarea class="subsection-rule" data-rule-for="sidebar-jobs" placeholder="이 필드의 규칙..."></textarea>
            </div>
            
            <div class="subsection" data-subsection-id="sidebar-majors">
              <div class="subsection-header">
                <input type="text" class="subsection-title-input" value="3.2. 관련 전공" data-title-for="sidebar-majors">
                <button class="delete-subsection-btn" onclick="deleteSubsection('sidebar-majors')">🗑 삭제</button>
              </div>
              <div class="drop-zone" data-section="sidebar-majors"></div>
              <textarea class="subsection-rule" data-rule-for="sidebar-majors" placeholder="이 필드의 규칙..."></textarea>
            </div>
            
            <div class="subsection" data-subsection-id="sidebar-orgs">
              <div class="subsection-header">
                <input type="text" class="subsection-title-input" value="3.3. 관련 기관" data-title-for="sidebar-orgs">
                <button class="delete-subsection-btn" onclick="deleteSubsection('sidebar-orgs')">🗑 삭제</button>
              </div>
              <div class="drop-zone" data-section="sidebar-orgs"></div>
              <textarea class="subsection-rule" data-rule-for="sidebar-orgs" placeholder="이 필드의 규칙..."></textarea>
            </div>
            
            <div class="subsection" data-subsection-id="sidebar-certs">
              <div class="subsection-header">
                <input type="text" class="subsection-title-input" value="3.4. 추천 자격증" data-title-for="sidebar-certs">
                <button class="delete-subsection-btn" onclick="deleteSubsection('sidebar-certs')">🗑 삭제</button>
              </div>
              <div class="drop-zone" data-section="sidebar-certs"></div>
              <textarea class="subsection-rule" data-rule-for="sidebar-certs" placeholder="이 필드의 규칙..."></textarea>
            </div>
          </div>
          <button class="add-subsection-btn" onclick="addSubsection('sidebar')">+ 서브섹션 추가</button>
        </div>
        
        <button class="export-button" onclick="exportConfig()">
          📋 JSON 구성 복사하기
        </button>
      </div>
      
      <!-- 사용 통계 탭 -->
      <div id="tab-stats" class="tab-content">
        <div class="stats-grid">
          <div class="stat-card" style="border-color:#4CAF50;">
            <div class="stat-label">커리어넷</div>
            <div class="stat-number" style="color:#4CAF50;" id="stat-careernet">0</div>
            <div class="stat-label">사용된 필드</div>
          </div>
          
          <div class="stat-card" style="border-color:#2196F3;">
            <div class="stat-label">고용24 직업정보</div>
            <div class="stat-number" style="color:#2196F3;" id="stat-work24job">0</div>
            <div class="stat-label">사용된 필드</div>
          </div>
          
          <div class="stat-card" style="border-color:#9C27B0;">
            <div class="stat-label">고용24 직업사전</div>
            <div class="stat-number" style="color:#9C27B0;" id="stat-work24djob">0</div>
            <div class="stat-label">사용된 필드</div>
          </div>
        </div>
        
        <h3 style="margin:24px 0 16px; color:#333;">섹션별 사용 현황</h3>
        <table class="usage-table">
          <thead>
            <tr>
              <th>섹션</th>
              <th>사용된 필드</th>
              <th>사용률</th>
            </tr>
          </thead>
          <tbody id="usageTableBody">
          </tbody>
        </table>
      </div>
    </div>
  </div>
  
  <script>
    const sourceColors = ${JSON.stringify(sourceColors)};
    const sectionData = new Map();
    const FIELD_TOGGLE_KEY = ${JSON.stringify(fieldToggleStorageKey)};
    const disabledFieldSet = new Set();
    
    // ETL 필드 매핑 (기본값)
    const etlFieldMapping = {
      'hero-category': [
        'WORK24_JOB.summary.jobLrclNm',
        'WORK24_JOB.summary.jobMdclNm',
        'WORK24_JOB.summary.jobSmclNm',
        'CAREERNET.encyclopedia.baseInfo.aptit_name',
        'WORK24_DJOB.optionJobInfo.dJobICdNm'
      ],
      'hero-title': [
        'CAREERNET.name',
        'WORK24_JOB.summary.jobNm',
        'WORK24_DJOB.dJobNm'
      ],
      'hero-intro': [
        'CAREERNET.summary',
        'WORK24_JOB.duty.jobSum',
        'WORK24_JOB.summary.jobSum',
        'WORK24_DJOB.workSum'
      ],
      'hero-tags': [
        'CAREERNET.encyclopedia.baseInfo.tag',
        'CAREERNET.encyclopedia.tagList',
        'WORK24_DJOB.optionJobInfo.similarNm',
        'WORK24_DJOB.optionJobInfo.connectJob'
      ],
      'overview-work': [
        'CAREERNET.summary',
        'WORK24_JOB.duty.execJob',
        'WORK24_DJOB.doWork',
        'WORK24_DJOB.optionJobInfo.workStrong',
        'WORK24_DJOB.optionJobInfo.workPlace',
        'WORK24_DJOB.optionJobInfo.physicalAct'
      ],
      'overview-prospect': [
        'CAREERNET.encyclopedia.forecastList',
        'WORK24_JOB.salProspect.jobProspect',
        'WORK24_JOB.summary.jobProspect',
        'WORK24_JOB.salProspect.jobSumProspect'
      ],
      'overview-abilities': [
        'CAREERNET.encyclopedia.abilityList',
        'CAREERNET.encyclopedia.jobReadyList.curriculum',
        'WORK24_JOB.path.technKnow',
        'WORK24_DJOB.optionJobInfo.eduLevel',
        'WORK24_DJOB.optionJobInfo.skillYear'
      ],
      'overview-aptitude': [
        'CAREERNET.encyclopedia.aptitudeList',
        'CAREERNET.encyclopedia.interestList'
      ],
      'overview-salary': [
        'WORK24_JOB.salProspect.sal',
        'WORK24_JOB.summary.sal',
        'CAREERNET.encyclopedia.baseInfo.wage'
      ],
      'detail-work': [
        'CAREERNET.duties',
        'CAREERNET.workList',
        'WORK24_JOB.duty.execJob'
      ],
      'detail-education': [
        'WORK24_JOB.path.edubg',
        'WORK24_JOB.path.schDpt'
      ],
      'detail-indicators': [
        'CAREERNET.encyclopedia.indicatorChart'
      ],
      'detail-wlb': [
        'CAREERNET.encyclopedia.baseInfo.wlb',
        'CAREERNET.encyclopedia.baseInfo.social'
      ],
      'detail-ready': [
        'CAREERNET.encyclopedia.jobReadyList',
        'WORK24_JOB.path.technKnow',
        'WORK24_JOB.path.relMajorList',
        'WORK24_JOB.path.relCertList'
      ],
      'detail-classification': [
        'CAREERNET.category',
        'WORK24_JOB.summary.jobLrclNm',
        'WORK24_JOB.summary.jobMdclNm',
        'WORK24_JOB.summary.jobSmclNm',
        'WORK24_JOB.path.kecoList'
      ],
      'char-knowledge': [
        'CAREERNET.knowledge',
        'WORK24_JOB.ablKnwEnv.Knwldg'
      ],
      'char-status': [
        'WORK24_JOB.salProspect.jobStatus',
        'WORK24_JOB.salProspect.jobStatusList'
      ],
      'char-environment': [
        'CAREERNET.environment',
        'WORK24_JOB.ablKnwEnv.jobsEnv'
      ],
      'char-performance': [
        'CAREERNET.encyclopedia.performList',
        'WORK24_JOB.actv.jobActvImprtnc',
        'WORK24_JOB.actv.jobActvLvl'
      ],
      'sidebar-jobs': [
        'CAREERNET.relatedJobs',
        'CAREERNET.encyclopedia.relJobList',
        'WORK24_JOB.relatedJobs',
        'WORK24_JOB.summary.relJobList',
        'WORK24_JOB.duty.relJobList'
      ],
      'sidebar-majors': [
        'CAREERNET.relatedMajors',
        'CAREERNET.encyclopedia.relMajorList',
        'WORK24_JOB.relatedMajors',
        'WORK24_JOB.summary.relMajorList',
        'WORK24_JOB.path.relMajorList'
      ],
      'sidebar-orgs': [
        'CAREERNET.relatedOrganizations',
        'CAREERNET.encyclopedia.relOrgList',
        'WORK24_JOB.relatedOrganizations',
        'WORK24_JOB.path.relOrgList'
      ],
      'sidebar-certs': [
        'CAREERNET.relatedCertificates',
        'CAREERNET.encyclopedia.relCertList',
        'WORK24_JOB.relatedCertificates',
        'WORK24_JOB.summary.relCertList',
        'WORK24_JOB.path.relCertList'
      ]
    };
    
    // ETL 필드 매핑 초기화 함수
    function initializeETLFields() {
      // 사용 가능한 필드 목록 확인
      const availableFields = new Set();
      document.querySelectorAll('.field-item').forEach(item => {
        if (!item.classList.contains('disabled')) {
          availableFields.add(item.dataset.path);
        }
      });
      
      Object.keys(etlFieldMapping).forEach(sectionId => {
        const fields = etlFieldMapping[sectionId];
        const zone = document.querySelector(\`[data-section="\${sectionId}"]\`);
        if (!zone) return;
        
        // 기존 필드가 있으면 유지, 없으면 초기화
        if (!sectionData.has(sectionId)) {
          sectionData.set(sectionId, []);
        }
        
        const existingFields = sectionData.get(sectionId);
        
        fields.forEach(fieldPath => {
          // 필드가 존재하고, 아직 추가되지 않았으면 추가
          if (availableFields.has(fieldPath) && !existingFields.includes(fieldPath)) {
            existingFields.push(fieldPath);
            
            const source = fieldPath.split('.')[0];
            const colors = sourceColors[source] || { bg: '#f0f0f0', border: '#ccc', text: '#333' };
            
            const fieldEl = document.createElement('div');
            fieldEl.className = 'dropped-field';
            fieldEl.style.background = colors.bg;
            fieldEl.style.borderColor = colors.border;
            fieldEl.style.color = colors.text;
            fieldEl.textContent = fieldPath;
            
            const removeBtn = document.createElement('button');
            removeBtn.className = 'remove-field';
            removeBtn.textContent = '×';
            removeBtn.onclick = () => {
              fieldEl.remove();
              const fields = sectionData.get(sectionId);
              const idx = fields.indexOf(fieldPath);
              if (idx > -1) fields.splice(idx, 1);
              updateStats();
            };
            
            fieldEl.appendChild(removeBtn);
            zone.appendChild(fieldEl);
          }
        });
      });
      
      updateStats();
    }
    
    function applyFieldState(path, disabled) {
      const fieldEl = document.querySelector(\`.field-item[data-path="\${path}"]\`);
      if (!fieldEl) return;
      const toggleBtn = fieldEl.querySelector(\`[data-field-disable="\${path}"]\`);
      if (disabled) {
        fieldEl.classList.add('disabled');
        fieldEl.setAttribute('draggable', 'false');
        toggleBtn?.setAttribute('data-state', 'disabled');
        if (toggleBtn) toggleBtn.textContent = '사용 중으로 전환';
      } else {
        fieldEl.classList.remove('disabled');
        fieldEl.setAttribute('draggable', 'true');
        toggleBtn?.setAttribute('data-state', 'active');
        if (toggleBtn) toggleBtn.textContent = '사용 안함';
      }
    }
    
    // 전체 필드 토글
    function toggleAllFields(enable) {
      document.querySelectorAll('.field-item').forEach(item => {
        const path = item.dataset.path;
        if (!path) return;
        
        const isCurrentlyDisabled = item.classList.contains('disabled');
        
        if (enable && isCurrentlyDisabled) {
          // 활성화
          disabledFieldSet.delete(path);
          applyFieldState(path, false);
        } else if (!enable && !isCurrentlyDisabled) {
          // 비활성화
          disabledFieldSet.add(path);
          applyFieldState(path, true);
        }
      });
      
      // localStorage 업데이트
      localStorage.setItem(FIELD_TOGGLE_KEY, JSON.stringify(Array.from(disabledFieldSet)));
      
      // 버튼 상태 업데이트
      updateBulkToggleButtons();
    }

    function initializeFieldToggles() {
      let saved;
      try {
        saved = JSON.parse(localStorage.getItem(FIELD_TOGGLE_KEY) || '[]');
      } catch {
        saved = [];
      }
      saved.forEach(path => {
        disabledFieldSet.add(path);
        applyFieldState(path, true);
      });

      document.querySelectorAll('[data-field-disable]').forEach(button => {
        button.addEventListener('click', (event) => {
          event.stopPropagation();
          const path = button.dataset.fieldDisable;
          const currentState = button.getAttribute('data-state');
          const willDisable = currentState !== 'disabled';
          if (willDisable) {
            disabledFieldSet.add(path);
          } else {
            disabledFieldSet.delete(path);
          }
          applyFieldState(path, willDisable);
          localStorage.setItem(FIELD_TOGGLE_KEY, JSON.stringify(Array.from(disabledFieldSet)));
          updateBulkToggleButtons();
        });
      });
      
      // 초기 버튼 상태 업데이트
      updateBulkToggleButtons();
    }
    
    // 전체 토글 버튼 상태 업데이트
    function updateBulkToggleButtons() {
      const totalFields = document.querySelectorAll('.field-item').length;
      const disabledCount = document.querySelectorAll('.field-item.disabled').length;
      const enabledCount = totalFields - disabledCount;
      
      const enableBtn = document.getElementById('enableAllBtn');
      const disableBtn = document.getElementById('disableAllBtn');
      
      // 대부분 활성화되어 있으면 enable 버튼 활성화, 대부분 비활성화되어 있으면 disable 버튼 활성화
      if (enabledCount > disabledCount) {
        enableBtn?.classList.add('active');
        disableBtn?.classList.remove('disable-all');
      } else if (disabledCount > 0) {
        enableBtn?.classList.remove('active');
        disableBtn?.classList.add('disable-all');
      }
    }

    function initializeExampleToggles() {
      document.querySelectorAll('[data-example-toggle]').forEach(button => {
        button.addEventListener('click', () => {
          const path = button.getAttribute('data-example-toggle');
          if (!path) return;
          const preview = document.querySelector('[data-example-preview="' + path + '"]');
          const full = document.querySelector('[data-example-full="' + path + '"]');
          if (!preview || !full) return;
          const isExpanded = button.getAttribute('data-expanded') === 'true';
          if (isExpanded) {
            preview.style.display = '';
            full.style.display = 'none';
            button.setAttribute('data-expanded', 'false');
            const text = button.querySelector('.example-toggle-text');
            const icon = button.querySelector('.example-toggle-icon');
            if (text) text.textContent = '예시 더보기';
            if (icon) icon.classList.remove('rotated');
          } else {
            preview.style.display = 'none';
            full.style.display = 'flex';
            button.setAttribute('data-expanded', 'true');
            const text = button.querySelector('.example-toggle-text');
            const icon = button.querySelector('.example-toggle-icon');
            if (text) text.textContent = '예시 접기';
            if (icon) icon.classList.add('rotated');
          }
        });
      });
    }

    function initializeDesigner() {
      initializeFieldToggles();
      initializeExampleToggles();
      initializeETLFields();
    }

    if (document.readyState === 'loading') {
      document.addEventListener('DOMContentLoaded', initializeDesigner);
    } else {
      setTimeout(initializeDesigner, 100);
    }
    
    // 드래그 앤 드롭
    document.querySelectorAll('.field-item').forEach(item => {
      item.addEventListener('dragstart', (e) => {
        e.dataTransfer.setData('text/plain', item.dataset.path);
        item.classList.add('dragging');
      });
      
      item.addEventListener('dragend', (e) => {
        item.classList.remove('dragging');
      });
    });
    
    // 기존 드롭 존 설정
    document.querySelectorAll('.drop-zone').forEach(zone => {
      setupDropZone(zone);
    });
    
    // 검색
    document.getElementById('searchBox').addEventListener('input', (e) => {
      const query = e.target.value.toLowerCase();
      document.querySelectorAll('.field-item').forEach(item => {
        const text = item.textContent.toLowerCase();
        item.style.display = text.includes(query) ? 'block' : 'none';
      });
    });
    
    // 소스 그룹 접기/펼치기
    document.querySelectorAll('.source-group h3').forEach(header => {
      header.addEventListener('click', () => {
        header.parentElement.classList.toggle('collapsed');
      });
    });
    
    // 탭 전환
    function switchTab(tabName) {
      document.querySelectorAll('.tab-button').forEach(btn => btn.classList.remove('active'));
      document.querySelectorAll('.tab-content').forEach(content => content.classList.remove('active'));
      
      event.target.classList.add('active');
      document.getElementById('tab-' + tabName).classList.add('active');
      
      if (tabName === 'stats') {
        updateStats();
      }
    }
    
    // 통계 업데이트
    function updateStats() {
      const stats = {
        CAREERNET: new Set(),
        WORK24_JOB: new Set(),
        WORK24_DJOB: new Set()
      };
      
      const sectionStats = [];
      
      document.querySelectorAll('.drop-zone').forEach(zone => {
        const sectionId = zone.dataset.section;
        const fields = sectionData.get(sectionId) || [];
        
        fields.forEach(path => {
          const source = path.split('.')[0];
          stats[source].add(path);
        });
        
        if (fields.length > 0) {
          const sectionTitle = zone.closest('.subsection').querySelector('.subsection-title').textContent;
          sectionStats.push({
            title: sectionTitle,
            count: fields.length,
            fields: fields
          });
        }
      });
      
      document.getElementById('stat-careernet').textContent = stats.CAREERNET.size;
      document.getElementById('stat-work24job').textContent = stats.WORK24_JOB.size;
      document.getElementById('stat-work24djob').textContent = stats.WORK24_DJOB.size;
      
      const totalFields = ${finalFields.length};
      const usedFields = stats.CAREERNET.size + stats.WORK24_JOB.size + stats.WORK24_DJOB.size;
      
      const tbody = document.getElementById('usageTableBody');
      tbody.innerHTML = sectionStats.map(section => {
        const percentage = Math.round((section.count / totalFields) * 100);
        return \`
          <tr>
            <td><strong>\${section.title}</strong></td>
            <td>\${section.count}개</td>
            <td>
              <div class="usage-bar">
                <div class="usage-bar-fill" style="width:\${percentage}%; background:#4CAF50;"></div>
              </div>
              <div style="font-size:11px; color:#666; margin-top:4px;">\${percentage}%</div>
            </td>
          </tr>
        \`;
      }).join('');
    }
    
    // 서브섹션 추가
    let subsectionCounter = {};
    function addSubsection(sectionGroup) {
      const container = document.querySelector(\`[data-section-group="\${sectionGroup}"]\`);
      if (!container) return;
      
      // 섹션 그룹별 카운터 초기화
      if (!subsectionCounter[sectionGroup]) {
        const existingSubsections = container.querySelectorAll('.subsection');
        subsectionCounter[sectionGroup] = existingSubsections.length;
      }
      
      subsectionCounter[sectionGroup]++;
      const newId = \`\${sectionGroup}-custom-\${subsectionCounter[sectionGroup]}\`;
      
      const subsection = document.createElement('div');
      subsection.className = 'subsection';
      subsection.setAttribute('data-subsection-id', newId);
      
      subsection.innerHTML = \`
        <div class="subsection-header">
          <input type="text" class="subsection-title-input" value="새 서브섹션" data-title-for="\${newId}">
          <button class="delete-subsection-btn" onclick="deleteSubsection('\${newId}')">🗑 삭제</button>
        </div>
        <div class="drop-zone" data-section="\${newId}"></div>
        <textarea class="subsection-rule" data-rule-for="\${newId}" placeholder="이 필드의 규칙..."></textarea>
      \`;
      
      container.appendChild(subsection);
      
      // 드래그 앤 드롭 이벤트 다시 바인딩
      const newZone = subsection.querySelector('.drop-zone');
      setupDropZone(newZone);
      
      // 섹션 데이터 초기화
      if (!sectionData.has(newId)) {
        sectionData.set(newId, []);
      }
    }
    
    // 서브섹션 삭제
    function deleteSubsection(subsectionId) {
      if (!confirm('이 서브섹션을 삭제하시겠습니까? 포함된 필드도 모두 삭제됩니다.')) {
        return;
      }
      
      const subsection = document.querySelector(\`[data-subsection-id="\${subsectionId}"]\`);
      if (!subsection) return;
      
      // 섹션 데이터에서 제거
      sectionData.delete(subsectionId);
      
      // DOM에서 제거
      subsection.remove();
      
      updateStats();
    }
    
    // 드롭 존 설정 함수 (재사용)
    function setupDropZone(zone) {
      zone.addEventListener('dragover', (e) => {
        e.preventDefault();
        zone.classList.add('drag-over');
      });
      
      zone.addEventListener('dragleave', () => {
        zone.classList.remove('drag-over');
      });
      
      zone.addEventListener('drop', (e) => {
        e.preventDefault();
        zone.classList.remove('drag-over');
        
        const fieldPath = e.dataTransfer.getData('text/plain');
        const source = fieldPath.split('.')[0];
        const colors = sourceColors[source];
        
        const sectionId = zone.dataset.section;
        if (!sectionData.has(sectionId)) {
          sectionData.set(sectionId, []);
        }
        sectionData.get(sectionId).push(fieldPath);
        
        const fieldEl = document.createElement('div');
        fieldEl.className = 'dropped-field';
        fieldEl.style.background = colors.bg;
        fieldEl.style.borderColor = colors.border;
        fieldEl.style.color = colors.text;
        fieldEl.textContent = fieldPath;
        
        const removeBtn = document.createElement('button');
        removeBtn.className = 'remove-field';
        removeBtn.textContent = '×';
        removeBtn.onclick = () => {
          fieldEl.remove();
          const fields = sectionData.get(sectionId);
          const idx = fields.indexOf(fieldPath);
          if (idx > -1) fields.splice(idx, 1);
          updateStats();
        };
        
        fieldEl.appendChild(removeBtn);
        zone.appendChild(fieldEl);
        
        updateStats();
      });
    }
    
    // JSON 내보내기
    // 섹션 규칙 토글
    function toggleSectionRule(sectionId) {
      const ruleEl = document.getElementById('rule-' + sectionId);
      if (ruleEl) {
        ruleEl.style.display = ruleEl.style.display === 'none' ? 'block' : 'none';
      }
    }
    
    // 섹션별 규칙 수집
    function getSectionRules() {
      const rules = {};
      document.querySelectorAll('.section-rule').forEach(el => {
        const sectionId = el.id.replace('rule-', '');
        const textarea = el.querySelector('.rule-input');
        if (textarea && textarea.value.trim()) {
          rules[sectionId] = textarea.value.trim();
        }
      });
      return rules;
    }
    
    // 서브섹션별 규칙 수집
    function getSubsectionRules() {
      const rules = {};
      document.querySelectorAll('.subsection-rule').forEach(el => {
        const ruleFor = el.dataset.ruleFor;
        if (ruleFor && el.value.trim()) {
          rules[ruleFor] = el.value.trim();
        }
      });
      return rules;
    }
    
    // 서브섹션 제목 수집
    function getSubsectionTitles() {
      const titles = {};
      document.querySelectorAll('.subsection-title-input').forEach(input => {
        const subsectionId = input.dataset.titleFor;
        if (subsectionId && input.value.trim()) {
          titles[subsectionId] = input.value.trim();
        }
      });
      return titles;
    }
    
    function exportConfig() {
      const config = {
        fields: {},
        subsectionTitles: getSubsectionTitles(),
        sectionRules: getSectionRules(),
        subsectionRules: getSubsectionRules(),
        disabledFields: Array.from(disabledFieldSet)
      };
      
      sectionData.forEach((fields, sectionId) => {
        config.fields[sectionId] = fields;
      });
      
      const json = JSON.stringify(config, null, 2);
      navigator.clipboard.writeText(json).then(() => {
        alert('✅ JSON 구성이 클립보드에 복사되었습니다!\\n(필드 매핑 + 서브섹션 제목 + 섹션 규칙 + 서브섹션 규칙 + 비활성 필드 포함)');
      });
    }
  </script>
</body>
</html>
  `
}

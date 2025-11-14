/**
 * 대학명에서 지역 추론
 * 고용24 API에는 대학 지역 정보가 없으므로, 대학명으로 지역을 추론합니다.
 */

// 지역 키워드 매핑 (우선순위 순)
const REGION_KEYWORDS: Array<{ keywords: string[]; region: string }> = [
  // 특별시/광역시 (명확한 지역명)
  { keywords: ['서울'], region: '서울' },
  { keywords: ['부산'], region: '부산' },
  { keywords: ['대구'], region: '대구' },
  { keywords: ['인천'], region: '인천' },
  { keywords: ['광주'], region: '광주' },
  { keywords: ['대전'], region: '대전' },
  { keywords: ['울산'], region: '울산' },
  { keywords: ['세종'], region: '세종' },
  
  // 도 지역 (전체 이름)
  { keywords: ['경기'], region: '경기' },
  { keywords: ['강원', '관동'], region: '강원' },
  { keywords: ['충북', '충청북'], region: '충북' },
  { keywords: ['충남', '충청남'], region: '충남' },
  { keywords: ['전북', '전라북'], region: '전북' },
  { keywords: ['전남', '전라남'], region: '전남' },
  { keywords: ['경북', '경상북'], region: '경북' },
  { keywords: ['경남', '경상남'], region: '경남' },
  { keywords: ['제주'], region: '제주' },
  
  // 주요 도시명 → 지역 매핑
  { keywords: ['수원', '용인', '성남', '고양', '부천', '안산', '안양', '남양주', '화성', '평택', '의정부', '시흥', '파주', '김포', '광명', '광주시', '군포', '오산', '이천', '양주', '안성', '구리', '포천', '의왕', '하남', '여주', '양평', '동두천', '과천'], region: '경기' },
  { keywords: ['춘천', '원주', '강릉', '동해', '태백', '속초', '삼척'], region: '강원' },
  { keywords: ['청주', '충주', '제천', '음성', '진천'], region: '충북' },
  { keywords: ['천안', '공주', '보령', '아산', '서산', '논산', '계룡', '당진', '금산'], region: '충남' },
  { keywords: ['전주', '군산', '익산', '정읍', '남원', '김제'], region: '전북' },
  { keywords: ['목포', '여수', '순천', '나주', '광양'], region: '전남' },
  { keywords: ['포항', '경주', '김천', '안동', '구미', '영주', '영천', '상주', '문경', '경산'], region: '경북' },
  { keywords: ['창원', '진주', '통영', '사천', '김해', '밀양', '거제', '양산'], region: '경남' },
]

/**
 * 대학명에서 지역 추론
 * @param universityName 대학명 (예: "가톨릭관동대학교", "서울대학교")
 * @returns 추론된 지역 (예: "강원", "서울") 또는 undefined
 */
export const inferRegionFromUniversityName = (universityName?: string): string | undefined => {
  if (!universityName) return undefined
  
  const normalized = universityName.trim()
  
  // 우선순위대로 매칭
  for (const { keywords, region } of REGION_KEYWORDS) {
    for (const keyword of keywords) {
      if (normalized.includes(keyword)) {
        return region
      }
    }
  }
  
  return undefined
}

/**
 * 대학 정보에 지역 추가 (area가 없는 경우 추론)
 */
export const enrichUniversityWithRegion = <T extends { name?: string; area?: string }>(
  university: T
): T => {
  if (university.area) {
    // 이미 area가 있으면 그대로 사용
    return university
  }
  
  // area가 없으면 대학명으로 추론
  const inferredRegion = inferRegionFromUniversityName(university.name)
  
  if (inferredRegion) {
    return {
      ...university,
      area: inferredRegion
    }
  }
  
  return university
}


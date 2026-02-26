// src/services/rag-search.ts
// ============================================
// RAG 기반 통합 검색 서비스
// 벡터 검색(의미) + LIKE 폴백(키워드)
// ============================================

import type { D1Database, KVNamespace, VectorizeIndex, VectorizeMatches } from '@cloudflare/workers-types'
import type { DataSource } from '../types/unifiedProfiles'
import type {
  CareerWikiEnv,
  UnifiedJobSummaryEntry,
  UnifiedMajorSummaryEntry,
  UnifiedSearchResult,
  SourceStatusRecord,
} from './profileDataService'
import { searchUnifiedJobs, searchUnifiedMajors } from './profileDataService'
import { generateOpenAIEmbedding, callOpenAI } from './ai-analyzer/openai-client'

// ============================================
// 벡터 검색 최소 유사도 임계값
// ============================================
// OpenAI text-embedding-3-small + cosine:
//   0.5+ = 매우 관련, 0.35-0.5 = 관련, 0.25-0.35 = 약한 관련, <0.25 = 노이즈
const MIN_VECTOR_SCORE = 0.25
const MIN_VECTOR_SCORE_HOWTO = 0.40 // HowTo는 임베딩 수가 적어 관련 없는 것도 높은 점수 나옴

// ============================================
// 쿼리 전처리: 속어/은어 확장 + 컨텍스트 보강
// ============================================

const SLANG_DICTIONARY: Record<string, string> = {
  // 직업 은어/속어
  '철밥통': '공무원 소방관 경찰관 군인 교사 우체국직원 공기업',
  '짭새': '경찰관 경찰',
  '짭': '경찰관 경찰',
  '땜장이': '용접기사 용접공',
  '빼빼로': '모델',
  '하얀가운': '의사 의료인',
  '법조인': '판사 검사 변호사',
  '법쟁이': '변호사 법조인',
  '약장수': '약사',
  '칼잡이': '외과의사 외과 의사',
  '코드몽키': '프로그래머 소프트웨어 개발자',
  '코딩': '프로그래머 소프트웨어 개발자',
  '흙수저': '자수성가 창업가',
  '사축': '회사원 직장인',
  '월급쟁이': '회사원 직장인 사무직',
  '장사꾼': '상인 자영업자',
  '농사꾼': '농부 농업인',
  '글쟁이': '작가 기자 작문가',
  '그림쟁이': '화가 일러스트레이터 미술가',
  '선생': '교사 교수 강사',
  '스님': '승려 종교인',
  '목사님': '목사 성직자',
  '신부님': '신부 성직자',
  '소방관아저씨': '소방관',
  '택배아저씨': '택배기사 물류기사',
  '배달기사': '택배기사 배달원',
  // 교육기관/과정 → 관련 직업
  '로스쿨': '변호사 판사 검사 법무사 법률 법조인',
  '법대': '변호사 판사 검사 법무사 법학',
  '의대': '의사 외과의사 내과의사 정신과의사 소아과의사',
  '치대': '치과의사 치과 치위생사',
  '한의대': '한의사 한방 한의학',
  '약대': '약사 제약 약학',
  '수의대': '수의사 동물병원',
  '간호대': '간호사 간호',
  '사관학교': '군인 장교 군장교 국방',
  '경찰대': '경찰관 경찰 수사관',
  '교대': '초등교사 교사 교육',
  '사범대': '교사 중등교사 고등교사 교육',
  '미대': '화가 디자이너 미술가 일러스트레이터',
  '음대': '음악가 연주자 작곡가 성악가',
  '체대': '체육교사 운동선수 스포츠지도사',
  '공대': '엔지니어 기술자 개발자 연구원',
  'MBA': '경영컨설턴트 경영자 기업경영',
  '공인회계사': '회계사 감사 세무사 재무',
  '공무원시험': '공무원 행정직 세무직',
  '임용고시': '교사 초등교사 중등교사',
  '행시': '행정고시 공무원 사무관 행정직',
  '외시': '외교관 외무공무원',
  '변시': '변호사 법조인 법률',
  '의사국시': '의사 전문의',
  '간호사국시': '간호사',
  // 법조 속어
  '로클럭': '재판연구원 판사 법원 법조인',
  '로클': '재판연구원 판사 법원 법조인',
  // 추가 속어 (확장 용어는 DB 실존 직업명 사용)
  '백수': '취업컨설턴트 커리어코치 직업상담사 직업연구원',
  '취준생': '취업컨설턴트 커리어코치 직업상담사 인사사무원',
  '알바': '매장관리자 바리스타 판매원 서빙로봇관리자',
  '프리랜서': '웹디자이너 일러스트레이터 번역가 사진작가 영상편집기사 작가',
  '유튜버': '미디어콘텐츠창작자크리에이터 디지털크리에이터 영상기자 영상편집기사',
  '인플루언서': '미디어콘텐츠창작자크리에이터 디지털크리에이터 광고기획자 마케터',
  '판검사': '판사 검사 변호사 법무사',
  '기레기': '기자 방송기자 신문기자 언론인',
  '선생님': '교사 초등교사 중등교사 외국어강사',
  '공시생': '경찰관 소방관 행정사무원 세무공무원 사서 교정직공무원',
  '공무원': '경찰관 소방관 고위직공무원일반 행정사무원 세무공무원 사서 교사',
  // 전공명 → 구체적 직업명 확장 (벡터 공간에서 관련 직업으로 유도)
  '심리학': '심리학연구원 임상심리사 심리상담전문가 청소년상담사 심리검사개발원 범죄심리분석관 스포츠심리상담사',
  // 워라밸/연봉/칼퇴 관련 속어
  '워라밸': '사서 공무원 연구원 교사 사무직 학예사',
  '고연봉': '변호사 의사 치과의사 한의사 파일럿 회계사',
  '칼퇴': '사서 공무원 연구원 교사 사무직 기록물관리사',
  // 임베딩 오염 방지: "면접"→용접, "포트폴리오"→발포 방지 (DB 실존 직업명으로 확장)
  '면접 준비': '취업컨설턴트 커리어코치 인사사무원 인사교육훈련사무원 헤드헌터',
  '면접 팁': '취업컨설턴트 커리어코치 인사사무원 인사교육훈련사무원 헤드헌터',
  '면접': '취업컨설턴트 커리어코치 인사사무원 인사교육훈련사무원 헤드헌터',
  '포트폴리오 만들기': 'PPT편집디자이너 인포그래픽디자이너 일러스트레이터 웹디자이너 모션그래픽디자이너',
  '포트폴리오': 'PPT편집디자이너 인포그래픽디자이너 웹디자이너 그래픽디자이너 일러스트레이터',
  // 의도 기반 부분 매칭 (자연어 표현 → 구체적 직업명)
  '연봉 높은': '고연봉 변호사 의사 치과의사 한의사 파일럿 회계사 금융전문가',
  '돈 많이 버는': '고소득 변호사 의사 금융전문가 파일럿 회계사',
  '안정적': '공무원 공기업 교사 소방관 경찰관 군인',
  '워라밸 좋은': '사서 공무원 연구원 교사 학예사 기록물관리사',
  // IT/기술 분야 부분 매칭
  'IT': '소프트웨어개발자 프로그래머 데이터분석가 시스템엔지니어 정보보안전문가',
  // 근무 환경/스타일 기반 부분 매칭
  '야근 없는': '사서 기록물관리사 학예사 교사 연구원 행정사무원',
  '야근 안 하는': '사서 기록물관리사 학예사 교사 연구원 행정사무원',
  '칼퇴근': '사서 기록물관리사 학예사 교사 연구원 행정사무원',
  '혼자 하는': '번역가 작가 프로그래머 데이터분석가 연구원 웹디자이너',
  '혼자 일하는': '번역가 작가 프로그래머 데이터분석가 연구원 웹디자이너',
  '창의적': '게임기획자 웹디자이너 일러스트레이터 영상편집기사 작가 미디어콘텐츠창작자크리에이터',
  // 자격/미래 관련
  '자격증': '공인중개사 세무사 사회복지사 요양보호사 미용사 조리사',
  '4차산업혁명': '인공지능엔지니어 인공지능연구원 로봇공학기술자 빅데이터전문가 사물인터넷개발자',
  '4차산업': '인공지능엔지니어 인공지능연구원 로봇공학기술자 빅데이터전문가 사물인터넷개발자',
  // 외래어 직업명 (임베딩 오염 방지)
  '데이터 사이언티스트': '데이터분석가 빅데이터분석가 데이터시각화전문가 인공지능연구원',
  '데이터사이언티스트': '데이터분석가 빅데이터분석가 데이터시각화전문가 인공지능연구원',
  // 장애 관련 키워드 → 복지/치료/재활 직업 (임베딩 오염 방지: 장애우→지우개, 자폐→위폐)
  '장애우': '장애인활동지원사 장애인재활상담사 사회복지사 특수교육교사 장애인직업능력평가사',
  '자폐': '언어치료사 장애인재활상담사 특수교육교사 심리치료사 장애인활동지원사',
  '발달장애': '언어치료사 장애인재활상담사 특수교육교사 심리치료사 재활승마치료사',
  '지체장애': '물리치료사 재활의학과전문의사 장애인활동지원사 장애인보조기기지원사무원 작업치료사',
  // === 임베딩 오염 방지: substring 충돌 해결 ===
  // "기자" → "전기자동차" substring 방지
  '기자': '기자 신문기자 방송기자 취재기자 영상기자 잡지기자',
  // "파일럿" → "파일편직원" 방지
  '파일럿': '항공기조종사 교관조종사 시험비행조종사 항공교통관제사',
  // "개발자" → "인공어초개발자" 방지
  '개발자': '웹개발자 모바일앱개발자 응용소프트웨어엔지니어 시스템소프트웨어엔지니어 게임개발프로듀서',
  // === 외래어/신조어 (DB에 없는 용어) ===
  'N잡러': '미디어콘텐츠창작자크리에이터 디지털크리에이터 웹디자이너 번역가 작가 사진작가',
  '디지털노마드': '웹개발자 웹디자이너 번역가 작가 데이터분석가 프로그래머',
  // === 취업/커리어 가이드 쿼리 (HowTo 성격 → 관련 직업 매핑) ===
  '이직 준비': '취업컨설턴트 커리어코치 직업상담사 인사사무원 헤드헌터',
  '이직': '취업컨설턴트 커리어코치 직업상담사 인사사무원 헤드헌터',
  '자기소개서 쓰는 법': '취업컨설턴트 커리어코치 인사사무원 인사교육훈련사무원 헤드헌터',
  '자기소개서': '취업컨설턴트 커리어코치 인사사무원 인사교육훈련사무원 헤드헌터',
  '연봉 협상': '취업컨설턴트 커리어코치 인사사무원 노무사 인적자원전문가',
  '취업 방법': '취업컨설턴트 커리어코치 직업상담사 인사사무원 헤드헌터',
  '커리어 전환': '취업컨설턴트 커리어코치 직업상담사 인사사무원 헤드헌터',
  // === 직종 카테고리 (임베딩이 "편직/직물"로 오염되는 문제) ===
  '사무직': '경리사무원 총무사무원 인사사무원 영업지원사무원 기획사무원',
  '서비스직': '고객상담원 판매원 미용사 바리스타 호텔컨시어지',
  '전문직': '변호사 회계사 세무사 변리사 건축가',
  '기술직': '전기기술자 기계기술자 건축시공기술자 용접공학기술자 배관공',
  '현장직': '건설시공기술자 전기기술자 건축배관공 용접원 설비기술자',
  // === HR/인사 (임베딩이 "하수처리"로 오염) ===
  'HR 담당자': '인사사무원 인적자원전문가 인적자원컨설턴트 인사교육훈련사무원 노무사',
  'HR': '인사사무원 인적자원전문가 인적자원컨설턴트 인사교육훈련사무원 노무사',
  // === "XX 관련 직업" 패턴 ===
  'AI 관련 직업': '인공지능엔지니어 인공지능연구원 인공지능서비스개발자 인공지능모델개발자 데이터분석가',
  'AI 관련': '인공지능엔지니어 인공지능연구원 인공지능서비스개발자 인공지능모델개발자 데이터분석가',
  '체육 관련 직업': '체육교사 운동처방사 스포츠마케터 프로게이머 스포츠심리상담사',
  '체육 관련': '체육교사 운동처방사 스포츠마케터 프로게이머 스포츠심리상담사',
  '노인 관련 직업': '노인전문간호사 요양보호사 사회복지사 물리치료사 작업치료사',
  '노인 관련': '노인전문간호사 요양보호사 사회복지사 물리치료사 작업치료사',
  '동물 관련 직업': '수의사 동물사육사 동물조련사 반려동물미용사 수의사보조원',
  '동물 관련': '수의사 동물사육사 동물조련사 반려동물미용사 수의사보조원',
  // === "XX 잘하는 사람" 패턴 ===
  '수학 잘하는 사람 직업': '보험계리사 통계학연구원 데이터분석가 수학교사 수학연구원',
  '수학 잘하는': '보험계리사 통계학연구원 데이터분석가 수학교사 수학연구원',
  '영어 잘하는 사람 직업': '통역가 번역가 외교관 외국어교사 해외마케터',
  '영어 잘하는': '통역가 번역가 외교관 외국어교사 해외마케터',
  // === 기타 임베딩 오염 쿼리 ===
  '고고학자': '역사학연구원 학예사 문화재보존과학자 인류학연구원 고전번역가',
  '멋있는 직업': '항공기조종사 외교관 영화감독 프로게이머 건축가',
  '쉬운 직업': '판매원 경리사무원 바리스타 경비원 행정사무원',
}

// 추상적/탐색적 쿼리 패턴 → 다양한 직업 카테고리로 확장 (부분 매칭)
// 속어 사전 이전에 체크하며, 매칭 시 확장 텍스트만 searchQuery로 사용 (속어와 동일 로직)
const ABSTRACT_QUERY_MAP: Record<string, string> = {
  // 탐색적 쿼리: "뭘 하지?" 계열
  '뭐 할지 모르겠': '소프트웨어개발자 간호사 회계사 교사 경찰관 그래픽디자이너',
  '어떤 직업': '소프트웨어개발자 교사 간호사 변호사 경찰관 그래픽디자이너',
  '진로 고민': '소프트웨어개발자 간호사 교사 회계사 마케터 경찰관',
  '진로를 모르': '소프트웨어개발자 간호사 교사 경찰관 그래픽디자이너 회계사',
  '하고 싶은 게 없': '소프트웨어개발자 간호사 교사 사무직 경찰관 회계사',
  // 자연어 문장 패턴: 조사/어미 → 핵심 키워드 변환
  '집에서 할 수 있': '재택근무 프리랜서 원격근무 소프트웨어개발자 웹디자이너 번역가',
  '재택': '재택근무 프리랜서 원격근무 소프트웨어개발자 웹디자이너 번역가',
  '하기 좋은 직업': '소프트웨어개발자 간호사 교사 공무원 회계사 디자이너',
  '추천 직업': '소프트웨어개발자 간호사 교사 공무원 회계사 디자이너',
  '유망': '소프트웨어개발자 데이터분석가 인공지능엔지니어 간호사 약사',
  '미래': '인공지능엔지니어 데이터분석가 로봇공학자 드론조종사 바이오연구원',
  '뜨는': '인공지능엔지니어 데이터분석가 콘텐츠크리에이터 드론조종사 바이오연구원',
  '없이 할 수 있': '자격증없이 경력없이 사무보조원 배달기사 콜센터상담원 판매원',
  '문과': '교사 공무원 변호사 회계사 마케터 사회복지사',
  '문과 추천': '교사 공무원 변호사 회계사 마케터 사회복지사',
  '이과': '소프트웨어개발자 의사 약사 엔지니어 연구원 데이터분석가',
  '이과 추천': '소프트웨어개발자 의사 약사 엔지니어 연구원 데이터분석가',
  '전과자': '사회복지사 직업상담사 바리스타 요리사 배달기사',
  // 장애인 관련 자연어 패턴
  '장애인 할 수 있': '사무보조원 바리스타 전산자료입력원 공예원 웹접근성전문가 도서정리원',
  '장애인 추천': '사무보조원 바리스타 전산자료입력원 공예원 웹접근성전문가 도서정리원',
  '장애인 직업': '장애인활동지원사 장애인재활상담사 사회복지사 특수교육교사 장애인직업능력평가사 언어치료사',
  // 꿈/방향 없음 계열
  '꿈이 없': '직업상담사 취업컨설턴트 커리어코치 직업연구원 인사사무원',
  '꿈이 없는데': '직업상담사 취업컨설턴트 커리어코치 직업연구원 인사사무원',
  '직업 추천': '직업상담사 취업컨설턴트 커리어코치 직업연구원 인적자원전문가',
  '적성에 맞는': '직업상담사 취업컨설턴트 커리어코치 심리상담전문가 직업연구원',
  // 학력 기반 취업
  '비전공자 취업': '취업컨설턴트 커리어코치 직업상담사 판매원 경리사무원 바리스타',
  '비전공자': '취업컨설턴트 커리어코치 직업상담사 판매원 경리사무원 바리스타',
  '고졸 취업': '판매원 경비원 요양보호사 미용사 용접원 배관공',
  '고졸': '판매원 경비원 요양보호사 미용사 용접원 배관공',
  // 조건 기반 쿼리 보강
  '체력 안 쓰는': '경리사무원 사서 번역가 데이터분석가 웹디자이너 프로그래머',
  '인간관계 스트레스 없는': '번역가 작가 프로그래머 데이터분석가 연구원 웹디자이너',
  '자격증 필요 없는': '판매원 작가 프로그래머 웹디자이너 바리스타 영상편집기사',
}

// ============================================
// 한국어 오타 교정
// ============================================
// 한국어 자모 분해 → 모음 혼동 교정 → 재조합
// 흔한 오타 패턴: ㅐ↔ㅔ, 쌍자음 누락, ㅚ↔ㅙ↔ㅞ

/** 한글 자모 분해 */
function decomposeHangul(char: string): [number, number, number] | null {
  const code = char.charCodeAt(0)
  if (code < 0xAC00 || code > 0xD7A3) return null
  const offset = code - 0xAC00
  const cho = Math.floor(offset / (21 * 28))
  const jung = Math.floor((offset % (21 * 28)) / 28)
  const jong = offset % 28
  return [cho, jung, jong]
}

/** 자모로 한글 조합 */
function composeHangul(cho: number, jung: number, jong: number): string {
  return String.fromCharCode(0xAC00 + cho * 21 * 28 + jung * 28 + jong)
}

// 모음 인덱스: ㅏ0 ㅐ1 ㅑ2 ㅒ3 ㅓ4 ㅔ5 ㅕ6 ㅖ7 ㅗ8 ㅘ9 ㅙ10 ㅚ11 ㅛ12 ㅜ13 ㅝ14 ㅞ15 ㅟ16 ㅠ17 ㅡ18 ㅢ19 ㅣ20
// 혼동 그룹: {1(ㅐ), 5(ㅔ)}, {3(ㅒ), 7(ㅖ)}, {10(ㅙ), 11(ㅚ), 15(ㅞ)}
const VOWEL_CONFUSION_MAP: Record<number, number[]> = {
  1: [1, 5],     // ㅐ ↔ ㅔ
  5: [5, 1],     // ㅔ ↔ ㅐ
  3: [3, 7],     // ㅒ ↔ ㅖ
  7: [7, 3],     // ㅖ ↔ ㅒ
  10: [10, 11],  // ㅙ ↔ ㅚ
  11: [11, 10],  // ㅚ ↔ ㅙ
}

/**
 * 한국어 오타 교정: 모음 혼동 변형을 생성해 원본 뒤에 추가
 * "프로그레머" → "프로그레머 프로그래머" (둘 다 검색)
 * 벡터 임베딩에서 올바른 단어가 지배적이므로 오타 영향 최소화
 */
function correctKoreanTypo(query: string): string {
  if (query.length > 12) return query // 긴 쿼리는 스킵

  const chars = [...query]
  const variantSet = new Set<string>()

  for (let i = 0; i < chars.length; i++) {
    const decomposed = decomposeHangul(chars[i])
    if (!decomposed) continue
    const [cho, jung, jong] = decomposed
    const alternatives = VOWEL_CONFUSION_MAP[jung]
    if (!alternatives) continue

    for (const altJung of alternatives) {
      if (altJung === jung) continue
      const newChars = [...chars]
      newChars[i] = composeHangul(cho, altJung, jong)
      variantSet.add(newChars.join(''))
    }
  }

  if (variantSet.size === 0) return query
  // 원본 + 변형을 모두 포함 (벡터 검색: 올바른 쪽이 임베딩 지배)
  return `${query} ${[...variantSet].join(' ')}`
}

/**
 * 검색 쿼리 전처리:
 * 1. 추상적 쿼리 → 다양한 직업 카테고리로 확장 (ABSTRACT_QUERY_MAP)
 * 2. 속어/은어 → 표준 직업명으로 확장
 * 3. 짧은 쿼리 → 직업 컨텍스트 추가
 * 4. 추상적 쿼리 → LLM 기반 키워드 확장 (feature flag: ENABLE_QUERY_EXPANSION)
 *
 * 반환:
 * - searchQuery: 임베딩용 — 속어 매칭 시 확장 텍스트만 (원본 속어 제외해 벡터 오염 방지)
 * - keywordQuery: LIKE 키워드 검색용 — 원본 + 확장 텍스트
 * - expansionTerms: 확장 키워드 배열
 * - isSlangExpanded: 속어 매칭 여부
 */
async function preprocessQuery(
  query: string,
  options?: { openaiApiKey?: string; kv?: KVNamespace; enableExpansion?: boolean }
): Promise<{ searchQuery: string; keywordQuery: string; expansionTerms: string[]; isSlangExpanded: boolean }> {
  let trimmed = query.trim()

  // -1. 오타 교정: 한국어 모음 혼동 (ㅐ↔ㅔ 등) 기반 교정
  trimmed = correctKoreanTypo(trimmed)

  // 0. 추상적/탐색적 쿼리 패턴 — 가장 긴 매칭 우선, 동일 길이면 쿼리 앞쪽 우선
  let bestAbstractMatch: { pattern: string; expansion: string; pos: number } | null = null
  for (const [pattern, expansion] of Object.entries(ABSTRACT_QUERY_MAP)) {
    const pos = trimmed.indexOf(pattern)
    if (pos !== -1) {
      if (!bestAbstractMatch ||
          pattern.length > bestAbstractMatch.pattern.length ||
          (pattern.length === bestAbstractMatch.pattern.length && pos < bestAbstractMatch.pos)) {
        bestAbstractMatch = { pattern, expansion, pos }
      }
    }
  }
  if (bestAbstractMatch) {
    const terms = bestAbstractMatch.expansion.split(/\s+/).filter(t => t.length >= 2)
    return {
      searchQuery: bestAbstractMatch.expansion,          // 임베딩: 확장 텍스트만 (원본 제외)
      keywordQuery: `${trimmed} ${bestAbstractMatch.expansion}`, // LIKE: 원본 + 확장
      expansionTerms: terms,
      isSlangExpanded: true,
    }
  }

  // 1. 속어 사전 — 완전 매칭
  const exactSlangExpansion = SLANG_DICTIONARY[trimmed]
  if (exactSlangExpansion) {
    const terms = exactSlangExpansion.split(/\s+/).filter(t => t.length >= 2)
    return {
      searchQuery: exactSlangExpansion,            // 임베딩: 확장 텍스트만 (원본 속어 제외)
      keywordQuery: `${trimmed} ${exactSlangExpansion}`, // LIKE: 원본 + 확장
      expansionTerms: terms,
      isSlangExpanded: true,
    }
  }

  // 부분 매칭 (사전 키가 쿼리에 포함된 경우) — 모든 매칭 결합 (복수 부분 매칭 허용)
  const allExpansions: string[] = []
  const allTermsSet = new Set<string>()
  for (const [slang, expansion] of Object.entries(SLANG_DICTIONARY)) {
    if (trimmed.includes(slang)) {
      allExpansions.push(expansion)
      for (const t of expansion.split(/\s+/).filter(t => t.length >= 2)) {
        allTermsSet.add(t)
      }
    }
  }
  if (allExpansions.length > 0) {
    const combinedExpansion = allExpansions.join(' ')
    const terms = Array.from(allTermsSet)
    return {
      searchQuery: `${trimmed} ${combinedExpansion}`, // 부분 매칭은 원본 유지 (문맥 필요)
      keywordQuery: `${trimmed} ${combinedExpansion}`,
      expansionTerms: terms,
      isSlangExpanded: true,
    }
  }

  // 1.5. 도메인 접미사 확장 (2-5글자, 속어 미매칭 시)
  // 짧은 핵심어를 도메인 특화 직업/전공 변형으로 확장해 벡터 검색 정밀도 향상
  const DOMAIN_SUFFIX_MAP: Record<string, string> = {
    '간호': '간호사 간호학과 간호조무사',
    '컴퓨터': '컴퓨터공학 소프트웨어개발자 프로그래머',
    '경제': '경제학과 경제분석가 금융',
    '법': '변호사 법학과 법무사 법조인',
    '의사': '의사 의학과 내과 외과',
    '교육': '교사 교육학과 강사 교수',
    '디자인': '디자이너 시각디자인 UX디자인 그래픽디자인',
    '음악': '음악가 음악학과 작곡 실용음악',
    '미술': '미술가 미술학과 회화 조소',
    '체육': '체육교사 체육학과 스포츠 트레이너',
    '요리': '요리사 조리사 셰프 조리학과',
    '건축': '건축가 건축학과 건축기사 건축설계',
    '회계': '회계사 회계학과 세무사 경리',
    '마케팅': '마케터 마케팅 광고 디지털마케팅',
    '심리': '심리학 심리상담사 상담심리 임상심리',
  }
  if (trimmed.length >= 2 && trimmed.length <= 5) {
    for (const [prefix, expansion] of Object.entries(DOMAIN_SUFFIX_MAP)) {
      if (trimmed === prefix || (trimmed.length <= 5 && trimmed.includes(prefix))) {
        const terms = expansion.split(/\s+/).filter(t => t.length >= 2)
        return {
          searchQuery: `${trimmed} ${expansion}`,
          keywordQuery: `${trimmed} ${expansion}`,
          expansionTerms: terms,
          isSlangExpanded: false,
        }
      }
    }
  }

  // 2. 짧은 쿼리(1-2글자) 의미 매핑: 동음이의어 해소 + 구체적 직업 확장
  if (trimmed.length <= 2) {
    const SHORT_QUERY_MAP: Record<string, string> = {
      '돈': '고소득 연봉 높은 변호사 의사 회계사 금융',
      '법': '변호사 판사 검사 법조인 법학',
      '약': '약사 약학 제약 한약사',
      '꽃': '플로리스트 화훼 원예사 꽃꽂이',
      '글': '작가 기자 카피라이터 편집자 소설',
      '차': '자동차정비사 자동차공학 모터스포츠',
      '옷': '패션디자이너 의류 스타일리스트 섬유',
      '집': '건축가 인테리어디자이너 부동산',
      '배': '항해사 선박 해운 선장',
      '숲': '산림치유지도사 조경 산림',
      '별': '천문학 천문학자 우주과학',
      '물': '수질환경기사 환경공학 수자원',
      '불': '소방관 소방 방재',
      '땅': '측량사 토목 부동산 감정평가사',
      '말': '통역사 번역가 언어학',
      'AI': '인공지능엔지니어 인공지능서비스개발자 데이터분석가',
    }
    const shortExpansion = SHORT_QUERY_MAP[trimmed]
    if (shortExpansion) {
      const terms = shortExpansion.split(/\s+/).filter(t => t.length >= 2)
      return {
        searchQuery: shortExpansion,
        keywordQuery: `${trimmed} ${shortExpansion}`,
        expansionTerms: terms,
        isSlangExpanded: true,
      }
    }
    return {
      searchQuery: `${trimmed} 관련 직업 전문가`,
      keywordQuery: trimmed,
      expansionTerms: [],
      isSlangExpanded: false,
    }
  }

  // 3. LLM 기반 쿼리 확장 (추상적 쿼리 대상)
  if (options?.enableExpansion && options.openaiApiKey && options.kv && trimmed.length >= 3) {
    const expanded = await expandQueryWithLLM(trimmed, options.openaiApiKey, options.kv)
    if (expanded) {
      const terms = expanded.split(/[,\s]+/).map(t => t.trim()).filter(t => t.length >= 2)
      return {
        searchQuery: `${trimmed} ${expanded}`,
        keywordQuery: `${trimmed} ${expanded}`,
        expansionTerms: terms,
        isSlangExpanded: false,
      }
    }
  }

  return { searchQuery: trimmed, keywordQuery: trimmed, expansionTerms: [], isSlangExpanded: false }
}

/**
 * LLM 기반 쿼리 확장: 추상적 쿼리를 구체적 직업 키워드로 변환
 * KV 캐시 (24시간 TTL)로 비용 최소화
 */
async function expandQueryWithLLM(
  query: string,
  openaiApiKey: string,
  kv: KVNamespace
): Promise<string | null> {
  try {
    // KV 캐시 확인
    const cacheKey = `qex:${await hashQuery(query)}`
    const cached = await kv.get(cacheKey)
    if (cached !== null) {
      return cached || null // 빈 문자열 = 확장 불필요로 판단된 캐시
    }

    // LLM 호출 (2초 타임아웃)
    const { response } = await callOpenAI(openaiApiKey, [
      {
        role: 'system',
        content: '당신은 한국어 직업 검색 도우미입니다. 사용자의 검색어를 보고, 관련될 수 있는 구체적인 직업명이나 직업 키워드를 3-5개 콤마로 구분해서 출력하세요. 검색어가 이미 구체적인 직업명이면 빈 문자열만 출력하세요.',
      },
      {
        role: 'user',
        content: `검색어: "${query}"`,
      },
    ], {
      temperature: 0.3,
      max_tokens: 100,
      timeout_ms: 2000,
    })

    const keywords = response.trim()

    // 캐시 저장 (24시간 TTL)
    await kv.put(cacheKey, keywords, { expirationTtl: 86400 }).catch(() => {})

    return keywords || null
  } catch {
    // LLM 실패 시 무시 (원본 쿼리 유지)
    return null
  }
}

// ============================================
// 쿼리 의도 감지 (Intent Detection) — Re-ranking용
// ============================================

interface IntentPattern {
  pattern: RegExp
  attribute: string // job_attributes 컬럼명
  weight: number    // boost 가중치
}

const INTENT_PATTERNS: IntentPattern[] = [
  // 소득/연봉
  { pattern: /연봉|돈|소득|월급|급여|수입|고소득|고연봉/, attribute: 'income', weight: 0.15 },
  // 안정성
  { pattern: /안정|철밥통|공무원|정규직/, attribute: 'stability', weight: 0.15 },
  // 워라밸
  { pattern: /워라밸|여유|칼퇴|야근/, attribute: 'wlb', weight: 0.15 },
  // 성장
  { pattern: /성장|발전|미래|전망|비전|유망|뜨는/, attribute: 'growth', weight: 0.15 },
  // HowTo: 방법/준비/절차 검색 (transactional intent)
  { pattern: /되는\s?법|되려면|되는\s?방법|하는\s?법|하는\s?방법|어떻게|준비\s?방법|공부\s?방법/, attribute: 'howto', weight: 0.20 },
  // HowTo: 자격증/시험/면허
  { pattern: /자격증|시험|면허|합격|준비/, attribute: 'howto', weight: 0.15 },
  // 분석적
  { pattern: /분석적|데이터분석|논리적|통계분석/, attribute: 'analytical', weight: 0.12 },
  // 창의적
  { pattern: /창의|디자인|예술|아이디어|창작/, attribute: 'creative', weight: 0.12 },
  // 사람 대면
  { pattern: /사람|대인|소통|상담|만나는/, attribute: 'people_facing', weight: 0.12 },
  // 독립/재택
  { pattern: /혼자서|독립적|자율근무|재택근무|원격근무|리모트/, attribute: 'solo_deep', weight: 0.12 },
  // 팀워크
  { pattern: /팀|협업|동료|함께/, attribute: 'teamwork', weight: 0.10 },
  // 실행/현장
  { pattern: /실행|실무|현장|손으로/, attribute: 'execution', weight: 0.10 },
]

/**
 * 쿼리에서 의도 감지: 매칭되는 attribute + weight 배열 반환
 */
function detectQueryIntents(query: string): { attribute: string; weight: number }[] {
  const intents: { attribute: string; weight: number }[] = []
  for (const { pattern, attribute, weight } of INTENT_PATTERNS) {
    if (pattern.test(query)) {
      intents.push({ attribute, weight })
    }
  }
  return intents
}

// ============================================
// 키워드 검색 함수 (하이브리드 검색용)
// ============================================

interface KeywordSearchHit {
  id: string
  keywordScore: number
}

/**
 * 한국어 복합어 분해: N-gram 기반 키워드 변형 생성
 * 예: "심리상담사" → ["심리상담사", "심리상담", "상담사", "심리"]
 * LIKE '%심리상담%'로 "심리상담전문가"도 매칭 가능
 */
function generateKoreanSubTerms(term: string): string[] {
  if (term.length <= 2) return [term]
  const variants = [term]
  // 3글자 이상: 앞쪽 N-1글자 (예: "심리상담사" → "심리상담")
  if (term.length >= 4) {
    variants.push(term.slice(0, term.length - 1))
  }
  // 4글자 이상: 뒤쪽 N-1글자 (예: "심리상담사" → "리상담사" → skip), 앞 2글자
  if (term.length >= 4) {
    const prefix = term.slice(0, 2)
    if (/[\uAC00-\uD7AF]{2}/.test(prefix) && !variants.includes(prefix)) {
      variants.push(prefix)
    }
  }
  return variants
}

async function keywordSearchJobIds(
  db: D1Database,
  query: string,
  limit: number = 30
): Promise<KeywordSearchHit[]> {
  try {
    // 이름 + 카테고리 + merged_profile_json 내 카테고리명으로 검색
    // json_extract로 display.categoryName도 매칭 (카테고리 컬럼이 빈 경우 보완)
    const result = await db.prepare(`
      SELECT j.id, j.name,
        (CASE WHEN j.name = ?1 THEN 100
              WHEN j.name LIKE ?2 THEN 80
              WHEN j.name LIKE ?3 THEN 60
              ELSE 0 END +
         CASE WHEN j.category LIKE ?3 THEN 20
              WHEN json_extract(j.merged_profile_json, '$.display.categoryName') LIKE ?3 THEN 20
              ELSE 0 END)
        as keyword_score
      FROM jobs j
      WHERE j.is_active = 1
        AND (j.name LIKE ?3 OR j.category LIKE ?3
          OR json_extract(j.merged_profile_json, '$.display.categoryName') LIKE ?3)
      ORDER BY keyword_score DESC
      LIMIT ?4
    `).bind(query, `${query}%`, `%${query}%`, limit).all<{
      id: string
      keyword_score: number
    }>()
    return (result.results || []).map(r => ({ id: r.id, keywordScore: r.keyword_score }))
  } catch {
    return []
  }
}

async function keywordSearchMajorIds(
  db: D1Database,
  query: string,
  limit: number = 30
): Promise<KeywordSearchHit[]> {
  try {
    const result = await db.prepare(`
      SELECT m.id, m.name,
        (CASE WHEN m.name = ?1 THEN 100
              WHEN m.name LIKE ?2 THEN 80
              WHEN m.name LIKE ?3 THEN 60
              ELSE 0 END)
        as keyword_score
      FROM majors m
      WHERE m.is_active = 1
        AND m.name LIKE ?3
      ORDER BY keyword_score DESC
      LIMIT ?4
    `).bind(query, `${query}%`, `%${query}%`, limit).all<{
      id: string
      keyword_score: number
    }>()
    return (result.results || []).map(r => ({ id: r.id, keywordScore: r.keyword_score }))
  } catch {
    return []
  }
}

async function keywordSearchHowtoIds(
  db: D1Database,
  query: string,
  limit: number = 10
): Promise<{ id: number; keywordScore: number }[]> {
  try {
    const result = await db.prepare(`
      SELECT p.id,
        (CASE WHEN p.title = ?1 THEN 100
              WHEN p.title LIKE ?2 THEN 80
              WHEN p.title LIKE ?3 THEN 60
              ELSE 0 END)
        as keyword_score
      FROM pages p
      WHERE p.page_type IN ('guide', 'howto')
        AND p.status = 'published'
        AND (p.title LIKE ?3 OR p.summary LIKE ?3)
      ORDER BY keyword_score DESC
      LIMIT ?4
    `).bind(query, `${query}%`, `%${query}%`, limit).all<{
      id: number
      keyword_score: number
    }>()
    return (result.results || []).map(r => ({ id: r.id, keywordScore: r.keyword_score }))
  } catch {
    return []
  }
}

// ============================================
// 키워드 검색 결과 병합 (확장 키워드용)
// ============================================

/**
 * 여러 키워드 검색 결과를 병합하고 중복 제거 (최고 점수 유지)
 */
function mergeKeywordHits(hitArrays: KeywordSearchHit[][]): KeywordSearchHit[] {
  const scoreMap = new Map<string, number>()
  for (const hits of hitArrays) {
    for (const hit of hits) {
      const existing = scoreMap.get(hit.id) || 0
      scoreMap.set(hit.id, Math.max(existing, hit.keywordScore))
    }
  }
  return Array.from(scoreMap.entries())
    .map(([id, keywordScore]) => ({ id, keywordScore }))
    .sort((a, b) => b.keywordScore - a.keywordScore)
}

// ============================================
// 확장 키워드 정확 매치 우선 주입 (Priority Injection)
// ============================================

/**
 * SLANG/LLM 확장 키워드의 정확 매치를 DB에서 찾아 RRF 결과 앞에 주입
 * 예: "로스쿨" → ["변호사","판사","검사"] → 이름이 정확히 일치하는 직업 ID를 최상단에 배치
 */
async function injectExactMatchJobs(
  db: D1Database,
  mergedIds: string[],
  keywordTerms: string[],
  originalQuery?: string,
  isSlangExpanded: boolean = false
): Promise<{ ids: string[]; relatedMajorNames: string[] }> {
  const fallback = { ids: mergedIds, relatedMajorNames: [] }
  const allTerms = [
    ...(originalQuery ? [originalQuery] : []),
    ...keywordTerms,
  ].filter(t => t.length >= 2)
  if (allTerms.length === 0) return fallback

  // Step 1: 정확 매치 + 접두사 매치 찾기
  let exactIds: string[] = []
  let prefixIds: string[] = []
  let otherIds: string[] = []
  let exactId: string | null = null
  try {
    // 공백 제거 버전도 IN 검색에 추가 (예: "웹 개발자" → "웹개발자" exact match)
    // LIKE prefix에는 추가하지 않음 — prefix 매칭은 sidebarJobs 노이즈 유발
    const noSpaceQuery = originalQuery ? originalQuery.replace(/\s+/g, '') : ''
    const termsWithNoSpace = [...new Set([...allTerms, ...(noSpaceQuery.length >= 2 ? [noSpaceQuery] : [])])].slice(0, 10)
    const placeholders = termsWithNoSpace.map(() => '?').join(',')
    const result = await db.prepare(
      `SELECT id, name FROM jobs WHERE is_active = 1 AND (name IN (${placeholders}) OR name LIKE ?||'%' OR name LIKE '%'||?||'%') LIMIT 20`
    ).bind(...termsWithNoSpace, originalQuery || '', originalQuery || '').all<{ id: string; name: string }>()
    if (!result.results || result.results.length === 0) return fallback
    // keywordTerms의 정확 매치도 exactIds로 분류 (SLANG "판검사"→"판사","검사" 등)
    const keywordTermSet = new Set(keywordTerms.map(t => t.trim()).filter(t => t.length >= 2))
    for (const r of result.results) {
      if (originalQuery && r.name === originalQuery) {
        exactIds.unshift(r.id)
        exactId = r.id
      } else if (noSpaceQuery && r.name === noSpaceQuery) {
        // 공백 제거 exact match: #1 순위 보장, sidebarJobs 주입은 안 함
        exactIds.unshift(r.id)
      } else if (keywordTermSet.has(r.name)) {
        // SLANG/확장 키워드의 IN 매치: exactIds로 분류 (판사, 검사 등)
        exactIds.push(r.id)
        if (!exactId) exactId = r.id
      } else if (originalQuery && r.name.startsWith(originalQuery)) {
        // SLANG 확장 쿼리: 학원강사 등 교육기관 prefix match 제외 (공무원→공무원학원강사 방지)
        if (isSlangExpanded && /학원|강사/.test(r.name) && !/강사$/.test(originalQuery)) {
          otherIds.push(r.id) // 우선순위 낮춤
        } else {
          prefixIds.push(r.id)
          if (!exactId) exactId = r.id
        }
      } else {
        otherIds.push(r.id)
      }
    }
  } catch {
    return fallback
  }

  // Step 2: 정확 매치가 있으면 → 카테고리 형제 + 관련 전공 조회 (별도 try/catch)
  let siblingIds: string[] = []
  let relatedMajorNames: string[] = []
  if (exactId) {
    // 2. profile에서 관련 직업 + 관련 전공 추출 (1회 DB 쿼리)
    try {
      const profileResult = await db.prepare(
        `SELECT merged_profile_json FROM jobs WHERE id = ?`
      ).bind(exactId).first<{ merged_profile_json: string | null }>()
      if (profileResult?.merged_profile_json) {
        const profile = JSON.parse(profileResult.merged_profile_json)

        // 2a. sidebarJobs에서 관련 직업 이름 → DB에서 ID 조회
        const relatedJobs = profile.sidebarJobs || []
        let relatedJobNames: string[] = relatedJobs
          .map((j: any) => j.jobNm || j.name || j)
          .filter((n: any) => typeof n === 'string' && n.length >= 2)
          .slice(0, 8)
        // SLANG 확장 쿼리: 관련 직업을 쿼리 키워드 관련 것만 필터링
        // (예: "심리학" → sidebarJobs 중 "심리" 포함 직업만 유지, "게이미피케이션전문가" 등 제거)
        if (isSlangExpanded && originalQuery && originalQuery.length >= 2) {
          const queryRoot = originalQuery.length >= 3 ? originalQuery.slice(0, originalQuery.length - 1) : originalQuery
          relatedJobNames = relatedJobNames.filter(name => name.includes(queryRoot))
        }
        if (relatedJobNames.length > 0) {
          try {
            const ph = relatedJobNames.map(() => '?').join(',')
            const sibResult = await db.prepare(
              `SELECT id FROM jobs WHERE is_active = 1 AND name IN (${ph}) LIMIT 8`
            ).bind(...relatedJobNames).all<{ id: string }>()
            siblingIds = (sibResult.results || []).map(r => r.id)
          } catch {}
        }

        // 2b. sidebarMajors에서 관련 전공 이름
        const majors = profile.sidebarMajors || profile.relatedMajors || []
        relatedMajorNames = majors
          .map((m: any) => m.majorNm || m.name || m)
          .filter((n: any) => typeof n === 'string' && n.length >= 2)
          .slice(0, 5)
      }
    } catch {}
  }

  // 우선순위: 정확 매치 → 접두사 매치 → 같은 카테고리 형제 → 확장 키워드 매치 → RRF 결과
  const priorityIds = [...exactIds, ...prefixIds, ...siblingIds, ...otherIds]
  const prioritySet = new Set(priorityIds)
  return {
    ids: [...priorityIds, ...mergedIds.filter(id => !prioritySet.has(id))],
    relatedMajorNames,
  }
}

/**
 * 확장 키워드 정확 매치 전공을 결과 앞에 주입
 */
async function injectExactMatchMajors(
  db: D1Database,
  mergedIds: string[],
  keywordTerms: string[],
  originalQuery?: string,
  relatedMajorNames?: string[]
): Promise<string[]> {
  // 원본 쿼리 + 확장 키워드 + 직업에서 가져온 관련 전공 이름
  const allTerms = [
    ...(originalQuery ? [originalQuery] : []),
    ...keywordTerms,
    ...(relatedMajorNames || []),
  ].filter(t => t.length >= 2)
  if (allTerms.length === 0) return mergedIds
  try {
    const terms = [...new Set(allTerms)].slice(0, 10)
    const placeholders = terms.map(() => '?').join(',')
    // 정확 이름 매치 OR 원본 쿼리로 시작하는 전공 OR 원본 쿼리가 이름에 포함된 전공
    // (예: "국어" → "국어국문학과", "심리학" → "심리학과", "응용심리학과")
    const result = await db.prepare(
      `SELECT id, name FROM majors WHERE is_active = 1 AND (name IN (${placeholders}) OR name LIKE ?||'%' OR name LIKE '%'||?||'%') LIMIT 15`
    ).bind(...terms, originalQuery || '', originalQuery || '').all<{ id: string; name: string }>()
    if (!result.results || result.results.length === 0) return mergedIds
    const exactIds: string[] = []
    const prefixIds: string[] = []
    const otherIds: string[] = []
    for (const r of result.results) {
      if (originalQuery && r.name === originalQuery) {
        exactIds.unshift(r.id)
      } else if (originalQuery && r.name.startsWith(originalQuery)) {
        prefixIds.push(r.id)
      } else {
        otherIds.push(r.id)
      }
    }
    const priorityIds = [...exactIds, ...prefixIds, ...otherIds]
    const prioritySet = new Set(priorityIds)
    return [...priorityIds, ...mergedIds.filter(id => !prioritySet.has(id))]
  } catch {
    return mergedIds
  }
}

// ============================================
// RRF (Reciprocal Rank Fusion) 결과 병합
// ============================================

const RRF_K = 60 // RRF 상수 (일반적으로 60 사용)

/**
 * 쿼리 특성에 따라 벡터/키워드 RRF 가중치를 동적 조정
 * - SLANG 확장 + 키워드 다수: 키워드 우선 (심리학 등 도메인 쿼리)
 * - 짧은 도메인 쿼리: 키워드 약간 우선
 * - 벡터 약/키워드 강: 키워드 우선
 * - 기본: 벡터 우선 0.7/0.3
 */
function calculateAdaptiveRRFWeights(
  query: string,
  isSlangExpanded: boolean,
  vectorHitCount: number,
  keywordHitCount: number
): { vectorWeight: number; keywordWeight: number } {
  // SLANG 확장 + 키워드 매칭 충분 → 키워드가 더 정확 (심리학→심리상담사 등)
  if (isSlangExpanded && keywordHitCount >= 5) {
    return { vectorWeight: 0.35, keywordWeight: 0.65 }
  }
  // 짧은 도메인 쿼리(2~5자) + 키워드 존재 → 키워드 약간 우선
  if (query.length <= 5 && keywordHitCount >= 3) {
    return { vectorWeight: 0.45, keywordWeight: 0.55 }
  }
  // 벡터 결과 약하고 키워드 풍부 → 키워드 우선
  if (vectorHitCount < 10 && keywordHitCount >= 10) {
    return { vectorWeight: 0.4, keywordWeight: 0.6 }
  }
  // 기본값: 벡터 우선
  return { vectorWeight: 0.7, keywordWeight: 0.3 }
}

/**
 * 벡터 검색 ID 순위 + 키워드 검색 ID 순위를 RRF로 병합
 * 반환: 병합된 ID 배열 (RRF score 내림차순)
 */
function mergeIdsWithRRF<T extends string | number>(
  vectorIds: T[],
  keywordHits: { id: T; keywordScore: number }[],
  vectorWeight: number = 0.7,
  keywordWeight: number = 0.3
): T[] {
  const scoreMap = new Map<T, number>()

  // 벡터 검색 RRF 점수
  for (let rank = 0; rank < vectorIds.length; rank++) {
    const id = vectorIds[rank]
    const rrfScore = vectorWeight / (RRF_K + rank + 1)
    scoreMap.set(id, (scoreMap.get(id) || 0) + rrfScore)
  }

  // 키워드 검색 RRF 점수
  for (let rank = 0; rank < keywordHits.length; rank++) {
    const { id } = keywordHits[rank]
    const rrfScore = keywordWeight / (RRF_K + rank + 1)
    scoreMap.set(id, (scoreMap.get(id) || 0) + rrfScore)
  }

  // RRF score 내림차순 정렬
  return Array.from(scoreMap.entries())
    .sort((a, b) => b[1] - a[1])
    .map(([id]) => id)
}

// ============================================
// Re-ranking: 속성 기반 결과 재정렬
// ============================================

interface JobAttributeRow {
  job_id: string
  income: number | null
  stability: number | null
  wlb: number | null
  growth: number | null
  analytical: number | null
  creative: number | null
  people_facing: number | null
  solo_deep: number | null
  teamwork: number | null
  execution: number | null
}

/**
 * intent가 감지되면 해당 속성 상위 직업 ID를 D1에서 조회하여 후보 풀 끝에 추가
 * 위치 강제 없이 re-ranking이 자연스럽게 정렬하도록 함
 * - 원래 좋은 결과 있으면 → 속성 상위 직업이 re-ranking에서 자연히 밀림
 * - 원래 결과가 의도 불일치면 → 속성 상위 직업이 re-ranking에서 자연히 올라감
 */
async function appendAttributeCandidates(
  db: D1Database,
  mergedIds: string[],
  intents: { attribute: string; weight: number }[],
  limit: number = 8
): Promise<string[]> {
  if (intents.length === 0) return mergedIds

  // 가장 weight가 높은 intent의 속성으로 상위 직업 조회
  const primary = intents.reduce((a, b) => a.weight > b.weight ? a : b)
  const validAttrs = ['income', 'stability', 'wlb', 'growth', 'analytical', 'creative', 'people_facing', 'solo_deep', 'teamwork', 'execution']
  if (!validAttrs.includes(primary.attribute)) return mergedIds

  try {
    const result = await db.prepare(`
      SELECT ja.job_id
      FROM job_attributes ja
      JOIN jobs j ON j.id = ja.job_id AND j.is_active = 1
      WHERE ja.${primary.attribute} >= 60
      ORDER BY ja.${primary.attribute} DESC
      LIMIT ?
    `).bind(limit).all<{ job_id: string }>()
    const attrIds = (result.results || []).map(r => r.job_id)
    if (attrIds.length === 0) return mergedIds
    // 기존 결과 뒤에 추가 (중복 제거)
    const existingSet = new Set(mergedIds)
    const newIds = attrIds.filter(id => !existingSet.has(id))
    return [...mergedIds, ...newIds]
  } catch {
    return mergedIds
  }
}

/**
 * 감지된 intent에 따라 직업 결과를 재정렬
 * 속성값이 70 이상인 경우 해당 intent weight만큼 boost
 */
// ============================================
// 복합 쿼리 필터 (Step 3: 카테고리 + 속성 필터)
// ============================================

const CATEGORY_FILTER_MAP: Record<string, string[]> = {
  'IT': ['정보통신', 'IT', '소프트웨어', '컴퓨터', '데이터', '인공지능', '보안'],
  '의료': ['보건', '의료', '의학', '간호', '약학', '치의학'],
  '교육': ['교육', '학교', '교사'],
  '금융': ['금융', '보험', '증권', '은행', '투자'],
  '법률': ['법률', '법조', '법무'],
  '예술': ['예술', '디자인', '미술', '음악', '공연'],
  '건설': ['건설', '건축', '토목'],
  '제조': ['제조', '생산', '공장'],
}

const CATEGORY_DETECT_PATTERNS: [RegExp, string][] = [
  [/IT|개발|프로그래|소프트웨어|코딩|컴퓨터|테크/, 'IT'],
  [/의료|병원|의사|간호|약/, '의료'],
  [/교육|교사|학교|강사/, '교육'],
  [/금융|은행|증권|투자/, '금융'],
  [/법률|변호사|법무|법조/, '법률'],
  [/예술|디자인|미술|음악/, '예술'],
  [/건설|건축|토목/, '건설'],
]

/**
 * 복합 쿼리에서 카테고리 필터 감지
 */
function detectCategoryFilter(query: string): string | null {
  for (const [pattern, category] of CATEGORY_DETECT_PATTERNS) {
    if (pattern.test(query)) return category
  }
  return null
}

/**
 * 복합 쿼리 필터: 카테고리 + 속성 기반 post-filtering
 * intent 2개 이상 + 카테고리 감지 시에만 적용
 * progressive relaxation: 결과 부족 시 기준 완화, 3개 미만이면 필터 포기
 */
function applyCompoundFilter(
  entries: UnifiedJobSummaryEntry[],
  attributeMap: Map<string, JobAttributeRow>,
  intents: { attribute: string; weight: number }[],
  categoryFilter: string | null
): UnifiedJobSummaryEntry[] {
  if (intents.length < 2 && !categoryFilter) return entries

  // 카테고리 필터 적용
  let filtered = entries
  if (categoryFilter) {
    const categoryKeywords = CATEGORY_FILTER_MAP[categoryFilter] || []
    const categoryFiltered = entries.filter(entry => {
      const catName = entry.display?.categoryName || ''
      return categoryKeywords.some(kw => catName.includes(kw))
    })
    // 3개 이상이면 필터 적용, 미만이면 필터 포기
    if (categoryFiltered.length >= 3) {
      filtered = categoryFiltered
    }
  }

  // 속성 필터: intent 속성이 모두 일정 기준 이상인 직업만 유지
  if (intents.length >= 2) {
    const nonHowtoIntents = intents.filter(i => i.attribute !== 'howto')
    if (nonHowtoIntents.length >= 2) {
      let threshold = 55
      // Progressive relaxation: 5개 이상 될 때까지 기준 완화
      for (let attempt = 0; attempt < 3; attempt++) {
        const attrFiltered = filtered.filter(entry => {
          const attrs = attributeMap.get(entry.profile.id)
          if (!attrs) return false
          return nonHowtoIntents.every(intent => {
            const value = (attrs as any)[intent.attribute] as number | null
            return value !== null && value !== undefined && value >= threshold
          })
        })
        if (attrFiltered.length >= 5) return attrFiltered
        if (attrFiltered.length >= 3) return attrFiltered
        threshold -= 15 // 완화: 55 → 40 → 25
      }
    }
  }

  return filtered
}

function rerankJobsByAttributes(
  entries: UnifiedJobSummaryEntry[],
  attributeMap: Map<string, JobAttributeRow>,
  intents: { attribute: string; weight: number }[]
): UnifiedJobSummaryEntry[] {
  if (intents.length === 0) return entries

  // 각 entry에 boost 점수 계산 (속성값에 비례)
  const scored = entries.map((entry, originalRank) => {
    const attrs = attributeMap.get(entry.profile.id)
    let boost = 0
    if (attrs) {
      for (const { attribute, weight } of intents) {
        const value = (attrs as any)[attribute] as number | null
        if (value !== null && value !== undefined && value >= 40) {
          boost += weight * (value / 100) // 비례 점수: stability=90 → 0.15*0.9=0.135
        }
      }
    }
    // 원래 순위 페널티: 로그 스케일로 1-10위(0~0.05), 10-100위(0.05~0.10) 범위로 자연스럽게 감쇠
    // 이전: originalRank * 0.008 → rank=20에서 0.16으로 boost 최대값(0.15) 초과
    const rankPenalty = Math.log10(originalRank + 1) * 0.05
    const blendedScore = boost - rankPenalty
    return { entry, originalRank, boost, blendedScore }
  })

  // blended score 내림차순 (속성 boost vs 원래 순위 균형)
  scored.sort((a, b) => b.blendedScore - a.blendedScore)

  return scored.map(s => s.entry)
}

// ============================================
// 타입 정의
// ============================================

export interface RagSearchOptions {
  jobsLimit?: number
  majorsLimit?: number
  howtosLimit?: number
}

export interface HowtoSearchResult {
  id: number
  slug: string
  title: string
  summary?: string
}

export interface RagUnifiedResult {
  jobs: UnifiedSearchResult<UnifiedJobSummaryEntry>
  majors: UnifiedSearchResult<UnifiedMajorSummaryEntry>
  howtos: HowtoSearchResult[]
}

// ============================================
// 임베딩 캐시 (KV)
// ============================================

async function getCachedEmbedding(kv: KVNamespace, query: string): Promise<number[] | null> {
  try {
    const key = `emb:${await hashQuery(query)}`
    const cached = await kv.get(key)
    if (!cached) return null
    // base64 → Float32Array → number[]
    const bytes = Uint8Array.from(atob(cached), c => c.charCodeAt(0))
    return Array.from(new Float32Array(bytes.buffer))
  } catch {
    return null
  }
}

async function cacheEmbedding(kv: KVNamespace, query: string, embedding: number[]): Promise<void> {
  try {
    const key = `emb:${await hashQuery(query)}`
    // number[] → Float32Array → base64
    const float32 = new Float32Array(embedding)
    const bytes = new Uint8Array(float32.buffer)
    const base64 = btoa(String.fromCharCode(...bytes))
    await kv.put(key, base64, { expirationTtl: 604800 }) // 7일
  } catch {
    // 캐시 실패는 무시
  }
}

async function hashQuery(query: string): Promise<string> {
  const encoder = new TextEncoder()
  const data = encoder.encode(query.toLowerCase().trim())
  const hashBuffer = await crypto.subtle.digest('SHA-256', data)
  const hashArray = Array.from(new Uint8Array(hashBuffer))
  return hashArray.map(b => b.toString(16).padStart(2, '0')).join('').slice(0, 16)
}

// ============================================
// Multi-Query Vectorize (topK 100 한계 우회)
// ============================================

/**
 * 쿼리를 1~5개 sub-query로 분해
 * - 원본 쿼리 (preprocessed searchQuery)
 * - 원본 사용자 입력 (다르면 추가)
 * - intent별 관점 쿼리 (income/stability/growth 등)
 */
const INTENT_SUBQUERY_MAP: Record<string, string> = {
  income: '높은 연봉 고소득 직업',
  stability: '안정적인 직업 정규직 공무원',
  wlb: '워라밸 좋은 직업 칼퇴',
  growth: '성장 가능성 미래 유망 직업',
  analytical: '데이터 분석 논리적 직업',
  creative: '창의적 디자인 예술 직업',
  people_facing: '사람 만나는 상담 소통 직업',
  solo_deep: '혼자 독립적 재택 원격 직업',
  teamwork: '팀 협업 함께 일하는 직업',
  execution: '실무 현장 실행 중심 직업',
}

function generateSubQueries(
  originalQuery: string,
  searchQuery: string,
  intents: { attribute: string; weight: number }[],
  isSlangExpanded: boolean = false
): string[] {
  const queries = new Set<string>([searchQuery])
  // 원본과 확장이 다르면 원본도 추가 (벡터 다양성)
  // 단, SLANG 확장된 쿼리는 확장 텍스트가 의미 정확 → 원본 추가하면 노이즈 유입 (연봉→재봉)
  if (!isSlangExpanded && originalQuery !== searchQuery && originalQuery.length >= 2) {
    queries.add(originalQuery)
  }
  // intent 2개 이상: intent별 sub-query 추가 (복합 쿼리에서 벡터 다양성 확보)
  if (intents.length >= 2) {
    for (const intent of intents) {
      if (intent.attribute === 'howto') continue // HowTo는 벡터 다양성에 불필요
      const subQ = INTENT_SUBQUERY_MAP[intent.attribute]
      if (subQ) queries.add(`${originalQuery} ${subQ}`)
    }
  }
  return Array.from(queries).slice(0, 5) // 최대 5개
}

/**
 * Multi-Query Vectorize: 여러 sub-query를 병렬로 Vectorize 검색
 * → 결과를 max score + hit count bonus로 병합
 * → 단일 쿼리 시 기존과 동일 (오버헤드 0)
 */
async function multiQueryVectorize(
  vectorize: VectorizeIndex,
  openaiApiKey: string,
  kv: KVNamespace,
  subQueries: string[]
): Promise<VectorizeMatches> {
  // 1. 각 sub-query의 임베딩 획득 (캐시 + 배치 생성)
  const embeddings: (number[] | null)[] = await Promise.all(
    subQueries.map(q => getCachedEmbedding(kv, q))
  )

  // 캐시 미스된 쿼리만 배치 임베딩
  const uncachedIndices: number[] = []
  const uncachedQueries: string[] = []
  for (let i = 0; i < subQueries.length; i++) {
    if (!embeddings[i]) {
      uncachedIndices.push(i)
      uncachedQueries.push(subQueries[i])
    }
  }

  if (uncachedQueries.length > 0) {
    const { embeddings: newEmbeddings } = await generateOpenAIEmbedding(openaiApiKey, uncachedQueries, 5000)
    for (let j = 0; j < uncachedIndices.length; j++) {
      const idx = uncachedIndices[j]
      embeddings[idx] = newEmbeddings[j]
      // 캐시 저장 (비동기)
      cacheEmbedding(kv, subQueries[idx], newEmbeddings[j]).catch(() => {})
    }
  }

  // 단일 쿼리: 기존과 동일 (오버헤드 0)
  if (subQueries.length === 1) {
    return vectorize.query(embeddings[0]!, { topK: 100, returnValues: false, returnMetadata: 'none' })
  }

  // 2. 병렬 Vectorize 검색
  const searchResults = await Promise.all(
    embeddings.map(emb =>
      vectorize.query(emb!, { topK: 100, returnValues: false, returnMetadata: 'none' })
    )
  )

  // 3. 병합: max score + hit count bonus
  const bestScoreMap = new Map<string, number>()
  const hitCountMap = new Map<string, number>()
  for (const result of searchResults) {
    for (const match of result.matches) {
      const existing = bestScoreMap.get(match.id)
      if (existing === undefined || match.score > existing) {
        bestScoreMap.set(match.id, match.score)
      }
      hitCountMap.set(match.id, (hitCountMap.get(match.id) || 0) + 1)
    }
  }

  // 4. 히트 카운트 보너스 적용 + matches 형태로 변환
  const mergedMatches = Array.from(bestScoreMap.entries())
    .map(([id, score]) => {
      const hits = hitCountMap.get(id) || 1
      const hitBonus = hits >= 3 ? Math.min(0.05, (hits - 2) * 0.015) : 0
      return { id, score: Math.min(1.0, score + hitBonus) }
    })
    .sort((a, b) => b.score - a.score)

  return { matches: mergedMatches, count: mergedMatches.length }
}

// ============================================
// 메인 통합 RAG 검색
// ============================================

/**
 * ragSearchUnified: 임베딩 1회 + Vectorize 1회 + D1 병렬 보강
 * 3단계 폴백: 벡터 검색 → LIKE 검색 → 빈 결과
 */
export async function ragSearchUnified(
  env: CareerWikiEnv,
  query: string,
  options: RagSearchOptions = {}
): Promise<RagUnifiedResult> {
  const { jobsLimit = 20, majorsLimit = 20, howtosLimit = 5 } = options
  const db = env.DB as unknown as D1Database
  const openaiApiKey = env.OPENAI_API_KEY as string | undefined
  const vectorize = env.VECTORIZE as VectorizeIndex | undefined
  const kv = env.KV as unknown as KVNamespace

  // OPENAI_API_KEY 또는 VECTORIZE 없으면 즉시 LIKE 폴백
  if (!openaiApiKey || !vectorize) {
    return likeFallback(env, query, { jobsLimit, majorsLimit, howtosLimit })
  }

  try {
    // 0. 쿼리 전처리 (속어 확장 + 컨텍스트 + LLM 확장)
    const enableExpansion = !!(env as any).ENABLE_QUERY_EXPANSION
    const { searchQuery, expansionTerms: keywordTerms, isSlangExpanded } = await preprocessQuery(query, {
      openaiApiKey, kv, enableExpansion,
    })

    // 0.5. 쿼리 의도 감지 (Re-ranking용)
    const intents = detectQueryIntents(query)

    // howto intent 감지 시: howtosLimit 확장 + HowTo 벡터 임계값 추가 완화
    const hasHowtoIntent = intents.some(i => i.attribute === 'howto')
    const effectiveHowtosLimit = hasHowtoIntent ? Math.max(howtosLimit, 10) : howtosLimit
    const effectiveHowtoVectorScore = hasHowtoIntent ? MIN_VECTOR_SCORE_HOWTO - 0.05 : MIN_VECTOR_SCORE_HOWTO

    // 1. Multi-Query Vectorize: sub-query 생성 → 병렬 벡터 검색 (topK 100 한계 우회)
    // 단순 쿼리(sub-query 1개)면 기존과 동일한 성능, 복합 쿼리면 최대 500개 후보
    const subQueries = generateSubQueries(query, searchQuery, intents, isSlangExpanded)
    let vectorResult: VectorizeMatches
    try {
      vectorResult = await multiQueryVectorize(vectorize, openaiApiKey, kv, subQueries)
    } catch (err: any) {
      return likeFallback(env, query, { jobsLimit, majorsLimit, howtosLimit })
    }

    // 2. 키워드 검색 병렬 실행 (확장 키워드 포함)
    // SLANG 확장 시 모든 확장 키워드 사용 (최대 6개), 아니면 3개
    // N-gram 분해: 한국어 복합어의 sub-term도 검색 (예: "심리상담사"→"심리상담"도 검색)
    const rawExpansionTerms = keywordTerms.slice(0, isSlangExpanded ? 6 : 3)
    const expansionTerms = isSlangExpanded
      ? [...new Set(rawExpansionTerms.flatMap(t => generateKoreanSubTerms(t)))].slice(0, 10)
      : rawExpansionTerms
    const [
      kwJobsOriginal,
      kwMajorsOriginal,
      kwHowtos,
      ...expansionResults
    ] = await Promise.all([
      keywordSearchJobIds(db, query, 30),
      keywordSearchMajorIds(db, query, 30),
      keywordSearchHowtoIds(db, query, 10),
      // 확장 키워드별 추가 검색 (직업 + 전공)
      ...expansionTerms.flatMap(term => [
        keywordSearchJobIds(db, term, 15),
        keywordSearchMajorIds(db, term, 15),
      ]),
    ])

    // 확장 키워드 검색 결과 병합
    const kwJobArrays: KeywordSearchHit[][] = [kwJobsOriginal]
    const kwMajorArrays: KeywordSearchHit[][] = [kwMajorsOriginal]
    for (let i = 0; i < expansionTerms.length; i++) {
      kwJobArrays.push(expansionResults[i * 2] as KeywordSearchHit[])
      kwMajorArrays.push(expansionResults[i * 2 + 1] as KeywordSearchHit[])
    }
    const kwJobs = mergeKeywordHits(kwJobArrays)
    const kwMajors = mergeKeywordHits(kwMajorArrays)

    // 3. 벡터 결과를 ID prefix로 분류 (최소 score 필터 적용)
    const vectorJobIds: string[] = []
    const vectorMajorIds: string[] = []
    const vectorHowtoIds: number[] = []
    const jobScores = new Map<string, number>()
    const majorScores = new Map<string, number>()

    for (const match of vectorResult.matches) {
      if (match.score < MIN_VECTOR_SCORE) continue

      if (match.id.startsWith('major:') || match.id.startsWith('m:')) {
        const id = (match.metadata as any)?.original_id || match.id.replace(/^major:|^m:/, '')
        vectorMajorIds.push(id)
        majorScores.set(id, match.score)
      } else if (match.id.startsWith('howto:')) {
        if (match.score < effectiveHowtoVectorScore) continue // HowTo는 더 높은 threshold (howto intent 시 완화)
        const id = parseInt(match.id.slice(6), 10)
        if (!isNaN(id)) vectorHowtoIds.push(id)
      } else {
        vectorJobIds.push(match.id)
        jobScores.set(match.id, match.score)
      }
    }

    // 4. Adaptive RRF 가중치 → 벡터 + 키워드 병합
    const rrfWeights = calculateAdaptiveRRFWeights(query, isSlangExpanded, vectorJobIds.length, kwJobs.length)
    let rrfJobIds = mergeIdsWithRRF(vectorJobIds, kwJobs, rrfWeights.vectorWeight, rrfWeights.keywordWeight)
    let rrfMajorIds = mergeIdsWithRRF(vectorMajorIds, kwMajors, rrfWeights.vectorWeight, rrfWeights.keywordWeight)
    const mergedHowtoIds = mergeIdsWithRRF(vectorHowtoIds, kwHowtos)

    // SLANG 확장된 쿼리에서 키워드 결과가 충분하면 → 키워드 결과를 최상위로 끌어올림
    // 벡터의 학술/도메인 노이즈(심리학→게이미피케이션) 방지
    if (isSlangExpanded && kwJobs.length >= 3) {
      const kwJobIdSet = new Set(kwJobs.map(h => h.id))
      const kwFirst = rrfJobIds.filter(id => kwJobIdSet.has(id))
      const rest = rrfJobIds.filter(id => !kwJobIdSet.has(id))
      rrfJobIds = [...kwFirst, ...rest]
    }
    if (isSlangExpanded && kwMajors.length >= 3) {
      const kwMajorIdSet = new Set(kwMajors.map(h => h.id))
      const kwFirst = rrfMajorIds.filter(id => kwMajorIdSet.has(id))
      const rest = rrfMajorIds.filter(id => !kwMajorIdSet.has(id))
      rrfMajorIds = [...kwFirst, ...rest]
    }

    // 정확 매치 우선 주입: 정확 일치 → 같은 카테고리 형제 → 확장 키워드 → RRF
    // injectExact* 함수는 원본 사용자 쿼리(query)를 기준으로 DB 이름 정확 매칭
    const exactJobResult = await injectExactMatchJobs(db, rrfJobIds, keywordTerms, query, isSlangExpanded)

    // 정확 직업 매치가 있고 관련 전공이 있으면, 벡터 전공 노이즈 필터링
    // 예: "변호사" 검색 시 벡터가 반환한 간호과/방사선과(score 0.3~0.4)를 제거
    let filteredMajorIds = rrfMajorIds
    if (exactJobResult.relatedMajorNames.length > 0) {
      filteredMajorIds = rrfMajorIds.filter(id => {
        const score = majorScores.get(id)
        // 키워드 매치(score 없음)는 유지, 벡터 score 0.5 미만은 제거
        return !score || score >= 0.5
      })
    }

    const exactMajorIds = await injectExactMatchMajors(
      db, filteredMajorIds, keywordTerms, query, exactJobResult.relatedMajorNames
    )

    // 4.5. 속성 기반 후보 추가: intent 감지 시 속성 상위 직업을 풀 끝에 추가
    const mergedJobIds = await appendAttributeCandidates(db, exactJobResult.ids, intents, 15)
    const mergedMajorIds = exactMajorIds

    // 5. D1 병렬 보강 — 속성 후보까지 포함하도록 충분히 가져옴
    // 복합 쿼리(카테고리+속성 필터) 시 더 많은 후보 필요 (필터 후 5개 이상 보장)
    const hasCompoundFilter = intents.length >= 2 && detectCategoryFilter(query) !== null
    const enrichLimit = hasCompoundFilter
      ? Math.min(mergedJobIds.length, 40) // 복합 필터: 충분한 후보 (최대 40)
      : intents.length > 0
        ? Math.min(mergedJobIds.length, 20) // 속성 후보까지 포함 (최대 20)
        : jobsLimit
    const [jobResult, majorEntries, howtoEntries] = await Promise.all([
      mergedJobIds.length > 0
        ? enrichJobsFromD1(db, mergedJobIds.slice(0, enrichLimit), jobScores)
        : Promise.resolve({ entries: [], attributeMap: new Map<string, JobAttributeRow>() }),
      mergedMajorIds.length > 0
        ? enrichMajorsFromD1(db, mergedMajorIds.slice(0, majorsLimit), majorScores)
        : Promise.resolve([]),
      mergedHowtoIds.length > 0
        ? enrichHowtosFromD1(db, mergedHowtoIds.slice(0, effectiveHowtosLimit))
        : Promise.resolve([]),
    ])

    // 6. 속성 기반 Re-ranking (intent 감지 시) + 복합 필터 + 최종 limit 적용
    // howto intent는 직업 속성이 아니므로 rerankJobsByAttributes에서 무시됨 (validAttrs에 없음)
    const reranked = rerankJobsByAttributes(jobResult.entries, jobResult.attributeMap, intents)
    const categoryFilter = detectCategoryFilter(query)
    const compoundFiltered = applyCompoundFilter(reranked, jobResult.attributeMap, intents, categoryFilter)
    // 복합 필터 결과가 부족하면 backfill (같은 카테고리 우선, 그 다음 나머지)
    let rankedJobs: UnifiedJobSummaryEntry[]
    if (compoundFiltered.length < jobsLimit && compoundFiltered !== reranked) {
      const existingIds = new Set(compoundFiltered.map(e => e.profile.id))
      const remaining = reranked.filter(e => !existingIds.has(e.profile.id))
      // 카테고리 필터가 있으면: 같은 카테고리 직업을 먼저 backfill
      if (categoryFilter) {
        const categoryKeywords = CATEGORY_FILTER_MAP[categoryFilter] || []
        const sameCat = remaining.filter(e => {
          const catName = e.display?.categoryName || ''
          return categoryKeywords.some(kw => catName.includes(kw))
        })
        const otherCat = remaining.filter(e => {
          const catName = e.display?.categoryName || ''
          return !categoryKeywords.some(kw => catName.includes(kw))
        })
        rankedJobs = [...compoundFiltered, ...sameCat, ...otherCat].slice(0, jobsLimit)
      } else {
        rankedJobs = [...compoundFiltered, ...remaining].slice(0, jobsLimit)
      }
    } else {
      rankedJobs = compoundFiltered.slice(0, jobsLimit)
    }

    // 7. 결과 부족한 타입은 LIKE로 보충
    const [supplementedJobs, supplementedMajors, supplementedHowtos] = await Promise.all([
      rankedJobs.length < 3
        ? supplementWithLike(env, query, 'jobs', jobsLimit, rankedJobs)
        : Promise.resolve(rankedJobs),
      majorEntries.length < 3
        ? supplementWithLike(env, query, 'majors', majorsLimit, majorEntries)
        : Promise.resolve(majorEntries),
      howtoEntries.length < 1
        ? supplementHowtosWithLike(db, query, effectiveHowtosLimit, howtoEntries)
        : Promise.resolve(howtoEntries),
    ])

    // 8. 관계 기반 검색 확장: 상위 직업의 관련 전공/가이드 추가
    const existingMajorIds = new Set(supplementedMajors.map(m => m.profile.id))
    const existingHowtoIds = new Set(supplementedHowtos.map(h => h.id))

    const { relatedMajors, relatedHowtos } = await expandWithRelatedContent(
      db, supplementedJobs, existingMajorIds, existingHowtoIds,
      { majors: Math.max(0, majorsLimit - supplementedMajors.length), howtos: Math.max(0, effectiveHowtosLimit - supplementedHowtos.length) },
      { original: query, keywordTerms }
    )

    const finalMajors = [...supplementedMajors, ...relatedMajors].slice(0, majorsLimit)

    // HowTo 최종 관련성 필터: 벡터/키워드 HowTo만 텍스트 필터 적용
    // 관계 기반 HowTo(relatedHowtos)는 howto_related_jobs DB 관계로 이미 검증됨 → 필터 없이 포함
    const howtoRelevanceTerms = [
      query,
      ...keywordTerms,
      ...supplementedJobs.slice(0, 5).map(j => j.profile.name),
    ].map(t => t.toLowerCase())
    const filteredSupplementedHowtos = supplementedHowtos.filter(h => {
      const t = (h.title || '').toLowerCase()
      const s = (h.summary || '').toLowerCase()
      return howtoRelevanceTerms.some(term => t.includes(term) || s.includes(term))
    })
    const finalHowtos = [...filteredSupplementedHowtos, ...relatedHowtos].slice(0, effectiveHowtosLimit)

    const defaultSources = createDefaultSourceStatus()

    return {
      jobs: {
        items: supplementedJobs.slice(0, jobsLimit),
        meta: { total: supplementedJobs.length, sources: defaultSources },
      },
      majors: {
        items: finalMajors,
        meta: { total: finalMajors.length, sources: defaultSources },
      },
      howtos: finalHowtos,
    }
  } catch (err: any) {
    return likeFallback(env, query, { jobsLimit, majorsLimit, howtosLimit })
  }
}

// ============================================
// 단일 도메인 RAG 검색 (API 엔드포인트용)
// ============================================

export async function ragSearchJobs(
  env: CareerWikiEnv,
  query: string,
  options?: { page?: number; perPage?: number }
): Promise<UnifiedSearchResult<UnifiedJobSummaryEntry>> {
  const page = options?.page || 1
  const perPage = options?.perPage || 20

  const openaiApiKey = env.OPENAI_API_KEY as string | undefined
  const vectorize = env.VECTORIZE as VectorizeIndex | undefined
  const kv = env.KV as unknown as KVNamespace

  if (!openaiApiKey || !vectorize) {
    return searchUnifiedJobs({ keyword: query, page, perPage }, env)
  }

  try {
    // 쿼리 전처리 + 의도 감지
    const enableExpansion = !!(env as any).ENABLE_QUERY_EXPANSION
    const { searchQuery, expansionTerms: keywordTerms, isSlangExpanded } = await preprocessQuery(query, {
      openaiApiKey, kv, enableExpansion,
    })
    const intents = detectQueryIntents(query)

    // Multi-Query Vectorize + 키워드 병렬 검색 (N-gram sub-term 포함)
    const subQueries = generateSubQueries(query, searchQuery, intents, isSlangExpanded)
    const rawExpansionTerms = keywordTerms.slice(0, isSlangExpanded ? 6 : 3)
    const expansionTerms = isSlangExpanded
      ? [...new Set(rawExpansionTerms.flatMap(t => generateKoreanSubTerms(t)))].slice(0, 10)
      : rawExpansionTerms
    const db = env.DB as unknown as D1Database
    const [vectorResult, kwJobsOriginal, ...expansionJobResults] = await Promise.all([
      multiQueryVectorize(vectorize, openaiApiKey, kv, subQueries),
      keywordSearchJobIds(db, query, 30),
      ...expansionTerms.map(term => keywordSearchJobIds(db, term, 15)),
    ])
    const kwJobs = mergeKeywordHits([kwJobsOriginal, ...expansionJobResults as KeywordSearchHit[][]])

    // 벡터 결과에서 직업 ID 추출
    const vectorJobIds: string[] = []
    const jobScores = new Map<string, number>()
    for (const match of vectorResult.matches) {
      if (!match.id.includes(':') && match.score >= MIN_VECTOR_SCORE) {
        vectorJobIds.push(match.id)
        jobScores.set(match.id, match.score)
      }
    }

    // Adaptive RRF 가중치 → 병합 + SLANG 키워드 우선 + 정확 매치 + 속성 후보
    const rrfWeights = calculateAdaptiveRRFWeights(query, isSlangExpanded, vectorJobIds.length, kwJobs.length)
    let rrfJobIds = mergeIdsWithRRF(vectorJobIds, kwJobs, rrfWeights.vectorWeight, rrfWeights.keywordWeight)
    if (isSlangExpanded && kwJobs.length >= 3) {
      const kwJobIdSet = new Set(kwJobs.map(h => h.id))
      const kwFirst = rrfJobIds.filter(id => kwJobIdSet.has(id))
      const rest = rrfJobIds.filter(id => !kwJobIdSet.has(id))
      rrfJobIds = [...kwFirst, ...rest]
    }
    const exactJobResult = await injectExactMatchJobs(db, rrfJobIds, keywordTerms, query, isSlangExpanded)
    const mergedJobIds = await appendAttributeCandidates(db, exactJobResult.ids, intents, 15)

    // 페이지네이션 적용
    const startIdx = (page - 1) * perPage
    const pageIds = mergedJobIds.slice(startIdx, startIdx + perPage)

    if (pageIds.length === 0) {
      return searchUnifiedJobs({ keyword: query, page, perPage }, env)
    }

    const jobResult = await enrichJobsFromD1(env.DB as unknown as D1Database, pageIds, jobScores)
    const rankedEntries = rerankJobsByAttributes(jobResult.entries, jobResult.attributeMap, intents)

    // 결과 부족하면 LIKE 보충
    if (rankedEntries.length < 3 && page === 1) {
      const supplemented = await supplementWithLike(env, query, 'jobs', perPage, rankedEntries)
      return {
        items: supplemented.slice(0, perPage),
        meta: { total: mergedJobIds.length, sources: createDefaultSourceStatus() },
      }
    }

    return {
      items: rankedEntries.slice(0, perPage),
      meta: { total: mergedJobIds.length, sources: createDefaultSourceStatus() },
    }
  } catch (err: any) {
    return searchUnifiedJobs({ keyword: query, page, perPage }, env)
  }
}

export async function ragSearchMajors(
  env: CareerWikiEnv,
  query: string,
  options?: { page?: number; perPage?: number }
): Promise<UnifiedSearchResult<UnifiedMajorSummaryEntry>> {
  const page = options?.page || 1
  const perPage = options?.perPage || 20

  const openaiApiKey = env.OPENAI_API_KEY as string | undefined
  const vectorize = env.VECTORIZE as VectorizeIndex | undefined
  const kv = env.KV as unknown as KVNamespace

  if (!openaiApiKey || !vectorize) {
    return searchUnifiedMajors({ keyword: query, page, perPage }, env)
  }

  try {
    // 쿼리 전처리
    const enableExpansion = !!(env as any).ENABLE_QUERY_EXPANSION
    const { searchQuery, expansionTerms: keywordTerms, isSlangExpanded } = await preprocessQuery(query, {
      openaiApiKey, kv, enableExpansion,
    })

    // Multi-Query Vectorize + 키워드 병렬 검색 (N-gram sub-term 포함)
    const intents = detectQueryIntents(query)
    const subQueries = generateSubQueries(query, searchQuery, intents, isSlangExpanded)
    const rawExpansionTerms = keywordTerms.slice(0, isSlangExpanded ? 6 : 3)
    const expansionTerms = isSlangExpanded
      ? [...new Set(rawExpansionTerms.flatMap(t => generateKoreanSubTerms(t)))].slice(0, 10)
      : rawExpansionTerms
    const db = env.DB as unknown as D1Database
    const [vectorResult, kwMajorsOriginal, ...expansionMajorResults] = await Promise.all([
      multiQueryVectorize(vectorize, openaiApiKey, kv, subQueries),
      keywordSearchMajorIds(db, query, 30),
      ...expansionTerms.map(term => keywordSearchMajorIds(db, term, 15)),
    ])
    const kwMajors = mergeKeywordHits([kwMajorsOriginal, ...expansionMajorResults as KeywordSearchHit[][]])

    const vectorMajorIds: string[] = []
    const majorScores = new Map<string, number>()
    for (const match of vectorResult.matches) {
      if ((match.id.startsWith('major:') || match.id.startsWith('m:')) && match.score >= MIN_VECTOR_SCORE) {
        const id = (match.metadata as any)?.original_id || match.id.replace(/^major:|^m:/, '')
        vectorMajorIds.push(id)
        majorScores.set(id, match.score)
      }
    }

    // Adaptive RRF 가중치 → 병합 + 정확 매치 우선 주입
    const rrfWeights = calculateAdaptiveRRFWeights(query, isSlangExpanded, vectorMajorIds.length, kwMajors.length)
    const rrfMajorIds = mergeIdsWithRRF(vectorMajorIds, kwMajors, rrfWeights.vectorWeight, rrfWeights.keywordWeight)
    const mergedMajorIds = await injectExactMatchMajors(db, rrfMajorIds, keywordTerms, query)

    const startIdx = (page - 1) * perPage
    const pageIds = mergedMajorIds.slice(startIdx, startIdx + perPage)

    if (pageIds.length === 0) {
      return searchUnifiedMajors({ keyword: query, page, perPage }, env)
    }

    const entries = await enrichMajorsFromD1(env.DB as unknown as D1Database, pageIds, majorScores)

    if (entries.length < 3 && page === 1) {
      const supplemented = await supplementWithLike(env, query, 'majors', perPage, entries)
      return {
        items: supplemented.slice(0, perPage),
        meta: { total: mergedMajorIds.length, sources: createDefaultSourceStatus() },
      }
    }

    return {
      items: entries.slice(0, perPage),
      meta: { total: mergedMajorIds.length, sources: createDefaultSourceStatus() },
    }
  } catch (err: any) {
    return searchUnifiedMajors({ keyword: query, page, perPage }, env)
  }
}

// ============================================
// D1 보강 함수: 직업
// ============================================

interface JobRow {
  id: string
  name: string
  slug: string | null
  primary_source: string | null
  merged_profile_json: string | null
  image_url: string | null
  // job_attributes (LEFT JOIN, nullable)
  attr_income: number | null
  attr_stability: number | null
  attr_wlb: number | null
  attr_growth: number | null
  attr_analytical: number | null
  attr_creative: number | null
  attr_people_facing: number | null
  attr_solo_deep: number | null
  attr_teamwork: number | null
  attr_execution: number | null
}

/**
 * enrichJobsFromD1: D1에서 직업 데이터 + 속성 데이터 조회
 * @returns [entries, attributeMap] — entries는 jobIds 순서 유지, attributeMap은 re-ranking용
 */
async function enrichJobsFromD1(
  db: D1Database,
  jobIds: string[],
  scores: Map<string, number>
): Promise<{ entries: UnifiedJobSummaryEntry[]; attributeMap: Map<string, JobAttributeRow> }> {
  if (jobIds.length === 0) return { entries: [], attributeMap: new Map() }

  const placeholders = jobIds.map(() => '?').join(',')
  const result = await db.prepare(`
    SELECT j.id, j.name, j.slug, j.primary_source, j.merged_profile_json, j.image_url,
      ja.income as attr_income, ja.stability as attr_stability, ja.wlb as attr_wlb,
      ja.growth as attr_growth, ja.analytical as attr_analytical, ja.creative as attr_creative,
      ja.people_facing as attr_people_facing, ja.solo_deep as attr_solo_deep,
      ja.teamwork as attr_teamwork, ja.execution as attr_execution
    FROM jobs j
    LEFT JOIN job_attributes ja ON j.id = ja.job_id
    WHERE j.id IN (${placeholders}) AND j.is_active = 1
  `).bind(...jobIds).all()

  if (!result.results) return { entries: [], attributeMap: new Map() }
  const rows = result.results as unknown as JobRow[]

  // Vectorize score 순서 유지
  const rowMap = new Map<string, JobRow>()
  for (const r of rows) rowMap.set(r.id, r)

  const entries: UnifiedJobSummaryEntry[] = []
  const attributeMap = new Map<string, JobAttributeRow>()

  for (const id of jobIds) {
    const row = rowMap.get(id)
    if (!row) continue
    entries.push(parseJobRowToEntry(row))
    // 속성 데이터 추출
    attributeMap.set(id, {
      job_id: id,
      income: row.attr_income,
      stability: row.attr_stability,
      wlb: row.attr_wlb,
      growth: row.attr_growth,
      analytical: row.attr_analytical,
      creative: row.attr_creative,
      people_facing: row.attr_people_facing,
      solo_deep: row.attr_solo_deep,
      teamwork: row.attr_teamwork,
      execution: row.attr_execution,
    })
  }

  return { entries, attributeMap }
}

/**
 * parseJobRowToEntry: D1 job row → UnifiedJobSummaryEntry 변환
 * searchUnifiedJobs의 파싱 로직과 동일한 출력 보장
 */
function parseJobRowToEntry(row: {
  id: string
  name: string
  slug: string | null
  primary_source: string | null
  merged_profile_json: string | null
  image_url: string | null
}): UnifiedJobSummaryEntry {
  const profile = row.merged_profile_json ? safeJsonParse(row.merged_profile_json) : {}
  const jobName = profile.name || row.name || '알 수 없음'
  const sources: DataSource[] = Array.isArray(profile.sources) ? profile.sources : ['CAREERNET']
  const sourceIds = profile.sourceIds || {}

  // Hero 설명 추출
  const heroDescription = extractFirstLine(
    profile.heroIntro || profile.summary || profile.work?.summary || profile.duties || profile.overviewWork?.main || ''
  )

  // 카테고리 추출
  let categoryName = ''
  let categoryLarge = ''
  let categoryMedium = ''
  let categorySmall = ''
  if (profile.heroCategory) {
    if (typeof profile.heroCategory === 'string') {
      categoryName = pickPrimaryCategory(profile.heroCategory)
      categoryLarge = categoryName
    } else if (typeof profile.heroCategory === 'object') {
      categoryName = profile.heroCategory.large || profile.heroCategory.value || profile.heroCategory.name || ''
      categoryLarge = profile.heroCategory.large || categoryName
      categoryMedium = profile.heroCategory.medium || ''
      categorySmall = profile.heroCategory.small || ''
    }
  }
  if (!categoryName) {
    categoryName = pickPrimaryCategory(profile.categoryName || profile.category?.name || '')
  }

  // 급여
  let salary = ''
  const salData = profile.salary || profile.overviewSalary?.wage || profile.overviewSalary?.sal
  if (salData) {
    const salStr = String(salData)
    const match = salStr.match(/평균\(50%\)\s*(\d[\d,]*만원)/)
    if (match) {
      salary = match[1]
    } else {
      const numMatch = salStr.match(/(\d[\d,]+)/)
      if (numMatch) salary = `${numMatch[1]}만원`
    }
  }

  // 만족도
  let satisfaction = ''
  const satisData = profile.satisfaction || profile.overviewAptitude?.satisfaction?.value || profile.overviewSalary?.jobSatis || profile.detailWlb?.satisfaction
  if (satisData) {
    const satStr = String(satisData).trim()
    satisfaction = /^\d+(\.\d+)?$/.test(satStr) ? `${satStr}%` : satStr
  }

  // WLB
  const wlb = profile.wlb || profile.detailWlb?.wlb || ''

  // 작업 강도
  let workStrong = ''
  const wsData = profile.overviewWork?.workStrong || profile.optionJobInfo?.workStrong
  if (wsData) {
    const wsStr = String(wsData)
    if (wsStr.includes('가벼운')) workStrong = '가벼움'
    else if (wsStr.includes('아주 힘든')) workStrong = '아주 힘듬'
    else if (wsStr.includes('힘든')) workStrong = '힘듬'
    else if (wsStr.includes('보통')) workStrong = '보통'
    else workStrong = wsStr
  }

  // 숙련기간
  let skillYear = ''
  const syData = profile.overviewAbilities?.skillYear || profile.optionJobInfo?.skillYear
  if (syData) {
    skillYear = String(syData).replace(/초과|이하/g, '').trim()
  }

  return {
    profile: {
      id: row.id || jobName,
      sourceIds: {
        careernet: sourceIds.careernet,
        goyong24: sourceIds.goyong24 || sourceIds.work24_job || sourceIds.work24_djob,
      },
      name: jobName,
      category: categoryName ? { name: categoryName } : undefined,
      sources,
    },
    sourceMeta: {
      careernet: sourceIds.careernet ? { jobdicSeq: sourceIds.careernet } : undefined,
      goyong24: sourceIds.goyong24 ? { jobCd: sourceIds.goyong24 } : undefined,
    },
    display: {
      summary: heroDescription,
      categoryName,
      categoryLarge,
      categoryMedium,
      categorySmall,
      salary,
      satisfaction,
      wlb: String(wlb),
      workStrong,
      skillYear,
      imageUrl: row.image_url || profile.image_url || undefined,
    },
  }
}

// ============================================
// D1 보강 함수: 전공
// ============================================

interface MajorRow {
  id: string
  name: string
  slug: string | null
  careernet_id: string | null
  goyong24_id: string | null
  merged_profile_json: string | null
  api_data_json: string | null
  image_url: string | null
}

async function enrichMajorsFromD1(
  db: D1Database,
  majorIds: string[],
  scores: Map<string, number>
): Promise<UnifiedMajorSummaryEntry[]> {
  if (majorIds.length === 0) return []

  const placeholders = majorIds.map(() => '?').join(',')
  const result = await db.prepare(`
    SELECT id, name, slug, careernet_id, goyong24_id, merged_profile_json, api_data_json, image_url
    FROM majors
    WHERE id IN (${placeholders}) AND is_active = 1
  `).bind(...majorIds).all()

  if (!result.results) return []
  const rows = result.results as unknown as MajorRow[]

  const rowMap = new Map<string, MajorRow>()
  for (const r of rows) rowMap.set(r.id, r)

  const entries: UnifiedMajorSummaryEntry[] = []
  for (const id of majorIds) {
    const row = rowMap.get(id)
    if (!row) continue
    entries.push(parseMajorRowToEntry(row))
  }

  return entries
}

/**
 * parseMajorRowToEntry: D1 major row → UnifiedMajorSummaryEntry 변환
 */
function parseMajorRowToEntry(row: {
  id: string
  name: string
  slug: string | null
  careernet_id: string | null
  goyong24_id: string | null
  merged_profile_json: string | null
  api_data_json: string | null
  image_url: string | null
}): UnifiedMajorSummaryEntry {
  const mp = row.merged_profile_json ? safeJsonParse(row.merged_profile_json) : null
  const majorName = mp?.name || row.name || '알 수 없음'
  const sources: DataSource[] = Array.isArray(mp?.sources) ? mp.sources : ['CAREERNET']
  const careernetId = row.careernet_id && row.careernet_id !== 'null' ? row.careernet_id : mp?.sourceIds?.careernet
  const goyongId = row.goyong24_id && row.goyong24_id !== 'null' ? row.goyong24_id : mp?.sourceIds?.work24

  // 프로필 기본 정보
  const profileObj = {
    id: row.slug || row.id || majorName,
    sourceIds: {
      careernet: careernetId,
      goyong24: goyongId,
    },
    name: majorName,
    categoryName: mp?.categoryDisplay || mp?.categoryName || '',
    summary: mp?.heroSummary || mp?.summary || '',
    sources,
  }

  // Display 정보 추출
  let summary = mp?.heroSummary?.trim() || mp?.summary?.trim() || ''
  let categoryName = mp?.categoryDisplay?.trim() || mp?.categoryName?.trim() || ''
  let employmentRate = ''
  let firstJobSalary = mp?.salaryAfterGraduation?.trim() || ''
  let firstJobSatisfaction = ''
  let universityCount = ''
  let relatedJobCount = ''

  if (mp) {
    // 취업률: chartData에서 추출
    if (mp.chartData) {
      const empData = mp.chartData?.employment_rate || mp.chartData?.[0]?.employment_rate
      if (Array.isArray(empData)) {
        const total = empData.find((e: any) => e.item === '전체')
        if (total?.data) {
          const rate = parseFloat(total.data)
          employmentRate = rate > 0 ? (Number.isInteger(rate) ? `${rate}%` : `${rate.toFixed(1)}%`) : ''
        }
      }
    }
    if (!employmentRate && mp.employmentRate) {
      employmentRate = String(mp.employmentRate).includes('%') ? mp.employmentRate : `${mp.employmentRate}%`
    }

    // 만족도: chartData.satisfaction에서 "만족" + "매우 만족" 합산
    if (mp.chartData?.satisfaction) {
      const satisArr = mp.chartData.satisfaction
      if (Array.isArray(satisArr)) {
        let satisfiedSum = 0
        for (const item of satisArr) {
          if (item.item === '만족' || item.item === '매우 만족') {
            satisfiedSum += parseFloat(item.data || '0')
          }
        }
        if (satisfiedSum > 0) {
          firstJobSatisfaction = `${satisfiedSum.toFixed(1)}%`
        }
      }
    }

    // 대학/직업 수
    if (Array.isArray(mp.universities) && mp.universities.length > 0) {
      universityCount = String(mp.universities.length)
    }
    if (Array.isArray(mp.relatedJobs) && mp.relatedJobs.length > 0) {
      relatedJobCount = String(mp.relatedJobs.length)
    }
  }

  return {
    profile: profileObj,
    sourceMeta: {
      careernet: careernetId ? { majorSeq: careernetId } : undefined,
      goyong24: goyongId ? { majorGb: mp?.majorGb || '1', departmentId: mp?.departmentId || '', majorId: goyongId } : undefined,
    },
    display: {
      summary,
      categoryName,
      employmentRate,
      salaryAfterGraduation: firstJobSalary,
      firstJobSalary,
      firstJobSatisfaction,
      universityCount: universityCount || undefined,
      relatedJobCount: relatedJobCount || undefined,
      imageUrl: row.image_url || mp?.image_url || undefined,
    },
  }
}

// ============================================
// D1 보강 함수: HowTo/가이드
// ============================================

interface HowtoRow {
  id: number
  slug: string
  title: string
  summary: string | null
}

async function enrichHowtosFromD1(
  db: D1Database,
  howtoIds: number[]
): Promise<HowtoSearchResult[]> {
  if (howtoIds.length === 0) return []

  const placeholders = howtoIds.map(() => '?').join(',')
  const result = await db.prepare(`
    SELECT id, slug, title, summary
    FROM pages
    WHERE id IN (${placeholders}) AND status = 'published'
  `).bind(...howtoIds).all()

  if (!result.results) return []
  const rows = result.results as unknown as HowtoRow[]

  // Vectorize score 순서 유지
  const rowMap = new Map<number, HowtoRow>()
  for (const r of rows) rowMap.set(r.id, r)

  const entries: HowtoSearchResult[] = []
  for (const id of howtoIds) {
    const row = rowMap.get(id)
    if (!row) continue
    entries.push({
      id: row.id,
      slug: row.slug,
      title: row.title,
      summary: row.summary || undefined,
    })
  }

  return entries
}

// ============================================
// LIKE 폴백 + 보충 함수
// ============================================

async function likeFallback(
  env: CareerWikiEnv,
  query: string,
  options: { jobsLimit: number; majorsLimit: number; howtosLimit: number }
): Promise<RagUnifiedResult> {
  const [jobResult, majorResult, howtoResult] = await Promise.all([
    searchUnifiedJobs({ keyword: query, page: 1, perPage: options.jobsLimit }, env),
    searchUnifiedMajors({ keyword: query, page: 1, perPage: options.majorsLimit }, env),
    likeSearchHowtos(env.DB as unknown as D1Database, query, options.howtosLimit),
  ])

  return {
    jobs: jobResult,
    majors: majorResult,
    howtos: howtoResult,
  }
}

async function supplementWithLike<T extends UnifiedJobSummaryEntry | UnifiedMajorSummaryEntry>(
  env: CareerWikiEnv,
  query: string,
  type: 'jobs' | 'majors',
  limit: number,
  existing: T[]
): Promise<T[]> {
  const existingIds = new Set(existing.map(e => e.profile.id))

  if (type === 'jobs') {
    const likeResult = await searchUnifiedJobs({ keyword: query, page: 1, perPage: limit }, env)
    const newItems = likeResult.items.filter(item => !existingIds.has(item.profile.id))
    return [...existing, ...newItems].slice(0, limit) as T[]
  } else {
    const likeResult = await searchUnifiedMajors({ keyword: query, page: 1, perPage: limit }, env)
    const newItems = likeResult.items.filter(item => !existingIds.has(item.profile.id))
    return [...existing, ...newItems].slice(0, limit) as T[]
  }
}

async function supplementHowtosWithLike(
  db: D1Database,
  query: string,
  limit: number,
  existing: HowtoSearchResult[]
): Promise<HowtoSearchResult[]> {
  const existingIds = new Set(existing.map(e => e.id))
  const likeResult = await likeSearchHowtos(db, query, limit)
  const newItems = likeResult.filter(item => !existingIds.has(item.id))
  return [...existing, ...newItems].slice(0, limit)
}

async function likeSearchHowtos(
  db: D1Database,
  query: string,
  limit: number
): Promise<HowtoSearchResult[]> {
  try {
    const result = await db.prepare(`
      SELECT id, slug, title, summary
      FROM pages
      WHERE page_type IN ('guide', 'howto')
        AND status = 'published'
        AND (title LIKE ? OR summary LIKE ?)
      ORDER BY
        CASE WHEN LOWER(title) = LOWER(?) THEN 0
             WHEN LOWER(title) LIKE LOWER(?) THEN 1
             ELSE 2
        END,
        updated_at DESC
      LIMIT ?
    `).bind(`%${query}%`, `%${query}%`, query, `${query}%`, limit).all()

    const rows = (result.results || []) as unknown as HowtoRow[]
    return rows.map(row => ({
      id: row.id,
      slug: row.slug,
      title: row.title,
      summary: row.summary || undefined,
    }))
  } catch {
    return []
  }
}

// ============================================
// 관계 기반 검색 확장 (Lightweight Graph Expansion)
// ============================================

/**
 * 검색 결과의 상위 직업에서 관련 전공/가이드를 추가로 찾아 결과에 합침
 * howto_related_jobs, howto_related_majors 테이블 활용
 */
async function expandWithRelatedContent(
  db: D1Database,
  jobEntries: UnifiedJobSummaryEntry[],
  existingMajorIds: Set<string>,
  existingHowtoIds: Set<number>,
  limits: { majors: number; howtos: number },
  queryContext?: { original: string; keywordTerms: string[] }
): Promise<{ relatedMajors: UnifiedMajorSummaryEntry[]; relatedHowtos: HowtoSearchResult[] }> {
  if (jobEntries.length === 0) return { relatedMajors: [], relatedHowtos: [] }

  // 상위 5개 직업의 ID와 이름
  const topJobEntries = jobEntries.slice(0, 5)
  const topJobIds = topJobEntries.map(e => e.profile.id)
  const topJobNames = topJobEntries.map(e => e.profile.name)
  const placeholders = topJobIds.map(() => '?').join(',')

  try {
    // 관련 가이드 조회 (3개 소스 병렬: howto_related_jobs + pages.meta_data + howto_related_majors)
    const [howtosResult, guideResult, relatedJobMajorsResult] = await Promise.all([
      db.prepare(`
        SELECT DISTINCT p.id, p.slug, p.title, p.summary
        FROM howto_related_jobs hrj
        JOIN pages p ON hrj.howto_id = p.id
        WHERE hrj.job_id IN (${placeholders})
          AND p.status = 'published'
        LIMIT ?
      `).bind(...topJobIds, limits.howtos).all<HowtoRow>(),
      // 가이드 페이지의 meta_data.relatedJobs에서 직업 관계 검색
      limits.howtos > 0
        ? db.prepare(`
            SELECT id, slug, title, summary, meta_data
            FROM pages
            WHERE page_type = 'guide' AND status = 'published'
            LIMIT 50
          `).all<HowtoRow & { meta_data: string }>()
        : Promise.resolve({ results: [] as (HowtoRow & { meta_data: string })[] }),
      // 직업의 관련 전공 (merged_profile_json.relatedMajors에서)
      db.prepare(`
        SELECT DISTINCT m.id, m.name, m.slug, m.careernet_id, m.goyong24_id,
          m.merged_profile_json, m.api_data_json, m.image_url
        FROM howto_related_majors hrm
        JOIN majors m ON hrm.major_id = m.id
        JOIN howto_related_jobs hrj ON hrm.howto_id = hrj.howto_id
        WHERE hrj.job_id IN (${placeholders})
          AND m.is_active = 1
        LIMIT ?
      `).bind(...topJobIds, limits.majors).all<MajorRow>(),
    ])

    // 1) howto_related_jobs 결과 (DB 관계 기반)
    const newHowtos = (howtosResult.results || [])
      .filter(r => !existingHowtoIds.has(r.id))
      .map(r => ({ id: r.id, slug: r.slug, title: r.title, summary: r.summary || undefined }))

    // 2) pages.meta_data.relatedJobs 결과 (가이드 페이지 내 관련 직업 선언)
    const foundIds = new Set([...existingHowtoIds, ...newHowtos.map(h => h.id)])
    const topJobIdSet = new Set(topJobIds)
    const metaHowtos = (guideResult.results || [])
      .filter(r => {
        if (foundIds.has(r.id)) return false
        try {
          const meta = JSON.parse(r.meta_data || '{}')
          return (meta.relatedJobs || []).some((j: any) => topJobIdSet.has(j.id))
        } catch { return false }
      })
      .map(r => ({ id: r.id, slug: r.slug, title: r.title, summary: r.summary || undefined }))

    const allRelatedHowtos = [...newHowtos, ...metaHowtos]

    const newMajors = (relatedJobMajorsResult.results || [])
      .filter(r => !existingMajorIds.has(r.id))
      .map(r => parseMajorRowToEntry(r))

    return { relatedMajors: newMajors, relatedHowtos: allRelatedHowtos }
  } catch {
    return { relatedMajors: [], relatedHowtos: [] }
  }
}

// ============================================
// 유틸리티 함수
// ============================================

function safeJsonParse(json: string): any {
  try {
    return JSON.parse(json)
  } catch {
    return null
  }
}

function extractFirstLine(text: string): string {
  if (!text) return ''
  return text.split('\n')[0].trim()
}

function pickPrimaryCategory(value: any): string {
  let cat = ''
  if (typeof value === 'string') {
    cat = value
  } else if (value && typeof value === 'object') {
    cat = value.large || value.value || value.name || value.medium || value.small || ''
  }
  if (cat.includes('›')) {
    cat = cat.split('›')[0].trim()
  } else if (cat.includes('>')) {
    cat = cat.split('>')[0].trim()
  }
  return cat
}

function createDefaultSourceStatus(): SourceStatusRecord {
  return {
    CAREERNET: { attempted: true, count: 0 },
    GOYONG24: { attempted: true, count: 0 },
    WORK24_JOB: { attempted: false, count: 0 },
    WORK24_DJOB: { attempted: false, count: 0 },
    WORK24_MAJOR: { attempted: false, count: 0 },
    AI: { attempted: false, count: 0 },
    USER_CONTRIBUTED: { attempted: false, count: 0 },
    ADMIN_OVERRIDE: { attempted: false, count: 0 },
  }
}

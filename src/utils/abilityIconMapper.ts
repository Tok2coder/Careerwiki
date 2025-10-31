/**
 * 역량(ability)과 지식(knowledge)을 Lucide 아이콘으로 매핑하는 유틸리티
 * 동일한 역량 이름은 항상 같은 아이콘을 반환합니다.
 * 
 * Lucide Icons: https://lucide.dev/icons/
 */

interface IconMapping {
  icon: string;  // Lucide 아이콘 이름
  color: string; // Tailwind CSS 색상 클래스
}

/**
 * 역량별 Lucide 아이콘 매핑 테이블
 * icon: Lucide 아이콘 이름 (예: 'message-circle')
 * color: Tailwind CSS 색상 클래스
 */
const ABILITY_ICON_MAP: Record<string, IconMapping> = {
  // 의사소통 & 대인관계
  '의사소통능력': { icon: 'message-circle', color: 'text-blue-400' },
  '대인관계능력': { icon: 'users', color: 'text-blue-400' },
  '설득': { icon: 'handshake', color: 'text-green-400' },
  '협상': { icon: 'scale', color: 'text-purple-400' },
  '서비스지향': { icon: 'smile', color: 'text-pink-400' },
  '협조': { icon: 'users-round', color: 'text-teal-400' },
  '말하기': { icon: 'mic', color: 'text-purple-300' },
  '듣고이해하기': { icon: 'ear', color: 'text-teal-300' },
  
  // 인지능력 & 학습
  '논리적분석': { icon: 'brain', color: 'text-indigo-400' },
  '추리력': { icon: 'lightbulb', color: 'text-yellow-400' },
  '수리력': { icon: 'calculator', color: 'text-cyan-400' },
  '수리·논리력': { icon: 'calculator', color: 'text-cyan-400' },
  '학습전략': { icon: 'book-open', color: 'text-orange-400' },
  '모니터링': { icon: 'activity', color: 'text-green-500' },
  '기억력': { icon: 'brain-circuit', color: 'text-purple-500' },
  '범주화': { icon: 'layers', color: 'text-gray-400' },
  '정보수집': { icon: 'search', color: 'text-teal-400' },
  
  // 문제해결 & 의사결정
  '문제해결능력': { icon: 'puzzle', color: 'text-red-400' },
  '판단과의사결정': { icon: 'gavel', color: 'text-amber-500' },
  '창의력': { icon: 'palette', color: 'text-pink-500' },
  '전략수립': { icon: 'target', color: 'text-gray-400' },
  
  // 시스템 & 기술
  '시스템분석': { icon: 'network', color: 'text-blue-500' },
  '시스템평가': { icon: 'clipboard-check', color: 'text-green-400' },
  '작동점검': { icon: 'wrench', color: 'text-orange-500' },
  '기술분석': { icon: 'cpu', color: 'text-purple-400' },
  '기술설계': { icon: 'drafting-compass', color: 'text-teal-500' },
  '프로그래밍': { icon: 'code', color: 'text-green-500' },
  '장비선정': { icon: 'settings', color: 'text-gray-500' },
  '품질관리분석': { icon: 'award', color: 'text-yellow-400' },
  
  // 자원관리
  '시간관리': { icon: 'clock', color: 'text-blue-400' },
  '재정자원관리': { icon: 'dollar-sign', color: 'text-green-600' },
  '물적자원관리': { icon: 'package', color: 'text-brown-400' },
  '인적자원관리': { icon: 'user-cog', color: 'text-indigo-400' },
  
  // 리더십 & 관리
  '리더십': { icon: 'crown', color: 'text-yellow-500' },
  '경영': { icon: 'briefcase', color: 'text-gray-600' },
  '조직체계의이해와적용': { icon: 'git-branch', color: 'text-blue-600' },
  
  // 언어 & 글쓰기
  '언어능력': { icon: 'languages', color: 'text-blue-400' },
  '읽기': { icon: 'book', color: 'text-blue-300' },
  '쓰기': { icon: 'pen', color: 'text-indigo-300' },
  
  // 신체 & 감각
  '신체적강인성': { icon: 'dumbbell', color: 'text-red-500' },
  '신체의유연성및균형': { icon: 'person-standing', color: 'text-orange-400' },
  '정교한동작': { icon: 'hand', color: 'text-pink-400' },
  '시력': { icon: 'eye', color: 'text-cyan-400' },
  '청력': { icon: 'ear', color: 'text-blue-400' },
  
  // 자기관리
  '자기성찰능력': { icon: 'user-check', color: 'text-purple-400' },
  '자기통제': { icon: 'shield-check', color: 'text-blue-400' },
  
  // 기술 작업
  '설치': { icon: 'plug', color: 'text-orange-400' },
  '수리': { icon: 'wrench', color: 'text-red-400' },
  '운전및조작': { icon: 'car', color: 'text-blue-500' },
  
  // 지식 관련
  '국어': { icon: 'book-a', color: 'text-green-400' },
  '영어': { icon: 'globe', color: 'text-blue-400' },
  '수학': { icon: 'calculator', color: 'text-purple-400' },
  '과학': { icon: 'flask-conical', color: 'text-cyan-400' },
  '법률': { icon: 'scale', color: 'text-indigo-500' },
  '의료': { icon: 'heart-pulse', color: 'text-red-500' },
  '교육및훈련': { icon: 'graduation-cap', color: 'text-orange-500' },
  '경제및회계': { icon: 'chart-pie', color: 'text-green-500' },
  '마케팅': { icon: 'megaphone', color: 'text-pink-500' },
  '디자인': { icon: 'palette', color: 'text-purple-500' },
  '건축': { icon: 'building', color: 'text-gray-500' },
  '기계': { icon: 'cog', color: 'text-blue-600' },
  '전기전자': { icon: 'zap', color: 'text-yellow-600' },
  '컴퓨터': { icon: 'laptop', color: 'text-teal-600' },
}

/**
 * 기본 아이콘 (매핑되지 않은 역량에 사용)
 */
const DEFAULT_ICON: IconMapping = {
  icon: 'sparkles',
  color: 'text-gray-400'
}

/**
 * 역량 이름을 정규화합니다 (공백, 특수문자 제거)
 */
function normalizeAbilityName(name: string): string {
  return name
    .trim()
    .toLowerCase()
    .replace(/\s+/g, '')
    .replace(/[()·]/g, '')
}

/**
 * 역량 이름에 해당하는 Lucide 아이콘을 반환합니다.
 * 
 * @param abilityName - 역량 이름 (예: "의사소통능력", "논리적 분석")
 * @returns IconMapping 객체 { icon, color }
 */
export function getAbilityIcon(abilityName: string): IconMapping {
  const normalized = normalizeAbilityName(abilityName)
  
  // 정확한 매칭 시도
  for (const [key, value] of Object.entries(ABILITY_ICON_MAP)) {
    if (normalizeAbilityName(key) === normalized) {
      return value
    }
  }
  
  // 부분 매칭 시도 (키워드 포함)
  for (const [key, value] of Object.entries(ABILITY_ICON_MAP)) {
    const normalizedKey = normalizeAbilityName(key)
    if (normalized.includes(normalizedKey) || normalizedKey.includes(normalized)) {
      return value
    }
  }
  
  // 키워드 기반 매칭 (fallback)
  if (normalized.includes('소통') || normalized.includes('대화') || normalized.includes('커뮤니케이션')) {
    return ABILITY_ICON_MAP['의사소통능력']
  }
  if (normalized.includes('분석') || normalized.includes('논리')) {
    return ABILITY_ICON_MAP['논리적분석']
  }
  if (normalized.includes('창의') || normalized.includes('아이디어')) {
    return ABILITY_ICON_MAP['창의력']
  }
  if (normalized.includes('리더') || normalized.includes('관리')) {
    return ABILITY_ICON_MAP['리더십']
  }
  if (normalized.includes('기술') || normalized.includes('테크')) {
    return ABILITY_ICON_MAP['기술분석']
  }
  if (normalized.includes('시간')) {
    return ABILITY_ICON_MAP['시간관리']
  }
  if (normalized.includes('문제') || normalized.includes('해결')) {
    return ABILITY_ICON_MAP['문제해결능력']
  }
  if (normalized.includes('언어')) {
    return ABILITY_ICON_MAP['언어능력']
  }
  if (normalized.includes('수리')) {
    return ABILITY_ICON_MAP['수리력']
  }
  if (normalized.includes('자기') || normalized.includes('성찰')) {
    return ABILITY_ICON_MAP['자기성찰능력']
  }
  
  // 기본 아이콘 반환
  return DEFAULT_ICON
}

/**
 * 여러 역량에 대한 아이콘을 일괄 조회합니다.
 * 
 * @param abilities - 역량 이름 배열
 * @returns 역량 이름과 아이콘 매핑 객체
 */
export function getAbilityIcons(abilities: string[]): Record<string, IconMapping> {
  const result: Record<string, IconMapping> = {}
  for (const ability of abilities) {
    result[ability] = getAbilityIcon(ability)
  }
  return result
}

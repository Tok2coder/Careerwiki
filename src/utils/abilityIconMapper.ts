/**
 * 역량(ability)과 지식(knowledge)을 Font Awesome 아이콘으로 매핑하는 유틸리티
 * 동일한 역량 이름은 항상 같은 아이콘을 반환합니다.
 */

interface IconMapping {
  icon: string;
  color: string;
}

/**
 * 역량별 Font Awesome 아이콘 매핑 테이블
 * icon: Font Awesome 클래스 (예: 'fa-comments')
 * color: Tailwind CSS 색상 클래스
 */
const ABILITY_ICON_MAP: Record<string, IconMapping> = {
  // 의사소통 & 대인관계
  '의사소통능력': { icon: 'fa-comments', color: 'text-blue-400' },
  '설득': { icon: 'fa-handshake', color: 'text-green-400' },
  '협상': { icon: 'fa-balance-scale', color: 'text-purple-400' },
  '서비스지향': { icon: 'fa-concierge-bell', color: 'text-pink-400' },
  '협조': { icon: 'fa-users', color: 'text-teal-400' },
  
  // 인지능력 & 학습
  '논리적분석': { icon: 'fa-brain', color: 'text-indigo-400' },
  '추리력': { icon: 'fa-lightbulb', color: 'text-yellow-400' },
  '수리력': { icon: 'fa-calculator', color: 'text-cyan-400' },
  '학습전략': { icon: 'fa-book-reader', color: 'text-orange-400' },
  '모니터링': { icon: 'fa-chart-line', color: 'text-green-500' },
  '기억력': { icon: 'fa-head-side-brain', color: 'text-purple-500' },
  
  // 문제해결 & 의사결정
  '문제해결능력': { icon: 'fa-puzzle-piece', color: 'text-red-400' },
  '판단과의사결정': { icon: 'fa-gavel', color: 'text-amber-500' },
  '창의력': { icon: 'fa-palette', color: 'text-pink-500' },
  '전략수립': { icon: 'fa-chess', color: 'text-gray-400' },
  
  // 시스템 & 기술
  '시스템분석': { icon: 'fa-project-diagram', color: 'text-blue-500' },
  '시스템평가': { icon: 'fa-clipboard-check', color: 'text-green-400' },
  '작동점검': { icon: 'fa-tools', color: 'text-orange-500' },
  '기술분석': { icon: 'fa-microchip', color: 'text-purple-400' },
  '기술설계': { icon: 'fa-drafting-compass', color: 'text-teal-500' },
  '프로그래밍': { icon: 'fa-code', color: 'text-green-500' },
  '장비선정': { icon: 'fa-cogs', color: 'text-gray-500' },
  
  // 자원관리
  '시간관리': { icon: 'fa-clock', color: 'text-blue-400' },
  '재정자원관리': { icon: 'fa-dollar-sign', color: 'text-green-600' },
  '물적자원관리': { icon: 'fa-boxes', color: 'text-brown-400' },
  '인적자원관리': { icon: 'fa-users-cog', color: 'text-indigo-400' },
  
  // 리더십 & 관리
  '리더십': { icon: 'fa-crown', color: 'text-yellow-500' },
  '경영': { icon: 'fa-briefcase', color: 'text-gray-600' },
  '조직체계의이해와적용': { icon: 'fa-sitemap', color: 'text-blue-600' },
  
  // 언어 & 글쓰기
  '읽기': { icon: 'fa-book-open', color: 'text-blue-300' },
  '듣고이해하기': { icon: 'fa-ear-listen', color: 'text-teal-300' },
  '말하기': { icon: 'fa-microphone', color: 'text-purple-300' },
  '쓰기': { icon: 'fa-pen', color: 'text-indigo-300' },
  
  // 신체 & 감각
  '신체적강인성': { icon: 'fa-dumbbell', color: 'text-red-500' },
  '신체의유연성및균형': { icon: 'fa-person-walking', color: 'text-orange-400' },
  '정교한동작': { icon: 'fa-hand-pointer', color: 'text-pink-400' },
  '시력': { icon: 'fa-eye', color: 'text-cyan-400' },
  '청력': { icon: 'fa-ear-deaf', color: 'text-blue-400' },
  
  // 기타 능력
  '범주화': { icon: 'fa-layer-group', color: 'text-gray-400' },
  '정보수집': { icon: 'fa-search', color: 'text-teal-400' },
  '품질관리분석': { icon: 'fa-award', color: 'text-yellow-400' },
  '설치': { icon: 'fa-wrench', color: 'text-orange-400' },
  '수리': { icon: 'fa-screwdriver', color: 'text-red-400' },
  '운전및조작': { icon: 'fa-car', color: 'text-blue-500' },
  
  // 지식 관련
  '국어': { icon: 'fa-language', color: 'text-green-400' },
  '영어': { icon: 'fa-globe', color: 'text-blue-400' },
  '수학': { icon: 'fa-square-root-alt', color: 'text-purple-400' },
  '과학': { icon: 'fa-flask', color: 'text-cyan-400' },
  '법률': { icon: 'fa-balance-scale-right', color: 'text-indigo-500' },
  '의료': { icon: 'fa-heartbeat', color: 'text-red-500' },
  '교육및훈련': { icon: 'fa-chalkboard-teacher', color: 'text-orange-500' },
  '경제및회계': { icon: 'fa-chart-pie', color: 'text-green-500' },
  '마케팅': { icon: 'fa-bullhorn', color: 'text-pink-500' },
  '디자인': { icon: 'fa-pencil-ruler', color: 'text-purple-500' },
  '건축': { icon: 'fa-building', color: 'text-gray-500' },
  '기계': { icon: 'fa-gear', color: 'text-blue-600' },
  '전기전자': { icon: 'fa-bolt', color: 'text-yellow-600' },
  '컴퓨터': { icon: 'fa-laptop-code', color: 'text-teal-600' },
}

/**
 * 기본 아이콘 (매핑되지 않은 역량에 사용)
 */
const DEFAULT_ICON: IconMapping = {
  icon: 'fa-star',
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
    .replace(/[()]/g, '')
}

/**
 * 역량 이름에 해당하는 Font Awesome 아이콘을 반환합니다.
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

/**
 * 역량 리스트를 HTML 형식으로 렌더링합니다 (아이콘 포함).
 * 
 * @param abilities - 역량 이름 배열
 * @returns HTML 문자열
 */
export function renderAbilityListWithIcons(abilities: string[]): string {
  return abilities
    .map(ability => {
      const { icon, color } = getAbilityIcon(ability)
      return `<li class="flex items-start gap-2">
        <i class="fas ${icon} ${color} mt-1 flex-shrink-0"></i>
        <span>${ability}</span>
      </li>`
    })
    .join('')
}

/**
 * 편집 가능 필드 타입 정의
 * 직업/전공 상세페이지 편집 시스템
 */

// 필드 입력 타입
export type FieldInputType = 
  | 'text'           // 단일 텍스트
  | 'textarea'       // 여러 줄 텍스트
  | 'tags'           // 태그/칩 배열
  | 'category'       // 직업 계열 자동완성/텍스트
  | 'majorCategory'  // 전공 계열 자동완성/텍스트
  | 'list'           // 한 줄씩 입력하는 리스트
  | 'autocomplete'   // 엔티티 검색(관련 직업/전공/HowTo)
  | 'pairList'       // 제목+설명 쌍 리스트

// 필드가 속한 섹션/탭
export type FieldSection = 
  | 'hero'           // 히어로 섹션
  | 'overview'       // 개요 탭
  | 'details'        // 상세정보 탭

// 필드 타입 (읽기 전용 여부)
export type FieldAccessType = 'editable' | 'readonly'

// 출처 정보
export interface FieldSource {
  id: number          // 주석 번호 [1], [2], ...
  text: string        // 출처 설명
  url?: string        // 출처 URL (선택)
  fieldKey: string    // 어느 필드에 연결된 출처인지
  tab?: string        // 어느 탭에 있는지 (overview, details)
}

// 필드 메타데이터
export interface EditFieldConfig {
  key: string                     // 필드 키 (예: 'summary', 'overviewWork.main')
  label: string                   // UI 표시 라벨 (예: '직업 설명')
  inputType: FieldInputType       // 입력 타입
  section: FieldSection           // 속한 섹션
  sectionGroup?: string           // 그룹명 (예: '주요 업무', '커리어 전망')
  placeholder?: string            // 플레이스홀더
  minLength: number               // 최소 길이 (기본: 2)
  maxLength: number               // 최대 길이 (기본: 7000)
  required?: boolean              // 필수 여부
  accessType: FieldAccessType     // 읽기 전용 여부
}

// 편집 데이터 구조
export interface EditData {
  [key: string]: any
  _sources?: Record<string, FieldSource>
}

// ============================================
// 직업 생성/편집 페이로드
// ============================================

// 직업 생성 (로그인 유저)
export interface CreateJobPayload {
  name: string        // 필수 - 직업명
  summary: string     // 필수 - 직업 설명
  heroTags?: string[] // 선택 - 태그
  heroCategory?: string // 선택 - 분류
}

// 직업 편집 (다중 필드)
export interface EditJobPayload {
  fields: Record<string, any>     // 변경된 필드들
  sources?: FieldSource[]         // 출처 목록
  changeSummary?: string          // 변경 요약
}

// ============================================
// 전공 생성/편집 페이로드
// ============================================

// 전공 생성 (로그인 유저)
export interface CreateMajorPayload {
  name: string        // 필수 - 전공명
  summary: string     // 필수 - 전공 설명
  heroTags?: string[] // 선택 - 관련 학과 태그
  categoryName?: string // 선택 - 계열
}

// 전공 편집 (다중 필드)
export interface EditMajorPayload {
  fields: Record<string, any>     // 변경된 필드들
  sources?: FieldSource[]         // 출처 목록
  changeSummary?: string          // 변경 요약
}

// ============================================
// 검증 결과
// ============================================

export interface ValidationResult {
  valid: boolean
  error?: string
  fieldErrors?: Record<string, string>
}



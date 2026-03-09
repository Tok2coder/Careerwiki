/**
 * 커리어트리 타입 정의
 * 유명 인물의 실제 커리어 경로를 직업 상세 페이지에서 표시하기 위한 타입
 */

/** 커리어트리 한 단계 */
export interface CareerTreeStage {
  order: number               // 정렬 순서 (0-based)
  title: string               // 직함/역할 (예: 'COO', '주니어 개발자')
  organization?: string       // 소속 (예: 'Apple', '삼성전자')
  years?: string              // 기간 (예: '1998-2011', '2011-현재')
  description?: string        // 한 줄 설명
  job_slug?: string | null    // CW 직업 페이지 슬러그 (있으면 링크)
}

/** DB row → 파싱된 커리어트리 */
export interface CareerTree {
  id: number
  personName: string
  personNameEn?: string
  personTitle?: string
  personImageUrl?: string
  stages: CareerTreeStage[]
  displayPriority: number
  isActive: boolean
}

/** 직업 페이지용: 어떤 stage가 현재 페이지인지 포함 */
export interface CareerTreeForJob extends CareerTree {
  highlightStageIndex: number | null   // 현재 직업 페이지에 해당하는 stage index
}

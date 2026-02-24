// CareerWiki - Embedding & Profile Version Management
// Version: v1.0.0 (Freeze v1.1)
//
// ============================================
// 버전 관리 원칙
// ============================================
// 1. 인덱싱 텍스트 구성이 바뀌면 JOB_PROFILE_COMPACT_VERSION 증가
// 2. SearchProfile 쿼리 생성 로직이 바뀌면 SEARCH_PROFILE_QUERY_VERSION 증가
// 3. 버전이 바뀌면 재인덱싱 또는 캐시 무효화가 필요함
// ============================================

// ============================================
// 직업 프로필 인덱싱 텍스트 버전
// ============================================
// 변경 시 Vectorize 재인덱싱 필요
export const JOB_PROFILE_COMPACT_VERSION = 'V2'

// ============================================
// SearchProfile 쿼리 텍스트 버전
// ============================================
// 변경 시 기존 캐시 무효화 필요
export const SEARCH_PROFILE_QUERY_VERSION = 'V1'

// ============================================
// 버전 히스토리 (변경 이력)
// ============================================
// JOB_PROFILE_COMPACT:
//   V2: 2026-02-22 - Contextual Embedding
//       구성: [카테고리/속성 맥락 프리앰블] + name + heroIntro/summary + duties + skills + environment + certifications
//       프리앰블: job_attributes 기반 분야/속성/관련전공 컨텍스트 추가
//       최대 길이: 1200자 (프리앰블 ~100-150자 + 원본 ~1000자)
//   V1: 2026-01-27 - 초기 버전
//       구성: name + heroIntro/summary + duties + skills + environment + certifications
//       fallback: heroIntro → summary → description → category
//       최대 길이: 1000자
//
// SEARCH_PROFILE_QUERY:
//   V1: 2026-01-27 - 초기 버전
//       구성: desiredThemes + strengthsHypothesis + keywords + environmentPreferences
//       최대 길이: 500자

// ============================================
// 복합 버전 문자열 (D1 저장용)
// ============================================
export function getFullEmbeddingVersion(): string {
  return `JPC_${JOB_PROFILE_COMPACT_VERSION}_SPQ_${SEARCH_PROFILE_QUERY_VERSION}`
}

// ============================================
// 버전 비교 유틸리티
// ============================================
export function isJobProfileVersionMatch(dbVersion: string | null): boolean {
  if (!dbVersion) return false
  return dbVersion.includes(`JPC_${JOB_PROFILE_COMPACT_VERSION}`)
}

export function isSearchProfileVersionMatch(dbVersion: string | null): boolean {
  if (!dbVersion) return false
  return dbVersion.includes(`SPQ_${SEARCH_PROFILE_QUERY_VERSION}`)
}

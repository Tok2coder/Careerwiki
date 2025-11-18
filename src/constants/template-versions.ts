/**
 * Template Version Management
 * 
 * Purpose: Central version control for wiki-style page templates.
 * When you update a template file, bump the corresponding version number here.
 * This triggers automatic cache invalidation for all pages using that template.
 * 
 * Example workflow:
 * 1. Edit MajorDetailTemplate.tsx (add new section, change styling)
 * 2. Increment MAJOR_TEMPLATE_VERSION: 1 → 2
 * 3. Next request to /major/:slug automatically regenerates HTML
 * 4. All 1,424 major pages update progressively (no manual rebuild needed)
 */

export const TEMPLATE_VERSIONS = {
  /**
   * Major detail page template version
   * Used for: /major/:slug pages
   * Current features: 사이드바 개선 (추천 자격증 계층 구조, 중복 제거, 하위 자격증 3개씩 토글), 목차 UX 개선, 탭 이름 변경, 지도 UI 개선, 지역 필터링 개선
   */
  MAJOR: 92,  // 💬 댓글 제출 버튼 텍스트 변경: '댓글 남기기' → '등록'

  /**
   * Job detail page template version
   * Used for: /job/:slug pages
   * Current features: 고용24 전용 직업 설명 추가 (duty.jobSum), 사이드바 연관 직업 5개 토글, 흥미 프로필 중복 제거, 커리어 전망 빈 데이터 처리, 깔끔한 URL slug
   */
  JOB: 31,  // 💬 댓글 제출 버튼 텍스트 변경: '댓글 남기기' → '등록'

  /**
   * Guide page template version
   * Used for: /guide/:slug pages
   * Current features: TBD (future)
   */
  GUIDE: 1,

  /**
   * HowTo guide page template version
   * Used for: /howto/:slug pages
   * Current features: 블로그 형태로 변경 (탭 제거, 사이드바 sticky 적용, 히어로 섹션 정리), AI 말투 제거 및 자연스러운 문체로 변경
   */
  HOWTO: 3,  // ✍️ AI 말투 제거 및 자연스러운 문체로 변경, 중복 숫자 제거
} as const

/**
 * Helper function to get template version by page type
 */
export function getTemplateVersion(pageType: 'major' | 'job' | 'guide' | 'howto'): number {
  const versionMap = {
    major: TEMPLATE_VERSIONS.MAJOR,
    job: TEMPLATE_VERSIONS.JOB,
    guide: TEMPLATE_VERSIONS.GUIDE,
    howto: TEMPLATE_VERSIONS.HOWTO,
  }
  return versionMap[pageType]
}

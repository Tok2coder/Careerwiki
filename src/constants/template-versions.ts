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
   * Current features: 히어로 섹션 개선 + 사이드바 추가 + summary 표시
   */
  MAJOR: 7,  // 🆕 직업 템플릿과 완전히 동일한 레이아웃 (2-column + 사이드바)

  /**
   * Job detail page template version
   * Used for: /job/:slug pages
   * Current features: 상세정보 탭 업무 상세 계층 구조 렌더링 (대분류 제목 + bullet point)
   */
  JOB: 10,  // 🆕 formatWorkDetailAsNumberedCards를 계층 구조로 개선 (대분류 제목 + 항목 리스트)

  /**
   * Guide page template version
   * Used for: /guide/:slug pages
   * Current features: TBD (future)
   */
  GUIDE: 1,
} as const

/**
 * Helper function to get template version by page type
 */
export function getTemplateVersion(pageType: 'major' | 'job' | 'guide'): number {
  const versionMap = {
    major: TEMPLATE_VERSIONS.MAJOR,
    job: TEMPLATE_VERSIONS.JOB,
    guide: TEMPLATE_VERSIONS.GUIDE,
  }
  return versionMap[pageType]
}

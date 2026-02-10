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
   * Current features: ETL 병합 필드 사용 (heroSummary, categoryDisplay, heroTags)
   */
  MAJOR: 275,  // R2 image_url 전달 추가

  /**
   * Job detail page template version
   * Used for: /job/:slug pages
   * Current features: ETL 개선 완료, 배열 필드 타입 체크 추가
   */
  JOB: 213,  // DB image_url 쿼리에 포함 및 profile에 병합

  /**
   * Guide page template version
   * Used for: /guide/:slug pages
   * Current features: TBD (future)
   */
  GUIDE: 3,

  /**
   * HowTo guide page template version
   * Used for: /howto/:slug pages
   * Current features: 블로그 형태로 변경 (탭 제거, 사이드바 sticky 적용, 히어로 섹션 정리), AI 말투 제거 및 자연스러운 문체로 변경
   */
  HOWTO: 83,  // ✍️ AI 말투 제거 및 자연스러운 문체로 변경, 중복 숫자 제거
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

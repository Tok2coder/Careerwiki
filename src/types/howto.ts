export interface HowtoGuideDetail {
  slug: string
  title: string
  summary: string
  heroIcon?: string
  thumbnailUrl?: string  // 썸네일 이미지 URL
  authorId?: number      // 작성자 ID
  authorName?: string    // 작성자 이름
  authorPictureUrl?: string  // 작성자 프로필 이미지 URL
  tags: string[]
  updatedAt: string
  estimatedDuration?: string
  difficulty?: string
  audience?: string
  prerequisites?: string[]
  keyMetrics?: Array<{ label: string; value: string; hint?: string }>
  steps: Array<{
    id: string
    title: string
    description: string
    keyActions?: string[]
    expectedOutcome?: string
  }>
  checkpoints?: Array<{ title: string; description: string }>
  resources?: Array<{ label: string; url: string; description?: string }>
  nextActions?: Array<{ label: string; description: string; href?: string; type?: 'ai' | 'job' | 'major' | 'external' }>
  telemetryId: string
  seo?: {
    title?: string
    description?: string
    canonicalSlug?: string
  }
  sampleNote?: string
  ctaLinks?: Array<{ label: string; href: string; type: 'ai' | 'job' | 'major' | 'external' }>
  relatedContent?: Array<{
    title: string
    slug: string
    summary?: string
    category?: string
    badge?: string
  }>
  // 확장 필드 (사용자 생성 HowTo용)
  rawHtml?: string  // 자유 형식 본문 HTML (steps 대신 사용)
  footnotes?: Array<{ id: number; text: string; url?: string }>  // 각주 데이터
  // 통계 필드
  viewCount?: number  // 조회수
  bookmarkCount?: number  // 저장 횟수
}

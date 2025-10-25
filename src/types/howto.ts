export interface HowtoGuideDetail {
  slug: string
  title: string
  summary: string
  heroIcon?: string
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
}

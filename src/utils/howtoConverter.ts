/**
 * DB row를 HowtoGuideDetail 타입으로 변환하는 유틸리티
 */

import type { HowtoGuideDetail } from '../types/howto'

export interface DbHowtoRow {
  id: number
  slug: string
  title: string
  summary: string | null
  content: string | null
  meta_data: string | null
  author_id: number | null
  author_picture_url?: string | null  // 작성자 프로필 이미지 (OAuth)
  author_custom_picture_url?: string | null  // 작성자 커스텀 프로필 이미지
  status: string
  created_at: string
  updated_at: string
  view_count?: number
  bookmark_count?: number
}

export interface ParsedMetaData {
  contentJson?: string
  tags?: string[]
  relatedJobs?: Array<{ id?: string; name: string; slug: string }>
  relatedMajors?: Array<{ id?: string; name: string; slug: string }>
  relatedHowtos?: Array<{ id?: number; title?: string; name?: string; slug: string }>
  footnotes?: Array<{ id: number; text: string; url?: string }>
  authorName?: string
  thumbnailUrl?: string
  difficulty?: string
  duration?: string
}

/**
 * DB에서 가져온 HowTo row를 HowtoGuideDetail 타입으로 변환
 */
export function dbRowToHowtoGuideDetail(row: DbHowtoRow): HowtoGuideDetail {
  // meta_data 파싱
  let metaData: ParsedMetaData = {}
  try {
    if (row.meta_data) {
      metaData = JSON.parse(row.meta_data)
    }
  } catch {
  }

  const tags = metaData.tags || []
  const relatedJobs = metaData.relatedJobs || []
  const relatedMajors = metaData.relatedMajors || []
  const relatedHowtos = metaData.relatedHowtos || []
  const footnotes = metaData.footnotes || []

  // nextActions: 관련 직업/전공을 매핑
  const nextActions: HowtoGuideDetail['nextActions'] = [
    ...relatedJobs.map(job => ({
      label: job.name,
      description: `${job.name} 직업 정보 보기`,
      href: `/job/${job.slug}`,
      type: 'job' as const
    })),
    ...relatedMajors.map(major => ({
      label: major.name,
      description: `${major.name} 전공 정보 보기`,
      href: `/major/${major.slug}`,
      type: 'major' as const
    }))
  ]

  // relatedContent: 관련 HowTo를 매핑
  const relatedContent: HowtoGuideDetail['relatedContent'] = relatedHowtos.map(howto => ({
    title: howto.title || howto.name || '',
    slug: howto.slug,
    summary: '',
    category: 'HowTo',
    badge: ''
  }))

  // resources: 각주를 매핑 (URL 여부 관계없이 모든 각주 포함)
  const resources: HowtoGuideDetail['resources'] = footnotes.map(fn => ({
    label: fn.text,
    url: fn.url || '',
    description: `출처 [${fn.id}]`
  }))

  // 프로필 이미지 우선순위: custom > OAuth > undefined
  const authorPictureUrl = row.author_custom_picture_url || row.author_picture_url || undefined

  return {
    slug: row.slug,
    title: row.title,
    summary: row.summary || '',
    heroIcon: 'fa-book-open',
    thumbnailUrl: metaData.thumbnailUrl || '',
    authorId: row.author_id || undefined,
    authorName: metaData.authorName || '작성자',
    authorPictureUrl,
    tags,
    updatedAt: row.updated_at || row.created_at,
    estimatedDuration: metaData.duration || '',
    difficulty: metaData.difficulty || '',
    audience: '',
    prerequisites: [],
    keyMetrics: [],
    steps: [], // 사용자 HowTo는 자유 형식이므로 steps가 없음
    checkpoints: [],
    resources,
    nextActions,
    telemetryId: `howto-${row.id}`,
    seo: {
      title: `${row.title} - Careerwiki`,
      description: row.summary || '',
      canonicalSlug: row.slug
    },
    sampleNote: '',
    ctaLinks: [],
    relatedContent,
    // 확장 필드: 자유 형식 본문 HTML
    rawHtml: row.content || '',
    // 각주 데이터
    footnotes,
    // 통계 필드
    viewCount: row.view_count || 0,
    bookmarkCount: row.bookmark_count || 0
  }
}

/**
 * 각주 HTML 섹션 생성 (더 이상 사용하지 않음 - sourcesCollapsible에 통합)
 */
export function renderFootnotesSection(footnotes: Array<{ id: number; text: string; url?: string }>): string {
  // 이 함수는 더 이상 사용하지 않음. 모든 각주는 "출처" 섹션에서 통합 렌더링됨.
  return ''
}

// 헬퍼: HTML 이스케이프
function escapeHtml(text: string): string {
  return text
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#39;')
}


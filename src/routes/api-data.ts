import { Hono } from 'hono'
import type { AppEnv } from '../types/app'
import {
  parseSourcesQuery, parseNumberParam, escapeHtml
} from '../utils/shared-helpers'
import { resolveDetailIdFromSlug } from '../utils/slug'
import { weakETag, toNFC, matchETag } from '../utils/etag'
import { TEMPLATE_VERSIONS } from '../constants/template-versions'
import { searchUnifiedJobs, searchUnifiedMajors, getUnifiedJobDetail, getUnifiedJobDetailWithRawData, getUnifiedMajorDetail } from '../services/profileDataService'
import { ragSearchJobs, ragSearchMajors } from '../services/rag-search'
import { JOB_CATEGORIES, APTITUDE_TYPES } from '../api/careernetAPI'
import { renderJobCard, renderMajorCard } from '../utils/card-renderers'
import type { UnifiedJobDetail, UnifiedMajorDetail } from '../types/unifiedProfiles'
import type { JobSourceRow, MajorSourceRow } from '../types/database'

// ─── Chart data conversion helpers (legacy → unified format) ───

interface UnifiedChartItem { label: string; value: number }
interface UnifiedChartEditData {
  chartType: 'bar' | 'doughnut' | 'horizontalBar'
  title?: string
  items: UnifiedChartItem[]
  unit?: string
  note?: string
  sortDescending?: boolean
  maxValue?: number
}

/** Check if data is already in unified chart format */
function isUnifiedChart(data: unknown): data is UnifiedChartEditData {
  if (!data || typeof data !== 'object') return false
  const d = data as Record<string, unknown>
  return 'chartType' in d && Array.isArray(d.items)
}

/** Convert job indicator data (detailIndicators) → unified */
function convertIndicatorsToUnified(data: any): UnifiedChartEditData | null {
  if (!data) return null
  if (isUnifiedChart(data)) return data
  if (!Array.isArray(data) || data.length === 0) return null

  const items: UnifiedChartItem[] = []
  const first = data[0]

  // Type 2: { category: "a,b,c", description: "1,2,3" }
  if (first?.category && first?.description) {
    const cats = first.category.split(',').map((s: string) => s.trim())
    const vals = first.description.split(',').map((s: string) => parseFloat(s.trim()) || 0)
    for (let i = 0; i < cats.length; i++) {
      if (cats[i]) items.push({ label: cats[i], value: vals[i] ?? 0 })
    }
  }
  // Type 1: [{ indicator, indicator_data }]
  else if (first?.indicator) {
    if (typeof first.indicator === 'string' && first.indicator.includes(',')) {
      const cats = first.indicator.split(',').map((s: string) => s.trim())
      const vals = String(first.indicator_data || '').split(',').map((s: string) => parseFloat(s.trim()) || 0)
      for (let i = 0; i < cats.length; i++) {
        if (cats[i]) items.push({ label: cats[i], value: vals[i] ?? 0 })
      }
    } else {
      for (const item of data) {
        const lbl = item.indicator || '지표'
        const val = typeof item.indicator_data === 'number' ? item.indicator_data : parseFloat(String(item.indicator_data)) || 0
        items.push({ label: lbl, value: val })
      }
    }
  }

  return items.length > 0 ? { chartType: 'horizontalBar', title: '한국의 직업지표', items, unit: '점', sortDescending: true } : null
}

/** Korean label maps for distribution data keys */
const EDUCATION_LABELS: Record<string, string> = {
  middleSchoolOrLess: '중학교 이하',
  highSchool: '고등학교',
  college: '전문대',
  university: '대학',
  graduate: '석사 이상',
  doctor: '박사'
}
const MAJOR_DIST_LABELS: Record<string, string> = {
  humanities: '인문계열',
  social: '사회계열',
  education: '교육계열',
  engineering: '공학계열',
  natural: '자연계열',
  medical: '의약계열',
  artsSports: '예체능'
}

/** Convert { key: "value%" } distribution → unified */
function convertDistributionToUnified(
  data: Record<string, string | undefined> | null | undefined,
  title: string, chartType: 'bar' | 'doughnut' | 'horizontalBar', unit: string,
  labelMap?: Record<string, string>
): UnifiedChartEditData | null {
  if (!data) return null
  if (isUnifiedChart(data)) return data as any
  const entries = Object.entries(data).filter(([, v]) => v !== undefined && v !== null)
  if (entries.length === 0) return null

  const items: UnifiedChartItem[] = entries.map(([k, v]) => ({
    label: labelMap?.[k] || k,
    value: parseFloat(String(v).replace('%', '')) || 0
  }))
  return { chartType, title, items, unit, sortDescending: true }
}

/** Convert prospect data → unified */
function convertProspectToUnified(data: any[] | undefined): UnifiedChartEditData | null {
  if (!data || !Array.isArray(data) || data.length === 0) return null
  if (isUnifiedChart(data)) return data as any

  const labelMap: Record<string, string> = {
    '증가': '증가', '다소 증가': '다소 증가', '유지': '유지',
    '다소 감소': '다소 감소', '감소': '감소'
  }
  const items: UnifiedChartItem[] = data.map(item => ({
    label: labelMap[item.jobProspectNm] || item.jobProspectNm || '',
    value: parseFloat(item.jobProspectRatio) || 0
  })).filter(i => i.label)

  return items.length > 0 ? { chartType: 'bar', title: '재직자가 생각하는 일자리 전망', items, unit: '%',
    note: '직업당 평균 30명의 재직자가 해당 직업의 향후 5년간 일자리 변화에 대해 응답한 결과입니다.' } : null
}

/** Convert major chartData items ({item, data}) → unified */
function convertMajorChartToUnified(
  data: any, title: string, chartType: 'bar' | 'doughnut' | 'horizontalBar', unit: string
): UnifiedChartEditData | null {
  if (!data) return null
  if (isUnifiedChart(data)) return data
  if (!Array.isArray(data) || data.length === 0) return null

  const items: UnifiedChartItem[] = data
    .map((item: { item?: string; data?: string }) => ({
      label: item.item || '',
      value: parseFloat(item.data || '0')
    }))
    .filter((i: UnifiedChartItem) => i.label)

  return items.length > 0 ? { chartType, title, items, unit } : null
}

export const apiDataRoutes = new Hono<AppEnv>()

// 학과정보 검색 API
apiDataRoutes.get('/api/majors', async (c) => {
  try {
    const mark = c.get('mark') as ((k: string) => void) | undefined
    mark?.('parse-query')
    const keyword = c.req.query('keyword') || ''
    const page = parseNumberParam(c.req.query('page'), 1, { min: 1 })
    const perPage = parseNumberParam(c.req.query('perPage'), 8, { min: 1, max: 50 })
    const includeSources = parseSourcesQuery(c.req.query('sources'))

    const dataVersion = 'v1'
    const seed = `${TEMPLATE_VERSIONS.MAJOR}:${dataVersion}:${toNFC(keyword)}:${page}:${perPage}`
    const etag = weakETag(seed)
    const inm = c.req.header('If-None-Match')
    const hasMatch = matchETag(inm, etag)
    if (hasMatch) {
      c.header('ETag', etag)
      c.header('Cache-Control', 'public, max-age=60, stale-while-revalidate=30')
      c.header('X-Cache-Status', 'HIT')
      return c.body(null, 304)
    }

    mark?.('build-sql')
    const result = await searchUnifiedMajors({
      keyword,
      page,
      perPage,
      includeSources
    }, c.env)
    mark?.('db-read')

    mark?.('post-filter')
    mark?.('serialize')
    // logging removed per request
    c.header('ETag', etag)
    c.header('Cache-Control', 'public, max-age=60, stale-while-revalidate=30')
    return c.json({
      success: true,
      data: result.items,
      meta: {
        ...result.meta,
        keyword,
        page,
        perPage
      }
    })
  } catch (error) {
    return c.json({
      success: false,
      error: error instanceof Error ? error.message : '학과 정보 검색 실패'
    }, 500)
  }
})

// 학과 검색 API (별도 엔드포인트) - :id 라우트보다 먼저 정의해야 함
apiDataRoutes.get('/api/majors/search', async (c) => {
  try {
    const q = c.req.query('q') || c.req.query('keyword') || ''
    const page = parseNumberParam(c.req.query('page'), 1, { min: 1 })
    const perPage = parseNumberParam(c.req.query('perPage'), 20, { min: 1, max: 50 })
    const sort = c.req.query('sort') || 'relevance'
    const includeSources = parseSourcesQuery(c.req.query('sources'))

    // RAG 검색 (벡터 + LIKE 폴백)
    const result = await ragSearchMajors(c.env, q, { page, perPage })

    return c.json({
      success: true,
      data: result.items,
      meta: {
        ...result.meta,
        keyword: q,
        page,
        perPage
      }
    })
  } catch (error) {
    return c.json({
      success: false,
      error: error instanceof Error ? error.message : '학과 정보 검색 실패'
    }, 500)
  }
})

// 학과 상세 정보 API
apiDataRoutes.get('/api/majors/:id', async (c) => {
  try {
    const id = c.req.param('id')
    let userContributedJson: any = {}
    const careernetId = c.req.query('careernetId') || undefined
    const goyongMajorGb = c.req.query('goyongMajorGb') as ('1' | '2') | undefined
    const goyongDepartmentId = c.req.query('goyongDepartmentId') || undefined
    const goyongMajorId = c.req.query('goyongMajorId') || undefined
    const includeSources = parseSourcesQuery(c.req.query('sources'))

    const goyongParams = goyongMajorGb && goyongDepartmentId && goyongMajorId
      ? {
          majorGb: goyongMajorGb as '1' | '2',
          departmentId: goyongDepartmentId,
          majorId: goyongMajorId
        }
      : undefined

    const result = await getUnifiedMajorDetail(
      {
        id,
        careernetId,
        goyong24Params: goyongParams,
        includeSources
      },
      c.env
    )

    if (!result.profile) {
      return c.json({
        success: false,
        error: '학과 정보를 찾을 수 없습니다.',
        sources: result.sources
      }, 404)
    }

    return c.json({
      success: true,
      data: result.profile,
      partials: result.partials,
      sources: result.sources
    })
  } catch (error) {
    return c.json({
      success: false,
      error: error instanceof Error ? error.message : '학과 정보 조회 실패'
    }, 500)
  }
})

// 직업정보 검색 API
apiDataRoutes.get('/api/jobs', async (c) => {
  try {
    const mark = c.get('mark') as ((k: string) => void) | undefined
    mark?.('parse-query')
    const keyword = c.req.query('keyword') || ''
    const category = c.req.query('category') || ''
    const page = parseNumberParam(c.req.query('page'), 1, { min: 1 })
    const perPage = parseNumberParam(c.req.query('perPage'), 8, { min: 1, max: 50 })
    const includeSources = parseSourcesQuery(c.req.query('sources'))

    const dataVersion = 'v1'
    const seed = `${TEMPLATE_VERSIONS.JOB}:${dataVersion}:${toNFC(keyword)}:${page}:${perPage}:${category}`
    const etag = weakETag(seed)
    const inm = c.req.header('If-None-Match')
    const hasMatch = matchETag(inm, etag)
    if (hasMatch) {
      c.header('ETag', etag)
      c.header('Cache-Control', 'public, max-age=60, stale-while-revalidate=30')
      c.header('X-Cache-Status', 'HIT')
      return c.body(null, 304)
    }

    mark?.('build-sql')
    const result = await searchUnifiedJobs({
      keyword,
      category,
      page,
      perPage,
      includeSources
    }, c.env)
    mark?.('db-read')

    mark?.('post-filter')
    mark?.('serialize')
    // logging removed per request
    c.header('ETag', etag)
    c.header('Cache-Control', 'public, max-age=60, stale-while-revalidate=30')
    return c.json({
      success: true,
      data: result.items,
      meta: {
        ...result.meta,
        keyword,
        category,
        page,
        perPage
      },
      categories: JOB_CATEGORIES
    })
  } catch (error) {
    return c.json({
      success: false,
      error: error instanceof Error ? error.message : '직업 정보 검색 실패'
    }, 500)
  }
})

// 직업 검색 API (별도 엔드포인트) - :id 라우트보다 먼저 정의해야 함
apiDataRoutes.get('/api/jobs/search', async (c) => {
  try {
    const q = c.req.query('q') || c.req.query('keyword') || ''
    const category = c.req.query('category') || ''
    const page = parseNumberParam(c.req.query('page'), 1, { min: 1 })
    const perPage = parseNumberParam(c.req.query('perPage'), 20, { min: 1, max: 50 })
    const sort = c.req.query('sort') || 'relevance'
    const includeSources = parseSourcesQuery(c.req.query('sources'))

    // RAG 검색 (벡터 + LIKE 폴백)
    const result = await ragSearchJobs(c.env, q, { page, perPage })

    return c.json({
      success: true,
      data: result.items,
      meta: {
        ...result.meta,
        keyword: q,
        category,
        page,
        perPage
      },
      categories: JOB_CATEGORIES
    })
  } catch (error) {
    return c.json({
      success: false,
      error: error instanceof Error ? error.message : '직업 정보 검색 실패'
    }, 500)
  }
})

// 직업 상세 정보 API
apiDataRoutes.get('/api/jobs/:id', async (c) => {
  try {
    const id = c.req.param('id')
    const careernetId = c.req.query('careernetId') || undefined
    const goyongJobId = c.req.query('goyongJobId') || undefined
    const includeSources = parseSourcesQuery(c.req.query('sources'))

    const result = await getUnifiedJobDetail(
      {
        id,
        careernetId,
        goyong24JobId: goyongJobId || undefined,
        includeSources
      },
      c.env
    )

    if (!result.profile) {
      return c.json({
        success: false,
        error: '직업 정보를 찾을 수 없습니다.',
        sources: result.sources
      }, 404)
    }

    return c.json({
      success: true,
      data: result.profile,
      partials: result.partials,
      sources: result.sources
    })
  } catch (error) {
    return c.json({
      success: false,
      error: error instanceof Error ? error.message : '직업 정보 조회 실패'
    }, 500)
  }
})

// 편집 모드용 데이터 조회 API (실제 렌더링에 사용되는 데이터 반환)
apiDataRoutes.get('/api/job/:id/edit-data', async (c) => {
  try {
    // 캐시 방지 (편집 직후 최신 데이터 보장)
    c.header('Cache-Control', 'no-store')
    c.header('Pragma', 'no-cache')
    c.header('Expires', '0')

    const id = c.req.param('id')
    let userContributedJson: any = {}
    
    const result = await getUnifiedJobDetailWithRawData(
      {
        id,
        careernetId: undefined,
        goyong24JobId: undefined,
        includeSources: ['CAREERNET', 'GOYONG24']
      },
      c.env
    )

    if (!result.profile) {
      return c.json({
        success: false,
        error: '직업 정보를 찾을 수 없습니다.'
      }, 404)
    }

    const profile = result.profile
    const careernetSummary = result.partials?.CAREERNET?.summary
    const goyong24Summary = result.partials?.GOYONG24?.summary
    const heroDescription =
      (profile as any).heroSummary ||
      (profile.summary || careernetSummary || goyong24Summary)?.split('\n')[0]?.trim() ||
      ''
    // rawApiData 제거됨 — 모든 데이터를 profile(merged_profile_json)에서 직접 읽음
    
    // 헬퍼 함수: 배열에서 이름/텍스트 추출 (핵심 역량, 적성, 흥미, 관련학과, 교육과정, 진로탐색 등)
    const extractListItems = (list: any[] | null | undefined): string[] => {
      if (!list || !Array.isArray(list)) return []
      return list
        .map((item: any) => {
          if (typeof item === 'string') return item.trim()
          // ETL에서 사용하는 모든 필드명 지원
          return (
            item?.name || 
            item?.majorNm ||           // 고용24 관련학과
            item?.depart_name ||       // 커리어넷 관련학과
            item?.curriculum ||        // 정규교육과정
            item?.research ||          // 진로탐색활동
            item?.recruit ||           // 채용정보
            item?.training ||          // 필요 교육/훈련
            item?.certificate ||       // 자격증
            item?.ability_name ||      // 커리어넷 핵심역량
            item?.aptitude || 
            item?.interest || 
            item?.ability || 
            item?.text || 
            item?.value || 
            ''
          ).trim()
        })
        .filter(Boolean)
    }
    
    // 헬퍼 함수: detailReady 배열에서 텍스트 추출 (채용정보, 교육훈련 등)
    // 템플릿의 extractReadyItem과 동일한 로직
    const extractReadyListItems = (list: any[] | null | undefined, key: string): string[] => {
      if (!list || !Array.isArray(list)) return []
      return list
        .map((item: any) => {
          if (typeof item === 'string') return item.trim()
          if (item && typeof item === 'object') {
            return (item[key] || item.name || item.value || item.title || '').trim()
          }
          return ''
        })
        .filter(Boolean)
    }
    
    // 모든 데이터를 profile(merged_profile_json)에서 직접 읽음

    // 🆕 템플릿과 정확히 동일한 로직으로 필드 추출 (renderUnifiedJobDetail과 일치)
    // 템플릿에서는 profile이 이미 user_contributed_json과 admin_data_json이 병합된 결과를 사용
    
    // 히어로 설명: 템플릿과 동일한 우선순위 (heroIntro > summary > goyong24)
    // 템플릿: const heroDescription = profile.heroIntro?.split('\n')[0]?.trim() || profile.summary || ...
    // 편집 모드에서도 실제 표시되는 데이터와 동일하게 표시
    const summaryForEdit =
      profile.heroIntro ||
      profile.summary || ''

    // "하는 일" 섹션
    const workSummary = profile.work?.summary || profile.summary || ''

    // 주요 업무
    const workSimple = profile.work?.simple
    let duties = ''
    if (workSimple && Array.isArray(workSimple) && workSimple.length > 0) {
      duties = workSimple
        .map((item: any) => {
          const text = typeof item === 'string' ? item : item.work || item.list_content || ''
          return text?.trim() || ''
        })
        .filter(Boolean)
        .join('\n')
    } else if (profile.duties?.trim()) {
      duties = profile.duties
    }

    // 태그: profile에서 직접 읽기 (ETL에서 이미 포함)
    const tagList = (profile as any).tagList || (profile as any).careernetOnly?.tagList || []
    const tagText = Array.isArray(tagList) 
      ? tagList.map((tag: any) => {
          // 템플릿과 동일한 로직: string이면 그대로, object면 tag 또는 list_content 추출
          const tagText = typeof tag === 'string' ? tag : (tag?.tag || tag?.list_content || '')
          return tagText?.trim() || ''
        }).filter(Boolean).join('\n')
      : ''

    // 실제 데이터베이스 ID 조회 (profile.id는 API ID일 수 있음)
    let actualDbId = id
    if (c.env.DB) {
      try {
        // slug로 조회 시도
        const normalizedSlug = id.toLowerCase().replace(/[-,·ㆍ\/\s()]/g, '')
        const dbResult = await c.env.DB.prepare(
          'SELECT id FROM jobs WHERE name_normalized = ? AND is_active = 1 LIMIT 1'
        ).bind(normalizedSlug).first<{ id: string }>()
        
        if (dbResult?.id) {
          actualDbId = dbResult.id
        } else {
          // ID로 직접 조회 시도
          const directResult = await c.env.DB.prepare(
            'SELECT id FROM jobs WHERE id = ? AND is_active = 1 LIMIT 1'
          ).bind(id).first<{ id: string }>()
          
          if (directResult?.id) {
            actualDbId = directResult.id
          }
        }
      } catch (dbError) {
        // DB 조회 실패 시 원본 id 사용
      }
    }

    // heroTags 처리: profile.heroTags 또는 tagList 사용
    let heroTags: string[] = []
    if (Array.isArray(profile.heroTags)) {
      heroTags = profile.heroTags
    } else if (Array.isArray(tagList) && tagList.length > 0) {
      heroTags = tagList.map((tag: any) => {
        const t = typeof tag === 'string' ? tag : (tag?.tag || tag?.list_content || '')
        return t?.trim() || ''
      }).filter(Boolean)
    }
    
    // heroCategory 처리: breadcrumb 형식인지 확인
    let heroCategory = ''
    let isCategoryBreadcrumb = false
    
    if (typeof profile.heroCategory === 'string') {
      heroCategory = profile.heroCategory
    } else if (profile.heroCategory && typeof profile.heroCategory === 'object') {
      const cat = profile.heroCategory as any
      // breadcrumb 형식: large, medium, small 등 계층 구조가 있는 경우
      if (cat.large || cat.medium || cat.small) {
        isCategoryBreadcrumb = true
        // breadcrumb 전체를 표시 (편집 불가)
        const parts = [cat.large, cat.medium, cat.small].filter(Boolean)
        heroCategory = parts.join(' › ')
      } else if (cat.value) {
        heroCategory = cat.value
      }
    }
    
    // 편집 가능한 필드만 추출 (편집 모드 UI 필드 구조에 맞춤)
    const editData: Record<string, any> = {
      name: profile.name || '',
      summary: summaryForEdit, // 전체 summary (heroIntro > summary > goyong24)
      heroTags: heroTags, // 태그 배열
      heroCategory: heroCategory, // 직업 분류
      isCategoryBreadcrumb: isCategoryBreadcrumb, // breadcrumb 형식 여부 (true면 편집 불가)
      
      // 개요 - 주요 업무
      // main은 문자열 → 배열로 변환 (리스트 편집용)
      // 템플릿의 renderDutyBulletList와 동일한 로직 적용
      overviewWork: {
        main: (() => {
          const raw = profile.overviewWork?.main || duties || ''
          if (Array.isArray(raw)) {
            return raw
          }
          if (typeof raw === 'string' && raw.trim()) {
            const normalized = raw.replace(/\r/g, '\n')
            // 1차: 줄바꿈, 불릿 포인트로 분리
            let sentences = normalized
              .split(/\n+|•|▶|►|■|●|◆/)
              .map((s: string) => s.trim().replace(/^[\d\-\.\)\(]+\s*/, ''))
              .filter(Boolean)
            // 2차: 1줄이면 마침표/느낌표/물음표로 분리
            if (sentences.length <= 1) {
              const sentenceSplit = normalized
                .replace(/([.!?])\s+(?=[^\s])/g, '$1|')
                .split('|')
                .map((s: string) => s.trim().replace(/^[\d\-\.\)\(]+\s*/, ''))
                .filter(Boolean)
              if (sentenceSplit.length > sentences.length) {
                sentences = sentenceSplit
              }
            }
            return sentences
          }
          return []
        })(),
        workStrong: profile.overviewWork?.workStrong || profile.workStrong || '',
        workPlace: profile.overviewWork?.workPlace || profile.workPlace || '',
        physicalAct: profile.overviewWork?.physicalAct || profile.physicalAct || ''
      },
      
      // 개요 - 커리어 전망
      overviewProspect: {
        main: profile.overviewProspect?.main || profile.prospect || ''
      },
      
      // 개요 - 핵심 능력·자격
      overviewAbilities: {
        abilityList: extractListItems(profile.overviewAbilities?.abilityList) 
          || extractListItems(profile.abilityList),
        technKnow: profile.overviewAbilities?.technKnow || profile.technKnow || '',
        eduLevel: profile.overviewAbilities?.eduLevel || profile.eduLevel || '',
        skillYear: profile.overviewAbilities?.skillYear || profile.skillYear || ''
      },
      
      // 개요 - 적성 및 흥미
      overviewAptitude: {
        aptitudeList: extractListItems(profile.overviewAptitude?.aptitudeList)
          || extractListItems(profile.aptitudeList),
        interestList: extractListItems(profile.overviewAptitude?.interestList)
          || extractListItems(profile.interestList)
      },
      
      // 개요 - 여담 (리스트 형식)
      trivia: typeof profile.trivia === 'string' 
        ? profile.trivia.split(/\n|•/).map((s: string) => s.trim()).filter(Boolean)
        : (Array.isArray(profile.trivia) ? profile.trivia : []),
      
      // 상세정보 - 직업 준비하기
      detailReady: {
        curriculum: extractListItems(profile.detailReady?.curriculum),
        recruit: extractListItems(profile.detailReady?.recruit),
        training: extractListItems(profile.detailReady?.training),
        researchList: extractListItems(profile.detailReady?.researchList)
      },
      
      // 사이드바 - 연관 정보
      sidebarJobs: extractListItems(profile.sidebarJobs),
      sidebarMajors: extractListItems(profile.sidebarMajors),
      sidebarCerts: extractListItems(profile.sidebarCerts),

      // 차트 데이터 (레거시→통일 포맷 변환)
      detailIndicators: convertIndicatorsToUnified(profile.detailIndicators),
      detailEducation: {
        educationDistribution: convertDistributionToUnified(
          profile.detailEducation?.educationDistribution, '학력 분포', 'bar', '%', EDUCATION_LABELS
        ),
        majorDistribution: convertDistributionToUnified(
          profile.detailEducation?.majorDistribution, '전공 분포', 'doughnut', '%', MAJOR_DIST_LABELS
        )
      },
      prospectChart: convertProspectToUnified(profile.overviewProspect?.jobSumProspect ?? undefined),
      customCharts: (profile as any).customCharts || [],

      // 사용자가 추가한 출처 (수정/삭제 가능)
      _sources: (profile as any)._sources || {}
    }

    // 디버깅: 데이터가 비어있는지 확인
    const dataKeys = Object.keys(editData)
    const nonEmptyKeys = dataKeys.filter(key => {
      const value = editData[key as keyof typeof editData]
      return value !== null && value !== undefined && value !== ''
    })
    
    
    // lastUpdatedAt 조회
    let lastUpdatedAt: number | null = null
    if (c.env.DB) {
      try {
        const jobMeta = await c.env.DB.prepare('SELECT user_last_updated_at FROM jobs WHERE id = ?')
          .bind(actualDbId).first<{ user_last_updated_at: number | null }>()
        lastUpdatedAt = jobMeta?.user_last_updated_at ?? null
      } catch (_e) { /* ignore */ }
    }

    return c.json({
      success: true,
      data: editData,
      entityId: actualDbId, // 실제 데이터베이스 ID 사용
      entityType: 'job',
      lastUpdatedAt
    })
  } catch (error) {
    return c.json({
      success: false,
      error: error instanceof Error ? error.message : '편집 데이터 조회 실패'
    }, 500)
  }
})

// 전공 편집 모드용 데이터 조회 API
apiDataRoutes.get('/api/major/:id/edit-data', async (c) => {
  try {
    // 캐시 방지 (편집 직후 최신 데이터 보장)
    c.header('Cache-Control', 'no-store')
    c.header('Pragma', 'no-cache')
    c.header('Expires', '0')

    const id = c.req.param('id')
    let userContributedJson: any = {} // 전체 스코프에서 사용할 변수 선언
    
    
    // 사용자 생성 전공 (U_ prefix)은 그대로 사용
    let resolvedId = id
    if (!id.startsWith('U_')) {
      // 전공 상세페이지와 동일한 ID 해결 로직 사용
      resolvedId = resolveDetailIdFromSlug('major', id)
    }
    
    
    // 실제 DB ID 찾기 (전공 상세페이지와 동일한 로직)
    let actualDbId = resolvedId
    if (c.env.DB) {
      try {
        // composite ID인 경우 (major:C_xxx 또는 major:G_xxx)
        if (resolvedId.includes(':')) {
          const parts = resolvedId.split(':')
          if (parts.length > 1) {
            const sourceId = parts[parts.length - 1].replace(/^C_/, '').replace(/^G_/, '')
            // careernet_id나 goyong24_id로 실제 DB ID 찾기
            const dbResult = await c.env.DB.prepare(
              'SELECT id FROM majors WHERE careernet_id = ? OR goyong24_id = ? LIMIT 1'
            ).bind(sourceId, sourceId).first() as { id: string } | null
            if (dbResult?.id) {
              actualDbId = dbResult.id
            } else {
            }
          }
        } else {
          // resolvedId가 composite ID가 아닌 경우 DB에서 찾기
          // ID로 직접 조회 시도
          let dbResult = await c.env.DB.prepare(
            'SELECT id FROM majors WHERE id = ? AND is_active = 1 LIMIT 1'
          ).bind(resolvedId).first() as { id: string } | null
          
          
          if (!dbResult) {
            // slug로 조회 시도 (정규화된 이름으로)
            const decodedSlug = decodeURIComponent(id)
            const lowerSlug = decodedSlug.toLowerCase()
            const normalizedSlug = lowerSlug.replace(/[-,·ㆍ\/\s()]/g, '')

            // 방법 1: name_normalized 인덱스로 조회 (풀스캔 제거)
            dbResult = await c.env.DB.prepare(
              'SELECT id FROM majors WHERE name_normalized = ? AND is_active = 1 LIMIT 1'
            ).bind(normalizedSlug).first() as { id: string } | null

            if (!dbResult) {
              // 방법 2: 이름으로 직접 조회 (대소문자 무시)
              dbResult = await c.env.DB.prepare(
                'SELECT id FROM majors WHERE LOWER(name) = ? AND is_active = 1 LIMIT 1'
              ).bind(lowerSlug).first() as { id: string } | null
            }

            if (!dbResult) {
              // 방법 3: 원본 slug로 조회
              dbResult = await c.env.DB.prepare(
                'SELECT id FROM majors WHERE LOWER(name) = LOWER(?) AND is_active = 1 LIMIT 1'
              ).bind(decodedSlug).first() as { id: string } | null
            }
          }
          
          if (dbResult?.id) {
            actualDbId = dbResult.id
          } else {
            actualDbId = resolvedId
          }
        }
      } catch (dbError) {
        // DB 조회 실패 시 resolvedId 사용
        actualDbId = resolvedId
      }
    }
    
    // 사용자 기여 데이터 우선 로드 (역사/편집 데이터 일치 보장)
    if (c.env.DB) {
      try {
        const ucRow = await c.env.DB.prepare(
          'SELECT user_contributed_json FROM majors WHERE id = ? LIMIT 1'
        ).bind(actualDbId).first<{ user_contributed_json: string | null }>()
        if (ucRow?.user_contributed_json) {
          userContributedJson = JSON.parse(ucRow.user_contributed_json)
        }
      } catch (ucError) {
      }
    }
    
    // 전공 상세페이지와 동일한 방식으로 데이터 조회
    // actualDbId가 실제 DB ID인 경우 그대로 사용, 아니면 resolvedId 사용
    const searchId = actualDbId !== resolvedId ? actualDbId : resolvedId
    const result = await getUnifiedMajorDetail(
      {
        id: searchId, // 실제 DB ID 또는 resolvedId
        careernetId: undefined,
        goyong24Params: undefined
      },
      c.env
    )

    if (!result.profile) {
      // 원본 slug로도 시도 (composite ID가 아닌 경우에만)
      if (searchId !== id && !id.includes(':')) {
        const retryResult = await getUnifiedMajorDetail(
          {
            id: id,
            careernetId: undefined,
            goyong24Params: undefined
          },
          c.env
        )
        if (retryResult.profile) {
          // retryResult 사용
          const profile = retryResult.profile
          
          // 헬퍼 함수: 배열에서 이름/텍스트 추출
          const extractListItems = (list: any[] | undefined): string[] => {
            if (!Array.isArray(list)) return []
            return list
              .map((item: any) => {
                if (typeof item === 'string') return item.trim()
                return (item?.name || item?.value || '').trim()
              })
              .filter(Boolean)
          }
          
          const heroTags = Array.isArray((profile as any).heroTags) ? (profile as any).heroTags : []
          const categoryName = typeof (profile as any).categoryName === 'string' ? (profile as any).categoryName : ((profile as any).categoryName?.value || '')
          
          const editData = {
            name: profile.name || '',
            summary: profile.summary || '',
            heroTags: heroTags,
            categoryName: categoryName,
            property: profile.property || '',
            aptitude: profile.aptitude || '',
            relatedMajors: extractListItems(profile.relatedMajors),
            mainSubjects: extractListItems(profile.mainSubjects),
            relatedJobs: extractListItems(profile.relatedJobs),
            whatStudy: profile.whatStudy || '',
            mainSubject: profile.mainSubject || '',
            relateSubject: profile.relateSubject || '',
            enterField: typeof profile.enterField === 'string' ? profile.enterField : (profile.enterField ? JSON.stringify(profile.enterField, null, 2) : ''),
            jobProspect: profile.jobProspect || '',
            careerAct: profile.careerAct || '',

            // 차트 데이터 (레거시→통일 포맷 변환)
            chartData: (() => {
              let cd: any = (profile as any).chartData
              if (typeof cd === 'string') { try { cd = JSON.parse(cd) } catch { cd = null } }
              if (Array.isArray(cd)) cd = cd[0]
              if (!cd) return {}
              return {
                after_graduation: convertMajorChartToUnified(cd.after_graduation, '졸업 후 진로', 'doughnut', '%'),
                employment_rate: convertMajorChartToUnified(cd.employment_rate, '취업률', 'bar', '%'),
                avg_salary: convertMajorChartToUnified(cd.avg_salary, '평균 연봉', 'bar', '만원'),
                satisfaction: convertMajorChartToUnified(cd.satisfaction, '만족도', 'bar', '점'),
                field: convertMajorChartToUnified(cd.field, '진출 분야', 'bar', '%'),
                gender: convertMajorChartToUnified(cd.gender, '성비', 'doughnut', '%'),
                applicant: convertMajorChartToUnified(cd.applicant, '입학 현황', 'bar', '명'),
              }
            })(),
            customCharts: (profile as any).customCharts || []
          }
          
          // 프로필 이름으로 실제 DB ID 찾기
          if (c.env.DB && profile.name) {
            try {
              const dbResult = await c.env.DB.prepare(
                'SELECT id FROM majors WHERE LOWER(name) = LOWER(?) AND is_active = 1 LIMIT 1'
              ).bind(profile.name).first() as { id: string } | null
              if (dbResult?.id) {
                actualDbId = dbResult.id
              }
            } catch (e) {
            }
          }
          
          // lastUpdatedAt 조회
          let majorMetaRetry: { user_last_updated_at: number | null } | null = null
          if (c.env.DB) {
            try {
              majorMetaRetry = await c.env.DB.prepare('SELECT user_last_updated_at FROM majors WHERE id = ?')
                .bind(actualDbId || id).first<{ user_last_updated_at: number | null }>()
            } catch (_e) { /* ignore */ }
          }

          return c.json({
            success: true,
            data: editData,
            entityId: actualDbId || id,
            entityType: 'major',
            lastUpdatedAt: majorMetaRetry?.user_last_updated_at ?? null
          })
        }
      }
      return c.json({
        success: false,
        error: '전공 정보를 찾을 수 없습니다.'
      }, 404)
    }
    
    // 프로필을 찾은 경우, 실제 DB ID를 다시 확인
    if (actualDbId === resolvedId && !actualDbId.includes(':') && c.env.DB) {
      try {
        // 프로필 이름으로 실제 DB ID 찾기
        const profileName = result.profile.name
        if (profileName) {
          const dbResult = await c.env.DB.prepare(
            'SELECT id FROM majors WHERE LOWER(name) = LOWER(?) AND is_active = 1 LIMIT 1'
          ).bind(profileName).first() as { id: string } | null
          if (dbResult?.id) {
            actualDbId = dbResult.id
          }
        }
      } catch (e) {
      }
    }

    const profile = result.profile
    
    // 헬퍼 함수: 배열에서 이름/텍스트 추출
    const extractListItems = (list: any[] | undefined): string[] => {
      if (!Array.isArray(list)) return []
      return list
        .map((item: any) => {
          if (typeof item === 'string') return item.trim()
          return (item?.name || item?.value || '').trim()
        })
        .filter(Boolean)
    }
    
    // heroTags 처리: profile.heroTags 또는 tagList
    let heroTags: string[] = []
    if (Array.isArray((profile as any).heroTags)) {
      heroTags = (profile as any).heroTags
    }
    
    // categoryName 처리
    let categoryName = ''
    if (typeof (profile as any).categoryName === 'string') {
      categoryName = (profile as any).categoryName
    } else if ((profile as any).categoryName?.value) {
      categoryName = (profile as any).categoryName.value
    }
    
    // 편집 가능한 필드만 추출 (편집 모드 UI 필드 구조에 맞춤)
    const extractListItemsWithSubjects = (list: any[] | undefined): string[] => {
      if (!Array.isArray(list)) return []
      return list
        .map((item: any) => {
          if (typeof item === 'string') return item.trim()
          return (
            item?.name ||
            item?.value ||
            item?.subject_name ||
            item?.SUBJECT_NM ||
            ''
          ).trim()
        })
        .filter(Boolean)
    }
    const toStringList = (val: any): string[] => {
      if (Array.isArray(val)) {
        return val.map(v => (typeof v === 'string' ? v : (v?.text || v?.value || v?.name || ''))).filter(Boolean)
      }
      if (typeof val === 'string') {
        return val.split(/\n+/).map(s => s.trim()).filter(Boolean)
      }
      return []
    }
    
    const toPairList = (list: any): Array<{ title: string; description: string }> => {
      if (!list) return []
      if (typeof list === 'string') {
        return list.split(/\n+/).map(line => line.trim()).filter(Boolean).map(line => ({ title: line, description: '' }))
      }
      if (Array.isArray(list)) {
        return list.map(item => {
          const anyItem = item as any
          const title =
            anyItem.title ||
            anyItem.name ||
            anyItem.gradeuate ||
            anyItem.field_name ||
            anyItem.act_name ||
            anyItem.ACT_NM ||
            anyItem.SBJECT_NM ||    // 커리어넷 실제 키 (U 없음)
            anyItem.SUBJECT_NM ||
            anyItem.subject_name ||
            ''
          const description =
            anyItem.description ||
            anyItem.desc ||
            anyItem.text ||
            anyItem.field_description ||
            anyItem.field_desc ||
            anyItem.act_description ||
            anyItem.ACT_SUMRY ||
            anyItem.SBJECT_SUMRY || // 커리어넷 실제 키 (U 없음)
            anyItem.subject_description ||
            anyItem.SUBJECT_SUMRY ||
            ''
          if (!title && !description) return null
          return { title, description }
        }).filter(Boolean) as Array<{ title: string; description: string }>
      }
      return []
    }
    
    // hero description: 템플릿과 동일 (heroSummary 우선, 없으면 summary/CAREERNET/GOYONG24 첫 문장)
    const heroDescription =
      (profile as any).heroSummary ||
      (profile.summary || result.partials?.CAREERNET?.summary || result.partials?.GOYONG24?.summary)
        ?.split('\n')[0]
        ?.trim() ||
      ''
    
    // overview summary: DB user_contributed_json 우선, 그 다음 merged → summary까지 폴백 (템플릿과 동일)
    const isUserCreatedMajor = (profile.id || '').startsWith('U_')
    const overviewSummary = (userContributedJson?.overview?.summary)
      || (profile as any).overview?.summary
      || profile.summary
      || (isUserCreatedMajor ? profile.summary : '')
      || ''
    // 사이드바 데이터
    const mapAutocompleteItems = (arr: any[] | undefined, type: 'job' | 'major' | 'howto') => {
      if (!Array.isArray(arr)) return []
      return arr.map(item => {
        if (typeof item === 'string') return { name: item, slug: item }
        return { name: item?.name || item?.title || '', slug: item?.slug || item?.id || item?.name || item?.title || '' }
      }).filter(i => i.name)
    }
    
    // 교육과정: 기초/심화 기본값 + mainSubjects 파싱 (템플릿과 동일한 순서)
    let basicSubjectsParsed = extractListItemsWithSubjects((profile as any).basicSubjects)
    let advancedSubjectsParsed = extractListItemsWithSubjects((profile as any).advancedSubjects)
    let relateSubjectParsed = extractListItemsWithSubjects(profile.relateSubject)
    // mainSubjects가 pairList 형태면 제목만 태그로 노출 (상세는 mainSubject pairList로 별도 저장)
    const mainSubjectsRaw = profile.mainSubjects
    if (Array.isArray(mainSubjectsRaw) && mainSubjectsRaw.length > 0) {
      const hasPairListShape = mainSubjectsRaw.some((i: any) => typeof i === 'object' && (i.title || i.subject_name || i.SUBJECT_NM))
      if (hasPairListShape) {
        const titles = mainSubjectsRaw
          .map((i: any) => i.title || i.subject_name || i.SUBJECT_NM || '')
          .filter(Boolean)
          .map((t: string) => t.trim())
          .filter(Boolean)
        if (basicSubjectsParsed.length === 0 && titles.length > 0) {
          basicSubjectsParsed = [...titles]
        }
      } else if (basicSubjectsParsed.length === 0 && advancedSubjectsParsed.length === 0) {
        // 문자열/배열 기반 파싱 (‡ 구분자)
        const firstSubject = mainSubjectsRaw[0]
        if (typeof firstSubject === 'string' && firstSubject.includes('‡')) {
          const sections = firstSubject.split('‡').filter((s: string) => s.trim())
          sections.forEach(section => {
            if (section.includes('기초과목')) {
              const subjects = section.replace(/^.*?기초과목\s*[:：]\s*/i, '')
                .split(/[,、]\s*/)
                .map((s: string) => s.trim())
                .filter((s: string) => s && s !== '등')
              basicSubjectsParsed.push(...subjects)
            } else if (section.includes('심화과목')) {
              const subjects = section.replace(/^.*?심화과목\s*[:：]\s*/i, '')
                .split(/[,、]\s*/)
                .map((s: string) => s.trim())
                .filter((s: string) => s && s !== '등')
              advancedSubjectsParsed.push(...subjects)
            }
          })
        }
      }
    }

    const editData = {
      name: profile.name || '',
      heroSummary: heroDescription || profile.summary || '',  // 히어로 섹션 전용 (개요와 분리)
      heroTags: heroTags,
      categoryName: categoryName,
      
      // 개요
      'overview.summary': overviewSummary,
      property: profile.property || '',
      aptitude: profile.aptitude || '',
      enterField: toPairList(profile.enterField),
      // 여담은 trivia 필드만 사용 (진로전망 jobProspect와 분리)
      trivia: toStringList((profile as any).trivia),
      
      // 상세정보 - 교육과정
      whatStudy: profile.whatStudy || '',
      basicSubjects: basicSubjectsParsed,
      advancedSubjects: advancedSubjectsParsed,
      // 대학 주요 교과목 상세: mainSubject 우선, 없으면 main_subject, 없으면 mainSubjects
      mainSubject: toPairList(
        (profile as any).mainSubject ||
        (profile as any).main_subject ||
        (profile as any).mainSubjects
      ),
      // 고교 추천 교과목: pairList로 제공 (제목/설명), [출처]로 시작하는 항목은 제외
      relateSubject: toPairList(profile.relateSubject || (profile as any).relate_subject).filter(
        (item) => item.title && !item.title.trim().startsWith('[출처')
      ),
      
      // 상세정보 - 진로 탐색 활동
      careerAct: toPairList(profile.careerAct),
      
      // 사이드바
      sidebarJobs: mapAutocompleteItems((profile as any).sidebarJobs || profile.relatedJobs, 'job'),
      sidebarMajors: mapAutocompleteItems((profile as any).sidebarMajors || profile.relatedMajors, 'major'),
      sidebarHowtos: mapAutocompleteItems((profile as any).sidebarHowtos, 'howto'),
      
      // 사용자 출처 (편집창에서 다중 입력 지원)
      _sources: (profile as any)._sources || {}
    }

    // lastUpdatedAt 조회
    let majorLastUpdatedAt: number | null = null
    if (c.env.DB) {
      try {
        const majorMeta = await c.env.DB.prepare('SELECT user_last_updated_at FROM majors WHERE id = ?')
          .bind(actualDbId).first<{ user_last_updated_at: number | null }>()
        majorLastUpdatedAt = majorMeta?.user_last_updated_at ?? null
      } catch (_e) { /* ignore */ }
    }

    return c.json({
      success: true,
      data: editData,
      entityId: actualDbId, // 실제 데이터베이스 ID 사용
      entityType: 'major',
      lastUpdatedAt: majorLastUpdatedAt
    })
  } catch (error) {
    return c.json({
      success: false,
      error: error instanceof Error ? error.message : '편집 데이터 조회 실패'
    }, 500)
  }
})

// 미리보기 API 제거됨 (편집 모드에서 미리보기 기능 없음)


apiDataRoutes.get('/api/categories', async (c) => {
  return c.json({
    success: true,
    jobCategories: JOB_CATEGORIES,
    aptitudeTypes: APTITUDE_TYPES
  })
})

// ============================================================================
// 카드 HTML 렌더링 API (클라이언트 정렬 시 사용)
// ============================================================================


apiDataRoutes.post('/api/job/cards', async (c) => {
  try {
    const body = await c.req.json<{ items: Array<{ profile: any; display?: any }> }>()
    const items = body.items || []
    
    if (!Array.isArray(items) || items.length === 0) {
      return c.json({ html: '', count: 0 })
    }
    
    const html = items.map((item) => renderJobCard(item)).join('')
    
    return c.json({
      html,
      count: items.length
    })
  } catch (error) {
    return c.json({
      error: error instanceof Error ? error.message : '카드 렌더링 실패',
      html: '',
      count: 0
    }, 500)
  }
})


apiDataRoutes.post('/api/major/cards', async (c) => {
  try {
    const body = await c.req.json<{ items: Array<{ profile: any; display?: any }> }>()
    const items = body.items || []
    
    if (!Array.isArray(items) || items.length === 0) {
      return c.json({ html: '', count: 0 })
    }
    
    const html = items.map((item) => renderMajorCard(item)).join('')
    
    return c.json({
      html,
      count: items.length
    })
  } catch (error) {
    return c.json({
      error: error instanceof Error ? error.message : '카드 렌더링 실패',
      html: '',
      count: 0
    }, 500)
  }
})


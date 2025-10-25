export type AnalysisType = 'job' | 'major'
export type PricingTier = 'free' | 'pro'
export type RequestStatus = 'pending' | 'processing' | 'completed' | 'failed'

export interface CreateSessionInput {
  sessionId?: string
  userIdentifier?: string | null
  traitsSnapshot?: unknown
}

export interface AiSessionRecord {
  id: string
  userIdentifier?: string | null
  traitsSnapshot?: unknown
  createdAt: string
  lastActiveAt: string
}

export interface CreateAnalysisRequestInput {
  sessionId: string
  analysisType: AnalysisType
  pricingTier?: PricingTier
  promptPayload: unknown
  status?: RequestStatus
}

export interface AiAnalysisRequestRecord {
  id: number
  sessionId: string
  analysisType: AnalysisType
  pricingTier: PricingTier
  promptPayload: unknown
  status: RequestStatus
  requestedAt: string
  processedAt?: string | null
}

export interface CreateAnalysisResultInput {
  requestId: number
  provider: string
  model?: string | null
  completionTokens?: number | null
  promptTokens?: number | null
  totalTokens?: number | null
  latencyMs?: number | null
  responseSummary?: string | null
  responsePayload: unknown
  requestStatus?: RequestStatus
}

export interface AiAnalysisResultRecord {
  id: number
  requestId: number
  provider: string
  model?: string | null
  completionTokens?: number | null
  promptTokens?: number | null
  totalTokens?: number | null
  latencyMs?: number | null
  responseSummary?: string | null
  responsePayload: unknown
  createdAt: string
}

export interface SerpInteractionLogInput {
  pageType: 'job' | 'major'
  action: string
  keywordLength?: number | null
  category?: string | null
  perPage?: number | null
  results?: number | null
  cacheStatus?: string | null
  durationMs?: number | null
  sampled?: boolean | null
  source?: string | null
}

export interface SerpInteractionLogRecord extends SerpInteractionLogInput {
  id: number
  recordedAt: string
}

export interface SerpInteractionSummaryRow {
  logDate: string
  pageType: 'job' | 'major'
  action: string
  samples: number
  avgDurationMs?: number | null
  avgResults?: number | null
  cacheHitRatio?: number | null
}

export interface SerpSummaryQueryOptions {
  startDate?: string
  endDate?: string
  pageType?: 'job' | 'major'
  action?: string
  limit?: number
}

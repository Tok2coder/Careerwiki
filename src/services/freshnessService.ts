import { withKvCache, buildListCacheKey, type CacheState } from './cacheService'
import {
  searchUnifiedJobs,
  searchUnifiedMajors,
  type UnifiedSearchResult,
  type UnifiedJobSummaryEntry,
  type UnifiedMajorSummaryEntry,
  type SourceStatusRecord,
  type CareerWikiEnv
} from './profileDataService'
import {
  SERP_FRESHNESS_TARGETS,
  type FreshnessTarget,
  type FreshnessTargetParams,
  type FreshnessListType
} from '../config/freshnessConfig'
import {
  LIST_CACHE_STALE_SECONDS,
  LIST_CACHE_MAX_AGE_SECONDS,
  FRESHNESS_SNAPSHOT_TTL_SECONDS,
  FRESHNESS_INDEX_LIMIT
} from '../config/cachePolicy'
import type { DataSource } from '../types/unifiedProfiles'

const FRESHNESS_SNAPSHOT_PREFIX = 'freshness:snapshot:'
const FRESHNESS_INDEX_PREFIX = 'freshness:index:'
const FRESHNESS_SCHEDULE_PREFIX = 'freshness:schedule:'
const SCHEDULE_STATE_TTL_SECONDS = 60 * 60 * 24 * 30 // 30 days

const targetByBaseKey = new Map<string, FreshnessTarget>()
const targetById = new Map<string, FreshnessTarget>()

SERP_FRESHNESS_TARGETS.forEach((target) => {
  const baseKey = buildListCacheKey(target.type, normalizeParams(target.type, target.params))
  targetByBaseKey.set(baseKey, target)
  targetById.set(target.id, target)
})

export type FreshnessTrigger = 'runtime' | 'scheduled' | 'manual'

export interface FreshnessSnapshot {
  id: string
  baseKey: string
  type: FreshnessListType
  params: NormalizedParams
  capturedAt: number
  trigger: FreshnessTrigger
  totalItems: number
  reportedTotal?: number
  sources?: SourceStatusRecord
  cacheStatus?: CacheState['status']
  cacheTimestamps?: {
    cachedAt: number
    staleAt: number
    expiresAt: number
  }
  targetId?: string
  targetDescription?: string
  notes?: string[]
  error?: string
}

export interface FreshnessScheduleState {
  targetId: string
  intervalMinutes: number
  jitterMinutes?: number
  nextRunAt?: number
  lastRunAt?: number
  lastAttemptAt?: number
  lastRuntimeAt?: number
  lastFailureAt?: number
  consecutiveFailures?: number
  lastStatus?: 'success' | 'failure'
  lastError?: string
  inProgress?: boolean
}

export interface FreshnessStatusResponse {
  generatedAt: number
  targets: Array<{
    target: FreshnessTarget
    baseKey: string
    schedule: FreshnessScheduleState
    latestSnapshot?: FreshnessSnapshot
    overdueBySeconds?: number
  }>
  recentSnapshots: FreshnessSnapshot[]
}

interface NormalizedParams {
  keyword?: string
  category?: string
  page: number
  perPage: number
  includeSources?: DataSource[]
}

interface RecordFreshnessInput {
  type: FreshnessListType
  params: FreshnessTargetParams
  trigger: FreshnessTrigger
  cacheState?: CacheState
  totalItems: number
  reportedTotal?: number
  sources?: SourceStatusRecord
  notes?: string[]
  error?: string
}

interface ScheduleAttemptOptions {
  force?: boolean
  reason?: string
}

export interface ScheduleAttemptResult {
  targetId: string
  outcome: 'success' | 'skipped' | 'error'
  reason?: string
  snapshot?: FreshnessSnapshot
  schedule?: FreshnessScheduleState
  cacheState?: CacheState
  error?: string
}

function normalizeIncludeSources(sources?: DataSource[]): DataSource[] | undefined {
  if (!sources || sources.length === 0) return undefined
  const unique = Array.from(new Set(sources))
  unique.sort()
  return unique
}

function normalizeParams(type: FreshnessListType, params: FreshnessTargetParams): NormalizedParams {
  const normalized: NormalizedParams = {
    keyword: params.keyword?.trim() || undefined,
    page: params.page ?? 1,
    perPage: params.perPage ?? 20,
    includeSources: normalizeIncludeSources(params.includeSources)
  }
  if (type === 'job') {
    normalized.category = params.category?.trim() || undefined
  }
  return normalized
}

const buildBaseKey = (type: FreshnessListType, params: FreshnessTargetParams): string => {
  const normalized = normalizeParams(type, params)
  return buildListCacheKey(type === 'job' ? 'job' : 'major', normalized)
}

const toSnapshotKey = (baseKey: string): string => `${FRESHNESS_SNAPSHOT_PREFIX}${baseKey}`
const toIndexKey = (type: FreshnessListType): string => `${FRESHNESS_INDEX_PREFIX}${type}`
const toScheduleKey = (targetId: string): string => `${FRESHNESS_SCHEDULE_PREFIX}${targetId}`

const updateIndex = async (kv: KVNamespace, type: FreshnessListType, snapshotKey: string): Promise<void> => {
  const indexKey = toIndexKey(type)
  const existing = await kv.get<string[]>(indexKey, 'json').catch(() => null)
  const list = existing ? existing.filter((entry) => entry !== snapshotKey) : []
  list.unshift(snapshotKey)
  const truncated = list.slice(0, FRESHNESS_INDEX_LIMIT)
  await kv.put(indexKey, JSON.stringify(truncated), { expirationTtl: FRESHNESS_SNAPSHOT_TTL_SECONDS })
}

const readScheduleState = async (kv: KVNamespace, target: FreshnessTarget): Promise<FreshnessScheduleState> => {
  const key = toScheduleKey(target.id)
  const stored = await kv.get<FreshnessScheduleState>(key, 'json').catch(() => null)
  if (stored) {
    stored.intervalMinutes = target.schedule.intervalMinutes
    stored.jitterMinutes = target.schedule.jitterMinutes
    return stored
  }
  return {
    targetId: target.id,
    intervalMinutes: target.schedule.intervalMinutes,
    jitterMinutes: target.schedule.jitterMinutes
  }
}

const saveScheduleState = async (kv: KVNamespace, state: FreshnessScheduleState): Promise<void> => {
  const key = toScheduleKey(state.targetId)
  await kv.put(key, JSON.stringify(state), { expirationTtl: SCHEDULE_STATE_TTL_SECONDS })
}

const computeNextRunAt = (now: number, target: FreshnessTarget, consecutiveFailures = 0): number => {
  const intervalSeconds = target.schedule.intervalMinutes * 60
  const fallbackSeconds = (target.schedule.fallbackIntervalMinutes ?? target.schedule.intervalMinutes * 2) * 60
  const failureFactor = consecutiveFailures > 0 ? Math.min(fallbackSeconds, intervalSeconds * (consecutiveFailures + 1)) : intervalSeconds
  const jitterSeconds = (target.schedule.jitterMinutes ?? 0) * 60
  const randomJitter = jitterSeconds ? Math.floor(Math.random() * jitterSeconds * 2) - jitterSeconds : 0
  const base = now + failureFactor + randomJitter
  return Math.max(base, now + Math.floor(intervalSeconds * 0.5))
}

const markScheduleStart = async (
  kv: KVNamespace,
  target: FreshnessTarget,
  state: FreshnessScheduleState,
  now: number
): Promise<FreshnessScheduleState> => {
  const updated: FreshnessScheduleState = {
    ...state,
    targetId: target.id,
    intervalMinutes: target.schedule.intervalMinutes,
    jitterMinutes: target.schedule.jitterMinutes,
    lastAttemptAt: now,
    inProgress: true
  }
  await saveScheduleState(kv, updated)
  return updated
}

const markScheduleSuccess = async (
  kv: KVNamespace,
  target: FreshnessTarget,
  state: FreshnessScheduleState,
  now: number
): Promise<FreshnessScheduleState> => {
  const nextRunAt = computeNextRunAt(now, target, 0)
  const updated: FreshnessScheduleState = {
    ...state,
    targetId: target.id,
    intervalMinutes: target.schedule.intervalMinutes,
    jitterMinutes: target.schedule.jitterMinutes,
    lastRunAt: now,
    lastStatus: 'success',
    lastError: undefined,
    consecutiveFailures: 0,
    inProgress: false,
    nextRunAt
  }
  await saveScheduleState(kv, updated)
  return updated
}

const markScheduleFailure = async (
  kv: KVNamespace,
  target: FreshnessTarget,
  state: FreshnessScheduleState,
  now: number,
  error: string
): Promise<FreshnessScheduleState> => {
  const consecutiveFailures = (state.consecutiveFailures ?? 0) + 1
  const nextRunAt = computeNextRunAt(now, target, consecutiveFailures)
  const updated: FreshnessScheduleState = {
    ...state,
    targetId: target.id,
    intervalMinutes: target.schedule.intervalMinutes,
    jitterMinutes: target.schedule.jitterMinutes,
    lastFailureAt: now,
    lastStatus: 'failure',
    lastError: error,
    consecutiveFailures,
    inProgress: false,
    nextRunAt
  }
  await saveScheduleState(kv, updated)
  return updated
}

const updateScheduleRuntime = async (
  kv: KVNamespace,
  target: FreshnessTarget,
  now: number
): Promise<void> => {
  const state = await readScheduleState(kv, target)
  const updated: FreshnessScheduleState = {
    ...state,
    lastRuntimeAt: now
  }
  await saveScheduleState(kv, updated)
}

export const recordListFreshness = async (
  kv: KVNamespace | undefined,
  input: RecordFreshnessInput
): Promise<FreshnessSnapshot | null> => {
  if (!kv) return null
  const now = Math.floor(Date.now() / 1000)
  const baseKey = buildBaseKey(input.type, input.params)
  const snapshotKey = toSnapshotKey(baseKey)
  const target = targetByBaseKey.get(baseKey)
  const snapshot: FreshnessSnapshot = {
    id: snapshotKey,
    baseKey,
    type: input.type,
    params: normalizeParams(input.type, input.params),
    capturedAt: now,
    trigger: input.trigger,
    totalItems: input.totalItems,
    reportedTotal: input.reportedTotal,
    sources: input.sources,
    cacheStatus: input.cacheState?.status,
    cacheTimestamps: input.cacheState
      ? {
          cachedAt: input.cacheState.cachedAt,
          staleAt: input.cacheState.staleAt,
          expiresAt: input.cacheState.expiresAt
        }
      : undefined,
    targetId: target?.id,
    targetDescription: target?.description,
    notes: input.notes,
    error: input.error
  }

  await kv.put(snapshotKey, JSON.stringify(snapshot), { expirationTtl: FRESHNESS_SNAPSHOT_TTL_SECONDS })
  await updateIndex(kv, input.type, snapshotKey)

  if (target && input.trigger === 'runtime' && target.schedule.allowRuntimeSync) {
    await updateScheduleRuntime(kv, target, now)
  }

  return snapshot
}

const refreshTargetList = async (
  kv: KVNamespace,
  env: CareerWikiEnv,
  target: FreshnessTarget,
  trigger: FreshnessTrigger
): Promise<{ result: UnifiedSearchResult<UnifiedJobSummaryEntry | UnifiedMajorSummaryEntry>; cacheState: CacheState }> => {
  const normalized = normalizeParams(target.type, target.params)
  const baseKey = buildBaseKey(target.type, target.params)
  const metadata = {
    targetId: target.id,
    trigger
  }

  if (target.type === 'job') {
    const { value, cacheState } = await withKvCache(
      kv,
      baseKey,
      async () =>
        searchUnifiedJobs(
          {
            keyword: normalized.keyword,
            category: normalized.category,
            page: normalized.page,
            perPage: normalized.perPage,
            includeSources: normalized.includeSources
          },
          env
        ),
      {
        staleSeconds: LIST_CACHE_STALE_SECONDS,
        maxAgeSeconds: LIST_CACHE_MAX_AGE_SECONDS,
        metadata,
        forceRefresh: true
      }
    )
    return { result: value, cacheState }
  }

  const { value, cacheState } = await withKvCache(
    kv,
    baseKey,
    async () =>
      searchUnifiedMajors(
        {
          keyword: normalized.keyword,
          page: normalized.page,
          perPage: normalized.perPage,
          includeSources: normalized.includeSources
        },
        env
      ),
    {
      staleSeconds: LIST_CACHE_STALE_SECONDS,
      maxAgeSeconds: LIST_CACHE_MAX_AGE_SECONDS,
      metadata,
      forceRefresh: true
    }
  )
  return { result: value, cacheState }
}

export const attemptScheduledRefresh = async (
  kv: KVNamespace | undefined,
  env: CareerWikiEnv,
  target: FreshnessTarget,
  options: ScheduleAttemptOptions = {}
): Promise<ScheduleAttemptResult> => {
  if (!kv) {
    return {
      targetId: target.id,
      outcome: 'skipped',
      reason: 'kv-unavailable'
    }
  }

  const now = Math.floor(Date.now() / 1000)
  let state = await readScheduleState(kv, target)

  if (state.inProgress && !options.force) {
    return {
      targetId: target.id,
      outcome: 'skipped',
      reason: 'already-in-progress',
      schedule: state
    }
  }

  const due = options.force || !state.nextRunAt || now >= (state.nextRunAt ?? 0)
  if (!due) {
    return {
      targetId: target.id,
      outcome: 'skipped',
      reason: 'not-due',
      schedule: state
    }
  }

  state = await markScheduleStart(kv, target, state, now)

  try {
    const trigger: FreshnessTrigger = options.force ? 'manual' : 'scheduled'
    const { result, cacheState } = await refreshTargetList(kv, env, target, trigger)
    const snapshot = await recordListFreshness(kv, {
      type: target.type,
      params: target.params,
      trigger,
      cacheState,
      totalItems: result.items.length,
      reportedTotal: result.meta?.total,
      sources: result.meta?.sources,
      notes: options.reason ? [options.reason] : undefined
    })
    state = await markScheduleSuccess(kv, target, state, now)
    return {
      targetId: target.id,
      outcome: 'success',
      snapshot: snapshot ?? undefined,
      schedule: state,
      cacheState
    }
  } catch (error) {
    const message = error instanceof Error ? error.message : 'Unknown error'
    state = await markScheduleFailure(kv, target, state, now, message)
    await recordListFreshness(kv, {
      type: target.type,
      params: target.params,
      trigger: options.force ? 'manual' : 'scheduled',
      totalItems: 0,
      error: message,
      notes: options.reason ? [options.reason] : undefined
    })
    return {
      targetId: target.id,
      outcome: 'error',
      error: message,
      schedule: state
    }
  }
}

const fetchSnapshot = async (kv: KVNamespace, baseKey: string): Promise<FreshnessSnapshot | undefined> => {
  return (await kv.get<FreshnessSnapshot>(toSnapshotKey(baseKey), 'json').catch(() => null)) ?? undefined
}

const getRecentSnapshots = async (kv: KVNamespace): Promise<FreshnessSnapshot[]> => {
  const keysJob = (await kv.get<string[]>(toIndexKey('job'), 'json').catch(() => null)) ?? []
  const keysMajor = (await kv.get<string[]>(toIndexKey('major'), 'json').catch(() => null)) ?? []
  const combinedKeys = Array.from(new Set([...keysJob, ...keysMajor]))
  const snapshots: FreshnessSnapshot[] = []
  for (const key of combinedKeys) {
    const snapshot = await kv.get<FreshnessSnapshot>(key, 'json').catch(() => null)
    if (snapshot) {
      snapshots.push(snapshot)
    }
  }
  snapshots.sort((a, b) => b.capturedAt - a.capturedAt)
  return snapshots.slice(0, 20)
}

export const getFreshnessStatus = async (kv: KVNamespace | undefined): Promise<FreshnessStatusResponse> => {
  const generatedAt = Math.floor(Date.now() / 1000)
  if (!kv) {
    return {
      generatedAt,
      targets: [],
      recentSnapshots: []
    }
  }

  const targetEntries = await Promise.all(
    SERP_FRESHNESS_TARGETS.map(async (target) => {
      const baseKey = buildBaseKey(target.type, target.params)
      const schedule = await readScheduleState(kv, target)
      const snapshot = await fetchSnapshot(kv, baseKey)
      const overdueBySeconds = schedule.nextRunAt ? Math.max(0, generatedAt - schedule.nextRunAt) : undefined
      return {
        target,
        baseKey,
        schedule,
        latestSnapshot: snapshot,
        overdueBySeconds
      }
    })
  )

  const recentSnapshots = await getRecentSnapshots(kv)

  return {
    generatedAt,
    targets: targetEntries,
    recentSnapshots
  }
}

export const resolveFreshnessTargetById = (id: string): FreshnessTarget | undefined => targetById.get(id)

export const resolveFreshnessTargetByBaseKey = (baseKey: string): FreshnessTarget | undefined => targetByBaseKey.get(baseKey)

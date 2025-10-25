import type { DataSource } from '../types/unifiedProfiles'

export type CacheStatus = 'miss' | 'hit' | 'revalidated' | 'stale' | 'bypass'

export interface CacheState {
  status: CacheStatus
  key: string
  cachedAt: number
  staleAt: number
  expiresAt: number
  metadata?: Record<string, unknown>
}

interface StoredCacheEntry<T> {
  version: string
  cachedAt: number
  staleAt: number
  expiresAt: number
  data: T
  metadata?: Record<string, unknown>
}

export interface KvCacheOptions {
  staleSeconds: number
  maxAgeSeconds: number
  version?: string
  metadata?: Record<string, unknown>
  forceRefresh?: boolean
}

export interface KvCacheResponse<T> {
  value: T
  cacheState: CacheState
}

const DEFAULT_VERSION = 'v1'

const nowSeconds = (): number => Math.floor(Date.now() / 1000)

export const withKvCache = async <T>(
  kv: KVNamespace | undefined,
  key: string,
  fetcher: () => Promise<T>,
  options: KvCacheOptions
): Promise<KvCacheResponse<T>> => {
  const { staleSeconds, maxAgeSeconds, forceRefresh = false } = options
  const version = options.version ?? DEFAULT_VERSION
  const metadata = options.metadata

  if (!kv) {
    const fresh = await fetcher()
    const timestamp = nowSeconds()
    return {
      value: fresh,
      cacheState: {
        status: 'bypass',
        key,
        cachedAt: timestamp,
        staleAt: timestamp + staleSeconds,
        expiresAt: timestamp + maxAgeSeconds,
        metadata
      }
    }
  }

  const attemptFetchAndStore = async (status: CacheStatus): Promise<KvCacheResponse<T>> => {
    const fresh = await fetcher()
    const timestamp = nowSeconds()
    const entry: StoredCacheEntry<T> = {
      version,
      cachedAt: timestamp,
      staleAt: timestamp + staleSeconds,
      expiresAt: timestamp + maxAgeSeconds,
      data: fresh,
      metadata
    }
    await kv.put(key, JSON.stringify(entry), { expiration: entry.expiresAt })
    return {
      value: fresh,
      cacheState: {
        status,
        key,
        cachedAt: entry.cachedAt,
        staleAt: entry.staleAt,
        expiresAt: entry.expiresAt,
        metadata
      }
    }
  }

  if (forceRefresh) {
    return attemptFetchAndStore('miss')
  }

  const stored = await kv.get<StoredCacheEntry<T>>(key, 'json').catch(() => null)

  if (stored && stored.version === version) {
    const timestamp = nowSeconds()

    if (timestamp < stored.staleAt) {
      return {
        value: stored.data,
        cacheState: {
          status: 'hit',
          key,
          cachedAt: stored.cachedAt,
          staleAt: stored.staleAt,
          expiresAt: stored.expiresAt,
          metadata: stored.metadata
        }
      }
    }

    if (timestamp < stored.expiresAt) {
      try {
        return await attemptFetchAndStore('revalidated')
      } catch (error) {
        console.warn(`KV cache revalidation failed for key ${key}:`, error)
        return {
          value: stored.data,
          cacheState: {
            status: 'stale',
            key,
            cachedAt: stored.cachedAt,
            staleAt: stored.staleAt,
            expiresAt: stored.expiresAt,
            metadata: stored.metadata
          }
        }
      }
    }
  }

  try {
    return await attemptFetchAndStore('miss')
  } catch (error) {
    if (stored) {
      console.warn(`KV cache refresh failed for key ${key}, serving stale data:`, error)
      return {
        value: stored.data,
        cacheState: {
          status: 'stale',
          key,
          cachedAt: stored.cachedAt,
          staleAt: stored.staleAt,
          expiresAt: stored.expiresAt,
          metadata: stored.metadata
        }
      }
    }
    throw error
  }
}

const serializeIncludeSources = (sources?: DataSource[]): string | undefined => {
  if (!sources || sources.length === 0) return undefined
  const unique = Array.from(new Set(sources)).sort()
  return unique.join(',')
}

export const buildListCacheKey = (
  type: 'job' | 'major',
  params: {
    keyword?: string
    category?: string
    page?: number
    perPage?: number
    includeSources?: DataSource[]
  }
): string => {
  const search = new URLSearchParams()
  if (params.keyword) {
    search.set('q', params.keyword.trim().toLowerCase())
  }
  if (type === 'job' && params.category) {
    search.set('category', params.category.trim())
  }
  if (params.page && params.page > 1) {
    search.set('page', String(params.page))
  }
  if (params.perPage && params.perPage !== 20) {
    search.set('perPage', String(params.perPage))
  }
  const serializedSources = serializeIncludeSources(params.includeSources)
  if (serializedSources) {
    search.set('sources', serializedSources)
  }

  const keySuffix = search.toString()
  return keySuffix ? `list:${type}:${keySuffix}` : `list:${type}:default`
}

export const secondsToHuman = (seconds: number): string => {
  if (seconds <= 0) return '0초'
  const units: Array<[number, string]> = [
    [60 * 60 * 24, '일'],
    [60 * 60, '시간'],
    [60, '분'],
    [1, '초']
  ]
  const parts: string[] = []
  let remaining = seconds
  for (const [unitSeconds, label] of units) {
    if (remaining >= unitSeconds) {
      const value = Math.floor(remaining / unitSeconds)
      remaining -= value * unitSeconds
      parts.push(`${value}${label}`)
    }
    if (parts.length >= 2) break
  }
  return parts.join(' ') || '0초'
}

export const formatTimestamp = (timestampSeconds: number): string => {
  const date = new Date(timestampSeconds * 1000)
  return `${date.toISOString().replace('T', ' ').slice(0, 16)} UTC`
}

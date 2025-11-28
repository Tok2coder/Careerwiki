import type { D1Database, KVNamespace } from '@cloudflare/workers-types'
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
    try {
      return await attemptFetchAndStore('miss')
    } catch (error) {
      // KV 접근 실패 시 캐시 없이 직접 fetcher 호출
      // 로컬 개발 환경에서는 KV가 없을 수 있으므로 조용히 처리
      if (kv) {
        console.warn(`KV cache force refresh failed for key ${key}, bypassing cache:`, error)
      }
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
  }

  let stored: StoredCacheEntry<T> | null = null
  try {
    stored = await kv.get<StoredCacheEntry<T>>(key, 'json').catch(() => null)
  } catch (error) {
    // KV 접근 실패 시 캐시 없이 직접 fetcher 호출
    // 로컬 개발 환경에서는 KV가 없을 수 있으므로 조용히 처리
    if (kv) {
      console.warn(`KV cache get failed for key ${key}, bypassing cache:`, error)
    }
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
        // KV 저장 실패해도 기존 데이터 반환
        console.warn(`KV cache revalidation failed for key ${key}, serving stale data:`, error)
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
    // KV 저장 실패 시에도 데이터는 반환 (캐시만 저장 실패)
    if (stored) {
      // 로컬 개발 환경에서는 KV가 없을 수 있으므로 조용히 처리
      if (kv) {
        console.warn(`KV cache refresh failed for key ${key}, serving stale data:`, error)
      }
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
    // 저장된 데이터도 없으면 fetcher만 호출 (KV 저장 실패 무시)
    // 로컬 개발 환경에서는 KV가 없을 수 있으므로 조용히 처리
    if (kv) {
      console.warn(`KV cache miss and store failed for key ${key}, bypassing cache:`, error)
    }
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
    sort?: string
  }
): string => {
  const search = new URLSearchParams()
  if (params.keyword) {
    search.set('q', params.keyword.trim().toLowerCase())
  }
  if (type === 'job' && params.category) {
    search.set('category', params.category.trim())
  }
  if (params.sort && params.sort !== 'relevance') {
    search.set('sort', params.sort)
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

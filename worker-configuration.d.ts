/**
 * Cloudflare Workers 환경 변수 타입 정의
 * 
 * 이 파일은 Cloudflare Workers 환경에서 사용되는 환경 변수와 바인딩을 정의합니다.
 */

import type { D1Database, KVNamespace } from '@cloudflare/workers-types'

export interface CloudflareBindings {
  // Database
  DB: D1Database
  
  // Key-Value Store
  KV: KVNamespace
  
  // API Keys
  CAREER_NET_API_KEY?: string
  GOYONG24_MAJOR_API_KEY?: string
  GOYONG24_JOB_API_KEY?: string
  
  // Performance & Monitoring
  PERF_ALERT_WEBHOOK?: string
  
  // Admin
  ADMIN_SECRET?: string
  
  // Environment
  ENVIRONMENT?: string
  
  // Phase 3: Google OAuth (Day 1)
  GOOGLE_CLIENT_ID: string
  GOOGLE_CLIENT_SECRET: string
  GOOGLE_CALLBACK_URL: string
  JWT_SECRET: string
}



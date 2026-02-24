/**
 * Cloudflare Workers 환경 변수 타입 정의
 * 
 * 이 파일은 Cloudflare Workers 환경에서 사용되는 환경 변수와 바인딩을 정의합니다.
 */

import type { D1Database, KVNamespace, R2Bucket, VectorizeIndex, Ai } from '@cloudflare/workers-types'

export interface CloudflareBindings {
  // Database
  DB: D1Database
  
  // Key-Value Store
  KV: KVNamespace
  
  // R2 Storage (이미지/파일 업로드)
  UPLOADS: R2Bucket
  
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
  
  // AI APIs
  OPENAI_API_KEY?: string
  GEMINI_API_KEY?: string

  // Cloudflare API (releases page 등)
  CLOUDFLARE_ACCOUNT_ID?: string
  CLOUDFLARE_API_TOKEN?: string
  CF_ACCOUNT_ID?: string
  CF_PAGES_API_TOKEN?: string
  GITHUB_TOKEN?: string

  // Cloudflare AI & Vectorize
  VECTORIZE: VectorizeIndex
  AI: Ai

  // SEO
  GOOGLE_SITE_VERIFICATION?: string
}



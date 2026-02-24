import type {
  D1Database,
  KVNamespace,
  R2Bucket,
  VectorizeIndex,
  Ai
} from '@cloudflare/workers-types'
import type { UserRole } from '../services/commentService'

// Types
export type Bindings = {
  DB: D1Database;
  KV: KVNamespace;
  UPLOADS: R2Bucket;  // R2 이미지 업로드
  VECTORIZE: VectorizeIndex;  // Vectorize 인덱스 (AI 분석기 후보 검색)
  AI: Ai;  // Workers AI (임베딩 생성)
  CAREER_NET_API_KEY?: string;
  GOYONG24_MAJOR_API_KEY?: string;
  GOYONG24_JOB_API_KEY?: string;
  PERF_ALERT_WEBHOOK?: string;
  ADMIN_SECRET?: string;
  ENVIRONMENT?: string;
  // Z-Image Turbo API (이미지 생성)
  EVOLINK_API_KEY?: string;
  // Phase 3: Google OAuth 환경 변수
  GOOGLE_CLIENT_ID: string;
  GOOGLE_CLIENT_SECRET: string;
  GOOGLE_CALLBACK_URL: string;
  JWT_SECRET: string;
  // Cloudflare API (releases page 등)
  CLOUDFLARE_ACCOUNT_ID?: string;
  CLOUDFLARE_API_TOKEN?: string;
  CF_ACCOUNT_ID?: string;
  CF_ZONE_ID?: string;
  CF_PAGES_API_TOKEN?: string;
  GITHUB_TOKEN?: string;
  GOOGLE_SITE_VERIFICATION?: string;
}

// User 타입 (auth-helpers에서 정의)
export interface User {
  id: number;
  google_id: string;
  provider?: string;
  provider_user_id?: string;
  email: string;
  name: string | null;
  picture_url: string | null;
  custom_picture_url: string | null;  // 사용자가 직접 업로드한 프로필 이미지
  role: 'user' | 'expert' | 'admin';
  username: string | null;
  ban_reason: string | null;
  onboarded?: number;  // 온보딩 완료 여부 (0 or 1)
  created_at: string;
  updated_at: string;
}

export type Variables = {
  title?: string;
  description?: string;
  user?: User | null;
  mark?: (key: string) => void;
}

export type AppEnv = { Bindings: Bindings; Variables: Variables }

// Phase 3 Day 3: 기존 헤더 기반 인증을 JWT 기반으로 변경
// 기존 코드 호환을 위한 타입 유지
export type RequestUser = {
  id: string
  role: UserRole
  name?: string | null
  username?: string | null
  picture_url?: string | null
  custom_picture_url?: string | null
}

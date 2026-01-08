/**
 * 온보딩 서비스
 * 
 * 첫 로그인 사용자를 위한 온보딩 플로우 처리
 * - 닉네임 설정
 * - 유입경로 수집
 * - 약관 동의
 */

import type { D1Database } from '@cloudflare/workers-types'
import { getUserById, updateNickname, completeOnboarding } from '../utils/auth-helpers'
import { validateNickname, NicknameValidationResult } from './profanityService'

// ============================================
// 타입 정의
// ============================================

/**
 * 유입경로 프리셋 값
 */
export const CHANNEL_PRESETS = [
  'google_search',
  'naver_search', 
  'kakao_share',
  'instagram',
  'youtube',
  'community',
  'school_academy',
  'friend_referral',
  'other'
] as const

export type ChannelPreset = typeof CHANNEL_PRESETS[number]

/**
 * 관심 상태 프리셋
 */
export const INTEREST_STATES = [
  'job_search',      // 직업 탐색
  'major_search',    // 전공 탐색
  'career_change',   // 전직 고민
  'consult_interest', // 상담 관심
  'browsing'         // 그냥 둘러보기
] as const

export type InterestState = typeof INTEREST_STATES[number]

/**
 * 커리어 상태 프리셋
 */
export const CAREER_STATES = [
  'high_school',     // 고등학생
  'university',      // 대학생
  'job_seeker',      // 취준생
  'employed',        // 재직자
  'transition',      // 커리어 전환
  'other'            // 기타
] as const

export type CareerState = typeof CAREER_STATES[number]

/**
 * 약관 버전 설정
 */
export const CONSENT_VERSIONS = {
  terms: 'v1.0-2025-12-01',
  privacy: 'v1.0-2025-12-01'
} as const

/**
 * 온보딩 상태 응답
 */
export interface OnboardingStatus {
  onboarded: boolean
  needs: ('nickname' | 'channel' | 'consents')[]
}

/**
 * 온보딩 제출 데이터
 */
export interface OnboardingSubmission {
  nickname: string
  channel: {
    self_channel: ChannelPreset
    self_channel_other?: string
  }
  interest_state?: InterestState
  career_state?: CareerState
  consents: {
    type: 'terms' | 'privacy'
    version: string
  }[]
}

/**
 * 유입경로 저장 데이터
 */
export interface AttributionData {
  self_channel: string
  self_channel_other?: string
  interest_state?: string
  career_state?: string
  utm_source?: string
  utm_medium?: string
  utm_campaign?: string
  utm_content?: string
  utm_term?: string
  referrer?: string
}

// ============================================
// 온보딩 상태 조회
// ============================================

/**
 * 사용자의 온보딩 상태 조회
 */
export async function getOnboardingStatus(
  db: D1Database,
  userId: number
): Promise<OnboardingStatus> {
  const user = await getUserById(db, userId)
  
  if (!user) {
    throw new Error('USER_NOT_FOUND')
  }
  
  // 이미 온보딩 완료
  if (user.onboarded === 1) {
    return {
      onboarded: true,
      needs: []
    }
  }
  
  // 온보딩 필요 항목 확인
  const needs: ('nickname' | 'channel' | 'consents')[] = []
  
  // 닉네임 체크 (임시 user_xxxxx 형태인지)
  if (!user.username || user.username.startsWith('user_')) {
    needs.push('nickname')
  }
  
  // 유입경로 체크
  const attribution = await db
    .prepare('SELECT user_id FROM user_attributions WHERE user_id = ?')
    .bind(userId)
    .first()
  
  if (!attribution) {
    needs.push('channel')
  }
  
  // 동의 체크
  const consents = await db
    .prepare('SELECT type FROM consents WHERE user_id = ?')
    .bind(userId)
    .all<{ type: string }>()
  
  const consentTypes = consents.results?.map(c => c.type) || []
  if (!consentTypes.includes('terms') || !consentTypes.includes('privacy')) {
    needs.push('consents')
  }
  
  return {
    onboarded: false,
    needs
  }
}

// ============================================
// 닉네임 가용성 체크
// ============================================

/**
 * 닉네임 가용성 체크 응답
 */
export interface NicknameCheckResult {
  ok: boolean
  reason?: 'duplicate' | 'invalid' | 'forbidden'
  message?: string
}

/**
 * 닉네임 가용성 체크 (실시간 검증용)
 */
export async function checkNicknameAvailability(
  db: D1Database,
  nickname: string,
  excludeUserId?: number
): Promise<NicknameCheckResult> {
  // 1. 기본 유효성 검증 (profanityService 사용)
  const validation = await validateNickname(db, nickname)
  
  if (!validation.ok) {
    return {
      ok: false,
      reason: validation.reason as 'invalid' | 'forbidden',
      message: validation.message
    }
  }
  
  // 2. 중복 체크
  const existingQuery = excludeUserId
    ? 'SELECT id FROM users WHERE username = ? AND id != ?'
    : 'SELECT id FROM users WHERE username = ?'
  
  const existing = excludeUserId
    ? await db.prepare(existingQuery).bind(nickname, excludeUserId).first()
    : await db.prepare(existingQuery).bind(nickname).first()
  
  if (existing) {
    return {
      ok: false,
      reason: 'duplicate',
      message: '이미 사용 중인 닉네임입니다.'
    }
  }
  
  return { ok: true }
}

// ============================================
// 온보딩 제출
// ============================================

/**
 * 온보딩 데이터 제출 및 처리
 */
export async function submitOnboarding(
  db: D1Database,
  userId: number,
  data: OnboardingSubmission,
  meta: { ip?: string; ua?: string }
): Promise<{ success: boolean; error?: string }> {
  const now = Math.floor(Date.now() / 1000)
  
  console.log('📝 [Onboarding] Processing submission for user:', userId)
  
  // 1. 닉네임 검증
  const nicknameCheck = await checkNicknameAvailability(db, data.nickname, userId)
  if (!nicknameCheck.ok) {
    return { success: false, error: nicknameCheck.message || '닉네임이 유효하지 않습니다.' }
  }
  
  // 2. 유입경로 검증
  if (!CHANNEL_PRESETS.includes(data.channel.self_channel)) {
    return { success: false, error: '유효하지 않은 유입경로입니다.' }
  }
  
  if (data.channel.self_channel === 'other') {
    const otherText = data.channel.self_channel_other?.trim()
    if (!otherText || otherText.length < 1 || otherText.length > 50) {
      return { success: false, error: '기타 유입경로를 입력해주세요. (1-50자)' }
    }
  }
  
  // 3. 관심 상태 검증 (선택)
  if (data.interest_state && !INTEREST_STATES.includes(data.interest_state)) {
    return { success: false, error: '유효하지 않은 관심 상태입니다.' }
  }
  
  // 4. 커리어 상태 검증 (선택)
  if (data.career_state && !CAREER_STATES.includes(data.career_state)) {
    return { success: false, error: '유효하지 않은 커리어 상태입니다.' }
  }
  
  // 5. 동의 검증
  const requiredConsents = ['terms', 'privacy']
  const providedConsents = data.consents.map(c => c.type)
  
  for (const required of requiredConsents) {
    if (!providedConsents.includes(required as 'terms' | 'privacy')) {
      return { success: false, error: `${required === 'terms' ? '이용약관' : '개인정보처리방침'} 동의가 필요합니다.` }
    }
  }
  
  // 버전 검증
  for (const consent of data.consents) {
    const expectedVersion = CONSENT_VERSIONS[consent.type]
    if (consent.version !== expectedVersion) {
      return { success: false, error: `${consent.type} 약관 버전이 일치하지 않습니다.` }
    }
  }
  
  try {
    // 6. 닉네임 저장
    await updateNickname(db, userId, data.nickname)
    console.log('✅ [Onboarding] Nickname saved:', data.nickname)
    
    // 7. 유입경로 저장
    await db
      .prepare(`
        INSERT INTO user_attributions (
          user_id, self_channel, self_channel_other,
          interest_state, career_state, first_touch_at
        ) VALUES (?, ?, ?, ?, ?, ?)
      `)
      .bind(
        userId,
        data.channel.self_channel,
        data.channel.self_channel_other || null,
        data.interest_state || null,
        data.career_state || null,
        now
      )
      .run()
    console.log('✅ [Onboarding] Attribution saved')
    
    // 8. 동의 저장
    for (const consent of data.consents) {
      await db
        .prepare(`
          INSERT INTO consents (user_id, type, version, consented_at, ip, ua)
          VALUES (?, ?, ?, ?, ?, ?)
        `)
        .bind(
          userId,
          consent.type,
          consent.version,
          now,
          meta.ip || null,
          meta.ua || null
        )
        .run()
    }
    console.log('✅ [Onboarding] Consents saved')
    
    // 9. 온보딩 완료 처리
    await completeOnboarding(db, userId)
    console.log('✅ [Onboarding] Completed for user:', userId)
    
    return { success: true }
    
  } catch (error) {
    console.error('❌ [Onboarding] Error:', error)
    return { success: false, error: '온보딩 처리 중 오류가 발생했습니다.' }
  }
}

// ============================================
// 관리자용 조회 함수
// ============================================

/**
 * 사용자의 유입경로 조회
 */
export async function getUserAttribution(
  db: D1Database,
  userId: number
): Promise<AttributionData | null> {
  const result = await db
    .prepare('SELECT * FROM user_attributions WHERE user_id = ?')
    .bind(userId)
    .first<AttributionData & { user_id: number; first_touch_at: number }>()
  
  if (!result) {
    return null
  }
  
  return {
    self_channel: result.self_channel,
    self_channel_other: result.self_channel_other || undefined,
    interest_state: result.interest_state || undefined,
    career_state: result.career_state || undefined,
    utm_source: result.utm_source || undefined,
    utm_medium: result.utm_medium || undefined,
    utm_campaign: result.utm_campaign || undefined,
    utm_content: result.utm_content || undefined,
    utm_term: result.utm_term || undefined,
    referrer: result.referrer || undefined
  }
}

/**
 * 사용자의 동의 이력 조회
 */
export async function getUserConsents(
  db: D1Database,
  userId: number
): Promise<{ type: string; version: string; consented_at: number; ip?: string; ua?: string }[]> {
  const result = await db
    .prepare('SELECT type, version, consented_at, ip, ua FROM consents WHERE user_id = ? ORDER BY consented_at DESC')
    .bind(userId)
    .all<{ type: string; version: string; consented_at: number; ip: string | null; ua: string | null }>()
  
  return result.results?.map(r => ({
    type: r.type,
    version: r.version,
    consented_at: r.consented_at,
    ip: r.ip || undefined,
    ua: r.ua || undefined
  })) || []
}

/**
 * 유입경로 라벨 (한글)
 */
export function getChannelLabel(channel: string): string {
  const labels: Record<string, string> = {
    google_search: 'Google 검색',
    naver_search: '네이버 검색',
    kakao_share: '카카오톡 공유',
    instagram: '인스타그램',
    youtube: '유튜브',
    community: '커뮤니티',
    school_academy: '학교/학원',
    friend_referral: '지인 추천',
    other: '기타'
  }
  return labels[channel] || channel
}

/**
 * 관심 상태 라벨 (한글)
 */
export function getInterestStateLabel(state: string): string {
  const labels: Record<string, string> = {
    job_search: '직업 탐색',
    major_search: '전공 탐색',
    career_change: '전직 고민',
    consult_interest: '상담 관심',
    browsing: '둘러보기'
  }
  return labels[state] || state
}

/**
 * 커리어 상태 라벨 (한글)
 */
export function getCareerStateLabel(state: string): string {
  const labels: Record<string, string> = {
    high_school: '고등학생',
    university: '대학생',
    job_seeker: '취준생',
    employed: '재직자',
    transition: '커리어 전환',
    other: '기타'
  }
  return labels[state] || state
}


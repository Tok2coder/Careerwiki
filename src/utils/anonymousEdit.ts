/**
 * 편집 시스템 익명 사용자 유틸리티 함수
 * 
 * 댓글 시스템과 동일한 로직을 사용하여 일관성 유지
 * - 비밀번호 해시/검증: SHA-256 사용
 * - 익명 번호: entity별로 관리
 * - 일일 편집 제한: IP별, entity별로 추적
 */

import type { D1Database } from '@cloudflare/workers-types'

// 일일 편집 제한 (IP당, entity당)
const MAX_DAILY_EDITS = 10

/**
 * 비밀번호 해시 생성 (댓글 시스템과 동일)
 * 
 * @param password 4자리 숫자 비밀번호
 * @returns SHA-256 해시 문자열
 */
export async function hashEditPassword(password: string): Promise<string> {
  if (!password || password.length !== 4 || !/^\d{4}$/.test(password)) {
    throw new Error('INVALID_PASSWORD')
  }
  
  // Web Crypto API 사용 (Cloudflare Workers 환경)
  const encoder = new TextEncoder()
  const data = encoder.encode(password)
  const hashBuffer = await crypto.subtle.digest('SHA-256', data)
  const hashArray = Array.from(new Uint8Array(hashBuffer))
  return hashArray.map(b => b.toString(16).padStart(2, '0')).join('')
}

/**
 * 비밀번호 검증 (댓글 시스템과 동일)
 * 
 * @param password 입력된 비밀번호
 * @param hash 저장된 해시
 * @returns 검증 성공 여부
 */
export async function verifyEditPassword(password: string, hash: string): Promise<boolean> {
  try {
    const computedHash = await hashEditPassword(password)
    return computedHash === hash
  } catch {
    return false
  }
}

/**
 * IP 주소 해시 생성
 * 
 * @param ip IP 주소 문자열
 * @returns SHA-256 해시 문자열 또는 null
 */
export async function hashIpAddress(ip: string | null | undefined): Promise<string | null> {
  if (!ip) return null
  
  const encoder = new TextEncoder()
  const digest = await crypto.subtle.digest('SHA-256', encoder.encode(ip))
  const hashArray = Array.from(new Uint8Array(digest))
  return hashArray.map(b => b.toString(16).padStart(2, '0')).join('')
}

/**
 * 익명 번호 할당 (entity별, IP별 재사용)
 * 
 * 같은 IP가 같은 entity에 여러 번 편집하면 같은 익명 번호를 재사용
 * 
 * @param db D1 데이터베이스
 * @param entityType 엔티티 타입 ('job', 'major', 'howto')
 * @param entityId 엔티티 ID
 * @param ipHash IP 해시
 * @returns 익명 번호 (1부터 시작)
 */
export async function getNextAnonymousNumber(
  db: D1Database,
  entityType: 'job' | 'major' | 'howto',
  entityId: string,
  ipHash: string
): Promise<number> {
  // 같은 IP가 이미 이 entity에 편집한 기록이 있는지 확인
  const existingRevision = await db
    .prepare(`
      SELECT anonymous_number 
      FROM page_revisions 
      WHERE entity_type = ? 
        AND entity_id = ? 
        AND ip_hash = ? 
        AND anonymous_number IS NOT NULL
      ORDER BY created_at DESC
      LIMIT 1
    `)
    .bind(entityType, entityId, ipHash)
    .first<{ anonymous_number: number }>()
  
  // 기존 번호가 있으면 재사용
  if (existingRevision?.anonymous_number) {
    return existingRevision.anonymous_number
  }
  
  // 새로운 번호 할당: 이 entity의 최대 익명 번호 + 1
  const maxNumberResult = await db
    .prepare(`
      SELECT MAX(anonymous_number) as max_number
      FROM page_revisions
      WHERE entity_type = ? AND entity_id = ? AND anonymous_number IS NOT NULL
    `)
    .bind(entityType, entityId)
    .first<{ max_number: number | null }>()
  
  const maxNumber = maxNumberResult?.max_number ?? 0
  return maxNumber + 1
}

/**
 * 일일 편집 제한 체크
 * 
 * @param db D1 데이터베이스
 * @param entityType 엔티티 타입
 * @param entityId 엔티티 ID
 * @param ipHash IP 해시
 * @returns 제한 초과 여부 (true: 허용, false: 제한 초과)
 */
export async function checkAnonymousEditLimit(
  db: D1Database,
  entityType: 'job' | 'major' | 'howto',
  entityId: string,
  ipHash: string
): Promise<{ allowed: boolean; remaining: number }> {
  if (!ipHash) {
    // IP가 없으면 제한 없음 (로그인 사용자)
    return { allowed: true, remaining: MAX_DAILY_EDITS }
  }
  
  const today = new Date().toISOString().split('T')[0]  // YYYY-MM-DD
  
  const limitRow = await db
    .prepare(`
      SELECT edit_count 
      FROM anonymous_edit_limits 
      WHERE entity_type = ? 
        AND entity_id = ? 
        AND ip_hash = ? 
        AND edit_date = ?
    `)
    .bind(entityType, entityId, ipHash, today)
    .first<{ edit_count: number }>()
  
  const currentCount = limitRow ? Number(limitRow.edit_count ?? 0) : 0
  const remaining = Math.max(0, MAX_DAILY_EDITS - currentCount)
  
  return {
    allowed: currentCount < MAX_DAILY_EDITS,
    remaining
  }
}

/**
 * 익명 편집 카운트 증가
 * 
 * 편집 성공 시 호출하여 일일 제한 카운트를 증가시킴
 * 
 * @param db D1 데이터베이스
 * @param entityType 엔티티 타입
 * @param entityId 엔티티 ID
 * @param ipHash IP 해시
 */
export async function incrementAnonymousEditCount(
  db: D1Database,
  entityType: 'job' | 'major' | 'howto',
  entityId: string,
  ipHash: string
): Promise<void> {
  if (!ipHash) {
    // IP가 없으면 카운트하지 않음 (로그인 사용자)
    return
  }
  
  const today = new Date().toISOString().split('T')[0]  // YYYY-MM-DD
  
  // 기존 레코드가 있으면 카운트 증가, 없으면 생성
  const existing = await db
    .prepare(`
      SELECT id FROM anonymous_edit_limits 
      WHERE entity_type = ? 
        AND entity_id = ? 
        AND ip_hash = ? 
        AND edit_date = ?
    `)
    .bind(entityType, entityId, ipHash, today)
    .first()
  
  if (existing) {
    await db
      .prepare(`
        UPDATE anonymous_edit_limits 
        SET edit_count = edit_count + 1, 
            last_edit_at = CURRENT_TIMESTAMP
        WHERE entity_type = ? 
          AND entity_id = ? 
          AND ip_hash = ? 
          AND edit_date = ?
      `)
      .bind(entityType, entityId, ipHash, today)
      .run()
  } else {
    await db
      .prepare(`
        INSERT INTO anonymous_edit_limits 
        (entity_type, entity_id, ip_hash, edit_date, edit_count, last_edit_at)
        VALUES (?, ?, ?, ?, 1, CURRENT_TIMESTAMP)
      `)
      .bind(entityType, entityId, ipHash, today)
      .run()
  }
}


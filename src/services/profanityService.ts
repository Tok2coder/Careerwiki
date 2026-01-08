/**
 * 욕설/금칙어 필터 서비스
 * 
 * - 닉네임 검증 (금칙어, 패턴, 예약어)
 * - 댓글 내용 필터링 (욕설 치환)
 */

import type { D1Database } from '@cloudflare/workers-types'

// ============================================
// 타입 정의
// ============================================

/**
 * 금칙어 규칙
 */
export interface ProfanityRule {
  id: number
  pattern: string
  replacement: string
  is_active: number
}

/**
 * 닉네임 검증 결과
 */
export interface NicknameValidationResult {
  ok: boolean
  reason?: 'invalid' | 'forbidden' | 'duplicate'
  message?: string
}

/**
 * 욕설 필터 결과
 */
export interface ProfanityFilterResult {
  moderated: boolean
  output: string
  originalInput: string
}

// ============================================
// 닉네임 검증 규칙
// ============================================

/**
 * 닉네임 정규식 패턴
 * - 2~16자
 * - 한글, 영문, 숫자, ._- 허용
 * - 연속 공백 불허
 * - 선두/말미 공백 불허
 */
const NICKNAME_PATTERN = /^(?!.*\s{2,})(?!\s)[A-Za-z0-9가-힣._-]{2,16}(?<!\s)$/

/**
 * 예약어 목록 (닉네임 사용 불가)
 */
const RESERVED_NICKNAMES = [
  '운영자', '관리자', '익명', 'admin', 'moderator',
  '시스템', 'system', 'careerwiki', '커리어위키',
  '관리', '운영', '공지', 'notice', 'official',
  '매니저', 'manager', 'staff', '스태프'
]

/**
 * 한글 자모 분리 정규화 (ㄱㅏ → 가)
 * 유니코드 유사문자 변형 대비
 */
function normalizeKorean(text: string): string {
  // 기본 정규화
  let normalized = text.normalize('NFC')
  
  // 일반적인 유사문자 치환
  const similarChars: Record<string, string> = {
    'ㅇ': 'o', 'ㅁ': 'm', 'ㄴ': 'n', 'ㄱ': 'r',
    '0': 'o', '1': 'l', '3': 'e', '4': 'a',
    '@': 'a', '$': 's', '!': 'i'
  }
  
  for (const [from, to] of Object.entries(similarChars)) {
    normalized = normalized.replace(new RegExp(from, 'g'), to)
  }
  
  return normalized.toLowerCase()
}

// ============================================
// 닉네임 검증
// ============================================

/**
 * 닉네임 유효성 검증
 */
export async function validateNickname(
  db: D1Database,
  nickname: string
): Promise<NicknameValidationResult> {
  // 1. 기본 패턴 검증
  if (!NICKNAME_PATTERN.test(nickname)) {
    return {
      ok: false,
      reason: 'invalid',
      message: '닉네임은 2~16자의 한글, 영문, 숫자만 사용할 수 있습니다.'
    }
  }
  
  // 2. 예약어 체크
  const normalizedNickname = normalizeKorean(nickname)
  for (const reserved of RESERVED_NICKNAMES) {
    if (normalizedNickname.includes(normalizeKorean(reserved))) {
      return {
        ok: false,
        reason: 'forbidden',
        message: '사용할 수 없는 닉네임입니다.'
      }
    }
  }
  
  // 3. DB 금칙어 체크
  const rules = await loadProfanityRules(db)
  for (const rule of rules) {
    const pattern = new RegExp(rule.pattern, 'gi')
    if (pattern.test(nickname) || pattern.test(normalizedNickname)) {
      return {
        ok: false,
        reason: 'forbidden',
        message: '부적절한 단어가 포함되어 있습니다.'
      }
    }
  }
  
  return { ok: true }
}

/**
 * 닉네임 중복 체크 (validateNickname과 별도 - 실시간 체크용)
 */
export async function isNicknameTaken(
  db: D1Database,
  nickname: string,
  excludeUserId?: number
): Promise<boolean> {
  const query = excludeUserId
    ? 'SELECT id FROM users WHERE username = ? AND id != ?'
    : 'SELECT id FROM users WHERE username = ?'
  
  const result = excludeUserId
    ? await db.prepare(query).bind(nickname, excludeUserId).first()
    : await db.prepare(query).bind(nickname).first()
  
  return !!result
}

// ============================================
// 욕설 필터링
// ============================================

/**
 * DB에서 금칙어 규칙 로드
 */
export async function loadProfanityRules(db: D1Database): Promise<ProfanityRule[]> {
  const result = await db
    .prepare('SELECT id, pattern, replacement, is_active FROM profanity_rules WHERE is_active = 1')
    .all<ProfanityRule>()
  
  return result.results || []
}

/**
 * 텍스트에서 욕설 필터링
 */
export async function filterProfanity(
  db: D1Database,
  input: string
): Promise<ProfanityFilterResult> {
  const rules = await loadProfanityRules(db)
  
  let output = input
  let moderated = false
  
  for (const rule of rules) {
    try {
      const before = output
      const pattern = new RegExp(rule.pattern, 'gi')
      output = output.replace(pattern, rule.replacement)
      
      if (output !== before) {
        moderated = true
      }
    } catch (e) {
      // 잘못된 정규식 패턴 무시
      console.warn(`Invalid profanity pattern: ${rule.pattern}`)
    }
  }
  
  return {
    moderated,
    output,
    originalInput: input
  }
}

/**
 * 텍스트에 금칙어가 포함되어 있는지 체크 (필터링 없이)
 */
export async function containsProfanity(
  db: D1Database,
  input: string
): Promise<boolean> {
  const rules = await loadProfanityRules(db)
  const normalizedInput = normalizeKorean(input)
  
  for (const rule of rules) {
    try {
      const pattern = new RegExp(rule.pattern, 'gi')
      if (pattern.test(input) || pattern.test(normalizedInput)) {
        return true
      }
    } catch (e) {
      // 잘못된 정규식 패턴 무시
    }
  }
  
  return false
}

// ============================================
// 관리자용 함수
// ============================================

/**
 * 금칙어 규칙 추가
 */
export async function addProfanityRule(
  db: D1Database,
  pattern: string,
  replacement: string = '**'
): Promise<{ success: boolean; id?: number; error?: string }> {
  try {
    // 정규식 유효성 체크
    new RegExp(pattern, 'gi')
    
    const result = await db
      .prepare('INSERT INTO profanity_rules (pattern, replacement, is_active) VALUES (?, ?, 1)')
      .bind(pattern, replacement)
      .run()
    
    if (result.success) {
      return { success: true, id: result.meta.last_row_id as number }
    }
    
    return { success: false, error: '추가 실패' }
  } catch (e) {
    if (e instanceof SyntaxError) {
      return { success: false, error: '유효하지 않은 정규식 패턴입니다.' }
    }
    return { success: false, error: String(e) }
  }
}

/**
 * 금칙어 규칙 삭제 (비활성화)
 */
export async function removeProfanityRule(
  db: D1Database,
  ruleId: number
): Promise<boolean> {
  const result = await db
    .prepare('UPDATE profanity_rules SET is_active = 0 WHERE id = ?')
    .bind(ruleId)
    .run()
  
  return result.success
}

/**
 * 모든 금칙어 규칙 조회 (관리자용)
 */
export async function getAllProfanityRules(
  db: D1Database,
  includeInactive: boolean = false
): Promise<ProfanityRule[]> {
  const query = includeInactive
    ? 'SELECT id, pattern, replacement, is_active FROM profanity_rules ORDER BY id DESC'
    : 'SELECT id, pattern, replacement, is_active FROM profanity_rules WHERE is_active = 1 ORDER BY id DESC'
  
  const result = await db.prepare(query).all<ProfanityRule>()
  
  return result.results || []
}


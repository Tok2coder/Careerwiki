/**
 * 슬러그 서비스
 * - 한글 제목 → 영문 슬러그 변환
 * - 중복 체크 및 suffix 추가
 * - 슬러그 히스토리 관리 (301 리다이렉트)
 */

// 한글 → 로마자 변환 맵 (초성, 중성, 종성)
const CHOSUNG = ['g', 'kk', 'n', 'd', 'tt', 'r', 'm', 'b', 'pp', 's', 'ss', '', 'j', 'jj', 'ch', 'k', 't', 'p', 'h']
const JUNGSUNG = ['a', 'ae', 'ya', 'yae', 'eo', 'e', 'yeo', 'ye', 'o', 'wa', 'wae', 'oe', 'yo', 'u', 'wo', 'we', 'wi', 'yu', 'eu', 'ui', 'i']
const JONGSUNG = ['', 'g', 'kk', 'gs', 'n', 'nj', 'nh', 'd', 'l', 'lg', 'lm', 'lb', 'ls', 'lt', 'lp', 'lh', 'm', 'b', 'bs', 's', 'ss', 'ng', 'j', 'ch', 'k', 't', 'p', 'h']

/**
 * 한글을 로마자로 변환 (간단한 Revised Romanization)
 */
function koreanToRoman(text: string): string {
  let result = ''
  
  for (let i = 0; i < text.length; i++) {
    const code = text.charCodeAt(i)
    
    // 한글 유니코드 범위: 0xAC00 ~ 0xD7A3
    if (code >= 0xAC00 && code <= 0xD7A3) {
      const syllable = code - 0xAC00
      const cho = Math.floor(syllable / 588)
      const jung = Math.floor((syllable % 588) / 28)
      const jong = syllable % 28
      
      result += CHOSUNG[cho] + JUNGSUNG[jung] + JONGSUNG[jong]
    } 
    // 영문, 숫자는 그대로
    else if ((code >= 0x41 && code <= 0x5A) || // A-Z
             (code >= 0x61 && code <= 0x7A) || // a-z
             (code >= 0x30 && code <= 0x39)) { // 0-9
      result += text[i].toLowerCase()
    }
    // 공백 및 기타 문자는 하이픈으로
    else if (code === 0x20 || code === 0x2D || code === 0x5F) { // space, -, _
      result += '-'
    }
    // 나머지는 무시
  }
  
  return result
}

/**
 * 제목에서 슬러그 생성
 * 한글은 그대로 유지하고, 특수문자만 정리
 */
export function generateSlug(title: string): string {
  if (!title || !title.trim()) {
    return ''
  }
  
  let slug = title.trim()
  
  // 1. URL에 사용 불가능한 특수문자 제거/변환
  // 허용: 한글, 영문, 숫자, 하이픈, 언더스코어
  slug = slug.replace(/[<>:"\/\\|?*#%&{}[\]^~`@!$()+=;',]/g, '')
  
  // 2. 공백을 하이픈으로 변환
  slug = slug.replace(/\s+/g, '-')
  
  // 3. 연속된 하이픈 정리
  slug = slug.replace(/-+/g, '-')
  
  // 4. 시작/끝 하이픈 제거
  slug = slug.replace(/^-|-$/g, '')
  
  // 5. 최대 길이 제한 (100자 - 한글은 3바이트씩 차지하므로 여유있게)
  if (slug.length > 100) {
    slug = slug.slice(0, 100).replace(/-$/, '')
  }
  
  // 6. 빈 슬러그 처리
  if (!slug) {
    slug = 'untitled'
  }
  
  return slug
}

/**
 * 슬러그 중복 체크 및 유니크 슬러그 반환
 */
export async function checkAndGenerateUniqueSlug(
  db: D1Database,
  title: string,
  excludeId?: number
): Promise<{ success: boolean; slug?: string; isUnique?: boolean; error?: string }> {
  try {
    const baseSlug = generateSlug(title)
    
    if (!baseSlug) {
      return { success: false, error: '유효한 슬러그를 생성할 수 없습니다' }
    }
    
    // 기본 슬러그 체크
    let candidateSlug = baseSlug
    let suffix = 1
    let isUnique = false
    
    while (!isUnique && suffix <= 100) {
      const query = excludeId
        ? `SELECT id FROM howtos WHERE slug = ? AND id != ? LIMIT 1`
        : `SELECT id FROM howtos WHERE slug = ? LIMIT 1`
      
      const existing = excludeId
        ? await db.prepare(query).bind(candidateSlug, excludeId).first()
        : await db.prepare(query).bind(candidateSlug).first()
      
      // 슬러그 히스토리에서도 체크
      const historyCheck = await db.prepare(`
        SELECT id FROM slug_history WHERE old_slug = ? LIMIT 1
      `).bind(candidateSlug).first()
      
      if (!existing && !historyCheck) {
        isUnique = true
      } else {
        suffix++
        candidateSlug = `${baseSlug}-${suffix}`
      }
    }
    
    if (!isUnique) {
      return { success: false, error: '유니크한 슬러그를 생성할 수 없습니다. 다른 제목을 사용해주세요.' }
    }
    
    return { 
      success: true, 
      slug: candidateSlug, 
      isUnique: candidateSlug === baseSlug  // suffix가 붙지 않았으면 true
    }
  } catch (error) {
    console.error('[checkAndGenerateUniqueSlug] Error:', error)
    return { success: false, error: '슬러그 생성 중 오류가 발생했습니다' }
  }
}

/**
 * 슬러그 히스토리에서 리다이렉트 대상 조회
 */
export async function getRedirectTarget(
  db: D1Database,
  oldSlug: string
): Promise<{ found: boolean; newSlug?: string; howtoId?: number }> {
  try {
    const history = await db.prepare(`
      SELECT sh.howto_id, h.slug as new_slug
      FROM slug_history sh
      JOIN howtos h ON sh.howto_id = h.id
      WHERE sh.old_slug = ? AND h.status = 'published'
      ORDER BY sh.changed_at DESC
      LIMIT 1
    `).bind(oldSlug).first<{ howto_id: number; new_slug: string }>()
    
    if (history) {
      return { found: true, newSlug: history.new_slug, howtoId: history.howto_id }
    }
    
    return { found: false }
  } catch (error) {
    console.error('[getRedirectTarget] Error:', error)
    return { found: false }
  }
}

/**
 * 슬러그 변경 시 히스토리에 기록
 */
export async function recordSlugHistory(
  db: D1Database,
  howtoId: number,
  oldSlug: string
): Promise<{ success: boolean; error?: string }> {
  try {
    // 이미 같은 old_slug가 있는지 확인
    const existing = await db.prepare(`
      SELECT id FROM slug_history WHERE howto_id = ? AND old_slug = ?
    `).bind(howtoId, oldSlug).first()
    
    if (existing) {
      return { success: true } // 이미 기록됨
    }
    
    await db.prepare(`
      INSERT INTO slug_history (howto_id, old_slug) VALUES (?, ?)
    `).bind(howtoId, oldSlug).run()
    
    return { success: true }
  } catch (error) {
    console.error('[recordSlugHistory] Error:', error)
    return { success: false, error: '슬러그 히스토리 기록 중 오류가 발생했습니다' }
  }
}

/**
 * 슬러그 유효성 검증
 * 한글, 영문, 숫자, 하이픈, 언더스코어 허용
 */
export function validateSlug(slug: string): { valid: boolean; error?: string } {
  if (!slug || !slug.trim()) {
    return { valid: false, error: '슬러그가 비어있습니다' }
  }
  
  // URL에 위험한 문자 체크
  if (/[<>:"\/\\|?*#%&{}[\]^~`@!$()+=;',]/.test(slug)) {
    return { valid: false, error: '슬러그에 사용할 수 없는 특수문자가 포함되어 있습니다' }
  }
  
  // 시작/끝이 하이픈이면 안됨
  if (slug.startsWith('-') || slug.endsWith('-')) {
    return { valid: false, error: '슬러그는 하이픈으로 시작하거나 끝날 수 없습니다' }
  }
  
  // 연속된 하이픈 금지
  if (/--/.test(slug)) {
    return { valid: false, error: '연속된 하이픈은 사용할 수 없습니다' }
  }
  
  // 길이 제한
  if (slug.length < 2) {
    return { valid: false, error: '슬러그는 최소 2자 이상이어야 합니다' }
  }
  
  if (slug.length > 100) {
    return { valid: false, error: '슬러그는 100자를 초과할 수 없습니다' }
  }
  
  return { valid: true }
}


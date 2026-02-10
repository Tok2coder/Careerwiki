/**
 * R2 이미지 업로드 서비스
 * - 사전서명 URL 발급
 * - 매직 넘버 검증
 * - 이미지 서빙
 */

import type { R2Bucket, R2ObjectBody } from '@cloudflare/workers-types'

// 허용된 MIME 타입과 매직 넘버
const ALLOWED_TYPES: Record<string, { mime: string; magic: number[]; ext: string }> = {
  'image/jpeg': { mime: 'image/jpeg', magic: [0xFF, 0xD8, 0xFF], ext: 'jpg' },
  'image/png': { mime: 'image/png', magic: [0x89, 0x50, 0x4E, 0x47], ext: 'png' },
  'image/gif': { mime: 'image/gif', magic: [0x47, 0x49, 0x46], ext: 'gif' },
  'image/webp': { mime: 'image/webp', magic: [0x52, 0x49, 0x46, 0x46], ext: 'webp' },
}

// SVG는 XSS 위험으로 차단
const BLOCKED_TYPES = ['image/svg+xml', 'application/xml', 'text/xml']

// 최대 파일 크기 (10MB)
const MAX_FILE_SIZE = 10 * 1024 * 1024

// 사전서명 URL 만료 시간 (5분)
const PRESIGN_EXPIRES_IN = 300

export interface PresignRequest {
  filename: string
  contentType: string
  contentLength: number
}

export interface PresignResponse {
  uploadUrl: string
  fileKey: string
  publicUrl: string
  expiresIn: number
}

/**
 * UUID 생성 (crypto.randomUUID 대체)
 */
function generateUUID(): string {
  const bytes = new Uint8Array(16)
  crypto.getRandomValues(bytes)
  bytes[6] = (bytes[6] & 0x0f) | 0x40
  bytes[8] = (bytes[8] & 0x3f) | 0x80
  
  const hex = Array.from(bytes)
    .map(b => b.toString(16).padStart(2, '0'))
    .join('')
  
  return `${hex.slice(0, 8)}-${hex.slice(8, 12)}-${hex.slice(12, 16)}-${hex.slice(16, 20)}-${hex.slice(20)}`
}

/**
 * 파일 키 생성 (경로: howto/YYYY/MM/DD/{originalFilename}-{shortId}.ext 또는 howto/YYYY/MM/DD/uuid.ext)
 */
export function generateFileKey(ext: string, originalFilename?: string): string {
  const now = new Date()
  const year = now.getFullYear()
  const month = String(now.getMonth() + 1).padStart(2, '0')
  const day = String(now.getDate()).padStart(2, '0')
  const uuid = generateUUID()
  const shortId = uuid.split('-')[0]
  
  if (originalFilename) {
    // 원본 파일명에서 확장자 제거하고 안전한 문자만 유지
    const baseName = originalFilename.replace(/\.[^/.]+$/, '').replace(/[^a-zA-Z0-9가-힣_-]/g, '_').slice(0, 50)
    return `howto/${year}/${month}/${day}/${baseName}-${shortId}.${ext}`
  }
  
  return `howto/${year}/${month}/${day}/${uuid}.${ext}`
}

/**
 * 콘텐츠 타입 검증
 */
export function validateContentType(contentType: string): { valid: boolean; error?: string; ext?: string } {
  // SVG 및 차단 타입 체크
  if (BLOCKED_TYPES.includes(contentType)) {
    return { valid: false, error: 'SVG 파일은 보안상 업로드할 수 없습니다' }
  }
  
  const typeInfo = ALLOWED_TYPES[contentType]
  if (!typeInfo) {
    return { valid: false, error: `지원하지 않는 파일 형식입니다. 지원: ${Object.keys(ALLOWED_TYPES).join(', ')}` }
  }
  
  return { valid: true, ext: typeInfo.ext }
}

/**
 * 파일 크기 검증
 */
export function validateFileSize(size: number): { valid: boolean; error?: string } {
  if (size <= 0) {
    return { valid: false, error: '파일 크기가 유효하지 않습니다' }
  }
  
  if (size > MAX_FILE_SIZE) {
    return { valid: false, error: `파일 크기는 ${MAX_FILE_SIZE / 1024 / 1024}MB를 초과할 수 없습니다` }
  }
  
  return { valid: true }
}

/**
 * 매직 넘버 검증 (파일 시그니처 확인)
 */
export function validateMagicNumber(buffer: ArrayBuffer, contentType: string): boolean {
  const typeInfo = ALLOWED_TYPES[contentType]
  if (!typeInfo) return false
  
  const bytes = new Uint8Array(buffer)
  const magic = typeInfo.magic
  
  // WEBP는 특별 처리 (RIFF....WEBP 형식)
  if (contentType === 'image/webp') {
    // RIFF 헤더 확인
    if (bytes[0] !== 0x52 || bytes[1] !== 0x49 || bytes[2] !== 0x46 || bytes[3] !== 0x46) {
      return false
    }
    // WEBP 시그니처 확인 (offset 8-11)
    if (bytes[8] !== 0x57 || bytes[9] !== 0x45 || bytes[10] !== 0x42 || bytes[11] !== 0x50) {
      return false
    }
    return true
  }
  
  // 일반적인 매직 넘버 검증
  for (let i = 0; i < magic.length; i++) {
    if (bytes[i] !== magic[i]) {
      return false
    }
  }
  
  return true
}

/**
 * 사전서명 URL 발급을 위한 업로드 정보 생성
 * (실제 R2는 사전서명 URL을 직접 지원하지 않으므로 서버 경유 업로드 사용)
 */
export function createUploadInfo(request: PresignRequest): { 
  success: boolean
  data?: { fileKey: string; ext: string }
  error?: string 
} {
  // 콘텐츠 타입 검증
  const typeResult = validateContentType(request.contentType)
  if (!typeResult.valid) {
    return { success: false, error: typeResult.error }
  }
  
  // 파일 크기 검증
  const sizeResult = validateFileSize(request.contentLength)
  if (!sizeResult.valid) {
    return { success: false, error: sizeResult.error }
  }
  
  // 파일 키 생성
  const fileKey = generateFileKey(typeResult.ext!)
  
  return {
    success: true,
    data: { fileKey, ext: typeResult.ext! }
  }
}

/**
 * R2에 파일 업로드
 */
export async function uploadToR2(
  bucket: R2Bucket,
  fileKey: string,
  body: ArrayBuffer | ReadableStream,
  contentType: string,
  metadata?: Record<string, string>
): Promise<{ success: boolean; error?: string }> {
  try {
    await bucket.put(fileKey, body, {
      httpMetadata: {
        contentType,
        cacheControl: 'public, max-age=31536000', // 1년 캐시
      },
      customMetadata: metadata
    })
    
    return { success: true }
  } catch (error) {
    console.error('[R2 Upload] Error:', error)
    return { success: false, error: '파일 업로드에 실패했습니다' }
  }
}

/**
 * R2에서 파일 조회
 */
export async function getFromR2(
  bucket: R2Bucket,
  fileKey: string
): Promise<R2ObjectBody | null> {
  try {
    return await bucket.get(fileKey)
  } catch (error) {
    console.error('[R2 Get] Error:', error)
    return null
  }
}

/**
 * R2에서 파일 삭제
 */
export async function deleteFromR2(
  bucket: R2Bucket,
  fileKey: string
): Promise<{ success: boolean; error?: string }> {
  try {
    await bucket.delete(fileKey)
    return { success: true }
  } catch (error) {
    console.error('[R2 Delete] Error:', error)
    return { success: false, error: '파일 삭제에 실패했습니다' }
  }
}

/**
 * 공개 URL 생성
 */
export function getPublicUrl(fileKey: string, baseUrl: string): string {
  return `${baseUrl}/uploads/${fileKey}`
}


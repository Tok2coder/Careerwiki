/**
 * 이미지 업로드 유틸리티
 * R2 presign API 연동
 */

export interface UploadResult {
  success: boolean
  publicUrl?: string
  error?: string
}

/**
 * 이미지 파일을 R2에 업로드
 */
export async function uploadImage(file: File): Promise<string | null> {
  // 1. 업로드 준비 요청
  const prepareRes = await fetch('/api/upload/prepare', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({
      filename: file.name,
      contentType: file.type,
      contentLength: file.size
    })
  })

  const prepareData = await prepareRes.json()
  if (!prepareData.success) {
    throw new Error(prepareData.error || '업로드 준비 실패')
  }

  // 2. 파일 업로드
  const uploadRes = await fetch('/api/upload/file', {
    method: 'POST',
    headers: {
      'Content-Type': file.type,
      'X-File-Key': prepareData.fileKey
    },
    body: file
  })

  const uploadData = await uploadRes.json()
  if (!uploadData.success) {
    throw new Error(uploadData.error || '업로드 실패')
  }

  return uploadData.publicUrl
}

/**
 * 이미지 크기 검증
 */
export function validateImageFile(file: File): { valid: boolean; error?: string } {
  const MAX_SIZE = 10 * 1024 * 1024 // 10MB
  const ALLOWED_TYPES = ['image/jpeg', 'image/png', 'image/gif', 'image/webp']

  if (!ALLOWED_TYPES.includes(file.type)) {
    return { valid: false, error: '지원하지 않는 이미지 형식입니다. (JPG, PNG, GIF, WEBP만 가능)' }
  }

  if (file.size > MAX_SIZE) {
    return { valid: false, error: '이미지 크기는 10MB를 초과할 수 없습니다.' }
  }

  return { valid: true }
}


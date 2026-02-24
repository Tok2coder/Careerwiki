/**
 * Z-Image Turbo API를 통한 이미지 생성 서비스
 * @see https://docs.evolink.ai/en/api-manual/image-series/z-image-turbo/z-image-turbo-image-generate
 */

// API 응답 타입
export interface ZImageTaskResponse {
  created: number
  id: string
  model: string
  object: 'image.generation.task'
  progress: number
  status: 'pending' | 'processing' | 'completed' | 'failed' | string // 추가 상태 허용
  task_info?: {
    can_cancel: boolean
    estimated_time: number
  }
  type: 'image'
  usage?: {
    billing_rule: 'per_call' | 'per_token' | 'per_second'
    credits_reserved: number
    user_group: string
  }
  // 완료 시 추가 필드
  results?: string[] // 생성된 이미지 URL 배열
  data?: {
    url?: string
    urls?: string[]
  }
  // 다양한 API 응답 형식 지원
  state?: string // 대안 상태 필드
  output?: {
    url?: string
    urls?: string[]
  }
  error?: {
    code: string
    message: string
  }
  // 기타 유연한 필드들
  [key: string]: any
}

// 이미지 생성 요청 파라미터
export interface GenerateImageParams {
  prompt: string
  size?: '1:1' | '2:3' | '3:2' | '3:4' | '4:3' | '9:16' | '16:9' | '1:2' | '2:1' | string // 커스텀 사이즈도 지원 (예: "1280x720")
  seed?: number
  nsfw_check?: boolean
  callback_url?: string
}

// 이미지 생성 결과 (DB 저장용)
export interface ImageGenerationResult {
  taskId: string
  status: 'pending' | 'processing' | 'completed' | 'failed'
  imageUrl?: string
  error?: string
}

const API_BASE_URL = 'https://api.evolink.ai/v1'

/**
 * Z-Image Turbo API로 이미지 생성 요청
 * @param apiKey - EvoLink API 키
 * @param params - 생성 파라미터
 * @returns 태스크 응답
 */
export async function requestImageGeneration(
  apiKey: string,
  params: GenerateImageParams
): Promise<{ success: boolean; data?: ZImageTaskResponse; error?: string }> {
  try {
    // 프롬프트 길이 검증 (최대 2000자)
    if (params.prompt.length > 2000) {
      return { 
        success: false, 
        error: `프롬프트가 너무 깁니다 (${params.prompt.length}/2000자)` 
      }
    }

    const response = await fetch(`${API_BASE_URL}/images/generations`, {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${apiKey}`,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        model: 'z-image-turbo',
        prompt: params.prompt,
        size: params.size || '16:9', // 기본 16:9 (히어로 이미지용)
        seed: params.seed,
        nsfw_check: params.nsfw_check ?? false,
        callback_url: params.callback_url
      })
    })

    if (!response.ok) {
      const errorText = await response.text()
      
      // 에러 코드별 메시지
      const errorMessages: Record<number, string> = {
        400: '잘못된 요청입니다',
        401: 'API 키가 유효하지 않습니다',
        402: '크레딧이 부족합니다',
        403: '접근이 거부되었습니다',
        404: '리소스를 찾을 수 없습니다',
        429: '요청 한도를 초과했습니다',
        500: '서버 오류가 발생했습니다',
        502: '게이트웨이 오류입니다',
        503: '서비스를 사용할 수 없습니다'
      }
      
      return { 
        success: false, 
        error: errorMessages[response.status] || `HTTP ${response.status}: ${errorText}` 
      }
    }

    const data: ZImageTaskResponse = await response.json()
    
    return { success: true, data }
  } catch (error) {
    return { 
      success: false, 
      error: error instanceof Error ? error.message : '알 수 없는 오류' 
    }
  }
}

/**
 * 태스크 상태 조회
 * @param apiKey - EvoLink API 키
 * @param taskId - 태스크 ID
 * @returns 태스크 상태
 */
export async function queryTaskStatus(
  apiKey: string,
  taskId: string
): Promise<{ success: boolean; data?: ZImageTaskResponse; error?: string }> {
  try {
    const response = await fetch(`${API_BASE_URL}/tasks/${taskId}`, {
      method: 'GET',
      headers: {
        'Authorization': `Bearer ${apiKey}`,
        'Content-Type': 'application/json'
      }
    })

    if (!response.ok) {
      const errorText = await response.text()
      return { success: false, error: `HTTP ${response.status}` }
    }

    const data: ZImageTaskResponse = await response.json()
    return { success: true, data }
  } catch (error) {
    return { 
      success: false, 
      error: error instanceof Error ? error.message : '알 수 없는 오류' 
    }
  }
}

/**
 * 이미지 URL에서 이미지 다운로드
 * @param imageUrl - 이미지 URL
 * @returns ArrayBuffer
 */
export async function downloadImage(
  imageUrl: string
): Promise<{ success: boolean; data?: ArrayBuffer; contentType?: string; error?: string }> {
  try {
    const response = await fetch(imageUrl)
    
    if (!response.ok) {
      return { success: false, error: `이미지 다운로드 실패: HTTP ${response.status}` }
    }

    const data = await response.arrayBuffer()
    const contentType = response.headers.get('content-type') || 'image/png'
    
    return { success: true, data, contentType }
  } catch (error) {
    return { 
      success: false, 
      error: error instanceof Error ? error.message : '다운로드 오류' 
    }
  }
}

/**
 * 콜백 데이터 파싱 및 검증
 * @param body - 콜백 요청 body
 * @returns 파싱된 태스크 응답
 */
export function parseCallbackData(body: unknown): ZImageTaskResponse | null {
  if (!body || typeof body !== 'object') {
    return null
  }
  
  const data = body as Record<string, unknown>
  
  // 필수 필드 검증
  if (!data.id || !data.status) {
    return null
  }
  
  return body as ZImageTaskResponse
}

/**
 * 직업/전공 slug로 이미지 파일 키 생성
 * @param type - 'jobs' | 'majors'
 * @param slug - 직업/전공 slug
 * @returns R2 파일 키
 */
export function generateImageFileKey(
  type: 'jobs' | 'majors',
  slug: string,
  contentType: string = 'image/webp'
): string {
  // 기존 이미지 형식과 일치시킴: jobs/job-{encodedSlug}.{ext}
  const prefix = type === 'jobs' ? 'job' : 'major'
  // content type에서 확장자 추출
  const extMap: Record<string, string> = {
    'image/webp': 'webp',
    'image/png': 'png',
    'image/jpeg': 'jpg',
    'image/gif': 'gif'
  }
  const ext = extMap[contentType] || 'webp'
  // slug에 '/'가 포함되면 경로 구분자로 해석되므로 '_'로 대체
  const safeSlug = slug.replace(/\//g, '_')
  // R2 키는 디코딩된 한글 그대로 저장 (서빙 라우트가 디코딩 키를 먼저 탐색)
  return `${type}/${prefix}-${safeSlug}.${ext}`
}

/**
 * R2 공개 URL 생성
 * @param fileKey - R2 파일 키
 * @param baseUrl - 기본 URL
 * @returns 공개 URL
 */
export function getImagePublicUrl(fileKey: string, baseUrl: string): string {
  // 상대 경로로 저장 (배포 환경에서도 동작)
  return `/uploads/${fileKey}`
}


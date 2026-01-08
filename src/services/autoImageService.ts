/**
 * 자동 이미지 생성 통합 서비스
 * Gemini 프롬프트 생성 + Evolink 이미지 생성 + R2 업로드를 하나로 통합
 */

import { generateJobImagePrompt, generateMajorImagePrompt } from './geminiService'
import {
  requestImageGeneration,
  queryTaskStatus,
  downloadImage,
  generateImageFileKey,
  getImagePublicUrl
} from './imageGenerationService'
import { uploadToR2 } from './uploadService'

export interface AutoImageResult {
  success: boolean
  imageUrl?: string
  imagePrompt?: string
  error?: string
  // 디버깅용 상세 정보
  details?: {
    promptGenerationTime?: number
    imageGenerationTime?: number
    uploadTime?: number
    taskId?: string
  }
}

interface AutoImageEnv {
  GEMINI_API_KEY: string
  EVOLINK_API_KEY: string
  UPLOADS: R2Bucket
}

// 이미지 생성 타임아웃 (60초)
const IMAGE_GENERATION_TIMEOUT = 60000
// 폴링 간격 (2초)
const POLLING_INTERVAL = 2000

/**
 * 이미지 생성 태스크 완료까지 폴링
 */
async function waitForImageCompletion(
  apiKey: string,
  taskId: string,
  timeoutMs: number = IMAGE_GENERATION_TIMEOUT
): Promise<{ success: boolean; imageUrl?: string; error?: string }> {
  const startTime = Date.now()
  
  while (Date.now() - startTime < timeoutMs) {
    const statusResult = await queryTaskStatus(apiKey, taskId)
    
    if (!statusResult.success || !statusResult.data) {
      // 일시적 오류일 수 있으므로 계속 폴링
      await new Promise(resolve => setTimeout(resolve, POLLING_INTERVAL))
      continue
    }
    
    const { status, results, data, error } = statusResult.data
    
    if (status === 'completed') {
      const imageUrl = results?.[0] || data?.url || data?.urls?.[0]
      if (imageUrl) {
        return { success: true, imageUrl }
      }
      return { success: false, error: '이미지 URL이 없습니다' }
    }
    
    if (status === 'failed') {
      return { 
        success: false, 
        error: error?.message || '이미지 생성에 실패했습니다' 
      }
    }
    
    // pending 또는 processing 상태 - 계속 대기
    await new Promise(resolve => setTimeout(resolve, POLLING_INTERVAL))
  }
  
  return { success: false, error: '이미지 생성 시간 초과 (60초)' }
}

/**
 * 직업용 자동 이미지 생성
 * @param env - 환경 변수 (API 키들, R2 버킷)
 * @param jobName - 직업명
 * @param slug - URL용 slug
 * @param baseUrl - 서버 기본 URL
 */
export async function generateJobImage(
  env: AutoImageEnv,
  jobName: string,
  slug: string,
  baseUrl: string
): Promise<AutoImageResult> {
  const details: AutoImageResult['details'] = {}
  
  try {
    // 1. Gemini로 이미지 프롬프트 생성
    console.log(`[AutoImage] Generating prompt for job: ${jobName}`)
    const promptStart = Date.now()
    
    const promptResult = await generateJobImagePrompt(env.GEMINI_API_KEY, jobName)
    details.promptGenerationTime = Date.now() - promptStart
    
    if (!promptResult.success || !promptResult.prompt) {
      console.error('[AutoImage] Prompt generation failed:', promptResult.error)
      return {
        success: false,
        error: `프롬프트 생성 실패: ${promptResult.error}`,
        details
      }
    }
    
    const imagePrompt = promptResult.prompt
    console.log(`[AutoImage] Prompt generated (${details.promptGenerationTime}ms)`)
    
    // 2. Evolink로 이미지 생성 요청
    console.log(`[AutoImage] Requesting image generation...`)
    const imageStart = Date.now()
    
    const imageRequest = await requestImageGeneration(env.EVOLINK_API_KEY, {
      prompt: imagePrompt,
      size: '1280x720', // 16:9 히어로 이미지
      nsfw_check: false
    })
    
    if (!imageRequest.success || !imageRequest.data) {
      console.error('[AutoImage] Image request failed:', imageRequest.error)
      return {
        success: false,
        imagePrompt, // 프롬프트는 저장할 수 있도록 반환
        error: `이미지 생성 요청 실패: ${imageRequest.error}`,
        details
      }
    }
    
    const taskId = imageRequest.data.id
    details.taskId = taskId
    console.log(`[AutoImage] Task created: ${taskId}`)
    
    // 3. 이미지 생성 완료 대기
    const completionResult = await waitForImageCompletion(env.EVOLINK_API_KEY, taskId)
    details.imageGenerationTime = Date.now() - imageStart
    
    if (!completionResult.success || !completionResult.imageUrl) {
      console.error('[AutoImage] Image generation failed:', completionResult.error)
      return {
        success: false,
        imagePrompt,
        error: `이미지 생성 실패: ${completionResult.error}`,
        details
      }
    }
    
    console.log(`[AutoImage] Image generated (${details.imageGenerationTime}ms)`)
    
    // 4. 이미지 다운로드
    const downloadResult = await downloadImage(completionResult.imageUrl)
    
    if (!downloadResult.success || !downloadResult.data) {
      console.error('[AutoImage] Image download failed:', downloadResult.error)
      return {
        success: false,
        imagePrompt,
        error: `이미지 다운로드 실패: ${downloadResult.error}`,
        details
      }
    }
    
    // 5. R2에 업로드
    console.log(`[AutoImage] Uploading to R2...`)
    const uploadStart = Date.now()
    
    const contentType = downloadResult.contentType || 'image/png'
    const fileKey = generateImageFileKey('jobs', slug, contentType)
    const uploadResult = await uploadToR2(
      env.UPLOADS,
      fileKey,
      downloadResult.data,
      contentType,
      {
        source: 'auto-generation',
        jobName,
        taskId
      }
    )
    details.uploadTime = Date.now() - uploadStart
    
    if (!uploadResult.success) {
      console.error('[AutoImage] R2 upload failed:', uploadResult.error)
      return {
        success: false,
        imagePrompt,
        error: `R2 업로드 실패: ${uploadResult.error}`,
        details
      }
    }
    
    const publicUrl = getImagePublicUrl(fileKey, baseUrl)
    console.log(`[AutoImage] Complete! URL: ${publicUrl}`)
    
    return {
      success: true,
      imageUrl: publicUrl,
      imagePrompt,
      details
    }
    
  } catch (error) {
    console.error('[AutoImage] Unexpected error:', error)
    return {
      success: false,
      error: error instanceof Error ? error.message : '알 수 없는 오류',
      details
    }
  }
}

/**
 * 전공용 자동 이미지 생성
 * @param env - 환경 변수 (API 키들, R2 버킷)
 * @param majorName - 전공명
 * @param slug - URL용 slug
 * @param baseUrl - 서버 기본 URL
 */
export async function generateMajorImage(
  env: AutoImageEnv,
  majorName: string,
  slug: string,
  baseUrl: string
): Promise<AutoImageResult> {
  const details: AutoImageResult['details'] = {}
  
  try {
    // 1. Gemini로 이미지 프롬프트 생성
    console.log(`[AutoImage] Generating prompt for major: ${majorName}`)
    const promptStart = Date.now()
    
    const promptResult = await generateMajorImagePrompt(env.GEMINI_API_KEY, majorName)
    details.promptGenerationTime = Date.now() - promptStart
    
    if (!promptResult.success || !promptResult.prompt) {
      console.error('[AutoImage] Prompt generation failed:', promptResult.error)
      return {
        success: false,
        error: `프롬프트 생성 실패: ${promptResult.error}`,
        details
      }
    }
    
    const imagePrompt = promptResult.prompt
    console.log(`[AutoImage] Prompt generated (${details.promptGenerationTime}ms)`)
    
    // 2. Evolink로 이미지 생성 요청
    console.log(`[AutoImage] Requesting image generation...`)
    const imageStart = Date.now()
    
    const imageRequest = await requestImageGeneration(env.EVOLINK_API_KEY, {
      prompt: imagePrompt,
      size: '1280x720',
      nsfw_check: false
    })
    
    if (!imageRequest.success || !imageRequest.data) {
      console.error('[AutoImage] Image request failed:', imageRequest.error)
      return {
        success: false,
        imagePrompt,
        error: `이미지 생성 요청 실패: ${imageRequest.error}`,
        details
      }
    }
    
    const taskId = imageRequest.data.id
    details.taskId = taskId
    console.log(`[AutoImage] Task created: ${taskId}`)
    
    // 3. 이미지 생성 완료 대기
    const completionResult = await waitForImageCompletion(env.EVOLINK_API_KEY, taskId)
    details.imageGenerationTime = Date.now() - imageStart
    
    if (!completionResult.success || !completionResult.imageUrl) {
      console.error('[AutoImage] Image generation failed:', completionResult.error)
      return {
        success: false,
        imagePrompt,
        error: `이미지 생성 실패: ${completionResult.error}`,
        details
      }
    }
    
    console.log(`[AutoImage] Image generated (${details.imageGenerationTime}ms)`)
    
    // 4. 이미지 다운로드
    const downloadResult = await downloadImage(completionResult.imageUrl)
    
    if (!downloadResult.success || !downloadResult.data) {
      console.error('[AutoImage] Image download failed:', downloadResult.error)
      return {
        success: false,
        imagePrompt,
        error: `이미지 다운로드 실패: ${downloadResult.error}`,
        details
      }
    }
    
    // 5. R2에 업로드
    console.log(`[AutoImage] Uploading to R2...`)
    const uploadStart = Date.now()
    
    const contentType = downloadResult.contentType || 'image/png'
    const fileKey = generateImageFileKey('majors', slug, contentType)
    const uploadResult = await uploadToR2(
      env.UPLOADS,
      fileKey,
      downloadResult.data,
      contentType,
      {
        source: 'auto-generation',
        majorName,
        taskId
      }
    )
    details.uploadTime = Date.now() - uploadStart
    
    if (!uploadResult.success) {
      console.error('[AutoImage] R2 upload failed:', uploadResult.error)
      return {
        success: false,
        imagePrompt,
        error: `R2 업로드 실패: ${uploadResult.error}`,
        details
      }
    }
    
    const publicUrl = getImagePublicUrl(fileKey, baseUrl)
    console.log(`[AutoImage] Complete! URL: ${publicUrl}`)
    
    return {
      success: true,
      imageUrl: publicUrl,
      imagePrompt,
      details
    }
    
  } catch (error) {
    console.error('[AutoImage] Unexpected error:', error)
    return {
      success: false,
      error: error instanceof Error ? error.message : '알 수 없는 오류',
      details
    }
  }
}


/**
 * 파일 업로드 + 이미지 생성 라우트
 * Phase 1-4: index.tsx에서 추출
 */
import { Hono } from 'hono'
import type { R2ObjectBody } from '@cloudflare/workers-types'
import type { AppEnv } from '../types/app'
import { requireAuth } from '../middleware/auth'

const uploadRoutes = new Hono<AppEnv>()
const hasImageAdminRole = (role?: string) =>
  role === 'admin' || role === 'super-admin' || role === 'operator'

// =====================================================
// 파일 업로드 API
// =====================================================

// 간단한 업로드 (FormData 방식)
uploadRoutes.post('/api/upload', requireAuth, async (c) => {
  try {
    const user = c.get('user')!
    const formData = await c.req.parseBody()
    const file = formData['file'] as File

    if (!file || !(file instanceof File)) {
      return c.json({ success: false, error: '파일이 없습니다.' }, 400)
    }

    const { validateContentType, validateFileSize, validateMagicNumber, uploadToR2, generateFileKey } = await import('../services/uploadService')

    // 콘텐츠 타입 검증
    const typeResult = validateContentType(file.type)
    if (!typeResult.valid) {
      return c.json({ success: false, error: typeResult.error }, 400)
    }

    // 파일 크기 검증
    const sizeResult = validateFileSize(file.size)
    if (!sizeResult.valid) {
      return c.json({ success: false, error: sizeResult.error }, 400)
    }

    // 파일 데이터 읽기
    const body = await file.arrayBuffer()

    // 매직 넘버 검증
    if (!validateMagicNumber(body, file.type)) {
      return c.json({ success: false, error: '파일 형식이 올바르지 않습니다.' }, 400)
    }

    // 파일 키 생성 (howto/YYYY/MM/DD/{파일명}-{shortId}.ext 형식)
    const ext = file.name.split('.').pop()?.toLowerCase() || 'bin'
    const fileKey = generateFileKey(ext, file.name)

    // R2에 업로드
    const uploadResult = await uploadToR2(c.env.UPLOADS, fileKey, body, file.type, {
      uploadedBy: user.id.toString(),
      originalName: file.name
    })

    if (!uploadResult.success) {
      return c.json({ success: false, error: uploadResult.error }, 500)
    }

    // URL 반환
    const baseUrl = new URL(c.req.url).origin
    const publicUrl = `${baseUrl}/uploads/${fileKey}`

    return c.json({ success: true, url: publicUrl })
  } catch (error) {
    return c.json({ success: false, error: '업로드 처리 중 오류가 발생했습니다.' }, 500)
  }
})

// 업로드 준비 (파일 키 발급)
uploadRoutes.post('/api/upload/prepare', requireAuth, async (c) => {
  try {
    const user = c.get('user')!
    const body = await c.req.json()
    const { filename, contentType, contentLength } = body

    if (!filename || !contentType || !contentLength) {
      return c.json({ success: false, error: '필수 입력값이 없습니다.' }, 400)
    }

    const { createUploadInfo, validateContentType, validateFileSize } = await import('../services/uploadService')

    // 검증
    const typeResult = validateContentType(contentType)
    if (!typeResult.valid) {
      return c.json({ success: false, error: typeResult.error }, 400)
    }

    const sizeResult = validateFileSize(contentLength)
    if (!sizeResult.valid) {
      return c.json({ success: false, error: sizeResult.error }, 400)
    }

    // 업로드 정보 생성
    const uploadInfo = createUploadInfo({ filename, contentType, contentLength })
    if (!uploadInfo.success) {
      return c.json({ success: false, error: uploadInfo.error }, 400)
    }

    // 기본 URL 결정
    const baseUrl = new URL(c.req.url).origin

    return c.json({
      success: true,
      fileKey: uploadInfo.data!.fileKey,
      uploadUrl: `${baseUrl}/api/upload/file`,
      publicUrl: `${baseUrl}/uploads/${uploadInfo.data!.fileKey}`,
      expiresIn: 300 // 5??
    })
  } catch (error) {
    return c.json({ success: false, error: '업로드 준비 중 오류가 발생했습니다.' }, 500)
  }
})

// 파일 업로드 (실제 업로드)
uploadRoutes.post('/api/upload/file', requireAuth, async (c) => {
  try {
    const user = c.get('user')!
    const fileKey = c.req.header('X-File-Key')
    const contentType = c.req.header('Content-Type') || ''

    if (!fileKey) {
      return c.json({ success: false, error: '파일 키가 없습니다.' }, 400)
    }

    const { validateContentType, validateMagicNumber, uploadToR2, getPublicUrl } = await import('../services/uploadService')

    // 콘텐츠 타입 검증
    const typeResult = validateContentType(contentType)
    if (!typeResult.valid) {
      return c.json({ success: false, error: typeResult.error }, 400)
    }

    // 파일 본문 읽기
    const body = await c.req.arrayBuffer()

    // 매직 넘버 검증
    if (!validateMagicNumber(body, contentType)) {
      return c.json({ success: false, error: '파일 형식이 올바르지 않습니다.' }, 400)
    }

    // R2에 업로드
    const uploadResult = await uploadToR2(c.env.UPLOADS, fileKey, body, contentType, {
      uploadedBy: user.id.toString(),
      originalContentType: contentType
    })

    if (!uploadResult.success) {
      return c.json({ success: false, error: uploadResult.error }, 500)
    }

    // DB에 메타데이터 저장
    await c.env.DB.prepare(`
      INSERT INTO uploaded_files (user_id, file_key, content_type, file_size)
      VALUES (?, ?, ?, ?)
    `).bind(user.id, fileKey, contentType, body.byteLength).run()

    const baseUrl = new URL(c.req.url).origin

    return c.json({
      success: true,
      fileKey,
      publicUrl: `${baseUrl}/uploads/${fileKey}`,
      size: body.byteLength
    })
  } catch (error) {
    return c.json({ success: false, error: '파일 업로드 중 오류가 발생했습니다.' }, 500)
  }
})

// 이미지 서빙 (R2 프록시)
uploadRoutes.get('/uploads/*', async (c) => {
  try {
    const rawUrl = c.req.raw.url
    const urlObj = new URL(rawUrl)
    const pathAfterUploads = urlObj.pathname.replace('/uploads/', '')

    if (!pathAfterUploads) {
      return c.json({ error: 'Empty path' }, 404)
    }

    if (!c.env.UPLOADS) {
      return c.json({ error: 'R2 bucket not bound' }, 500)
    }

    // R2 키가 다양한 형태로 저장되어 있으므로 모든 변형을 시도
    // 옛 이미지: 인코딩된 키 (jobs/job-%EB%B2%95%EC%9D%98%ED%95%99%EC%9E%90.webp)
    // 새 이미지: 디코딩된 키 (jobs/job-법의학자.webp)
    const decodedPath = decodeURIComponent(pathAfterUploads)

    // 파일명에서 슬래시→언더스코어 변환 (UI/UX 같은 이름 처리)
    const firstSlash = decodedPath.indexOf('/')
    const dir = firstSlash !== -1 ? decodedPath.substring(0, firstSlash) : ''
    const filename = firstSlash !== -1 ? decodedPath.substring(firstSlash + 1) : decodedPath
    const safeFilename = filename.replace(/\//g, '_')

    // 파일명 부분만 인코딩한 키 (디렉토리 구분자는 유지)
    const reEncodedFilename = encodeURIComponent(safeFilename).replace(/%2F/g, '/')
    const reEncodedPath = dir ? `${dir}/${reEncodedFilename}` : reEncodedFilename

    // 시도할 R2 키 목록 (중복 제거)
    const keysToTry = [...new Set([
      decodedPath,                                    // 1. 디코딩된 한글 (새 이미지)
      pathAfterUploads,                               // 2. URL에서 추출한 원본 (인코딩된 상태)
      reEncodedPath,                                  // 3. 파일명만 재인코딩
      dir ? `${dir}/${safeFilename}` : safeFilename,  // 4. 슬래시→언더스코어 변환
    ])]

    let object: R2ObjectBody | null = null
    let usedPath = ''

    for (const key of keysToTry) {
      object = await c.env.UPLOADS.get(key)
      if (object) {
        usedPath = key
        break
      }
    }

    if (!object) {
      return c.json({
        error: 'File not found in R2',
        tried: keysToTry,
      }, 404)
    }

    // 확장자 기반 Content-Type 추론 (R2 메타데이터가 없을 경우 대비)
    const getContentTypeByExtension = (filepath: string): string => {
      const ext = filepath.split('.').pop()?.toLowerCase()
      const mimeTypes: Record<string, string> = {
        'webp': 'image/webp',
        'png': 'image/png',
        'jpg': 'image/jpeg',
        'jpeg': 'image/jpeg',
        'gif': 'image/gif',
        'svg': 'image/svg+xml',
        'ico': 'image/x-icon',
        'avif': 'image/avif'
      }
      return mimeTypes[ext || ''] || 'application/octet-stream'
    }

    // 캐시 헤더 설정 (1년)
    const headers = new Headers()
    const contentType = object.httpMetadata?.contentType || getContentTypeByExtension(usedPath)
    headers.set('Content-Type', contentType)
    // ?v= 캐시 버스터가 있으면 장기 캐시, 없으면 revalidate
    const hasVersionParam = new URL(c.req.raw.url).searchParams.has('v')
    headers.set('Cache-Control', hasVersionParam
      ? 'public, max-age=31536000, immutable'
      : 'public, max-age=3600, must-revalidate')
    headers.set('ETag', object.httpEtag)

    // If-None-Match 헤더 확인 (304 응답)
    const ifNoneMatch = c.req.header('If-None-Match')
    if (ifNoneMatch && ifNoneMatch === object.httpEtag) {
      return new Response(null, { status: 304, headers })
    }

    return new Response(object.body as ReadableStream, { headers })
  } catch (error) {
    // 에러 발생 시 상세 정보 반환
    return c.json({
      error: 'R2 proxy error',
      message: error instanceof Error ? error.message : String(error)
    }, 500)
  }
})

// ============================================
// Z-Image Turbo 이미지 생성 API
// ============================================

// 이미지 생성 요청 (관리자 전용)
uploadRoutes.post('/api/image/generate', requireAuth, async (c) => {
  try {
    const user = c.get('user')!

    // 관리자 권한 확인
    if (user.role !== 'admin') {
      return c.json({ success: false, error: '관리자 권한이 필요합니다.' }, 403)
    }

    const apiKey = c.env.EVOLINK_API_KEY
    if (!apiKey) {
      return c.json({ success: false, error: 'EVOLINK_API_KEY가 설정되지 않았습니다.' }, 500)
    }

    const body = await c.req.json()
    const { type, slug, promptOverride } = body as {
      type: 'jobs' | 'majors'
      slug: string
      promptOverride?: string
    }

    if (!type || !slug) {
      return c.json({ success: false, error: 'type과 slug가 필요합니다.' }, 400)
    }

    // 프롬프트 결정: promptOverride → DB image_prompt → Gemini 자동 생성
    let imagePrompt: string | undefined = promptOverride
    if (!imagePrompt) {
      const table = type === 'jobs' ? 'jobs' : 'majors'
      const nameCol = type === 'jobs' ? 'name' : 'name'
      const record = await c.env.DB.prepare(`
        SELECT image_prompt, ${nameCol} as item_name FROM ${table} WHERE slug = ?
      `).bind(slug).first<{ image_prompt: string | null; item_name: string }>()

      if (record?.image_prompt) {
        imagePrompt = record.image_prompt
      } else if (record?.item_name && c.env.GEMINI_API_KEY) {
        // Gemini로 자동 프롬프트 생성
        const { generateJobImagePrompt, generateMajorImagePrompt } = await import('../services/geminiService')
        const geminiResult = type === 'jobs'
          ? await generateJobImagePrompt(c.env.GEMINI_API_KEY, record.item_name)
          : await generateMajorImagePrompt(c.env.GEMINI_API_KEY, record.item_name)

        if (geminiResult.success && geminiResult.prompt) {
          imagePrompt = geminiResult.prompt
          // 생성된 프롬프트를 DB에 저장 (다음에 재사용)
          await c.env.DB.prepare(`UPDATE ${table} SET image_prompt = ? WHERE slug = ?`)
            .bind(imagePrompt, slug).run()
        } else {
          return c.json({ success: false, error: '이미지 프롬프트 생성에 실패했습니다.' }, 500)
        }
      } else {
        return c.json({ success: false, error: '대상 항목을 찾을 수 없습니다.' }, 404)
      }
    }

    // 콜백 URL 생성
    const baseUrl = new URL(c.req.url).origin
    const callbackUrl = `${baseUrl}/webhooks/image-completed`

    // Z-Image Turbo API 호출 (매번 다른 이미지를 위해 랜덤 seed 사용)
    const { requestImageGeneration } = await import('../services/imageGenerationService')
    const randomSeed = Math.floor(Math.random() * 2147483647)
    console.log(`[ImageGen] Requesting: type=${type}, slug=${slug}, seed=${randomSeed}, prompt="${(imagePrompt || '').substring(0, 80)}..."`)
    const result = await requestImageGeneration(apiKey, {
      prompt: imagePrompt || '',
      size: '16:9',
      seed: randomSeed,
      callback_url: callbackUrl
    })

    if (!result.success || !result.data) {
      return c.json({ success: false, error: result.error || '이미지 생성 요청에 실패했습니다.' }, 500)
    }

    // 태스크 정보를 KV에 저장 (콜백 시 사용)
    const taskMeta = {
      type,
      slug,
      prompt: (imagePrompt || '').substring(0, 200), // 프롬프트 요약
      createdAt: Date.now(),
      createdBy: user.id
    }

    // KV가 바인딩되어 있으면 저장 (로컬 개발 환경에서는 없을 수 있음)
    if (c.env.KV) {
      await c.env.KV.put(`image-task:${result.data.id}`, JSON.stringify(taskMeta), {
        expirationTtl: 86400 // 24시간
      })
    } else {
    }

    return c.json({
      success: true,
      taskId: result.data.id,
      status: result.data.status,
      estimatedTime: result.data.task_info?.estimated_time || 10
    })
  } catch (error) {
    return c.json({ success: false, error: '이미지 생성 요청 중 오류가 발생했습니다.' }, 500)
  }
})

// 이미지 생성 상태 조회
uploadRoutes.get('/api/image/status/:taskId', requireAuth, async (c) => {
  try {
    const taskId = c.req.param('taskId')
    const apiKey = c.env.EVOLINK_API_KEY

    if (!apiKey) {
      return c.json({ success: false, error: 'EVOLINK_API_KEY가 설정되지 않았습니다.' }, 500)
    }

    const { queryTaskStatus } = await import('../services/imageGenerationService')
    const result = await queryTaskStatus(apiKey, taskId)


    console.log(`[ImageStatus] taskId=${taskId}, raw response:`, JSON.stringify(result.data).substring(0, 500))

    if (!result.success || !result.data) {
      return c.json({ success: false, error: result.error || '상태 조회에 실패했습니다.' }, 500)
    }

    // 상태 정규화 (다양한 API 응답 형식 처리)
    const rawStatus = (result.data as any).status || (result.data as any).state || ''
    const normalizedStatus = rawStatus.toLowerCase()
    const isCompleted = normalizedStatus === 'completed' || normalizedStatus === 'success' || normalizedStatus === 'done'
    const isFailed = normalizedStatus === 'failed' || normalizedStatus === 'error'

    // results 배열 우선, data.url/urls는 fallback
    const imageUrl = (result.data as any).results?.[0] || (result.data as any).data?.url || (result.data as any).data?.urls?.[0] || (result.data as any).output?.url

    console.log(`[ImageStatus] taskId=${taskId}, status=${rawStatus}, isCompleted=${isCompleted}, imageUrl=${imageUrl ? imageUrl.substring(0, 120) : 'null'}`)

    return c.json({
      success: true,
      taskId: result.data.id,
      status: isCompleted ? 'completed' : (isFailed ? 'failed' : rawStatus),
      progress: result.data.progress,
      imageUrl
    })
  } catch (error) {
    return c.json({ success: false, error: '상태 조회 중 오류가 발생했습니다.' }, 500)
  }
})

// 이미지 저장 API (폴링 방식용 - 로컬 환경에서 콜백이 작동하지 않을 때 사용)
uploadRoutes.post('/api/image/save', requireAuth, async (c) => {
  try {
    const user = c.get('user')!

    // 관리자 권한 확인
    if (user.role !== 'admin') {
      return c.json({ success: false, error: '관리자 권한이 필요합니다.' }, 403)
    }

    const body = await c.req.json()
    const { taskId, type, slug, imageUrl } = body as {
      taskId: string
      type: 'jobs' | 'majors'
      slug: string
      imageUrl: string
    }

    if (!taskId || !type || !slug || !imageUrl) {
      return c.json({ success: false, error: 'taskId, type, slug, imageUrl이 필요합니다.' }, 400)
    }

    const { downloadImage, generateImageFileKey, getImagePublicUrl } =
      await import('../services/imageGenerationService')
    const { uploadToR2 } = await import('../services/uploadService')

    // 이미지 다운로드
    console.log(`[ImageSave] Downloading from: ${imageUrl}`)
    const downloadResult = await downloadImage(imageUrl)
    if (!downloadResult.success || !downloadResult.data) {
      console.log(`[ImageSave] Download FAILED: ${downloadResult.error}`)
      return c.json({ success: false, error: downloadResult.error || '이미지 다운로드에 실패했습니다.', debug: { imageUrl, downloadError: downloadResult.error } }, 500)
    }

    const downloadSize = downloadResult.data.byteLength
    console.log(`[ImageSave] Downloaded: ${downloadSize} bytes, type=${downloadResult.contentType}, url=${imageUrl}`)

    // R2에 업로드 (기존 이미지 덮어쓰기)
    const actualContentType = downloadResult.contentType || 'image/png'
    const fileKey = generateImageFileKey(type, slug, actualContentType)


    // 기존 이미지가 다른 확장자 또는 다른 인코딩으로 저장되어 있을 수 있으므로
    const extensions = ['webp', 'png', 'jpg']
    const prefix = type === 'jobs' ? 'job' : 'major'
    const safeSlug = slug.replace(/\//g, '_')
    const encodedSlug = encodeURIComponent(safeSlug)
    const decodedSlug = safeSlug  // 한글 그대로

    for (const ext of extensions) {
      // 인코딩된 키 (generateImageFileKey가 생성하는 형식)
      const encodedKey = `${type}/${prefix}-${encodedSlug}.${ext}`
      // 디코딩된 키 (기존 autoImageService 등이 저장한 형식)
      const decodedKey = `${type}/${prefix}-${decodedSlug}.${ext}`

      for (const oldKey of [encodedKey, decodedKey]) {
        if (oldKey !== fileKey) {
          try { await c.env.UPLOADS.delete(oldKey) } catch {}
        }
      }
    }
    console.log(`[ImageSave] Deleted old variants. Uploading new: key=${fileKey}`)

    const uploadResult = await uploadToR2(
      c.env.UPLOADS,
      fileKey,
      downloadResult.data,
      actualContentType,
      {
        source: 'z-image-turbo',
        taskId,
        slug
      }
    )

    if (!uploadResult.success) {
      console.log(`[ImageSave] R2 upload FAILED: ${uploadResult.error}`)
      return c.json({ success: false, error: uploadResult.error || 'R2 업로드에 실패했습니다.' }, 500)
    }
    console.log(`[ImageSave] R2 upload OK: key=${fileKey}`)

    // DB 업데이트 (image_url 컬럼 + merged_profile_json 둘 다 업데이트)
    const baseUrl = new URL(c.req.url).origin
    const publicUrl = getImagePublicUrl(fileKey, baseUrl)
    // 캐시 버스터 추가 (브라우저 캐시 우회)
    const publicUrlWithCache = `${publicUrl}?v=${Date.now()}`
    const table = type === 'jobs' ? 'jobs' : 'majors'

    // slug로 레코드 찾기 - image_url 컬럼과 merged_profile_json 둘 다 업데이트
    let updateResult = await c.env.DB.prepare(`
      UPDATE ${table}
      SET image_url = ?,
          merged_profile_json = json_set(COALESCE(merged_profile_json, '{}'), '$.image_url', ?)
      WHERE slug = ?
    `).bind(publicUrlWithCache, publicUrlWithCache, slug).run()

    // slug로 못 찾으면 name으로 시도
    if (updateResult.meta.changes === 0) {
      updateResult = await c.env.DB.prepare(`
        UPDATE ${table}
        SET image_url = ?,
            merged_profile_json = json_set(COALESCE(merged_profile_json, '{}'), '$.image_url', ?)
        WHERE name = ?
      `).bind(publicUrlWithCache, publicUrlWithCache, slug).run()
    }


    // CDN 캐시 퍼지 (페이지 + 이미지 URL 모두)
    try {
      const baseUrl = new URL(c.req.url).origin
      const pageType = type === 'jobs' ? 'job' : 'major'
      const pageUrl = `${baseUrl}/${pageType}/${encodeURIComponent(slug)}`
      const imageUrlFull = `${baseUrl}${publicUrl}`  // /uploads/... ??? URL

      // 1) Workers Cache API — 페이지와 이미지 모두 퍼지
      const cache = (caches as any).default
      const urlsToPurge = [
        pageUrl,
        `${baseUrl}/${pageType}/${slug}`,
        imageUrlFull,
        `${imageUrlFull}?v=${Date.now()}`,
      ]
      for (const u of urlsToPurge) {
        try { await cache.delete(new Request(u)) } catch {}
      }
      console.log(`[ImageSave] Cache purged: ${urlsToPurge.length} URLs`)

      // 1.5) KV 목록 캐시 무효화 (썸네일 갱신)
      if (c.env.KV) {
        const { invalidateListCache } = await import('../services/cacheService')
        const listType = pageType as 'job' | 'major'
        const deleted = await invalidateListCache(c.env.KV, listType)
        console.log(`[ImageSave] List KV cache purged: ${deleted} keys for ${listType}`)
      }

      // 2) Cloudflare Zone Purge API (CF_ZONE_ID + CF_API_TOKEN 필요)
      const zoneId = c.env.CF_ZONE_ID
      const apiToken = c.env.CLOUDFLARE_API_TOKEN
      if (zoneId && apiToken) {
        // prefix_purge로 이미지 URL 변형 모두 퍼지
        await fetch(`https://api.cloudflare.com/client/v4/zones/${zoneId}/purge_cache`, {
          method: 'POST',
          headers: { 'Authorization': `Bearer ${apiToken}`, 'Content-Type': 'application/json' },
          body: JSON.stringify({
            files: [
              pageUrl,
              `${baseUrl}/${pageType}/${slug}`,
              imageUrlFull,
            ]
          })
        })
      }
    } catch (cacheError) {
      console.log(`[ImageSave] Cache purge error: ${cacheError}`)
    }

    return c.json({
      success: true,
      imageUrl: publicUrlWithCache,
      message: '이미지가 성공적으로 저장되었습니다. 새로고침하면 확인할 수 있습니다.',
      debug: { fileKey, downloadSize, actualContentType, sourceUrl: imageUrl, dbChanges: updateResult.meta.changes }
    })
  } catch (error) {
    return c.json({ success: false, error: '이미지 저장 중 오류가 발생했습니다.' }, 500)
  }
})

// Z-Image Turbo 콜백 핸들러 (이미지 생성 완료 시 호출됨)
uploadRoutes.post('/webhooks/image-completed', async (c) => {
  try {
    const body = await c.req.json()

    const { parseCallbackData, downloadImage, generateImageFileKey, getImagePublicUrl } =
      await import('../services/imageGenerationService')
    const { uploadToR2 } = await import('../services/uploadService')

    // 콜백 데이터 파싱
    const taskData = parseCallbackData(body)
    if (!taskData) {
      return c.json({ success: false, error: 'Invalid callback data' }, 400)
    }

    const taskId = taskData.id
    const status = taskData.status

    // 태스크 메타데이터 조회
    const taskMetaStr = await c.env.KV.get(`image-task:${taskId}`)
    if (!taskMetaStr) {
      return c.json({ success: false, error: 'Task metadata not found' }, 404)
    }

    const taskMeta = JSON.parse(taskMetaStr) as {
      type: 'jobs' | 'majors'
      slug: string
      prompt: string
      createdAt: number
      createdBy: number
    }

    // 실패 처리
    if (status === 'failed') {
      // 실패 로그 저장 (선택사항)
      await c.env.KV.put(`image-task-failed:${taskId}`, JSON.stringify({
        ...taskMeta,
        error: taskData.error,
        failedAt: Date.now()
      }), { expirationTtl: 604800 }) // 7??
      return c.json({ success: true, status: 'failed' })
    }

    // 완료가 아니면 무시
    if (status !== 'completed') {
      return c.json({ success: true, status })
    }

    // 이미지 URL 추출 (results 배열 우선)
    const imageUrl = taskData.results?.[0] || taskData.data?.url || taskData.data?.urls?.[0]
    if (!imageUrl) {
      return c.json({ success: false, error: 'No image URL' }, 400)
    }

    // 이미지 다운로드
    const downloadResult = await downloadImage(imageUrl)
    if (!downloadResult.success || !downloadResult.data) {
      return c.json({ success: false, error: downloadResult.error }, 500)
    }

    // R2에 업로드
    const fileKey = generateImageFileKey(taskMeta.type, taskMeta.slug)
    const uploadResult = await uploadToR2(
      c.env.UPLOADS,
      fileKey,
      downloadResult.data,
      downloadResult.contentType || 'image/png',
      {
        source: 'z-image-turbo',
        taskId,
        slug: taskMeta.slug
      }
    )

    if (!uploadResult.success) {
      return c.json({ success: false, error: uploadResult.error }, 500)
    }

    // DB 업데이트
    const baseUrl = new URL(c.req.url).origin
    const publicUrl = getImagePublicUrl(fileKey, baseUrl)
    const table = taskMeta.type === 'jobs' ? 'jobs' : 'majors'

    await c.env.DB.prepare(`
      UPDATE ${table}
      SET image_url = ?, updated_at = datetime('now')
      WHERE slug = ?
    `).bind(publicUrl, taskMeta.slug).run()


    // 목록 KV 캐시 무효화 (썸네일 갱신)
    if (c.env.KV) {
      const { invalidateListCache } = await import('../services/cacheService')
      const listType = (taskMeta.type === 'jobs' ? 'job' : 'major') as 'job' | 'major'
      await invalidateListCache(c.env.KV, listType)
    }

    // 태스크 메타데이터 삭제
    await c.env.KV.delete(`image-task:${taskId}`)

    // 성공 로그 저장 (선택사항)
    await c.env.KV.put(`image-task-completed:${taskId}`, JSON.stringify({
      ...taskMeta,
      imageUrl: publicUrl,
      completedAt: Date.now()
    }), { expirationTtl: 604800 }) // 7??

    return c.json({ success: true, status: 'completed', imageUrl: publicUrl })
  } catch (error) {
    return c.json({ success: false, error: 'Internal error' }, 500)
  }
})

// 로컬 브리지가 생성한 이미지 바이트를 받아 R2 + D1에 저장하는 엔드포인트
// (브리지는 순수 컴퓨트만 담당, 모든 영구 쓰기는 서버에서 수행)
uploadRoutes.post('/api/admin/image/save', requireAuth, async (c) => {
  try {
    const user = c.get('user')!
    if (!hasImageAdminRole(user.role)) {
      return c.json({ success: false, error: '관리자 권한이 필요합니다.' }, 403)
    }

    const body = await c.req.json() as {
      targetType?: 'job' | 'major'
      type?: 'jobs' | 'majors'
      slug?: string
      imageBase64?: string
      mimeType?: string
      prompt?: string
      source?: { prompt?: string; image?: string }
      loraApplied?: boolean
    }

    // targetType('job'/'major') 또는 type('jobs'/'majors') 둘 다 수용
    const tableType: 'jobs' | 'majors' =
      body.type === 'jobs' || body.targetType === 'job' ? 'jobs'
      : body.type === 'majors' || body.targetType === 'major' ? 'majors'
      : (() => { throw new Error('targetType 또는 type이 필요합니다.') })()

    const slug = body.slug
    const imageBase64 = body.imageBase64
    const mimeType = body.mimeType || 'image/webp'

    if (!slug || !imageBase64) {
      return c.json({ success: false, error: 'slug와 imageBase64가 필요합니다.' }, 400)
    }

    if (!['image/webp', 'image/png', 'image/jpeg'].includes(mimeType)) {
      return c.json({ success: false, error: '허용되지 않은 mimeType 입니다.' }, 400)
    }

    // 대상 레코드 존재 확인
    const table = tableType
    const record = await c.env.DB.prepare(
      `SELECT name FROM ${table} WHERE slug = ? LIMIT 1`
    ).bind(slug).first<{ name: string }>()
    if (!record?.name) {
      return c.json({ success: false, error: '대상 항목을 찾을 수 없습니다.' }, 404)
    }

    // base64 → ArrayBuffer
    let buffer: ArrayBuffer
    try {
      const bin = atob(imageBase64)
      const bytes = new Uint8Array(bin.length)
      for (let i = 0; i < bin.length; i++) bytes[i] = bin.charCodeAt(i)
      buffer = bytes.buffer
    } catch {
      return c.json({ success: false, error: 'imageBase64 디코딩 실패' }, 400)
    }

    // 사이즈 가드 (10MB)
    if (buffer.byteLength > 10 * 1024 * 1024) {
      return c.json({ success: false, error: '이미지 크기 한도(10MB) 초과' }, 413)
    }

    const { generateImageFileKey, getImagePublicUrl } = await import('../services/imageGenerationService')
    const { uploadToR2 } = await import('../services/uploadService')

    const fileKey = generateImageFileKey(tableType, slug, mimeType)
    const uploadResult = await uploadToR2(c.env.UPLOADS, fileKey, buffer, mimeType, {
      source: 'local-bridge',
      adminId: String(user.id),
      promptSource: body.source?.prompt || 'unknown',
      imageSource: body.source?.image || 'unknown',
    })
    if (!uploadResult.success) {
      return c.json({ success: false, error: uploadResult.error || 'R2 업로드 실패' }, 500)
    }

    const baseUrl = new URL(c.req.url).origin
    const publicUrl = getImagePublicUrl(fileKey, baseUrl)
    const cacheBustedUrl = `${publicUrl}?v=${Date.now()}`

    const generationMeta = {
      generatedAt: new Date().toISOString(),
      generatedBy: 'local-bridge',
      promptSource: body.source?.prompt || null,
      imageSource: body.source?.image || null,
      loraApplied: !!body.loraApplied,
    }

    await c.env.DB.prepare(`
      UPDATE ${table}
      SET image_url = ?,
          image_prompt = ?,
          merged_profile_json = json_set(
            COALESCE(merged_profile_json, '{}'),
            '$.image_url', ?,
            '$.image_generation_meta', json(?)
          )
      WHERE slug = ?
    `).bind(
      cacheBustedUrl,
      body.prompt || null,
      cacheBustedUrl,
      JSON.stringify(generationMeta),
      slug
    ).run()

    if (c.env.KV) {
      const { invalidateListCache } = await import('../services/cacheService')
      await invalidateListCache(c.env.KV, tableType === 'jobs' ? 'job' : 'major')
    }

    return c.json({
      success: true,
      imageUrl: cacheBustedUrl,
      r2Key: fileKey,
      source: { prompt: body.source?.prompt || null, image: body.source?.image || null, mode: 'local-bridge' },
      loraApplied: !!body.loraApplied,
      generationMeta,
    })
  } catch (error) {
    return c.json({
      success: false,
      error: error instanceof Error ? error.message : '이미지 저장 중 오류가 발생했습니다.'
    }, 500)
  }
})

uploadRoutes.post('/api/admin/image/regenerate', requireAuth, async (c) => {
  try {
    const user = c.get('user')!
    if (!hasImageAdminRole(user.role)) {
      return c.json({ success: false, error: '관리자 권한이 필요합니다.' }, 403)
    }

    const body = await c.req.json()
    const { type, slug } = body as { type: 'jobs' | 'majors'; slug: string }

    if (!type || !slug || !['jobs', 'majors'].includes(type)) {
      return c.json({ success: false, error: 'type과 slug가 필요합니다.' }, 400)
    }

    const table = type === 'jobs' ? 'jobs' : 'majors'
    const record = await c.env.DB.prepare(
      `SELECT name FROM ${table} WHERE slug = ? LIMIT 1`
    ).bind(slug).first<{ name: string }>()

    if (!record?.name) {
      return c.json({ success: false, error: '대상 항목을 찾을 수 없습니다.' }, 404)
    }

    const baseUrl = new URL(c.req.url).origin
    const source = { prompt: 'gemini', image: 'evolink', mode: 'remote-fallback' }
    const autoImageService = await import('../services/autoImageService')
    const imageResult = type === 'jobs'
      ? await autoImageService.generateJobImage(
          {
            GEMINI_API_KEY: c.env.GEMINI_API_KEY || '',
            EVOLINK_API_KEY: c.env.EVOLINK_API_KEY || '',
            UPLOADS: c.env.UPLOADS
          },
          record.name,
          slug,
          baseUrl
        )
      : await autoImageService.generateMajorImage(
          {
            GEMINI_API_KEY: c.env.GEMINI_API_KEY || '',
            EVOLINK_API_KEY: c.env.EVOLINK_API_KEY || '',
            UPLOADS: c.env.UPLOADS
          },
          record.name,
          slug,
          baseUrl
        )

    if (!imageResult.success || !imageResult.imageUrl) {
      return c.json({
        success: false,
        error: imageResult.error || '이미지 생성에 실패했습니다.',
        imagePrompt: imageResult.imagePrompt || null,
        source
      }, 500)
    }

    const generationMeta = {
      generatedAt: new Date().toISOString(),
      generatedBy: 'remote-admin-regenerate',
      promptSource: source.prompt,
      imageSource: source.image,
      loraApplied: false,
    }
    const cacheBustedUrl = `${imageResult.imageUrl}${imageResult.imageUrl.includes('?') ? '&' : '?'}v=${Date.now()}`

    await c.env.DB.prepare(`
      UPDATE ${table}
      SET image_url = ?,
          image_prompt = ?,
          merged_profile_json = json_set(
            COALESCE(merged_profile_json, '{}'),
            '$.image_url', ?,
            '$.image_generation_meta', json(?)
          )
      WHERE slug = ?
    `).bind(
      cacheBustedUrl,
      imageResult.imagePrompt || null,
      cacheBustedUrl,
      JSON.stringify(generationMeta),
      slug
    ).run()

    if (c.env.KV) {
      const { invalidateListCache } = await import('../services/cacheService')
      await invalidateListCache(c.env.KV, type === 'jobs' ? 'job' : 'major')
    }

    return c.json({
      success: true,
      imageUrl: cacheBustedUrl,
      imagePrompt: imageResult.imagePrompt || null,
      source,
      generationMeta,
      details: imageResult.details || null,
    })
  } catch (error) {
    return c.json({
      success: false,
      error: error instanceof Error ? error.message : '이미지 재생성 중 오류가 발생했습니다.'
    }, 500)
  }
})

export { uploadRoutes }



/**
 * Edit Service
 * 
 * 편집 시스템의 데이터 저장 로직
 * - 직업/전공/HowTo 편집 처리
 * - API 데이터 편집 지원
 * - Revision 생성 및 데이터 병합
 */

import type { D1Database } from '@cloudflare/workers-types'
import { createRevision, getCurrentRevision } from './revisionService'
import { 
  getNextAnonymousNumber, 
  checkAnonymousEditLimit, 
  incrementAnonymousEditCount,
  verifyEditPassword,
  hashEditPassword
} from '../utils/anonymousEdit'
import { getStoredJob } from './jobStorage'
import { invalidatePageCache } from '../utils/page-cache'
import { validateEditInput, sanitizeContent } from '../utils/editValidation'
import type { UnifiedJobDetail } from '../types/unifiedProfiles'
import type { UnifiedMajorDetail } from '../types/unifiedProfiles'

/**
 * 직업 편집 페이로드
 */
export interface EditJobPayload {
  field: string  // 'summary', 'duties', 'salary' 등
  content: string  // 편집 내용
  source: string  // 출처 URL (필수)
  changeSummary?: string  // 변경 요약
  // 익명 편집 시
  password?: string
  anonymous?: boolean
  ipHash?: string
  // 로그인 사용자
  userId?: string
  editorType?: 'user' | 'expert' | 'admin'
}

/**
 * 전공 편집 페이로드
 */
export interface EditMajorPayload {
  field: string
  content: string
  source: string
  changeSummary?: string
  password?: string
  anonymous?: boolean
  ipHash?: string
  userId?: string
  editorType?: 'user' | 'expert' | 'admin'
}

/**
 * HowTo 편집 페이로드
 */
export interface EditHowToPayload {
  content: string  // JSON 문자열 (HowtoGuideDetail 구조)
  source?: string
  changeSummary?: string
  password?: string
  anonymous?: boolean
  ipHash?: string
  userId?: string
  editorType?: 'user' | 'expert' | 'admin'
}

/**
 * API 데이터 편집 페이로드
 */
export interface EditApiDataPayload {
  field: string
  content: string
  source: string
  changeSummary?: string
  password?: string
  anonymous?: boolean
  ipHash?: string
  userId?: string
  editorType?: 'user' | 'expert' | 'admin'
}

/**
 * 현재 데이터를 병합하여 스냅샷 생성
 */
async function createDataSnapshot(
  db: D1Database,
  entityType: 'job' | 'major',
  entityId: string
): Promise<any> {
  if (entityType === 'job') {
    const job = await getStoredJob(db, entityId)
    if (!job) {
      throw new Error('JOB_NOT_FOUND')
    }
    return job
  } else if (entityType === 'major') {
    // majors 테이블에서 데이터 조회
    const result = await db.prepare(
      'SELECT * FROM majors WHERE id = ? AND is_active = 1'
    ).bind(entityId).first()
    
    if (!result) {
      throw new Error('MAJOR_NOT_FOUND')
    }
    
    // 데이터 병합 (admin > user > api 우선순위)
    let apiData = {}
    let userData = {}
    let adminData = {}
    
    try {
      apiData = result.api_data_json ? JSON.parse(result.api_data_json as string) : {}
    } catch (error) {
      console.error('[createDataSnapshot] Failed to parse api_data_json:', error)
      apiData = {}
    }
    
    try {
      userData = result.user_contributed_json ? JSON.parse(result.user_contributed_json as string) : {}
    } catch (error) {
      console.error('[createDataSnapshot] Failed to parse user_contributed_json:', error)
      userData = {}
    }
    
    try {
      adminData = result.admin_data_json ? JSON.parse(result.admin_data_json as string) : {}
    } catch (error) {
      console.error('[createDataSnapshot] Failed to parse admin_data_json:', error)
      adminData = {}
    }
    
    return {
      ...apiData,
      ...userData,
      ...adminData
    } as UnifiedMajorDetail
  }
  
  throw new Error('INVALID_ENTITY_TYPE')
}

/**
 * 직업 편집
 * 
 * @param db D1 데이터베이스
 * @param jobId 직업 ID
 * @param payload 편집 페이로드
 * @returns 성공 여부 및 revision ID
 */
export async function editJob(
  db: D1Database,
  jobIdParam: string,
  payload: EditJobPayload
): Promise<{ success: boolean; revisionId: number }> {
  // jobId는 slug일 수 있으므로 실제 ID로 변환
  let jobId = jobIdParam
  // 입력 검증
  const validation = validateEditInput(payload.field, payload.content, payload.source, 'job')
  if (!validation.valid) {
    throw new Error(validation.error ?? 'INVALID_INPUT')
  }
  
  // Content 정리 (XSS 방지)
  const sanitizedContent = sanitizeContent(payload.content)
  
  // 직업 존재 확인 (ID 또는 slug로 조회)
  let job = await db.prepare('SELECT * FROM jobs WHERE id = ? AND is_active = 1')
    .bind(jobId)
    .first()
  
  // ID로 찾지 못한 경우 slug로 시도
  if (!job) {
    // job:G_K000000890 같은 형식에서 실제 ID 추출 시도
    let extractedId = jobId
    if (jobId.includes(':')) {
      // job:G_K000000890 -> G_K000000890 또는 K000000890
      const parts = jobId.split(':')
      if (parts.length > 1) {
        extractedId = parts[parts.length - 1].replace(/^G_/, '').replace(/^C_/, '')
        
        // 추출한 ID로 다시 시도
        job = await db.prepare('SELECT * FROM jobs WHERE id = ? AND is_active = 1')
          .bind(extractedId)
          .first()
        
        if (job) {
          jobId = extractedId
        }
      }
    }
    
    // 여전히 찾지 못한 경우 slug로 시도
    if (!job) {
      // slug 정규화 (URL 디코딩 포함)
      const decodedSlug = decodeURIComponent(jobId)
      const normalizedSlug = decodedSlug.toLowerCase()
      
      // 방법 1: 정규화된 이름으로 조회
      job = await db.prepare(
        'SELECT * FROM jobs WHERE LOWER(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(name, "-", ""), ",", ""), "·", ""), "ㆍ", ""), "/", ""), " ", ""), "(", ""), ")", "")) = ? AND is_active = 1 LIMIT 1'
      ).bind(normalizedSlug).first()
      
      // 방법 2: 이름으로 직접 조회 (대소문자 무시)
      if (!job) {
        job = await db.prepare(
          'SELECT * FROM jobs WHERE LOWER(name) = ? AND is_active = 1 LIMIT 1'
        ).bind(normalizedSlug).first()
      }
      
      // 방법 3: 원본 slug로 조회
      if (!job) {
        job = await db.prepare(
          'SELECT * FROM jobs WHERE LOWER(name) = LOWER(?) AND is_active = 1 LIMIT 1'
        ).bind(decodedSlug).first()
      }
      
      // slug로 찾은 경우 실제 ID로 업데이트
      if (job) {
        jobId = (job as any).id
      }
    }
  }
  
  if (!job) {
    console.error(`[editJob] Job not found. Searched with: ${jobIdParam}`)
    throw new Error('JOB_NOT_FOUND')
  }
  
  // 익명 편집인 경우 제한 체크 (IP 해시가 있는 경우만)
  if (!payload.userId && payload.ipHash) {
    const limitCheck = await checkAnonymousEditLimit(db, 'job', jobId, payload.ipHash)
    if (!limitCheck.allowed) {
      throw new Error('DAILY_LIMIT_REACHED')
    }
  }
  
  // 현재 활성 revision 확인 및 초기 revision 생성
  const currentRevision = await getCurrentRevision(db, 'job', jobId)
  let currentSnapshot: any
  
  // 첫 편집인 경우 초기 revision 생성
  if (!currentRevision) {
    try {
      currentSnapshot = await createDataSnapshot(db, 'job', jobId)
      
      // 초기 revision 생성 (운영자)
      await createRevision(db, {
        entityType: 'job',
        entityId: jobId,
        dataSnapshot: currentSnapshot,
        editorType: 'system',
        editorName: '운영자',
        changeType: 'initial',
        changeSummary: '초기 데이터',
        changedFields: [],
        storeFullSnapshot: true
      })
      
    } catch (error) {
      console.error('[editJob] Failed to create initial revision:', error)
      currentSnapshot = await createDataSnapshot(db, 'job', jobId)
    }
  } else {
    // 기존 revision이 있는 경우 스냅샷 파싱
    try {
      currentSnapshot = JSON.parse(currentRevision.dataSnapshot)
    } catch (error) {
      console.error('[editJob] Failed to parse current snapshot, creating new:', error)
      currentSnapshot = await createDataSnapshot(db, 'job', jobId)
    }
  }
  
  // 편집자 정보 설정
  let editorId: string | null = null
  let editorType: 'anonymous' | 'user' | 'expert' | 'admin' | 'system' = 'anonymous'
  let editorName: string | null = null
  let passwordHash: string | null = null
  let anonymousNumber: number | null = null
  
  if (payload.userId) {
    // 로그인 사용자 편집
    editorId = payload.userId
    editorType = payload.editorType ?? 'user'
    
    // 사용자명 조회 (선택사항)
    const user = await db.prepare('SELECT username FROM users WHERE id = ?')
      .bind(payload.userId)
      .first<{ username: string }>()
    
    editorName = user?.username ?? `User ${payload.userId}`
  } else if (payload.ipHash) {
    // 익명 편집 (IP 해시만으로 식별, 비밀번호 없음)
    editorType = 'anonymous'
    anonymousNumber = await getNextAnonymousNumber(db, 'job', jobId, payload.ipHash)
    editorName = `익명 ${anonymousNumber}`
    // 비밀번호는 없음 (IP 해시만으로 식별)
    passwordHash = null
  } else {
    // IP 해시도 없는 경우 (로컬 개발 환경 등)
    // 기본 익명 사용자로 처리
    editorType = 'anonymous'
    editorName = '익명 사용자'
    passwordHash = null
  }
  
  // 현재 데이터 조회 및 병합
  let apiData = {}
  let userData = {}
  let adminData = {}
  
  try {
    apiData = job.api_data_json ? JSON.parse(job.api_data_json as string) : {}
  } catch (error) {
    console.error('[editJob] Failed to parse api_data_json:', error)
    apiData = {}
  }
  
  try {
    userData = job.user_contributed_json ? JSON.parse(job.user_contributed_json as string) : {}
  } catch (error) {
    console.error('[editJob] Failed to parse user_contributed_json:', error)
    userData = {}
  }
  
  try {
    adminData = job.admin_data_json ? JSON.parse(job.admin_data_json as string) : {}
  } catch (error) {
    console.error('[editJob] Failed to parse admin_data_json:', error)
    adminData = {}
  }
  
  // 편집 내용 반영 (user_contributed_json에 저장)
  // Phase 4 요구사항: 사용자 편집은 user_contributed_json에 저장하여 api_data_json보다 우선순위
  const updatedUserData = {
    ...userData,
    [payload.field]: sanitizedContent
  }
  
  // 병합된 최종 데이터 생성 (admin > user > api 우선순위)
  const mergedData = {
    ...apiData,
    ...updatedUserData,
    ...adminData
  }
  
  // 변경 전 값 저장 (변경사항만 저장 시 사용)
  // 병합된 데이터에서 변경 전 값을 가져옴 (admin > user > api 우선순위)
  const previousValue = adminData[payload.field] ?? userData[payload.field] ?? apiData[payload.field] ?? null
  const previousValues: Record<string, any> = {
    [payload.field]: previousValue
  }
  
  // 보상 트랜잭션 패턴: revision 먼저 생성
  let revision: any
  try {
    revision = await createRevision(db, {
      entityType: 'job',
      entityId: jobId,
      dataSnapshot: mergedData,
      previousValues,
      editorId,
      editorType,
      editorName,
      passwordHash,
      anonymousNumber,
      ipHash: payload.ipHash ?? null,
      changeType: 'edit',
      changeSummary: payload.changeSummary ?? `Edited ${payload.field}`,
      changedFields: [payload.field],
      sourceUrl: payload.source,
      sourceType: null,  // 출처 타입은 API에서 분류
      storeFullSnapshot: false  // 변경사항만 저장 (용량 최적화)
    })
  } catch (error) {
    console.error('[editJob] Failed to create revision:', error)
    throw new Error('REVISION_CREATION_FAILED')
  }
  
  // jobs 테이블 업데이트 (user_contributed_json에 저장, 실패 시 revision 롤백)
  try {
    const now = Date.now()
    await db.prepare(`
      UPDATE jobs 
      SET user_contributed_json = ?, user_last_updated_at = ?
      WHERE id = ?
    `).bind(JSON.stringify(updatedUserData), now, jobId).run()
  } catch (error) {
    // 실패 시 생성된 revision 삭제 (보상 트랜잭션)
    console.error('[editJob] Failed to update jobs table, rolling back revision:', error)
    try {
      await db.prepare(`DELETE FROM page_revisions WHERE id = ?`).bind(revision.id).run()
    } catch (rollbackError) {
      console.error('[editJob] Failed to rollback revision:', rollbackError)
    }
    throw new Error('DATA_UPDATE_FAILED')
  }
  
  // 익명 편집 카운트 증가 (IP 해시가 있는 경우만)
  if (!payload.userId && payload.ipHash) {
    await incrementAnonymousEditCount(db, 'job', jobId, payload.ipHash)
  }
  
  // 캐시 무효화 (편집 후 ISR 캐시 삭제)
  // 🆕 jobId를 전달하여 실제 slug를 찾아서 캐시 삭제
  await invalidatePageCache(db, {
    jobId: jobId,
    pageType: 'job'
  })
  
  return {
    success: true,
    revisionId: revision.id
  }
}

/**
 * 전공 편집
 * 
 * @param db D1 데이터베이스
 * @param majorId 전공 ID
 * @param payload 편집 페이로드
 * @returns 성공 여부 및 revision ID
 */
export async function editMajor(
  db: D1Database,
  majorId: string,
  payload: EditMajorPayload
): Promise<{ success: boolean; revisionId: number }> {
  // 입력 검증
  const validation = validateEditInput(payload.field, payload.content, payload.source, 'major')
  if (!validation.valid) {
    throw new Error(validation.error ?? 'INVALID_INPUT')
  }
  
  // Content 정리 (XSS 방지)
  const sanitizedContent = sanitizeContent(payload.content)
  
  // 전공 존재 확인
  const major = await db.prepare('SELECT * FROM majors WHERE id = ? AND is_active = 1')
    .bind(majorId)
    .first()
  
  if (!major) {
    throw new Error('MAJOR_NOT_FOUND')
  }
  
  // 익명 편집인 경우 제한 체크 (IP 해시가 있는 경우만)
  if (!payload.userId && payload.ipHash) {
    const limitCheck = await checkAnonymousEditLimit(db, 'major', majorId, payload.ipHash)
    if (!limitCheck.allowed) {
      throw new Error('DAILY_LIMIT_REACHED')
    }
  }
  
  // 편집자 정보 설정 (editJob과 동일한 로직)
  let editorId: string | null = null
  let editorType: 'anonymous' | 'user' | 'expert' | 'admin' | 'system' = 'anonymous'
  let editorName: string | null = null
  let passwordHash: string | null = null
  let anonymousNumber: number | null = null
  
  if (payload.userId) {
    // 로그인 사용자 편집
    editorId = payload.userId
    editorType = payload.editorType ?? 'user'
    
    const user = await db.prepare('SELECT username FROM users WHERE id = ?')
      .bind(payload.userId)
      .first<{ username: string }>()
    
    editorName = user?.username ?? `User ${payload.userId}`
  } else if (payload.ipHash) {
    // 익명 편집 (IP 해시만으로 식별, 비밀번호 없음)
    editorType = 'anonymous'
    anonymousNumber = await getNextAnonymousNumber(db, 'major', majorId, payload.ipHash)
    editorName = `익명 ${anonymousNumber}`
    // 비밀번호는 없음 (IP 해시만으로 식별)
    passwordHash = null
  } else {
    // IP 해시도 없는 경우 (로컬 개발 환경 등)
    // 기본 익명 사용자로 처리
    editorType = 'anonymous'
    editorName = '익명 사용자'
    passwordHash = null
  }
  
  // 현재 데이터 조회 및 병합
  let apiData = {}
  let userData = {}
  let adminData = {}
  
  try {
    apiData = major.api_data_json ? JSON.parse(major.api_data_json as string) : {}
  } catch (error) {
    console.error('[editMajor] Failed to parse api_data_json:', error)
    apiData = {}
  }
  
  try {
    userData = major.user_contributed_json ? JSON.parse(major.user_contributed_json as string) : {}
  } catch (error) {
    console.error('[editMajor] Failed to parse user_contributed_json:', error)
    userData = {}
  }
  
  try {
    adminData = major.admin_data_json ? JSON.parse(major.admin_data_json as string) : {}
  } catch (error) {
    console.error('[editMajor] Failed to parse admin_data_json:', error)
    adminData = {}
  }
  
  // 편집 내용 반영 (user_contributed_json에 저장)
  const updatedUserData = {
    ...userData,
    [payload.field]: sanitizedContent
  }
  
  // 병합된 최종 데이터 생성 (admin > user > api 우선순위)
  const mergedData = {
    ...apiData,
    ...updatedUserData,
    ...adminData
  }
  
  // 현재 활성 revision 확인 및 초기 revision 생성
  const currentRevision = await getCurrentRevision(db, 'major', majorId)
  
  // 첫 편집인 경우 초기 revision 생성
  if (!currentRevision) {
    try {
      const initialSnapshot = await createDataSnapshot(db, 'major', majorId)
      
      // 초기 revision 생성 (운영자)
      await createRevision(db, {
        entityType: 'major',
        entityId: majorId,
        dataSnapshot: initialSnapshot,
        editorType: 'system',
        editorName: '운영자',
        changeType: 'initial',
        changeSummary: '초기 데이터',
        changedFields: [],
        storeFullSnapshot: true
      })
      
    } catch (error) {
      console.error('[editMajor] Failed to create initial revision:', error)
      // 계속 진행 (초기 revision 생성 실패해도 편집은 가능)
    }
  }
  
  // 변경 전 값 저장 (현재 user_contributed_json에 있는 값)
  const previousValues: Record<string, any> = {
    [payload.field]: userData[payload.field] ?? apiData[payload.field] ?? null
  }
  
  // 보상 트랜잭션 패턴: revision 먼저 생성
  let revision: any
  try {
    revision = await createRevision(db, {
      entityType: 'major',
      entityId: majorId,
      dataSnapshot: mergedData,
      previousValues,
      editorId,
      editorType,
      editorName,
      passwordHash,
      anonymousNumber,
      ipHash: payload.ipHash ?? null,
      changeType: 'edit',
      changeSummary: payload.changeSummary ?? `Edited ${payload.field}`,
      changedFields: [payload.field],
      sourceUrl: payload.source,
      sourceType: null,
      storeFullSnapshot: false  // 변경사항만 저장
    })
    
  } catch (error) {
    console.error('[editMajor] Failed to create revision:', error)
    throw new Error('REVISION_CREATION_FAILED')
  }
  
  // majors 테이블 업데이트 (user_contributed_json에 저장, 실패 시 revision 롤백)
  try {
    await db.prepare(`
      UPDATE majors 
      SET user_contributed_json = ?
      WHERE id = ?
    `).bind(JSON.stringify(updatedUserData), majorId).run()
    
  } catch (error) {
    // 실패 시 생성된 revision 삭제
    console.error('[editMajor] Failed to update majors table, rolling back revision:', error)
    try {
      await db.prepare(`DELETE FROM page_revisions WHERE id = ?`).bind(revision.id).run()
    } catch (rollbackError) {
      console.error('[editMajor] Failed to rollback revision:', rollbackError)
    }
    throw new Error('DATA_UPDATE_FAILED')
  }
  
  // 익명 편집 카운트 증가 (IP 해시가 있는 경우만)
  if (!payload.userId && payload.ipHash) {
    await incrementAnonymousEditCount(db, 'major', majorId, payload.ipHash)
  }
  
  // 캐시 무효화 (편집 후 ISR 캐시 삭제) - majorId 사용
  await invalidatePageCache(db, {
    majorId: majorId,
    pageType: 'major'
  })
  
  
  return {
    success: true,
    revisionId: revision.id
  }
}

/**
 * HowTo 편집
 * 
 * @param db D1 데이터베이스
 * @param slug HowTo slug
 * @param payload 편집 페이로드
 * @returns 성공 여부 및 revision ID
 */
export async function editHowTo(
  db: D1Database,
  slug: string,
  payload: EditHowToPayload
): Promise<{ success: boolean; revisionId: number }> {
  // HowTo 존재 확인
  const howto = await db.prepare(`
    SELECT * FROM pages 
    WHERE slug = ? AND page_type = 'guide' AND status = 'published'
  `).bind(slug).first()
  
  if (!howto) {
    throw new Error('HOWTO_NOT_FOUND')
  }
  
  // 익명 편집인 경우 제한 체크 (IP 해시가 있는 경우만)
  if (!payload.userId && payload.ipHash) {
    const limitCheck = await checkAnonymousEditLimit(db, 'howto', slug, payload.ipHash)
    if (!limitCheck.allowed) {
      throw new Error('DAILY_LIMIT_REACHED')
    }
  }
  
  // 편집자 정보 설정
  let editorId: string | null = null
  let editorType: 'anonymous' | 'user' | 'expert' | 'admin' | 'system' = 'anonymous'
  let editorName: string | null = null
  let passwordHash: string | null = null
  let anonymousNumber: number | null = null
  
  if (payload.userId) {
    // 로그인 사용자 편집
    editorId = payload.userId
    editorType = payload.editorType ?? 'user'
    
    const user = await db.prepare('SELECT username FROM users WHERE id = ?')
      .bind(payload.userId)
      .first<{ username: string }>()
    
    editorName = user?.username ?? `User ${payload.userId}`
  } else if (payload.ipHash) {
    // 익명 편집 (IP 해시만으로 식별, 비밀번호 없음)
    editorType = 'anonymous'
    anonymousNumber = await getNextAnonymousNumber(db, 'howto', slug, payload.ipHash)
    editorName = `익명 ${anonymousNumber}`
    // 비밀번호는 없음 (IP 해시만으로 식별)
    passwordHash = null
  } else {
    // IP 해시도 없는 경우 (로컬 개발 환경 등)
    // 기본 익명 사용자로 처리
    editorType = 'anonymous'
    editorName = '익명 사용자'
    passwordHash = null
  }
  
  // Content 길이 검증
  if (!payload.content || payload.content.length === 0) {
    throw new Error('CONTENT_REQUIRED')
  }
  
  if (payload.content.length > 10 * 1024 * 1024) {
    throw new Error('CONTENT_TOO_LONG')
  }
  
  // content 파싱 (JSON 문자열)
  let contentData: any
  try {
    contentData = JSON.parse(payload.content)
  } catch {
    throw new Error('INVALID_CONTENT_FORMAT')
  }
  
  // Content 정리 (XSS 방지)
  const sanitizedContent = sanitizeContent(payload.content)
  
  // 이전 content 저장
  const previousContent = howto.content as string | null
  
  // 스냅샷 생성 (HowTo는 content 필드만 저장)
  const snapshot = {
    content: sanitizedContent,
    contentData,
    slug,
    title: howto.title as string,
    summary: howto.summary as string | null
  }
  
  // 보상 트랜잭션 패턴: revision 먼저 생성
  let revision: any
  try {
    revision = await createRevision(db, {
      entityType: 'howto',
      entityId: slug,
      dataSnapshot: snapshot,
      previousValues: { content: previousContent },
      editorId,
      editorType,
      editorName,
      passwordHash,
      anonymousNumber,
      ipHash: payload.ipHash ?? null,
      changeType: 'edit',
      changeSummary: payload.changeSummary ?? 'Edited HowTo guide',
      changedFields: ['content'],
      sourceUrl: payload.source ?? null,
      sourceType: null,
      storeFullSnapshot: false  // 변경사항만 저장
    })
  } catch (error) {
    console.error('[editHowTo] Failed to create revision:', error)
    throw new Error('REVISION_CREATION_FAILED')
  }
  
  // pages 테이블 업데이트 (실패 시 revision 롤백)
  try {
    await db.prepare(`
      UPDATE pages 
      SET content = ?, updated_at = CURRENT_TIMESTAMP
      WHERE slug = ? AND page_type = 'guide'
    `).bind(sanitizedContent, slug).run()
  } catch (error) {
    // 실패 시 생성된 revision 삭제
    console.error('[editHowTo] Failed to update pages table, rolling back revision:', error)
    try {
      await db.prepare(`DELETE FROM page_revisions WHERE id = ?`).bind(revision.id).run()
    } catch (rollbackError) {
      console.error('[editHowTo] Failed to rollback revision:', rollbackError)
    }
    throw new Error('DATA_UPDATE_FAILED')
  }
  
  // 익명 편집 카운트 증가 (IP 해시가 있는 경우만)
  if (!payload.userId && payload.ipHash) {
    await incrementAnonymousEditCount(db, 'howto', slug, payload.ipHash)
  }
  
  // 캐시 무효화 (편집 후 ISR 캐시 삭제)
  await invalidatePageCache(db, {
    slug,
    pageType: 'guide'
  })
  
  return {
    success: true,
    revisionId: revision.id
  }
}

/**
 * API 데이터 편집 (원본 보존)
 * 
 * API 원본 데이터를 편집하지만, revision으로 원본이 보존됨
 * 
 * @param db D1 데이터베이스
 * @param entityType 엔티티 타입 ('job' 또는 'major')
 * @param entityId 엔티티 ID
 * @param payload 편집 페이로드
 * @returns 성공 여부 및 revision ID
 */
export async function editApiData(
  db: D1Database,
  entityType: 'job' | 'major',
  entityId: string,
  payload: EditApiDataPayload
): Promise<{ success: boolean; revisionId: number }> {
  // editJob 또는 editMajor와 동일한 로직
  // API 데이터 편집은 일반 편집과 동일하게 처리됨
  // (revision으로 원본이 보존되므로)
  
  if (entityType === 'job') {
    return editJob(db, entityId, payload)
  } else if (entityType === 'major') {
    return editMajor(db, entityId, payload)
  }
  
  throw new Error('INVALID_ENTITY_TYPE')
}


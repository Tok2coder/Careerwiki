/**
 * Revision Service
 * 
 * 편집 시스템의 버전 히스토리 관리 서비스
 * - Revision 생성, 조회, 되돌리기 기능 제공
 * - 전체 데이터 스냅샷 저장 및 복원
 */

import type { D1Database } from '@cloudflare/workers-types'
import { invalidatePageCache } from '../utils/page-cache'

/**
 * Revision 레코드 타입
 */
export interface RevisionRecord {
  id: number
  entityType: 'job' | 'major' | 'howto' | 'guide'
  entityId: string
  revisionNumber: number
  isCurrent: boolean
  editorId: string | null
  editorType: 'anonymous' | 'user' | 'expert' | 'admin' | 'system'
  editorName: string | null
  editorPictureUrl: string | null  // 편집자 프로필 이미지 (custom > OAuth > null)
  passwordHash: string | null
  anonymousNumber: number | null
  ipHash: string | null
  changeType: 'initial' | 'edit' | 'restore' | 'merge'
  changeSummary: string | null
  changedFields: string[] | null
  dataSnapshot: string  // JSON 문자열
  sourceUrl: string | null
  sourceType: 'website' | 'academic' | 'government' | 'news' | 'other' | null
  createdAt: string
}

/**
 * Revision 생성 페이로드
 */
export interface CreateRevisionPayload {
  entityType: 'job' | 'major' | 'howto'
  entityId: string
  dataSnapshot: any  // 병합된 전체 데이터 객체 또는 변경사항만 (최적화)
  previousValues?: Record<string, any>  // 변경 전 값들 (변경사항만 저장 시)
  editorId?: string | null
  editorType: 'anonymous' | 'user' | 'expert' | 'admin' | 'system'
  editorName?: string | null
  passwordHash?: string | null
  anonymousNumber?: number | null
  ipHash?: string | null
  changeType: 'initial' | 'edit' | 'restore' | 'merge'
  changeSummary?: string | null
  changedFields?: string[]
  sourceUrl?: string | null
  sourceType?: 'website' | 'academic' | 'government' | 'news' | 'other' | null
  // 최적화 옵션: 전체 스냅샷 대신 변경사항만 저장할지 여부
  storeFullSnapshot?: boolean  // true면 전체 스냅샷, false면 변경사항만
  fullDataForCheckpoint?: Record<string, any>  // 체크포인트용 전체 데이터 (10번째 편집마다 자동 전체 스냅샷)
}

/**
 * DB 행을 RevisionRecord로 변환
 */
function mapRowToRevision(row: any): RevisionRecord {
  let changedFields: string[] | null = null
  if (row.changed_fields && typeof row.changed_fields === 'string') {
    try {
      const parsed = JSON.parse(row.changed_fields)
      changedFields = Array.isArray(parsed) ? parsed : null
    } catch {
      changedFields = null
    }
  }

  // 프로필 이미지 우선순위: custom > OAuth > null
  const editorPictureUrl = row.editor_custom_picture_url || row.editor_picture_url || null

  return {
    id: Number(row.id),
    entityType: row.entity_type as RevisionRecord['entityType'],
    entityId: String(row.entity_id),
    revisionNumber: Number(row.revision_number ?? 0),
    isCurrent: Number(row.is_current ?? 0) === 1,
    editorId: typeof row.editor_id === 'string' ? row.editor_id : null,
    editorType: row.editor_type as RevisionRecord['editorType'],
    editorName: typeof row.editor_name === 'string' ? row.editor_name : null,
    editorPictureUrl,
    passwordHash: typeof row.password_hash === 'string' ? row.password_hash : null,
    anonymousNumber: row.anonymous_number !== null && row.anonymous_number !== undefined ? Number(row.anonymous_number) : null,
    ipHash: typeof row.ip_hash === 'string' ? row.ip_hash : null,
    changeType: row.change_type as RevisionRecord['changeType'],
    changeSummary: typeof row.change_summary === 'string' ? row.change_summary : null,
    changedFields,
    dataSnapshot: typeof row.data_snapshot === 'string' ? row.data_snapshot : '{}',
    sourceUrl: typeof row.source_url === 'string' ? row.source_url : null,
    sourceType: row.source_type as RevisionRecord['sourceType'],
    createdAt: typeof row.created_at === 'string' ? row.created_at : new Date().toISOString()
  }
}

/**
 * 다음 Revision 번호 조회
 * 
 * @param db D1 데이터베이스
 * @param entityType 엔티티 타입
 * @param entityId 엔티티 ID
 * @returns 다음 revision 번호 (1부터 시작)
 */
export async function getNextRevisionNumber(
  db: D1Database,
  entityType: 'job' | 'major' | 'howto',
  entityId: string
): Promise<number> {
  const result = await db
    .prepare(`
      SELECT MAX(revision_number) as max_number
      FROM page_revisions
      WHERE entity_type = ? AND entity_id = ?
    `)
    .bind(entityType, entityId)
    .first<{ max_number: number | null }>()
  
  const maxNumber = result?.max_number ?? 0
  return maxNumber + 1
}

/**
 * 현재 활성 Revision 조회
 * 
 * @param db D1 데이터베이스
 * @param entityType 엔티티 타입
 * @param entityId 엔티티 ID
 * @returns 현재 활성 revision 또는 null
 */
export async function getCurrentRevision(
  db: D1Database,
  entityType: 'job' | 'major' | 'howto',
  entityId: string
): Promise<RevisionRecord | null> {
  const row = await db
    .prepare(`
      SELECT *
      FROM page_revisions
      WHERE entity_type = ? 
        AND entity_id = ? 
        AND is_current = 1
      ORDER BY revision_number DESC
      LIMIT 1
    `)
    .bind(entityType, entityId)
    .first()
  
  if (!row) {
    return null
  }
  
  return mapRowToRevision(row)
}

/**
 * Revision의 스냅샷에서 전체 데이터 재구성
 * 
 * 변경사항만 저장된 revision들을 순회하여 전체 데이터를 재구성
 * 
 * @param db D1 데이터베이스
 * @param entityType 엔티티 타입
 * @param entityId 엔티티 ID
 * @param targetRevisionNumber 목표 revision 번호
 * @returns 재구성된 전체 데이터
 */
export async function reconstructFullData(
  db: D1Database,
  entityType: 'job' | 'major' | 'howto',
  entityId: string,
  targetRevisionNumber: number
): Promise<any> {
  // 모든 revision 조회 (초기 revision부터 목표 revision까지)
  const revisions = await db
    .prepare(`
      SELECT * FROM page_revisions
      WHERE entity_type = ? AND entity_id = ?
      AND revision_number <= ?
      ORDER BY revision_number ASC
    `)
    .bind(entityType, entityId, targetRevisionNumber)
    .all()
  
  if (!revisions.results || revisions.results.length === 0) {
    throw new Error('REVISION_NOT_FOUND')
  }
  
  let fullData: any = {}
  
  // 초기 revision부터 순회하며 데이터 재구성
  for (const row of revisions.results) {
    const revision = mapRowToRevision(row)
    
    try {
      const snapshot = JSON.parse(revision.dataSnapshot)
      
      // 전체 스냅샷인 경우
      if (snapshot.changedFields === undefined) {
        fullData = snapshot
      } else {
        // 변경사항만 저장된 경우: 이전 값들을 새 값으로 덮어쓰기
        if (snapshot.changes) {
          fullData = { ...fullData, ...snapshot.changes }
        }
      }
    } catch (error) {
      // 파싱 실패 시 이전 데이터 유지
    }
  }
  
  return fullData
}

/**
 * 현재 활성 Revision의 전체 데이터 조회
 * 
 * 변경사항만 저장된 경우 전체 데이터를 재구성하여 반환
 * 
 * @param db D1 데이터베이스
 * @param entityType 엔티티 타입
 * @param entityId 엔티티 ID
 * @returns 전체 데이터 객체 또는 null
 */
export async function getCurrentRevisionFullData(
  db: D1Database,
  entityType: 'job' | 'major' | 'howto',
  entityId: string
): Promise<any | null> {
  const currentRevision = await getCurrentRevision(db, entityType, entityId)
  
  if (!currentRevision) {
    return null
  }
  
  try {
    const snapshot = JSON.parse(currentRevision.dataSnapshot)
    
    // 전체 스냅샷인 경우
    if (snapshot.changedFields === undefined) {
      return snapshot
    }
    
    // 변경사항만 저장된 경우 전체 데이터 재구성
    return await reconstructFullData(db, entityType, entityId, currentRevision.revisionNumber)
  } catch (error) {
    return null
  }
}

/**
 * Revision 목록 조회
 * 
 * @param db D1 데이터베이스
 * @param entityType 엔티티 타입
 * @param entityId 엔티티 ID
 * @param options 페이지네이션 옵션
 * @returns Revision 목록 및 전체 개수
 */
export async function listRevisions(
  db: D1Database,
  entityType: 'job' | 'major' | 'howto',
  entityId: string,
  options: { limit?: number; offset?: number } = {}
): Promise<{ revisions: RevisionRecord[]; total: number }> {
  const limit = options.limit ?? 20
  const offset = options.offset ?? 0
  
  // 전체 개수 조회
  const countResult = await db
    .prepare(`
      SELECT COUNT(*) as total
      FROM page_revisions
      WHERE entity_type = ? AND entity_id = ?
    `)
    .bind(entityType, entityId)
    .first<{ total: number }>()
  
  const total = countResult ? Number(countResult.total) : 0
  
  // Revision 목록 조회 (최신순, 편집자 프로필 이미지 포함)
  const rows = await db
    .prepare(`
      SELECT pr.*, 
             u.picture_url AS editor_picture_url, 
             u.custom_picture_url AS editor_custom_picture_url
      FROM page_revisions pr
      LEFT JOIN users u ON u.id = pr.editor_id
      WHERE pr.entity_type = ? AND pr.entity_id = ?
      ORDER BY pr.revision_number DESC
      LIMIT ? OFFSET ?
    `)
    .bind(entityType, entityId, limit, offset)
    .all()
  
  const revisions = Array.isArray(rows.results) 
    ? rows.results.map(mapRowToRevision)
    : []
  
  return { revisions, total }
}

/**
 * 특정 Revision 조회
 * 
 * @param db D1 데이터베이스
 * @param revisionId Revision ID
 * @returns Revision 레코드 또는 null
 */
export async function getRevisionById(
  db: D1Database,
  revisionId: number
): Promise<RevisionRecord | null> {
  const row = await db
    .prepare('SELECT * FROM page_revisions WHERE id = ?')
    .bind(revisionId)
    .first()
  
  if (!row) {
    return null
  }
  
  return mapRowToRevision(row)
}

/**
 * Revision 생성
 * 
 * 새 revision을 생성하고 이전 revision의 is_current를 0으로 업데이트
 * D1 batch를 사용하여 원자적 처리
 * 
 * @param db D1 데이터베이스
 * @param payload Revision 생성 페이로드
 * @returns 생성된 Revision 레코드
 */
export async function createRevision(
  db: D1Database,
  payload: CreateRevisionPayload
): Promise<RevisionRecord> {
  // 다음 revision 번호 조회
  const revisionNumber = await getNextRevisionNumber(
    db,
    payload.entityType,
    payload.entityId
  )
  
  // 최적화: 전체 스냅샷 vs 변경사항만 저장
  // - initial, restore: 항상 전체 스냅샷
  // - edit: 기본적으로 변경사항만 저장 (storeFullSnapshot=true면 전체)
  const shouldStoreFull = payload.storeFullSnapshot ??
    (payload.changeType === 'initial' || payload.changeType === 'restore')

  // 10번째 편집마다 자동 체크포인트 (전체 스냅샷 강제 저장)
  const isCheckpoint = !shouldStoreFull
    && payload.changeType === 'edit'
    && revisionNumber > 0
    && revisionNumber % 10 === 0

  let dataSnapshotJson: string
  if (shouldStoreFull || isCheckpoint) {
    // 전체 스냅샷 저장 (체크포인트: fullDataForCheckpoint 우선 사용)
    const snapshotData = isCheckpoint && payload.fullDataForCheckpoint
      ? payload.fullDataForCheckpoint
      : payload.dataSnapshot
    dataSnapshotJson = JSON.stringify(snapshotData)
  } else {
    // 변경사항만 저장 (용량 최적화)
    const changeSnapshot = {
      changedFields: payload.changedFields ?? [],
      changes: {} as Record<string, any>,
      previousValues: payload.previousValues ?? {}
    }
    
    // 변경된 필드의 새 값만 저장
    if (payload.changedFields && payload.dataSnapshot) {
      for (const field of payload.changedFields) {
        if (payload.dataSnapshot[field] !== undefined) {
          changeSnapshot.changes[field] = payload.dataSnapshot[field]
        }
      }
    }
    
    dataSnapshotJson = JSON.stringify(changeSnapshot)
  }
  
  // changed_fields를 JSON 배열 문자열로 변환
  const changedFieldsJson = payload.changedFields 
    ? JSON.stringify(payload.changedFields)
    : null
  
  // D1 batch를 사용하여 원자적 처리
  // 1. 이전 revision의 is_current를 0으로 업데이트 (모든 is_current = 1인 revision)
  // 2. 새 revision 생성 (is_current = 1)
  // 🆕 여러 개의 is_current = 1이 있을 수 있으므로 모두 0으로 업데이트
  const batch = db.batch([
    // 이전 revision의 is_current 업데이트 (모든 is_current = 1인 revision을 0으로)
    db.prepare(`
      UPDATE page_revisions
      SET is_current = 0
      WHERE entity_type = ? 
        AND entity_id = ? 
        AND is_current = 1
    `).bind(payload.entityType, payload.entityId),
    
    // 새 revision 생성
    db.prepare(`
      INSERT INTO page_revisions (
        page_id, entity_type, entity_id, revision_number, is_current,
        editor_id, editor_type, editor_name,
        password_hash, anonymous_number, ip_hash,
        change_type, change_summary, changed_fields,
        data_snapshot, source_url, source_type
      )
      VALUES (NULL, ?, ?, ?, 1, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    `).bind(
      payload.entityType,
      payload.entityId,
      revisionNumber,
      payload.editorId ?? null,
      payload.editorType,
      payload.editorName ?? null,
      payload.passwordHash ?? null,
      payload.anonymousNumber ?? null,
      payload.ipHash ?? null,
      payload.changeType,
      payload.changeSummary ?? null,
      changedFieldsJson,
      dataSnapshotJson,
      payload.sourceUrl ?? null,
      payload.sourceType ?? null
    )
  ])
  
  await batch
  
  // 생성된 revision 조회
  const created = await getCurrentRevision(
    db,
    payload.entityType,
    payload.entityId
  )
  
  if (!created) {
    throw new Error('Failed to create revision')
  }
  
  return created
}

/**
 * 되돌리기 (특정 Revision으로 복원)
 * 
 * 지정된 revision의 data_snapshot을 현재 데이터로 복원하고 새 revision 생성
 * 
 * @param db D1 데이터베이스
 * @param revisionId 복원할 revision ID
 * @param userId 복원 요청자 ID (권한 확인용)
 * @param password 익명 편집인 경우 비밀번호
 * @param username 사용자 닉네임 (역사에 표시)
 * @returns 복원 후 생성된 새 Revision 레코드
 */
export async function restoreRevision(
  db: D1Database,
  revisionId: number,
  userId?: string | null,
  password?: string | null,
  username?: string | null
): Promise<RevisionRecord> {
  // 복원할 revision 조회
  const targetRevision = await getRevisionById(db, revisionId)
  
  if (!targetRevision) {
    throw new Error('REVISION_NOT_FOUND')
  }
  
  // 권한 확인: 엔티티 타입에 따라 다른 정책 적용
  // - job, major: 누구나 되돌리기 가능 (위키 스타일)
  // - howto: 작성자 본인 또는 관리자만 가능
  if (targetRevision.entityType === 'howto') {
    // 하우투는 작성자 본인 또는 관리자만 되돌리기 가능
    if (targetRevision.editorId) {
      if (!userId || (userId !== targetRevision.editorId && !userId.startsWith('admin'))) {
        throw new Error('UNAUTHORIZED')
      }
    }
  }
  // job, major는 권한 확인 없이 누구나 되돌리기 가능
  
  // 현재 활성 revision의 스냅샷 저장 (되돌리기 전 상태 보존)
  const currentRevision = await getCurrentRevision(
    db,
    targetRevision.entityType,
    targetRevision.entityId
  )
  
  // data_snapshot 파싱 및 전체 데이터 재구성
  let restoredData: any
  try {
    const snapshot = JSON.parse(targetRevision.dataSnapshot)
    
    // 변경사항만 저장된 경우 전체 데이터 재구성 필요
    if (snapshot.changedFields !== undefined) {
      restoredData = await reconstructFullData(
        db,
        targetRevision.entityType,
        targetRevision.entityId,
        targetRevision.revisionNumber
      )
    } else {
      // 전체 스냅샷인 경우 그대로 사용
      restoredData = snapshot
    }
  } catch (error) {
    throw new Error('INVALID_SNAPSHOT')
  }
  
  // 실제 데이터 복원 (jobs/majors/pages 테이블 업데이트)
  // 🆕 복원 시: data_snapshot에 저장된 병합된 데이터를 user_contributed_json으로 저장
  // api_data_json은 유지하여 원본 데이터 보존
  // 이렇게 하면 user_contributed_json이 api_data_json보다 우선순위를 가지므로 복원된 데이터가 표시됨
  if (targetRevision.entityType === 'job') {
    // 복원된 데이터를 user_contributed_json으로 저장
    // 메타데이터 필드 제거
    const userContributedData: Record<string, any> = {}
    for (const [key, value] of Object.entries(restoredData)) {
      // 메타데이터 필드는 제외
      if (!key.startsWith('_') && key !== 'id' && key !== 'name') {
        userContributedData[key] = value
      }
    }
    
    const now = Date.now()
    await db.prepare(`
      UPDATE jobs 
      SET user_contributed_json = ?, merged_profile_json = ?, user_last_updated_at = ?
      WHERE id = ?
    `).bind(
      JSON.stringify(userContributedData),
      JSON.stringify(restoredData),
      now,
      targetRevision.entityId
    ).run()
    
    // api_data_json과 admin_data_json은 유지 (원본 데이터 보존)
  } else if (targetRevision.entityType === 'major') {
    // 전공도 동일한 로직 적용
    const userContributedData: Record<string, any> = {}
    for (const [key, value] of Object.entries(restoredData)) {
      if (!key.startsWith('_') && key !== 'id' && key !== 'name') {
        userContributedData[key] = value
      }
    }
    
    const now = Date.now()
    await db.prepare(`
      UPDATE majors 
      SET user_contributed_json = ?, merged_profile_json = ?, user_last_updated_at = ?
      WHERE id = ?
    `).bind(
      JSON.stringify(userContributedData),
      JSON.stringify(restoredData),
      now,
      targetRevision.entityId
    ).run()
  } else if (targetRevision.entityType === 'howto') {
    // HowTo 데이터 복원
    const content = restoredData.content || restoredData
    await db.prepare(`
      UPDATE pages 
      SET content = ?, updated_at = CURRENT_TIMESTAMP
      WHERE slug = ? AND page_type = 'guide'
    `).bind(typeof content === 'string' ? content : JSON.stringify(content), targetRevision.entityId).run()
  }
  
  // 새 revision 생성 (change_type='restore')
  const editorDisplayName = username || (userId ? `User ${userId}` : '익명')
  const restoredRevision = await createRevision(db, {
    entityType: targetRevision.entityType,
    entityId: targetRevision.entityId,
    dataSnapshot: restoredData,
    editorId: userId ?? null,
    editorType: userId ? 'user' : 'anonymous',
    editorName: editorDisplayName,
    changeType: 'restore',
    changeSummary: `r${targetRevision.revisionNumber} 버전으로 복원`,
    changedFields: targetRevision.changedFields ?? []
  })
  
  // 캐시 무효화 (복원 후 ISR 캐시 삭제)
  await invalidatePageCache(db, {
    jobId: targetRevision.entityType === 'job' ? targetRevision.entityId : undefined,
    majorId: targetRevision.entityType === 'major' ? targetRevision.entityId : undefined,
    slug: targetRevision.entityType === 'howto' ? targetRevision.entityId : undefined,
    pageType: targetRevision.entityType === 'howto' ? 'guide' : targetRevision.entityType
  })
  
  return restoredRevision
}


/**
 * Job Storage Service
 * D1 데이터베이스를 사용한 직업 데이터 영구 저장 및 관리
 */

import type { UnifiedJobDetail } from '../types/unifiedProfiles'

// Web Crypto API를 사용한 해시 생성 (Cloudflare Workers 호환)
async function generateDataHash(data: any): Promise<string> {
  const normalized = JSON.stringify(data, Object.keys(data).sort())
  const encoder = new TextEncoder()
  const dataBuffer = encoder.encode(normalized)
  const hashBuffer = await crypto.subtle.digest('SHA-256', dataBuffer)
  const hashArray = Array.from(new Uint8Array(hashBuffer))
  return hashArray.map(b => b.toString(16).padStart(2, '0')).join('')
}

// 변경된 필드 감지
function detectChangedFields(oldData: any, newData: any): string[] {
  const changedFields: string[] = []
  const fields = ['name', 'summary', 'salary', 'duties', 'abilities', 'knowledge', 
                  'relatedJobs', 'relatedMajors', 'relatedCertificates']
  
  for (const field of fields) {
    const oldValue = JSON.stringify(oldData?.[field])
    const newValue = JSON.stringify(newData?.[field])
    if (oldValue !== newValue) {
      changedFields.push(field)
    }
  }
  
  return changedFields
}

// 저장된 직업 데이터 조회 (API + User + Admin 데이터 병합)
export async function getStoredJob(db: D1Database, jobId: string): Promise<UnifiedJobDetail | null> {
  const result = await db.prepare(
    'SELECT * FROM jobs WHERE id = ? AND is_active = 1'
  ).bind(jobId).first()
  
  if (!result) {
    return null
  }
  
  // 기본 API 데이터
  const apiData = result.api_data_json ? JSON.parse(result.api_data_json as string) : {}
  
  // 사용자 기여 데이터 병합 (API 데이터보다 우선)
  const userData = result.user_contributed_json ? JSON.parse(result.user_contributed_json as string) : {}
  
  // 운영진 데이터 병합 (최우선)
  const adminData = result.admin_data_json ? JSON.parse(result.admin_data_json as string) : {}
  
  // 데이터 병합 (admin > user > api 순서로 우선순위)
  return {
    ...apiData,
    ...userData,
    ...adminData,
    _meta: {
      apiLastFetched: result.api_last_fetched_at,
      apiLastUpdated: result.api_last_updated_at,
      userLastUpdated: result.user_last_updated_at,
      adminLastUpdated: result.admin_last_updated_at
    }
  } as UnifiedJobDetail
}

// API 데이터만 업데이트 (사용자/운영진 데이터는 보존)
export async function updateApiData(
  db: D1Database, 
  jobId: string, 
  apiData: UnifiedJobDetail,
  options: { forceUpdate?: boolean } = {}
): Promise<{ updated: boolean; changedFields: string[] }> {
  const now = Date.now()
  const newHash = await generateDataHash(apiData)
  
  // 기존 데이터 조회
  const existing = await db.prepare(
    'SELECT api_data_json, api_data_hash FROM jobs WHERE id = ?'
  ).bind(jobId).first()
  
  let changedFields: string[] = []
  let shouldUpdate = options.forceUpdate || false
  
  if (existing) {
    const oldHash = existing.api_data_hash as string
    
    if (oldHash !== newHash) {
      // 데이터 변경됨
      const oldData = JSON.parse(existing.api_data_json as string)
      changedFields = detectChangedFields(oldData, apiData)
      shouldUpdate = true
    }
  } else {
    // 새 데이터
    shouldUpdate = true
  }
  
  if (shouldUpdate) {
    await db.prepare(`
      INSERT INTO jobs (
        id, careernet_id, goyong24_id, name, 
        api_data_json, api_data_hash, 
        api_last_fetched_at, api_last_updated_at, created_at
      )
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
      ON CONFLICT(id) DO UPDATE SET
        api_data_json = excluded.api_data_json,
        api_data_hash = excluded.api_data_hash,
        api_last_fetched_at = excluded.api_last_fetched_at,
        api_last_updated_at = excluded.api_last_updated_at
    `).bind(
      jobId,
      apiData.sourceIds?.careernet ?? null,
      apiData.sourceIds?.goyong24 ?? null,
      apiData.name ?? '',
      JSON.stringify(apiData),
      newHash,
      now,
      now,
      existing ? (existing as any).created_at : now
    ).run()
    
    // 로그 기록
    if (changedFields.length > 0) {
      await db.prepare(`
        INSERT INTO update_logs (job_id, update_type, changed_fields, new_hash, updated_at, updated_by)
        VALUES (?, ?, ?, ?, ?, ?)
      `).bind(
        jobId,
        'api',
        JSON.stringify(changedFields),
        newHash,
        now,
        'cron'
      ).run()
    }
  } else {
    // 변경 없음, last_fetched_at만 업데이트
    await db.prepare(
      'UPDATE jobs SET api_last_fetched_at = ? WHERE id = ?'
    ).bind(now, jobId).run()
  }
  
  return { updated: shouldUpdate, changedFields }
}

// 사용자 기여 데이터 저장 (API 데이터와 독립적)
export async function saveUserContribution(
  db: D1Database,
  jobId: string,
  userData: any,
  userId: string
): Promise<void> {
  const now = Date.now()
  
  await db.prepare(`
    UPDATE jobs 
    SET user_contributed_json = ?, user_last_updated_at = ?
    WHERE id = ?
  `).bind(JSON.stringify(userData), now, jobId).run()
  
  // 로그 기록
  await db.prepare(`
    INSERT INTO update_logs (job_id, update_type, updated_at, updated_by)
    VALUES (?, ?, ?, ?)
  `).bind(jobId, 'user', now, `user:${userId}`).run()
}

// 운영진 데이터 저장 (최우선 데이터)
export async function saveAdminData(
  db: D1Database,
  jobId: string,
  adminData: any,
  adminId: string
): Promise<void> {
  const now = Date.now()
  
  await db.prepare(`
    UPDATE jobs 
    SET admin_data_json = ?, admin_last_updated_at = ?
    WHERE id = ?
  `).bind(JSON.stringify(adminData), now, jobId).run()
  
  // 로그 기록
  await db.prepare(`
    INSERT INTO update_logs (job_id, update_type, updated_at, updated_by)
    VALUES (?, ?, ?, ?)
  `).bind(jobId, 'admin', now, `admin:${adminId}`).run()
}

// 모든 활성 직업 ID 조회 (Cron에서 사용)
export async function getAllActiveJobIds(db: D1Database): Promise<string[]> {
  const results = await db.prepare(
    'SELECT id FROM jobs WHERE is_active = 1 ORDER BY name'
  ).all()
  
  return results.results.map((row: any) => row.id)
}

// 최근 업데이트 로그 조회
export async function getRecentUpdates(
  db: D1Database, 
  limit: number = 50
): Promise<any[]> {
  const results = await db.prepare(`
    SELECT l.*, j.name as job_name
    FROM update_logs l
    LEFT JOIN jobs j ON l.job_id = j.id
    ORDER BY l.updated_at DESC
    LIMIT ?
  `).bind(limit).all()
  
  return results.results.map((row: any) => ({
    jobId: row.job_id,
    jobName: row.job_name,
    updateType: row.update_type,
    changedFields: row.changed_fields ? JSON.parse(row.changed_fields) : [],
    updatedAt: new Date(row.updated_at).toISOString(),
    updatedBy: row.updated_by
  }))
}

/**
 * Seed Work24 Majors
 * 
 * Work24 학과 API를 사용하여 major_sources 테이블에 상세 데이터 시딩
 * - 목록 API: keyword 검색으로 학과 목록 수집
 * - 상세 API: 일반학과(majorGb=1) / 이색학과(majorGb=2) 상세 정보 수집
 */

import type { D1Database } from '@cloudflare/workers-types'
import { 
  fetchGoyong24MajorList, 
  fetchGoyong24MajorDetail, 
  normalizeGoyong24MajorDetail, 
  type EnvWithGoyong24Keys,
  type Goyong24MajorListItem 
} from '../../api/goyong24API'

interface Env extends EnvWithGoyong24Keys {
  DB: D1Database
}

interface SeedProgress {
  total: number
  processed: number
  success: number
  failed: number
  skipped: number
  errors: Array<{ id: string; name: string; error: string }>
  startTime: number
}

interface MajorInfo {
  majorGb: '1' | '2'
  empCurtState1Id: string  // 계열ID
  empCurtState2Id: string  // 학과ID
  name: string             // 학과명
}

function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms))
}

async function createSeedLog(
  db: D1Database,
  seedType: string,
  status: string,
  stats: Partial<SeedProgress>
): Promise<number> {
  const now = Date.now()
  const result = await db.prepare(`
    INSERT INTO seed_logs (
      seed_type, started_at, completed_at, status,
      total_count, success_count, failed_count, skipped_count,
      created_at
    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
  `).bind(
    seedType,
    stats.startTime || now,
    status === 'running' ? null : now,
    status,
    stats.total || 0,
    stats.success || 0,
    stats.failed || 0,
    stats.skipped || 0,
    now
  ).run()
  
  return result.meta.last_row_id as number
}

async function upsertMajorSource(
  db: D1Database,
  data: {
    sourceSystem: 'WORK24_MAJOR'
    sourceKey: string
    sourceType: string
    majorGb?: string
    departmentId?: string
    rawPayload: any
    normalizedPayload: any
  }
): Promise<void> {
  const now = Date.now()
  const rawJson = JSON.stringify(data.rawPayload)
  const normalizedJson = JSON.stringify(data.normalizedPayload)
  
  await db.prepare(`
    INSERT INTO major_sources (
      major_id, source_system, source_key, source_type,
      major_seq, department_cd, track, gubun,
      raw_payload, normalized_payload,
      fetched_at, updated_at, retry_count
    ) VALUES (
      NULL, ?, ?, ?,
      NULL, ?, NULL, ?,
      ?, ?,
      ?, ?, 0
    )
    ON CONFLICT(source_system, source_key) DO UPDATE SET
      raw_payload = excluded.raw_payload,
      normalized_payload = excluded.normalized_payload,
      updated_at = excluded.updated_at
  `).bind(
    data.sourceSystem,
    data.sourceKey,
    data.sourceType,
    data.departmentId || null,
    data.majorGb || null,
    rawJson,
    normalizedJson,
    now,
    now
  ).run()
}

/**
 * 여러 키워드로 학과 목록 수집 (중복 제거)
 */
async function collectMajorList(env: Env): Promise<MajorInfo[]> {
  const keywords = [
    '과',    // 대부분의 학과 포함
    '학',    // ~학부, ~학전공 등
    '부',    // ~학부
    '공',    // 공학, 공과 등
    '전공',  // ~전공
    '계열',  // 계열 학과
  ]
  
  const majorMap = new Map<string, MajorInfo>()
  
  for (const keyword of keywords) {
    try {
      console.log(`  🔍 Searching with keyword: "${keyword}"`)
      
      const response = await fetchGoyong24MajorList({ keyword, srchType: 'K' }, env)
      
      for (const item of response.items) {
        if (!item.empCurtState2Id || !item.knowSchDptNm) continue
        
        // 고유키: 계열ID + 학과ID
        const uniqueKey = `${item.empCurtState1Id}:${item.empCurtState2Id}`
        
        if (!majorMap.has(uniqueKey)) {
          majorMap.set(uniqueKey, {
            majorGb: (item.majorGb === '2' ? '2' : '1') as '1' | '2',
            empCurtState1Id: item.empCurtState1Id,
            empCurtState2Id: item.empCurtState2Id,
            name: item.knowSchDptNm
          })
        }
      }
      
      console.log(`    Found ${response.items.length} items, total unique: ${majorMap.size}`)
      await sleep(300)
      
    } catch (error) {
      console.error(`  ⚠️ Error with keyword "${keyword}":`, error)
    }
  }
  
  return Array.from(majorMap.values())
}

export async function seedWork24Majors(
  db: D1Database,
  env: Env,
  options: {
    limit?: number
    skipExisting?: boolean
  } = {}
): Promise<SeedProgress> {
  console.log('🌱 Seeding Work24 Majors (with Detail API)...')
  
  const progress: SeedProgress = {
    total: 0,
    processed: 0,
    success: 0,
    failed: 0,
    skipped: 0,
    errors: [],
    startTime: Date.now()
  }
  
  const seedLogId = await createSeedLog(db, 'WORK24_MAJOR_DETAIL', 'running', progress)
  
  try {
    // Step 1: 목록 API로 학과 정보 수집
    console.log('📋 Step 1: Collecting major list via keyword search...')
    const allMajors = await collectMajorList(env)
    
    // Limit 적용
    const majorsToProcess = options.limit ? allMajors.slice(0, options.limit) : allMajors
    progress.total = majorsToProcess.length
    
    console.log(`📊 Found ${allMajors.length} unique majors, processing ${progress.total}`)
    
    // Step 2: 각 학과의 상세 API 호출
    console.log('📋 Step 2: Fetching detail for each major...')
    
    for (const major of majorsToProcess) {
      progress.processed++
      
      if (progress.processed % 20 === 0) {
        console.log(`📊 Progress: ${progress.processed}/${progress.total} (Success: ${progress.success}, Failed: ${progress.failed})`)
      }
      
      try {
        // skipExisting 옵션: 이미 있는 소스 스킵
        if (options.skipExisting) {
          const sourceKey = `WORK24_MAJOR:${major.empCurtState1Id}:${major.empCurtState2Id}`
          const existing = await db.prepare(
            'SELECT id FROM major_sources WHERE source_key = ?'
          ).bind(sourceKey).first()
          
          if (existing) {
            progress.skipped++
            continue
          }
        }
        
        // 상세 API 호출
        const detail = await fetchGoyong24MajorDetail({
          majorGb: major.majorGb,
          empCurtState1Id: major.empCurtState1Id,
          empCurtState2Id: major.empCurtState2Id
        }, env)
        
        if (!detail) {
          throw new Error('API returned null')
        }
        
        // 정규화
        const normalized = normalizeGoyong24MajorDetail(detail)
        
        // 저장
        await upsertMajorSource(db, {
          sourceSystem: 'WORK24_MAJOR',
          sourceKey: `WORK24_MAJOR:${major.empCurtState1Id}:${major.empCurtState2Id}`,
          sourceType: major.majorGb === '2' ? 'DETAIL_SPECIAL' : 'DETAIL_GENERAL',
          majorGb: major.majorGb,
          departmentId: major.empCurtState1Id,
          rawPayload: detail,
          normalizedPayload: normalized
        })
        
        progress.success++
        await sleep(300)
        
      } catch (error) {
        const errorMessage = error instanceof Error ? error.message : String(error)
        console.error(`  ❌ ${major.name} (${major.empCurtState2Id}): ${errorMessage}`)
        
        progress.failed++
        progress.errors.push({
          id: `${major.empCurtState1Id}:${major.empCurtState2Id}`,
          name: major.name,
          error: errorMessage
        })
        
        await sleep(300)
      }
    }
    
    await createSeedLog(db, 'WORK24_MAJOR_DETAIL', 'completed', progress)
    
    console.log('\n✅ Work24 Major Seeding Complete')
    console.log(`   Total: ${progress.total}`)
    console.log(`   Success: ${progress.success}`)
    console.log(`   Failed: ${progress.failed}`)
    console.log(`   Skipped: ${progress.skipped}`)
    
    return progress
    
  } catch (error) {
    console.error('❌ Fatal error during seeding:', error)
    await createSeedLog(db, 'WORK24_MAJOR_DETAIL', 'failed', progress)
    throw error
  }
}

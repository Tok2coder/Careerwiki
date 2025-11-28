/**
 * Seed Work24 Majors from CSV (Direct Detail API call)
 * 
 * CSV에서 계열ID, 학과ID를 추출하여 상세 API를 직접 호출합니다.
 * - 일반학과 (majorGb=1): 계열ID 1-6
 * - 이색학과 (majorGb=2): 계열ID A001-A007
 */

import type { D1Database } from '@cloudflare/workers-types'
import { fetchGoyong24MajorDetail, normalizeGoyong24MajorDetail, type EnvWithGoyong24Keys } from '../../api/goyong24API'
import * as fs from 'fs'
import * as path from 'path'

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

interface CSVMajorEntry {
  deptId: string       // 계열ID (1-6 또는 A001-A007)
  majorId: string      // 학과ID
  majorGb: '1' | '2'   // 일반학과=1, 이색학과=2
  majorName: string    // 학과명
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
 * CSV 파일에서 계열ID, 학과ID, 학과명을 추출합니다.
 * - 계열ID가 숫자(1-6)면 일반학과 (majorGb=1)
 * - 계열ID가 A로 시작하면 이색학과 (majorGb=2)
 */
function parseCSV(filePath: string): CSVMajorEntry[] {
  const content = fs.readFileSync(filePath, 'utf-8')
  const lines = content.split('\n')
  
  const majors: CSVMajorEntry[] = []
  
  for (let i = 3; i < lines.length; i++) {  // Skip header rows
    const line = lines[i].trim()
    if (!line) continue
    
    // CSV 라인을 콤마로 분리하되, 따옴표 내의 콤마는 무시
    const columns = parseCSVLine(line)
    if (columns.length < 5) continue
    
    const deptId = columns[0].trim()
    const majorId = columns[1].trim()
    const majorName = columns[4].trim()
    
    // 계열ID와 학과ID가 모두 있어야 함
    if (!deptId || !majorId || !majorName) continue
    
    // 테스트 데이터 제외
    if (majorName === '테스트') continue
    
    // majorGb 결정: 숫자면 일반학과(1), A로 시작하면 이색학과(2)
    const majorGb: '1' | '2' = /^\d+$/.test(deptId) ? '1' : '2'
    
    majors.push({
      deptId,
      majorId,
      majorGb,
      majorName
    })
  }
  
  return majors
}

/**
 * CSV 라인을 파싱합니다. 따옴표로 감싸진 필드 내의 콤마를 처리합니다.
 */
function parseCSVLine(line: string): string[] {
  const result: string[] = []
  let current = ''
  let inQuotes = false
  
  for (let i = 0; i < line.length; i++) {
    const char = line[i]
    
    if (char === '"') {
      inQuotes = !inQuotes
    } else if (char === ',' && !inQuotes) {
      result.push(current)
      current = ''
    } else {
      current += char
    }
  }
  
  result.push(current)
  return result
}

export async function seedWork24MajorsFromCSV(
  db: D1Database,
  env: Env,
  options: {
    limit?: number
    skipExisting?: boolean
  } = {}
): Promise<SeedProgress> {
  console.log('🌱 Seeding Work24 Majors from CSV (Direct Detail API)...')
  
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
    console.log('📋 Step 1: Loading majors from CSV...')
    
    const csvPath = path.join(process.cwd(), 'docs', '계열학과목록.csv')
    const majors = parseCSV(csvPath)
    
    console.log(`📊 Found ${majors.length} majors in CSV`)
    console.log(`   - 일반학과 (majorGb=1): ${majors.filter(m => m.majorGb === '1').length}개`)
    console.log(`   - 이색학과 (majorGb=2): ${majors.filter(m => m.majorGb === '2').length}개`)
    
    const majorsToProcess = options.limit ? majors.slice(0, options.limit) : majors
    progress.total = majorsToProcess.length
    
    console.log(`📦 Step 2: Fetching major details via Detail API...`)
    
    for (const major of majorsToProcess) {
      progress.processed++
      
      if (progress.processed % 20 === 0) {
        console.log(`📊 Progress: ${progress.processed}/${progress.total} (Success: ${progress.success}, Failed: ${progress.failed})`)
      }
      
      const sourceKey = `WORK24_MAJOR:${major.deptId}:${major.majorId}`
      
      try {
        // skipExisting 옵션: 이미 있는 소스 스킵
        if (options.skipExisting) {
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
          empCurtState1Id: major.deptId,
          empCurtState2Id: major.majorId
        }, env)
        
        if (!detail) {
          throw new Error('API returned null')
        }
        
        // 정규화
        const normalized = normalizeGoyong24MajorDetail(detail)
        
        // 저장
        await upsertMajorSource(db, {
          sourceSystem: 'WORK24_MAJOR',
          sourceKey,
          sourceType: major.majorGb === '2' ? 'DETAIL_SPECIAL' : 'DETAIL_GENERAL',
          majorGb: major.majorGb,
          departmentId: major.deptId,
          rawPayload: detail,
          normalizedPayload: normalized
        })
        
        progress.success++
        await sleep(300)
        
      } catch (error) {
        const errorMessage = error instanceof Error ? error.message : String(error)
        console.error(`  ❌ ${major.majorName} (${sourceKey}): ${errorMessage}`)
        
        progress.failed++
        progress.errors.push({
          id: sourceKey,
          name: major.majorName,
          error: errorMessage
        })
        
        await sleep(300)
      }
    }
    
    await createSeedLog(db, 'WORK24_MAJOR_DETAIL', 'completed', progress)
    
    console.log('\n✅ Work24 Major Seeding Complete')
    console.log(`   Total: ${progress.total}`)
    console.log(`   Success: ${progress.success}`)
    console.log(`   Skipped: ${progress.skipped}`)
    console.log(`   Failed: ${progress.failed}`)
    
    if (progress.errors.length > 0) {
      console.log('\n❌ Failed majors:')
      progress.errors.forEach(e => console.log(`   - ${e.name}: ${e.error}`))
    }
    
    return progress
    
  } catch (error) {
    console.error('❌ Fatal error during seeding:', error)
    await createSeedLog(db, 'WORK24_MAJOR_DETAIL', 'failed', progress)
    throw error
  }
}


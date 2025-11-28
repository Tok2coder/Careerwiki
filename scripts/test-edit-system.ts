/**
 * Phase 4 편집 시스템 통합 테스트 스크립트
 * 
 * 실행 방법:
 * npx tsx scripts/test-edit-system.ts
 */

import { Miniflare } from 'miniflare'
import type { Env } from '../worker-configuration'

async function testEditSystem() {
  console.log('🧪 Phase 4 편집 시스템 통합 테스트 시작\n')

  // Miniflare 인스턴스 생성 (로컬 D1 사용)
  const mf = new Miniflare({
    script: '',
    d1Databases: {
      DB: 'careerwiki-jobs'
    },
    modules: true,
    compatibilityDate: '2024-01-01'
  })

  const env = await mf.getBindings<Env>()
  const db = env.DB

  let passedTests = 0
  let failedTests = 0

  // 테스트 헬퍼 함수
  const test = (name: string, fn: () => Promise<void> | void) => {
    return async () => {
      try {
        await fn()
        console.log(`✅ ${name}`)
        passedTests++
      } catch (error) {
        console.error(`❌ ${name}`)
        console.error(`   Error: ${error instanceof Error ? error.message : String(error)}`)
        failedTests++
      }
    }
  }

  // 테스트 1: page_revisions 테이블 구조 확인
  await test('page_revisions 테이블 구조 확인', async () => {
    const result = await db.prepare('PRAGMA table_info(page_revisions)').all()
    const columns = result.results as Array<{ name: string; type: string }>
    const requiredColumns = [
      'entity_type', 'entity_id', 'revision_number', 'is_current',
      'data_snapshot', 'editor_type', 'change_type'
    ]
    
    const columnNames = columns.map(c => c.name)
    for (const col of requiredColumns) {
      if (!columnNames.includes(col)) {
        throw new Error(`Missing column: ${col}`)
      }
    }
  })()

  // 테스트 2: anonymous_edit_limits 테이블 구조 확인
  await test('anonymous_edit_limits 테이블 구조 확인', async () => {
    const result = await db.prepare('PRAGMA table_info(anonymous_edit_limits)').all()
    const columns = result.results as Array<{ name: string }>
    const columnNames = columns.map(c => c.name)
    
    const requiredColumns = ['entity_type', 'entity_id', 'ip_hash', 'edit_date', 'edit_count']
    for (const col of requiredColumns) {
      if (!columnNames.includes(col)) {
        throw new Error(`Missing column: ${col}`)
      }
    }
  })()

  // 테스트 3: 인덱스 확인
  await test('인덱스 확인', async () => {
    const indexes = await db.prepare(`
      SELECT name FROM sqlite_master 
      WHERE type='index' 
      AND (name LIKE 'idx_revisions%' OR name LIKE 'idx_anonymous%')
    `).all()
    
    const indexNames = (indexes.results as Array<{ name: string }>).map(i => i.name)
    const requiredIndexes = [
      'idx_revisions_entity',
      'idx_revisions_current',
      'idx_revisions_number',
      'idx_anonymous_limits'
    ]
    
    for (const idx of requiredIndexes) {
      if (!indexNames.includes(idx)) {
        throw new Error(`Missing index: ${idx}`)
      }
    }
  })()

  // 테스트 4: 유틸리티 함수 import 테스트
  await test('유틸리티 함수 import 테스트', async () => {
    const { hashEditPassword, verifyEditPassword } = await import('../src/utils/anonymousEdit')
    
    const password = '1234'
    const hash = await hashEditPassword(password)
    
    if (!hash || hash.length !== 64) {
      throw new Error('Invalid hash format')
    }
    
    const isValid = await verifyEditPassword(password, hash)
    if (!isValid) {
      throw new Error('Password verification failed')
    }
    
    const isInvalid = await verifyEditPassword('0000', hash)
    if (isInvalid) {
      throw new Error('Password verification should fail for wrong password')
    }
  })()

  // 테스트 5: Revision 서비스 함수 import 테스트
  await test('Revision 서비스 함수 import 테스트', async () => {
    const { getNextRevisionNumber, createRevision, getCurrentRevision } = await import('../src/services/revisionService')
    
    // 테스트용 엔티티 ID
    const testEntityId = 'test-job-001'
    
    // 다음 revision 번호 조회
    const nextNumber = await getNextRevisionNumber(db, 'job', testEntityId)
    if (nextNumber !== 1) {
      throw new Error(`Expected revision number 1, got ${nextNumber}`)
    }
    
    // 현재 revision 조회 (없어야 함)
    const current = await getCurrentRevision(db, 'job', testEntityId)
    if (current !== null) {
      throw new Error('Current revision should be null for new entity')
    }
  })()

  // 테스트 6: 편집 서비스 함수 import 테스트
  await test('편집 서비스 함수 import 테스트', async () => {
    const { editJob, editMajor, editHowTo } = await import('../src/services/editService')
    
    // 함수가 정의되어 있는지 확인
    if (typeof editJob !== 'function') {
      throw new Error('editJob is not a function')
    }
    if (typeof editMajor !== 'function') {
      throw new Error('editMajor is not a function')
    }
    if (typeof editHowTo !== 'function') {
      throw new Error('editHowTo is not a function')
    }
  })()

  // 테스트 7: 캐시 무효화 함수 테스트
  await test('캐시 무효화 함수 테스트', async () => {
    const { invalidatePageCache } = await import('../src/utils/page-cache')
    
    // 존재하지 않는 페이지 캐시 삭제 (에러 없이 실행되어야 함)
    const deleted = await invalidatePageCache(db, {
      slug: 'non-existent-page',
      pageType: 'job'
    })
    
    if (typeof deleted !== 'number') {
      throw new Error('invalidatePageCache should return a number')
    }
  })()

  // 테스트 8: 실제 직업 데이터 존재 확인
  await test('실제 직업 데이터 존재 확인', async () => {
    const job = await db.prepare('SELECT id, name FROM jobs WHERE is_active = 1 LIMIT 1').first()
    
    if (!job) {
      throw new Error('No active jobs found in database')
    }
    
    console.log(`   Found test job: ${(job as any).name} (ID: ${(job as any).id})`)
  })()

  // 테스트 결과 출력
  console.log(`\n📊 테스트 결과:`)
  console.log(`   ✅ 통과: ${passedTests}`)
  console.log(`   ❌ 실패: ${failedTests}`)
  console.log(`   총 테스트: ${passedTests + failedTests}`)
  
  if (failedTests === 0) {
    console.log(`\n🎉 모든 테스트 통과!`)
    process.exit(0)
  } else {
    console.log(`\n⚠️  일부 테스트 실패`)
    process.exit(1)
  }
}

testEditSystem().catch((error) => {
  console.error('❌ 테스트 실행 중 오류:', error)
  process.exit(1)
})


// @ts-nocheck
/**
 * Flat-50 노이즈 직업 일괄 재태깅 스크립트
 *
 * 사용법:
 *   npx tsx scripts/batch-retag-flat50.ts [--batch-size=10] [--max-batches=50] [--base-url=https://careerwiki.org]
 *
 * 환경변수:
 *   ADMIN_SECRET: .dev.vars에서 자동 로드
 *
 * 동작:
 *   1. /admin/api/ai/retag-flat50 엔드포인트를 반복 호출
 *   2. 각 배치에서 flat-50 속성 삭제 후 개선된 프롬프트로 재태깅
 *   3. 진행 상황을 콘솔에 출력
 *   4. 모든 flat-50 직업이 재태깅되거나 max-batches 도달 시 종료
 */

import { readFileSync } from 'fs'
import { resolve } from 'path'

// .dev.vars에서 ADMIN_SECRET 읽기
function loadAdminSecret(): string {
  try {
    const devVars = readFileSync(resolve(process.cwd(), '.dev.vars'), 'utf-8')
    const match = devVars.match(/ADMIN_SECRET\s*=\s*['"]?([^'"\n]+)['"]?/)
    if (match) return match[1].trim()
  } catch (e) {
    // ignore
  }
  if (process.env.ADMIN_SECRET) return process.env.ADMIN_SECRET
  throw new Error('ADMIN_SECRET not found in .dev.vars or environment')
}

// CLI 인자 파싱
function parseArgs() {
  const args: Record<string, string> = {}
  process.argv.slice(2).forEach(arg => {
    const match = arg.match(/^--([^=]+)=(.+)$/)
    if (match) args[match[1]] = match[2]
  })
  return {
    batchSize: parseInt(args['batch-size'] || '10', 10),
    maxBatches: parseInt(args['max-batches'] || '200', 10),
    baseUrl: args['base-url'] || 'https://careerwiki.org',
  }
}

async function sleep(ms: number) {
  return new Promise(resolve => setTimeout(resolve, ms))
}

async function main() {
  const { batchSize, maxBatches, baseUrl } = parseArgs()
  const adminSecret = loadAdminSecret()

  console.log(`\n🔄 Flat-50 재태깅 시작`)
  console.log(`   Base URL: ${baseUrl}`)
  console.log(`   Batch size: ${batchSize}`)
  console.log(`   Max batches: ${maxBatches}\n`)

  let totalSuccess = 0
  let totalFail = 0
  let batchNum = 0

  while (batchNum < maxBatches) {
    batchNum++

    try {
      const response = await fetch(`${baseUrl}/admin/api/ai/retag-flat50`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-Admin-Secret': adminSecret,
        },
        body: JSON.stringify({ batch_size: batchSize, offset: 0 }),
      })

      if (!response.ok) {
        const text = await response.text()
        console.error(`❌ Batch ${batchNum}: HTTP ${response.status} — ${text.substring(0, 200)}`)
        // 에러 시 30초 대기 후 재시도
        await sleep(30000)
        continue
      }

      const data = await response.json() as {
        total_flat50: number
        processed: number
        success: number
        failed: number
        remaining: number
        results: Array<{ job_id: string; job_name: string; success: boolean; error?: string }>
      }

      totalSuccess += data.success
      totalFail += data.failed

      const successNames = data.results.filter(r => r.success).map(r => r.job_name).join(', ')
      const failNames = data.results.filter(r => !r.success).map(r => `${r.job_name}(${r.error})`).join(', ')

      console.log(
        `[${batchNum}/${maxBatches}] ` +
        `처리: ${data.processed} | 성공: ${data.success} | 실패: ${data.failed} | ` +
        `남은: ${data.remaining} | 누적: +${totalSuccess} -${totalFail}`
      )
      if (failNames) console.log(`   ⚠️ 실패: ${failNames}`)

      // 모두 완료
      if (data.remaining === 0 || data.processed === 0) {
        console.log(`\n✅ 재태깅 완료!`)
        console.log(`   총 성공: ${totalSuccess}`)
        console.log(`   총 실패: ${totalFail}`)
        break
      }

      // Worker 부하 분산을 위해 배치 사이 2초 대기
      await sleep(2000)

    } catch (error) {
      console.error(`❌ Batch ${batchNum}: ${error instanceof Error ? error.message : String(error)}`)
      await sleep(10000)
    }
  }

  if (batchNum >= maxBatches) {
    console.log(`\n⚠️ Max batches (${maxBatches}) 도달. 남은 작업이 있을 수 있습니다.`)
    console.log(`   재실행하여 계속 처리하세요.`)
  }

  console.log(`\n📊 최종 결과: 성공 ${totalSuccess}건, 실패 ${totalFail}건`)
}

main().catch(err => {
  console.error('Fatal error:', err)
  process.exit(1)
})

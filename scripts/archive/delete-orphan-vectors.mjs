// 고아 벡터 삭제 스크립트
import { execSync } from 'child_process'
import fs from 'fs'

const orphanIds = JSON.parse(fs.readFileSync('artifacts/orphan-vector-ids.json', 'utf-8'))
console.log('고아 벡터 삭제:', orphanIds.length, '개')

// 50개씩 배치로 삭제
const batchSize = 50
let deleted = 0

for (let i = 0; i < orphanIds.length; i += batchSize) {
  const batch = orphanIds.slice(i, i + batchSize)
  const idsArg = batch.join(' ')
  
  console.log(`Batch ${Math.floor(i/batchSize) + 1}: ${batch.length}개 삭제 중...`)
  
  try {
    execSync(
      `npx wrangler vectorize delete-vectors careerwiki-embeddings --ids ${idsArg}`,
      { encoding: 'utf-8', shell: 'cmd.exe' }
    )
    deleted += batch.length
  } catch (e) {
    console.error('  Error:', e.message)
  }
}

console.log(`\n완료! ${deleted}개 삭제됨`)

// 검증
console.log('\n검증 중...')
try {
  const output = execSync(
    'npx wrangler vectorize info careerwiki-embeddings',
    { encoding: 'utf-8', shell: 'cmd.exe' }
  )
  console.log(output)
} catch (e) {
  console.error('검증 실패:', e.message)
}

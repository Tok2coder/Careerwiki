/**
 * 간호학과의 실제 D1 데이터 확인
 */
import 'dotenv/config'
import { createClient } from '@libsql/client'

const db = createClient({
  url: 'file:./.wrangler/state/v3/d1/miniflare-D1DatabaseObject/xxxx.sqlite',
  authToken: ''
})

const result = await db.execute({
  sql: `SELECT id, name, careernet_id, goyong24_id, api_data_json 
        FROM majors 
        WHERE LOWER(name) = LOWER(?)
        LIMIT 5`,
  args: ['간호학과']
})

console.log(`\n🔍 D1에서 "간호학과" 조회 결과: ${result.rows.length}개\n`)

for (const row of result.rows) {
  console.log(`\n📄 레코드 ID: ${row.id}`)
  console.log(`   이름: ${row.name}`)
  console.log(`   careernet_id: ${row.careernet_id}`)
  console.log(`   goyong24_id: ${row.goyong24_id}`)
  
  if (row.api_data_json) {
    const apiData = JSON.parse(row.api_data_json as string)
    
    if (apiData.careernet) {
      console.log(`\n   📚 CareerNet 데이터:`)
      console.log(`      - mainSubjects: ${apiData.careernet.mainSubjects ? apiData.careernet.mainSubjects.length : 0}개`)
      console.log(`      - mainSubject: ${apiData.careernet.mainSubject ? apiData.careernet.mainSubject.length : 0}개`)
      console.log(`      - relateSubject: ${apiData.careernet.relateSubject ? apiData.careernet.relateSubject.length : 0}개`)
      console.log(`      - careerAct: ${apiData.careernet.careerAct ? apiData.careernet.careerAct.length : 0}개`)
      
      if (apiData.careernet.mainSubjects) {
        console.log(`\n      mainSubjects 샘플:`)
        apiData.careernet.mainSubjects.slice(0, 3).forEach((s: string) => console.log(`        - ${s}`))
      }
    }
    
    if (apiData.goyong24) {
      console.log(`\n   📊 Goyong24 데이터:`)
      console.log(`      - mainSubjects: ${apiData.goyong24.mainSubjects ? apiData.goyong24.mainSubjects.length : 0}개`)
      console.log(`      - mainSubject: ${apiData.goyong24.mainSubject ? apiData.goyong24.mainSubject.length : 0}개`)
      console.log(`      - relateSubject: ${apiData.goyong24.relateSubject ? apiData.goyong24.relateSubject.length : 0}개`)
      console.log(`      - careerAct: ${apiData.goyong24.careerAct ? apiData.goyong24.careerAct.length : 0}개`)
    }
  }
}

db.close()


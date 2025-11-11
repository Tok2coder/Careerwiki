import { readFileSync } from 'fs'
import { resolve, dirname } from 'path'
import { fileURLToPath } from 'url'

const __filename = fileURLToPath(import.meta.url)
const projectRoot = resolve(dirname(__filename), '..')

const devVarsPath = resolve(projectRoot, '.dev.vars')
const content = readFileSync(devVarsPath, 'utf-8')
content.split('\n').forEach((line) => {
  const trimmed = line.trim()
  if (!trimmed || trimmed.startsWith('#')) return
  const [key, ...valueParts] = trimmed.split('=')
  if (!key || valueParts.length === 0) return
  process.env[key.trim()] = valueParts.join('=').trim()
})

const API_KEY = process.env.CAREER_NET_API_KEY || 'd9e0285190fde074bef30031f17f669e'

// 샘플 전공 코드 (농학과 관련)
const testMajorSeq = '238' // 예시

const url = new URL('https://www.career.go.kr/cnet/openapi/getOpenApi')
url.searchParams.append('apiKey', API_KEY)
url.searchParams.append('svcType', 'api')
url.searchParams.append('svcCode', 'MAJOR_VIEW')
url.searchParams.append('contentType', 'json')
url.searchParams.append('gubun', 'univ_list')
url.searchParams.append('majorSeq', testMajorSeq)

console.log('=== CareerNet API 응답 구조 확인 ===\n')
console.log('요청 URL:', url.toString())
console.log('\n응답 대기 중...\n')

fetch(url.toString())
  .then(async (response) => {
    if (!response.ok) {
      throw new Error(`HTTP ${response.status}: ${response.statusText}`)
    }
    const jsonData = await response.json()
    const major = jsonData.dataSearch?.content?.[0]
    
    if (!major) {
      console.log('❌ 전공 데이터 없음')
      return
    }
    
    console.log('✅ 전공 데이터 발견:', major.major || major.mClass || '이름 없음')
    console.log('\n=== 필드 존재 여부 확인 ===\n')
    
    const fields = [
      'lstMiddleAptd',
      'lstHighAptd', 
      'lstVals',
      'chartData',
      'relate_subject',
      'career_act',
      'main_subject',
      'enter_field',
      'property',
      'universityList'
    ]
    
    fields.forEach(field => {
      const exists = major[field] !== undefined && major[field] !== null
      const type = exists ? typeof major[field] : '없음'
      const isArray = exists && Array.isArray(major[field])
      const isObject = exists && typeof major[field] === 'object' && !Array.isArray(major[field])
      
      let detail = ''
      if (exists) {
        if (isArray) {
          detail = ` (배열, 길이: ${major[field].length})`
        } else if (isObject) {
          detail = ` (객체, 키: ${Object.keys(major[field]).join(', ')})`
        } else {
          detail = ` (${type})`
        }
      }
      
      console.log(`${exists ? '✅' : '❌'} ${field}: ${type}${detail}`)
    })
    
    // 샘플 데이터 출력
    if (major.lstMiddleAptd) {
      console.log('\n=== lstMiddleAptd 샘플 ===')
      console.log(JSON.stringify(major.lstMiddleAptd, null, 2).substring(0, 500))
    }
    
    if (major.chartData) {
      console.log('\n=== chartData 샘플 ===')
      console.log(JSON.stringify(major.chartData, null, 2).substring(0, 500))
    }
  })
  .catch(error => {
    console.error('❌ 오류:', error.message)
  })

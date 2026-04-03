/**
 * 유사 이름 매핑 적용 스크립트
 * 1. 수동으로 확인된 매핑 저장
 * 2. 정규화 후 중복 항목 자동 매핑
 * 3. ETL 실행
 */

import { saveNameMappings, findSimilarNames } from '../src/services/similarNamesService'

// 사용자가 확인한 직업 매핑 목록
const confirmedJobMappings = [
  { type: 'job' as const, sourceName: '자재·구매사무원', targetName: '자재구매사무원', similarityScore: 0.98, matchReason: 'normalized' },
  { type: 'job' as const, sourceName: '자동조립라인 및 산업용로봇조작원', targetName: '자동조립라인·산업용 로봇조작원', similarityScore: 0.93, matchReason: 'levenshtein' },
  { type: 'job' as const, sourceName: '상ㆍ하수도 처리장치 조작원', targetName: '상·하수도처리장치조작원', similarityScore: 0.92, matchReason: 'levenshtein' },
  { type: 'job' as const, sourceName: '크레인·호이스트운전원', targetName: '크레인 및 호이스트운전원', similarityScore: 0.91, matchReason: 'levenshtein' },
  { type: 'job' as const, sourceName: '가전제품 설치 및 수리원', targetName: '가전제품설치·수리원', similarityScore: 0.90, matchReason: 'levenshtein' },
  { type: 'job' as const, sourceName: '귀금속 및 보석세공원', targetName: '귀금속·보석세공원', similarityScore: 0.89, matchReason: 'levenshtein' },
  { type: 'job' as const, sourceName: '가구제조,수리원', targetName: '가구제조·수리원', similarityScore: 0.88, matchReason: 'levenshtein' },
  { type: 'job' as const, sourceName: '곡식작물재배자', targetName: '곡식작물재배원', similarityScore: 0.86, matchReason: 'levenshtein' },
  { type: 'job' as const, sourceName: '과수작물재배자', targetName: '과수작물재배원', similarityScore: 0.86, matchReason: 'levenshtein' },
  { type: 'job' as const, sourceName: '여행상품개발자', targetName: '여행상품개발원', similarityScore: 0.86, matchReason: 'levenshtein' },
  { type: 'job' as const, sourceName: '재활용 처리 및 소각로 조작원', targetName: '재활용 처리장치·소각로조작원', similarityScore: 0.85, matchReason: 'levenshtein' },
  { type: 'job' as const, sourceName: '주차장관리원', targetName: '주차관리원', similarityScore: 0.83, matchReason: 'levenshtein' },
  { type: 'job' as const, sourceName: '출판물편집자', targetName: '출판편집자', similarityScore: 0.83, matchReason: 'levenshtein' },
  { type: 'job' as const, sourceName: '종이제품생산직(기계조작)', targetName: '종이제품생산기계조작원', similarityScore: 0.82, matchReason: 'levenshtein' },
]

async function main() {
  // D1 데이터베이스 연결은 wrangler를 통해 실행해야 함
  console.log('이 스크립트는 wrangler d1 execute를 통해 SQL로 실행해야 합니다.')
  console.log('')
  console.log('아래 SQL을 복사해서 실행하세요:')
  console.log('')
  
  const now = Date.now()
  
  // SQL INSERT 문 생성
  const insertStatements = confirmedJobMappings.map(m => 
    `INSERT OR REPLACE INTO name_mappings (type, source_name, target_name, similarity_score, match_reason, created_at, is_active) VALUES ('${m.type}', '${m.sourceName}', '${m.targetName}', ${m.similarityScore}, '${m.matchReason}', ${now}, 1);`
  ).join('\n')
  
  console.log(insertStatements)
}

main()


#!/usr/bin/env node
/**
 * V3 AI Analyzer 로컬 테스트 스크립트
 * 사용법: node scripts/test-v3-local.mjs
 */

const BASE_URL = 'http://localhost:3000'
const SESSION_ID = `test-v3-${Date.now()}`

console.log('🧪 V3 AI Analyzer 로컬 테스트 시작')
console.log(`   Session ID: ${SESSION_ID}`)
console.log(`   Base URL: ${BASE_URL}`)
console.log('')

// 1. 서술형 답변 저장 테스트
async function testNarrativeFacts() {
  console.log('📝 1. 서술형 답변 저장 테스트...')
  
  try {
    const res = await fetch(`${BASE_URL}/api/ai-analyzer/v3/narrative-facts`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        session_id: SESSION_ID,
        high_alive_moment: '팀 프로젝트에서 제 아이디어가 채택됐을 때요. 처음으로 제 생각이 인정받은 느낌이었고, 밤새워도 지치지 않았어요.',
        lost_moment: '매일 같은 보고서를 작성할 때요. 제가 누군지, 왜 이 일을 하는지 모르겠었어요.',
      }),
    })
    
    const data = await res.json()
    console.log(`   상태: ${res.status} ${res.ok ? '✅' : '❌'}`)
    console.log(`   응답:`, JSON.stringify(data, null, 2).substring(0, 200))
    return res.ok
  } catch (error) {
    console.log(`   에러: ${error.message} ❌`)
    return false
  }
}

// 2. 라운드 질문 생성 테스트
async function testRoundQuestions(roundNumber) {
  console.log(`\n🎯 2-${roundNumber}. Round ${roundNumber} 질문 생성 테스트...`)
  
  try {
    const res = await fetch(`${BASE_URL}/api/ai-analyzer/v3/round-questions`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        session_id: SESSION_ID,
        round_number: roundNumber,
        narrative_facts: {
          highAliveMoment: '팀 프로젝트에서 제 아이디어가 채택됐을 때',
          lostMoment: '매일 같은 보고서를 작성할 때',
        },
        previous_round_answers: [],
        universal_answers: {
          univ_interest: ['tech', 'analysis'],
          univ_dislike: ['sales', 'routine'],
          univ_priority: 'growth',
        },
      }),
    })
    
    const data = await res.json()
    console.log(`   상태: ${res.status} ${res.ok ? '✅' : '❌'}`)
    console.log(`   생성 방식: ${data.generated_by || 'unknown'}`)
    console.log(`   질문 수: ${data.questions?.length || 0}`)
    
    if (data.questions?.length > 0) {
      console.log(`   첫 번째 질문: "${data.questions[0].questionText?.substring(0, 50)}..."`)
    }
    
    return res.ok && data.questions?.length > 0
  } catch (error) {
    console.log(`   에러: ${error.message} ❌`)
    return false
  }
}

// 3. 라운드 답변 저장 테스트
async function testRoundAnswers() {
  console.log('\n💾 3. 라운드 답변 저장 테스트...')
  
  try {
    const res = await fetch(`${BASE_URL}/api/ai-analyzer/v3/round-answers`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        session_id: SESSION_ID,
        round_number: 1,
        answers: [
          {
            question_id: 'round1_q1',
            question_text: '어떤 일을 할 때 시간 가는 줄 모르나요?',
            purpose_tag: 'ENGINE',
            answer: '새로운 기술을 배우고 프로젝트에 적용할 때 시간이 빠르게 흘러갑니다.',
          },
        ],
      }),
    })
    
    const data = await res.json()
    console.log(`   상태: ${res.status} ${res.ok ? '✅' : '❌'}`)
    console.log(`   저장된 답변 수: ${data.saved_count || 0}`)
    return res.ok
  } catch (error) {
    console.log(`   에러: ${error.message} ❌`)
    return false
  }
}

// 4. Vectorize 테스트
async function testVectorize() {
  console.log('\n🔍 4. Vectorize 검색 테스트...')
  
  try {
    const res = await fetch(`${BASE_URL}/api/ai-analyzer/vectorize-test?query=소프트웨어 개발&topK=5`)
    const data = await res.json()
    
    console.log(`   상태: ${res.status} ${res.ok ? '✅' : '❌'}`)
    console.log(`   결과 수: ${data.total_results || 0}`)
    
    if (data.results?.length > 0) {
      console.log(`   첫 번째 결과: ${data.results[0].job_name} (score: ${data.results[0].score})`)
    }
    
    return res.ok
  } catch (error) {
    console.log(`   에러: ${error.message} ❌`)
    return false
  }
}

// 5. DB 테이블 확인
async function checkDbTables() {
  console.log('\n📊 5. V3 테이블 확인...')
  
  // 직접 DB 접근 대신 API 통해 확인 불가능하므로 스킵
  console.log('   (로컬 wrangler CLI로 직접 확인 필요)')
  console.log('   npx wrangler d1 execute careerwiki-kr --local --command "SELECT name FROM sqlite_master WHERE type=\'table\'"')
  return true
}

// 메인 실행
async function main() {
  const results = []
  
  results.push({ test: 'narrative_facts', pass: await testNarrativeFacts() })
  results.push({ test: 'round_questions_1', pass: await testRoundQuestions(1) })
  results.push({ test: 'round_questions_2', pass: await testRoundQuestions(2) })
  results.push({ test: 'round_questions_3', pass: await testRoundQuestions(3) })
  results.push({ test: 'round_answers', pass: await testRoundAnswers() })
  results.push({ test: 'vectorize', pass: await testVectorize() })
  await checkDbTables()
  
  console.log('\n' + '='.repeat(50))
  console.log('📋 테스트 결과 요약')
  console.log('='.repeat(50))
  
  const passed = results.filter(r => r.pass).length
  const total = results.length
  
  results.forEach(r => {
    console.log(`   ${r.pass ? '✅' : '❌'} ${r.test}`)
  })
  
  console.log('')
  console.log(`   총 ${total}개 중 ${passed}개 통과 (${Math.round(passed/total*100)}%)`)
  
  if (passed < total) {
    console.log('\n⚠️  일부 테스트가 실패했습니다.')
    console.log('   - 로컬 서버가 실행 중인지 확인: npm run dev')
    console.log('   - Vectorize는 로컬에서 지원되지 않아 실패할 수 있음 (정상)')
  } else {
    console.log('\n🎉 모든 테스트 통과!')
  }
}

main().catch(console.error)

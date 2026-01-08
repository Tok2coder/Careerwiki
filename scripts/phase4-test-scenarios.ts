/**
 * Phase 4 Safe Replacement Logic - 테스트 시나리오 5개
 * Research Bias 해결 및 Diversity Guard 동작 확인용
 */

// 테스트 시나리오 정의
export const PHASE4_TEST_SCENARIOS = [
  // 시나리오 1: Research Bias 기본 케이스
  // 예상: 연구직 3개 → 연구직 1개 + 다른 직군 2개
  {
    id: 'scenario_1_research_bias',
    name: 'Research Bias 방지 - 연구직 3개 독점 방지',
    input: {
      session_id: 'test-phase4-001',
      stage: 'job_explore',
      universal_answers: {
        univ_interest: ['tech', 'numbers'],
        univ_workstyle: 'solo',
        univ_priority: 'growth',
      },
    },
    expected: {
      max_research_in_top3: 1,  // 연구직 최대 1개
      diversity_guard_applied: true,
      different_clusters_in_top3: 2,  // 최소 2개 다른 클러스터
    },
    description: '기술+숫자 관심, 혼자 일하기 선호 → 기존에는 연구직 3개 독점. Phase 4 후 다양화 기대',
  },

  // 시나리오 2: Hard Filter + 대체
  // 예상: 야근 많은 직업 필터 → 유사 직업으로 대체
  {
    id: 'scenario_2_hard_filter',
    name: 'Hard Filter - 야근 거부 시 대체 직업 선정',
    input: {
      session_id: 'test-phase4-002',
      stage: 'job_early',
      universal_answers: {
        univ_interest: ['business'],
        univ_workstyle: 'team',
        univ_priority: 'income',
      },
      followup_no: {
        constraint: 'work_hours_strict',
        job_id: 'financial-analyst',  // 야근 많은 직업
      },
    },
    expected: {
      replacement_found: true,
      replacement_similarity: 0.5,  // 최소 유사도
      constraint_respected: true,
    },
    description: '비즈니스 관심 + 수입 중시 → 투자은행/컨설팅 추천됨. 야근 거부 시 유사 금융직 대체',
  },

  // 시나리오 3: Diversity Guard - 같은 클러스터 방지
  // 예상: IT/개발직 3개 → IT 1개 + 다른 분야 2개
  {
    id: 'scenario_3_cluster_diversity',
    name: 'Diversity Guard - 동일 클러스터 중복 방지',
    input: {
      session_id: 'test-phase4-003',
      stage: 'job_student',
      universal_answers: {
        univ_interest: ['tech'],
        univ_workstyle: 'solo',
        univ_priority: 'growth',
      },
    },
    expected: {
      max_same_cluster: 1,  // 같은 클러스터 최대 1개
      cluster_types_count: 3,  // 3개 다른 클러스터
    },
    description: '기술 관심만 있어도 IT 외 다른 분야 (데이터분석, UX 등) 추천',
  },

  // 시나리오 4: Soft Rerank - 트레이드오프 반영
  // 예상: WLB 선택 시 야근 많은 직업 순위 하락
  {
    id: 'scenario_4_soft_rerank',
    name: 'Soft Rerank - WLB 선택 시 순위 변동',
    input: {
      session_id: 'test-phase4-004',
      stage: 'job_explore',
      universal_answers: {
        univ_interest: ['business', 'numbers'],
        univ_workstyle: 'team',
        univ_priority: 'wlb',  // WLB 우선
      },
    },
    expected: {
      wlb_jobs_boosted: true,
      overtime_jobs_penalized: true,
      top3_avg_wlb_score: 60,  // WLB 점수 평균 60 이상
    },
    description: 'WLB 우선 시 야근 많은 금융/컨설팅 순위 하락, WLB 좋은 직업 상승',
  },

  // 시나리오 5: 복합 케이스 - Research Bias + Hard Filter + Diversity
  // 예상: 연구직 제외 + 원격 필수 + 다양성 적용
  {
    id: 'scenario_5_complex',
    name: '복합 케이스 - 다중 조건 동시 적용',
    input: {
      session_id: 'test-phase4-005',
      stage: 'job_explore',
      universal_answers: {
        univ_interest: ['tech', 'art'],
        univ_workstyle: 'solo',
        univ_priority: 'autonomy',
        univ_life_constraint: ['caregiving'],  // 돌봄 필요
      },
      followup_no: {
        constraint: 'remote_only',  // 원격만 가능
      },
    },
    expected: {
      all_remote_possible: true,  // 모든 TOP3 원격 가능
      max_research_in_top3: 1,
      diversity_guard_applied: true,
    },
    description: '기술+예술 관심, 혼자 선호, 자율성 중시, 돌봄 필요 → 원격 가능하고 다양한 직업군 추천',
  },
]

// 테스트 실행 함수
export async function runPhase4Tests(baseUrl: string = 'http://localhost:3000') {
  console.log('='.repeat(60))
  console.log('Phase 4 Safe Replacement Logic 테스트')
  console.log('='.repeat(60))
  
  for (const scenario of PHASE4_TEST_SCENARIOS) {
    console.log(`\n🧪 ${scenario.name}`)
    console.log(`   ID: ${scenario.id}`)
    console.log(`   ${scenario.description}`)
    
    try {
      // 1. 분석 요청
      const analyzeResponse = await fetch(`${baseUrl}/api/ai-analyzer/analyze`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(scenario.input),
      })
      
      const analyzeResult = await analyzeResponse.json()
      
      if (!analyzeResult.success) {
        console.log(`   ❌ 분석 실패: ${analyzeResult.error}`)
        continue
      }
      
      // 2. 결과 검증
      console.log(`   📊 TOP3:`)
      const top3 = analyzeResult.result?.fit_top3 || []
      for (const job of top3) {
        console.log(`      - ${job.job_name} (Fit: ${job.fit_score})`)
      }
      
      // Phase 4 적용 여부 확인
      const phase4Applied = analyzeResult.result?.phase4_applied
      const diversityApplied = analyzeResult.result?.diversity_guard_active
      
      console.log(`   🛡️ Phase 4 적용: ${phase4Applied ? '✅' : '❌'}`)
      console.log(`   🎯 Diversity Guard: ${diversityApplied ? '✅' : '❌'}`)
      
      if (analyzeResult.result?.diversity_changes?.length > 0) {
        console.log(`   📝 변경 사항:`)
        for (const change of analyzeResult.result.diversity_changes) {
          console.log(`      - ${change}`)
        }
      }
      
      // 3. Follow-up No 테스트 (해당되는 경우)
      if (scenario.input.followup_no) {
        console.log(`\n   🔄 Follow-up "No" 테스트:`)
        
        const followupResponse = await fetch(`${baseUrl}/api/ai-analyzer/followup`, {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({
            session_id: scenario.input.session_id,
            question_id: 'test-question',
            constraint: scenario.input.followup_no.constraint,
            job_id: scenario.input.followup_no.job_id,
            answer: 'no',
            request_id: analyzeResult.request_id,
          }),
        })
        
        const followupResult = await followupResponse.json()
        
        console.log(`      Action: ${followupResult.action}`)
        if (followupResult.rank_change?.changed) {
          console.log(`      변경 전: ${followupResult.rank_change.before_top3.join(', ')}`)
          console.log(`      변경 후: ${followupResult.rank_change.after_top3.join(', ')}`)
        }
      }
      
    } catch (error) {
      console.log(`   ❌ 테스트 실패: ${error}`)
    }
  }
  
  console.log('\n' + '='.repeat(60))
  console.log('테스트 완료')
  console.log('='.repeat(60))
}

// CLI 실행 (ESM 호환)
// 주의: 이 파일은 직접 실행하지 말고 run-calibration.ts를 사용할 것
// 직접 실행 필요 시: npx tsx scripts/phase4-test-scenarios.ts
const isMainModule = import.meta.url === `file://${process.argv[1]?.replace(/\\/g, '/')}`
if (isMainModule) {
  const baseUrl = process.argv[2] || 'http://localhost:3000'
  runPhase4Tests(baseUrl)
    .then(() => process.exit(0))
    .catch(err => {
      console.error(err)
      process.exit(1)
    })
}


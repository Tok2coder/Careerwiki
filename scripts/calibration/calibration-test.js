/**
 * 캘리브레이션 테스트 스크립트
 * CALIBRATION_SCENARIOS.md의 시나리오들을 실제로 테스트
 */

const scenarios = [
  {
    scenario_id: "E1",
    stage: "job_explore",
    name: "기술 호기심 학생",
    universal_answers: {
      univ_interest: ["tech", "numbers"],
      univ_dislike: ["people"],
      univ_workstyle_social: "solo",
      univ_priority: "growth"
    },
    expected_top3_contains: ["개발자", "데이터", "연구"],
    expected_top3_avoids: ["영업", "서비스", "간호"]
  },
  {
    scenario_id: "E2",
    stage: "job_explore",
    name: "창의적 예술 학생",
    universal_answers: {
      univ_interest: ["art", "design"],
      univ_dislike: ["numbers", "rules"],
      univ_workstyle_social: "team",
      univ_priority: "meaning"
    },
    expected_top3_contains: ["디자인", "예술", "교육"],
    expected_top3_avoids: ["금융", "생산", "데이터"]
  },
  {
    scenario_id: "M1",
    stage: "job_mid",
    name: "안정 추구 중간 관리자",
    universal_answers: {
      univ_interest: ["management", "people"],
      univ_dislike: ["risk", "uncertainty"],
      univ_workstyle_social: "team",
      univ_priority: "stability"
    },
    expected_top3_contains: ["관리자", "행정", "교육"],
    expected_top3_avoids: ["창업", "프리랜서", "영업"]
  }
];

async function runCalibrationTest() {
  console.log('🎯 캘리브레이션 테스트 시작\n');

  for (const scenario of scenarios) {
    console.log(`\n📋 시나리오 ${scenario.scenario_id}: ${scenario.name}`);

    try {
      // API 호출
      const response = await fetch('http://localhost:3000/api/ai-analyzer/analyze', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          session_id: `calibration-${scenario.scenario_id}`,
          analysis_type: 'job',
          stage: scenario.stage,
          universal_answers: scenario.universal_answers
        })
      });

      if (!response.ok) {
        console.log(`❌ API 호출 실패: ${response.status}`);
        continue;
      }

      const result = await response.json();
      const top3 = result.result.fit_top3;

      console.log(`  실제 TOP3:`);
      top3.forEach((job, idx) => {
        console.log(`    ${idx+1}. ${job.job_name} (점수: ${job.fit_score})`);
      });

      // 검증
      let containsCount = 0;
      let avoidsCount = 0;

      for (const job of top3) {
        const jobName = job.job_name.toLowerCase();
        for (const expected of scenario.expected_top3_contains) {
          if (jobName.includes(expected.toLowerCase())) {
            containsCount++;
            break;
          }
        }
        for (const avoid of scenario.expected_top3_avoids) {
          if (jobName.includes(avoid.toLowerCase())) {
            avoidsCount++;
            break;
          }
        }
      }

      const quality = ((containsCount * 2) - avoidsCount) / 3 * 100;
      console.log(`  ✅ 기대 일치: ${containsCount}/3개`);
      console.log(`  ⚠️ 회피 성공: ${3-avoidsCount}/3개`);
      console.log(`  📊 품질 점수: ${quality.toFixed(1)}%`);

      if (quality >= 70) {
        console.log(`  🎉 PASS`);
      } else {
        console.log(`  ❌ FAIL`);
      }

    } catch (error) {
      console.log(`❌ 오류: ${error.message}`);
    }
  }

  console.log('\n🏁 캘리브레이션 테스트 완료');
}

// Node.js 환경에서 실행
if (typeof require !== 'undefined') {
  // Node.js
  fetch = require('node-fetch');
  runCalibrationTest().catch(console.error);
} else {
  // 브라우저
  runCalibrationTest();
}






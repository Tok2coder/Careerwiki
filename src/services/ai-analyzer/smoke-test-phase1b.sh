#!/bin/bash
# CareerWiki AI Analyzer - Phase 1B Smoke Test
# 태깅 완료 후 추천/질문 로직 연결 테스트

BASE_URL=${1:-"http://localhost:3000"}

echo "========================================"
echo "Phase 1B Smoke Test"
echo "Base URL: $BASE_URL"
echo "========================================"

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

PASS_COUNT=0
FAIL_COUNT=0

check() {
  if [ "$1" = "true" ]; then
    echo -e "${GREEN}✓ $2${NC}"
    ((PASS_COUNT++))
  else
    echo -e "${RED}✗ $2${NC}"
    ((FAIL_COUNT++))
  fi
}

# ============================================
# Test 1: Tagger Stats
# ============================================
echo ""
echo -e "${YELLOW}[Test 1] Tagger Stats${NC}"
STATS=$(curl -s "$BASE_URL/api/ai-analyzer/tagger/stats")
TOTAL=$(echo "$STATS" | jq -r '.total')
echo "Tagged jobs: $TOTAL"
[ "$TOTAL" -gt 0 ] && T1="true" || T1="false"
check "$T1" "At least 1 job tagged"

# ============================================
# Test 2: Golden Set Run (Optional - skip if already done)
# ============================================
echo ""
echo -e "${YELLOW}[Test 2] Golden Set Available${NC}"
GOLDEN_COUNT=$(curl -s "$BASE_URL/api/ai-analyzer/tagger/stats" | jq -r '.total')
if [ "$GOLDEN_COUNT" -ge 30 ]; then
  echo "Golden set already tagged ($GOLDEN_COUNT jobs)"
  T2="true"
else
  echo "Golden set not complete ($GOLDEN_COUNT/30)"
  echo "Run: POST /api/ai-analyzer/tagger/run-golden to tag golden set"
  T2="false"
fi
check "$T2" "Golden set (30+) tagged"

# ============================================
# Test 3: Analyze with Real Job Attributes
# ============================================
echo ""
echo -e "${YELLOW}[Test 3] Analyze with Tagged Jobs${NC}"
SESSION="phase1b-test-$(date +%s)"

ANALYZE=$(curl -s -X POST "$BASE_URL/api/ai-analyzer/analyze" \
  -H "Content-Type: application/json" \
  -d "{
    \"session_id\": \"$SESSION\",
    \"user_id\": \"test\",
    \"profile\": {
      \"interest\": { \"keywords\": [\"기술\", \"분석\", \"연구\"] },
      \"value\": { \"priority\": [\"성장\", \"안정\"] },
      \"skill\": [{ \"name\": \"분석\", \"level\": \"intermediate\" }],
      \"dislike\": { \"keywords\": [\"야근\"] },
      \"constraints\": {}
    }
  }")

TOP3_COUNT=$(echo "$ANALYZE" | jq -r '.result.fit_top3 | length')
QUESTIONS=$(echo "$ANALYZE" | jq -r '.result.followup_questions | length')
CANDIDATES=$(echo "$ANALYZE" | jq -r '.result.total_candidates')

echo "TOP3: $TOP3_COUNT, Questions: $QUESTIONS, Candidates: $CANDIDATES"

[ "$TOP3_COUNT" -ge 3 ] && T3="true" || T3="false"
check "$T3" "TOP3 generated"

[ "$QUESTIONS" -ge 1 ] && T4="true" || T4="false"
check "$T4" "Follow-up questions generated"

# ============================================
# Test 4: Candidate Pool Size (target: 80)
# ============================================
echo ""
echo -e "${YELLOW}[Test 4] Candidate Pool Size${NC}"
echo "Total candidates: $CANDIDATES"
[ "$CANDIDATES" -ge 10 ] && T5="true" || T5="false"
check "$T5" "Candidate pool >= 10 (Phase 1B target)"

# ============================================
# Test 5: Follow-up Changes Ranking
# ============================================
echo ""
echo -e "${YELLOW}[Test 5] Follow-up Changes Ranking${NC}"

# Get initial TOP3
INITIAL_TOP=$(echo "$ANALYZE" | jq -r '.result.fit_top3[0].job_id')
echo "Initial TOP1: $INITIAL_TOP"

# Submit follow-up (wlb preference)
FOLLOWUP=$(curl -s -X POST "$BASE_URL/api/ai-analyzer/followup" \
  -H "Content-Type: application/json" \
  -d "{
    \"session_id\": \"$SESSION\",
    \"question_id\": \"tradeoff_salary_vs_wlb\",
    \"fact_key\": \"tradeoff.salary_vs_wlb\",
    \"answer\": \"wlb\"
  }")

FACT_SAVED=$(echo "$FOLLOWUP" | jq -r '.fact_saved.fact_key')
echo "Fact saved: $FACT_SAVED"

# Re-analyze
REANALYZE=$(curl -s -X POST "$BASE_URL/api/ai-analyzer/analyze" \
  -H "Content-Type: application/json" \
  -d "{
    \"session_id\": \"$SESSION\",
    \"user_id\": \"test\",
    \"profile\": {
      \"interest\": { \"keywords\": [\"기술\", \"분석\", \"연구\"] },
      \"value\": { \"priority\": [\"성장\", \"안정\"] },
      \"skill\": [{ \"name\": \"분석\", \"level\": \"intermediate\" }],
      \"dislike\": { \"keywords\": [\"야근\"] },
      \"constraints\": {}
    }
  }")

NEW_TOP=$(echo "$REANALYZE" | jq -r '.result.fit_top3[0].job_id')
FACTS_APPLIED=$(echo "$REANALYZE" | jq -r '.facts_applied')
EXPLANATION=$(echo "$REANALYZE" | jq -r '.result.llm_explanation')

echo "New TOP1: $NEW_TOP"
echo "Facts applied: $FACTS_APPLIED"
echo "Explanation: $EXPLANATION"

# Check if ranking changed or scores changed
if [ "$INITIAL_TOP" != "$NEW_TOP" ]; then
  echo "Ranking changed!"
  T6="true"
else
  # Check if scores changed
  INITIAL_SCORE=$(echo "$ANALYZE" | jq -r '.result.fit_top3[0].like_score')
  NEW_SCORE=$(echo "$REANALYZE" | jq -r '.result.fit_top3[0].like_score')
  if [ "$INITIAL_SCORE" != "$NEW_SCORE" ]; then
    echo "Scores changed: $INITIAL_SCORE -> $NEW_SCORE"
    T6="true"
  else
    echo "No change detected"
    T6="false"
  fi
fi
check "$T6" "Follow-up changes ranking/scores"

# ============================================
# Test 6: 10 Different Sessions Test
# ============================================
echo ""
echo -e "${YELLOW}[Test 6] Multiple Session Variations${NC}"
CHANGE_COUNT=0

for i in $(seq 1 10); do
  SESSION_N="multi-test-$i-$(date +%s)"
  
  # Initial analyze
  A1=$(curl -s -X POST "$BASE_URL/api/ai-analyzer/analyze" \
    -H "Content-Type: application/json" \
    -d "{\"session_id\":\"$SESSION_N\",\"user_id\":\"test\",\"profile\":{\"interest\":{\"keywords\":[\"test\"]},\"value\":{\"priority\":[]},\"skill\":[],\"dislike\":{\"keywords\":[]},\"constraints\":{}}}")
  
  SCORE1=$(echo "$A1" | jq -r '.result.fit_top3[0].like_score // 0')
  
  # Submit followup
  curl -s -X POST "$BASE_URL/api/ai-analyzer/followup" \
    -H "Content-Type: application/json" \
    -d "{\"session_id\":\"$SESSION_N\",\"question_id\":\"tradeoff_salary_vs_wlb\",\"fact_key\":\"tradeoff.salary_vs_wlb\",\"answer\":\"wlb\"}" > /dev/null
  
  # Re-analyze
  A2=$(curl -s -X POST "$BASE_URL/api/ai-analyzer/analyze" \
    -H "Content-Type: application/json" \
    -d "{\"session_id\":\"$SESSION_N\",\"user_id\":\"test\",\"profile\":{\"interest\":{\"keywords\":[\"test\"]},\"value\":{\"priority\":[]},\"skill\":[],\"dislike\":{\"keywords\":[]},\"constraints\":{}}}")
  
  SCORE2=$(echo "$A2" | jq -r '.result.fit_top3[0].like_score // 0')
  
  if [ "$SCORE1" != "$SCORE2" ]; then
    ((CHANGE_COUNT++))
  fi
done

echo "Sessions with ranking change: $CHANGE_COUNT/10"
[ "$CHANGE_COUNT" -ge 5 ] && T7="true" || T7="false"
check "$T7" "At least 5/10 sessions show score change"

# ============================================
# Summary
# ============================================
echo ""
echo "========================================"
echo "PHASE 1B SMOKE TEST SUMMARY"
echo "========================================"
echo "Results: $PASS_COUNT passed, $FAIL_COUNT failed"

if [ "$FAIL_COUNT" -eq 0 ]; then
  echo -e "${GREEN}========================================${NC}"
  echo -e "${GREEN}Phase 1B: ALL TESTS PASSED!${NC}"
  echo -e "${GREEN}========================================${NC}"
  exit 0
else
  echo -e "${RED}========================================${NC}"
  echo -e "${RED}Phase 1B: SOME TESTS FAILED${NC}"
  echo -e "${RED}========================================${NC}"
  exit 1
fi








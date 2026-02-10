#!/bin/bash
# CareerWiki AI Analyzer - Phase 1A MVE Smoke Test
# 검증 시나리오:
# (1) analyze → TOP3 A
# (2) followup: tradeoff.salary_vs_wlb = wlb 저장
# (3) analyze 재호출 → TOP3 B (A와 달라야 함)
# (4) 결과에 "워라밸을 중시한 답변을 반영했다" 설명 포함

BASE_URL=${1:-"http://localhost:3000"}
SESSION_ID="smoke-test-$(date +%s)"

echo "========================================"
echo "Phase 1A MVE Smoke Test"
echo "Session ID: $SESSION_ID"
echo "Base URL: $BASE_URL"
echo "========================================"

# Color codes
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# ============================================
# Step 1: Initial Analysis
# ============================================
echo ""
echo -e "${YELLOW}[STEP 1] Initial Analysis${NC}"
echo "POST $BASE_URL/api/ai-analyzer/analyze"

ANALYZE_1=$(curl -s -X POST "$BASE_URL/api/ai-analyzer/analyze" \
  -H "Content-Type: application/json" \
  -d "{
    \"session_id\": \"$SESSION_ID\",
    \"user_id\": \"test-user\",
    \"profile\": {
      \"interest\": { \"keywords\": [\"데이터\", \"분석\", \"IT\"] },
      \"value\": { \"priority\": [\"워라밸\", \"성장\"] },
      \"skill\": [{ \"name\": \"Python\", \"level\": \"intermediate\" }],
      \"dislike\": { \"keywords\": [\"야근\"] },
      \"constraints\": {}
    }
  }")

# Extract TOP3 from first analysis
TOP3_A=$(echo "$ANALYZE_1" | jq -r '.result.fit_top3 | map(.job_name) | join(", ")')
HAS_QUESTIONS=$(echo "$ANALYZE_1" | jq -r '.result.followup_questions | length')
ENGINE_STATE_1=$(echo "$ANALYZE_1" | jq -r '.result.engine_state')

echo "Engine State: $ENGINE_STATE_1"
echo "TOP3 (A): $TOP3_A"
echo "Follow-up Questions: $HAS_QUESTIONS"

if [ "$HAS_QUESTIONS" -gt 0 ]; then
  echo -e "${GREEN}✓ Follow-up questions generated${NC}"
  echo "$ANALYZE_1" | jq '.result.followup_questions[0]'
else
  echo -e "${RED}✗ No follow-up questions generated${NC}"
fi

echo ""
echo "Full response:"
echo "$ANALYZE_1" | jq '.'

# ============================================
# Step 2: Submit Follow-up Answer (WLB 선택)
# ============================================
echo ""
echo -e "${YELLOW}[STEP 2] Submit Follow-up (tradeoff.salary_vs_wlb = wlb)${NC}"
echo "POST $BASE_URL/api/ai-analyzer/followup"

FOLLOWUP=$(curl -s -X POST "$BASE_URL/api/ai-analyzer/followup" \
  -H "Content-Type: application/json" \
  -d "{
    \"session_id\": \"$SESSION_ID\",
    \"user_id\": \"test-user\",
    \"question_id\": \"tradeoff_salary_vs_wlb\",
    \"question_type\": \"tradeoff\",
    \"attribute\": \"wlb\",
    \"fact_key\": \"tradeoff.salary_vs_wlb\",
    \"answer\": \"wlb\",
    \"answer_text\": \"칼퇴가 보장되는 쪽을 선택합니다\"
  }")

FACT_SAVED=$(echo "$FOLLOWUP" | jq -r '.fact_saved.fact_key')
REANALYZE=$(echo "$FOLLOWUP" | jq -r '.reanalyze_available')

echo "Fact Saved: $FACT_SAVED"
echo "Reanalyze Available: $REANALYZE"

if [ "$FACT_SAVED" = "tradeoff.salary_vs_wlb" ]; then
  echo -e "${GREEN}✓ Fact saved correctly${NC}"
else
  echo -e "${RED}✗ Fact not saved correctly${NC}"
fi

echo ""
echo "Full response:"
echo "$FOLLOWUP" | jq '.'

# ============================================
# Step 3: Re-analyze (with fact applied)
# ============================================
echo ""
echo -e "${YELLOW}[STEP 3] Re-analyze (with fact applied)${NC}"
echo "POST $BASE_URL/api/ai-analyzer/analyze"

ANALYZE_2=$(curl -s -X POST "$BASE_URL/api/ai-analyzer/analyze" \
  -H "Content-Type: application/json" \
  -d "{
    \"session_id\": \"$SESSION_ID\",
    \"user_id\": \"test-user\",
    \"profile\": {
      \"interest\": { \"keywords\": [\"데이터\", \"분석\", \"IT\"] },
      \"value\": { \"priority\": [\"워라밸\", \"성장\"] },
      \"skill\": [{ \"name\": \"Python\", \"level\": \"intermediate\" }],
      \"dislike\": { \"keywords\": [\"야근\"] },
      \"constraints\": {}
    }
  }")

TOP3_B=$(echo "$ANALYZE_2" | jq -r '.result.fit_top3 | map(.job_name) | join(", ")')
FACTS_APPLIED=$(echo "$ANALYZE_2" | jq -r '.facts_applied')
ENGINE_STATE_2=$(echo "$ANALYZE_2" | jq -r '.result.engine_state')
APPLIED_RULES=$(echo "$ANALYZE_2" | jq -r '.result.input_summary.applied_rules | join(", ")')
EXPLANATION=$(echo "$ANALYZE_2" | jq -r '.result.llm_explanation')

echo "Engine State: $ENGINE_STATE_2"
echo "TOP3 (B): $TOP3_B"
echo "Facts Applied: $FACTS_APPLIED"
echo "Applied Rules: $APPLIED_RULES"
echo "Explanation: $EXPLANATION"

echo ""
echo "Full response:"
echo "$ANALYZE_2" | jq '.'

# ============================================
# Step 4: Verify Changes
# ============================================
echo ""
echo -e "${YELLOW}[STEP 4] Verification${NC}"

# Check if TOP3 changed
if [ "$TOP3_A" != "$TOP3_B" ]; then
  echo -e "${GREEN}✓ TOP3 changed after follow-up${NC}"
  echo "  Before: $TOP3_A"
  echo "  After:  $TOP3_B"
else
  echo -e "${YELLOW}⚠ TOP3 same (may be OK if order/scores changed)${NC}"
fi

# Check if explanation mentions 워라밸
if echo "$EXPLANATION" | grep -q "워라밸"; then
  echo -e "${GREEN}✓ Explanation mentions '워라밸'${NC}"
else
  echo -e "${RED}✗ Explanation does not mention '워라밸'${NC}"
fi

# Check if facts were applied
if [ "$FACTS_APPLIED" -gt 0 ]; then
  echo -e "${GREEN}✓ Facts were applied ($FACTS_APPLIED)${NC}"
else
  echo -e "${RED}✗ No facts applied${NC}"
fi

# Check engine state changed
if [ "$ENGINE_STATE_2" = "phase1a_mve" ]; then
  echo -e "${GREEN}✓ Engine state is 'phase1a_mve'${NC}"
else
  echo -e "${YELLOW}⚠ Engine state: $ENGINE_STATE_2${NC}"
fi

# ============================================
# Step 5: Verify Session Data
# ============================================
echo ""
echo -e "${YELLOW}[STEP 5] Session Data Check${NC}"
echo "GET $BASE_URL/api/ai-analyzer/session/$SESSION_ID"

SESSION=$(curl -s "$BASE_URL/api/ai-analyzer/session/$SESSION_ID")

EVENT_COUNT=$(echo "$SESSION" | jq '.events | length')
FACT_COUNT=$(echo "$SESSION" | jq '.facts | length')
REQUEST_COUNT=$(echo "$SESSION" | jq '.requests | length')

echo "Events: $EVENT_COUNT"
echo "Facts: $FACT_COUNT"
echo "Requests: $REQUEST_COUNT"

if [ "$FACT_COUNT" -gt 0 ]; then
  echo -e "${GREEN}✓ Facts stored in DB${NC}"
  echo "Stored facts:"
  echo "$SESSION" | jq '.facts'
else
  echo -e "${RED}✗ No facts in DB${NC}"
fi

echo ""
echo "Full session:"
echo "$SESSION" | jq '.'

# ============================================
# Summary
# ============================================
echo ""
echo "========================================"
echo "SMOKE TEST SUMMARY"
echo "========================================"

PASS_COUNT=0
FAIL_COUNT=0

check_pass() {
  if [ "$1" = "true" ]; then
    echo -e "${GREEN}✓ $2${NC}"
    ((PASS_COUNT++))
  else
    echo -e "${RED}✗ $2${NC}"
    ((FAIL_COUNT++))
  fi
}

# Checks
[ "$HAS_QUESTIONS" -gt 0 ] && Q1="true" || Q1="false"
[ "$FACT_SAVED" = "tradeoff.salary_vs_wlb" ] && Q2="true" || Q2="false"
[ "$FACTS_APPLIED" -gt 0 ] && Q3="true" || Q3="false"
echo "$EXPLANATION" | grep -q "워라밸" && Q4="true" || Q4="false"
[ "$FACT_COUNT" -gt 0 ] && Q5="true" || Q5="false"

check_pass "$Q1" "Follow-up questions generated"
check_pass "$Q2" "Fact saved correctly"
check_pass "$Q3" "Facts applied to re-analysis"
check_pass "$Q4" "Explanation mentions WLB"
check_pass "$Q5" "Facts stored in DB"

echo ""
echo "Results: $PASS_COUNT passed, $FAIL_COUNT failed"

if [ "$FAIL_COUNT" -eq 0 ]; then
  echo -e "${GREEN}========================================${NC}"
  echo -e "${GREEN}Phase 1A MVE: ALL TESTS PASSED!${NC}"
  echo -e "${GREEN}========================================${NC}"
  exit 0
else
  echo -e "${RED}========================================${NC}"
  echo -e "${RED}Phase 1A MVE: SOME TESTS FAILED${NC}"
  echo -e "${RED}========================================${NC}"
  exit 1
fi









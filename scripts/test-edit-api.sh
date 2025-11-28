#!/bin/bash
# Phase 4 편집 시스템 API 테스트 스크립트
# 
# 사용법: ./scripts/test-edit-api.sh
# 
# 사전 요구사항:
# - 서버가 http://localhost:3000에서 실행 중이어야 함
# - npm run dev 또는 npm run dev:sandbox 실행 필요

BASE_URL="http://localhost:3000"
TEST_JOB_ID="159"  # 가구제조,수리원

echo "🧪 Phase 4 편집 시스템 API 테스트"
echo "=================================="
echo ""

# 테스트 1: 익명 편집 (비밀번호 없이 - 실패해야 함)
echo "테스트 1: 익명 편집 (비밀번호 없이) - 실패 예상"
RESPONSE=$(curl -s -X POST "$BASE_URL/api/job/$TEST_JOB_ID/edit" \
  -H "Content-Type: application/json" \
  -d '{
    "field": "summary",
    "content": "테스트 편집 내용",
    "source": "https://example.com",
    "anonymous": true
  }')

if echo "$RESPONSE" | grep -q "PASSWORD_REQUIRED\|password"; then
  echo "✅ 테스트 1 통과: 비밀번호 없이 편집 시도 시 에러 반환"
else
  echo "❌ 테스트 1 실패: 예상된 에러가 반환되지 않음"
  echo "   Response: $RESPONSE"
fi
echo ""

# 테스트 2: 익명 편집 (비밀번호 포함 - 성공해야 함)
echo "테스트 2: 익명 편집 (비밀번호 포함) - 성공 예상"
RESPONSE=$(curl -s -X POST "$BASE_URL/api/job/$TEST_JOB_ID/edit" \
  -H "Content-Type: application/json" \
  -d '{
    "field": "summary",
    "content": "테스트 편집 내용 (익명)",
    "source": "https://example.com/test",
    "anonymous": true,
    "password": "1234"
  }')

if echo "$RESPONSE" | grep -q "success.*true\|revisionId"; then
  echo "✅ 테스트 2 통과: 익명 편집 성공"
  echo "   Response: $RESPONSE"
else
  echo "❌ 테스트 2 실패: 편집이 성공하지 않음"
  echo "   Response: $RESPONSE"
fi
echo ""

# 테스트 3: Revision 목록 조회
echo "테스트 3: Revision 목록 조회"
RESPONSE=$(curl -s "$BASE_URL/api/job/$TEST_JOB_ID/revisions")
if echo "$RESPONSE" | grep -q "success.*true\|revisions"; then
  echo "✅ 테스트 3 통과: Revision 목록 조회 성공"
else
  echo "❌ 테스트 3 실패: Revision 목록 조회 실패"
  echo "   Response: $RESPONSE"
fi
echo ""

echo "테스트 완료!"


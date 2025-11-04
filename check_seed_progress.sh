#!/bin/bash
# Seed 진행 상황 확인 스크립트

echo "🔍 Seed 진행 상황 확인 중..."
echo ""

# 최근 진행 상황 로그 확인
PROGRESS=$(pm2 logs careerwiki --nostream --lines 50 2>&1 | grep "📊 진행 상황" | tail -1)

if [ -n "$PROGRESS" ]; then
    echo "$PROGRESS"
    echo ""
    
    # 퍼센트 추출
    PERCENT=$(echo "$PROGRESS" | grep -oP '\(\K[0-9]+(?=%\))')
    
    if [ "$PERCENT" = "100" ]; then
        echo "🎉 Seed 완료!"
        echo ""
        echo "✅ 데이터베이스 직업 수 확인 중..."
        curl -s "http://localhost:3000/api/jobs?page=1&perPage=1" | python3 -c "
import sys, json
try:
    data = json.load(sys.stdin)
    total = data.get('total', 0)
    print(f'✅ 총 {total}개 직업 저장됨')
except:
    pass
"
    else
        echo "⏳ 진행 중... ($PERCENT% 완료)"
        echo "💡 다시 확인하려면: bash /home/user/webapp/check_seed_progress.sh"
    fi
else
    echo "⚠️  진행 상황을 찾을 수 없습니다."
    echo "💡 Seed가 시작되었는지 확인하세요."
    echo ""
    echo "📝 최근 로그 (마지막 10줄):"
    pm2 logs careerwiki --nostream --lines 10 2>&1 | tail -10
fi

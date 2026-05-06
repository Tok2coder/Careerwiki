---
name: stop-validate-pending
event: Stop
matcher:
  recent_tools: ["Edit", "Write"]
description: 턴 종료 시 코드 변경이 있었으면 validate-job-edit + git status 자동 실행.
blocking: false
---

# Stop — Validate Pending Changes

## Why

이미 careerwiki `.claude/settings.json`에 LLM 기반 Stop hook이 등록되어 있지만 (자기검증 prompt), **결정적 스크립트** 검증을 추가로 실행. LLM 자가 검증은 false-pass 가능.

## When fires

- 턴 종료 (Stop) 시점, 그 턴 안에서 `Edit` 또는 `Write`가 1회 이상 호출된 경우

## Action

```bash
cd "$CLAUDE_PROJECT_DIR"

# 1. 가장 최근에 수정된 draft JSON이 있으면 validate
RECENT_DRAFT=$(ls -t scripts/skill-cache/*.json scripts/skill-cache/draft-*.json scripts/skill-cache/edit-*.json 2>/dev/null | head -1)

if [ -n "$RECENT_DRAFT" ]; then
  AGE=$(( $(date +%s) - $(stat -c %Y "$RECENT_DRAFT") ))
  if [ "$AGE" -lt 600 ]; then
    echo "[validate-pending] 최근 draft 검증: $RECENT_DRAFT"
    node scripts/validate-job-edit.cjs "$RECENT_DRAFT" 2>&1 | tail -20
  fi
fi

# 2. git status (uncommitted 변경 보고)
echo ""
echo "[git status]"
git status --short | head -20

# 3. 변경된 src/ 파일 있으면 tsc 재확인
if git status --short | grep -qE "^.M src/.*\.(ts|tsx)$|^A.*src/.*\.(ts|tsx)$"; then
  echo ""
  echo "[tsc check — src/ 변경 있음]"
  npx tsc --noEmit 2>&1 | tail -10
fi

exit 0
```

## Notes

- **비차단** — 알림 + 보고만. 사용자가 결과 보고 다음 행동 결정.
- 기존 settings.json의 LLM Stop hook (자기검증 prompt)는 그대로 둠 — 보완 관계.
- `validate-job-edit.cjs`는 PASS면 silent, FAIL이면 violation 출력.
- draft JSON 10분 이내만 검증 (오래된 파일은 skip).

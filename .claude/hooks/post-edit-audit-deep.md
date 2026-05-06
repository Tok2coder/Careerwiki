---
name: post-edit-audit-deep
event: PostToolUse
matcher:
  tools: ["Bash"]
  command_pattern: "POST.*api/job/.*/edit"
  exit_code: 0
description: 직업 편집 API 호출 성공 직후 audit-sources-deep 자동 실행 + WARN/FAIL 보고.
blocking: false
---

# Post-Edit Deep Audit

## Why

편집 API POST 후 prod 데이터에 9패턴 이슈 (origin / orphan / dup / rawURL / brokenRef / markerCluster / listPage / mojibake / idxGap)가 남아있을 수 있음. 자기검증 LLM에 맡기면 false-pass 가능 — **결정적 스크립트**로 audit해야 함.

## When fires

- `Bash` 도구가 `POST .../api/job/{id}/edit` 명령을 **exit 0 (성공)** 으로 끝낸 직후

## Action

slug 추출 → audit-sources-deep 실행:

```bash
CMD="$CLAUDE_TOOL_INPUT"

# slug 또는 job_id 추출
JOB_ID=$(echo "$CMD" | grep -oE "/api/job/[^/]+/edit" | sed -E "s|/api/job/([^/]+)/edit|\1|")

if [ -z "$JOB_ID" ]; then
  echo "[audit-deep] job id 추출 실패 — skip"
  exit 0
fi

cd "$CLAUDE_PROJECT_DIR"

# id가 숫자면 slug 조회, 슬러그면 직접 사용
if [[ "$JOB_ID" =~ ^[0-9]+$ ]]; then
  SLUG=$(node -e "
    const { execSync } = require('child_process');
    const r = execSync('wrangler d1 execute careerwiki-kr --remote --command \"SELECT slug FROM jobs WHERE id=$JOB_ID\" --json', { encoding: 'utf8' });
    const j = JSON.parse(r);
    console.log(j[0]?.results?.[0]?.slug || '');
  ")
else
  SLUG="$JOB_ID"
fi

if [ -z "$SLUG" ]; then
  echo "[audit-deep] slug 조회 실패 — manual 확인 필요"
  exit 0
fi

echo "[audit-deep] 실행: $SLUG"
node scripts/skill-cache/audit-sources-deep.cjs --slug="$SLUG" 2>&1 | tail -50

# WARN/FAIL 카운트 추출 후 사용자 alert
RESULT=$?
if [ "$RESULT" -ne 0 ]; then
  echo ""
  echo "⚠ audit-deep WARN/FAIL 발견. 위 로그 확인 후 fix 필요."
fi

exit 0  # 비차단 (보고만)
```

## Notes

- `blocking: false` — audit 결과는 **알림용**. fail이라도 다음 작업 진행 가능 (단, 사용자가 fix 안 하면 prod에 dirty data 남음).
- 글로벌 CLAUDE.md `Validation Loops → Data 변경 시`의 9 패턴 audit 자동 실행 버전.
- `audit-sources-deep.cjs`는 `scripts/skill-cache/`에 위치.

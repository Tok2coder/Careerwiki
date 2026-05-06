---
name: post-edit-tsc-check
event: PostToolUse
matcher:
  tools: ["Edit", "Write"]
  files:
    - "**/*.ts"
    - "**/*.tsx"
description: Edit/Write로 .ts/.tsx 수정 후 tsc --noEmit clean 보장. fail 시 사용자 alert.
blocking: false
---

# Post-Edit TypeScript Check

## Why

`.ts`/`.tsx` 변경 후 타입 에러를 빌드/배포까지 미루면 발견이 늦어 fix 비용이 커진다. PostToolUse 시점에 즉시 검증.

## When fires

- `Edit` / `Write` 도구가 `*.ts` 또는 `*.tsx` 파일에 적용된 직후

## Action

```bash
cd "$CLAUDE_PROJECT_DIR" && npx tsc --noEmit 2>&1
```

- exit 0 → silent (no-op)
- exit ≠ 0 → 사용자에게 alert:
  - 에러 발생 파일·줄 출력 (stderr 마지막 30줄)
  - 메시지: "TypeScript 에러 발생. 다음 작업 전 fix 필요."

## Notes

- `safe-deploy.cjs`도 tsc를 실행하지만 그건 deploy 시점. 이 hook은 **edit 직후 즉시** 발견 목적.
- `.claude/`, `node_modules/`, `migrations/` 내 변경은 무시 (matcher의 files 패턴이 src 위주로 맞춰짐).
- 대규모 변경 시 tsc가 10초 이상 걸릴 수 있음 — 비차단 (blocking: false).

## Hookify install

이 hook은 **hookify 자동 인식 형식**. `npx hookify install`로 `.claude/settings.json`에 자동 등록되며, 미설치 시 사용자가 수동으로 settings.json `hooks.PostToolUse`에 추가해야 함:

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          { "type": "command", "command": "node .claude/hooks/runner.cjs post-edit-tsc-check" }
        ]
      }
    ]
  }
}
```

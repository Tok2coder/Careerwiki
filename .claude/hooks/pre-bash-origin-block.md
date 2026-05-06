---
name: pre-bash-origin-block
event: PreToolUse
matcher:
  tools: ["Bash"]
  command_pattern: "POST.*api/job/.*/edit"
description: 직업 편집 API 호출 시 originDomain URL이 sources에 들어가면 차단. 자기자신 인용 방지.
blocking: true
---

# Pre-Bash Origin Self-Cite Block

## Why

CareerWiki는 정부 직업포털 (career.go.kr / work.go.kr / wagework.go.kr / work24.go.kr / job.go.kr) 데이터를 기반으로 함. 이 origin URL을 다시 sources로 등록하면 **자기자신 인용** = 사용자에게 무가치한 출처. dispatch agent (LLM)가 모르고 등록 시도하는 일이 반복됨.

## When fires

- `Bash` 도구가 `curl -X POST .../api/job/{id}/edit` 또는 동일 의미의 명령을 실행하기 직전

## Action (block decision)

command 본문 (`-d` 페이로드 또는 `@file.json`)을 검사:

```bash
PAYLOAD=$(echo "$CLAUDE_TOOL_INPUT" | grep -oE -- "-d (@?[^ ]+|'[^']+')" | sed -E "s/^-d //")

# 파일 경로면 read
if [[ "$PAYLOAD" =~ ^@ ]]; then
  PAYLOAD=$(cat "${PAYLOAD#@}")
fi

# origin 도메인 매칭
if echo "$PAYLOAD" | grep -qE "(career|wagework|work24|work)\.go\.kr|job\.go\.kr|careerwiki\.org"; then
  echo "BLOCKED: payload에 origin domain URL 포함."
  echo "차단 도메인: career.go.kr / work.go.kr / wagework.go.kr / work24.go.kr / job.go.kr / careerwiki.org"
  echo "조치: sources에서 해당 URL 제거 후 한국 1차 출처 (정부 deep page / 협회 deep page / 한국 미디어) 사용."
  exit 1
fi

exit 0
```

- exit 0 → 통과
- exit 1 → 차단 + alert. 사용자가 명시적으로 unblock해야 진행.

## Notes

- 글로벌 CLAUDE.md `Failure Modes → Origin Self-Cite`의 자동 enforcement 버전.
- `careerwiki.org`도 self-cite로 차단 (자기 사이트 인용 방지).
- 화이트리스트 필요 시 (예: career.go.kr 보도자료를 *예외적으로* 인용해야 할 때) 사용자가 직접 unblock.

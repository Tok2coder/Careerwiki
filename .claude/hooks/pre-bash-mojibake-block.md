---
name: pre-bash-mojibake-block
event: PreToolUse
matcher:
  tools: ["Bash"]
  command_pattern: "curl.*-d"
description: 인라인 한글이 들어간 curl -d payload를 차단. 파일 기반 -d @file.json 강제.
blocking: true
---

# Pre-Bash Mojibake Block

## Why

Windows bash에서 `curl -d '{"name":"한글"}'`은 인코딩 mismatch로 mojibake 발생 (한글이 깨져서 prod 저장됨). 사고 사례 다수 — Windows cp949 + bash UTF-8 변환 + curl shell escape의 조합으로 매우 자주 깨짐.

## When fires

- `Bash` 도구가 `curl ... -d ...` 형태 명령을 실행하기 직전

## Action (block decision)

```bash
CMD="$CLAUDE_TOOL_INPUT"

# -d @file.json 형태는 통과
if echo "$CMD" | grep -qE -- "-d @"; then
  exit 0
fi

# -d --data --data-raw --data-binary 인라인 페이로드 검사
PAYLOAD=$(echo "$CMD" | grep -oE -- "(--data(-raw|-binary)?|-d) ('[^']+'|\"[^\"]+\")" | head -1)

# 한글 (Hangul U+AC00–U+D7A3, 자모 U+1100–U+11FF, U+3130–U+318F) 매칭
if echo "$PAYLOAD" | grep -qP '[\x{AC00}-\x{D7A3}\x{1100}-\x{11FF}\x{3130}-\x{318F}]'; then
  echo "BLOCKED: curl -d 인라인 페이로드에 한글 포함."
  echo "이유: Windows bash + curl 조합에서 mojibake (한글 깨짐) 빈발."
  echo "조치:"
  echo "  1. 페이로드를 .json 파일로 저장 (UTF-8 BOM 없이)"
  echo "  2. curl -d @file.json 사용"
  echo "예: curl -X POST URL -H 'Content-Type: application/json; charset=utf-8' -d @payload.json"
  exit 1
fi

exit 0
```

## Notes

- 글로벌 CLAUDE.md `Failure Modes → Mojibake (Windows)`의 자동 enforcement.
- PowerShell/wsl에서도 동일 hook 적용 (사용자 환경에 따라 mojibake 양상은 다르지만 파일 기반이 일관성 있음).
- `--data-binary @file.json` `--data-raw` 등 변형도 매칭.

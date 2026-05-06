# Serena MCP — CareerWiki 적용 가이드

> Serena는 LSP(Language Server Protocol) 기반 코드 검색·리팩토링 MCP. 단순 grep보다 **심볼 단위·타입-aware** 검색·이동이 가능. 큰 코드베이스에서 함수·타입 사용처 추적, safe rename, dead code 탐지에 효과적.

## 적용 가치 (CareerWiki 기준)

CareerWiki는 ~50+ TypeScript 파일 (`src/services/ai-analyzer/` 등) + 50+ 마이그레이션. 다음 시나리오에서 grep/Edit보다 우월:

| 시나리오 | grep 한계 | Serena 강점 |
|---|---|---|
| `UnifiedJobDetail` 타입 사용처 전체 | 문자열 매칭만 → 동명이인·주석 노이즈 | LSP가 정확한 타입 참조만 반환 |
| `profileDataService.getJob` rename | 모든 호출처 수동 fix 필요 | LSP rename — 자동 일괄 (import 포함) |
| `src/routes/admin.ts` SQL 쿼리 패턴 검색 | template literal 안의 SQL은 grep으로 추출 노이즈 많음 | AST 기반 — `db.prepare()` 호출 인자 정확 추출 |
| `jobs` 테이블 컬럼 사용처 추적 | column명이 일반 변수명과 충돌 | 쿼리 문맥 한정 검색 가능 (custom rule) |
| dead code 탐지 (`personalized-scoring.ts` 미사용 export) | 호출처 없음 ≠ dead (re-export 체인) | call graph 분석 가능 |
| `services/ai-analyzer/` 50+ 파일 의존성 그래프 | 직접 추적 불가 | symbol graph 생성 |

## 설치

(2026-05-06 기준 — 최신 설치법은 Serena 공식 docs 확인)

```bash
# uv 또는 pip로 serena 설치
uv tool install serena-mcp
# 또는
pipx install serena-mcp
```

`~/.claude/mcp.json` (또는 careerwiki `.claude/mcp.json`)에 등록:

```json
{
  "mcpServers": {
    "serena": {
      "command": "serena-mcp",
      "args": ["--project", "C:/Users/user/Careerwiki"],
      "env": {
        "SERENA_LANGUAGE": "typescript"
      }
    }
  }
}
```

설치 검증: Claude Code 재시작 후 `mcp__serena__*` 툴이 deferred list에 노출되는지 확인.

## CareerWiki 첫 적용 작업 (권장 순서)

### 1. 코드베이스 인덱싱 (1회)
```
mcp__serena__index_project   (또는 동일 의미 툴)
```
- `src/`, `migrations/`, `scripts/` 인덱스 생성
- TypeScript LSP 기반 — `tsconfig.json` 자동 인식

### 2. 자주 쓰는 검색 패턴

**(a) 타입 사용처 전체:**
```
mcp__serena__find_references --symbol UnifiedJobDetail
```

**(b) 함수 호출 그래프:**
```
mcp__serena__call_graph --symbol "profileDataService.getJob"
```

**(c) DB 컬럼 사용처 (정확 매칭):**
```
mcp__serena__search --pattern "jobs\\.image_url|j\\.image_url" --kind sql_in_template
```
(serena가 SQL-in-TS template literal을 파싱할 수 있는 경우. 미지원 시 Grep으로 fallback.)

**(d) admin.ts 쿼리 인벤토리:**
```
mcp__serena__list_calls --file src/routes/admin.ts --target "db.prepare"
```

### 3. Refactor (예시)

**`personalized-scoring.ts`의 `scoreJob` 시그니처 변경 (param 추가):**

1. `find_references` — 모든 호출처 list
2. 호출처가 5+개면 — 사용자 컨펌 후 Serena rename/refactor 적용
3. tsc 재실행 (글로벌 Validation Loops)

## 주의사항

- **prod 데이터에 영향 X** — Serena는 코드 read/edit만. DB 직접 변경 X.
- **자동 rename 후 반드시 `npx tsc --noEmit` + `npm run build`** — LSP가 모든 case를 cover하지 못할 수 있음 (특히 dynamic require, JSX 동적 컴포넌트).
- **Serena가 인덱스에 없는 파일** — `.skill-cache/`, `.tmp-*` 등 임시 파일은 인덱스 제외 권장 (`.serenaignore` 생성).
- **마이그레이션 SQL은 LSP 인식 X** — `migrations/*.sql` 검색은 Grep 사용.
- **글로벌 룰 적용** — Serena 결과로 코드 변경 시 `~/.claude/CLAUDE.md` Validation Loops 그대로 적용 (tsc / Read 재확인 / Grep 충돌 확인).

## 사용 가치가 낮은 작업 (Serena 쓸 필요 없음)

- 단순 문자열 검색 (URL, slug, error message) → Grep 충분
- 단일 파일 내 변경 → Edit 직접
- 커밋 메시지·docs 검색 → grep `git log --grep`
- HTML 템플릿 (`templates/`) — Serena LSP는 HTML/JSX 안의 비코드 부분에 약함

## 다음 단계 (사용자 선택)

1. Serena 설치 + 인덱싱 → 첫 시범 작업: `UnifiedJobDetail` 사용처 전수 조사
2. 결과로 dead code / 미사용 export 발견 시 별도 cleanup PR
3. AI 추천 파이프라인 (`services/ai-analyzer/`) 의존성 그래프 시각화 → 리팩토링 우선순위 결정

## 참고

- Serena 공식: (사용자 직접 검색 — 이 문서 작성 시점 URL 검증 X)
- 글로벌 룰: `~/.claude/CLAUDE.md`
- 프로젝트 룰: `CLAUDE.md` (이 repo root)

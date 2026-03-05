# Standalone — Phase 11: 버그 수정 & 로직 개선

> **이 파일을 읽고 Team Leader로서 작업을 시작하세요.**
> Wave와 독립적으로 언제든 실행 가능합니다.

---

## 1. 공통 컨텍스트

### 프로젝트 개요
- **CareerWiki**: 한국어 진로 정보 위키 + AI 직업/전공 추천 플랫폼
- **Production**: https://careerwiki.org
- **Tech Stack**: Cloudflare Workers (Pages) + Hono + D1 (SQLite) + R2 + KV + Vectorize
- **AI/LLM**: Workers AI, OpenAI API (GPT-4o-mini)
- **Frontend**: TailwindCSS 3, TipTap editor
- **Build**: Vite, TypeScript strict mode

### 배포 절차 (모든 코드 수정 후 필수)
```
1. npx tsc --noEmit              # 타입 에러 0 확인
2. npm run build                  # = npm run build:css && vite build → dist/
3. npm run deploy                 # = npm run build && wrangler pages deploy dist/
   → 배포 완료 시 URL 출력 (*.careerwiki.pages.dev)
4. https://careerwiki.org 에서 변경 확인 (1-2분 propagation)
```

### 절대 금지
- `git stash`, `git reset --hard`, `git add -A`, `git add .`
- `.dev.vars` 커밋
- `DROP TABLE`, `DELETE FROM` (WHERE 없이)
- 로컬 dev 서버로 테스트 (프로덕션에서만 테스트)
- 커밋 메시지: `feat/fix/chore: [한국어 설명]` 형식 필수

### Cloudflare 바인딩
- `DB` → D1 (careerwiki-kr), `UPLOADS` → R2, `KV`, `VECTORIZE`, `AI` → Workers AI
- Vectorize, AI binding은 **프로덕션에서만** 동작

### 필수 읽기 파일
1. `CLAUDE.md` — 프로젝트 규칙 전체

---

## 2. 팀 구성

| 역할 | 모델 | 실행 방식 | 임무 |
|------|------|----------|------|
| Team Leader | Opus (메인) | 메인 세션 | 버그 트리아지, 우선순위 결정, 코드 리뷰 |
| Analyst | Sonnet | Task(run_in_background) | 코드 분석, 버그 재현 확인, 부작용 검증 |
| Researcher | Sonnet | Task(run_in_background) | 베스트 프랙티스 조사, 솔루션 비교 |
| Implementer | Sonnet | Task (순차) | 버그 수정, 리팩토링, 빌드, 배포 |

에이전트 정의: `.claude/agents/analyst.md`, `researcher.md`, `implementer.md`

### 실행 패턴
```
1. Team Leader: 현재 코드베이스 스캔 지시
2. Analyst → Task(run_in_background=true)로 전체 코드 분석
   - TODO/FIXME/HACK 주석 수집
   - 타입 에러, 데드코드, 미사용 import 탐지
   - 에러 핸들링 누락 지점 식별
   - 프로덕션 사이트에서 실제 동작 확인
3. Team Leader: 발견된 이슈 트리아지 (Critical → High → Medium → Low)
4. Implementer → Task로 우선순위 순서대로 수정
5. ★ 코드 리뷰 게이트 → Analyst 부작용 확인 → 배포
6. 반복
```

---

## 3. Phase 11 목표

Wave와 무관하게, 사이트 전반의 버그 수정 + 로직/알고리즘 개선

### 작업 범위

Phase 11은 **특정 파일에 한정되지 않습니다.** 전체 코드베이스가 대상입니다.
아래는 주요 관심 영역입니다:

#### A. 알려진 TODO/FIXME
```
src/services/ai-analyzer/routes.ts:6317
  → TODO: AggregatedProfile에서 AxisCoverage 추출 (빈 커버리지 사용 중)

public/static/api-client.js:1275
  → TODO: 클라이언트 로그인 상태 확인 로직 (항상 false 반환 중)
```

#### B. 버그 탐색 대상 영역
```
프론트엔드:
  - public/static/api-client.js       — API 호출, 에러 핸들링
  - public/static/scenario-runner.js   — 시나리오 테스트 러너
  - src/templates/**/*.tsx             — SSR 템플릿 렌더링

백엔드 라우트:
  - src/routes/*.ts                    — API 엔드포인트
  - src/index.tsx                      — 메인 엔트리포인트

서비스 로직:
  - src/services/*.ts                  — 비즈니스 로직
  - src/services/ai-analyzer/*.ts      — AI 추천 파이프라인

유틸리티:
  - src/utils/*.ts                     — 인증, 날짜, 포맷팅 등
  - src/middleware/*.ts                — 미들웨어
```

#### C. 로직/알고리즘 개선 관심사
```
- 에러 핸들링: try-catch 누락, 사용자에게 보이는 에러 메시지 품질
- 성능: 불필요한 DB 쿼리, N+1 문제, 캐시 미스
- 타입 안전성: any 타입 사용, 타입 단언(as) 남용
- 엣지 케이스: null/undefined 처리, 빈 배열/객체 처리
- 데드코드: 미사용 함수, 도달 불가 분기
```

---

## 4. 이슈 트리아지 기준

| 등급 | 기준 | 예시 |
|------|------|------|
| **Critical** | 사용자가 즉시 영향 받음, 기능 불가 | 페이지 크래시, 데이터 손실, 인증 우회 |
| **High** | 주요 기능 저하, 잘못된 결과 | 검색 결과 누락, 편집 저장 실패, UI 깨짐 |
| **Medium** | 사소한 UX 문제, 코드 품질 | 에러 메시지 불친절, 불필요한 API 호출 |
| **Low** | 코드 정리, 미래 대비 | 데드코드 제거, 타입 개선, TODO 해결 |

### 수정 순서
```
Critical → High → Medium → Low
같은 등급 내에서는 수정 범위가 작은 것부터 (빠른 승리)
```

---

## 5. 프로덕션 확인 방법

### 주요 페이지 동작 체크
```
1. 메인 페이지: https://careerwiki.org/
2. 검색: https://careerwiki.org/search?q=프로그래머
3. 직업 상세: https://careerwiki.org/job/소프트웨어-개발자
4. 전공 상세: https://careerwiki.org/major/컴퓨터공학
5. AI 추천: https://careerwiki.org/ai-analyzer
6. HowTo 목록: https://careerwiki.org/howto
```

### API 동작 체크
```
GET  /api/search?q=개발자&type=all          — 통합 검색
GET  /api/job/소프트웨어-개발자              — 직업 상세 API
POST /api/ai-analyzer/analyze               — AI 분석 시작
```

---

## 6. 실행 흐름

```
1. Team Leader: CLAUDE.md 읽기 → 팀 생성
2. Analyst: 전체 코드베이스 스캔 (TODO/FIXME, 타입 에러, 데드코드, 에러 핸들링)
   + 프로덕션 사이트 주요 페이지 동작 확인
3. Team Leader: Analyst 결과로 이슈 목록 생성 → 트리아지
4. 유저에게 이슈 목록 보고 → 우선순위 승인 요청
5. Implementer: 승인된 순서대로 수정
   - 수정 1건 → tsc 통과 → 코드 리뷰 게이트 → 배포
   - 다음 수정으로 이동
6. 모든 Critical/High 수정 완료 시 → 완료 보고서 작성
```

### ★ 유저 확인 게이트

Phase 11은 범위가 넓기 때문에 다음 시점에서 반드시 유저에게 보고합니다:

1. **스캔 완료 후**: 발견된 이슈 목록 + 트리아지 결과 보고
2. **각 수정 건별**: 무엇을 왜 어떻게 고쳤는지 요약
3. **배포 전**: 변경 파일 목록 + 영향 범위 보고

---

## 7. Context Compact 복원

컨텍스트가 compact되면 반드시:
1. 이 파일 (`docs/sessions/standalone-bugfix.md`) 다시 읽기
2. `git log --oneline -10` + `git diff HEAD` 확인
3. Team Leader의 가장 최근 메시지 확인
4. 현재 진행 중인 이슈 번호/내용 재확인

---

## 8. 완료 기준

- [ ] 코드베이스 전체 스캔 완료 (TODO/FIXME, 타입 에러, 데드코드)
- [ ] 이슈 트리아지 완료 (Critical/High/Medium/Low 분류)
- [ ] Critical 이슈 전부 수정
- [ ] High 이슈 전부 수정
- [ ] Medium 이슈 가능한 만큼 수정
- [ ] npx tsc --noEmit 통과
- [ ] npm run build 성공
- [ ] 프로덕션 배포 및 주요 페이지 동작 확인
- [ ] 완료 보고서 작성 (수정 내역, Before/After)

---

## 9. 다른 Phase와의 관계

- Phase 11은 **어떤 Wave와도 독립적**입니다
- 단, 다른 코드 수정 Phase가 동시에 돌고 있으면 **파일 충돌 가능**
- 동시 실행 시: 다른 Phase가 건드리는 파일은 피하고, 나머지 영역만 수정
- 배포도 다른 Phase와 겹치지 않게 순차 실행

# Agent Team Sessions — 세션 인덱스

> 각 세션의 Self-contained 시작 파일이 `docs/sessions/`에 있습니다.
> Claude Code Desktop에서 새 대화를 열고 해당 파일을 읽으면 팀 구성부터 Phase 완료까지 자동으로 진행됩니다.

---

## 사용법

Claude Code Desktop에서 새 대화를 열고 아래 프롬프트를 입력하세요:

```
docs/sessions/{파일명}.md 를 읽고 Team Leader로서 작업을 시작해.
```

---

## 에이전트 역할 요약

| 역할 | 페르소나 | 핵심 책임 | 정의 파일 |
|------|---------|-----------|-----------|
| **Team Leader** | 조율자 (Opus) | 팀 조율, 의사결정, 진행 보고 | 메인 세션 |
| **Analyst** | "김분석" (Sonnet) | 코드 깊이 분석, 테스트 채점, Before/After 비교 | `.claude/agents/analyst.md` |
| **Researcher** | "박리서치" (Sonnet) | 웹 검색, 베스트 프랙티스, 경쟁 분석, 팩트 체킹 | `.claude/agents/researcher.md` |
| **Content Creator** | "정콘텐츠" (Sonnet) | 콘텐츠 작성, 데이터 가공, 포맷 일관성 | `.claude/agents/content-creator.md` |
| **Implementer** | "이구현" (Sonnet) | 코드 수정, tsc→build→deploy 루프, git commit | `.claude/agents/implementer.md` |
| **Designer** | "최디자인" (Sonnet) | UI/UX 리뷰, 접근성, 근거 기반 개선안 (선택적) | `.claude/agents/designer.md` |

---

## Wave 1 (4 세션 동시)

| 세션 | Phase | 팀 구성 | 시작 파일 |
|------|-------|---------|-----------|
| A | Phase 3: RAG 검색 | Leader + Analyst + Researcher + Implementer | [`wave1-a-rag.md`](docs/sessions/wave1-a-rag.md) |
| B | Phase 4: 편집 시스템 | Leader + Analyst + Implementer | [`wave1-b-edit.md`](docs/sessions/wave1-b-edit.md) |
| C | Phase 5: 광고 셋업 | Leader + 풀팀 (5인) | [`wave1-c-ads.md`](docs/sessions/wave1-c-ads.md) |
| D | Phase 6: HowTo 콘텐츠 발행 | Leader + Researcher + Content Creator + Implementer | [`wave1-d-content.md`](docs/sessions/wave1-d-content.md) |

---

## Wave 2 (4 세션 동시, Wave 1 완료 후)

| 세션 | Phase | 팀 구성 | 시작 파일 |
|------|-------|---------|-----------|
| A | Phase 1: 직업 추천 | Leader + Analyst + Researcher + Implementer | [`wave2-a-job.md`](docs/sessions/wave2-a-job.md) |
| B | Phase 10: HowTo 에디터 | Leader + 풀팀 (4인) | [`wave2-b-howto.md`](docs/sessions/wave2-b-howto.md) |
| C | Phase 9: 관리자 대시보드 | Leader + 풀팀 (4인) | [`wave2-c-admin.md`](docs/sessions/wave2-c-admin.md) |
| D | Phase 7: 직업 정보 보완 | Leader + Analyst + Researcher + Content Creator + Implementer | [`wave2-d-jobdata.md`](docs/sessions/wave2-d-jobdata.md) |

> **Phase 7 선행 조건**: Phase 4 (편집 시스템) 완료 후 시작

---

## Wave 3 (2 세션, Wave 2 완료 후)

| 세션 | Phase | 팀 구성 | 시작 파일 |
|------|-------|---------|-----------|
| A | Phase 2: 전공 추천 | Leader + Analyst + Researcher + Implementer | [`wave3-a-major.md`](docs/sessions/wave3-a-major.md) |
| B | Phase 8: 신규 직업 추가 | Leader + Analyst + Researcher + Content Creator + Implementer | [`wave3-b-newjobs.md`](docs/sessions/wave3-b-newjobs.md) |

> **Phase 8 선행 조건**: Phase 7 (직업 정보 보완) 완료 후 시작

---

## 의존성 체인

```
Phase 6 (HowTo 콘텐츠) ─────────────────────────────────────────
Phase 4 (편집 시스템) ──→ Phase 7 (직업 정보 보완) ──→ Phase 8 (신규 직업 추가)
Phase 3 (RAG 검색) ──→ Phase 1 (직업 추천) ──→ Phase 2 (전공 추천)
Phase 5 (광고 셋업) ──→ Phase 9 (관리자)
Phase 4 (편집 시스템) ──→ Phase 10 (HowTo 에디터)
```

---

## Standalone (Wave 무관, 언제든 실행)

| 세션 | Phase | 팀 구성 | 시작 파일 |
|------|-------|---------|-----------|
| - | Phase 11: 버그 수정 & 로직 개선 | Leader + Analyst + Researcher + Implementer | [`standalone-bugfix.md`](docs/sessions/standalone-bugfix.md) |
| - | Phase 12: UI/UX 디자인 개선 | Leader + UX Researcher + UI Auditor + Frontend QA + Implementer | [`standalone-design.md`](docs/sessions/standalone-design.md) |
| - | Phase 13: 기술 감사 & 리포트 | Leader + Architecture Analyst + Product Analyst + Security & Ops Analyst | [`standalone-audit.md`](docs/sessions/standalone-audit.md) |
| - | Phase 14: 데이터 전문가 | Leader + **Database Architect (Opus)** + Data Pipeline Engineer + Web Data Specialist + Search & Vector Engineer | [`standalone-data.md`](docs/sessions/standalone-data.md) |
| - | Phase 15: UX 테스트 (MCP 브라우저) | Leader + Persona Navigator + **Competitive Researcher (Opus)** + Heuristic Evaluator + Issue Reporter | [`standalone-ux-test.md`](docs/sessions/standalone-ux-test.md) |

> **코드 수정 Phase (11, 12, 14)**: 다른 코드 수정 Phase와 동시 배포 금지. 파일 충돌 주의.
> Phase 11과 Phase 12는 수정 파일이 겹칠 수 있으므로 동시 실행 비권장.
> **읽기 전용 Phase (13, 15)**: 어떤 Phase와도 충돌 없이 언제든 실행 가능.
> Phase 14는 Phase A(감사)는 읽기 전용, Phase B(개선)부터 코드 수정 발생.

---

## 병렬 실행 규칙

- **코드 수정 세션** (Phase 1-5, 9, 10, 11, 12): 동시 배포 금지, 한 번에 하나만 `npm run deploy`
- **데이터 전용 세션** (Phase 6, 7, 8): 코드 수정 없음 (API 호출만) → 코드 세션과 병렬 가능
- **Phase 11 (버그 수정)**: Wave 무관하게 실행 가능, 단 다른 코드 세션과 파일 충돌 주의
- **Phase 13 (기술 감사)**: 읽기 전용 → 어떤 Phase와도 병렬 가능, 배포 없음
- **Phase 14 (데이터)**: Phase A 감사는 병렬 가능, Phase B 개선 시 배포 순서 조율 필요
- **Phase 15 (UX 테스트)**: 읽기 전용 → 어떤 Phase와도 병렬 가능, 배포 없음
- **Wave 간 핸드오프**: 다음 Wave 시작 전 `git pull` 필수

---

## Context Compact 복원

모든 에이전트는 컨텍스트가 compact되면:
1. 해당 세션 파일 (`docs/sessions/wave{N}-{x}-{name}.md`) 다시 읽기
2. `docs/phase-progress/phase-{N}-state.md` 읽기
3. `git log --oneline -5` 확인
4. Team Leader의 가장 최근 메시지 확인

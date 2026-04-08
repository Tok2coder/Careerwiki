# AGENTS.md — CareerWiki 에이전트 협업 규칙

> Claude(주 작업자)와 Codex(검증/리뷰)가 CareerWiki 프로젝트에서 협업할 때 반드시 따라야 할 규칙.

## 1. 프로젝트 개요

- **서비스**: CareerWiki (careerwiki.org) — 한국 직업 정보 위키
- **데이터**: 608개 전공, 6,945개 직업 (활성: is_active=1 기준)
- **기술 스택**: Cloudflare Workers (Pages), Hono (TypeScript/JSX), D1 (SQLite), R2, KV, Vectorize
- **편집 API**: `POST https://careerwiki.org/api/job/{id}/edit` — `X-Admin-Secret: careerwiki-admin-2026` 헤더 필수
- **배포**: `npm run deploy` (main 브랜치에서만. worktree 배포 시 다음 main 배포 때 롤백됨)

---

## 2. 데이터 규칙 (Data Rules)

### 2-1. 기존 데이터 보존

- 기존 필드 데이터 **삭제/덮어쓰기 금지** — 추가·수정만 허용
- `overviewSalary.wage` **절대 덮어쓰기 금지** — 임금 바 차트 데이터. validate-job-edit.cjs가 draft에 wage 포함 시 FAIL 처리
- `overviewProspect` 그래프 데이터 보존 필수
- `detailReady.researchList` **수정/추가/삭제 금지** — CareerNet 원본 데이터, 출처 각주도 달지 않음

### 2-2. 각주/출처 규칙 (Footnote Rules)

- 외부 출처 데이터는 반드시 인라인 각주 `[N]` 필수
- 각 필드의 `_sources` 는 `[1]`부터 독립 번호 시작
- 페이지 렌더링 시 `normalizeUserSources`가 `fieldOrder` 기준으로 **전역 통합 번호** 부여
- 각주 위치: 마침표 **뒤** — `"...한다.[1]"` (마침표 앞 `"...[1]."` 금지)
- **출처 없는 데이터 추가 금지** — 확인 불가 시 문장 제거
- `sidebarCerts` 항목 텍스트에 `[N]` 마커 금지 — 자격증명만 저장, 출처는 `_sources.sidebarCerts`에만 등록
- `detailReady.certificate` 항목에 `[N]` 사용 시 `_sources["detailReady.certificate"]` 등록 필수
- 임금(salary) 데이터는 반드시 참조 연도 명시 — `"2024년 기준 평균 연봉 약 X만 원"` 형식

### 2-3. 출처 배지 (Source Badge)

- 배지 카운트 = `API 출처(커리어넷, 1개) + userSourceCount` 합산
- 스킬은 배지 카운트에 신경 쓸 필요 없음 (렌더러 자동 계산)

### 2-4. detailReady 항목 타입

| 하위 필드 | 허용 타입 |
|-----------|----------|
| `curriculum` | plain string **전용** — `{text:"..."}` 객체 금지 |
| `training` | plain string **전용** — `{text:"..."}` 객체 금지 |
| `recruit` | `{text, url}` 객체 또는 plain string |
| `certificate` | plain string **전용** — `[N]` 사용 시 `_sources` 등록 필수 |
| `researchList` | CareerNet 원본 — **스킬 수정 금지** |

### 2-5. 필드 판단 매트릭스 (요약)

| 카테고리 | 대상 필드 | 행동 |
|----------|----------|------|
| 항상 새로 작성 | way, detailReady, trivia, wlbDetail, socialDetail, 커리어트리 | API 데이터와 무관하게 작성 |
| 보강 가능 | sidebarCerts, sidebarMajors, sal, prospect | API 충분→스킵, 부족→보강 |
| API 있으면 스킵 | overviewWork.main, technKnow, wlb/social 등급 | API null이면 리서치+출처 필수로 채움 |
| 공식 통계만 | abilityList, aptitude, satisfaction, educationDistribution, detailIndicators | 출처 없으면 null 유지 |

---

## 3. 코드 규칙 (Code Rules)

### 3-1. 핵심 파일

| 파일 | 역할 |
|------|------|
| `src/templates/unifiedJobDetail.ts` | 직업 상세 페이지 렌더러 — `normalizeUserSources`, `fieldOrder`, `renderSourcesCollapsible` |
| `src/templates/detailTemplateUtils.ts` | `applyInlineFootnotes` — 배열 항목 인라인 `[N]` 변환 |
| `scripts/validate-job-edit.cjs` | 편집 사전 검증 (12+ 규칙, FAIL 시 API 차단) |
| `scripts/full-quality-audit.cjs` | 배포 후 품질 감사 (5 게이트, 15 체크포인트) |
| `.claude/skills/job-data-enhance/SKILL.md` | 직업 데이터 고도화 스킬 정의 |

### 3-2. fieldOrder (각주 전역 번호 순서)

`normalizeUserSources` 내 `fieldOrder` 배열이 전역 각주 번호를 결정한다.  
DOM 렌더링 순서와 반드시 일치해야 함. 현재 순서:

```
summary → heroCategory → heroTags
→ overviewWork.* → overviewProspect.main
→ detailWlb.* → overviewSalary.sal → trivia
→ overviewAbilities.*
→ way
→ detailReady.curriculum → recruit → certificate → training → researchList
→ sidebarMajors → sidebarCerts
```

### 3-3. 렌더링 안전 규칙

- `way` 타입: **반드시 string** — 배열이면 500 에러 즉시 발생
- R2 이미지 키: `jobs/job-{slug}.webp` — `uploads/` prefix 절대 금지
- DB image_url: `/uploads/jobs/job-{slug}.webp?v={timestamp}`

---

## 4. 검증 체계 (Validation System)

### 4-1. validate-job-edit.cjs (사전 검증 — API 호출 전 필수)

| 규칙 | 유형 |
|------|------|
| way 길이 < 100자 | ERROR |
| way 타입 배열 | ERROR (치명) |
| overviewSalary.wage 포함 | ERROR (치명) |
| YouTube URL 포맷 오류 / 3개 초과 | ERROR |
| 각주 중복 (`[1]`이 2회 이상) | ERROR |
| _sources 없는데 [N] 있음 | ERROR |
| sources text에 URL 포함 | ERROR |
| detailReady.curriculum/training 객체 타입 | ERROR (치명) |
| sidebarCerts 텍스트에 `[N]` 패턴 | WARN |
| detailReady.researchList 수정 시도 | WARN |
| curriculum < 3개 | WARN |
| youtubeLinks 없음 | WARN |

### 4-2. full-quality-audit.cjs (사후 감사 — 배포 후 실행)

| Gate | 검사 내용 | 주요 체크 |
|------|----------|----------|
| Gate 1 | **각주 정합성** | `[N]` 중복, 비순차(1부터 연속), 마침표 앞 위치(`[N].` 패턴), `_sources` 불일치 |
| Gate 2 | **텍스트 완결성** | `overviewSalary.wage` 소실 감지 + way/sal/prospect/trivia/wlbDetail/socialDetail 잘린 문장·완성형 어미 검사 |
| Gate 3 | **YouTube 링크 검증** | URL 포맷(youtube.com/watch, youtu.be, shorts 등) + oembed API로 영상 재생 가능 여부 확인 |
| Gate 4 | **_sources ID 순서** | 전역 ID 오름차순 여부, 각 필드 내 `text`의 `[N]` 번호와 배열 인덱스 일치 여부 |
| Gate 5 | **추가 무결성** | heroCategory 존재, sidebarJobs 비어있지 않음, image_url 포맷(`/uploads/jobs/job-{slug}.webp`), way 타입(배열이면 FAIL), detailWlb.wlb/social 등급 존재 |

---

## 5. 워크플로우 (Workflow)

### 5-1. Claude (주 작업자)

1. `job-data-enhance` 스킬 적용: Phase 0-D(기존 각주 점검) → Phase 1(리서치) → Phase 2(품질 게이트) → Phase 3(저장) → Phase 4(프로덕션 검증) → Phase 5(각주·출처 수선)
2. 코드 수정, 버그 픽스: `npx tsc --noEmit` → `npm run build` → `npm run deploy` → 검증
3. 커밋: `feat/fix/chore: [한국어 설명]` 형식

### 5-2. Codex (검증/리뷰)

- 배치 완료 후 `full-quality-audit.cjs` 실행 → 품질 감사
- 렌더링 크로스체크: 각주 번호 순서, 배지 카운트 정합성
- 부작용 체크: 기존 데이터 변경 여부, 필드 누락
- 코드 변경 시 사이드이펙트 분석 (영향받는 모든 모듈 확인)

### 5-3. 에스컬레이션 규칙

- Codex 이슈 발견 → 리포트 작성 → Claude가 수정
- 판단 불가 / 데이터 신뢰도 불명확 → 사용자에게 에스컬레이션
- 배포 후 FAIL → 즉시 롤백 검토 후 원인 분석

---

## 6. 버그 대응 프로토콜 (Bug Protocol)

1. **근본 원인 분석(RCA)** 수행 — 증상이 아닌 원인을 찾아 수정
2. **재발 방지 3단계 방어** 적용:
   - SKILL.md 규칙 추가/수정
   - `validate-job-edit.cjs` 검증 규칙 추가
   - 렌더링 코드 처리 개선
3. 방어 조치 완료 후 다음 작업 진행
4. `memory/lessons-learned.md` 기록

---

## 7. 세션 관리 (Session Management)

- idle 세션 재활용 우선 (`start_code_task` 대신 `send_message`)
- 병렬 세션 최대 2~3개
- 작업 완료 후 worktree 정리 필수
- worktree 50개 이상 시 → 정리 먼저 실행 후 작업 시작
- worktree 배포 절대 금지 — 반드시 main 브랜치에서 배포

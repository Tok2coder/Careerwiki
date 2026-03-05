# Wave 2 / Session A — Phase 1: 직업 추천 품질 개선

> **이 파일을 읽고 팀을 구성한 뒤 Phase 1 작업을 시작하세요.**
> **선행 조건**: Wave 1의 Phase 3 (RAG 검색) 완료 후 시작. `git pull` 필수.

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
2. `MASTER_PLAN.md` — Phase 1 섹션 + 사전 검토 체크리스트 + 완료 보고서 템플릿
3. `docs/phase-progress/phase-3-state.md` — Phase 3 결과 (vectorize-pipeline 변경 확인)

---

## 2. 팀 구성

| 역할 | 모델 | 실행 방식 | 임무 |
|------|------|----------|------|
| Team Leader | Opus (메인) | 메인 세션 | 조율, 시나리오 평가, 코드 리뷰 |
| Analyst | Sonnet | Task(run_in_background) | 6개 E2E 시나리오 분석, 채점 |
| Researcher | Sonnet | Task(run_in_background) | 추천 시스템 베스트 프랙티스 |
| Implementer | Sonnet | Task (순차) | 코드 수정, 빌드, 배포 |

에이전트 정의: `.claude/agents/analyst.md`, `researcher.md`, `implementer.md`

### 실행 패턴
```
1. Analyst + Researcher → Task(run_in_background=true)로 병렬 실행
2. 결과 종합 후 Team Leader가 70점 미만 시나리오 식별
3. Implementer → Task로 순차 수정
4. ★ 코드 리뷰 게이트 → Analyst 재검증 → 배포
```

---

## 3. Phase 1 목표

AI 직업 추천 파이프라인의 정확도와 결과 품질을 반복 테스트하며 개선

### 이전 세션에서 완료된 작업
- `personalized-scoring.ts`: 18개 missing token mapping 추가 (배포 완료)
- `routes.ts`: 5개 ARCHETYPE_DB_QUERIES 추가 (배포 완료)
- **남은 작업**: 6개 E2E 시나리오 실행 + 채점 + 70점 미만 시나리오 수정

### 수정 대상 파일
```
src/services/ai-analyzer/
├── routes.ts                    (7,937줄) - 메인 API 라우트, 파이프라인 오케스트레이션
├── vectorize-pipeline.ts        (3,330줄) - Multi-Query 벡터 검색
├── llm-judge.ts                 (2,378줄) - LLM 다차원 평가 (Like/Can/Fit 점수)
├── llm-reporter.ts              (2,319줄) - 서사적 리포트 생성
├── personalized-scoring.ts      - 맞춤 점수 산출
├── tag-filter.ts                (2,064줄) - TAG 기반 필터링
├── fact-score-mapping.ts        (2,221줄) - Career-to-fact 스코어 매핑
├── test-scenarios.ts            (862줄)  - 6개 테스트 시나리오
├── growth-curve-matcher.ts      - 성장곡선 매칭
└── internal-conflict.ts         - 내부 갈등 감지
```

### 참고 파일 (읽기 전용)
```
src/routes/analyzer-job-page.ts  (10,050줄) - 프론트엔드 UI
src/services/ai-analyzer/types.ts (1,373줄) - 타입 정의
```

### 6개 테스트 시나리오
```
1. analytical_user     - 데이터 분석 지향 (Fit 60-95)
2. stability_seeker    - 안정 추구형 (Fit 55-90)
3. internal_conflict   - 자율 vs 안정 갈등 (Fit 50-85)
4. creative_user       - 포트폴리오 기반 (Fit 65-95)
5. low_can_user        - 경력 전환자 (Fit 40-75)
6. comprehensive_test  - 다기능 검증 (Fit 55-90)
```

### 검증 기준 (100점 만점)
```
- Top Jobs 매칭: 25점 (카테고리 키워드 히트)
- 제외 직업: 20점 (하드 필터 검증)
- Fit 점수 범위: 20점 (min-max 바운드)
- Like-Can 밸런스: 15점 (갭 검증)
- 기능 적용: 20점 (growthCurve, conflict, canFilter, balanceCap)
- 통과 기준: 70점 이상
```

### AI 파이프라인 흐름
```
Mini Module (5축) → Universal Questions (10개)
→ Deep Intake (서술형) → LLM Follow-up
→ Vector Search (600-800 후보) → TAG Filter
→ Personalized Scoring → LLM Judge
→ Diversity Guard → Premium Report
```

### E2E 시나리오 실행 방법
```
Admin 페이지: careerwiki.org/admin → AI Analyzer 탭
ScenarioRunner 클래스: src/templates/admin/scenarioRunner.ts

API 호출 시퀀스:
1. POST /api/ai-analyzer/analyze (세션 시작 + profile 제출)
2. POST /api/ai-analyzer/v3/narrative-facts (서술형 응답)
3. POST /api/ai-analyzer/v3/round-questions (LLM 라운드 질문 요청)
4. POST /api/ai-analyzer/v3/round-answers (라운드 답변 제출)
5. 3→4 반복 (3라운드)
6. POST /api/ai-analyzer/v3/recommend (최종 추천 요청)
```

---

## 4. 실행 흐름

```
1. Team Leader: 팀 생성 → Analyst → Researcher → Implementer 스폰
2. Analyst: test-scenarios.ts 6개 시나리오 전체 분석
   - scenarioRunner.ts 코드 분석으로 E2E 실행 흐름 추적
   - 시나리오별 100점 만점 채점 기준표 작성
   - 현재 코드의 잠재적 문제점 식별
3. Researcher: 추천 시스템 품질 평가 베스트 프랙티스 리서치
   - NDCG, MAP 등 추천 시스템 메트릭 참고
4. Team Leader: Analyst 채점 결과 기반으로 70점 미만 시나리오 식별
5. Implementer: 문제 시나리오 코드 수정 (한 번에 하나씩)
   - 수정 → npx tsc --noEmit 통과까지
6. ★ 코드 리뷰 게이트 (배포 전 필수):
   - Implementer → Team Leader: git diff 요약 보고
   - Team Leader: 변경 범위 확인
   - Analyst: 수정된 함수의 호출부 Grep → 부작용/회귀 위험 보고
     (특히 routes.ts, llm-judge.ts 수정 시 직업+전공 양쪽 영향 확인)
   - Team Leader: 문제 없으면 배포 승인
7. Implementer: npm run build → npm run deploy → 프로덕션 확인
8. Analyst: 재테스트 → Before/After 비교
9. 반복 (모든 시나리오 70+ 될 때까지)
10. Team Leader: 완료 보고서 작성 → 사용자 검증 안내
```

---

## 5. Context Compact 복원

컨텍스트가 compact되면 반드시:
1. 이 파일 (`docs/sessions/wave2-a-job.md`) 다시 읽기
2. `docs/phase-progress/phase-1-state.md` 읽기
3. `git log --oneline -5` + `git diff HEAD~1` 확인
4. Team Leader의 가장 최근 메시지 확인

---

## 6. 완료 기준

- [ ] 6개 E2E 시나리오 모두 70점 이상
- [ ] Top Jobs가 각 시나리오의 기대 카테고리와 일치
- [ ] 제외 직업이 결과에 포함되지 않음
- [ ] Fit 점수가 expectedFitRange 이내
- [ ] Phase 3 (RAG 검색) 회귀 테스트 통과
- [ ] npx tsc --noEmit 통과
- [ ] npm run build 성공
- [ ] 프로덕션 배포 및 확인 완료
- [ ] 완료 보고서 작성

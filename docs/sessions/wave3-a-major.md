# Wave 3 / Session A — Phase 2: 전공 추천 품질 개선

> **이 파일을 읽고 팀을 구성한 뒤 Phase 2 작업을 시작하세요.**
> **선행 조건**: Wave 2의 Phase 1 (직업 추천) 완료 후 시작. `git pull` 필수.

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
2. `MASTER_PLAN.md` — Phase 2 섹션 + 사전 검토 체크리스트 + 완료 보고서 템플릿
3. `docs/phase-progress/phase-1-state.md` — Phase 1 결과 (ai-analyzer 변경 확인)

---

## 2. 팀 구성

| 역할 | 모델 | 실행 방식 | 임무 |
|------|------|----------|------|
| Team Leader | Opus (메인) | 메인 세션 | 조율, 시나리오 평가, 코드 리뷰 |
| Analyst | Sonnet | Task(run_in_background) | 8개 시나리오 분석, 스테이지 검증 |
| Researcher | Sonnet | Task(run_in_background) | 전공 추천 베스트 프랙티스 |
| Implementer | Sonnet | Task (순차) | 코드 수정, 빌드, 배포 |

에이전트 정의: `.claude/agents/analyst.md`, `researcher.md`, `implementer.md`

### 실행 패턴
```
1. Analyst + Researcher → Task(run_in_background=true)로 병렬 실행
2. 결과 종합 후 Team Leader가 문제 시나리오 식별
3. Implementer → Task로 순차 수정
4. ★ 코드 리뷰 게이트 → Analyst 재검증 (직업+전공 양쪽) → 배포
```

---

## 3. Phase 2 목표

AI 전공 추천 파이프라인의 정확도와 결과 품질을 반복 테스트하며 개선

### 수정 대상 파일
```
src/services/ai-analyzer/
├── routes.ts                    - 전공 분석 API (직업과 공유)
├── vectorize-pipeline.ts        - 전공 벡터 검색
├── llm-judge.ts                 - judgeMajorCandidates 함수
├── llm-reporter.ts              - 전공 리포트 생성
├── test-scenarios-major.ts      (1,011줄) - 8개 전공 테스트 시나리오
├── tag-filter.ts                - applyMajorTagFilter 함수
└── premium-report-generator.ts  - generateMajorPremiumReport 함수
```

### 참고 파일 (읽기 전용)
```
src/routes/analyzer-major-page.ts (5,061줄) - 전공 분석기 UI
```

### 8개 전공 테스트 시나리오
```
1. 이과 STEM 학생 → 컴퓨터, 소프트웨어, 전자, 수학, 통계
2. 인문계 학생 → 심리학, 교육학, 사회과학
3. 창의적 학생 → 디자인, 시각예술, 애니메이션 (tagFilter: false)
4. 취업 중심 → 높은 취업률 전공 (tagFilter: true)
5. 갈등 학생 → 디자인 + 안정 혼합 (internalConflictRisk: true)
6. 수학 제약 → 수학 과목 제외 필수 (tagFilter: true)
7. 어린이 (미성년자 안전장치 엣지 케이스)
8. 초등학생 (미성년자 안전장치 엣지 케이스)
```

### 전공별 스테이지
```
major_child → major_elementary → major_middle → major_high
→ major_freshman → major_student → major_graduate
```

### Phase 1과의 차이점
- 전공은 스테이지(학년)별 분기가 있음
- 미성년자 보호 로직 포함
- 과목 기반 필터링 (좋아하는/싫어하는 과목)
- 취업률, 연계 직업 등 추가 평가 기준

---

## 4. 실행 흐름

```
1. Team Leader: 팀 생성 → 전원 스폰
2. Analyst: test-scenarios-major.ts 8개 시나리오 전체 분석
   - 스테이지별 분기 코드 추적 (routes.ts의 major 분기)
   - judgeMajorCandidates, applyMajorTagFilter 코드 분석
   - 미성년자 보호 로직 검증
   - 시나리오별 채점 기준표 작성
3. Researcher: 한국 대학 전공 추천 베스트 프랙티스 리서치
   - 전공 선택 가이드 사이트/서비스 분석
   - 전공별 취업률/연봉 데이터 소스 확인
4. Team Leader: Analyst 결과 기반으로 문제 시나리오 식별
5. Implementer: 문제 시나리오 수정 (한 번에 하나씩)
   - 수정 → npx tsc --noEmit 통과까지
6. ★ 코드 리뷰 게이트 (배포 전 필수):
   - Implementer → Team Leader: git diff 요약 보고
   - Analyst: 수정된 함수의 호출부 Grep → 부작용/회귀 위험 보고
     (routes.ts, llm-judge.ts 수정 시 직업+전공 양쪽 영향 반드시 확인)
   - Team Leader: 문제 없으면 배포 승인
7. Implementer: npm run build → npm run deploy → 프로덕션 확인
8. Analyst: 재테스트 → Before/After 비교
   - Phase 1 (직업 추천) 회귀 테스트 필수!
9. 반복 (모든 시나리오 70+ 될 때까지)
10. Team Leader: 완료 보고서 작성
```

---

## 5. Context Compact 복원

컨텍스트가 compact되면 반드시:
1. 이 파일 (`docs/sessions/wave3-a-major.md`) 다시 읽기
2. `docs/phase-progress/phase-2-state.md` 읽기
3. `git log --oneline -5` + `git diff HEAD~1` 확인
4. Team Leader의 가장 최근 메시지 확인

---

## 6. 완료 기준

- [ ] 8개 전공 시나리오 모두 70점 이상
- [ ] 스테이지별 분기 정상 동작 (child~graduate)
- [ ] 미성년자 보호 로직 정상 (시나리오 7, 8)
- [ ] 과목 기반 필터링 정상 (시나리오 6)
- [ ] Phase 1 (직업 추천) 회귀 테스트 통과
- [ ] Phase 3 (RAG 검색) 회귀 테스트 통과
- [ ] npx tsc --noEmit 통과
- [ ] npm run build 성공
- [ ] 프로덕션 배포 및 확인 완료
- [ ] 완료 보고서 작성

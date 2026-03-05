# Wave 1 / Session A — Phase 3: RAG 검색 품질 개선

> **이 파일을 읽고 팀을 구성한 뒤 Phase 3 작업을 시작하세요.**

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
2. `MASTER_PLAN.md` — Phase 3 섹션 + 사전 검토 체크리스트 + 완료 보고서 템플릿

---

## 2. 팀 구성

| 역할 | 모델 | 실행 방식 | 임무 |
|------|------|----------|------|
| Team Leader | Opus (메인) | 메인 세션 | 조율, 의사결정, 코드 리뷰 승인 |
| Analyst | Sonnet | Task(run_in_background) | 코드 분석, 테스트 채점, 부작용 검증 |
| Researcher | Sonnet | Task(run_in_background) | 웹 리서치, 베스트 프랙티스 |
| Implementer | Sonnet | Task (순차) | 코드 수정, 빌드, 배포 |

에이전트 정의: `.claude/agents/analyst.md`, `researcher.md`, `implementer.md`

### 실행 패턴
```
1. Analyst + Researcher → Task(run_in_background=true)로 병렬 실행
2. 결과 종합 후 Team Leader가 문제 우선순위 결정
3. Implementer → Task로 순차 수정
4. ★ 코드 리뷰 게이트 → Analyst 부작용 확인 → 배포
```

---

## 3. Phase 3 목표

사이트 내 통합 검색의 정확도와 관련성 개선

### 수정 대상 파일
```
src/services/rag-search.ts           (1,656줄) - RAG 하이브리드 검색 엔진
src/routes/search.ts                 (335줄)  - 검색 라우트
src/services/ai-analyzer/vectorize-pipeline.ts - 벡터 검색 공유
```

### 참고 파일 (읽기 전용)
```
src/routes/content-editor.ts         - /api/search 엔드포인트 포함
```

### 검색 파이프라인
```
사용자 쿼리
→ 1. 속어 사전 확장 (88개 한국어 슬랭 매핑)
→ 2. 짧은 쿼리 컨텍스트 보강 (≤2글자)
→ 3. LLM 쿼리 확장 (선택적, KV 캐시 24시간)
→ 4. Vector Search (Vectorize, cosine similarity)
   - 일반: MIN_VECTOR_SCORE = 0.3
   - HowTo: MIN_VECTOR_SCORE_HOWTO = 0.5
→ 5. LIKE Fallback (키워드 매칭)
→ 6. Intent 기반 재순위 (7개 속성, 0.12-0.15 가중치)
→ 7. 결과 병합 및 반환
```

### 테스트 쿼리 카테고리
```
1. 직업명 직접 검색: "데이터 분석가", "웹 개발자"
2. 속어/은어: "철밥통", "짭새", "코드몽키"
3. 의도 기반: "연봉 높은 직업", "워라밸 좋은 직업"
4. 전공명: "컴퓨터공학", "심리학"
5. 추상적 질문: "뭐 할지 모르겠어요"
6. HowTo 검색: "면접 준비", "포트폴리오 만들기"
7. 복합 쿼리: "안정적이고 연봉 높은 IT 직업"
```

---

## 4. 실행 흐름

```
1. Team Leader: 팀 생성 → Analyst 스폰 → Researcher 스폰 → Implementer 스폰
2. Analyst: rag-search.ts 전체 파이프라인 분석 + 현재 프로덕션 검색 품질 Before 기록
   - 7개 카테고리 × 2-3개 쿼리로 현재 결과 채점
3. Researcher: 검색 엔진 베스트 프랙티스 리서치 (한국어 NLP, 속어 처리, 벡터 검색 임계값)
4. Team Leader: Analyst/Researcher 결과 종합 → 문제 우선순위 결정
5. Implementer: 우선순위 높은 문제부터 한 번에 하나씩 수정
   - 수정 → npx tsc --noEmit 통과까지
6. ★ 코드 리뷰 게이트 (배포 전 필수):
   - Implementer → Team Leader: git diff 요약 보고
   - Team Leader: 변경 범위 확인 (의도하지 않은 수정 없는지)
   - Analyst: 수정된 함수의 호출부(caller) 전체 Grep → 부작용/회귀 위험 보고
   - Team Leader: 문제 없으면 배포 승인
7. Implementer: npm run build → npm run deploy → 프로덕션 확인
8. Analyst: 재테스트 → Before/After 비교
9. 반복 (모든 카테고리 만족할 때까지)
10. Team Leader: 완료 보고서 작성 → 사용자 검증 안내
```

---

## 5. Context Compact 복원

컨텍스트가 compact되면 반드시:
1. 이 파일 (`docs/sessions/wave1-a-rag.md`) 다시 읽기
2. `docs/phase-progress/phase-3-state.md` 읽기 (진행 상태)
3. `git log --oneline -5` + `git diff HEAD~1` 확인
4. Team Leader의 가장 최근 메시지 확인

---

## 6. 완료 기준

- [ ] 7개 테스트 카테고리 모두 관련 결과 반환
- [ ] 속어 검색이 올바른 직업으로 매핑
- [ ] HowTo 검색 결과 품질 적절
- [ ] 검색 실패(0건) 케이스 최소화
- [ ] npx tsc --noEmit 통과
- [ ] npm run build 성공
- [ ] 프로덕션 배포 및 확인 완료
- [ ] 완료 보고서 작성 (MASTER_PLAN.md 템플릿 형식)

# Wave 2 / Session C — Phase 9: 관리자 대시보드 강화

> **이 파일을 읽고 팀을 구성한 뒤 Phase 9 작업을 시작하세요.**
> **선행 조건**: Wave 1의 Phase 5 (광고 셋업) 완료 후 시작. `git pull` 필수.

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
2. `MASTER_PLAN.md` — Phase 9 섹션 + 사전 검토 체크리스트 + 완료 보고서 템플릿
3. `docs/phase-progress/phase-5-state.md` — Phase 5 결과 (GA4 연동 확인)

---

## 2. 팀 구성

| 역할 | 모델 | 실행 방식 | 임무 |
|------|------|----------|------|
| Team Leader | Opus (메인) | 메인 세션 | 조율, 코드 리뷰 승인 |
| Analyst | Sonnet | Task(run_in_background) | admin 코드 분석, D1 스키마 |
| Researcher | Sonnet | Task(run_in_background) | GA4 API, 검색어 로깅 리서치 |
| Designer | Sonnet | Task(run_in_background) | 대시보드 레이아웃, 차트 UX |
| Implementer | Sonnet | Task (순차) | 마이그레이션, API, UI 구현 |

에이전트 정의: `.claude/agents/analyst.md`, `researcher.md`, `implementer.md`, `designer.md`
> 풀팀: 코드 분석 + GA4 리서치 + UI 설계 + 구현 모두 필요.

### 실행 패턴
```
1. Analyst + Researcher + Designer → 3개 병렬 Task(run_in_background=true)
2. 결과 종합 후 Team Leader가 구현 우선순위 결정
3. Implementer → Task로 순차 구현 (DB 마이그레이션 → API → UI)
4. ★ 코드 리뷰 게이트 → Analyst 부작용 확인 → 배포
5. Designer 배포 후 레이아웃/UX 재확인
```

---

## 3. Phase 9 목표

비즈니스 오너 관점의 마케팅/모니터링 대시보드 구축

### 수정 대상 파일
```
src/routes/admin.ts              (675줄)  - 관리자 라우트
src/templates/admin/
├── adminDashboard.tsx           - 메인 대시보드 UI
├── adminStats.tsx               (26KB)  - 통계 페이지
├── adminContent.tsx             (44KB)  - 콘텐츠 관리
├── adminUsers.tsx               (18KB)  - 사용자 관리
├── adminAiAnalyzer.tsx          (34KB)  - AI 분석기 관리
└── adminLayout.tsx              - 공통 레이아웃

src/services/
├── adminService.ts              (669줄)  - 관리자 비즈니스 로직
├── perfMetricsService.ts        (646줄)  - 성능 메트릭
```

### 현재 기능 (이미 있음)
```
기본 통계 (직업/전공/사용자/편집 수)
캐시 적중률
최근 편집/사용자
AI 분석기 통계 (완료/요청/재분석)
콘텐츠 리비전 히스토리
사용자 역할 관리
피드백/신고 관리
```

### 추가 필요 기능
```
일별/주별/월별 방문자 추이 (GA4 연동 또는 자체 수집)
인기 페이지 TOP 20 (실시간)
검색어 분석 (인기 검색어, 검색 실패 키워드)
AI 분석기 전환율 (시작 → 완료 비율)
사용자 유입 채널 분석
콘텐츠 커버리지 맵 (빈 데이터 직업 비율)
SEO 성과 (검색 노출, CTR)
에러/장애 모니터링
광고 수익 대시보드 (Phase 5 이후)
```

---

## 4. 실행 흐름

```
1. Team Leader: 풀 팀 생성 → 전원 스폰
2. Analyst: 현재 admin 코드 전체 분석
   - 기존 API/쿼리 구조 파악
   - D1 스키마 확인 (추가 마이그레이션 필요 여부)
   - 성능 메트릭 수집 현황 파악
3. Researcher: GA4 Data API, 검색어 로깅 베스트 프랙티스 리서치
   - Cloudflare Workers에서 GA4 연동 방법
   - 서버사이드 검색어 로깅 패턴
4. Designer: 대시보드 레이아웃/UX 설계
   - 정보 밀도와 가독성 밸런스
   - 차트/그래프 표시 방식 (라이브러리 불필요, CSS/SVG 기반)
   - 모바일 관리자 뷰
5. Team Leader: 전원 결과 종합 → 구현 우선순위 결정
   - 마이그레이션 필요 시 먼저 설계 검토
6. Implementer: 우선순위 순서대로 구현
   - DB 마이그레이션 → API → UI 순서
   - 수정 → npx tsc --noEmit 통과까지
7. ★ 코드 리뷰 게이트 (배포 전 필수):
   - Implementer → Team Leader: git diff 요약 보고
   - Analyst: 수정된 코드의 부작용/회귀 위험 보고
     (특히 DB 마이그레이션은 rollback 불가이므로 각별히 주의)
   - Team Leader: 문제 없으면 배포 승인
8. Implementer: npm run build → npm run deploy → 프로덕션 확인
9. Designer: 배포 후 레이아웃/UX 재확인
10. 반복
11. Team Leader: 완료 보고서 작성
```

---

## 5. Context Compact 복원

컨텍스트가 compact되면 반드시:
1. 이 파일 (`docs/sessions/wave2-c-admin.md`) 다시 읽기
2. `docs/phase-progress/phase-9-state.md` 읽기
3. `git log --oneline -5` + `git diff HEAD~1` 확인
4. Team Leader의 가장 최근 메시지 확인

---

## 6. 완료 기준

- [ ] 방문자 추이 표시 (일별 최소)
- [ ] 인기 페이지 TOP 20 표시
- [ ] 검색어 분석 (인기 검색어 + 실패 키워드)
- [ ] AI 분석기 전환율 표시
- [ ] 콘텐츠 커버리지 맵 (빈 데이터 비율)
- [ ] 기존 기능 회귀 테스트 통과
- [ ] npx tsc --noEmit 통과
- [ ] npm run build 성공
- [ ] 프로덕션 배포 및 확인 완료
- [ ] 완료 보고서 작성

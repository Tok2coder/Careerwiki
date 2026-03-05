# Wave 1 / Session B — Phase 4: 편집 시스템 안정화

> **이 파일을 읽고 팀을 구성한 뒤 Phase 4 작업을 시작하세요.**

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
2. `MASTER_PLAN.md` — Phase 4 섹션 + 사전 검토 체크리스트 + 완료 보고서 템플릿

---

## 2. 팀 구성

| 역할 | 모델 | 실행 방식 | 임무 |
|------|------|----------|------|
| Team Leader | Opus (메인) | 메인 세션 | 조율, 코드 리뷰 승인 |
| Analyst | Sonnet | Task(run_in_background) | 7개 시나리오 테스트, 부작용 검증 |
| Implementer | Sonnet | Task (순차) | 버그 수정, 빌드, 배포 |

에이전트 정의: `.claude/agents/analyst.md`, `implementer.md`
> Designer/Researcher 불필요: 편집 시스템은 기존 코드 버그 수정 중심.

### 실행 패턴
```
1. Analyst → Task(run_in_background=true)로 코드 분석
2. 결과 기반으로 Team Leader가 Critical/High 버그 식별
3. Implementer → Task로 순차 수정
4. ★ 코드 리뷰 게이트 → Analyst 부작용 확인 → 배포
```

---

## 3. Phase 4 목표

직업/전공/HowTo 편집 기능의 버그 수정 및 안정화

### 수정 대상 파일
```
src/routes/
├── content-editor.ts     (687줄)  - 공통 편집 API (slug, 검색, 리비전)
├── job-editor.ts         (953줄)  - 직업 편집 CRUD
├── major-editor.ts       (875줄)  - 전공 편집 CRUD
├── howto-editor.ts       (1,540줄) - HowTo 편집 + 드래프트 관리

src/services/
├── editService.ts        (1,162줄) - 편집 비즈니스 로직
├── revisionService.ts    (592줄)  - 리비전 추적
├── draftService.ts       (575줄)  - 드래프트 관리
├── commentService.ts     (1,183줄) - 댓글 시스템
```

### 편집 시스템 구조
```
편집 흐름:
1. 입력 검증 (validateEditInput + sanitizeContent)
2. 데이터 스냅샷 생성 (createDataSnapshot)
3. 리비전 생성 (createRevision)
4. ISR 캐시 무효화 (invalidatePageCache)
5. 익명 편집은 4자리 PIN 비밀번호 지원
```

### HowTo 발행 흐름
```
draft → draft_published (관리자 리뷰 대기) → published
- Tiptap JSON → HTML 변환 (20+ 노드 타입)
- R2 이미지 라이프사이클 관리
- If-Match 헤더로 낙관적 동시성 제어
- Vectorize 자동 인덱싱
```

### 테스트 항목 (7개 시나리오)
```
1. 직업 편집 → 저장 → 리비전 확인 → 복원
2. 전공 편집 → 저장 → 리비전 확인 → 복원
3. HowTo 드래프트 생성 → 편집 → 발행
4. 익명 편집 → PIN 검증 → 수정/삭제
5. 댓글 작성 → 투표 → 신고 → 블라인드
6. 이미지 업로드 → R2 저장 → 삭제 시 정리
7. 동시 편집 충돌 처리 (If-Match)
```

---

## 4. 실행 흐름

```
1. Team Leader: 팀 생성 → Analyst 스폰 → Implementer 스폰
2. Analyst: 편집 시스템 전체 코드 분석 + 7개 시나리오별 코드 경로 추적
   - 각 시나리오별 실행 가능 여부, 에지 케이스 식별
   - 프로덕션에서 실제 편집 테스트 (읽기 전용 관찰)
3. Team Leader: Analyst 결과 기반으로 Critical/High 버그 식별
4. Implementer: 우선순위 높은 버그부터 수정
   - 수정 → npx tsc --noEmit 통과까지
5. ★ 코드 리뷰 게이트 (배포 전 필수):
   - Implementer → Team Leader: git diff 요약 보고
   - Team Leader: 변경 범위 확인
   - Analyst: 수정된 함수의 호출부 Grep → 부작용/회귀 위험 보고
   - Team Leader: 문제 없으면 배포 승인
6. Implementer: npm run build → npm run deploy → 프로덕션 확인
7. Analyst: 재테스트 → 회귀 확인
8. 반복
9. Team Leader: 완료 보고서 작성
```

---

## 5. Context Compact 복원

컨텍스트가 compact되면 반드시:
1. 이 파일 (`docs/sessions/wave1-b-edit.md`) 다시 읽기
2. `docs/phase-progress/phase-4-state.md` 읽기
3. `git log --oneline -5` + `git diff HEAD~1` 확인
4. Team Leader의 가장 최근 메시지 확인

---

## 6. 완료 기준

- [ ] 7개 편집 시나리오 모두 정상 동작
- [ ] 익명 편집 PIN 검증 정상
- [ ] HowTo 발행 흐름 (draft → published) 정상
- [ ] 동시 편집 충돌 시 적절한 에러 메시지
- [ ] 댓글 투표/신고/블라인드 정상
- [ ] npx tsc --noEmit 통과
- [ ] npm run build 성공
- [ ] 프로덕션 배포 및 확인 완료
- [ ] 완료 보고서 작성

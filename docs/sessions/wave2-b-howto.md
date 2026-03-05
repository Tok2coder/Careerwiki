# Wave 2 / Session B — Phase 10: HowTo 에디터 UX 개선

> **이 파일을 읽고 팀을 구성한 뒤 Phase 10 작업을 시작하세요.**
> **선행 조건**: Wave 1의 Phase 4 (편집 시스템) 완료 후 시작. `git pull` 필수.

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
2. npm run build:editor           # Tiptap 에디터 번들 빌드 (에디터 변경 시)
3. npm run build                  # = npm run build:css && vite build → dist/
   (또는 npm run build:all = build:editor + build)
4. npm run deploy                 # = npm run build && wrangler pages deploy dist/
   → 배포 완료 시 URL 출력 (*.careerwiki.pages.dev)
5. https://careerwiki.org 에서 변경 확인 (1-2분 propagation)
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
2. `MASTER_PLAN.md` — Phase 10 섹션 + 사전 검토 체크리스트 + 완료 보고서 템플릿
3. `docs/phase-progress/phase-4-state.md` — Phase 4 결과 (편집 시스템 변경 확인)

---

## 2. 팀 구성

| 역할 | 모델 | 실행 방식 | 임무 |
|------|------|----------|------|
| Team Leader | Opus (메인) | 메인 세션 | 조율, 코드 리뷰 승인 |
| Analyst | Sonnet | Task(run_in_background) | 에디터 코드 분석, 10개 시나리오 |
| Researcher | Sonnet | Task(run_in_background) | TipTap API/버그 리서치 |
| Designer | Sonnet | Task(run_in_background) | 모바일 UX, 에러 메시지 한국어화 |
| Implementer | Sonnet | Task (순차) | 코드 수정, build:editor, 배포 |

에이전트 정의: `.claude/agents/analyst.md`, `researcher.md`, `implementer.md`, `designer.md`
> 풀팀: TipTap 외부 라이브러리 → Researcher 필수. 모바일 UX → Designer 필수.

### 실행 패턴
```
1. Analyst + Researcher + Designer → 3개 병렬 Task(run_in_background=true)
2. 결과 종합 후 Team Leader가 수정 우선순위 결정
3. Implementer → Task로 순차 수정 (에디터 변경 시 build:editor 필수)
4. ★ 코드 리뷰 게이트 → Analyst 부작용 확인 → 배포
5. Designer 배포 후 UX 재확인
```

---

## 3. Phase 10 목표

HowTo 에디터의 버그 수정 및 사용자 편의성 향상

### 수정 대상 파일
```
src/routes/howto-editor.ts       (1,540줄) - 에디터 API 라우트
src/editor/                      (151KB)  - Tiptap 에디터 번들
src/services/draftService.ts     (575줄)  - 드래프트 관리
src/templates/howtoDetail.ts     (62KB)   - HowTo 렌더링
```

### Tiptap 에디터 지원 노드
```
paragraph, heading, bold, italic, underline, strike, code
link, image, blockquote, bulletList, orderedList, listItem
table, tableRow, tableCell, tableHeader
taskList, taskItem, textAlign, color, highlight
fontFamily, placeholder
```

### 에디터 빌드
```bash
npm run build:editor   # vite.editor.config.ts 사용
# 결과: src/editor/ 번들 생성
# 에디터 변경 시 반드시 build:editor 먼저 실행!
```

### 점검 항목 (10개)
```
1. 드래프트 자동저장 동작 확인
2. 이미지 업로드 → R2 저장 → 미리보기
3. If-Match 동시성 충돌 처리
4. 발행 전 미리보기 기능
5. 모바일 에디터 반응형 레이아웃
6. Tiptap → HTML 변환 정확성 (20+ 노드)
7. 각주(footnote) 추출 및 표시
8. 코드 블록, 테이블 렌더링
9. 드래프트 삭제 시 R2 이미지 정리
10. 에러 핸들링 (네트워크 실패, 권한 부족 등)
```

---

## 4. 실행 흐름

```
1. Team Leader: 팀 생성 → Analyst → Researcher → Implementer → Designer 스폰
2. Analyst: howto-editor.ts + draftService.ts + editor/ 전체 코드 분석
   - 10개 점검 항목별 코드 경로 추적
   - 에지 케이스, 에러 핸들링 누락 식별
3. Researcher: TipTap 공식 문서, 알려진 버그, 마이그레이션 가이드 리서치
   - TipTap 버전별 API 차이 확인
4. Designer: 프로덕션 HowTo 에디터 페이지 UX 분석
   - 모바일 레이아웃 점검
   - 에러 메시지 한국어화 상태 확인
   - 사용자 흐름 (생성→편집→저장→발행) 인지 부하 평가
5. Team Leader: 전원 결과 종합 → 수정 우선순위 결정
6. Implementer: 버그/UX 이슈 수정 (한 번에 하나씩)
   - 수정 → npx tsc --noEmit 통과까지
7. ★ 코드 리뷰 게이트 (배포 전 필수):
   - Implementer → Team Leader: git diff 요약 보고
   - Analyst: 수정된 함수의 호출부 Grep → 부작용/회귀 위험 보고
   - Team Leader: 문제 없으면 배포 승인
8. Implementer: 에디터 변경 시 npm run build:editor → npm run build → npm run deploy
9. Designer: 배포 후 UX 재확인
10. 반복
11. Team Leader: 완료 보고서 작성
```

---

## 5. Context Compact 복원

컨텍스트가 compact되면 반드시:
1. 이 파일 (`docs/sessions/wave2-b-howto.md`) 다시 읽기
2. `docs/phase-progress/phase-10-state.md` 읽기
3. `git log --oneline -5` + `git diff HEAD~1` 확인
4. Team Leader의 가장 최근 메시지 확인

---

## 6. 완료 기준

- [ ] 10개 점검 항목 모두 정상 동작
- [ ] 모바일 에디터 레이아웃 정상
- [ ] 에러 메시지 한국어화 완료
- [ ] 드래프트 자동저장 동작 확인
- [ ] 이미지 업로드/삭제 R2 라이프사이클 정상
- [ ] Phase 4 (편집 시스템) 회귀 테스트 통과
- [ ] npx tsc --noEmit 통과
- [ ] npm run build:all 성공
- [ ] 프로덕션 배포 및 확인 완료
- [ ] 완료 보고서 작성

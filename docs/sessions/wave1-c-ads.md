# Wave 1 / Session C — Phase 5: Google Ads 기본 셋업

> **이 파일을 읽고 팀을 구성한 뒤 Phase 5 작업을 시작하세요.**

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
2. `MASTER_PLAN.md` — Phase 5 섹션 + 사전 검토 체크리스트 + 완료 보고서 템플릿

---

## 2. 팀 구성

| 역할 | 모델 | 실행 방식 | 임무 |
|------|------|----------|------|
| Team Leader | Opus (메인) | 메인 세션 | 조율, 코드 리뷰 승인 |
| Analyst | Sonnet | Task(run_in_background) | nav.ts 구조 분석, 부작용 범위 |
| Researcher | Sonnet | Task(run_in_background) | AdSense/GA4 베스트 프랙티스 |
| Designer | Sonnet | Task(run_in_background) | 광고 배치, CLS 방지, 레이아웃 |
| Implementer | Sonnet | Task (순차) | 코드 수정, 빌드, 배포 |

에이전트 정의: `.claude/agents/analyst.md`, `researcher.md`, `implementer.md`, `designer.md`
> 풀팀: nav.ts(27KB) 전 페이지 영향 → Analyst 필수. Designer: CLS 방지.

### 실행 패턴
```
1. Analyst + Researcher + Designer → Task(run_in_background=true)로 병렬 실행
2. 결과 종합 후 Team Leader가 구현 계획 확정
3. Implementer → Task로 순차 구현
4. ★ 코드 리뷰 게이트 → Analyst 부작용 확인 → 배포
5. Designer 배포 후 CLS/레이아웃 재확인
```

---

## 3. Phase 5 목표

Google AdSense 심사용 기본 틀 구축 (현재 광고 인프라 전무)

### 현재 상태
- 광고 코드: 없음
- Google Analytics: 없음
- GTM: 없음
- 추적 픽셀: 없음

### 수정 대상 파일
```
src/templates/
├── partials/nav.ts          (27KB) - 공통 네비게이션 (head 태그 포함)
├── unifiedJobDetail.ts      - 직업 상세 페이지
├── unifiedMajorDetail.ts    - 전공 상세 페이지
├── howtoDetail.ts           - HowTo 상세 페이지

src/routes/pages.ts          - 메인/법적 페이지 라우트
```

### 구현 항목
```
1. Google AdSense 스크립트 삽입 (head 태그)
2. 광고 슬롯 배치:
   - 상단 배너 (728x90 데스크톱 / 320x50 모바일)
   - 콘텐츠 중간 (인피드 광고)
   - 사이드바 (300x250)
   - 하단 (반응형)
3. ads.txt 파일 생성 (R2 또는 static)
4. 개인정보 처리방침 업데이트 (광고 관련 조항)
5. Google Analytics 4 (GA4) 기본 설치
   - gtag.js 삽입
   - 페이지뷰 자동 추적
```

### 주의사항
- AdSense 심사 기준: 충분한 콘텐츠, 개인정보 처리방침, 이용약관
- 처음엔 자동 광고만 설정 (수동 배치는 심사 후)
- CLS(Cumulative Layout Shift) 방지 → 광고 영역 미리 확보

---

## 4. 실행 흐름

```
1. Team Leader: 팀 생성 → Analyst + Researcher + Designer + Implementer 스폰
2. Analyst: nav.ts(27KB) 전체 구조 분석 → 수정 시 영향 범위(모든 페이지) 사전 파악
3. Researcher: AdSense 심사 기준, GA4 설치 가이드, ads.txt 규격 리서치
   - 한국어 사이트 AdSense 승인 사례 조사
   - CLS 방지 베스트 프랙티스 조사
4. Designer: 현재 페이지 레이아웃 분석 → 광고 슬롯 배치 제안
   - 사용자 경험 해치지 않는 위치 선정
   - 모바일/데스크톱 반응형 광고 크기 제안
5. Team Leader: 전원 결과 종합 → 구현 계획 확정
6. Implementer: nav.ts에 AdSense/GA4 스크립트 삽입
   - ads.txt 생성, 개인정보 처리방침 업데이트
   - 수정 → npx tsc --noEmit 통과까지
7. ★ 코드 리뷰 게이트 (배포 전 필수):
   - Implementer → Team Leader: git diff 요약 보고
   - Analyst: nav.ts 수정이 전체 페이지에 미치는 영향 확인 → 부작용 보고
   - Team Leader: 문제 없으면 배포 승인
8. Implementer: npm run build → npm run deploy → 프로덕션 확인
9. Designer: 배포 후 레이아웃 CLS, 모바일/데스크톱 확인
10. Team Leader: 완료 보고서 작성
```

---

## 5. Context Compact 복원

컨텍스트가 compact되면 반드시:
1. 이 파일 (`docs/sessions/wave1-c-ads.md`) 다시 읽기
2. `docs/phase-progress/phase-5-state.md` 읽기
3. `git log --oneline -5` + `git diff HEAD~1` 확인
4. Team Leader의 가장 최근 메시지 확인

---

## 6. 완료 기준

- [ ] AdSense 스크립트 정상 삽입 (head 태그)
- [ ] GA4 기본 추적 코드 동작 확인
- [ ] ads.txt 접근 가능 (careerwiki.org/ads.txt)
- [ ] 개인정보 처리방침에 광고 조항 추가
- [ ] CLS 영향 없음 (광고 영역 미리 확보)
- [ ] 모바일/데스크톱 레이아웃 정상
- [ ] npx tsc --noEmit 통과
- [ ] npm run build 성공
- [ ] 프로덕션 배포 및 확인 완료
- [ ] 완료 보고서 작성

# Standalone — Phase 12: UI/UX 디자인 개선

> **이 파일을 읽고 Team Leader로서 작업을 시작하세요.**
> Wave와 독립적으로 언제든 실행 가능합니다.

---

## 1. 공통 컨텍스트

### 프로젝트 개요
- **CareerWiki**: 한국어 진로 정보 위키 + AI 직업/전공 추천 플랫폼
- **Production**: https://careerwiki.org
- **Tech Stack**: Cloudflare Workers (Pages) + Hono + D1 (SQLite) + R2 + KV + Vectorize
- **Frontend**: TailwindCSS 3, TipTap editor
- **Build**: Vite, TypeScript strict mode
- **디자인 테마**: 다크 모드 기반, 글래스 모르핑 (Glass Morphism)

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
- 로컬 dev 서버로 테스트 (프로덕션에서만 테스트)
- 커밋 메시지: `feat/fix/chore: [한국어 설명]` 형식 필수

### 필수 읽기 파일
1. `CLAUDE.md` — 프로젝트 규칙 전체

---

## 2. 팀 구성

| 역할 | 모델 | 실행 방식 | 담당 영역 |
|------|------|----------|----------|
| Team Leader | Opus (메인) | 메인 세션 | 전체 조율, UX 의사결정, 유저 보고 |
| UX Researcher | Sonnet | Task(run_in_background) | **외부+흐름**: 경쟁사 벤치마크, UX 트렌드, 사용자 동선 병목 분석 |
| UI Auditor | Sonnet | Task(run_in_background) | **내부 시각**: 색상/타이포/간격 일관성, 반응형, 접근성 감사 |
| Frontend QA | Sonnet | Task(run_in_background) | **내부 동작**: 기능 테스트, Web Vitals(CLS/LCP), 수정 후 회귀 검증 |
| Implementer | Sonnet | Task (순차) | **구현**: CSS/HTML/JS 수정, 빌드, 배포 |

에이전트 정의: `.claude/agents/researcher.md` (UX Researcher용), `designer.md` (UI Auditor용), `analyst.md` (Frontend QA용), `implementer.md`

### MECE 역할 분담
```
┌─ 발견 (Discovery) ──────────────────────────────────────┐
│  UX Researcher: 외부 시야 (경쟁사, 트렌드, 베스트프랙티스) │
│  UI Auditor:    내부 시각 (디자인 일관성, 반응형, 접근성)   │
│  Frontend QA:   내부 동작 (기능 테스트, 성능 지표)          │
├─ 설계 (Design) ─────────────────────────────────────────┤
│  Team Leader:   감사 결과 종합 → 우선순위 → 개선안 결정     │
│  UX Researcher: 경쟁사 참고 개선 방향 제안                  │
├─ 구현 (Implementation) ─────────────────────────────────┤
│  Implementer:   코드 수정 → 빌드 → 배포                    │
├─ 검증 (Validation) ─────────────────────────────────────┤
│  Frontend QA:   수정 후 기능 회귀 + 성능 악화 없는지 확인    │
└──────────────────────────────────────────────────────────┘
```

### 실행 패턴
```
1. UX Researcher + UI Auditor + Frontend QA → 3개 Task(run_in_background=true) 병렬
2. Team Leader: 3가지 감사 결과 종합 → 이슈 트리아지
3. ★ 유저에게 이슈 목록 + 경쟁 벤치마크 보고 → 우선순위 승인
4. Implementer → Task로 순차 수정
5. Frontend QA → 수정 후 회귀 검증 + 성능 확인
6. 문제 없으면 배포, 있으면 4번으로 돌아감
```

---

## 3. Phase 12 목표

**실제 유저 관점**에서 사이트 전반의 UI/UX를 점검하고 개선합니다.
기능이 제대로 작동하는지도 함께 확인합니다.

---

## 4. 디자인 시스템 현황

### 색상 팔레트 (tailwind.config.js)
```
wiki-bg:        #0f0f23    (배경)
wiki-card:      #1a1a2e    (카드)
wiki-border:    #2a2a3e    (테두리)
wiki-primary:   #4361ee    (주요 — 파란색)
wiki-secondary: #64b5f6    (보조 — 라이트 블루)
wiki-text:      #e0e0e0    (텍스트)
wiki-muted:     #9ca3af    (약한 텍스트)
```

### 글래스 모르핑 카드
```css
background: rgba(26, 26, 46, 0.82);
border: 1px solid rgba(148, 163, 184, 0.22);
backdrop-filter: blur(14px);
```

### 반응형 중단점
- 모바일: < 768px (md)
- 태블릿: 768px ~ 1024px
- 데스크톱: > 1024px
- 최대 너비: 1400px

---

## 5. 점검 대상 페이지 & 파일

### 주요 사용자 동선 (User Journey)
```
1. 메인 페이지 (/) → 검색 or AI 추천 진입
2. 검색 결과 (/search?q=...) → 직업/전공/HowTo 클릭
3. 직업 상세 (/job/{slug}) → 탭 전환, 편집, 댓글
4. 전공 상세 (/major/{slug}) → 탭 전환, 편집, 댓글
5. AI 추천 (/ai-analyzer) → 프로필 입력 → 질문 응답 → 결과
6. HowTo 목록 (/howto) → 상세 (/howto/{slug})
7. 헬프 (/help) → FAQ 탐색
```

### 템플릿 파일 (수정 대상)
```
src/templates/
├── unifiedJobDetail.ts       (213KB) — 직업 상세
├── unifiedMajorDetail.ts     (135KB) — 전공 상세
├── howtoDetail.ts            (62KB)  — HowTo 상세
├── help.tsx                  (19KB)  — 헬프 센터
├── feedback.tsx              (13KB)  — 피드백
├── onboarding.tsx            (24KB)  — 온보딩
├── notFound.tsx                      — 404 페이지
├── partials/
│   └── nav.ts                        — 공통 네비게이션
```

### CSS 파일
```
public/static/
├── howto-content.css         (737줄) — HowTo 콘텐츠 렌더링
├── howto-editor.css          (2,325줄) — TipTap 에디터 UI
├── edit-mode.css             (143줄) — 편집 모드 트랜지션
```

### 프론트엔드 JS
```
public/static/
├── api-client.js             (7,924줄) — 편집 시스템 + API
├── edit-mode.js              (2,141줄) — 편집 UI
├── perf-metrics.js           (421줄)  — 성능 메트릭
├── resume-upload.js          (230줄)  — 이력서 업로드
```

### TailwindCSS 설정
```
tailwind.config.js            — 색상, 폰트, 중단점 설정
```

---

## 6. 역할별 감사 체크리스트

### UX Researcher 담당

#### 경쟁사 벤치마크
```
□ 한국 진로 정보 사이트 3-5개 조사 (커리어넷, 워크넷, 사람인, 잡코리아 등)
□ 해외 진로/교육 플랫폼 2-3개 조사 (O*NET, Coursera, LinkedIn 등)
□ 각 경쟁사의 강점 UX 패턴 식별 (우리가 배울 점)
□ 각 경쟁사의 약점 식별 (우리가 차별화할 점)
□ 정보 구조(IA) 비교: 직업 상세 페이지 구성, 네비게이션 깊이
□ 검색 UX 비교: 자동완성, 필터, 결과 표시 방식
□ 모바일 UX 비교: 네비게이션, 콘텐츠 밀도, 터치 최적화
```

#### 사용자 동선 분석
```
□ 메인 → 검색: 검색창 발견 용이성, 진입 허들
□ 검색 → 결과: 결과 레이아웃, 빈 결과 처리, 필터 사용성
□ 결과 → 상세: 클릭 영역 명확성, 정보 미리보기
□ 상세 페이지: 정보 위계, 스크롤 깊이, 핵심 정보 접근성
□ AI 추천: 단계 진행 명확성, 이탈 위험 구간, 결과 만족도
□ HowTo: 단계별 가이드 탐색성, 완독 유도
□ 편집 모드: 진입/나가기 직관성, 기여 동기 부여
□ 댓글: 참여 허들, 커뮤니티 활성화 구조
```

### UI Auditor 담당

#### 시각적 일관성
```
□ 색상: 모든 페이지에서 wiki-* 팔레트 일관 적용
□ 타이포그래피: 제목/본문/캡션 크기 위계 (h1~h6, body, caption)
□ 간격: padding/margin 일관성 (4px 그리드)
□ 카드: glass-card 스타일 일관 적용
□ 버튼: 크기, 색상, hover/active/disabled 상태 통일
□ 아이콘: 크기, 색상, 스타일 (라인/솔리드) 통일
□ 로딩 상태: 스켈레톤/스피너 일관성
□ 에러/빈 상태: 메시지 디자인 통일
□ 그림자/둥근모서리: border-radius, box-shadow 일관성
```

#### 반응형 & 모바일
```
□ 네비게이션: 모바일 메뉴 동작, 검색창 전환
□ 직업/전공 상세: 탭 UI 모바일 사용성 (스와이프? 스크롤?)
□ 테이블: 모바일에서 가로 스크롤 or 카드 변환
□ 이미지: 모바일에서 비율 유지, lazy loading
□ 폼: 입력 필드 크기, 모바일 키보드 대응
□ 터치 타겟: 최소 44x44px
□ 폰트 크기: 모바일 최소 14px, 데스크톱 대비 스케일링
□ 중단점 전환: 768px, 1024px 경계에서 레이아웃 깨짐 확인
```

#### 접근성
```
□ 키보드 네비게이션: Tab 순서, focus 표시 (ring)
□ ARIA 레이블: 아이콘 버튼, 모달, 드롭다운, 탭
□ 색상 대비: WCAG AA 기준 (텍스트 4.5:1, 대형 텍스트 3:1)
□ 스크린리더: 의미 있는 heading 구조 (h1 하나, h2-h3 위계)
□ 모달: 포커스 트랩, ESC 닫기, 배경 스크롤 방지
□ 폼: label 연결, 에러 메시지 aria-live
```

### Frontend QA 담당

#### 기능 동작 확인
```
□ 검색: 입력 → 결과 표시 → 타입별 필터 → 클릭 이동
□ 탭 전환: 직업/전공 상세 모든 탭 클릭 → 콘텐츠 표시
□ 편집 모드: 진입 → 필드 수정 → 저장 → 리비전 확인
□ 댓글: 작성 → 표시 → 투표 → 신고
□ AI 추천: 프로필 → 질문 → 응답 → 결과 → 상세 보기
□ HowTo: 목록 → 상세 → 단계 탐색
□ 404 페이지: 존재하지 않는 URL 처리
□ 뒤로가기: 브라우저 히스토리 정상
□ 외부 링크: 새 탭 열림, rel=noopener
```

#### 성능 지표 (Web Vitals)
```
□ LCP (Largest Contentful Paint): 2.5초 이내 목표
□ FID/INP (Interaction to Next Paint): 200ms 이내 목표
□ CLS (Cumulative Layout Shift): 0.1 이내 목표
□ TTFB (Time to First Byte): ISR 캐시 히트 시 < 100ms
□ 이미지: 적절한 크기, format, lazy loading
□ JS 번들: 불필요한 코드 로딩 없는지
□ CSS: 미사용 스타일 비율
```

#### 수정 후 회귀 검증
```
□ 수정된 페이지 기능 동작 재확인
□ 수정 전후 CLS 비교 (레이아웃 시프트 악화 없는지)
□ 수정 전후 LCP 비교 (로딩 속도 저하 없는지)
□ 관련 페이지 사이드이펙트 확인
□ 모바일 + 데스크톱 양쪽 확인
```

---

## 7. 이슈 분류 기준

| 등급 | 기준 | 예시 |
|------|------|------|
| **Critical** | 기능 불가, 사용자 이탈 유발 | 버튼 안 눌림, 페이지 깨짐, 모바일 사용 불가 |
| **High** | UX 저해, 혼란 유발 | 탭 전환 안 됨, 로딩 피드백 없음, 에러 메시지 없음 |
| **Medium** | 시각적 불일관, 사소한 UX | 색상 불일치, 간격 불균형, hover 효과 누락 |
| **Low** | 폴리싱, 디테일 | 미세 정렬, 애니메이션 개선, 아이콘 통일 |

---

## 8. 실행 흐름

```
1. Team Leader: CLAUDE.md 읽기 → 팀 생성

2. [병렬 감사 — 3개 Task 동시 실행]
   UX Researcher (run_in_background):
   - 경쟁사 3-5개 사이트 벤치마크 (WebSearch + WebFetch)
   - 사용자 동선 병목/이탈 위험 분석
   - 경쟁사 대비 차별화 포인트 + 개선 방향 제안

   UI Auditor (run_in_background):
   - 전체 템플릿 코드 읽고 시각적 일관성 점검
   - TailwindCSS 클래스 사용 패턴 분석
   - 반응형 (768px, 1024px) 레이아웃 점검
   - 접근성 감사 (WCAG AA 기준)

   Frontend QA (run_in_background):
   - 프로덕션 사이트 전체 기능 동작 확인
   - 각 페이지 Web Vitals 기준선 측정 (LCP, CLS, INP)
   - 깨진 기능, JS 에러, 콘솔 경고 수집

3. Team Leader: 3가지 감사 결과 종합 → 이슈 트리아지
   - 경쟁사 대비 열세 항목 = Critical/High 상향
   - 성능 지표 미달 항목 = High
4. ★ 유저에게 보고: 이슈 목록 + 경쟁 벤치마크 요약 + 우선순위 제안
5. 유저 승인 후 → Implementer: 승인된 순서대로 수정
   - 수정 1건 → tsc 통과 → 빌드 → 배포
6. Frontend QA: 수정 후 회귀 검증 (기능 + 성능)
   - 문제 발견 시 → 5번으로 돌아감
   - 문제 없으면 → 다음 수정으로
7. 반복
8. Team Leader: 완료 보고서 작성 (경쟁 비교 + Before/After)
```

### ★ 유저 확인 게이트

디자인은 주관적 판단이 포함되므로 다음 시점에서 반드시 유저에게 보고합니다:

1. **감사 완료 후**: 발견된 이슈 목록 + 트리아지 결과 + 개선 제안
2. **각 수정 건별**: 무엇을 왜 어떻게 바꿨는지 요약
3. **배포 전**: 변경 파일 목록 + 영향 범위

---

## 9. 디자인 원칙 (수정 시 준수)

```
1. 정보 위계: 가장 중요한 정보가 가장 눈에 띄어야 함
2. 일관성: 같은 요소는 어디서든 같은 모양, 같은 동작
3. 피드백: 유저 액션에는 항상 시각적 반응 (hover, loading, success, error)
4. 모바일 우선: 모바일에서 먼저 확인, 데스크톱은 확장
5. 최소 변경: 기존 디자인 시스템 안에서 개선, 새 패턴 최소화
6. 성능: CSS 애니메이션은 transform/opacity만, reflow 유발 금지
```

---

## 10. Context Compact 복원

컨텍스트가 compact되면 반드시:
1. 이 파일 (`docs/sessions/standalone-design.md`) 다시 읽기
2. `git log --oneline -10` + `git diff HEAD` 확인
3. Team Leader의 가장 최근 메시지 확인
4. 현재 진행 중인 이슈 재확인

---

## 11. 완료 기준

- [ ] 경쟁사 벤치마크 완료 (3-5개 사이트 비교)
- [ ] 사용자 동선 UX 감사 완료
- [ ] 시각적 일관성 점검 완료
- [ ] 반응형/모바일 점검 완료
- [ ] 접근성 감사 완료 (WCAG AA)
- [ ] 기능 동작 + Web Vitals 기준선 측정 완료
- [ ] Critical/High 이슈 전부 수정
- [ ] Medium 이슈 가능한 만큼 수정
- [ ] 수정 후 회귀 검증 통과 (기능 + 성능)
- [ ] npx tsc --noEmit 통과
- [ ] npm run build 성공
- [ ] 프로덕션 배포 및 확인
- [ ] 완료 보고서 작성 (경쟁 비교 + Before/After)

---

## 12. 다른 Phase와의 관계

- Phase 12는 **어떤 Wave와도 독립적**입니다
- 단, 다른 코드 수정 Phase가 동시에 돌고 있으면 **파일 충돌 가능**
  - 특히 `src/templates/`, `public/static/` 파일은 주의
- 동시 실행 시: 다른 Phase가 건드리는 파일은 피하고, 나머지 영역만 수정
- 배포도 다른 Phase와 겹치지 않게 순차 실행

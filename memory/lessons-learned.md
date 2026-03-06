# Lessons Learned

### [2026-03-06] CSS: Tailwind 3 CSS 변수 색상 — 빌드 시 정적 해석 문제
- **상황**: `wiki-primary: 'rgb(var(--wp, 67 97 238) / <alpha-value>)'`로 정의 후, gradient 클래스(`from-wiki-primary`)가 `#4361ee` 하드코딩으로 컴파일됨
- **원인**: Tailwind 3이 `var(--wp, 67 97 238)` 의 fallback `67 97 238`을 빌드 시점에 정적 hex로 변환. gradient 유틸리티에서 CSS 변수가 런타임에 유지되지 않음
- **해결**: (1) Tailwind config에서 fallback 제거: `'rgb(var(--wp) / <alpha-value>)'` (2) `@layer base { :root { --wp: 67 97 238 } }` 를 tailwind.css에 추가 (최저 우선순위 기본값) (3) 페이지별 extraHead `:root` 오버라이드가 base layer를 덮어씀
- **교훈**: Tailwind CSS 변수 색상은 config에 fallback 넣지 말고, `@layer base`에서 기본값 설정. CDN 캐시로 새 CSS가 반영 안 될 수 있으므로 `?v=N` cache-busting 필수

### [2026-03-06] 디자인: 개별 클래스 교체 vs CSS 변수 시스템
- **상황**: 첫 시도에서 `buildCard` 아이콘만 accent 파라미터로 색상 변경 → 나머지 130+ 요소는 여전히 blue
- **원인**: `wiki-primary`/`wiki-secondary`가 수백 곳에 사용되는데, 일부만 바꾸면 비일관적
- **해결**: CSS 변수 시스템 (`--wp`, `--ws`)으로 전환 → 라우트에서 `extraHead` 한 줄로 전체 색상 변경
- **교훈**: 테마 색상 변경은 개별 클래스 교체가 아닌 CSS 변수 레벨에서 해야 확장성/일관성 확보

### [2026-03-05] Risk: riskPenalty가 routes.ts에서 손실됨 ✅ 해결 (v3.16.0)
- **상황**: tag-filter에서 riskPenalty(0~40) 계산했으나 최종 결과에 반영 안 됨 (모두 10)
- **원인**: routes.ts L5434에서 FilteredCandidate → VectorSearchResult 변환 시 riskPenalty 필드 strip, vectorResultsToScoredJobs에서 baseRisk=10 하드코딩
- **해결**: routes.ts에 riskPenaltyMap 추가, scoredJobs에 tag-filter 값 적용, cap 8→15 확대
- **교훈**: 파이프라인에서 타입 변환 시 필드 손실 여부를 end-to-end로 확인해야 함. 특히 타입이 달라지는 지점에서 데이터 흐름 추적 필수

### [2026-03-05] 인터뷰: 감정질문 82% ✅ 부분 해결 (v3.16.0, 54%로 감소)
- **상황**: cag-manager에 감정질문 1개 제한 추가했으나 실측 38~82%
- **원인**: Round 1에는 기존 질문 이력이 없어 체크 자체가 발동 안 됨. LLM도 프롬프트 규칙 무시
- **해결**: generateRoundQuestions에 서버사이드 감정질문 패턴 필터 추가 (라운드당 1개)
- **남은 이슈**: "느끼는", "느끼고" 등 활용형까지 패턴 확장 필요. 감정질문 정의 자체가 모호 — "어떤 기분" vs "어떤 자유를 느끼실" 구분이 어려움
- **교훈**: LLM 프롬프트만으로는 행동 통제 불가 → 구조적 강제 필수. 단, 감정 표현의 정의를 너무 넓게 잡으면 유효한 질문도 필터링됨

### [2026-03-05] 검색: "연구원" 카테고리 노이즈 유입 ✅ 대부분 해결 (v3.16.0)
- **상황**: 버섯연구원, 환경연구원, 국악연구원 등 무관한 직업이 Top 15에 진입
- **원인**: 벡터 임베딩에서 "연구원"이 "분석/기술"과 가까워서 검색 시 무차별 유입
- **해결**: sanitizeKeywordOvermatching에 범용 suffix 도메인 불일치 체크 + 노이즈 직업명 패턴 감점 추가
- **남은 이슈**: 내면갈등 시나리오에서 가스설비안전성연구원, 기능성식품연구원 일부 잔존 (interest 도메인 키워드 매칭 범위 조정 필요)
- **교훈**: 벡터 검색 후 코드 기반 post-filter가 필수. LLM 프롬프트 기반 Relevance Gate만으로는 불안정

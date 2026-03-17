# Lessons Learned

### [2026-03-17] 데이터 보완: 출처 없는 데이터는 절대 넣지 않는다
- **상황**: 숲해설사 직업의 빈 필드를 채우면서 적성 목록, 학력분포 %, 만족도 수치, 교육과정 등을 출처 없이 AI 추정값으로 넣음
- **원인**: "빈 필드를 빨리 채우자"는 목표에 매몰되어 출처 확보 없이 그럴듯한 값을 생성함. 텍스트 필드에만 출처를 달고 구조화 데이터(배열, 수치)에는 출처가 불필요하다고 착각
- **해결**: 출처 없는 구조화 데이터 전부 롤백 (null로 덮어쓰기). 스킬 파일에 "출처 없으면 안 넣는다" 최우선 원칙으로 명시
- **교훈**: 빈 필드보다 잘못된 데이터가 더 나쁘다. 모든 데이터(텍스트든 수치든)에 반드시 출처가 있어야 한다. 공식 통계를 최대한 찾되, 못 찾으면 비워둔다

### [2026-03-14] 출처 URL: 구글 검색 결과의 구버전 URL 사용 금지
- **상황**: 리서치 에이전트가 구글에서 커리어넷 직업 URL을 검색, `/cnet/front/base/job/jobView.do?SEQ=` 형식으로 수집
- **원인**: 커리어넷 사이트가 리뉴얼되어 URL 체계가 `/cloud/w/job/view?seq=`로 변경됨. 구글 인덱스에는 구버전 URL이 남아있어 검색에 노출
- **해결**: 20개 직업의 출처 URL을 전부 신규 형식으로 재수정
- **교훈**: 출처 URL 수집 후 반드시 `curl -w "%{http_code} %{redirect_url}"` 로 실제 접속+리다이렉트 여부 검증. 구글 검색 결과를 맹신하지 말 것

### [2026-03-14] linkify 정규식: &lt; 가 개별 문자로 해석
- **상황**: 사용자 출처 URL이 중간에서 잘려 앞부분만 링크로 변환됨
- **원인**: `[^\s,)&lt;]` 정규식에서 `&lt;`가 HTML 엔티티가 아닌 개별 문자 `&`,`l`,`t`로 해석 → URL의 `t`에서 매칭 중단
- **해결**: `[^\s,)<>]`로 변경
- **교훈**: 정규식 character class 안에서 HTML 엔티티(`&lt;`, `&gt;`)는 의도대로 동작하지 않음. 리터럴 문자로 직접 써야 함

### [2026-03-09] ETag 캐시: 동일 길이 문자열 변경 시 캐시 무효화 실패
- **상황**: `api-client.js?v=20260306a` → `v=20260309a`로 변경했으나, 브라우저가 계속 old 버전 서빙
- **원인**: ETag가 `${version}:${pageType}:${slug}:${content.length}` 기반. 변경 전후 문자열 길이가 동일하여 ETag 불변 → 304 응답 → 브라우저 캐시 유지
- **해결**: `src/constants/template-versions.ts`에서 JOB/MAJOR 버전 범프 → ETag의 version 필드 변경 → 새 ETag 생성 → 캐시 무효화
- **교훈**: 정적 자산 버전 변경 시 반드시 template-versions.ts 버전도 함께 범프. ETag는 content length 기반이므로 동일 길이 문자열 변경은 감지 불가

### [2026-03-07] HowTo: 주제 중복 발행 실수
- **상황**: "소방공무원 체력시험"과 "공인중개사 독학" 주제를 새로 발행했는데, 이미 동일 주제의 기존 글(pageId 4001, 3944)이 존재했음
- **원인**: 기존 발행 글 목록을 DB에서 확인하지 않고 주제를 선정함. 기존 글 제목과 미묘하게 달라서 겹치는지 인식 못함
- **해결**: 중복 글 2개를 status='deleted'로 변경하고 새로운 주제(CPA, TOEFL)로 교체
- **교훈**: howto-publish.md 스킬에 중복 방지 규칙 추가함. **주제 선정 전에 반드시 `SELECT id, title FROM pages WHERE page_type='guide' AND status='published'` SQL로 기존 글 전체 목록을 확인**해야 함. 제목이 달라도 같은 시험/자격증이면 중복

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

### [2026-03-06] D1: json_extract 대량 호출 시 Memory Limit 초과
- **상황**: migrate-goyong24 API에서 7000개 행에 `json_extract(merged_profile_json, ...)` 실행 → D1 메모리 한계 초과
- **원인**: D1의 메모리 리밋이 있어서 대량 JSON 파싱은 실패함
- **해결**: `LIKE '%"type":"breadcrumb"%'` 패턴 매칭 + `LEFT JOIN ... IS NULL` + LIMIT 배치 처리
- **교훈**: D1에서 json_extract는 소규모(수백)만 가능. 대규모는 LIKE 패턴 또는 별도 컬럼 사용

### [2026-03-06] LLM: GPT-4o-mini가 산업분류(KSIC)를 직업분류로 혼동
- **상황**: 배치 LLM 분류에서 "제조직", "경비·경호 및 탐정업" 등 잘못된 카테고리 반환 (~30% 실패)
- **원인**: merged_profile_json의 산업분류 코드가 프롬프트에 포함되어 LLM이 혼동
- **해결**: (1) 프롬프트에 "산업분류(KSIC)가 아닌 직업분류" 강조 (2) 퍼지 매칭 폴백 (키워드→유효 카테고리) (3) 낮은 confidence(0.6) 부여
- **교훈**: LLM에 분류 체계 제공 시 혼동 가능한 다른 분류 체계를 명시적으로 배제. 폴백 매핑으로 100% 분류율 확보

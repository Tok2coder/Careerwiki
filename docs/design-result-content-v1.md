# 설계서: 추천 결과 콘텐츠 밀도 개편 (P4) v1

작성: 차민혁 / 2026-07-07 / 승인: Jason ("그거 다 진행")

## 배경
결과 페이지가 점수표 수준 — 유저가 원하는 연봉·전망·되는법·비교·첫걸음 부재.
근본 원인: 추천이 자기 위키 데이터(6,945 직업의 sal/prospect/way/자격증/HowTo)를 join하지 않음.
+ 영어 토큰 ID(art/organizing/routine)가 화면·LLM 응답에 날것 노출 (Jason 지적).

## 범위

### P4-0. 영어 토큰 노출 전수 수리 (최우선)
- 라벨 SSOT: `mini-module-questions.ts`의 질문 정의(text)에서 토큰→한글 맵 자동 생성 (`tokenToKo`/`tokensToKo` export)
- 적용 길목: ① 프론트 토큰 직접 렌더 지점 ② LLM 프롬프트 주입 지점(judge userContext, searchProfile 생성, reporter 입력) — LLM이 영어 토큰을 에코하는 원천 차단
- 커버리지: 흥미/가치/강점/제약/워크스타일/희생/에너지드레인 전 토큰

### P4-1. 추천 카드 위키 데이터 결합
- 서버: 최종 top_jobs 구성 시 D1 1쿼리로 merged_profile_json에서 추출 →
  `salary_text`(overviewSalary.sal 요약), `prospect_text`(전망 앞부분), `way_text`(되는법 앞부분), `certifications[]` 필드 추가
- 프론트: 추천 카드에 연봉·전망·되는법·자격증 행 + 직업 페이지 딥링크 버튼
- 캐시: 필드 추가는 additive — 엔진 버전 범프로 구캐시 무효화

### P4-2. top3 비교 블록
- deferred 리포트 생성에 편승(추가 대기 0): 리포터가 top3 트레이드오프 비교(comparison) 섹션 생성
- 프론트: 요약 탭에 비교 표 렌더

### P4-3. "오늘 할 수 있는 첫 걸음"
- way_text 기반 첫 걸음 + HowTo 가이드 연결(동일 Vectorize 인덱스 howto: prefix 검색, top1 직업 기준 1-2개)
- 요약 탭 하단 블록

### P4-4. 리포트 서사 밀도
- 리포터 프롬프트: 유저 서사 원문 인용을 뼈대로 쓰도록 개편 (P3 Judge와 동일 원칙)

## 검증
- tsc/build/deploy/smoke + 신규 프로필 E2E로 카드 필드·비교·첫걸음 존재 확인
- 영어 토큰: 응답 JSON+리포트 텍스트에 `[a-z_]{4,}` 토큰 패턴 부재 grep
- 하네스 회귀: hit@10 불변 (콘텐츠 변경은 랭킹 무영향이 원칙 — P4-0의 프롬프트 한글화만 랭킹에 영향 가능, 전/후 확인)

## 리스크
- P4-0 프롬프트 한글화가 Judge 점수 분포를 미세하게 바꿀 수 있음 → 엔진 버전 범프 + 하네스 확인
- 카드 필드 추가로 응답 크기 증가(직업당 ~0.5KB × 30) — 무시 가능

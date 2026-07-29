# R130 완료 보고 (2026-07-29)

## 결과
- 25/25 완료. KPI **3621** (3596+25 정확 일치). max master rev 23452.
- 집합검증 25/25, 마커 25/25, 명단 밖 오염 0, audit 실FAIL 0.
- distinct URL **25/25 전건 ≥18** (18~20), totalE min 19, URL-set 재사용 FAIL 0.
- prod 표본 3/3 200 (원유품질검사원·원목공급원·원예치료사), 각주 22~30 정상.
- sal/wage 미접촉, baseline 이탈 0.

## 사고와 수습
1. 배치 5세션 전부 WebSearch 200회 한도 소진 → 10직 distinct 10~12 미달 + data.go.kr 편중 2직 + 원목관리원↔원목운반원 URL-set Jaccard 52%/피복률 68% FAIL.
   → 재보강 5세션(S1·S2·S3·S2b·S3b)으로 11직 전건 해소 (rev 23429~23439). soft-flag 0 마감.
2. S2·S3 세션한도 사망 → DB landing 실측으로 미완 4직만 특정해 재배치. 중복 POST 0.
3. opus 검증 2분할(V1 13직·V2 12직), 수치 121건 전건 triage → 실결함 12건 정정 (rev 23440~23452).
   - WRONG 8: 처리기간 30배 오독 2건(1개월→1일 / 3개월→3일), 원목공급원 날조 수치, 원목분류원 원문 부재+연도 오귀속, 25곳→23곳, CTP 1999년 자기모순, 기사 게재일 오귀속, 실시간 대시보드값 재현불가.
   - 오귀속 4: 국내 1위(원문 부재), 크레인 2톤 기준, 세로토닌 40% 대상 누락, 기업 root URL.
4. 형제 복붙: 원목등급원↔원목인양기조종원 prospect 3문장 Jaccard 1.00 → 고유 서술 교체(23452). 재검 0쌍.
5. urlUnverified 4건 전건 거짓양성(Chrome UA 200 + 실콘텐츠).

## 잔존 (R131 이관)
- 원예작물환경연구원 비료관리법 링크가 연혁(구법)판 — 수치는 정확, 현행법 링크 교체 권고.
- 목재이용실태조사 통계 3직 중복 인용 (문장 상이, 복붙 아님 — 관찰만).

## 권고
1. numprov에 EUC-KR·PDF 인코딩 폴백 추가 — 이번 WRONG 8건 중 2건이 "스크립트가 못 읽어서" NOT_FOUND 뒤에 숨어 있었다.
2. 배치 세션 WebSearch 예산 소진이 5/5 재현 — 배치 크기 축소 또는 대체 검색 경로(DuckDuckGo HTML·Jina Reader) 기본 탑재.

## 확인 방법
- https://careerwiki.org/admin/job-equalize?fresh=1
- https://careerwiki.org/job/원목공급원 · /job/원유품질검사원 · /job/원예치료사

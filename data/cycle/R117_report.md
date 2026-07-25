# R117 cycle 보고 (2026-07-25)

## 한 일
언어재활사~엔진조립원 25직업 master enhance (🔀 v6-disperse 11회차: 에너지5·에이3·에프2·엔진2·엘리2·엘이2·에스2 형제 분산). sonnet 5배치 foreground 병렬 + opus 검증 이원화.

## 결과 (25/25)
- **집합검증 25/25 정확 일치·이탈 0** (rev 22615~22663, latest=master 25/25)
- **마커 25/25 top-level** (R39 무마커 0)
- **audit 실FAIL 0** (verify-cycle PASS 20 / WARN 5 = 전부 urlUnverified TLS 거짓양성)
- **urlUnverified 5직업(10 URL) opus 3분류: 거짓양성 5/5 유지, dead교체 0, 정책위반교체 0** (keri.re.kr·lems.seaman.or.kr·kola.or.kr·katech.re.kr — bogus 경로 400/500 반환으로 실페이지 live 확정, katech/seaman은 R80/R78 반복확정 도메인)
- **totalE 전건 ≥19** (min 19 = 에프알피선박수지적층원)
- **distinct**: major 15직 ≥18 / niche 10직 11~12
- **산문 복붙 0쌍** (형제군 4-gram Jaccard max 2.2%, 에너지5그룹 0.1~0.6%)
- **통계누출 0** (형제 대표전용 통계 비대표 재인용 0)
- **prod 표본 3/3** 200 (에너지저장연구원·엔진검사원·에이치티엠엘html코딩원)

## rev 상세 (25)
| slug | rev | distinct | totalE | class |
|---|---|---|---|---|
| 언어재활사 | 22615 | — | — | B1 |
| 언론정책연구원 | 22617 | 19 | 20 | major |
| 에너지저장연구원 | 22619 | 18 | 27 | major |
| 얼음판매원 | 22621 | 11 | 20 | niche |
| 어촌지도사 | 22623 | 18 | 27 | niche |
| 에너지공정연구원 | 22625 | — | — | B1 |
| 에너지진단사 | 22627 | 19 | 22 | major |
| 에어백제조원 | 22629 | 19 | 28 | major |
| 에너지기기시험성능평가원 | 22631 | 18 | 20 | major |
| 에너지정책연구원 | 22633 | 18 | 29 | major |
| 에이징원 | 22635 | — | — | B1 |
| 에스코esco사업관리사무원 | 22637 | 18 | 23 | major |
| 에이치티엠엘html코딩원 | 22639 | 19 | 26 | major |
| 에스컬레이터설치원 | 22641 | 18 | 28 | major |
| 에이치씨아이-컨설턴트 | 22643 | 18 | 22 | major |
| 에프알피선박건조재료제조현장감독자 | 22645 | — | — | B1 |
| 엔n스크린서비스개발자 | 22647 | 18 | 24 | major |
| 엘리베이터유지관리원 | 22649 | — | — | B1 |
| 에프알피선박수지적층원 | 22651 | 11 | 19 | niche |
| 엔진검사원 | 22653 | 18 | 31 | major |
| 에지밴딩기조작원 | 22655 | 11 | 28 | niche |
| 엘리베이터설치원 | 22657 | 18 | 23 | major |
| 엘이디led조명품질관리원 | 22659 | 11 | 21 | niche |
| 엘이디제조원 | 22661 | 18 | 31 | major |
| 엔진조립원 | 22663 | 12 | 26 | niche |

(B1 5직업은 배치 최종요약에 표 미반환 → DB 집합검증으로 랜딩 확인, 게이트 통과)

## 사고와 수습
- **B1 배치 최종 요약에 per-job 표 미반환** — 워커 자가보고 불신 원칙대로 추측 배제, DB 집합검증(22615/22625/22635/22645/22649 전건 latest=master)으로 랜딩 실증 → 완료 게이트 통과. (중복/누락 0)
- 전배치 WebSearch 세션한도(200) 소진 → 후반 직업 WebFetch/Jina Reader 대체(전 URL node fetch 200 확인 후 등록). pool-limited 0.
- 그 외 리밋·세션사망·전멸·fix POST **0**. opus 수정세션 생략(실FAIL 0).

## 부작용 없음
- sal/wage 미접촉(전 25 rev), baseline 이탈 0, 명단 밖 무접촉.
- careerTree 신규 1건: 에너지정책연구원(이회성, career_trees id=419) — 위키 등재 인물 정상 생성.

## KPI
**3296** (예상 3271+25 정확 일치, 이중 실측: admin fresh 3,296 + KPI CTE 독립쿼리 3,296). max master rev 22663.

## 확인 방법
- admin: https://careerwiki.org/admin/job-equalize (KPI 3296)
- 표본: https://careerwiki.org/job/에너지저장연구원 · /job/엔진검사원 · /job/에이치티엠엘html코딩원

R118은 go 주면 시작.

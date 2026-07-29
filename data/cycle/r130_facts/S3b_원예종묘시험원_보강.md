# 원예종묘시험원 — R130 재보강(S3b) 추가 출처 근거

보강 전 distinct=10 (data.go.kr 7/10=70% 편중) → 목표: +8 & data.go.kr ≤30%

## 신규 도입 수치 — 3열 표 (원문 인용 검증)

| 수치 | 출처URL | 원문 인용 구절 |
|---|---|---|
| 2012년 1월 7일 딸기·나무딸기·감귤·블루베리·양앵두·해조류 추가로 모든 작물이 품종보호 대상이 됨 | https://www.seed.go.kr/seed/963/subview.do | "2012년 1월 7일 딸기, 나무딸기, 감귤, 블루베리, 양앵두, 해조류가 포함되면서 모든 작물이 품종보호의 대상이 되었습니다." |
| 딸기 '고슬' — 2012년 'Albion'×'설향' 교배로 육성, 화방수 2.5개(Redpearl보다 1.5개 많음) | https://www.dbpia.co.kr/journal/articleDetail?nodeId=NODE10712535 | "'고슬'은 'Albion'을 모본으로 하고 '설향'을 부본으로 2012년 교배하여... 우수한 중일성 개체를 선발한 것이다.", "화방수는 2.5개로 'Redpearl'보다 1.5개 더 많았다." (한국국제농업개발학회지 32권 1호, 2020) |
| 국립종자원 특성조사기준 대상 원예작물 145개 품목 | https://www.seed.go.kr/seed/192/subview.do | "채소류(가지, 갓), 과수류(감, 감귤), 화훼류(가우라, 개나리, 거베라) 등 다양한 원예작물 145개 품목이 목록으로 제시" |
| 밀 신품종 보호 등록 심사기준 UPOV 27항목 반영, 조사항목 30개→31개 개정(2024.12.26 발표, 12.27 시행) | https://mafra.go.kr/bbs/home/792/572706/artclView.do | "UPOV 기준(27항목)과 육성자 의견을 반영하여... 기존에 사용해 오던 30개 조사항목 중... 11개 특성을 보완, 삭제하여 최종 31개 특성 조사항목으로 결정" |
| 원예과학기술지(HST) 1998년 창간 | https://www.hst-j.org/journal-information/about/ | "HST was launched in 1998" |

## 조치 요약
- data.go.kr 중복 사용 URL 3건 제거: 국가품종목록 데이터셋(15047612, 4개 슬롯 중복) → 국립종자원 공식 소개 페이지(seed.go.kr/917)로 교체(같은 사실을 1차 기관 자체 페이지로 격상), 제주 종자업육묘업 등록현황(15096859)·경남양산시 초화류육묘장현황(15074126) → 각각 국립종자원·DBpia로 교체(tangential 지자체 개별 데이터셋 제거)
- 신규 8건 슬롯 추가(overviewAbilities.technKnow[4], detailWlb.wlbDetail[3], detailWlb.socialDetail[2], overviewProspect.main[3], detailReady.curriculum[6], detailReady.recruit[2][3], detailReady.training[3])

## 시도 도메인 (전부 실제 WebFetch/node fetch로 시도)
| 도메인 | 결과 |
|---|---|
| www.seed.go.kr (국립종자원) | 성공 — 5개 딥페이지(917 국가품종목록/963 품종보호대상/192 특성조사기준/113 유전자분석/248 처리절차) |
| www.krei.re.kr (한국농촌경제연구원) | 성공 |
| www.nihhs.go.kr (국립원예특작과학원) | 성공(딥페이지 intro_Introview.do). 루트 페이지는 JS-shell로 빈 콘텐츠라 서브페이지로 대체 |
| www.rda.go.kr (농촌진흥청) | 성공 — 2024 연구성과보고서(기존 way의 메인페이지와 다른 딥URL) |
| mafra.go.kr (농림축산식품부) | 성공 — 보도자료(밀 신품종 심사기준 개정). 루트는 JS-shell이라 bbs 딥링크 사용 |
| www.dbpia.co.kr | 성공 — 딸기 '고슬' 육성 논문(한국국제농업개발학회지) |
| www.hst-j.org / horticulture.or.kr (한국원예학회) | horticulture.or.kr 루트는 rootURL 게이트 걸림 → 학회 발행 학술지 사이트(hst-j.org) 딥페이지로 대체, 성공 |
| kosaseed.or.kr (한국종자협회) | 인증서 만료(certificate expired) — 보안 사유로 미사용 |
| www.upov.int (UPOV) | 200 확인, 영문 콘텐츠·외국기관이라 한국 출처 우선 정책상 미사용 |
| www.ksa.or.kr, www.standard.go.kr 등 | 이번 배치에서는 job1(원염용해조조작원)에서 이미 시도해 JS-shell 확인, job2에서는 재시도 생략 |

## 결과 (POST 실측)
- revisionId: 23439
- distinct: 10 → 18
- 도메인 수: 4 → 10
- data.go.kr 비중: 70% (7/10) → 22.2% (4/18)
- 최대 도메인 비중: www.seed.go.kr 27.8%(5/18) — ≤30% 충족
- audit-via-api.cjs: clean (0/1 FAIL)

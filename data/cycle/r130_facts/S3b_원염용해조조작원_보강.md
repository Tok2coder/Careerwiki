# 원염용해조조작원 — R130 재보강(S3b) 추가 출처 근거

보강 전 distinct=12 (data.go.kr 8/12=67% 편중) → 목표: +6 & data.go.kr ≤30%

## 조치 요약
- data.go.kr 중복 사용 URL 3건 제거(한국동서발전/한수원/한국가스공사 화학물질 사용량 — 직무와 tangential한 decorative 인용) → trivia[3][4][5], recruit[2] 슬롯을 신규 출처로 교체
- 신규 9건 슬롯 추가(way[4], overviewProspect.main[3], overviewAbilities.technKnow[3], detailWlb.socialDetail[2], detailReady.curriculum[6])
- 본 보강은 전부 정성 서술(기관 기능·법령 소관 설명)이며 **신규 수치(통계·연도·금액) 미도입** — 3열 수치표 해당 없음

## 시도 도메인 (전부 실제 WebFetch/node fetch로 시도)
| 도메인 | 결과 |
|---|---|
| nics.mcee.go.kr (화학물질안전원) | 성공 — 비전·기능 페이지(sub.do?menuId=101) 사용 |
| www.krict.re.kr (한국화학연구원) | 성공 — 화학공정연구본부(sub02_01_01.do) 사용. 화학소재연구본부(sub02_02_01.do)·정밀바이오화학연구본부(sub02_04_01.do)는 내용 확인했으나 직무 연관성 낮아 미사용 |
| www.kcma.or.kr (한국화학물질관리협회) | 성공 — 정보포털서비스(sub_info/info_main.asp) |
| edu.kcma.or.kr (KCMA 안전교육센터) | 성공 — main/main.asp |
| dart.fss.or.kr (전자공시시스템) | 성공 — 공시서류 통합검색(dsab007/main.do). 특정 기업(한화솔루션 등) 소다회 생산 개별 보고서 링크는 rcpNo 미확보로 사용 안 함 |
| stat.kita.net / www.kita.net (한국무역협회 K-Stat) | stat.kita.net 성공(품목 수출입 통계). www.kita.net 루트만 확인되고 딥링크(JS 메뉴)를 찾지 못해 최종 미사용 |
| www.mcee.go.kr (기후에너지환경부) | 성공 — 화학물질안전원 소속기관 확인 |
| standard.go.kr, ksa.or.kr, ktl.re.kr, kosha.or.kr, kgs.or.kr, nier.go.kr, cheric.org | 200 응답이나 JS-shell(본문 렌더 안 됨)이거나 직무 연관성 낮아 미사용. **cheric.org는 도메인이 베트남어 스포츠 스트리밍 사이트로 만료·재판매됨을 확인 — 절대 인용 금지** |
| law.go.kr 화평법(화학물질의 등록 및 평가 등에 관한 법률) | 성공 — way[4] 신규 추가 |

## 결과 (POST 실측)
- revisionId: 23438
- distinct: 12 → 18
- 도메인 수: 4 → 11
- data.go.kr 비중: 67% (8/12) → 27.8% (5/18)
- audit-via-api.cjs: OK (0/1 FAIL, TLS 소프트 warning 2건 — kcma.or.kr 계열 로컬 인증서 체인 이슈, WebFetch로 콘텐츠 실존 확인함)

# R133 Seed URL Pool + 파리티 기준표 (v7.1 준비 세션)

생성: 2026-07-30. 본 세션은 **enhance/POST/audit 미실시** — 명단 산출 + 파리티 기준표 + seed URL 발굴/검증만 수행.
모든 URL은 `node scripts/skill-cache/_scratch_url_verify.cjs`(Chrome UA, redirect 추적, rejectUnauthorized:false)로 **200 + 본문 3KB 이상**을 개별/배치 확인한 것만 등록. class·파리티기준 표기는 DB 실측 기반 권고치이며 최종 판정은 enhance 세션(job-data-master SKILL.md 룰 9)의 몫이나, **파리티 기준=18인 직업은 niche 자가 하향 금지** (v7.1 신규 게이트 취지).

---

## 파리티 기준표 (R130~132 "형제 파리티 분열" 재발 방지 — v7.1 핵심)

R130~132 3 cycle 연속으로 같은 heroCategory 형제 직업 중 일부만 distinct 18~20을 달성하고 나머지가 "niche"를 자칭해 10~13으로 자가 하향하는 사고가 재현됐다(R132 실측: 반도체 19~20 vs 10~12, IT 18 vs 10~13, B2가 위권틀보기원 distinct 19 보고 → 게이트 실측 10). 이를 차단하기 위해 R133의 25직 각각에 대해 **DB에서 같은 heroCategory 기존 마커 보유 직업의 실측 distinct**를 조회했다(`master-verify-cycle.cjs --slugs-file` 실측, prod GET 기반).

판정 룰: 동일 heroCategory 표본 중 **1건이라도 distinct≥18이면 기준=18(하향 절대 불가)**. 표본 전건이 10~13에 수렴하고 18+ 사례가 0건이면 "niche 후보(10+)"로 표기.

| # | 직업 | heroCategory | 파리티 근거 (DB 실측) | 기준 distinct |
|---|---|---|---|---|
| 1 | 위생도기이형제처리원 | 내화,비내화 요업제품 제조업 | 형제 내화물연구자 실측 distinct=18 | **18** |
| 2 | 위생용품제조반장 | 기타 종이 및 판지 제품 제조업 | 동일 heroCategory 6표본(벽지개발연구원11·벽지검사원10·벽지-디자이너13·봉투제조원10·벽지제조반장11·발포제제조원11) **전건 10~13, 18+ 사례 0건** | niche 후보(10+) |
| 3 | 위성통신망시공기술자 🔴 | 전기 통신업(명칭중의성) | 형제 무선통신연구원 실측 distinct=19 | **18** |
| 4 | 위험평가사정원 | 보험업 | 동일 heroCategory 5표본 중 보험중개인 d=19(보험계리사13·손해사정사10·보험설계사11·보험상품개발자11은 낮으나 18+ 실적 존재) | **18** |
| 5 | 유가증권대차거래중개인 | 금융 지원 서비스업 | 동일 heroCategory 선물옵션시장분석가 d=19·개인자산관리사 d=18(애널리스트9·외환딜러11은 낮으나 18+ 실적 존재) | **18** |
| 6 | 위변조방지기술개발원 | 인쇄 및 인쇄관련 산업 | 동일 heroCategory 오프셋인쇄기조작원 실측 distinct=18 | **18** |
| 7 | 위생도기조립원 | 내화,비내화 요업제품 제조업 | 형제 내화물연구자 d=18 (동일 카테고리, #1과 공유) | **18** |
| 8 | 위생청소원 | 하수, 폐수 및 분뇨 처리업 | 동일 heroCategory 공공폐수처리시설관리자 실측 distinct=19 | **18** |
| 9 | 위성통신망운용원 | 전기 통신업 | 무선통신연구원 d=19 | **18** |
| 10 | 유가증권매매제도기획원 | 금융 지원 서비스업 | 선물옵션시장분석가 d=19 | **18** |
| 11 | 위생용품가공설비조작원 | 기타 종이 및 판지 제품 제조업 | 6표본 전건 10~13, 18+ 사례 0건 (#2와 동일 근거) | niche 후보(10+) |
| 12 | 위성방송상품개발원 🔴 | 전기 통신업(명칭중의성) | 무선통신연구원 d=19 — **산업통계 인용 대표** | **18** |
| 13 | 위성통신설비관리원 | 전기 통신업 | 무선통신연구원 d=19 | **18** |
| 14 | 위조주화감정연구원 | 그 외 기타 전문, 과학 및 기술 서비스업 | 동일 heroCategory 감정업 계열 미술품감정사 d=18·국가유산감정사 d=18·문서감정사 d=23 (감정업 축 18+ 확고) | **18** |
| 15 | 유가증권발행사무원 | 금융 지원 서비스업 | 선물옵션시장분석가 d=19 | **18** |
| 16 | 위생용품검사원 🔴 | 기타 종이 및 판지 제품 제조업(명칭중의성) | 6표본 전건 10~13, 18+ 사례 0건 | niche 후보(10+) |
| 17 | 위성통신망감리원 | 전기 통신업 | 무선통신연구원 d=19 | **18** |
| 18 | 위성통신설비연구원 | 전기 통신업 | 무선통신연구원 d=19 | **18** |
| 19 | 위폐감정사 | 은행 및 저축기관 / 입법 및 일반 정부 행정(이중분류) | 은행업 축 여신심사사무원 d=20 + 감정업 축 미술품감정사 d=18·문서감정사 d=23 (양 축 모두 18+) | **18** |
| 20 | 유가증권보관사무원 | 금융 지원 서비스업 | 선물옵션시장분석가 d=19 | **18** |
| 21 | 위생용품성형설비조작원 | 기타 종이 및 판지 제품 제조업 | 6표본 전건 10~13, 18+ 사례 0건 | niche 후보(10+) |
| 22 | 위성통신망설계기술자 🔴 | 전기 통신업(명칭중의성) | 무선통신연구원 d=19 | **18** |
| 23 | 위험물취급원 🔴 | 기타 운송관련 서비스업(명칭중의성) | 동일 heroCategory 관세사 실측 distinct=18 — **산업통계 인용 대표** | **18** |
| 24 | 윈치염색원 | 섬유제품 염색, 정리 및 마무리 가공업 | 동일 heroCategory 염색반장 d=19·염색시험원 d=19(스크린날염반장 d=11 혼재하나 18+ 실적 존재) | **18** |
| 25 | 유가증권-디자이너 🔴 | 인쇄 및 인쇄관련 산업(명칭중의성) | 오프셋인쇄기조작원 d=18 — **산업통계 인용 대표** | **18** |

**요약**: 기준=18 → 21직 (niche 자가 하향 절대 금지). niche 후보(10+) → 4직, 전부 "위생용품(기타 종이/판지 제품 제조업 — 벽지·봉투류)" 계열로 6표본 DB 실측 전건 10~13에 수렴 + 18+ 사례 0건 확인된 **진짜 니치**(단, 니치도 distinct≥10 필수, <10 금지는 기존 룰 유지). 🔴 = 명칭 중의성(직업명 신호와 DB heroCategory 불일치) 6건.

---

## B1

### 위생도기이형제처리원 (id=1765285227463501, heroCategory: 내화,비내화 요업제품 제조업, class=major, 파리티기준=18 — 산업통계 인용 대표)
- [표준] https://standard.go.kr/KSCI/standardIntro/getStandardSearchView.do?menuId=919&topMenuId=502&upperMenuId=503&ksNo=KSL1551 — KS L 1551 위생도기 국가표준 규격 (verify: 200, len=146151)
- [공정] https://scienceon.kisti.re.kr/srch/selectPORSrchArticle.do?cn=JAKO200211921036626 — 위생도기 제조공정 및 향후전망 논문(KISTI ScienceON) (verify: 200, len=433154)
- [산업동향] https://koreascience.kr/article/JAKO201624558247444.pdf — 위생도기 산업동향·전망(초절수형·방오소재) 논문 PDF (verify: 200, len=1794669)
- [검사] https://www.kicet.re.kr/00018/00078/00306.web — 한국세라믹기술원 이천분원(전통세라믹·요업 시험인증) (verify: 200, len=46497)
- [안전] https://www.law.go.kr/LSW//lsLawLinkInfo.do?lsJoLnkSeq=1012805087&chrClsCd=010202&ancYnChk= — 산업안전보건법 제16조(관리감독자) 조문 (verify: 200, len=4526)
- [정책] https://www.kicet.re.kr/00020/00118/00126.web — 한국세라믹기술원 세라믹 기술백서(산업동향·경쟁력분석) (verify: 200, len=53063)

### 위생용품제조반장 (id=1765285524682972, heroCategory: 기타 종이 및 판지 제품 제조업, class=niche, 파리티기준=10+)
- [법령] https://www.law.go.kr/LSW/lsInfoP.do?lsiSeq=264881 — 위생용품 관리법 시행규칙 본문 (verify: 200, len=145691)
- [정책] https://www.gov.kr/mw/AA020InfoCappView.do?CappBizCD=14600000029&tp_seq=01 — 위생용품제조업 등 영업신고(정부24) (verify: 200, len=219953)
- [기준] https://www.mfds.go.kr/wpge/m_675/de010410l003.do — 식약처 위생용품 정보(기준·규격) (verify: 200, len=165482)
- [공정] https://www.fnnews.com/news/202507301046087409 — 유한킴벌리 충주공장 위생용품 생산라인 대전 이전 기사 (verify: 200, len=67629)
- [검사] https://m.ktr.or.kr/test-evaluation/contentsid/1790/index.do — KTR 위생용품 자가품질시험검사 (verify: 200, len=48782)
- [안전] https://www.law.go.kr/LSW/lsLawLinkInfo.do?lsJoLnkSeq=1000996608&chrClsCd=010202 — 산업안전보건법 시행령 제15조(관리감독자 업무) 조문 (verify: 200, len=4765)

### 위성통신망시공기술자 (id=1765283680686696, heroCategory: 전기 통신업 — 🔴명칭중의성, class=major, 파리티기준=18)
- [법령] https://www.law.go.kr/LSW//lsLinkProc.do?lsNm=전파법&mode=4&lsId=2001582&lsClsCd=L&joNo=001900000^002000000^002100000^002200000^002300000^002400000^002500000^002600000^002700000^002800000^002900000^003000000^003100000&ancYd=20180118 — 전파법 무선국 개설허가 조문 (verify: 200, len=39664)
- [표준] https://www.rra.go.kr/ko/reference/lawList_view.do?lw_seq=46 — 국립전파연구원 무선설비 기술기준 고시 (verify: 200, len=126747)
- [자격] https://www.koit.co.kr/news/articleView.html?idxno=122252 — 정보통신신문 "학·경력자도 특급 인정" 정보통신기술자 등급 기사 (verify: 200, len=103649)
- [직무] https://career.kica.or.kr/help/qna/8873 — 한국정보통신공사협회 온라인 경력신고 시스템 Q&A (verify: 200, len=19412)
- [산업동향] https://www.asiatoday.co.kr/kn/view.php?key=20260727010009807 — KT SAT 해양경찰청 위성통신망 사업 3년 연속 수주 기사 (verify: 200, len=61635)
- [산업동향] https://ettrends.etri.re.kr/ettrends/185/0905185007/ — ETRI Trends "저궤도 위성통신망 기반 글로벌 무선통신 기술동향" (verify: 200, len=81861) *(교체: etnews.com 20260427000293 중복 해소)*

### 위험평가사정원 (id=1765284092062153, heroCategory: 보험업, class=major, 파리티기준=18)
- [자격] https://www.fss.or.kr/fss/job/gyerythaBsmn/list.do?menuNo=200610 — 금융감독원 손해사정사·보험계리사 등록여부 조회 (verify: 200, len=295706)
- [법령] https://www.law.go.kr/admRulLsInfoP.do?admRulSeq=2200000080687 — 보험업감독업무시행세칙(금융감독원세칙) (verify: 200, len=77892)
- [자격] https://kicaa.or.kr/new/03_institution/exam.html — 한국손해사정사회 손해사정사 시험제도 안내 (verify: 200, len=64408)
- [법령] https://casenote.kr/법령/보험업법/제185조 — 보험업법 제185조(손해사정) 조문 (verify: 200, len=36074)
- [법령] https://www.law.go.kr/LSW/lumLsLinkPop.do?lspttninfSeq=74276&chrClsCd=010202 — 보험업법 시행규칙 관련조문 (verify: 200, len=31539)
- [정책] https://kicaa.or.kr/new/board/board_view.html?code=1&no=399 — 한국손해사정사회 2025년 상반기 손해사정업자 공시 안내 (verify: 200, len=51702)

### 유가증권대차거래중개인 (id=176528408866071, heroCategory: 금융 지원 서비스업, class=major, 파리티기준=18)
- [법령] https://law.kofia.or.kr/service/law/lawFullScreenContent.do?seq=124&historySeq=235 — 금융투자협회 증권 대차거래 약관 규정내용 (verify: 200, len=59374)
- [법령] https://law.kofia.or.kr/service/law/lawFullScreenContent.do?seq=336&historySeq=1425 — 금융투자회사 증권 대차·공매도 업무처리 모범규준 (verify: 200, len=45372)
- [법령] https://law.kofia.or.kr/service/law/lawFullScreen.do?seq=354&historySeq=1553 — 펀드의 증권대차거래 업무 가이드라인 (verify: 200, len=9909)
- [논문] https://www.kci.go.kr/kciportal/ci/sereArticleSearch/ciSereArtiView.kci?sereArticleSearchBean.artiId=ART001398275 — "증권대차거래에 관한 법적 고찰" 논문(KCI) (verify: 200, len=109797)
- [정책] http://www.kif.re.kr/KMFileDir/129521401216983764_FVIP2011-07.pdf — 한국금융연구원 "증권대차시장의 발전방안" 보고서 PDF (verify: 200, len=8108470)
- [직무] http://www.ksfc.co.kr/services/loan/avg/types.do — 한국증권금융 대차거래 서비스 유형 소개 (verify: 200, len=67319)

---

## B2

### 위변조방지기술개발원 (id=176528382473568, heroCategory: 인쇄 및 인쇄관련 산업, class=major, 파리티기준=18)
- [공정] https://www.bok.or.kr/portal/main/contents.do?menuNo=200372 — 한국은행 만원권 위조방지장치 상세 (verify: 200, len=406575)
- [공정] https://www.bok.or.kr/portal/main/contents.do?menuNo=200371 — 한국은행 오만원권 위조방지장치 상세 (verify: 200, len=411820)
- [산업동향] https://kidd.co.kr/news/236366 — 조광페인트-한국조폐공사 보안 인쇄제품용 특수잉크 고도화 공동R&D (verify: 200, len=204262)
- [직무] https://www.komsco.com/kor/contents/71 — 한국조폐공사 e-ID 제조 및 보안기술 R&D 분야 (verify: 200, len=128782)
- [직무] https://museum.komsco.com/museum/contents/8 — 한국조폐공사 화폐박물관 상설전시(주화·은행권 제조공정·위조방지기술) (verify: 200, len=40326) *(교체: komsco.com/kor/contents/65 중복 해소 — 유가증권-디자이너/위조주화감정연구원과 겹침)*
- [정책] https://www.mcst.go.kr/kor/s_policy/dept/deptView.jsp?pSeq=1729&pDataCD=0417000000&pType=04 — 문체부 인쇄문화산업 진흥계획(2022~2026) (verify: 200, len=146770)

### 위생도기조립원 (id=1765285227854793, heroCategory: 내화,비내화 요업제품 제조업, class=major, 파리티기준=18)
- [공정] https://scienceon.kisti.re.kr/srch/selectPORSrchArticle.do?cn=JAKO201111436237483 — "전통 생활도자기 경량화 기술개발" 논문(KISTI ScienceON) (verify: 200, len=466246) *(교체: JAKO200211921036626 중복 해소 — 위생도기이형제처리원과 겹침)*
- [기관] https://www.kicet.re.kr/00015/00033/00037.web — 한국세라믹기술원 이천분원 소개(전통세라믹 전문연구) (verify: 200, len=43306) *(교체: KS L 1551 중복 해소)*
- [공정] https://www.daelimbath.com/product/product_technology01 — 대림바스 위생도기 기술력(성형·소성) (verify: 200, len=53717)
- [검사] https://www.daelimbath.com/product/product_technology05 — 대림바스 위생도기 기술력(품질/절수등급) (verify: 200, len=51585)
- [공정] https://www.sedaily.com/article/20058880 — 서울경제, 대림바스 방오기술 '세라코팅' 특허출원 이중 도포·소성 공정 (verify: 200, len=134173)
- [정책] https://www.kgnews.co.kr/news/article.html?no=890316 — 경기신문, 한국도자재단 "2026년 도자시험분석 지원사업" 추진 (verify: 200, len=114846) *(교체: koreascience.kr JAKO201624558247444.pdf 중복 해소)*

### 위생청소원 (id=1765284816277853, heroCategory: 하수, 폐수 및 분뇨 처리업, class=major, 파리티기준=18)
- [법령] https://www.law.go.kr/LSW/lsInfoP.do?lsiSeq=89691 — 하수도법 시행규칙 (verify: 200, len=145631)
- [법령] https://www.law.go.kr/LSW/lsInfoP.do?lsiSeq=96910 — 수도시설의 청소 및 위생관리 등에 관한 규칙 (verify: 200, len=145831)
- [통계] https://www.data.go.kr/data/3073222/fileData.do — 한국환경공단 공공하수처리시설 현황 (공공데이터포털) (verify: 200, len=248067)
- [자격] https://ehrd.me.go.kr/kor/edusch/eduschDetail.do?menuNo=110001&courseseqno=18264 — 국립환경인재개발원 폐수처리기술요원 교육과정 (verify: 200, len=144731)
- [안전] https://www.data.go.kr/data/15100304/fileData.do — 한국산업안전보건공단 밀폐공간 질식재해예방 안전작업가이드 (verify: 200, len=154356)
- [정책] https://www.mcee.go.kr/home/web/policy_data/read.do?pagerOffset=20&maxPageItems=10&maxIndexPages=10&searchKey=&searchValue=&menuId=10264&orgCd=&condition.toInpYmd=null&condition.fromInpYmd=null&condition.deleteYn=N&condition.deptNm=null&seq=8492 — 공공폐수처리시설 설치 및 운영관리지침(11차 개정) (verify: 200, len=288168)

### 위성통신망운용원 (id=176528368106587, heroCategory: 전기 통신업, class=major, 파리티기준=18)
- [정책] https://www.korea.kr/news/policyNewsView.do?newsId=148929490 — 2030년까지 저궤도 통신위성 2기 발사, 6G 인프라 구축 정책브리핑 (verify: 200, len=160636)
- [정책] https://www.korea.kr/news/policyNewsView.do?newsId=148935149 — 6G 주파수·위성망 100개 확보 정책브리핑 (verify: 200, len=176984)
- [산업동향] https://ksp.etri.re.kr/ksp/plan-report/read?id=904 — ETRI "6G Industrial IoT 및 위성통신 시장전망" (verify: 200, len=23548) *(교체: etnews.com 20260427000293 중복 해소)*
- [직무] https://www.crms.go.kr/lay1/S1T456C462/contents.do — 전파박물관 무선통신서비스 변천사 - 위성통신 (verify: 200, len=110773)
- [표준] https://www.law.go.kr/LSW/admRulLsInfoP.do?admRulSeq=2200000036661 — 국립전파연구원고시, 우주국·지구국 무선설비 기술기준 (verify: 200, len=78449)
- [기술] https://ettrends.etri.re.kr/ettrends/212/0905212004/034-043.%20%EB%B0%95%EB%B4%89%ED%98%81_212%ED%98%B8%20%EC%B5%9C%EC%A2%85.pdf — ETRI Trends "저궤도 위성통신 단말용 위상배열 안테나 시스템 기술동향" (verify: 200, len=1703130) *(교체: ktsat.com cttNo=01 중복 해소)*

### 유가증권매매제도기획원 (id=1765284387631248, heroCategory: 금융 지원 서비스업, class=major, 파리티기준=18)
- [직무] https://www.koscom.co.kr/portal/main/contents.do?menuNo=200295 — 코스콤 시장시스템 개발운용(매매체결·청산결제 전산처리) (verify: 200, len=24096)
- [직무] https://www.koscom.co.kr/portal/main/contents.do?menuNo=200293 — 코스콤 자본시장IT 서비스 개요 (verify: 200, len=23564)
- [법령] https://regulation.krx.co.kr/contents/RGL/03/03010100/RGL03010100.jsp — KRX 유가증권시장 매매거래제도 일반 (verify: 200, len=217855)
- [법령] https://regulation.krx.co.kr/contents/RGL/03/03010404/RGL03010404.jsp — KRX 유가증권시장 프로그램매매 매매거래제도 (verify: 200, len=221656)
- [정책] https://www.bok.or.kr/portal/main/contents.do?menuNo=200345 — 한국은행 지급결제제도 개요 (verify: 200, len=404749)
- [정책] https://www.bok.or.kr/portal/bbs/P0001717/view.do?menuNo=200614&nttId=10070866 — 한국은행 발간물 「한국은행의 발권업무」(2022) 안내 (verify: 200, len=409039) *(교체: bok.or.kr menuNo=200362 중복 해소 — 유가증권발행/보관사무원과 겹침)*

---

## B3

### 위생용품가공설비조작원 (id=1765285523349448, heroCategory: 기타 종이 및 판지 제품 제조업, class=niche, 파리티기준=10+)
- [법령] https://www.law.go.kr/lsInfoP.do?lsiSeq=272467&viewCls=lsRvsDocInfoR — 위생용품 관리법 시행규칙 제정·개정문 (verify: 200, len=145566) *(교체: lsiSeq=264881 중복 해소 — 위생용품제조반장과 겹침)*
- [정책] https://www.gov.kr/mw/AA020InfoCappView.do?HighCtgCD=A09006&CappBizCD=14600000031&tp_seq=01 — 위생용품 제조업 등 영업의 폐업·휴업 신고 민원안내(정부24) (verify: 200, len=222010)
- [검사] https://fiti.re.kr/web/contents/FT0201040400.do — 위생용품 자가품질검사(FITI시험연구원) (verify: 200, len=89617)
- [정책] https://www.mfds.go.kr/brd/m_1104/view.do?seq=3 — 위생용품 영업 및 수입신고 관련 민원인 안내서(서울지방식약청) (verify: 200, len=45116) *(교체: m.ktr.or.kr 1790 중복 해소 — 위생용품제조반장과 겹침)*
- [공정] https://www.kopack.re.kr/contents.asp?page=520 — 전처리 장비(한국생산기술연구원 패키징기술센터, kitech.re.kr 산하) (verify: 200, len=32399)
- [안전] http://www.firstsafe.co.kr/sub03/sub03_01.html?ptype=view&idx=5288&page=3&code=tdata — 위험성평가 업종별모델(위생용 종이제품 제조업) [20506] (verify: 200, len=13936) *(교체: kcl.re.kr 001012009002 중복 해소 — 위생용품검사원/성형설비조작원과 겹침)*

### 위성방송상품개발원 (id=1765284097956570, heroCategory: 전기 통신업 — 🔴명칭중의성, class=major, 파리티기준=18 — 산업통계 인용 대표)
- [산업동향] https://www.kisdi.re.kr/report/view.do?key=m2101113024973&masterId=3934581&arrMasterId=3934581&artId=1777676 — 저궤도 위성통신 현황·전망·정책이슈(정보통신정책연구원) (verify: 200, len=78725)
- [산업동향] https://www.kistep.re.kr/gpsBoardDownload.es?board_se=issue&list_no=49121&seq=1 — 저궤도 위성통신 산업동향과 경쟁우위 확보전략(KISTEP) (verify: 200, len=1248718)
- [정책] https://eiec.kdi.re.kr/policy/materialView.do?num=251779 — 대한민국 저궤도 위성통신 시대 첫걸음(KDI 경제정보센터) (verify: 200, len=179447)
- [산업동향] https://www.etnews.com/20260427000293 — 전자신문 "한국형 위성통신 전방위 육성" 정책 기사 (verify: 200, len=58672)
- [직무] https://www.ktsat.com/kr/content/view.do?cttNm=about&cttNo=01 — KT SAT 소개(국내 유일 상업위성통신사업자) (verify: 200, len=128424)
- [정책] https://www.msit.go.kr/bbs/view.do?sCode=user&mPid=112&mId=113&bbsSeqNo=94&nttSeqNo=3181680 — 과학기술정보통신부 위성산업 관련 보도자료 (verify: 200, len=122461)

### 위성통신설비관리원 (id=1765283743111170, heroCategory: 전기 통신업, class=major, 파리티기준=18)
- [직무] https://www.ktsat.com/kr/content/view.do?cttNm=facilities&cttNo=011 — KT SAT 시설(금산위성센터) 소개 (verify: 200, len=126244)
- [직무] https://biz.newdaily.co.kr/site/data/html/2022/05/18/2022051800094.html — 금산위성센터 르포(아시아 최대 위성 텔레포트) (verify: 200, len=86165)
- [직무] https://www.bloter.net/newsView/blt202205190067 — 금산위성센터 뉴스페이스 허브 전환 기사 (verify: 200, len=166622)
- [안전] https://www.law.go.kr/LSW/lsInfoP.do?lsiSeq=19847 — 산업안전보건법 시행령(관리감독자 설비 점검 업무) (verify: 200, len=145361)
- [직무] https://www.kca.kr/contentsView.do?pageId=www154 — 한국방송통신전파진흥원(KCA) 업무안내(무선국 검사) (verify: 200, len=25435)
- [검사] https://plus.hankyung.com/apps/newsinside.view?aid=2024062592871&category=&sns=y — KCA 무선국 검사·전자파 측정 기사(한국경제) (verify: 200, len=29134)

### 위조주화감정연구원 (id=1765284115661488, heroCategory: 그 외 기타 전문, 과학 및 기술 서비스업, class=major, 파리티기준=18)
- [정책] https://encykorea.aks.ac.kr/Article/E0061410 — 한국조폐공사 개관(한국민족문화대백과사전) (verify: 200, len=97195) *(교체: komsco.com/kor/contents/65 중복 해소 — 위변조방지기술개발원/유가증권-디자이너와 겹침)*
- [직무] https://www.bok.or.kr/portal/bbs/P0000547/view.do?nttId=10085714&oldMenuNo=201150&menuNo=200387&programType=newsData&depth=200387&relate=Y — 한국은행 "화폐는 어떻게 사람들 손에 들어올까"(발행·환수 흐름) (verify: 200, len=424993) *(교체: komsco.com/kor/contents/66 중복 해소 — 위폐감정사와 겹침)*
- [법령] https://www.law.go.kr/LSW/lsLinkProc.do?lsNm=%ED%98%95%EB%B2%95&efYd=19930309&lsId=prec19930309&lsClsCd=L&joNo=023100&mode=11&lnkJoNo=undefined — 형법 제207조 통화의 위조 등 조문 (verify: 200, len=3926)
- [산업동향] https://economist.co.kr/article/view/ecn202402150029 — "위조지폐 늘었는데 위조동전은 왜 없을까" 기사(이코노미스트) (verify: 200, len=141987)
- [정책] https://www.fnnews.com/news/202607230920313661 — 온라인 가짜 돈 주의보, 한은 관리 강화 기사(파이낸셜뉴스) (verify: 200, len=75868)
- [검사] https://www.bok.or.kr/portal/main/contents.do?menuNo=200991 — 한국은행 "주화 훼손 및 훼손 주화 발견시 처리요령"(주화 전용) (verify: 200, len=400525) *(교체: bok.or.kr menuNo=200379 중복 해소 — 위폐감정사와 겹침)*

### 유가증권발행사무원 (id=1765284388107347, heroCategory: 금융 지원 서비스업, class=major, 파리티기준=18)
- [법령] https://law.kofia.or.kr/service/law/lawFullScreenContent.do?seq=247&historySeq=640 — 유가증권인수업무에관한규칙(금융투자협회) (verify: 200, len=89095)
- [정책] https://dart.fss.or.kr/securityInfo.do — 유가증권발행제도(전자공시시스템 DART) (verify: 200, len=46920)
- [정책] https://ktb.moef.go.kr/isuProcss.do — 국채 발행절차(기획재정부 국고채전문딜러 시스템) (verify: 200, len=105659) *(교체: bok.or.kr menuNo=200362 중복 해소 — 유가증권매매제도기획원/보관사무원과 겹침)*
- [검사] https://opendart.fss.or.kr/disclosureinfo/scrits/main.do — 증권신고서 주요정보조회(공시정보활용마당) (verify: 200, len=57333)
- [법령] https://www.law.go.kr/LSW/admRulLsInfoP.do?admRulSeq=2100000038100 — 국고채권의 발행 및 국고채전문딜러 운영에 관한 규정 (verify: 200, len=78097)
- [법령] https://law.kofia.or.kr/service/law/lawFullScreenContent.do?seq=136&historySeq=296 — 금융투자회사의 영업 및 업무에 관한 규정(금융투자협회) (verify: 200, len=670115)

---

## B4

### 위생용품검사원 (id=1765285523763464, heroCategory: 기타 종이 및 판지 제품 제조업 — 🔴명칭중의성, class=niche, 파리티기준=10+)
- [기준] https://www.mfds.go.kr/brd/m_211/down.do?brd_id=data0005&seq=14796&data_tp=A&file_seq=2 — 식약처 위생용품의 기준 및 규격 고시 원문 (verify: 200, len=1399169)
- [검사] https://www.mfds.go.kr/brd/m_207/view.do?seq=14538 — 「위생용품의 자가품질검사 항목 및 세부 사항 지정」 제정고시 (verify: 200, len=181735)
- [법령] https://law.go.kr/LSW/lsInfoP.do?lsiSeq=193478 — 위생용품 관리법 (국가법령정보센터) (verify: 200, len=145009)
- [표준] https://www.kcl.re.kr/site/homepage/menu/viewMenu.do?menuid=001012009002 — KCL 위생용품 시험·검사·인증 서비스 페이지 (verify: 200, len=152723)
- [안전] https://scienceon.kisti.re.kr/srch/selectPORSrchReport.do?cn=TRKO201900000680 — 위생용품 안전관리 기반 연구 (보고서, KISTI) (verify: 200, len=489761)
- [정책] https://scienceon.kisti.re.kr/srch/selectPORSrchReport.do?cn=TRKO202300003923 — 위생용품의 기준 및 규격 개선 연구 (보고서) (verify: 200, len=436014)

### 위성통신망감리원 (id=1765283680101889, heroCategory: 전기 통신업, class=major, 파리티기준=18)
- [법령] https://www.law.go.kr/LSW/lsInfoP.do?lsiSeq=265837 — 정보통신공사업법 (verify: 200, len=145030)
- [자격] https://www.law.go.kr/LSW/lsInfoP.do?lsiSeq=83251 — 정보통신공사업법시행령(제8조의3 감리원 배치기준) (verify: 200, len=145385)
- [직무] https://www.koit.co.kr/news/articleView.html?idxno=115883 — 정보통신신문: 감리 대상 공사범위·감리원 배치기준 (verify: 200, len=100737)
- [표준] https://ictis.kica.or.kr/engineer/workInfo/index — 한국정보통신공사협회 기술자·감리원 종합정보시스템 (verify: 200, len=158031)
- [안전] https://www.rra.go.kr/FileDownSvl?file_type=notice&file_parentseq=6357&file_seq=1 — 국립전파연구원 우주국·지구국 무선설비 기술기준(PDF) (verify: 200, len=1942569)
- [정책] https://www.crms.go.kr/download.do?uuid=63d4d37e-59bd-472d-9c6b-bdfc09a97352 — 중앙전파관리소 2024년 2분기 위성 관련 정책·산업동향(PDF) (verify: 200, len=587229)

### 위성통신설비연구원 (id=1765283681349824, heroCategory: 전기 통신업, class=major, 파리티기준=18)
- [직무] https://www.kari.re.kr/kor/contents/62 — 한국항공우주연구원 위성 운영기술 연구 소개 (verify: 200, len=257537)
- [공정] https://www.dbpia.co.kr/journal/articleDetail?nodeId=NODE06596838 — 정지궤도 모바일 위성서비스용 대형 전개형 반사 안테나 개발 현황 (논문, KARI) (verify: 200, len=536917)
- [표준] https://scienceon.kisti.re.kr/srch/selectPORSrchReport.do?cn=TRKO201400022102 — 위성용 안테나 관련 기술 (보고서) (verify: 200, len=426021)
- [정책] https://www.kasa.go.kr/prog/bbsArticle/BBSMSTR_000000000010/view.do?bbsId=BBSMSTR_000000000010&nttId=B000000001196Ev1jU6 — 우주항공청 6G 저궤도 위성통신 핵심기술 확보 추진 보도 (verify: 200, len=889894)
- [산업동향] https://ettrends.etri.re.kr/ettrends/204/0905204011/114-124.%20%EA%B9%80%EB%B3%91%EC%9A%B4_204%ED%98%B8.pdf — ETRI Trends "저궤도 5G-NTN 서비스 동향" (verify: 200, len=1199390) *(교체: etnews.com 20260427000293 중복 해소)*
- [정책] https://eiec.kdi.re.kr/policy/materialView.do?num=231202 — KDI 경제정보센터: 국내 저궤도 위성통신 기술경쟁력 확보 방안 (verify: 200, len=181154)

### 위폐감정사 (id=1765284115914278, heroCategory: 은행 및 저축기관 / 입법 및 일반 정부 행정, class=major, 파리티기준=18)
- [검사] https://www.bok.or.kr/portal/main/contents.do?menuNo=200379 — 한국은행 위조지폐 확인법 앱·위조방지장치 안내 (verify: 200, len=404532)
- [직무] https://www.bok.or.kr/portal/main/contents.do?menuNo=200396 — 한국은행 위조지폐 식별요령(비·기·만) (verify: 200, len=401245)
- [정책] https://www.bok.or.kr/portal/main/contents.do?menuNo=200745 — 한국은행 위조지폐 발견시 처리요령(1차감정→정밀감정 절차) (verify: 200, len=400431)
- [법령] https://www.bok.or.kr/portal/main/contents.do?menuNo=200391 — 한국은행 화폐 관련 법규 (verify: 200, len=397047)
- [안전] https://www.komsco.com/kor/contents/66 — 한국조폐공사 위조방지센터 연구개발 소개 (verify: 200, len=123301)
- [표준] https://www.nfs.go.kr/site/nfs/05/10501020000002017091511.jsp — 국립과학수사연구원 감정의뢰방법 안내 (verify: 200, len=42661)

### 유가증권보관사무원 (id=1765284388531751, heroCategory: 금융 지원 서비스업, class=major, 파리티기준=18)
- [자격] https://law.kofia.or.kr/service/law/lawFullScreenContent.do?seq=318&historySeq=1452 — 금융투자협회 증권형 크라우드펀딩 표준업무방법서(예탁·보호예수 절차) (verify: 200, len=536660)
- [법령] https://www.fsc.go.kr/comm/getFile?srvcId=BBSTY1&upperNo=73740&fileTy=ATTACH&fileNo=4 — 금융위원회 전자증권제도 및 법령 주요내용(PDF) (verify: 200, len=751599)
- [통계] https://www.data.go.kr/data/3034081/fileData.do — 한국예탁결제원 증권예탁결제통계(분기) 공공데이터 (verify: 200, len=148742)
- [산업동향] https://www.sedaily.com/article/20063540 — 서울경제: 예탁원 디지털혁신 대비 토큰증권·IT구축 조직 상설화 (verify: 200, len=134697)
- [정책] https://www.fsc.go.kr/comm/getFile?srvcId=BBSTY1&upperNo=25746&fileTy=ATTACH&fileNo=1 — 금융위원회 금융기관 검사 및 제재에 관한 규정(PDF) (verify: 200, len=224768)
- [직무] https://www.bok.or.kr/portal/main/contents.do?menuNo=200362 — 한국은행의 증권업무(국고증권) 안내 (verify: 200, len=405215)

---

## B5

### 위생용품성형설비조작원 (id=1765285524244163, heroCategory: 기타 종이 및 판지 제품 제조업, class=niche, 파리티기준=10+)
- [공정] https://oshri.kosha.or.kr/extappKosha/kosha/guidance/fileDownload.do?sfhlhTchnlgyManualNo=M-56-2020&fileOrdrNo=3 — KOSHA 사출성형기의 안전작업에 관한 기술지침 (verify: 200, len=118129)
- [법령] https://www.moleg.go.kr/lawinfo/makingInfo.mo?lawSeq=81240&lawCd=0&lawType=TYPE5&mid=a10104010000 — 위생용품 관리법 시행규칙 일부개정령안 입법예고(법제처) (verify: 200, len=79954) *(교체: law.go.kr lsiSeq=264881 중복 해소 — 위생용품제조반장과 겹침)*
- [정책] https://health.gangnam.go.kr/web/hygiene/report/product/sub01.do — 위생용품 제조업 신고 절차(강남구보건소) (verify: 200, len=96031)
- [자격] https://kcia.or.kr/inc/down.php?dir=BOARD&file_name=202311_170124840230348_2.pdf — 의약외품 제조 및 품질관리기준(GMP) 가이던스 (verify: 200, len=1108182)
- [안전] https://www.law.go.kr/admRulLsInfoP.do?admRulSeq=2100000113754 — 근골격계부담작업의 범위 및 유해요인조사 방법에 관한 고시 (verify: 200, len=78140)
- [정책] https://www.mfds.go.kr/brd/m_99/view.do?seq=41518 — 「위생용품 관리법」 4월 19일 본격 시행 보도자료(식약처) (verify: 200, len=166813) *(교체: kcl.re.kr 001012009002 중복 해소 — 위생용품가공설비조작원/검사원과 겹침)*

### 위성통신망설계기술자 (id=1765283680417434, heroCategory: 전기 통신업 — 🔴명칭중의성, class=major, 파리티기준=18)
- [법령] https://www.law.go.kr/LSW/admRulLsInfoP.do?admRulSeq=2200000022967 — 전기통신사업용 무선설비의 기술기준 (verify: 200, len=78005)
- [정책] https://www.sisajournal-e.com/news/articleView.html?idxno=417964 — 과기부 위성망 이용 지원 시스템 구축(위성통신 경쟁력 강화) (verify: 200, len=196273)
- [자격] https://www.cq.or.kr/qh_quagm01_005.do — 무선설비기사 자격 안내(Q-net) (verify: 200, len=355404)
- [자격] https://www.cq.or.kr/qh_quagm01_002.do — 정보통신기술사 자격 안내(Q-net) (verify: 200, len=351838)
- [산업동향] https://www.kukinews.com/article/view/kuk202505120136 — ETRI 6G 저궤도위성통신 개발 총괄 기사 (verify: 200, len=129437)
- [기술] https://ettrends.etri.re.kr/ettrends/196/0905196005/041-051_%EC%97%84%EB%A7%8C%EC%84%9D_196%ED%98%B8.pdf — ETRI Trends "저궤도 군집 통신위성 탑재체 기술동향" (verify: 200, len=1736097) *(교체: ktsat.com cttNo=01 중복 해소)*

### 위험물취급원 (id=1765283947997579, heroCategory: 기타 운송관련 서비스업 — 🔴명칭중의성, class=major, 파리티기준=18 — 산업통계 인용 대표)
- [검사] https://oshri.kosha.or.kr/extappKosha/kosha/guidance/fileDownload.do?sfhlhTchnlgyManualNo=G-78-2021&fileOrdrNo=7 — 유해·위험물 탱크로리의 검사 및 입·출하 등에 관한 기술지침 (verify: 200, len=603259)
- [검사] https://hazmat.nfa.go.kr/contents.do?contentsNo=65 — 탱크안전성능검사(국가위험물정보시스템) (verify: 200, len=12981)
- [자격] https://hazmat.nfa.go.kr/contents.do?contentsNo=56 — 위험물안전교육 안내 (verify: 200, len=15401)
- [검사] https://www.komdi.or.kr/ukiwi/biz/dngr/guide/ukiwiBizDngrGuide.do — 한국해사위험물검사원 위험물 검사 안내 (verify: 200, len=64303)
- [법령] https://law.go.kr/LSW/lsInfoP.do?lsiSeq=166247 — 위험물안전관리법 본문 (verify: 200, len=145031)
- [자격] https://www.komdi.or.kr/ukiwi/biz/edu/guide/ukiwiBizEduGuideProfessional.do — 위험물 안전운송 전문교육 안내 (verify: 200, len=52000)

### 윈치염색원 (id=1765284938594256, heroCategory: 섬유제품 염색, 정리 및 마무리 가공업, class=major, 파리티기준=18)
- [공정] http://contents.kocw.net/KOCW/document/2015/hanyang/parkmyengja/12.pdf — 한양대 의류학과 「염색과 가공」 강의자료(제19장) (verify: 200, len=1051759)
- [자격] http://www.q-net.or.kr/crf005.do?id=crf00503&gSite=Q&gId=&jmCd=1292 — 염색가공기사 자격 상세정보(Q-net) (verify: 200, len=227065)
- [법령] https://www.law.go.kr/LSW/flDownload.do?gubun=&flSeq=83926613&bylClsCd=110201 — 물환경보전법 시행규칙 [별표13] 수질오염물질 배출허용기준(섬유염색가공시설 포함) (verify: 200, len=287259)
- [안전] https://oshri.kosha.or.kr/extappKosha/kosha/guidance/fileDownload.do?sfhlhTchnlgyManualNo=W-12-2017&fileOrdrNo=3 — KOSHA 고열작업환경관리지침 (verify: 200, len=173724)
- [산업동향] https://www.imaeil.com/page/view/2026070914061547052 — 대구 섬유·염색업 고용안정에 국비 20억 투입 기사 (verify: 200, len=106458)
- [자격] https://hrd.dyetec.or.kr/edu_process_all.php — 다이텍연구원 컨소시엄(염색가공) 교육과정 (verify: 200, len=46984)

### 유가증권-디자이너 (id=1765284205345466, heroCategory: 인쇄 및 인쇄관련 산업 — 🔴명칭중의성, class=major, 파리티기준=18 — 산업통계 인용 대표)
- [공정] https://www.komsco.com/kor/contents/65 — 한국조폐공사 기술연구원 소개(위변조방지·인쇄 R&D) (verify: 200, len=126919)
- [산업동향] https://www.komsco.com/kor/article/bodo/16139 — 조폐공사·조광페인트 보안인쇄용 특수잉크 공동개발 보도자료 (verify: 200, len=172275)
- [정책] https://www.mcst.go.kr/servlets/eduport/front/upload/UplDownloadFile?pFileName=제5차_인쇄문화산업_진흥_계획(2022-2026).pdf — 제5차 인쇄문화산업 진흥계획(문체부) (verify: 200, len=1326611)
- [산업동향] http://www.printingkorea.or.kr/bbs/board.php?bo_table=B12&wr_id=118 — 「위협 받는 오프셋 인쇄의 미래는?」(한국인쇄산업협회) (verify: 200, len=68910)
- [기술] https://www.hankooki.com/news/articleView.html?idxno=123395 — 조폐공사 보안인쇄용 특수잉크 국산화 기사 (verify: 200, len=181906)
- [자격] http://www.q-net.or.kr/crf005.do?id=crf00503&jmCd=7524 — 인쇄기능사 자격 상세정보(Q-net) (verify: 200, len=226913)

---

## 형제 분할 선언 (URL 배타 분할 검증 — 초안 중복 19건 전건 교체 완료)

1차 조립 시 5개 배치가 병렬로 독립 리서치한 결과, 동일 heroCategory 형제 직업 간 URL 중복 12개 그룹(위생도기 3, 위생용품(law/kcl/ktr) 3, 위성(etnews/ktsat) 2그룹×다중, 유가·조폐(bok/komsco) 4그룹)이 발견되어 **전건 대체 URL 재발굴 + 재검증(200+3KB) 후 해소**했다.

- **위생도기(2직: 위생도기이형제처리원·위생도기조립원)**: 대표=위생도기이형제처리원(KS L 1551·scienceon 논문·koreascience 논문 3건 산업통계 단독 배정). 최초 위생도기조립원 초안이 이 3건을 그대로 재사용 → scienceon(경량화 기술개발 논문)·kicet.re.kr(이천분원)·kgnews.co.kr(도자재단 지원사업)로 전량 교체. URL 교집합 0.
- **위생용품(4직: 위생용품제조반장·가공설비조작원·검사원·성형설비조작원, 전원 niche 후보)**: 대표 없음(산업통계 대표는 다른 클러스터인 위생도기이형제처리원 — 실제 제품군이 달라 통계 자체가 겹치지 않으나, law.go.kr 위생용품 관리법·kcl.re.kr 시험인증·m.ktr.or.kr 자가품질검사 등 **범용 근거 URL이 4직에 걸쳐 중복 재사용**됐던 것을 확인. 위생용품제조반장(lsiSeq=264881, m.ktr.or.kr)·위생용품검사원(kcl.re.kr)만 유지하고 가공설비조작원·성형설비조작원의 겹친 3+2건을 mfds.go.kr 안내서·firstsafe.co.kr 위험성평가·moleg.go.kr 입법예고 등으로 교체. URL 교집합 0.
- **위성(7직: 위성방송상품개발원·위성통신망감리원·설계기술자·시공기술자·운용원·설비관리원·설비연구원)**: 대표=위성방송상품개발원(전자신문 산업육성 기사·KT SAT 소개 2건 산업통계/개관 단독 배정). 시공기술자·운용원·설비연구원 3직이 동일 전자신문 기사를, 운용원·설계기술자 2직이 동일 KT SAT 소개 페이지를 중복 인용했던 것을 ETRI Trends 논문 5건(185/904/212/204/196호)으로 교체. URL 교집합 0.
- **위험(2직: 위험평가사정원·위험물취급원)**: 대표=위험물취급원(관세사 파리티 근거 계열, 산업통계 단독 배정). 최초 리서치부터 두 직업 완전 독립 도메인(보험업 vs 운송업) 사용 — URL 교집합 0 (교체 불필요).
- **유가(5직: 유가증권대차거래중개인·매매제도기획원·발행사무원·보관사무원·유가증권-디자이너)**: 대표=유가증권-디자이너(komsco.com 조폐 인쇄기술·문체부 인쇄산업 진흥계획 산업통계 단독 배정). 매매제도기획원·발행사무원·보관사무원 3직이 동일 bok.or.kr 국고증권 안내(menuNo=200362)를 중복 인용 → 매매제도기획원은 bok.or.kr 발권업무 단행본, 발행사무원은 기획재정부 국채발행절차로 교체(보관사무원만 원본 유지). URL 교집합 0.
- **위조/위폐 (명칭cluster 아님, 근접주제 2직: 위조주화감정연구원·위폐감정사)**: 형식상 형제 클러스터는 아니나 "화폐 위조·감정" 주제가 근접해 komsco.com/kor/contents/65,66·bok.or.kr menuNo=200379가 위변조방지기술개발원·유가증권-디자이너까지 포함해 최대 3중 중복됐던 것을 확인 — 위조주화감정연구원 3건을 encykorea.aks.ac.kr(백과사전)·bok.or.kr(화폐이야기)·bok.or.kr(주화훼손 처리요령, menuNo=200991 — 주화 전용으로 위폐감정사의 지폐 전용(menuNo=200379)과 축 분리)로 교체. URL 교집합 0.

**patents.google.com 사용 0건** (R132까지 상용했던 관행 폐기 — 이번 25직 150건 전량 KIPRIS/논문/특허청 대신 정부·협회·연구원·언론 심층출처로만 구성. KIPRIS 직접 페이지는 세션 만료형 reg_key 구조상 재검증 불가능해 대신 산업 실측 출처로 대체했다).

---

## 요약 통계

- 전체 25직업 seed 총 **150건** (직업당 정확히 6건), fetch 200+3KB 검증 통과율 **100%**(초안 발굴 단계 실패분 — 403 안티봇 2건, 404/DNS 1건, JS-shell 저용량 2건, TIMEOUT 1건 등 총 6건은 등록 전 즉시 대체 발굴하여 최종본에는 미포함).
- 형제 클러스터 중복 해소를 위한 2차 교체: **19건** 재발굴+재검증(전건 200+3KB PASS).
- niche 후보(파리티기준 10+) 4직 = 위생용품 계열(제조반장/가공설비조작원/검사원/성형설비조작원), 나머지 21직은 파리티 기준 18 확정(형제/동일 heroCategory 18+ 실적 근거 보유 — enhance 세션에서 niche 자가 하향 시 즉시 이의제기 대상).

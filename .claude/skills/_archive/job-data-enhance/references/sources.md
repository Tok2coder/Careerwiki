# 출처 품질 기준 및 포맷 규칙

> ⚠️ **2026-04-29 정책 강화**: deep audit에서 마커 보유 직업 325개 중 196개(60%) 가
> career.go.kr / work.go.kr 등 우리 데이터 origin 도메인만 단독 사용 — selfCite 사고 발견.
> 아래 정책은 그 후 강화된 것. **origin 단독 인용 금지 + 외부 보충 강제**.

## 출처 등급 분류

### 🚨 origin 도메인 (CareerWiki 데이터 원본 — 절대 사용 금지)

> 🚨 **2026-04-29 정책 격상 (사용자 의도 반영)**:
> 기존 "외부 보충 1+ 있으면 통과" 정책 폐기. **_sources에 1건이라도 있으면 즉시 FAIL** (validate `[originDomain]`).
> 결정적 계기: 의료코디네이터 `wagework.go.kr` (2026-04-29 사용자 발견)

다음 도메인은 CareerWiki가 API로 직접 가져오는 **원본 데이터(origin)**다.
출처로 쓰면 자기 데이터를 인용하는 것 → 정보 가치 0. **외부 보충 충분해도 1건이라도 섞이면 FAIL.**

| 기관명 | 도메인 | 비고 |
|--------|--------|------|
| 커리어넷 직업백과 | career.go.kr | API로 자동 수집됨 (커리어넷 신·구버전) |
| 워크넷 직업정보 | work.go.kr | API로 자동 수집됨 (구버전) |
| 고용24 | work24.go.kr | 워크넷 후속 |
| 한국노동연구원 임금직업정보 (워크피디아) | wagework.go.kr | 의료코디네이터 사고 사례 |
| 직업포털 | job.go.kr | 정부 직업포털 |
| **(heuristic)** | `*.go.kr` + path keyword (job/career/work/wage/employ) | 자동 검출 — `moel.go.kr/policy/labor/employment.do` 등도 origin 후보 |

**위 도메인 대신 사용해야 할 외부 1차 출처**:
- 한국고용정보원 `keis.or.kr` (직업전망보고서)
- 한국직업능력연구원 `krivet.re.kr` (훈련·자격)
- KOSIS `kosis.kr` (통계청 통계)
- Q-Net `q-net.or.kr` (자격증)
- 한국산업인력공단 `hrdkorea.or.kr`
- 정부 부처 정책 페이지 (`moel.go.kr/policy/...` 처럼 직업정보 path 아닌 경우)
- 협회·학회 공식 사이트 (`kna.or.kr`, `koreanbar.or.kr` 등)
- 전문 미디어 (한경, 매경, IT조선 등)
- 학술논문 (RISS, KISS, DBpia)

### 🚫 자기 사이트 (절대 금지)

| 도메인 | 비고 |
|--------|------|
| careerwiki.org / .kr | 자기 자신 인용 — validate `[selfDomain]` FAIL |

### 1등급 — 외부 공공·전문 기관 (적극 활용)

신뢰도 최고. 가능하면 외부 1등급 출처 2개 이상 확보.

| 기관명 | 도메인 | 주요 정보 |
|--------|--------|-----------|
| 한국고용정보원 | keis.or.kr | 고용 통계, 직업 전망 보고서 |
| 직업능력개발원 | krivet.re.kr | 훈련·자격 정보 |
| 국가통계포털 | kosis.kr | 종사자 수, 임금 통계 |
| 교육부 | moe.go.kr | 학과 정보, 진로 정책 |
| 보건복지부 | mohw.go.kr | 의료·복지 직종 정보 |
| 고용노동부 | moel.go.kr | 노동 환경, 임금 규정 |
| 한국산업인력공단 | hrdkorea.or.kr | 자격증 정보 |
| Q-net (자격증 포털) | q-net.or.kr | 국가기술자격 상세 |

### 2등급 — 민간 전문 사이트
신뢰도 보통~높음. 1등급으로 보완 불가한 경우 활용.

| 기관명 | 도메인 | 주요 정보 |
|--------|--------|-----------|
| 직업백과(아사마루) | job.asamaru.net | 직업 상세 설명 |
| 자격증넷 | janet.co.kr | 자격증·연봉 정보 |
| 사람인 연봉 정보 | saramin.co.kr | 실제 채용 연봉 |
| 잡코리아 직업백과 | jobkorea.co.kr | 직업 정보 |
| 주요 협회·학회 사이트 | 각 협회 도메인 | 해당 직종 전문 정보 |
| 대학 학과 소개 | 각 대학 도메인 | 학과 커리큘럼 |

### 3등급 — 블로그·유튜브·커뮤니티
신뢰도 낮음. 보조 자료로만 사용. 단독 출처 금지.

| 유형 | 예시 | 사용 조건 |
|------|------|-----------|
| 네이버 블로그 | blog.naver.com | trivia 보조용, 반드시 1등급과 병용 |
| 티스토리 | tistory.com | trivia 보조용 |
| 유튜브 | youtube.com | youtubeLinks 전용 (본문 출처 불가) |
| 커뮤니티 | dcinside, 블라인드 | 사용 금지 |

---

## A등급 포맷 (필수)

### 완성 예시
```json
{
  "way": [
    {"id": 1, "text": "커리어넷 직업백과", "url": "https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=229"},
    {"id": 2, "text": "워크넷 직업정보", "url": "https://www.work.go.kr/empInfo/jobInfo/jobInfoDetailView.do?jobsCd=1234"}
  ],
  "overviewSalary.sal": [
    {"id": 3, "text": "워크넷 임금직업정보", "url": "https://www.work.go.kr/empInfo/wageJobInfo/wageJobInfoDetailView.do?jobsCd=1234"}
  ],
  "overviewProspect.main": [
    {"id": 4, "text": "한국고용정보원 직업전망", "url": "https://www.keis.or.kr/user/extra/main/1/publication/publicationList/jsp/LayOutPage.do"}
  ],
  "trivia": [
    {"id": 5, "text": "커리어넷 직업백과", "url": "https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=229"}
  ],
  "detailWlb.wlbDetail": [
    {"id": 6, "text": "직업백과(아사마루)", "url": "https://job.asamaru.net/..."}
  ],
  "detailWlb.socialDetail": [
    {"id": 7, "text": "워크넷", "url": "https://www.work.go.kr/..."}
  ]
}
```

### 필드별 id 매핑 원칙

> ⚠️ **2026-04-29 정합성 정정** — 실제 렌더링 코드(`src/templates/detailTemplateUtils.ts:applyInlineFootnotes`)와 일치하도록 명세 갱신.

**핵심 정책**:
- 본문 `[N]`은 **field-local 번호** — 각 필드마다 1부터 시작
- 본문 `[N]` ↔ `_sources[fieldKey][N-1]` (배열 내 0-based index 매핑)
- `_sources[fieldKey][i].id`는 **페이지 통합 출처 카운트용 글로벌 번호** — 1부터 연속 권장하지만 본문 매핑과 무관
- 렌더러가 footnoteMap을 통해 본문 [N] (local) → 글로벌 [M] 으로 변환

**올바른 예** (글로벌 id 1-4 분산):
```
way 본문: "간호학과 졸업.[1] 국가시험 합격.[2]"
trivia 본문: "급여는 평균 4,200만 원.[1]"
_sources.way: [
  {"id":1, "text":"커리어넷", "url":"https://www.career.go.kr/cloud/w/job/view?seq=1"},
  {"id":2, "text":"한국간호협회", "url":"https://kna.or.kr/..."}
]
_sources.trivia: [
  {"id":3, "text":"KOSIS 임금 통계", "url":"https://kosis.kr/..."}
]
```

본문 way [1] ↔ _sources.way[0] (글로벌 [1]), way [2] ↔ _sources.way[1] (글로벌 [2]),
trivia [1] ↔ _sources.trivia[0] (글로벌 [3]).

**잘못된 예 1** (brokenRef — _sources 길이 < 본문 max [N]):
```
way 본문: "...졸업.[1] 시험.[2] 취업.[3]"  ← 본문 max=[3]
_sources.way: [{"id":1, ...}]  ← 길이 1, [2]·[3] 매핑 없음 → validate FAIL
```

**잘못된 예 2** (orphanSrc — 등록만, 본문 미인용):
```
way 본문: "...졸업.[1]"  ← 본문 max=[1]
_sources.way: [
  {"id":1, ...}, {"id":2, ...}, {"id":3, ...}, {"id":4, ...}
]  ← 4개 등록됐지만 [2]·[3]·[4]는 본문 미사용 → validate WARN
```

**잘못된 예 3** (글로벌 id 불연속 — gap):
```
_sources.way: [{"id":1, ...}, {"id":3, ...}]  ← id 2 누락. 글로벌 카운트 깨짐
```

---

## 금지 포맷 (절대 사용 금지)

### 구형 문자열 포맷
```json
"_sources": "URL=https://career.go.kr|텍스트=커리어넷"
"_sources": {"way": "https://career.go.kr=커리어넷"}
```

### 문자열 배열 포맷
```json
"_sources": ["커리어넷", "워크넷"]
"_sources": {"way": ["커리어넷", "워크넷"]}
```

### 도메인만 있는 URL
```json
// 금지! (실제 페이지 아님)
{"id": 1, "text": "커리어넷", "url": "https://www.career.go.kr"}

// 올바름
{"id": 1, "text": "커리어넷 직업백과 간호사", "url": "https://www.career.go.kr/cloud/w/job/view?seq=229"}
```

### 🚫 list-page / 인덱스 URL (validate `[listPageURL]` FAIL)

직업 specific 식별자(seq/SEQ/jobsCd/jmCd/code 등)가 없는 인덱스/카테고리/리스트 페이지는 출처로 부적합.

```json
// ❌ 금지 — career.go.kr 신형 인덱스 (seq 누락)
{"id": 1, "url": "https://www.career.go.kr/cloud/w/job"}
{"id": 2, "url": "https://www.career.go.kr/cloud/w/major"}

// ❌ 금지 — career.go.kr 구형 인덱스 (SEQ 누락)
{"id": 3, "url": "https://www.career.go.kr/cnet/front/base/job/jobView.do"}
{"id": 4, "url": "https://www.career.go.kr/cnet/front/base/job/jobList.do"}

// ❌ 금지 — work.go.kr 인덱스 (jobsCd 누락)
{"id": 5, "url": "https://www.work.go.kr/empInfo/jobInfo/jobInfoDetailView.do"}

// ❌ 금지 — Q-Net 인덱스 (jmCd 또는 id 누락)
{"id": 6, "url": "https://www.q-net.or.kr/crf005.do"}

// ❌ 금지 — path가 /list, /listView, /category, /index, /main으로 끝남
{"id": 7, "url": "https://example.go.kr/board/list"}
{"id": 8, "url": "https://example.or.kr/info/category"}

// ✅ 올바름 — 직업 specific 식별자 포함
{"id": 1, "url": "https://www.career.go.kr/cloud/w/job/view?seq=229"}
{"id": 2, "url": "https://www.work.go.kr/empInfo/jobInfo/jobInfoDetailView.do?jobsCd=1234"}
{"id": 3, "url": "https://www.q-net.or.kr/crf005.do?id=crf00505&jmCd=1320"}
```

### 🚫 자기 사이트 인용 (validate `[selfDomain]` FAIL)

```json
// ❌ 절대 금지 — careerwiki.org / careerwiki.kr 자기 사이트
{"id": 1, "url": "https://careerwiki.org/job/X"}
{"id": 2, "url": "https://www.careerwiki.kr/major/Y"}
```

### 🚫 origin 단독 인용 (validate `[selfCiteOnly]` FAIL)

career.go.kr / work.go.kr / work24.go.kr / job.go.kr 만으로 _sources를 채우면 FAIL.
반드시 외부 host(keis.or.kr, kosis.kr, krivet.re.kr, 협회·학회·전문 미디어 등) 1개 이상 동반.

```json
// ❌ FAIL — 모든 URL이 origin 도메인
"_sources": {
  "way": [{"id":1, "url":"https://www.career.go.kr/cloud/w/job/view?seq=1"}],
  "trivia": [{"id":2, "url":"https://www.work.go.kr/empInfo/jobInfo/jobInfoDetailView.do?jobsCd=2"}]
}

// ✅ PASS — origin + 외부 보충
"_sources": {
  "way": [
    {"id":1, "url":"https://www.career.go.kr/cloud/w/job/view?seq=1"},
    {"id":2, "url":"https://www.kna.or.kr/discipline/curriculum"}
  ],
  "trivia": [{"id":3, "url":"https://kosis.kr/statHtml/statHtml.do?orgId=124"}]
}
```

---

## 🔴 한 source = 한 기관 = 한 URL 원칙

이 원칙은 두 가지 서로 다른 수준의 위반으로 나뉩니다.

### 위반 유형 1 — text에 복수 URL 인라인 삽입 (절대 금지 / FAIL)

`source.text` 필드 안에 `http://` 또는 `https://` URL을 2개 이상 직접 쓰는 것은
**구조적 위반**입니다. source 항목 자체가 `{text, url}` 구조이며 URL은 `url` 필드에만
1개 존재해야 합니다. text에 URL을 인라인으로 박으면 렌더링·각주 시스템이 의도대로
작동하지 않습니다.

```json
// ❌ 절대 금지 — text에 URL 2개 이상
{"text": "[1] https://www.hrd.go.kr/... 와 https://koreacasino.or.kr/... 참고", "url": "..."}

// ✅ 올바름 — URL은 url 필드에만 1개
{"text": "[1] HRD-Net 직업훈련포털", "url": "https://www.hrd.go.kr/..."}
```

→ `validate` `[출처URL복수]` **FAIL**, `audit` `[Gate5/URL복수]` **FAIL** 으로 차단됨.

### 위반 유형 2 — 라벨에 여러 기관 병합 (확인 필요 / INFO)

`source.text`에 "기관A 및 기관B" 형태로 여러 기관을 병렬 표기하되 URL이 하나인 경우.
URL이 언급된 모든 기관의 내용을 실제로 커버하면 문제없지만,
그렇지 않으면 한 기관의 URL만 연결되고 나머지는 미확인 출처가 됩니다.

**자동 감지는 INFO 수준** — 사람 판단이 필요한 영역이므로 FAIL로 차단하지 않습니다.

```json
// ⚠️ INFO — URL이 두 기관 모두를 커버하면 허용, 그렇지 않으면 분리 필요
{"text": "[1] HRD-Net 직업훈련포털 및 한국카지노업관광협회", "url": "https://www.hrd.go.kr/..."}
```

→ URL(hrd.go.kr)이 한국카지노업관광협회 내용을 커버하지 못하면 → 분리 필요:

```json
// ✅ 기관별로 분리한 올바른 예시
{"text": "[1] HRD-Net 직업훈련포털", "url": "https://www.hrd.go.kr/hrdp/co/pcobo/PCOBO0100P.do?..."},
{"text": "[2] 한국카지노업관광협회 교육기관 안내", "url": "https://koreacasino.or.kr/kcasino/info/infoEduAgency.do"}
```

**"한국건축가협회 및 설계사무소"처럼 단일 URL이 복합 기관명을 실제 커버하는 경우**는
INFO 알림만 뜨고 저장은 허용됩니다. URL을 WebFetch로 확인 후 적절히 판단하세요.

### 자동 감지 요약

| 유형 | 도구 | 타이밍 | 레벨 | 코드 |
|------|------|--------|------|------|
| text 내 복수 URL | `validate-job-edit.cjs` | 저장 **전** | **FAIL** | `[출처URL복수]` |
| text 내 복수 URL | `full-quality-audit.cjs` | 저장 **후** | **FAIL** | `[Gate5/URL복수]` |
| 라벨에 여러 기관 병합 | `validate-job-edit.cjs` | 저장 **전** | WARN | `[출처라벨병합]` |
| 라벨에 여러 기관 병합 | `full-quality-audit.cjs` | 저장 **후** | WARN | `[Gate5/라벨병합]` |

---

## Phase별 출처 요구사항

| Phase | 요구사항 |
|-------|----------|
| Phase 1 | _sources 존재 (포맷 무관) |
| Phase 2 | A등급 포맷, URL 3개 이상 |
| Phase 3 | 1등급 출처 2개 이상, 모든 [N] 참조 일치 |
| Phase 4 | 모든 URL WebFetch 200 확인 |
| Phase 5 | 전 섹션 출처 커버, 최신 자료 (2023년 이후) |

---

## URL 검증 방법

```bash
curl -s -o /dev/null -w "%{http_code}" "https://www.career.go.kr/..."
```

200 = 정상
301/302 = 리다이렉트 (최종 URL 확인 필요)
404 = 페이지 없음 → 다른 URL 찾기
403 = 접근 제한 → 캐시/아카이브 URL 활용

---

## 자주 쓰이는 출처 URL 패턴

### 커리어넷 직업백과
```
https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ={직업SEQ번호}
```
검색: career.go.kr/cnet 에서 직업명 검색 후 SEQ 확인

### 워크넷 직업정보
```
https://www.work.go.kr/empInfo/jobInfo/jobInfoDetailView.do?jobsCd={코드}
```

### 직업백과 (아사마루)
```
https://job.asamaru.net/job/{직업명}/
```

### 한국산업인력공단 자격증
```
https://www.q-net.or.kr/crf005.do?id=crf00505&jmCd={자격코드}
```

# 출처 품질 기준 및 포맷 규칙

## 출처 등급 분류

### 1등급 — 공공기관 (최우선)
신뢰도 최고. 가능하면 1등급 출처 2개 이상 확보할 것.

| 기관명 | 도메인 | 주요 정보 |
|--------|--------|-----------|
| 커리어넷 직업백과 | career.go.kr | 직업 개요, 하는 일, 준비 방법 |
| 워크넷 직업정보 | work.go.kr | 임금·직업 현황, 전망 |
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
- id는 전체 JSON 내 전역 고유 순번 (1부터 연속)
- 같은 출처를 여러 섹션에서 사용해도 섹션마다 별도 id 부여
- 본문 `[N]`은 해당 섹션 _sources 배열에서 `"id": N`인 항목을 참조

**올바른 예**:
```
way 텍스트: "간호사가 되려면 간호학과를 졸업해야 한다.[1] 국가면허시험에 합격해야 한다.[2]"
_sources.way: [{"id":1, ...}, {"id":2, ...}]
```

**잘못된 예** (id 불일치):
```
way 텍스트: "간호사가 되려면 간호학과를 졸업해야 한다.[1] 국가면허시험에 합격해야 한다.[3]"
_sources.way: [{"id":1, ...}, {"id":2, ...}]  // [3]이 없음!
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
{"id": 1, "text": "커리어넷 직업백과 간호사", "url": "https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=229"}
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

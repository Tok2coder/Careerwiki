# Fact Verification — 본문 fact 정확성 검증 (NEW)

> SKILL.md Phase 1-B의 확장본. 본 doc은 reference 전용 — 본문 fact 정확성 검증 절차 + 사고 사례.

---

## 왜 fact verification이 필요한가

기존 audit/validate는 출처 형식 (URL valid / origin 도메인 / sidebar orphan / 마커 정합성) 중심. 본문에 박힌 **구체 fact 자체의 정확성**은 검증 안 됨.

**사고 사례**:
- **방사선사 trivia 0.6 mSv** (사용자 발견): 본문에 "연간 방사선 노출 0.6 mSv" 인용 → 실제 ICRP/KMA 자료는 **0.82 mSv** (mismatch). 출처 URL 자체는 valid이지만 본문 숫자가 부정확.
- **게임-프로그래머 detailReady 9.9조** (사용자 발견): "한국 게임 산업 시장 9.9조" → 실제 KOCCA 보고서 **11.6조** (2024 기준). 본문 outdated 또는 작성자 추정.

이런 사고는 출처 형식 audit으로는 차단 안 됨. 별도 fact verification 단계 필요.

---

## Phase 1-B에서 fact verification 실행

### 1-B-1. 본문 fact 추출

PROSE_BODY_FIELDS 9 필드 + detailReady array 본문에서 다음 카테고리 fact 추출:

| 카테고리 | 예시 |
|---|---|
| **회사명** | 삼성전자, SK하이닉스, 넥슨, 크래프톤, KBS, MBC |
| **통계 수치** | 평균임금 6,800만원, 종사자 12만명, 시장 19조원 |
| **연도** | 2024년 기준, 2023년 발표, 2020년 시작 |
| **순위·점유율** | 세계 1위, 시장 점유율 35%, M&A 5위 |
| **금액·연봉** | 초임 4,500만원, 연 매출 100억원 |
| **자격증·시험** | 정보처리기사 합격률 25%, 임상병리사 국시 |
| **법령·정책** | 의료법 제27조, 노동법 개정 2024 |

regex 패턴 (대략):
```js
const FACT_PATTERNS = {
  numStats: /\d+(?:,\d{3})*\s*(?:만원|원|억|조|천|백)/g,
  percent: /\d+(?:\.\d+)?\s*%/g,
  years: /\b(?:19|20)\d{2}년?/g,
  ranking: /(?:세계|국내|아시아)\s*\d+(?:위|등)/g,
  companies: /(?:삼성전자|SK하이닉스|네이버|카카오|쿠팡|.{2,8}전자|.{2,8}공사)/g,
};
```

### 1-B-2. WebSearch cross-check

각 fact별 cross-check:
```
WebSearch query: "{직업명} {fact 키워드} 통계" 또는 "{회사명} {연도} 매출"
또는 KOSIS / 정부 부처 / 협회 deep page 직접 fetch
```

**판정 기준**:
- WebSearch top 3 결과의 본문 수치/연도/회사명이 본문과 ±10% 이내 → MATCH
- mismatch 검출 시 → 정확한 값 추출 + 출처 등록

### 1-B-3. WebFetch evidence 의무

본문 fact가 출처 페이지에 직접 등장하는지 확인:
```
1. 새 출처 URL을 WebFetch (Jina Reader 우회 가능)
2. 응답 본문에서 fact 고유 식별자 (회사명·정확한 숫자·정확한 연도) 직접 등장 확인
3. cover 안 되면 → 1번 더 fix 시도
4. 2회째도 cover 안 되면 → fact 제거
```

**evidence 명시 의무** (Phase 7 DONE 보고에 포함):
```
verify_result: [
  { fact: "방사선사 연 노출 0.82 mSv", src_url: "https://kdca.go.kr/...",
    covers: true, evidence: "WebFetch 결과 '0.82 mSv (2024)' 직접 등장" }
]
all_covered: true
```

evidence 명시 X = cover=false 간주 → POST 차단.

---

## fact verification 실행 흐름

```
┌─ Phase 1-B-1: 본문 fact 추출 ───────────┐
│ PROSE_BODY_FIELDS 9 + detailReady array │
│ regex로 fact 카테고리별 추출            │
└─────────────┬───────────────────────────┘
              │
              ▼
┌─ Phase 1-B-2: WebSearch cross-check ───┐
│ 각 fact별 1차 출처 검색                 │
│ KOSIS / 정부 부처 / 협회 deep page      │
│ ko.wikipedia.org 우선                  │
└─────────────┬───────────────────────────┘
              │
              ▼
       mismatch 검출? ── No ──► PASS (Phase 2 진입)
              │
              Yes
              ▼
┌─ Phase 1-B-3: WebFetch evidence 검증 ──┐
│ 새 출처 URL fetch                      │
│ fact 직접 등장 확인                    │
│ cover 안 되면 1번 더 fix 시도          │
└─────────────┬───────────────────────────┘
              │
              ▼
       cover OK? ── No ──► fact 제거 또는 일반화
              │
              Yes
              ▼
       Phase 2 (CLEANUP + fact 정정 모드)
```

---

## fact 정정 vs 본문 일반화 vs fact 제거

검증 후 mismatch 발견 시 3 옵션:

### 1. fact 정정 (선호)

```js
// Before: trivia: "방사선사는 연 0.6 mSv 노출[1]..."
// After:  trivia: "방사선사는 연 0.82 mSv 노출[1]..."
// _sources["trivia"]: [{ id: 1, text: "KDCA 의료기관 방사선 노출 통계 (2024)",
//                         url: "https://kdca.go.kr/.../radiation-stats" }]
```

WebFetch evidence 의무 — 새 출처 페이지에 "0.82 mSv" 직접 등장 확인.

### 2. 본문 일반화

```js
// Before: trivia: "한국 게임 시장 9.9조원 (2023)..."
// After:  trivia: "한국 게임 시장은 매년 성장세..."
```

deep page 발굴 실패 + 정확한 값 cross-check 어려움 + fact 자체가 핵심 정보 X일 때.

### 3. fact 제거

```js
// Before: trivia: "삼성전자가 2024 1,200명 채용[1]..."
// After:  trivia: ""    또는 다른 fact로 대체
```

deep page 발굴 실패 + 일반화도 어색 + fact가 본문 정체성에 핵심 X일 때.

---

## 한국 출처 우선 (룰 5, 2026-05-04)

CareerWiki는 한국어 직업 정보 위키. 한국 직업·산업 fact는 **한국 1차 출처가 우선**. 외국 사이트는 fallback only.

**우선순위 (high → low)**:
1. 🇰🇷 **한국 공식**: 정부 (.go.kr) / 협회·학회 (.or.kr) / 기업 (.co.kr) / 대학 (.ac.kr) / 연구원 (.re.kr) — **deep page** (root URL X)
2. 🇰🇷 **한국 미디어**: 한국경제·전자신문·연합뉴스·이코노믹리뷰·KBS·MBC·SBS·JTBC·CJ ENM 뉴스룸 등 1차 보도
3. 🇰🇷 **한국 위키**: ko.wikipedia.org (1순위 시도)
4. 🌐 **외국 1차 출처** (fallback): en.wikipedia.org / 글로벌 기관 (FDA·IFR·OECD 등) — 한국 출처 부재 시에만

**한국 한정 fact는 외국 출처 절대 X**:
- ❌ "한국 N위 / 한국 시장 N억 / 한국 채용 / 한국 인력 부족" + en.wikipedia.org → FAIL
- ❌ "한국 조선업 세계 1위" + 외국 사이트 → FAIL (한국 출처에서 확인 필수)
- ✅ "ChatGPT 등장" + en.wikipedia.org/ChatGPT → OK (글로벌 사실)
- ✅ "글로벌 의료기기 시장 N억 달러" + 글로벌 통계 → OK

**한국 위키 우선 패턴**:
```
1. ko.wikipedia.org/wiki/{topic} 시도 (WebFetch verify)
2. 한국 위키 부재 또는 stub → en.wikipedia.org/wiki/{topic} fallback
3. 한국 위키에 있는데 외국 위키 사용 → FAIL
```

---

## 본문-출처 1:1 정합성 (Phase 4-SRC-FACT 룰 — 보강)

본문 구체 fact가 등장하면 그 fact를 직접 cover하는 출처 매핑 강제.

| 본문 구체 fact 종류 | 적합한 1차 출처 | 부적합 (사고) |
|---|---|---|
| 회사명 (서안·동심원·삼성전자·네이버 등) | 그 회사의 공식 채용/홈페이지 또는 그 회사를 직접 보도한 기사 | 협회 메인, 직업백과 일반 페이지 |
| 통계 수치 (평균임금 6800만원, 종사자 12만명 등) | 그 통계 발표 페이지 (KOSIS 통계표 / 공공기관 보도자료 / 학술논문) | 협회 메인, 정부 부처 root, 백과 일반 |
| 연도·순위 (2024년 기준 1위 등) | 그 순위·연도 발표 페이지 | 일반 산업 분석 |
| 자격증 명·시험 일정 | 자격증 주관 기관(Q-Net 등)의 그 자격증 페이지 | 협회 메인 |
| 금액·연봉 구체 (초임 4500만원 등) | 채용 공고 / 정부 임금 통계 / 언론 임금 보도 | 협회 메인 |

### 일반 도메인 = 구체 fact 출처로 등록 절대 금지

다음 카테고리는 **산업 일반 정보용으로만** 사용 가능. 본문 구체 fact 출처로 등록 시 자동 **factMismatch FAIL**:

- **협회 메인** (ksla.or.kr / kosca.or.kr / kpta.co.kr 등 root) — 산업 개관·자격증 일반 OK / 회사·통계·서사적 진술 fact 출처 X
- **직업백과 일반 페이지** (asamaru.net 어디든) — 직업 정의·일반 설명 OK / 구체 회사·통계 출처 X
- **부처 메인** (mohw.go.kr / molit.go.kr 등 root) — 정책 일반 OK / 구체 통계 출처 X
- **위키 일반 페이지** (ko/en.wikipedia.org 직업 정의) — 정의·역사 OK / 구체 회사·통계 출처 X
- **자기소개서·취업 가이드 사이트** (jasoseol.com / linkareer.com / incruit.com) — specific 회사 자소서 1개만 cover / 다수 회사·채용 fact 출처 X
- **UGC** (blog.naver.com / cafe.naver.com / brunch / Medium 등) — 개인 의견·후기 OK / 통계·산업 사실 출처 X

---

## 사고 사례 — 본 사이클 (2026-05-08)

### 1. 방사선사 trivia 0.6 mSv (사용자 발견)

- **본문 fact**: "방사선사는 연 0.6 mSv 노출"
- **출처 URL**: `https://kdca.go.kr/...` (valid)
- **문제**: 출처 URL 자체는 정상이지만 본문 숫자 0.6이 부정확. 실제 KDCA 통계는 **0.82 mSv**.
- **사고 패턴**: 출처 형식 audit는 PASS. fact verification 단계 부재 → 사용자 spot-check로만 발견.
- **fix**: 본문 0.6 → 0.82 정정 + 출처 deep page (KDCA 의료기관 방사선 노출 통계 2024) 재발굴.

### 2. 게임-프로그래머 detailReady 시장 9.9조 (사용자 발견)

- **본문 fact**: "한국 게임 산업 시장 9.9조원 (2023)"
- **출처 URL**: KOCCA 보고서 valid
- **문제**: 9.9조는 2022 기준. 2023 KOCCA 발표 자료는 **11.6조**.
- **fix**: 본문 9.9조 → 11.6조 + 출처 페이지 2023 보고서 deep page로 교체.

---

## 검증 강제 (Phase 7 DONE 보고)

```json
{
  "fact_verification": {
    "facts_checked": 12,
    "facts_corrected": 2,
    "facts_unchanged": 10,
    "evidence": [
      { "fact": "방사선사 연 노출 0.82 mSv",
        "src_url": "https://kdca.go.kr/.../radiation-stats",
        "covers": true,
        "evidence": "WebFetch '0.82 mSv (2024)' 직접 등장" },
      { "fact": "한국 게임 시장 11.6조원 (2023)",
        "src_url": "https://kocca.kr/.../report-2023",
        "covers": true,
        "evidence": "KOCCA 보고서 '11.6조 원 (2023)' 직접 등장" }
    ],
    "all_covered": true
  }
}
```

`all_covered=false` 또는 `evidence` 명시 X → POST 절대 차단.

---

## fact verification 비용

- WebSearch query 1~3회 per fact → 직업당 평균 5~10회 (12 fact 중 핵심만)
- WebFetch verify 1회 per 정정된 fact → 직업당 평균 2~3회
- 추가 토큰 ~2K~5K per 직업 (mismatch 0~3건)

대부분 직업은 fact가 정확하거나 일반론적 표현이라 verification에서 PASS — 평균 비용은 미미.

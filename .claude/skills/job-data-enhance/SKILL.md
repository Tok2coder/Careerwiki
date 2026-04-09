---
name: job-data-enhance
description: >
  CareerWiki 직업 데이터 고도화 스킬 (ultimate). job-supplement + job-data-equalize 통합판.
  직업 데이터 현황 자동 진단 → 12개 필드 보완 → 4중 품질 게이트(각주/완결성/유튜브/출처순서) →
  편집 API 저장 → 프로덕션 검증까지 전체 워크플로우를 실행한다.
  유저가 "데이터 보완", "직업 보완", "균등화", "equalize", "부실 직업", "NULL 직업", "데이터 채워줘",
  "직업 데이터 업데이트", "배치 처리", "품질 고도화", "job data enhance", "정보보완",
  "way/salary/trivia 비어있어", "user_contributed_json", "직업 데이터 개선",
  "품질 수선", "각주 정리", "출처 정리", "마커 정리", "보완된 직업 점검", "trivia 수정",
  "footnote fix", "quality repair", "orphan marker", "고아 마커", "Phase 5" 등을 언급하면
  반드시 이 스킬을 사용한다. 단일 직업이든 수백 개 배치든 이 스킬이 처리한다.
---

# CareerWiki 직업 데이터 고도화 스킬

두 스킬(job-supplement, job-data-equalize)을 통합한 최종 워크플로우.
**Phase 0 진단 → Phase 1 보완 → Phase 2 품질 게이트 → Phase 3 저장 → Phase 4 검증 → Phase 5 각주·출처 수선** 순서로 진행.

---

## 🚫 출처·사실성 철칙 (절대 원칙)

> **AI가 지어낸 내용을 출처 없이 넣는 것은 절대 금지.**

- **외부에서 가져오는 모든 정보는 반드시 출처를 명시**한다 — 각주 [N] + sources 등록.
- **출처가 없는 정보는 추가하지 않는다** — 사실이라 확신해도, 출처를 찾을 수 없으면 생략.
- AI가 추론·생성한 문장은 출처 없이 데이터 필드에 삽입 금지. 반드시 실제 URL·문서를 근거로 작성.
- **모든 필드(prospect/sal/way/trivia 포함)에서 출처 없는 합성 문장 추가 절대 금지** — 출처에서 직접 가져온 내용만 작성. 트렌드·시장 분석·AI 전망 등 "그럴듯한" 문장도 출처 없이 추가 금지.
- **원문 뉘앙스 보존 절대 원칙** — 출처의 원문 표현이 "보수적"이면 작성도 반드시 보수적이어야 함. "유지하거나 다소 증가" → "증가 전망"으로 바꾸는 것은 사실 왜곡임. 원문 그대로 인용하고 [N]만 추가.
- **prospect(전망) 필드에서 forecastList 원문 필수 확인** — `merged_profile_json.overviewProspect.forecastList` 또는 CareerNet API의 원문 전망 텍스트를 먼저 조회하고, 해당 내용과 충돌하는 방향으로 UCJ를 작성하는 것은 금지.

---

## ⚡ 핵심 기술 규칙 (항상 적용)

| 규칙 | 내용 |
|------|------|
| `way` 타입 | **반드시 string** — 배열이면 즉시 500 에러 |
| `detailReady` 배열 항목 타입 | `curriculum`/`training`/`recruit` 항목 모두 **반드시 plain string** — `{text:"...", url:"..."}` 객체이면 UI에 URL 도메인이 텍스트에 직접 노출되는 버그 발생. 채용처 URL은 `_sources["detailReady.recruit"]`에만 등록 |
| 인라인 URL·도메인 표기 금지 | 모든 텍스트 필드(way, trivia, wlbDetail 등)와 배열 항목에서 URL/도메인을 문자열에 직접 삽입 금지. `"(worker.co.kr)"`, `"(work24.go.kr)"` 등 괄호 안 도메인 표기 포함 금지. 모든 외부 출처는 반드시 각주 [N] + `_sources`로만 표기. **사이트명 자체는 허용** — `"건설워커를 통해 검색"` ✅, `"건설워커(worker.co.kr)를 통해 검색"` ❌ |
| 검색결과 페이지 URL 금지 | `_sources` URL로 동적 검색결과 페이지(예: `work24.go.kr/wk/a/b/1200/retriveDtlEmpSrchList.do`, `worker.co.kr/job/list.asp`) 사용 금지 — 검색 조건에 따라 결과가 달라지는 페이지는 출처로 부적합. 기관 메인 페이지(`https://www.work24.go.kr/`) 또는 구체적인 직업 상세 페이지 URL 사용 |
| `sidebarCerts` 텍스트 내 [N] 금지 | sidebarCerts 항목(자격증명)은 텍스트에 `[1]` 등 인라인 각주 마커를 **절대 넣지 않음**. 출처가 필요하면 `_sources.sidebarCerts`에만 등록. 텍스트에 마커 넣으면 자격증 이름에 `[숫자]`가 그대로 노출됨 |
| `detailReady.researchList` 수정 금지 | CareerNet 원본 데이터 필드. **스킬이 추가/수정/삭제 금지**. 출처 각주도 달지 않음. 해당 필드가 UCJ에 있으면 validate-job-edit.cjs가 WARN 출력 |
| `detailReady.certificate` 텍스트 내 [N] | certificate 항목도 `curriculum`/`training`처럼 `applyInlineFootnotes`로 처리됨. `[1]` 마커를 넣으면 반드시 `_sources["detailReady.certificate"]` 등록 필수 — 미등록 시 다른 필드 출처로 잘못 연결됨 |
| 출처 배지 카운트 | 배지 숫자 = API 출처(커리어넷 1개) + 사용자 추가 출처. 스킬은 배지 카운트에 신경 쓸 필요 없음 (렌더러가 자동 계산) |
| 편집 API URL | `POST https://careerwiki.org/api/job/{id}/edit` |
| 직업 페이지 URL | `https://careerwiki.org/job/슬러그` (`.kr` 또는 `/jobs` 절대 금지) |
| R2 이미지 키 | `jobs/job-{slug}.webp` — `uploads/` prefix 절대 금지 |
| DB image_url | `/uploads/jobs/job-{slug}.webp?v={timestamp}` |
| 인증 헤더 | `-H "X-Admin-Secret: careerwiki-admin-2026"` |
| 배포 | **반드시 main 브랜치** — worktree에서 배포하면 다음 main 배포 시 롤백됨 |
| DB 명령 | `npx wrangler d1 execute careerwiki-kr --remote --command "SQL문"` |
| 프로젝트 경로 | `C:\Users\user\Careerwiki` |

---

## ⚠️ 필드별 판단 원칙 (작업 전 숙지)

```
1. user_contributed_json에 이미 해당 필드가 있는가?
   → 내용 충분 → 건드리지 않음
   → 부실·2년+ 됐으면 → 보강/최신화
   → 없음 → 아래로

2. merged_profile_json에 API 데이터가 있는가?
   → "항상 새로 작성" (way/detailReady/trivia/wlbDetail/socialDetail/커리어트리)
      → API와 무관하게 반드시 작성
   → "보강 가능" (sidebarCerts/sidebarMajors/overviewSalary.sal/overviewProspect.main)
      → API 충분하면 스킵, 부족하면 보강
   → "API에 있으면 스킵" (overviewWork.main/overviewAbilities.technKnow/detailWlb.wlb 등)
      → API 있으면 스킵, null이면 리서치하여 채움
   → "공식 통계만 허용" (abilityList/aptitude/satisfaction/educationDistribution 등)
      → 공식 통계 있으면 채움, 없으면 null 유지 (추정값 절대 금지)

⚠️ 마이너 직업은 API 데이터가 대부분 비어있을 수 있다. "스킵" 판단 전 실제 데이터 유무 확인.
```

**4카테고리 판단 매트릭스** (상세: `references/field-decision-matrix.md`):

| 카테고리 | 대상 필드 | 행동 |
|----------|----------|------|
| **항상 새로 작성** | way, detailReady, trivia, wlbDetail, socialDetail, 커리어트리 | API 데이터와 무관하게 반드시 작성 |
| **보강 가능** | sidebarCerts, sidebarMajors, sal, prospect | API 충분→스킵, 부족→보강 |
| **API 있으면 스킵** | overviewWork.main, technKnow, wlb/social 등급 | API null이면 리서치+출처 필수로 채움 |
| **공식 통계만** | abilityList, aptitude, educationDistribution, detailIndicators | 출처 없으면 **null 유지** — 추정값 절대 금지 |

> **빈 칸이 거짓 정보보다 100배 낫다** — 공식 통계 전용 필드에 AI 추정값 넣으면 사용자에게 거짓 수치 제공.

---

## Phase 0: 현황 진단 (항상 먼저 실행)

작업 전 대상 직업의 현재 상태를 자동 진단한다. 기존 데이터를 덮어쓰는 사고를 막는다.

### 0-A. 대상 선택

유저가 직업을 지정하면 해당 직업 조회, 아니면 아래 SQL로 선별:

```sql
SELECT * FROM (
  SELECT id, name, slug,
    (CASE WHEN json_extract(merged_profile_json,'$.way') IS NULL OR json_extract(merged_profile_json,'$.way')='' THEN 1 ELSE 0 END) +
    (CASE WHEN json_extract(merged_profile_json,'$.overviewSalary.sal') IS NULL THEN 1 ELSE 0 END) +
    (CASE WHEN json_extract(merged_profile_json,'$.overviewProspect.main') IS NULL THEN 1 ELSE 0 END) +
    (CASE WHEN json_extract(merged_profile_json,'$.trivia') IS NULL THEN 1 ELSE 0 END) as missing_count
  FROM jobs WHERE is_active=1
) WHERE missing_count>=2 ORDER BY missing_count DESC LIMIT 30;
```

### 0-B. 현황 분석 쿼리

```sql
SELECT id, name, slug,
  substr(json_extract(merged_profile_json,'$.way'),1,200) as way_preview,
  json_extract(merged_profile_json,'$.overviewSalary.sal') as salary_preview,
  json_extract(merged_profile_json,'$.overviewProspect.main') as prospect_preview,
  json_extract(merged_profile_json,'$.trivia') as trivia_preview,
  json_extract(user_contributed_json,'$._sources') IS NOT NULL as has_sources,
  LENGTH(user_contributed_json) as ucj_len
FROM jobs WHERE name IN ('직업명') AND is_active=1;
```

**기존 데이터 보존 체크리스트 (Phase 0 완료 후 작성):**
UCJ 또는 merged_profile_json에 아래 필드가 이미 있으면 Phase 1 draft에 반드시 기존값 그대로 포함:
- **overviewSalary.wage (임금 바 차트 데이터) — 절대 덮어쓰기 금지** ← wage 소실 시 임금 바 차트 전체가 사라짐. validate-job-edit.cjs가 draft에 wage 포함 시 FAIL 처리. full-quality-audit.cjs Gate 2가 wage 소실 감지 시 FAIL 처리.
- overviewProspect (그래프 데이터) — 절대 덮어쓰기 금지
- detailWlb.wlb / detailWlb.social (등급) — 교정만 허용, 삭제 금지
- detailIndicators (지표 데이터) — 공식 통계, 임의 변경 금지
merged_profile_json에만 있는 필드도 draft 전송 시 누락되면 null로 덮어씌워지므로 주의.

### 0-C. 진단 결과 보고 형식

```
[직업명] 진단 결과:
✅ way: 존재 (350자) / ❌ way: 없음
✅ salary: 기존 wage 차트 있음 → sal 텍스트만 보강 가능
❌ prospect: 없음 → 작성 필요
⚠️  trivia: 2022년 데이터 → 최신화 필요
❌ detailWlb: wlb/social 등급 없음 → 요약 카드 공란 렌더링 중
✅ youtubeLinks: 2개 (oembed 검증 필요)
⚠️  _sources: 구형 포맷 → A등급으로 업그레이드 필요
⚠️  sidebarMajors: 없음 / ✅ sidebarMajors: 5개 → Phase 0-E 참조
⚠️  sidebarOrgs: 없음 / ✅ sidebarOrgs: 1개 → Phase 0-E 참조
⚠️  sidebarCerts: 1개 → 부족 / ✅ sidebarCerts: 3개 → Phase 0-E 참조
```

**기존 데이터 변경 금지 원칙 (중요):**

| 상황 | 행동 |
|------|------|
| `overviewSalary.wage` + 구조화 포맷이 있음 | **절대 덮어쓰기 금지** — 임금 바 차트가 사라짐. `sal` 텍스트 보강만 허용 |
| `merged_profile_json`에 해당 필드 값이 이미 존재 | **덮어쓰기 전에 판단**: "항상 새로 작성" 필드(way·trivia·wlbDetail 등)는 교체 가능. "보강 가능" 필드(sal·prospect)는 기존 값이 충분하면 스킵 |
| `api_data_json = null` + `job_sources` 행 없음 | API에 존재하지 않는 직업 → 모든 정보를 공개 출처에서 직접 리서치해야 함 |

### 0-D. 기존 각주 정합성 점검 (Go-over)

Phase 0 진단 직후, Phase 1 리서치 시작 전에 실행.
**새 데이터를 쓰기 전에 기존 UCJ의 각주 상태를 먼저 고쳐야 한다.**

#### 점검 항목

| 유형 | 판단 기준 | 조치 |
|------|----------|------|
| **FP — 마침표 앞 마커** | `합니다[1].` 패턴 존재 | 자동 교정 → `합니다.[1]` |
| **FP — 중간 삽입 마커** | `A이다.[1] B이다.` (B도 같은 출처) | [1]을 마지막 문장 끝으로 이동 |
| **비순차 번호** | `[1]`, `[3]` 존재 (`[2]` 없음) 등 | sources 순서 기준으로 재번호 |
| **sources 불일치** | 본문에 `[2]` 있는데 sources에 id:2 없음 | sources에 출처 추가 또는 마커 제거 |
| **각주 누락** | 서술 필드에 문장이 있는데 [N]이 하나도 없음 | 해당 내용의 출처를 찾아 [N] + sources 등록 |

#### 진단 절차

1. 직업의 `user_contributed_json._sources`와 각 텍스트 필드 값을 조회
2. 각 필드에서 위 5가지 유형 해당 여부 확인
3. 문제 없으면 → "기존 각주 정상 — Phase 1 진행" 보고 후 넘어감
4. 문제 있으면 → Phase 1 draft 작성 시 함께 수정 (별도 API 호출 불필요 — 어차피 해당 직업 저장할 때 같이 수정)

#### 각주 누락 처리 규칙

- 기존 텍스트에 각주가 없는 경우: **출처를 직접 찾아서** 달아야 함. 출처를 못 찾으면 각주 없이 유지 (추정 출처 금지).
- 각주 누락 의심 감지: 마침표로 구분된 문장이 2개 이상인데 [N]이 전혀 없으면 누락 가능성 높음.

```
[직업명] 기존 각주 점검 결과:
✅ way: 각주 정상 (1~3 순차, 마침표 뒤)
⚠️  trivia: [1] 누락 — 출처 탐색 필요
❌ wlbDetail: [2]. 패턴 (마침표 앞) → 교정 필요
```

---

### 0-E. 사이드바 현황 점검

Phase 0-D 직후, Phase 1 시작 전에 사이드바 3개 필드의 현황을 확인한다.

#### 점검 기준

| 필드 | 충분 기준 | 보강 필요 기준 |
|------|----------|--------------|
| `sidebarMajors` | 3개 이상 | 없거나 2개 이하 |
| `sidebarOrgs` | 1개 이상 | 없음 (현재 대부분 직업에 없음) |
| `sidebarCerts` | 2개 이상 | 없거나 1개 이하 |

#### 데이터 우선순위

사이드바 3개 필드 모두 **`merged_profile_json`에 이미 있는 값을 먼저 확인**한다.
UCJ에 없더라도 merged_profile에 값이 있으면 그 값에서 출발하여 부족한 부분만 보강.

```sql
SELECT
  json_extract(merged_profile_json,'$.sidebarMajors') as majors,
  json_extract(merged_profile_json,'$.sidebarOrgs') as orgs,
  json_extract(merged_profile_json,'$.sidebarCerts') as certs
FROM jobs WHERE slug='슬러그';
```

#### 사이드바 공통 원칙

- **기존 항목 절대 삭제 금지** — 부족한 것만 추가
- **모든 사이드바 항목에 `[N]` 각주 마커 금지** — 항목명/기관명/자격증명에 `[1]` 등 삽입 시 UI에 숫자가 그대로 노출됨
- `sidebarOrgs` URL이 없으면 `"url": null`로 저장

#### 진단 결과 보고 형식

```
[직업명] 사이드바 점검:
✅ sidebarMajors: 6개 (merged_profile 있음) → 충분
❌ sidebarOrgs: 없음 → 보강 필요 (관련 협회 검색)
⚠️  sidebarCerts: 1개 → 부족 (2개+ 목표, Q-net 검색)
```

---

## Phase 1: 필드 보완 (리서치 + 데이터 작성)

→ 필드별 타입/길이/포맷 상세: `references/fields.md`
→ 필드별 처리 판단(API 데이터 활용 여부): `references/field-decision-matrix.md`

### 필수 채울 필드 (항상 새로 작성, 건너뛰면 안 됨)

| 필드 | 분량 | 핵심 주의 |
|------|------|----------|
| `way` | 200~500자, string | **배열 절대 금지**. 서술형 진로 경로 (자격요건·시험·진입경로). 교육과정 목록 나열 금지 → detailReady |
| `detailReady` | curriculum 5개+, recruit 3+, training 2+ | 교육과정/채용/훈련 **배열** (way와 혼동 금지). **모든 항목 타입**: 반드시 **plain string** — `{text:"..."}` 또는 `{text:"...", url:"..."}` 객체 절대 금지. curriculum/training은 렌더링 깨짐(Rule 12 FAIL). recruit는 UI에 URL 도메인이 그대로 노출되는 버그 발생. 채용처 URL은 `_sources["detailReady.recruit"]`에만 등록. |
| `trivia` | 출처 있는 팩트 1개 | 뻔한 직업 설명 금지. 의외의 통계/현실 |
| `detailWlb.wlbDetail` | 130~200자 | 근무시간·야근·교대. **임금 정보 절대 금지** |
| `detailWlb.socialDetail` | 100~160자 | 사회적 영향·공익만. 근무환경·취업전망 금지 |
| `detailWlb.wlb` / `.social` | 등급 string | **반드시 포함** — 누락 시 페이지 요약 카드 공란. 유효값: `"높음"` / `"보통 이상"` / `"보통"` / `"보통 이하"` / `"낮음"` — **반드시 띄어쓰기 포함** (`"보통이상"`, `"보통이하"` 붙여쓰기 금지) |

### 보강 가능 필드

| 필드 | 판단 기준 |
|------|----------|
| `overviewSalary.sal` | 기존 서술 있으면 유지. 없거나 2년+ 됐으면 최신화. **wage는 절대 덮어쓰지 않음** — wage(그래프 데이터)가 있는 직업은 wage 절대 건드리지 않음. sal 텍스트만 보강. 렌더링: sal 텍스트는 wage 차트 밑에 보충 설명으로 표시됨. wage 없으면 sal 텍스트만 표시. **임금 데이터는 기준 연도 반드시 명시** — `"2024년 기준 평균 연봉 약 3,500만 원"` 형식. 연도 없이 금액만 서술하는 것 금지. |
| `overviewProspect.main` | 기존 서술 있으면 유지. 없거나 부실하면 보강 |

### 무출처 문장 발견 시 처리 절차 (절대 바로 제거 금지)

무출처 문장([N] 각주가 없는 서술 문장)을 발견했을 때 반드시 아래 순서를 따른다:

1. **바로 앞 [N] 출처 확인**: 해당 문장 바로 앞에 있는 [N]의 출처 URL을 WebFetch로 방문하여, 해당 문장 내용이 같은 출처에 포함되어 있는지 확인
2. **같은 출처 범위이면 → [N] 이동**: [N] 마커를 해당 문장 끝으로 이동 (출처 범위 확장)
3. **같은 출처가 아니면 → 다른 출처 탐색**: merged_profile_json 원문, 공식 사이트 등에서 해당 내용의 출처를 찾음
4. **새 출처 확인되면 → [N+1] 추가**: _sources에 새 출처 등록, 문장 끝에 새 각주 추가
5. **어디서도 확인 불가일 때만 → 제거**: 출처를 찾을 수 없는 경우에만 문장 제거

⚠️ 출처 확인 없이 바로 제거하는 것은 금지. 유용한 정보가 출처만 빠진 채 삭제될 수 있음.

### 기존 데이터 수정·대체 금지 원칙

기존 데이터(merged_profile 또는 UCJ에 이미 존재하는 내용)를 수정하거나 대체할 때는 반드시 아래 조건을 모두 충족해야 한다.
새로 찾은 출처가:
- 기존 내용보다 **더 최신**인가?
- 기존 내용보다 **더 디테일**한가?
- **공식 기관 또는 신뢰할 수 있는 소스**인가?

위 조건을 충족하지 않으면 **기존 내용을 그대로 유지**한다.

**절대 금지:**
- ❌ 기존 내용을 **축약**하거나 **과장**하거나 **뉘앙스를 바꾸는** 것
  - 예: "현 상태를 유지하거나 다소 증가할 전망" → "증가 전망" (과장 금지)
  - 예: "감소할 전망" → "보통 수준" (완화 금지)
  - 예: "어려움이 예상" → 언급 자체 생략 (부정 전망 누락 금지)
- ❌ **출처 없는 합성 문장 추가** — 추가하는 모든 문장에는 반드시 출처가 있어야 함
  - 예: DX·AI·ESG 트렌드 문장을 근거 없이 삽입하는 것 금지
  - 예: "[1] 이후 AI 서비스 규모가 커질수록..." 같은 미출처 보충 문장 삽입 금지

#### 🔒 prospect(전망) 필드 원문 보존 규칙 (특별 강조)

`overviewProspect.main`(UCJ 전망 텍스트)를 작성 또는 수정할 때:

1. **반드시 먼저 원문을 확인**한다:
   - `GET /api/jobs/{slug}` → `data.overviewProspect.forecastList[]` (CareerNet 원문 전망 데이터)
   - `GET /api/jobs/{slug}` → `data.overviewProspect.jobSumProspect` (고용24 원문 요약)
   - 원문이 있으면 **해당 텍스트를 기반으로** UCJ를 작성. 원문과 다른 방향으로 작성 금지.

2. **원문 표현의 강도를 그대로 유지**한다:
   - 원문이 "유지하거나 다소 증가" → UCJ도 "유지하거나 다소 증가" 수준으로
   - 원문이 "감소할 전망" → UCJ도 감소 전망을 반드시 언급
   - 원문이 "어렵다·경쟁 심화" → UCJ도 해당 부정 내용 포함

3. **원문에 없는 내용을 긍정적으로 추가 금지**:
   - ❌ 원문은 "유지 수준"인데 AI가 "DX 수요 확대로 성장 전망" 추가
   - ❌ 원문은 "감소"인데 AI가 "스마트팜 등 새로운 기회" 추가
   - ✅ 원문과 같은 방향의 내용만, 출처와 함께 추가 가능

### 최신 데이터 우선 규칙

**동일 출처에 연도별 데이터가 여러 개 있으면 반드시 가장 최신 연도를 사용.**

- ✅ 2023년 통계 vs 2019년 통계 → **2023년 선택**
- ❌ 오래된 연도 데이터를 "있으니까" 사용하는 것 금지

**출처 발행 연도가 현재 기준 3년 이상 오래된 경우**: 본문에 `(YYYY년 기준)` 명시.

- ✅ `"2021년 기준 평균 연봉은 6,500만 원이다.[1]"` — 2024년 기준 3년차라면 연도 표기
- 단, 커리어넷·워크넷의 기본 직업 소개 텍스트는 연도 무관하게 사용 가능 (정적 정보)

**⚠️ sal(임금) 필드는 연도 오래됨 여부와 무관하게 항상 기준 연도를 명시한다.**
임금 수치는 시점에 따라 크게 달라지므로 기준 연도가 가장 중요한 정보다.
- ✅ `"2024년 기준 평균 연봉 약 3,500만 원[1]"` — 연도 명시 필수
- ✅ `"커리어넷 직업정보 2024년 기준 하위 25%는 약 3,200만 원..."` — 출처명 직후 연도 위치
- ❌ `"평균 연봉은 약 3,500만 원이다.[1]"` — 연도 없는 금액 단독 서술 금지
- ❌ `"커리어넷 직업정보 기준 평균 연봉은..."` — "기준" 앞에 연도 없음 → 금지

**sal 연도 확인 절차:**
1. `GET /api/jobs/{slug}` → `data.overviewSalary.wageSource` 또는 `wageYear` 필드에서 연도 확인
2. 출처 텍스트(sources `text` 필드)에서 `(YYYY)`, `YYYY년` 형태의 연도 추출
3. 워크넷·커리어넷·고용24 등 공공 직업 정보 포털은 일반적으로 전년도 데이터 제공 (예: 2025년 접근 시 2024년 기준)
4. 연도를 확인할 수 없으면 출처 URL을 WebFetch로 직접 방문하여 게시 연도 확인
5. 그래도 연도가 없으면 `"최근 기준"` 대신 `"조사 기준 연도 미상"` 명시 (임의 연도 추정 금지)
| `overviewWork.main` | API 데이터 없을 때(null)만 — 수행 직무 서술형 (출처+각주 필수) |
| `overviewAbilities.technKnow` | API 데이터 없을 때(null)만 — 활용 기술 서술형 (출처+각주 필수) |
| `sidebarJobs` | 7~12개, **반드시 DB 실존 확인**. DB에 없는 항목은 제거하되, 해당 키워드가 heroTags에 없으면 heroTags에 태그로 추가 (정보 손실 방지) |
| `sidebarMajors` | 3~8개, **plain string 배열** `["전공명1", "전공명2"]`. **반드시 DB 실존 확인**(`SELECT name FROM majors WHERE ...`). `merged_profile_json.sidebarMajors`에 있으면 우선 활용하고 부족하면 커리어넷·워크넷 관련 학과 검색으로 보강. **[N] 마커 금지** |
| `sidebarOrgs` | 1~3개, **object 배열** `[{"name":"기관명","url":"https://..."}]`. 관련 협회·학회·정부기관. `merged_profile_json.sidebarOrgs`에 있으면 우선 활용. 없으면 해당 직업 주관 협회 공식 사이트 검색(WebSearch: "직업명 협회" 등). URL 모르면 `"url": null`. **[N] 마커 금지** |
| `sidebarCerts` | 2~5개, **object 배열** `[{"name":"자격증명","url":"https://www.q-net.or.kr/..."}]`. `merged_profile_json.sidebarCerts`에 있으면 우선 활용하고 부족하면 Q-net에서 해당 직업 관련 자격증 검색으로 보강. **"~시험" 금지** — LEET·사법시험·TOEIC 등은 시험이지 자격증이 아님. **[N] 마커 금지** |
| `heroTags` | 4~8개, 별칭/세부분류/영문명 포함. **조사 어미 판정 예외**: validate가 "~의", "~이" 등으로 끝나는 태그를 조사로 판정하지만, "강의", "설비", "기여", "관리" 등은 명사임. validate에 예외 리스트가 있으므로 이런 경우 PASS됨. 그 외 실제 조사(~에서의, ~으로의)로 끝나면 수정 필요. |
| `youtubeLinks` | 1~3개, oembed 검증 필수. **형식: `[{url: "https://youtube.com/watch?v=...", title: "영상 제목"}]` 객체 배열** — 문자열 배열(`["url"]`) 절대 금지. 문자열 배열이면 UI에 썸네일 안 뜨고 영상 제목 노출 불가. **한국어 영상만 허용** — 제목이 한국어인 한국 영상만 사용. 영어/외국어 영상 금지. 한국어 영상이 없으면 youtubeLinks 비워둠 (영어 영상 절대 넣지 않음). |

**YouTube 검색 우선순위:**
1. KEIS 직업진로동영상(@KEISwork2011) 채널에서 해당 직업 영상 검색
2. "직업명 현직자 인터뷰" 한국어 검색
3. "직업명 진로 탐색" 한국어 검색

**title 인코딩 주의:** oembed에서 가져온 title에 HTML entity(&#39; &amp; 등)가 포함되면 반드시 디코딩 후 저장. 디코딩 불가 시 YouTube 페이지에서 제목 직접 복사. validate가 HTML entity/퍼센트 인코딩 잔류 시 FAIL 처리함.

> ⚠️ **youtubeLinks title 인코딩 주의**: title은 원본 그대로 저장하며 이모지 포함 가능. WebSearch/oembed에서 가져온 title이 깨져 있으면 직접 YouTube 페이지에서 확인 후 수동 입력. curl 명령에 한국어·이모지 포함 제목을 직접 입력하면 EUC-KR로 오염될 수 있으니 반드시 `--data-binary @파일명` 방식으로 JSON 파일을 전송할 것.

**DB 실존 확인 쿼리:**
```sql
-- 관련 직업 실존 확인
SELECT name FROM jobs WHERE is_active=1 AND name IN ('직업A', '직업B', '직업C');
-- 관련 전공 실존 확인 (sidebarMajors용)
SELECT name FROM majors WHERE is_active=1 AND name IN ('전공A', '전공B');
```
> ⚠️ sidebarJobs·sidebarMajors에 DB에 없는 항목을 넣으면 404 링크가 생성됨
> ⚠️ sidebarOrgs는 외부 기관이므로 DB 확인 불필요 — URL 직접 WebFetch로 생존 여부 확인

### 주석 위치 규칙 (⚠️ CRITICAL — 가장 빈번한 오류)

**필드 유형에 따라 두 가지 규칙이 다르게 적용된다.**

---

#### 산문체 필드 (way, sal, prospect, trivia, wlbDetail, socialDetail, summary, technKnow 등)

같은 출처에서 가져온 **연속 문장 블록**의 **마지막 문장 마침표 뒤**에만 [N]을 1회 붙인다.
다른 출처가 시작되면 새 번호 [N+1].

> ⚠️ **핵심 규칙**: 같은 출처에서 가져온 연속 문장이 2개 이상이면, **[N]은 반드시 마지막 문장의 마침표 뒤에만 1회 삽입. 첫 문장이나 중간 문장에 [N]을 넣지 않는다.**

✅ GOOD:
"A 사실이다. B 현상이 있다.[1] C 통계에 따르면 D이다.[2]"
→ 문장1~2는 출처1에서 가져옴 → 문장2(마지막) 끝에만 [1]
→ 문장3~4는 출처2에서 가져옴 → 문장4(마지막) 끝에만 [2]

✅ GOOD (3문장 모두 같은 출처):
"A 사실이다. B 현상이다. C 현황이다.[1]"
→ 세 문장 모두 출처1 → 마지막 문장3 끝에만 [1]

✅ GOOD (마침표 바로 뒤):
"활용된다. 시뮬레이션이 가능하다.[1]"
→ 마지막 문장 마침표(.) 바로 뒤에 [1] — 정확한 위치

❌ BAD (중복):
"A 사실이다.[1] B 현상이 있다.[1]"
→ 같은 [1]이 2회 등장 — validate FAIL (각주 중복)

❌ BAD (첫 문장에만):
"A 사실이다.[1] B 현상이 있다."
→ B 문장이 같은 출처면 [1]은 B 끝으로 이동해야 함

❌ BAD (중간 문장에만):
"A 사실이다.[1] B 현상이다. C 현황이다."
→ B, C가 같은 출처1이면 [1]은 C(마지막) 끝에 있어야 함

❌ BAD (중간 삽입):
"활용된다.[1] 시뮬레이션이 가능하다."
→ 두 문장이 같은 출처이면 [1]은 마지막 문장 끝으로 이동해야 함

❌ BAD (마침표 앞):
"활용된다. 시뮬레이션이 가능하다[1]."
→ [N]은 반드시 마침표 뒤(.) — `마침표[N]` 아니라 `[N]마침표` 형태는 FAIL

❌ BAD (누락):
"A 사실이다. B 현상이 있다."
→ 출처 각주 자체가 없음

---

#### 리스트형 항목 예외 (detailReady.curriculum, detailReady.recruit, detailReady.training, detailReady.certificate 등)

배열 항목은 마침표로 끝나지 않는 명사구/동사구 형태가 자연스럽다. **마침표 없이 항목 끝에 바로 [N]을 붙이는 것을 허용한다.**

- 마침표가 없는 리스트 항목에 억지로 마침표를 넣지 않아도 됨
- [N]은 항목 텍스트의 **맨 끝**에 붙인다 (중간 삽입 금지)
- 각 출처 [N]은 해당 섹션의 **마지막 항목**에만 1회 (섹션 단위 각주)

✅ GOOD (마침표 없는 명사구 끝):
`"배관공사 관련 안전보건교육 이수[1]"`
`"국가기술자격 취득 후 경력 2년 이상[1]"`

✅ GOOD (마침표 있는 항목):
`"관련 학과를 졸업한다.[1]"`
→ 마침표가 있는 경우 기존 규칙(마침표 뒤)과 동일하게 적용

❌ BAD (억지 마침표):
`"배관공사 관련 안전보건교육 이수.[1]"` → 명사구에 어색한 마침표를 강제로 붙이지 않음
→ `"배관공사 관련 안전보건교육 이수[1]"` 로 작성

❌ BAD (중간 삽입):
`"배관공사[1] 관련 안전보건교육 이수"` → [N]은 반드시 항목 끝에

> 📌 **validate-job-edit.cjs**: detailReady 배열 필드는 각주 위치 검사 대상에서 제외되어 있어 마침표 없는 형태도 PASS됨.

핵심: [N]은 필드 내에서 각각 정확히 1회만 등장해야 함. validate가 중복 감지하므로 위반 시 FAIL.

> 🚫 **같은 [N] 마커를 한 필드 내에서 2회 이상 사용 금지 — validate Rule 5 차단됨.**
> 동일 출처를 비연속 문장에 재인용해야 할 경우: [N]을 마지막 해당 문장 끝으로 이동하거나,
> 다른 URL의 새 [N+1] 출처를 추가해 커버한다. 같은 [N]을 두 번 쓰는 것은 불가.

### detailReady 출처 등록 규칙

detailReady.curriculum / detailReady.recruit / detailReady.training / detailReady.pathExplore 섹션에 내용을 추가할 때:
- 해당 내용의 출처를 반드시 `_sources`에 등록해야 한다.
- sources 키: `"detailReady.curriculum"`, `"detailReady.recruit"`, `"detailReady.training"`, `"detailReady.pathExplore"`
- curriculum/recruit/training/pathExplore는 **배열** 필드이다.
  - **외부 출처 데이터가 있으면 무조건 인라인 [N] 필수** — 기존 데이터든 신규 추가든 관계없이, sources에 등록된 출처가 있으면 해당 섹션 마지막 항목의 text 끝에 인라인 [N] 마커를 붙인다. 마침표가 있으면 마침표 뒤(`이수한다.[1]`), 없는 명사구/동사구면 항목 끝(`안전보건교육 이수[1]`) — **억지로 마침표를 추가하지 않아도 됨**.
  - sources가 없으면 [N] 불필요. `sidebarCerts`는 각주 불필요.
  출처는 sources에 반드시 등록하며, id:1부터 시작하는 객체 배열 형식 사용.
- validate-job-edit.cjs가 텍스트가 있는데 sources가 없으면 WARN 처리.

```json
"sources": {
  "detailReady.curriculum": [{"id":1, "text":"[1] 커리어넷 직업정보", "url":"https://..."}],
  "detailReady.recruit": [{"id":1, "text":"[1] 직업백과 채용정보", "url":"https://..."}],
  "detailReady.training": [{"id":1, "text":"[1] 훈련기관 공식 사이트", "url":"https://..."}],
  "detailReady.pathExplore": [{"id":1, "text":"[1] 커리어넷 진로탐색", "url":"https://..."}]
}
```

**recruit 항목별 출처가 서로 다른 경우** — 각 항목에 [N]을 붙이고 별도 sources 등록:
```json
// recruit 항목마다 다른 출처가 있을 때
"recruit": [
  "공공기관 채용공고 지원[1]",    ← 공공기관 전용 URL (KICT 등)
  "민간 건설사 채용 지원[2]",     ← 채용포털 검색결과 URL
  "전문업체 취업 후 경력 개발"   ← 별도 URL 없으면 [N] 불필요
],
"sources": {
  "detailReady.recruit": [
    {"id":1, "text":"[1] 기관명 채용공고", "url":"https://기관채용페이지"},
    {"id":2, "text":"[2] 사람인 직종 검색결과", "url":"https://www.saramin.co.kr/zf_user/search/recruit?searchword=직종명"}
  ]
}
```
⚠️ **같은 필드 sources에 동일 URL 2회 등록 금지** — validate FAIL 처리됨.

### 기존 콘텐츠 보존 규칙 (F3)

**새 내용을 추가하거나 수정할 때, 기존 UCJ에 있던 내용이 새 내용과 겹치지 않으면 기존 내용을 유지하면서 새 내용을 append해야 한다. 기존 내용을 새 내용으로 통째로 대체하지 않는다.**

| 상황 | 행동 |
|------|------|
| 기존 UCJ 필드가 있고 새 내용과 겹침 | 최신 내용 우선, 중복 제거 |
| 기존 UCJ 필드가 있고 새 내용과 겹치지 않음 | **기존 내용 유지 + 새 내용 append** |
| 기존 UCJ 필드가 없음 | 새 내용으로 채움 |

이 규칙은 **모든 필드**에 적용 (way, trivia, detailReady 배열 등 포함).

### 출처 수집 규칙

**핵심 원칙**: 출처 수가 아니라 **정보 퀄리티(최신성·디테일)**가 목적. 다양한 출처는 다양한 관점의 디테일을 얻기 위한 수단.

**우선순위:**
1등급: 커리어넷(career.go.kr) · 워크넷(work.go.kr) · 한국고용정보원(keis.or.kr) · KOSIS · Q-net
2등급: 직업백과(job.asamaru.net) · 협회·학회 공식 사이트 · 대학 학과 소개
3등급 (적극 활용 권장): 업계 보고서 · 통계청 · 전문 미디어(한경, 매경, IT조선 등) · 학술논문 — 커리어넷/고용24/워크넷은 이미 API로 가져온 데이터와 중복될 수 있으므로, **더 최신이고 고급인 출처를 적극 발굴하여 차별화된 정보를 제공**
❌ 금지: 블라인드, 디시인사이드, 블로그 단독 출처

**출처 다양화 원칙**: 커리어넷/고용24/워크넷은 API로 이미 가져온 데이터와 중복될 수 있음. 업계 보고서, 학회 자료, 전문 미디어(신문/뉴스), 통계청, 직업 관련 전문 사이트 등 고급 출처를 적극 활용. 동일 내용이면 더 최신이고 신뢰도 높은 출처 우선 선택.

**필드 간 출처 재사용 지양 원칙**: 동일 출처(같은 URL)를 여러 필드에 걸쳐 반복 사용하는 것을 최대한 지양한다. 가능하면 각 필드(way, trivia, overviewSalary.sal 등)마다 해당 내용에 더 적합한 별도 출처를 찾아서 사용한다. 부득이하게 동일 URL을 여러 필드에 쓰는 것은 허용되지만, 같은 필드 내 sources 배열에 동일 URL을 2번 이상 등록하는 것은 validate FAIL이므로 절대 금지.

**리서치 탐색 범위**: 커리어넷·워크넷 외에도 아래를 적극 탐색:
- 해당 직업 관련 **협회·단체 공식 사이트** (예: 한국간호협회, 한국건축사협회)
- 관련 **정부부처·공공기관** 공식 통계/보고서 (고용부, 복지부, 교육부 등)
- 업계 **언론 기사** (한겨레, 중앙, 한경, 매경 등 — 발행일 확인 필수)
- **학회지·학술논문** (RISS, KISS, DBpia 등)
- **통계청** KOSIS 통계

**리서치 금지 사항:**
- **없는 내용을 지어내거나 출처를 조작 금지** — 반드시 WebFetch로 해당 URL에서 해당 수치/사실이 실제로 존재하는지 확인 후 사용
- **같은 URL을 하나의 필드 sources에 2번 이상 등록 금지** — 동일 필드 내 같은 URL 중복은 validate FAIL (네트워크엔지니어 overviewProspect 중복 사례 방지)
- **sources.text 필드에 URL 포함 금지** — `"[1] 커리어넷"` (O) / `"[1] https://career.go.kr/..."` (X) — text는 기관명만

**커리어넷 URL (신형만 사용):**
```
https://www.career.go.kr/cloud/w/job/view?seq={job_cd}   ← 반드시 이 형식
```
구버전(`/cnet/front/base/job/jobView.do`) 사용 금지 — 링크가 깨지는 경우 있음

**저작권 원칙 (비공공 출처 사용 시):**
- CC/공공누리 표시 → 사용 가능
- "무단전재 금지" → 수치/사실만 **자체 문장으로 재작성** (원문 복사 금지)
- 크롤링 금지/유료 → 사용 금지
- 어떤 출처든 **원문 그대로 복사 금지**

**반드시 WebFetch로 내용 대조**: 출처 URL에 해당 수치/사실이 실제로 존재하는지 확인. "이 URL이면 이 내용이 있겠지" 추정 금지.

**출처 URL 유효성 규칙** (제출 전 필수 확인):
- 출처 URL은 반드시 실제로 해당 내용을 보여주는 페이지여야 한다 — 메인 페이지, 빈 검색폼, JS만 로딩되는 동적 페이지는 부적합
- 채용 관련 sources URL: 해당 직종 채용공고가 실제로 표시되는 검색결과 페이지 사용 (사람인 검색결과, 잡코리아 검색결과, 기관 공식 채용공고 페이지 등)
- `https://www.work24.go.kr/` (고용24 메인), `https://www.worker.co.kr/` (건설워커 메인) 단독은 채용 출처로 부적합 — 직종명 포함 검색결과 URL 사용. **단, recruit 텍스트를 "건설워커를 통해 ~검색 및 지원"처럼 포털 안내 형식으로 쓰면 메인 URL과 일치하므로 허용.**
- WebFetch로 후보 URL에 직접 접속해 실제 채용공고 목록 또는 관련 내용이 노출되는지 확인 후 사용
- 접근 불가(TLS 오류, 연결 거부) 또는 빈 페이지이면 다른 URL로 대체 (recruit.hdec.kr 등 JS 동적 로딩 사이트 주의)

**출처-텍스트 일치 원칙** (recruit 필드 특히 중요):
- **출처는 진실의 원천이다**: recruit 텍스트 설명과 _sources URL이 가리키는 실제 페이지 내용이 반드시 일치해야 한다.
- 불일치 발견 시 **텍스트를 출처 실제 내용에 맞게 조정**하는 것이 원칙 (출처 내용이 기준).
- 출처 URL에 실제로 없는 특정 회사명·부서명·자격요건을 텍스트에 기재 금지.
  - 예: worker.co.kr 메인이 "삼성물산 상품개발팀 신입공채"를 뒷받침하지 못함 → 텍스트를 "건설워커를 통해 대형 건설사 ~부서 채용공고 검색 및 지원"으로 일반화
  - 예: 잡코리아 "건설재료연구원" 검색에 한국도로공사 도로교통연구원 공고 없음 → 텍스트를 실제 검색결과에 나오는 기관명으로 수정
- 검색결과 URL 범위가 넓어 특정 유형(임대업체 행정직 등)을 단정하기 어려우면, 텍스트도 "~검색 및 지원"처럼 포괄적으로 표현.

→ 출처 등급/포맷 상세: `references/sources.md`
→ sources 키 매핑: `../shared/source-key-mapping.md`

**⚠️ __SOURCE_FIELD_MAP__ 등록 필수 (리스트 필드 각주 렌더링):**
리스트 배열 필드(curriculum, recruit, training, certificate, researchList 등)는 `formatRichText` 인라인 각주가 아닌 클라이언트 JS가 heading에 동적으로 각주를 붙이는 방식이다. 이를 위해 `src/templates/unifiedJobDetail.ts`의 `window.__SOURCE_FIELD_MAP__`에 해당 fieldKey가 등록되어 있어야 한다. **미등록 필드에 sources를 저장하면 heading 각주가 렌더링되지 않는다.**
현재 등록된 리스트 필드: `detailReady.curriculum`, `detailReady.recruit`, `detailReady.training`, `detailReady.researchList`, `detailReady.certificate`, `sidebarJobs`, `sidebarMajors`.
새로운 리스트 필드에 sources를 추가할 경우 반드시 `__SOURCE_FIELD_MAP__`에도 매핑을 등록해야 한다.

---

## Phase 2: 품질 게이트 (4가지 — 전부 PASS해야 저장 가능)

이 단계는 건너뛸 수 없다. 4개 게이트를 모두 통과한 뒤에만 Phase 3으로 진행.

> **⚠️ 필수**: Phase 3 API 호출 직전 반드시 `node scripts/validate-job-edit.cjs < draft.json` 실행. **FAIL 0개 확인 후에만 API 호출 허용.** FAIL이 1개라도 있으면 수정 후 재검증.

**Phase 2 추가 규칙:**
- **overviewSalary.wage는 draft fields에 절대 포함 금지** — validate가 FAIL 처리함
- **같은 필드 sources에 동일 URL 중복 등록 금지** — validate가 FAIL 처리함 (예: overviewProspect sources에 동일 URL 3번 → FAIL)

### Gate 0: 원문 보존·무출처 합성 검증 (Content Integrity — Phase 2 진입 전 필수)

**아래 서술형 필드 중 하나라도 작성·수정한 경우 반드시 아래 항목 체크 후 Gate 1 진행.**

| 필드 | 설명 | Rule 11 대상 |
|------|------|:---:|
| `way` | 되는 길 | ✅ |
| `overviewSalary.sal` | 연봉 서술 | ✅ |
| `overviewProspect.main` | 전망 서술 | ✅ |
| `trivia` | 여담 | ✅ |
| `summary` | 직업 설명 (히어로) | ✅ |
| `overviewAbilities.technKnow` | 기술 지식 서술 | ✅ |
| `detailWlb.wlbDetail` | 워라밸 상세 | ✅ |
| `detailWlb.socialDetail` | 사회적 기여도 상세 | ✅ |
| `detailReady.*` (curriculum/recruit/training/pathExplore) | 진로 준비 정보 | ⛔ 제외 |

> ⛔ `detailReady.*` 제외 이유: 산문 `[N]`이 아니라 `== 제목 [N] ==` 헤딩 각주 체계를 사용하므로 Rule 11 패턴으로 검사하면 오탐 발생.
> 📌 `validate-job-edit.cjs` Rule 11이 자동 검사하지만, AI 작성 단계에서도 사전 확인 필수.

**prospect 원문 보존 체크리스트:**
- [ ] `forecastList` 원문 텍스트와 UCJ `overviewProspect.main`을 나란히 놓고 비교했는가?
- [ ] 원문의 전망 강도(증가/유지/감소)가 UCJ에서 동일하게 유지되는가?
  - "유지하거나 다소 증가" → UCJ도 이 표현 수준을 벗어나지 않는가?
  - 원문에 "감소" 언급 있으면 → UCJ에도 해당 내용이 포함되어 있는가?
- [ ] UCJ의 모든 문장에 출처 [N]이 있는가? (출처 없는 문장 0개 확인)
  - 마지막 [N] 이후에 추가 문장이 있으면 → 그 문장에도 [N]이 있어야 함
- [ ] 원문에 없는 긍정적 전망을 AI가 임의로 추가하지 않았는가?

**sal 연도 체크리스트:**
- [ ] sal 텍스트에 `YYYY년 기준` 또는 `YYYY년` 연도가 포함되어 있는가?
- [ ] 출처(wageSource 또는 sources text)에서 연도를 실제로 확인했는가? (추정 금지)
- [ ] `"기준"` 앞에 연도가 명시되어 있는가? (`"워크넷 기준"` 형태 → `"워크넷 2024년 기준"` 으로)

**무출처 합성 문장 체크리스트 (모든 필드 공통):**
- [ ] draft의 모든 서술 문장 끝에 [N] 마커가 있는가?
- [ ] [N] 없는 문장이 있다면 — 그 문장을 출처 있는 내용으로 교체하거나 삭제했는가?
- [ ] "AI 도입", "DX 전환", "ESG 경영" 등 트렌드 문장이 출처 없이 추가되지 않았는가?

> ⚠️ Gate 0에서 하나라도 미충족이면 → 해당 문장 수정/삭제 후 재체크. Gate 1으로 넘어가지 않음.

### Gate 1: 각주 검증 (Footnote Validation)

→ 상세: `../shared/footnote-validation.md`

```javascript
// 필드별 [N] 중복 검사 (반드시 실행)
function validateFootnotes(text, fieldName) {
  const counts = {};
  (text.match(/\[(\d+)\]/g)||[]).forEach(m => { counts[m] = (counts[m]||0)+1; });
  const dupes = Object.entries(counts).filter(([_,c])=>c>1);
  if (dupes.length) throw new Error(`${fieldName}: [N] 중복 — ${dupes.map(([n,c])=>`${n}이 ${c}회`).join(', ')}`);
}
```

체크리스트:
- [ ] 각 `[N]`이 해당 필드에서 1회만 등장하는가?
- [ ] `[N]` 번호가 **필드별** 1부터 순차 증가하는가? (건너뛰기 금지: `[1][3]` ← 불가)
  - ⚠️ **주의**: 번호는 필드 간 공유 안 함. way=[1][2], sal=[1], trivia=[1][2] 각각 독립 번호 사용
  - editService가 저장 시 자동으로 전역 ID를 재할당 → 페이지에 [3],[4] 등으로 표시됨
- [ ] 각주 위치 (산문 필드): `합니다.[1]` (O) / `합니다[1].` (X) — 마침표 **뒤**에
  - 리스트 항목(curriculum/recruit/training/certificate): 마침표 없이 항목 끝에 바로 [N] 허용 (`안전보건교육 이수[1]` O)
- [ ] sources[필드키] 배열 길이 = 해당 필드 최대 `[N]` 번호와 일치하는가?
  - [N]이 [1]부터 순차이므로, 최대 번호 = 종류 수. 예: `[1][2]` → sources 2개
  - 순차 위반([1][3])은 이 검사 전에 위 규칙에서 먼저 FAIL → 여기까지 안 옴
- [ ] sources 내 `id` 값도 per-field [1]부터 시작 (`{"id":1,...}`, `{"id":2,...}`)

### Gate 2: 텍스트 완결성 검증 (절단 문장 감지)

서술형 필드(`way`, `trivia`, `overviewSalary.sal`, `overviewProspect.main`, `detailWlb.wlbDetail`, `detailWlb.socialDetail`)에서 문장이 중간에 잘렸는지 검사.

**잘린 문장 패턴 (발견 시 반드시 수정):**
- 조사/어미로 끝남: `"...부상 시"`, `"...으로 인해"`, `"...경우에는"`, `"...에 따르면"`
- 동사 어간으로 끝남: `"...가능하"`, `"...필요하"`, `"...이루어지"`
- 숫자/단위로 끝남: `"...2024년"`, `"...억 원"`, `"...% 이상"`

검증법: 마지막 문장이 `마침표(.)` 또는 `~습니다/~입니다/~됩니다/~합니다` 등 완성형 어미로 끝나는지 확인.

### Gate 3: YouTube 제목 관련성 체크

youtubeLinks의 모든 영상에 대해:

```bash
curl -s "https://www.youtube.com/oembed?url=https://www.youtube.com/watch?v=VIDEO_ID&format=json"
```

체크리스트:
- [ ] oembed 200 응답인가? (삭제/비공개 영상 제외)
- [ ] `title` 필드가 존재하는가? (없으면 UI에 URL이 그대로 노출됨)
- [ ] 영상 제목에 직업명 또는 관련 키워드가 포함되어 있는가?
  - ✅ "간호사 되는 법", "간호사 현직자 인터뷰", "간호 국시 준비 방법"
  - ❌ "내 하루 브이로그", "2024 맛집 추천" (직업명/관련 키워드 없음)
- [ ] 진로 탐색 목적 영상인가? (진로 가이드 > 현직자 인터뷰 > 전망 > vlog)
- [ ] **한국어 영상인가?** — 제목이 한국어로 표시되는 한국 영상만. 영어/외국어 영상 발견 시 제거. 한국어 영상이 없으면 youtubeLinks를 빈 배열 `[]`로 설정 (영어 영상 유지 금지)

### Gate 4: 출처 ID 순서 검증

각 필드의 sources 배열 내 id가 해당 필드의 [N] 등장 순서와 일치하는지 확인.

**검증 절차 (per-field 방식):**
각 필드별로 독립 검증:
- way에 `[1]`, `[2]` → sources["way"] = [{id:1,...}, {id:2,...}] ✅
- sal에 `[1]` → sources["overviewSalary.sal"] = [{id:1,...}] ✅
- trivia에 `[1]`, `[2]` → sources["trivia"] = [{id:1,...}, {id:2,...}] ✅

```
❌ 구버전 (전역 번호 — full-quality-audit FAIL):
sal: "[3]" sources["overviewSalary.sal"]: [{id:3}]  ← FAIL

✅ 현행 (per-field 번호):
sal: "[1]" sources["overviewSalary.sal"]: [{id:1}]  ← PASS
```

> 💡 editService가 저장 시 자동으로 전역 ID를 재할당하므로, 페이지에서는 [3],[4] 등 전역 번호가 표시되는 것이 정상.

---

## Phase 3: 저장 (편집 API 호출)

### 3-A. 사전 검증 스크립트 실행

```bash
# PASS 확인 후에만 API 호출 (FAIL이면 수정 후 재실행)
node scripts/validate-job-edit.cjs < draft.json
```

**이 스크립트가 검사하는 10가지** (하나라도 FAIL이면 API 호출 차단):
1. way 최소 100자 + string 타입 (배열이면 즉시 FAIL)
2. detailReady.curriculum 3개+
3. sidebarJobs 15개 이하
4. sidebarCerts에 "시험" 단어 금지
5. heroTags 3~10개, 조사로 끝나면 FAIL, 15자 초과 FAIL
6. 짧은 라벨 필드(workStrong/workPlace/physicalAct) 20자 이하
7. 공식 통계 전용 필드에 출처 없이 값 넣으면 FAIL
8. 각주 [N] 중복 + sources 대응 확인 + blob 검출
9. 서술 필드 잘린 문장 감지
10. YouTube URL 포맷 + sources {text,url} 분리 검증

### 3-B. 편집 API 호출

**fields + sources는 반드시 함께 전송.** sources 없이 fields만 보내면 각주가 깨진다.

```bash
curl -s -X POST "https://careerwiki.org/api/job/{id}/edit" \
  -H "Content-Type: application/json" \
  -H "X-Admin-Secret: careerwiki-admin-2026" \
  -d '{
    "fields": {
      "way": "...[1] ...[2]",
      "trivia": "...[1]",
      "detailWlb": {"wlb":"보통 이하","social":"높음","wlbDetail":"...[1]","socialDetail":"...[2]"}
    },
    "sources": {
      "way": [
        {"text": "[1] 커리어넷 직업백과", "url": "https://www.career.go.kr/..."},
        {"text": "[2] 워크넷 직업정보", "url": "https://www.work.go.kr/..."}
      ],
      "trivia": [{"text": "[1] 한국고용정보원", "url": "https://www.keis.or.kr/..."}],
      "detailWlb.wlbDetail": [{"text": "[1] 직업백과", "url": "https://job.asamaru.net/..."}],
      "detailWlb.socialDetail": [{"text": "[2] 워크넷", "url": "https://www.work.go.kr/..."}]
    },
    "changeSummary": "way·trivia·detailWlb 최신 정보로 보완"
  }'
# 응답: {"success": true} 확인. false이면 오류 메시지 확인 후 수정
```

**sources 키 전체 매핑표** (출처: `../shared/source-key-mapping.md`):

| sources 키 | 대상 필드 |
|------------|----------|
| `way` | 되는 방법 |
| `overviewSalary.sal` | 임금 설명 |
| `overviewProspect.main` | 전망 |
| `trivia` | 여담 |
| `summary` | 직업 설명 |
| `detailWlb.wlbDetail` | 워라밸 상세 |
| `detailWlb.socialDetail` | 사회적 기여 상세 |
| `overviewAbilities.technKnow` | 활용 기술 |
| `detailReady.curriculum` | 교육과정 배열 출처 |
| `detailReady.recruit` | 채용 배열 출처 |
| `detailReady.training` | 훈련 배열 출처 |
| `detailReady.pathExplore` | 진로탐색 배열 출처 |

**흔한 키 실수:**
- ❌ `way_sources` → ✅ `way` (접미사 `_sources` 금지)
- ❌ `overviewSalary_sources` → ✅ `overviewSalary.sal`
- ❌ 숫자 키 `"1"`, `"2"` → ✅ 필드명 키

**각주 [N] 렌더링 지원 필드** (formatRichText 적용 — 이 필드들만 인라인 각주 클릭 링크 사용 가능):
`way`, `overviewSalary.sal`, `overviewProspect.main`, `trivia`, `summary`,
`detailWlb.wlbDetail`, `detailWlb.socialDetail`, `overviewAbilities.technKnow`
— curriculum/recruit/training/pathExplore는 배열 필드이므로 현재 formatRichText가 적용되지 않음. 단, **외부 출처 데이터가 있으면 기존·신규 불문** 마지막 항목 문자열 끝 마침표 뒤에 [N] 마커를 붙인다 (sources 등록은 필수). 모든 항목은 plain string이므로 문자열 끝에 직접 붙인다.

> ✅ **완료**: `detailTemplateUtils.ts`에 `applyInlineFootnotes` 헬퍼 추가, `unifiedJobDetail.ts`의 curriculum·recruit·training 렌더링에 적용 완료 (2026-04-06). 배열 항목 text의 [N] 마커가 `<sup>` 각주 링크로 렌더링됨.

**구조화 데이터는 통째로 전송** (점 표기법 불가):
```json
"detailWlb": {"wlb":"보통 이하","social":"높음","wlbDetail":"...","socialDetail":"..."}
```

### 3-C. 커리어트리 연결 (선택 — 한국인 공인만)

**인물 선정 기준:**
- **살아있거나 최소 2000년 이후까지 경력이 이어진 사람만** — 역사적 위인(세종대왕, 이순신 등)이나 너무 오래된 인물은 제외
- 현실적으로 직업을 고민하는 사람들에게 참고가 되는 인물이어야 함
- 해당 직업 분야에서 실제로 활동한 한국인 공인

→ 인물 선정 기준·스테이지 작성·DB 삽입 상세: `../shared/career-tree.md`

삽입 방법 요약 (직접 wrangler d1 사용 — Admin API 미지원):
```bash
# 1. 인물 삽입
npx wrangler d1 execute careerwiki-kr --remote --command \
  "INSERT INTO career_trees (person_name, person_name_en, person_title, person_image_url, stages_json, display_priority, is_active, created_at, updated_at) VALUES ('인물명', '영문명', '한 줄 소개', NULL, '[{\"order\":0,\"title\":\"직함\",\"job_slug\":null}]', 100, 1, unixepoch()*1000, unixepoch()*1000)"

# 2. 삽입된 ID 확인 후 직업 연결
npx wrangler d1 execute careerwiki-kr --remote --command \
  "INSERT INTO career_tree_job_links (career_tree_id, job_slug, stage_index) VALUES ({ID}, '{slug}', {해당직업스테이지인덱스})"
```

> ⚠️ `job_slug`는 해당 직업에 **처음 진입하는 스테이지에만** 설정. 이전 스테이지(학생, 타직업)는 반드시 null.

**강조 스테이지(stage_index) 설정 규칙:**
`career_tree_job_links.stage_index`는 현재 직업 페이지에서 강조(하이라이트)될 스테이지의 인덱스(0-based).
- 해당 직업에 **처음 진입하여 본업으로 활동한 스테이지**를 지정
- 마지막 스테이지가 전직(회장, 교수, 정치인, CEO 등)이면 → 그 직전의 본업 스테이지 인덱스 지정
- 예: 약사 페이지 → stages: [0:약학대학, 1:약사·약국운영, 2:대한약사회회장] → stage_index=1 (본업)

---

## Phase 3.5: 커리어트리 생성 (한국인 공인 대상)

> 💡 Phase 3 저장 직후 또는 Phase 3과 병행하여 실행. 적합한 인물이 없으면 건너뛰기.

### 인물 선정 기준

- **한국인만** — 외국인 절대 금지
- **공인만** — 위키피디아 등재 또는 공식 프로필 확인 가능한 인물
- **검증 가능한 경력만** — 공식 출처(위키피디아, 나무위키, 공식 사이트)에서 교차 확인된 경력만 입력. 추정/소문 금지
- **다양성** — 같은 직업에 2~3명, 시대·분야·성별 다양하게
- **적합한 인물 없으면 건너뛰기** — 지어내거나 억지로 넣지 않음
- **살아있거나 최소 2000년 이후까지 경력이 이어진 인물** — 역사적 위인 제외
- **정치적 중립** — 정치인 출신은 가급적 피하고, 해당 직업으로 유명한 인물 우선

### 스테이지 작성 규칙

커리어트리는 **업적 나열이 아니라 진입 과정과 성장 경로**를 보여줘야 한다.

**권장 구조:** 사전준비 → 입직 → 초기경력 → 성장 → 현재(본업)

**필수 규칙:**
- **반드시 하나의 스테이지에 해당 직업의 `job_slug` 포함** — 해당 직업에 처음 진입하는 스테이지에만 설정
- 이전 스테이지(학생, 타직업)에는 `job_slug: null`
- **전직(다른 분야로 빠지는 것)은 마지막 스테이지에 넣지 말 것** — 해당 직업 이후의 전직(감독, 정치인, 교수 등)은 제외
- **구체적 타이틀 사용**: "서울대 체육교육과 졸업" (O) / "대학 졸업" (X)
- 수상·업적 자체를 스테이지로 만들지 않음 — description에 간략히 언급만

**❌ 잘못된 예시 (업적 나열):**
```
1. 대학 졸업 (2005)       ← 모호
2. 데뷔 (2006)
3. 금메달 (2010)          ← 업적 나열
4. 세계 1위 (2015)        ← 업적 나열
5. 감독 취임 (2020)       ← 전직 → 제외
```

**✅ 올바른 예시 (진입 경로):**
```
1. 용인체육고 자전거부 (2000-2003) — "중학교 대회 입상 후 체육고 진학"
2. 경륜훈련원 입소 (2003-2004) — "11개월 합숙 훈련, 실기·필기 검정 통과"
3. 경륜선수 데뷔 (2004) — "광명경륜장 첫 출주, C급에서 시작"  ← job_slug 여기
4. A급 승격 (2007) — "3년 만에 최상위 등급, 연간 승률 35%"
5. 국가대표 선발 (2010) — "아시안게임 대표, 트랙사이클 종목"
```

### stage_index 하이라이트 규칙

`career_tree_job_links.stage_index`는 현재 직업 페이지에서 강조될 스테이지 인덱스(0-based):
- `job_slug`가 있는 스테이지의 인덱스를 지정
- 본업이 여러 스테이지에 걸치면 **처음 입직한 스테이지**
- 마지막 스테이지가 전직이면 → 그 **직전의 본업 스테이지** 인덱스 지정
  - 예: stages[0:학교, 1:입직, 2:성장, 3:회장(전직)] → stage_index = 1 (입직)

### DB 저장 방법

**wrangler d1으로 직접 삽입** (Admin API 미지원):

```bash
# 1. 인물 삽입
cd C:/Users/user/Careerwiki && npx wrangler d1 execute careerwiki-kr --remote --command \
  "INSERT INTO career_trees (person_name, person_name_en, person_title, person_image_url, stages_json, display_priority, is_active, created_at, updated_at)
   VALUES ('인물명', '영문명', '한 줄 소개', NULL,
   '[{\"order\":0,\"title\":\"직함\",\"organization\":\"소속\",\"years\":\"기간\",\"description\":\"설명\",\"job_slug\":null}]',
   0, 1, unixepoch()*1000, unixepoch()*1000)"

# 2. 삽입된 ID 확인
npx wrangler d1 execute careerwiki-kr --remote --command \
  "SELECT id FROM career_trees WHERE person_name='인물명' ORDER BY id DESC LIMIT 1"

# 3. 직업 연결 (stage_index = 해당 직업 스테이지의 0-based 인덱스)
npx wrangler d1 execute careerwiki-kr --remote --command \
  "INSERT INTO career_tree_job_links (career_tree_id, job_slug, stage_index) VALUES ({ID}, '{slug}', {index})"
```

> ⚠️ `stages_json` 내 `job_slug`는 해당 직업에 **처음 진입하는 스테이지에만** 설정. 이전 스테이지(학생, 타직업)에는 반드시 `null`.

### 적용 조건

- 모든 직업에 커리어트리 작성을 시도하되, **적합한 한국인 공인이 없으면 건너뛰기**
- 기존 커리어트리가 있는지 먼저 확인:
  ```sql
  SELECT ct.person_name, ct.stages_json FROM career_trees ct
  JOIN career_tree_job_links ctjl ON ct.id = ctjl.career_tree_id
  WHERE ctjl.job_slug = '{slug}';
  ```
- 이미 있으면 중복 삽입 금지

---

## Phase 4: 프로덕션 검증

```bash
# 1. 기본 접속 확인
# ⚠️ 한국어 slug는 반드시 UTF-8 퍼센트 인코딩 사용 (EUC-KR 인코딩 시 500 에러)
curl -s -o /dev/null -w "%{http_code}" \
  "https://careerwiki.org/job/$(python3 -c "import urllib.parse; print(urllib.parse.quote('{slug}'))")"
# 또는 직접 인코딩된 URL 사용:
# curl -s -o /dev/null -w "%{http_code}" "https://careerwiki.org/job/%EC%9E%AC%EB%AC%B4%EA%B4%80%EB%A6%AC%EC%9E%90"
# 200 = 정상 / 500 = JSON 파싱 에러 (way 배열 여부, 따옴표 이스케이프 확인)

# 2. 캐시 우회 후 내용 확인
curl -s "https://careerwiki.org/job/{slug}?nocache=1" | grep "확인할키워드"

# 3. 전체 품질 감사 (PASS 없이 다음 직업으로 넘어가는 것 절대 금지)
node scripts/full-quality-audit.cjs --slug={직업slug}
# FAIL → 이슈 수정 → validate 재검증 → API 재호출 → PASS 확인 후 다음 직업
```

**확인 항목:**
- [ ] HTTP 200 응답
- [ ] way/salary/prospect/trivia 텍스트가 페이지에 표시되는가?
- [ ] 각주 번호 클릭 시 올바른 출처로 이동하는가?
- [ ] **리스트 필드 heading 각주 렌더링 확인** — sources를 저장한 리스트 필드(curriculum, recruit, training, certificate, researchList)의 heading에 `[N]` 각주가 표시되는지 확인. 안 보이면 `src/templates/unifiedJobDetail.ts`의 `__SOURCE_FIELD_MAP__`에 해당 필드가 등록되어 있는지 점검. **미등록 필드는 heading 각주가 렌더링되지 않는다.**
- [ ] youtubeLinks 영상 제목이 올바르게 표시되는가? (URL 문자열 노출 아닌지)
- [ ] `**볼드 잔류 없음**` — 서술 필드에 마크다운 `**...**` 텍스트가 남아있지 않은가?
- [ ] 기존에 있던 데이터가 사라지지 않았는가?

---

## Phase 5: 각주·출처 수선

Phase 4 검증 완료 직후 바로 실행. 방금 보완한 직업의 각주 번호·출처 키 상태를 점검하고 문제가 있으면 수리한다.
Phase 4에서 `full-quality-audit.cjs` PASS가 나왔더라도 GN·FP·SK 잔재가 있을 수 있으므로 항상 실행.

> 💡 **editService 전역 renumber 동작 이해:**
> 편집 API로 저장하면 editService가 모든 sources의 id를 전역 순서로 자동 재할당한다.
> 예: way sources [{id:1},{id:2}], sal sources [{id:1}] → 저장 후 way [{id:1},{id:2}], sal [{id:3}]
> 따라서 저장 직후 full-quality-audit의 Gate4에서 "id 역전/비순차" WARN이 나오는 것은 **정상 동작**.
> Gate4 ID 역전은 editService 구조적 특성이므로 **WARN 유지** (FAIL로 올리지 않음 — FAIL로 올리면 모든 저장이 막힘).
> Phase 5 진단 시 Gate4 WARN은 무시하고, Gate1(각주 중복/순차) FAIL만 수선 대상으로 취급.

### 진단 코드 (5종)

| 코드 | 문제 | 수선 방식 |
|------|------|----------|
| GN | 전역 번호: 필드 내 첫 [N]이 [1]이 아님 | **자동** — 재번호 |
| FP | 마침표 앞 마커: `[N].` → `.[N]` | **자동** — 위치 교정 |
| SK | sources 키 오류: `way_sources`, 숫자 키 등 | **자동** — 키 매핑 |
| OM | 고아 마커: 본문 [N]에 대응 source 없음 | **수동** — 출처 추가 or 마커 제거 |
| OS | 고아 출처: source 있지만 본문에 [N] 없음 | **수동** — 마커 삽입 or 출처 제거 |

> ⚠️ OM은 **절대 자동 삭제 금지**. SK(키 오류) 때문에 source를 못 찾는 것일 수 있다. SK 수선 후 재진단.
> "여담[2]" 같은 현상은 별도 코드가 아니라 **GN의 증상** — trivia 텍스트가 [2]부터 시작한 것. (섹션 헤더 "여담"은 프론트엔드가 렌더링하는 것이지 데이터에 없음)

### 5-0: 수선 대상 확인

**Phase 4 직후 실행**: 방금 보완한 직업에 대해 바로 5-1 진단으로 진입.

배치 수선이나 기존 직업 일괄 점검 시에는 아래로 대상 목록을 수집:
```bash
# FAIL/WARN 직업을 자동 필터
node scripts/full-quality-audit.cjs --all --limit=200
# Gate1 FAIL(각주 비순차/중복/sources 불일치) 직업만 수선 대상으로 등록
```

> ⚠️ `--all`이 ENOBUFS 에러로 실패할 경우 (전체 JSON blob 크기 초과): 아래 SQL로 GN/FP 후보를 먼저 추출 → `--slug`로 개별 감사.
>
> ```sql
> -- GN/FP 후보: sources 내 id가 1보다 큰 직업 (전역 번호 잔재 가능성)
> SELECT slug, name FROM jobs
> WHERE user_contributed_json IS NOT NULL
>   AND (user_contributed_json LIKE '%"id":2%'
>     OR user_contributed_json LIKE '%"id":3%')
>   AND is_active=1 LIMIT 50;
> ```
> 추출된 slug 목록을 `node scripts/full-quality-audit.cjs --slug={slug}` 로 순차 확인.

특정 직업 직접 조회:
```sql
SELECT id, name, slug, merged_profile_json, user_contributed_json
FROM jobs WHERE slug='대상슬러그' AND is_active=1;
```

### 5-1: 개별 진단 절차 (per-job)

**Step 0 — 등급 띄어쓰기 자동교정 (Phase 5 시작 시 항상 실행):**
기존 UCJ의 `detailWlb.wlb`와 `detailWlb.social` 값이 "보통이상", "보통이하", "다소높음", "다소낮음" 등 붙여쓰기면:
→ "보통 이상", "보통 이하", "다소 높음", "다소 낮음"으로 자동 교정하여 수선 필드에 포함.
validate가 이제 붙여쓰기를 FAIL 처리하므로, Phase 5에서 선제적으로 교정해야 저장 가능.

**Step 1 — 데이터 읽기**:
- `merged_profile_json` → 텍스트 필드 원본 (way, sal, trivia 등)
- `user_contributed_json._sources` → 현재 출처 매핑

**Step 2 — 필드별 마커 추출** (스캔 순서 고정):
```
way → overviewSalary.sal → overviewProspect.main → trivia
→ detailWlb.wlbDetail → detailWlb.socialDetail
각 필드: regex /\[(\d+)\]/g → 마커 번호 set 추출
```

**Step 3 — 교차 대조** (필드별 독립 판정):
```
필드마다:
  markers = 본문 [N] 번호들           (예: {4, 5, 6, 7})
  src_len = _sources[필드키] 배열 길이  (예: 4)

  GN: min(markers) ≠ 1               → 🔴 전역번호
  FP: 텍스트에 /\[\d+\]\./ 존재       → 🟡 마침표 위치
  SK: _sources에 비표준 키 존재        → 🔴 키 오류
  OM: max(markers) > src_len          → 🔴 고아 마커
  OS: src_len > 0 AND markers 비어있음 → 🔴 고아 출처
```

> ⚠️ **GN과 OM이 동시에 뜨는 것은 정상**. 예: trivia [4][5][6][7] / source 4개 → max(7)>4=OM이지만, 실제론 GN. 5-2에서 SK→GN 수선 후 [1][2][3][4]가 되면 max(4)=4=OM 해소. **따라서 5-1 진단의 OM은 "잠정"이며, GN 수선 후 재판정해야 최종 확정된다.**

**Step 4 — 진단 보고**:
```
[가스설비공사관리자] 5-1 진단:
  way:     [1][2] / sources.way 2개          → 🟢 정상
  sal:     [3]    / sources["overviewSalary.sal"] [{id:3}] → 🔴 GN
  trivia:  [4][5][6][7] / sources.trivia 0개 → 🔴 GN + OM
```

**Phase 5 추가 체크 — 문장 각주 누락 감지:**
- 필드에 마침표로 구분된 문장이 2개 이상인데 [N]이 하나도 없는 문장이 끝에 있으면 → 누락 의심
- 예: "A이다.[1] B이다. C이다." → 마지막 문장 뒤에 [N] 없음 → 수선 대상
- 같은 출처인 경우 마지막 문장에만 [N]을 붙이면 됨 (다른 출처면 새 번호)

### 5-2: 수선 실행

**⚠️ 수선 순서 엄수: SK → GN → FP → OM → OS**
(키 오류를 먼저 고쳐야 고아 마커가 줄어들고, GN을 고쳐야 OM 판정이 정확해짐)

#### SK 수선 (sources 키 교정)
```json
// Before                           After
"way_sources": [{...}]           → "way": [{...}]
"1": [{...}]                     → (본문 [N] 위치 기준으로 필드키 추론)
"overviewSalary_sources": [{...}] → "overviewSalary.sal": [{...}]
```
**추론 불가 시 수동 판단** — 숫자 키 "1"이 어떤 필드인지 모르면 본문 [N] 분포로 역추적.

#### GN 수선 (전역→필드별 재번호)
```
예: trivia에 [4][5][6][7], sources.trivia = [{id:4,...},{id:5,...},{id:6,...},{id:7,...}]

1. 매핑 생성: {4→1, 5→2, 6→3, 7→4}
2. 텍스트 치환 (큰 번호부터 → 충돌 방지):
   "[7]"→"[4]" → "[6]"→"[3]" → "[5]"→"[2]" → "[4]"→"[1]"
3. sources id 갱신: {id:4}→{id:1}, {id:5}→{id:2}, ...
4. sources text 갱신: "[4] 출처명"→"[1] 출처명", ...
```

#### FP 수선 (마침표 위치)
```
text.replace(/\[(\d+)\]\./g, '.[$1]')
"증가했다[1]." → "증가했다.[1]"
```

#### OM 수선 (고아 마커 — 반드시 수동)
```
SK→GN→FP 수선 후에도 source 매칭 안 되는 마커가 남으면:
  1순위: 출처 찾기 — WebFetch로 관련 페이지 확인 → source 추가
  2순위: 마커 제거 — 출처 불명이면 [N] 삭제 + 잔여 마커 재번호
```

### 5-3: 수선 저장 (**변경 필드만 전송**)

```bash
# 예: trivia GN + sal GN만 수선한 경우 — way는 정상이므 보내지 않음
curl -s -X POST "https://careerwiki.org/api/job/{id}/edit" \
  -H "Content-Type: application/json" \
  -H "X-Admin-Secret: careerwiki-admin-2026" \
  -d '{
    "fields": {
      "trivia": "수선된 텍스트...[1] ...[2]",
      "overviewSalary": {"sal": "수선된 텍스트...[1]", "wage": (기존값 그대로)}
    },
    "sources": {
      "trivia": [
        {"text": "[1] 출처명", "url": "https://..."},
        {"text": "[2] 출처명", "url": "https://..."}
      ],
      "overviewSalary.sal": [
        {"text": "[1] 출처명", "url": "https://..."}
      ]
    },
    "changeSummary": "Phase 5: trivia·sal GN 재번호"
  }'
```

> ⚠️ overviewSalary를 보낼 때 **wage 기존값 반드시 포함** — 통째 전송이므로 wage 빠지면 바 차트 소실.
> 변경 안 한 필드(way 등)는 fields에 넣지 않는다.

### 5-4: 수선 검증

1. `node scripts/validate-job-edit.cjs < draft.json` — PASS
2. `curl -s -o /dev/null -w "%{http_code}" "https://careerwiki.org/job/{slug}"` — 200
3. `node scripts/full-quality-audit.cjs --slug={slug}` — **Gate1 PASS 필수**
4. 수선 전후 diff: 마커·출처·id 외에 **본문 텍스트 내용 변경 없음** 확인

### 5-5: 배치 수선

1. `full-quality-audit.cjs --all` → Gate1 FAIL 직업 목록 수집
2. **A그룹** (자동): GN·FP·SK만 있는 직업 → 배치 처리 가능
3. **B그룹** (수동): OM·OS가 하나라도 있는 직업 → 개별 확인
4. A그룹 배치 → 각 직업 audit PASS 확인 → B그룹 순차

---

## 배치 처리 (10개+ 직업)

대량 처리는 **3단계 분리** 패턴을 사용한다.

### 단계 1: 팀 리더 — 대상 선별 + 현황 요약
Phase 0 쿼리로 대상 목록 생성. 각 직업의 현재 데이터 상태 요약.

### 단계 2: Researcher Agent × 3 병렬 (리서치만, API 호출 금지)
→ 에이전트 프롬프트 템플릿: `references/researcher-agent-prompt.md`

```
병렬 에이전트 분배 예시 (30개 배치):
- Agent A: 직업 1~10
- Agent B: 직업 11~20
- Agent C: 직업 21~30
⚠️ 각 에이전트는 JSON + qualityGates 결과만 반환. 편집 API 호출 금지.
```

### 단계 3: 팀 리더 — 검증 + API 호출 + 프로덕션 확인
1. 에이전트 결과 JSON 수집
2. **Phase 2 품질 게이트 4개** 전부 PASS 확인 (FAIL 직업은 수동 수정 후 재처리)
3. sidebarJobs/sidebarMajors DB 실존 확인
4. validate-job-edit.cjs PASS 후 편집 API 호출
5. full-quality-audit.cjs PASS 확인

### 배치 완료 보고 형식

```
처리 완료: X개 (성공 Y개 / 실패 Z개)
성공: [직업명1, 직업명2, ...]
실패: [직업명A (원인), 직업명B (원인)]
커버리지: N → M / 6,945
```

---

## 체크리스트

### 작업 전
- [ ] Phase 0 진단 완료 (각 직업 현황 파악)
- [ ] `references/lessons.md` 확인 (과거 실수 반복 방지)

### 각 직업 완료 후 (신규 보완)
- [ ] Gate 1: 각주 중복 없음, 1부터 순차, 올바른 위치
- [ ] **[self-check]** 산문 필드: [N]이 마침표 바로 뒤인지 확인 (`합니다.[1]` ✅ / `합니다[1].` ❌ / `합니다.[1] 다음 문장` ❌)
- [ ] **[self-check]** 리스트 항목(curriculum/recruit/training/certificate): [N]이 항목 맨 끝에 위치하는지 확인 (`안전보건교육 이수[1]` ✅ / `안전보건교육[1] 이수` ❌)
- [ ] Gate 2: 모든 서술 필드가 완성된 문장으로 끝남
- [ ] Gate 3: YouTube oembed 200 + title 포함 + 직업 관련 키워드 포함
- [ ] Gate 4: _sources id 순서 = 본문 [N] 첫 등장 순서
- [ ] way는 string 타입 (배열 아님)
- [ ] detailWlb.wlb + .social 등급 포함 (높음/보통 이상/보통/보통 이하/낮음 중 하나)
- [ ] sidebarCerts `[{name, url}]` 포맷 사용
- [ ] fields + sources 함께 전송
- [ ] 기존 overviewSalary.wage 건드리지 않음
- [ ] validate-job-edit.cjs PASS
- [ ] HTTP 200 + full-quality-audit.cjs PASS

### Phase 5 완료 후
- [ ] 5-1 진단 완료 (문제 유형별 분류)
- [ ] 마커와 _sources 1:1 매칭
- [ ] 각 필드 [N]이 [1]부터 순차
- [ ] 본문 텍스트 내용 무변경 확인 (마커 외)
- [ ] wage/prospect/구조화 데이터 보존 확인
- [ ] validate-job-edit.cjs PASS
- [ ] full-quality-audit.cjs PASS

### 배치 완료 후
- [ ] 처리 건수 보고
- [ ] 실패 건 원인 분석
- [ ] 커버리지 변화 보고

---

## 참조 파일

| 파일 | 내용 |
|------|------|
| `references/fields.md` | 12개 필드 타입·길이·포맷 상세 스펙 |
| `references/sources.md` | 출처 등급 분류 + A등급 포맷 예시 |
| `references/field-decision-matrix.md` | API 데이터 있을 때 필드별 처리 판단 매트릭스 |
| `references/researcher-agent-prompt.md` | 병렬 리서치 에이전트 프롬프트 템플릿 |
| `references/lessons.md` | 과거 실수 교훈 모음 (새 작업 전 필독) |
| `../shared/career-tree.md` | 커리어트리 인물 선정·스테이지 작성·DB 삽입 상세 |
| `../shared/footnote-validation.md` | 각주 검증 시스템 상세 |
| `../shared/source-key-mapping.md` | sources 소스 키 전체 매핑표 |

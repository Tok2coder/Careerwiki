# Enhance Phase Procedures — Phase 0-PRE / 0-MODE / 0-DIAG / Gate 0~4 / Phase 3.5 / 4-MARKER / 5-DEDUP / 5-AUDIT / 5-VERIFY / END_TRACKING

> archive `job-data-enhance/SKILL.md` Phase 0~5 본문 그대로 통합 (2026-05-09 master 통합).
> ENHANCE 모드 (마커 미보유 신규 직업 + `--force-enhance`) 진입 시 Phase 실행 절차 상세.

---

## Phase 0-PRE. START_TRACKING (skill 1회 실행 시간 기록) ⚠️ **필수 실행 단계**

본격 진단 전, 작업 시작 시각을 임시 파일로 기록한다. Phase 5의 END_TRACKING에서 elapsed 계산에 사용된다.

> 🚫 **절대 skip 금지** — 본 단계를 누락하면 트래킹 데이터가 0건이 되어 운영 지표(p50/p90 시간, 토큰 누적, validate/audit 분포) 측정 불능.
> ✅ **체크 방법**: 실행 후 `ls .skill-runs/.start-${SESSION_ID}-${SLUG}.json` 으로 파일 생성 확인.

```bash
mkdir -p .skill-runs
SLUG="{대상_slug}"               # Phase 0-A에서 결정될 슬러그 (지금 단계는 placeholder OK)
SESSION_ID="${CC_SESSION_ID:-$(date +%s)-$$}"   # Claude Code 세션 ID 또는 fallback
START_TS=$(date -u +%Y-%m-%dT%H:%M:%SZ)
echo "{\"slug\":\"$SLUG\",\"session_id\":\"$SESSION_ID\",\"start_ts\":\"$START_TS\"}" \
  > ".skill-runs/.start-${SESSION_ID}-${SLUG}.json"
```

> 이 파일은 `.gitignore`로 보호된다. END_TRACKING이 정상 종료되면 자동 삭제. 실패 시에도 다음 사이클의 분석에 영향 없음(stale 파일 무시).

---

## Phase 0-MODE. 작업 모드 — 풀 사이클 vs 부분 보강 vs force-enhance

**기본**: 풀 사이클 (Phase 0~5 모두 강제). 첫 enhance 또는 신규 직업.

### `--field-only=<csv>` 부분 보강 모드

마커 보유 직업에 한해 단일 또는 일부 필드만 추가/갱신. Phase 0 진단·Phase 1 다른 필드 작성·Phase 3.6 careerTree 생성 SKIP. Phase 1 해당 필드 + Phase 2 검증 + Phase 3 저장 + Phase 5 수선만 실행.

**사용 조건** (필수 사전 검증):
```sql
-- 마커 사전 체크
SELECT COUNT(*) FROM page_revisions
WHERE entity_type='job' AND entity_id=CAST(? AS TEXT)
  AND (change_summary LIKE '%[job-data-master]%' OR change_summary LIKE '%[job-data-enhance]%');
```
- 결과 ≥ 1: 부분 보강 모드 사용 가능
- 결과 = 0: **풀 사이클 강제** (Phase 0~5 전체)

**예시 사용**:
- `--field-only=sidebarOrgs,sidebarCerts` (이미 enhance된 직업에 sidebar 보강만)
- `--field-only=youtubeLinks` (YouTube만 추가)
- `--field-only=careerTree` (이미 enhance된 직업에 careerTree만 추가)

**효과 추정**: 풀 사이클 ~50K 토큰 → 부분 보강 ~10K 토큰 (5x 효율).

**주의**:
- 0-DIAG 룰은 부분 모드에서도 적용 (`merged_profile_json` 기준 보유 필드 점검 후 누락만 추가)
- 0-PRE START_TRACKING + Phase 5 END_TRACKING은 부분 모드에서도 필수 실행
- 보강 대상 외 필드 절대 덮어쓰기 금지 (Preservation Contract 동일 적용)

### `--force-enhance` 모드 (master 신규)

마커 보유 + audit CLEAN 직업에도 ENHANCE 풀 사이클을 강제 실행. cluster 패턴 / 출처 0 / 옛 룰 박힌 데이터 retroactive 보강 use case.

**진입 신호**:
- `/job-data-master <slug> --force-enhance` 명시 flag
- prompt에 "force re-do" / "재처리" / "quality 회복" / "enhance 강제" 신호

**처리**: 마커 미보유 ENHANCE 모드와 **완전히 동일** — Phase 0-DIAG (12 필드 진단) + Phase 1 (1차 출처 발굴) + Self-Report 17 필드 풀 체크 + careerTree 신규 작성 가능 + 본문 expand / detailReady 항목 추가 / trivia 새 fact 발굴 모두 허용. archive enhance 본래 capability 그대로 적용.

차이는 단지 진입 조건 (이미 enhance된 직업이라는 점) + change_summary `force-enhance:` 접두만.

---

## Phase 0-DIAG. 진단 정확도 룰 ⚠️ **반드시 `merged_profile_json` 기준** (UCJ 단독 금지)

**원칙**: 진단·필드 누락 검사·권장치 미달 분석은 **항상 `merged_profile_json` 기준**. `user_contributed_json` 단독 사용 절대 금지.

**왜 중요한가** (반복 사고 8회+ 후 도입, 2026-04-28):
- `user_contributed_json`은 user 측 편집분만 보유. api_data_json(공공 데이터)이 채운 필드는 보이지 않음.
- 예: 보건교사 sidebarJobs를 UCJ로만 보면 "누락" 판정. 그러나 merged엔 25개 항목 보유 (api 측 채움). false positive 발생.
- 페이지 렌더링에 사용되는 실제 데이터는 `merged_profile_json` (api + user + admin 통합본).

**필드 진단 표준 SQL 패턴** ⚠️ **type별 length 기반 검사 필수**:
```sql
SELECT slug,
  json_type(merged_profile_json, '$.{field}') AS field_type,
  json_array_length(merged_profile_json, '$.{field}') AS field_count,
  length(json_extract(merged_profile_json, '$.{field}')) AS field_text_len
FROM jobs WHERE slug = ?;
```

**판정 룰 (type 분기)**:
- `field_type = NULL` → 진짜 누락 (필드 자체 부재)
- `field_type = 'array'`:
  - `field_count = 0` → 빈 배열 (효과적 누락)
  - `field_count < 권장치` → 권장 미달
- `field_type = 'text'` (string):
  - `field_text_len < 권장 길이` → 텍스트 부실
  - `field_text_len ≥ 권장 길이` → 충실 (보강 불필요)
- `field_type = 'object'` (예: overviewProspect.main): 하위 키별 별도 진단

⚠️ **text 형식 필드를 `json_array_length`로만 검사하면 항상 0 반환 → false positive 다발**.

**필드별 권장 임계치**:
| 필드 | 권장 ≥ | 형식 | 비고 |
|---|---|---|---|
| sidebarJobs | 3 | array | 관련 직업 |
| sidebarMajors | 2 | array | 관련 전공 |
| sidebarCerts | 2 | array | object 배열 `[{name, url}]` |
| sidebarOrgs | 3 | array | object 배열 |
| heroTags | 4~8 | array | 직업 키워드 |
| youtubeLinks | 2 | array | object 배열 |
| **trivia** | **80자** | **text** | **string text — array 아님. length 검사** |
| way | 150자 | text | string text |
| detailReady | 200자 | text | string text |
| overviewSalary.sal | 50자 | text | string text |

**URL null 검사** (sidebarCerts/sidebarOrgs object 배열): 항목 중 `url` 미지정/null이면 **데이터 부실** 별도 표기. 권장치 충족이라도 url null이면 보강 대상.

**skill 룰 차단 필드 명시**:
- `overviewSalary`(sal/wage/wageSource) 전체: `[sal-수정금지]` 차단 → sal=NULL 직업은 sal 보강 보류, 다른 누락만 작업.

---

## Phase 0-A. 대상 선택 + 자동 분기 SQL

유저가 직업을 지정하면 해당 직업 조회, 아니면 아래 SQL로 선별:

```sql
SELECT * FROM (
  SELECT id, name, slug,
    (CASE WHEN json_extract(merged_profile_json,'$.way') IS NULL OR json_extract(merged_profile_json,'$.way')='' THEN 1 ELSE 0 END) +
    (CASE WHEN json_extract(merged_profile_json,'$.overviewProspect.main') IS NULL THEN 1 ELSE 0 END) +
    (CASE WHEN json_extract(merged_profile_json,'$.trivia') IS NULL THEN 1 ELSE 0 END) as missing_count
  FROM jobs WHERE is_active=1
) WHERE missing_count>=2 ORDER BY missing_count DESC LIMIT 30;
```

자동 분기 SQL (마커 + active 판정):
```sql
SELECT j.id, j.slug, j.name, j.is_active,
  (SELECT COUNT(*) FROM page_revisions
   WHERE entity_type='job' AND entity_id=CAST(j.id AS TEXT)
     AND (change_summary LIKE '%[job-data-master]%' OR change_summary LIKE '%[job-data-enhance]%')) AS marker_count
FROM jobs j WHERE slug = ?;
```

---

## Phase 0-B. 현황 분석 쿼리

```sql
SELECT id, name, slug,
  substr(json_extract(merged_profile_json,'$.way'),1,200) as way_preview,
  json_extract(merged_profile_json,'$.overviewProspect.main') as prospect_preview,
  json_extract(merged_profile_json,'$.trivia') as trivia_preview,
  json_extract(user_contributed_json,'$._sources') IS NOT NULL as has_sources,
  LENGTH(user_contributed_json) as ucj_len
FROM jobs WHERE name IN ('직업명') AND is_active=1;
```

**기존 데이터 보존 체크리스트 (Phase 0 완료 후 작성):**
UCJ 또는 merged_profile_json에 아래 필드가 이미 있으면 Phase 1 draft에 반드시 기존값 그대로 포함:
- **overviewSalary** — 🔒 절대 수정 금지
- overviewProspect (그래프 데이터) — 절대 덮어쓰기 금지
- detailWlb.wlb / detailWlb.social (등급) — 교정만 허용, 삭제 금지
- detailIndicators (지표 데이터) — 공식 통계, 임의 변경 금지

merged_profile_json에만 있는 필드도 draft 전송 시 누락되면 null로 덮어씌워지므로 주의.

---

## Phase 0-C. 진단 결과 보고 형식

```
[직업명] 진단 결과:
✅ way: 존재 (350자) / ❌ way: 없음
⛔ salary: 스킬이 건드리지 않음 (sal/wage 모두 읽기 전용)
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
| `overviewSalary` (sal/wage/wageSource 전체) | **→ 필드별 판단 원칙 🔒 절대 수정 금지 참조** |
| `merged_profile_json`에 해당 필드 값이 이미 존재 | **보완 우선**: 기존 서술 필드는 최대한 유지하고 부족한 내용만 보강. 완전 교체는 기존 값이 깨졌거나 검증 가능한 더 나은 출처가 있는 경우에만 예외적으로 수행 |
| `api_data_json = null` + `job_sources` 행 없음 | API에 존재하지 않는 직업 → 모든 정보를 공개 출처에서 직접 리서치해야 함 |

---

## Phase 0-D. 기존 각주 정합성 점검 (Go-over)

Phase 0 진단 직후, Phase 1 리서치 시작 전에 실행.
**새 데이터를 쓰기 전에 기존 UCJ의 각주 상태를 먼저 고쳐야 한다.**

### 점검 항목

| 유형 | 판단 기준 | 조치 |
|------|----------|------|
| **FP — 마침표 앞 마커** | `합니다[1].` 패턴 존재 | 자동 교정 → `합니다.[1]` |
| **FP — 중간 삽입 마커** | `A이다.[1] B이다.` (B도 같은 출처) | [1]을 마지막 문장 끝으로 이동 |
| **비순차 번호** | `[1]`, `[3]` 존재 (`[2]` 없음) 등 | sources 순서 기준으로 재번호 |
| **sources 불일치** | 본문에 `[2]` 있는데 sources에 id:2 없음 | sources에 출처 추가 또는 마커 제거 |
| **각주 누락** | 서술 필드에 문장이 있는데 [N]이 하나도 없음 | 해당 내용의 출처를 찾아 [N] + sources 등록 |

### 진단 절차

1. 직업의 `user_contributed_json._sources`와 각 텍스트 필드 값을 조회
2. 각 필드에서 위 5가지 유형 해당 여부 확인
3. 문제 없으면 → "기존 각주 정상 — Phase 1 진행" 보고 후 넘어감
4. 문제 있으면 → Phase 1 draft 작성 시 함께 수정 (별도 API 호출 불필요 — 어차피 해당 직업 저장할 때 같이 수정)

### 각주 누락 처리 규칙

- 기존 텍스트에 각주가 없는 경우: **출처를 직접 찾아서** 달아야 함. 출처를 못 찾으면 각주 없이 유지 (추정 출처 금지).
- 각주 누락 의심 감지: 마침표로 구분된 문장이 2개 이상인데 [N]이 전혀 없으면 누락 가능성 높음.

```
[직업명] 기존 각주 점검 결과:
✅ way: 각주 정상 (1~3 순차, 마침표 뒤)
⚠️  trivia: [1] 누락 — 출처 탐색 필요
❌ wlbDetail: [2]. 패턴 (마침표 앞) → 교정 필요
```

---

## 🔒 Preservation Contract (기존 데이터 보존 계약)

**Phase 0 완료 후, Phase 1 작성 시작 전 반드시 이 계약을 확인하고 준수한다.**

다음 행위는 **어떠한 이유로도 절대 금지**:

| 금지 행위 | 발생 사례 | 결과 |
|----------|----------|------|
| **배열 항목 수 감소** | sidebarCerts 5개 → 3개로 줄임 | 정보 손실, 즉시 revert 필요 |
| **텍스트 방향 반전** | prospect "소폭 감소" → "안정적" | 사실 왜곡, 즉시 revert 필요 |
| **기존 trivia 무단 교체** | 승효상 관련 기존 trivia → 다른 내용 | 정보 손실, 즉시 revert 필요 |
| **검증 안 된 URL을 recruit sources에** | saramin cat_kewd=84 → 백엔드 채용 페이지 | 잘못된 출처, 즉시 revert 필요 |

**배열 필드 보강 원칙 (sidebarCerts, sidebarMajors, sidebarOrgs, detailReady 모든 배열):**
- 기존 배열이 있으면 → 기존 항목을 **그대로 유지**하고, **없는 항목만 추가**
- 기존 배열을 새로 만든 배열로 **교체하는 것 금지** — 기존 항목을 먼저 가져와서 append
- Phase 0에서 기존 값 확인 후 "기존 항목: X개" 를 명시적으로 기록

**prospect(전망) 텍스트 보강 시:**
- 기존 UCJ의 prospect.main이 있으면 → 반드시 원문 인용하고 방향(긍정/보통/부정)을 그대로 유지
- 방향이 "감소" 또는 "유지" 수준이면 → "증가" 또는 "성장" 방향으로 바꾸는 것 절대 금지
- 기존 내용을 전면 교체하는 것 금지 — 보강이 필요하면 기존 텍스트 끝에 append만 허용

**trivia 교체 시:**
- 기존 trivia가 있고 내용이 충분하면 → **수정하지 않음**
- 수정이 꼭 필요한 경우(각주 오류 교정 등) → 내용 방향은 그대로 유지, 최소 교정만

---

## Phase 0-E. 사이드바 현황 점검

Phase 0-D 직후, Phase 1 시작 전에 사이드바 3개 필드의 현황을 확인한다.

### 점검 기준

| 필드 | 충분 기준 | 보강 필요 기준 |
|------|----------|--------------|
| `sidebarMajors` | 3개 이상 | 없거나 2개 이하 |
| `sidebarOrgs` | 1개 이상 | 없음 (현재 대부분 직업에 없음) |
| `sidebarCerts` | 2개 이상 | 없거나 1개 이하 |

### 데이터 우선순위

사이드바 3개 필드 모두 **`merged_profile_json`에 이미 있는 값을 먼저 확인**한다.
UCJ에 없더라도 merged_profile에 값이 있으면 그 값에서 출발하여 부족한 부분만 보강.

```sql
SELECT
  json_extract(merged_profile_json,'$.sidebarMajors') as majors,
  json_extract(merged_profile_json,'$.sidebarOrgs') as orgs,
  json_extract(merged_profile_json,'$.sidebarCerts') as certs
FROM jobs WHERE slug='슬러그';
```

### 사이드바 공통 원칙

- **기존 항목 절대 삭제 금지** — 부족한 것만 추가
- **모든 사이드바 항목에 `[N]` 각주 마커 금지** — 항목명/기관명/자격증명에 `[1]` 등 삽입 시 UI에 숫자가 그대로 노출됨
- `sidebarOrgs` URL이 없으면 `"url": null`로 저장

---

## Phase 1-PRE. URL 사전 조회 (sidebarCerts / sidebarOrgs 캐싱)

`scripts/skill-cache/cert-org-mapping.json`에 자주 등장하는 자격증 URL(Q-net 등) + 협회/정부기관 URL 사전 보유. **Phase 1 sidebarCerts/sidebarOrgs 작성 시 LLM 리서치 전에 사전 먼저 조회**.

**룰**:
1. 자격증/기관명 결정 후 사전 lookup:
   ```bash
   node scripts/skill-cache/lookup.cjs --type=cert --names="공인노무사,세무사" --json
   node scripts/skill-cache/lookup.cjs --type=org --names="대한변호사협회,한국세무사회" --json
   ```
2. **사전 매칭됨**: 그 URL 즉시 사용 (LLM WebFetch/WebSearch 호출 생략)
3. **사전 부재**: LLM이 WebFetch/WebSearch로 리서치 → 발견 시 본 mapping 파일에 PR로 추가 권장

**효과 추정**: Phase 1 토큰 ~30% 절감 + sidebarCerts/sidebarOrgs URL=null 잔존 제거.

**현재 사전 보유**: 자격증 ~70개 + 협회/기관 ~90개 (Q-net + kuksiwon + 직군별 학회/협회). 부분 매칭 fallback 지원 (자격증명에 등급 포함 케이스 — 예: "공인노무사 1급" → "공인노무사" 매칭).

**경고**: url=null 잔존 발견 시(권장치는 채워졌으나 url 없음) 사전 보강 우선 — 다음 사이클 사용 시 즉시 활용 가능.

---

## Phase 2 — 4 게이트 (전부 PASS해야 저장 가능)

이 단계는 건너뛸 수 없다. 4개 게이트를 모두 통과한 뒤에만 Phase 3으로 진행.

> **⚠️ 필수**: Phase 3 API 호출 직전 반드시 `node scripts/validate-job-edit.cjs < draft.json` 실행. **FAIL 0개 확인 후에만 API 호출 허용.** FAIL이 1개라도 있으면 수정 후 재검증.

**Phase 2 추가 규칙:**
- **overviewSalary 전체(sal/wage/wageSource) draft fields에 절대 포함 금지** — validate [sal-수정금지] FAIL 처리함
- **같은 필드 sources에 동일 URL 중복 등록 금지** — validate가 FAIL 처리함

### Gate 0: 원문 보존·무출처 합성 검증 (Content Integrity — Phase 2 진입 전 필수)

**아래 서술형 필드 중 하나라도 작성·수정한 경우 반드시 아래 항목 체크 후 Gate 1 진행.**

| 필드 | 설명 | Rule 11 대상 |
|------|------|:---:|
| `way` | 되는 길 | ✅ |
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

**무출처 합성 문장 체크리스트 (모든 필드 공통):**
- [ ] draft의 모든 서술 문장 끝에 [N] 마커가 있는가?
- [ ] [N] 없는 문장이 있다면 — 그 문장을 출처 있는 내용으로 교체하거나 삭제했는가?
- [ ] "AI 도입", "DX 전환", "ESG 경영" 등 트렌드 문장이 출처 없이 추가되지 않았는가?

> ⚠️ Gate 0에서 하나라도 미충족이면 → 해당 문장 수정/삭제 후 재체크. Gate 1으로 넘어가지 않음.

### Gate 1: 각주 검증 (Footnote Validation)

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

서술형 필드(`way`, `trivia`, `overviewProspect.main`, `detailWlb.wlbDetail`, `detailWlb.socialDetail`)에서 문장이 중간에 잘렸는지 검사.

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
- 전망에 `[1]` → sources["overviewProspect.main"] = [{id:1,...}] ✅
- trivia에 `[1]`, `[2]` → sources["trivia"] = [{id:1,...}, {id:2,...}] ✅

```
❌ 구버전 (전역 번호 — full-quality-audit FAIL):
전망: "[3]" sources["overviewProspect.main"]: [{id:3}]  ← FAIL

✅ 현행 (per-field 번호):
전망: "[1]" sources["overviewProspect.main"]: [{id:1}]  ← PASS
```

> 💡 editService가 저장 시 자동으로 전역 ID를 재할당하므로, 페이지에서는 [3],[4] 등 전역 번호가 표시되는 것이 정상.

---

## Self-Report: 17필드 완료 체크리스트

**Phase 1-2 완료 후, Phase 3 진행 전에 아래 17개 필드 상태를 직접 보고한다.**

```
필드 | 상태 (✅완료/⚠️부분/❌미작업/🔒스킵) | 비고
-----|------|----
1. way | | 200자+ string
2. detailReady.curriculum | | 5개+ plain string
3. detailReady.recruit | | 3개+ plain string
4. detailReady.training | | 2개+ plain string
5. trivia | | 출처 있는 팩트
6. detailWlb.wlbDetail | | 130~200자
7. detailWlb.socialDetail | | 100~160자
8. detailWlb.wlb (등급) | | 높음/보통 이상/보통/보통 이하/낮음
9. detailWlb.social (등급) | | 동일
10. overviewProspect.main | | 기존 있으면 유지, 없으면 보강
11. sidebarJobs | | 7~12개, DB 실존 확인
12. sidebarMajors | | 3~8개, DB 실존 확인
13. sidebarCerts | | 2~5개
14. sidebarOrgs | | 1~3개 (협회/기관)
15. heroTags | | 4~8개
16. youtubeLinks | | oembed 확인. 없으면 ✅ + _youtubeSearchNote 필수
17. careerTree | | 한국인 공인. 없으면 ✅ + _careerTreeNote 필수
```

> ⚠️ **audit Gate 5(k)**는 _careerTreeNote 미기재 시 WARN을 발생시킨다 — 17번 필드 처리 증거 없이 제출 금지.

---

## Phase 3-A. 사전 검증 스크립트 실행

```bash
# PASS 확인 후에만 API 호출 (FAIL이면 수정 후 재실행)
node scripts/validate-job-edit.cjs < draft.json
```

> ⚠️ **일회성 스크립트 작성 시 절대 규칙**: 수동 수정 스크립트나 one-off 스크립트를 작성할 때도 validate를 우회하면 안 된다. 스크립트 내에서 반드시 `const { validate } = require('./validate-job-edit.cjs')` 로 직접 호출하여 FAIL 0개를 확인 후 API를 호출해야 한다. 하네스 없이 wrangler나 curl로 직접 저장하는 것은 금지 — 과거 사례: validate 미통과 데이터가 프로덕션에 저장되어 각주 깨짐 발생.

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

---

## Phase 3.5: Save Self-check (API 호출 직전 필수 점검)

**Phase 3 API 호출 직전, validate PASS 확인 후 추가로 아래를 반드시 점검한다.**

### 배열 필드 항목 수 확인

Phase 0에서 기록한 기존 배열 항목 수와 draft 배열 항목 수를 직접 비교:

```
[sidebarCerts]  기존: N개 → draft: M개  (M >= N이어야 함)
[sidebarMajors] 기존: N개 → draft: M개  (M >= N이어야 함)
[detailReady.curriculum] 기존: N개 → draft: M개  (M >= N이어야 함)
```

M < N이면 → **즉시 중단, 기존 항목 복원 후 재검증**

### prospect 방향 일치 확인

기존 UCJ의 prospect.main 원문을 다시 꺼내서 draft와 나란히 비교:

```
[기존] "...소폭 감소할 것으로..."
[draft] "...안정적으로 유지될 것으로..."
```

방향이 다르면 → **즉시 기존 텍스트 방향으로 복원**

### trivia 변경 여부 확인

기존 trivia가 있었다면 → draft에서 내용이 교체되지 않았는지 확인.
내용이 다르면 → 교체 이유가 명확한지 확인 (각주 오류 수정 등 최소 교정만 허용)

### curriculum 각주 점검 (필수)

draft의 `detailReady.curriculum` 배열을 항목별로 확인:

```
[항목1] "...취득한다"      → [N] 있음? ✅/❌
[항목2] "...유리하다[2]"   → [N] 있음? ✅
[항목3] "...높아진다[3]"   → [N] 있음? ✅
[항목4] "...쌓을 수 있다"  → [N] 있음? ✅/❌
[항목5] "...갖춘다[1]"     → [N] 있음? ✅
```

- 항목별로 다른 출처가 있는데 [N]이 없으면 → 출처 추가 후 [N] 부여
- 연속된 항목이 동일 출처인 경우 → 마지막 항목에만 [N] (블록 패턴 허용)
- **전체 배열 중 하나의 항목에만 [N]이 있으면 → 반드시 재검토** (블록 오판 의심)

recruit, training도 동일 방식으로 확인 (각 항목이 별도 출처면 각각 [N]).

> ⚠️ **validate [UCJ각주항목누락] FAIL**: curriculum/recruit/training 항목에 [N]이 없으면 저장이 차단됩니다.
> 어떤 항목도 출처 없이 넣지 마세요.

### youtubeLinks 탐색 깊이 확인 (빈 배열 제출 시)

`_youtubeSearchNote`에 다음 중 하나 충족 확인:
- 작은따옴표 탐색어 `'...'` ≥6개 기재됨
- 카테고리 ≥3개 커버: `현직자·인터뷰` / `직무·실무` / `강의·교육` / `진로·면접`

미달이면 → **추가 탐색 후 재기재** (`[YouTubeNote얕음]` FAIL 차단됨)

### careerTree 탐색 깊이 확인 (null 제출 시)

`_careerTreeNote`에 다음 중 하나 충족 확인:
- 이름(이유) 형식으로 후보 ≥5명 기재됨
- 카테고리 ≥3개 커버: `재벌·대기업` / `컨설팅` / `공공·정부` / `학계·연구` / `스타트업·CxO`

미달이면 → **추가 탐색 후 재기재** (`[CareerTreeNote얕음]` FAIL 차단됨)

### sources URL 품질 확인

draft의 모든 sources URL을 한 번 훑어서:
- 검색결과 URL (cat_kewd, searchKeyword 등 파라미터 포함) → 제거 또는 교체
- 해당 직업과 관련 없는 카테고리 페이지 → 제거 또는 교체

**Self-check 항목이 모두 ✅ 이어야 API 호출 가능.**

---

## Phase 3-B. 편집 API 호출

**fields + sources는 반드시 함께 전송.** sources 없이 fields만 보내면 각주가 깨진다.

> 🔖 **changeSummary 마커 규칙 (필수)**: `changeSummary`는 반드시 `[job-data-master]` prefix로 시작한다. 이 마커는 `page_revisions.change_summary`에 저장되어 스킬 적용 여부를 쿼리로 추적하는 데 사용된다.
>
> - ✅ `"[job-data-master] enhance — 17필드 보완 (way, trivia, detailWlb...)"`
> - ✅ `"[job-data-master] cleanup — rootURL=2→0, sidebarSources=1→0"`
> - ❌ `"17필드 보완"` (prefix 누락)
> - ❌ `"job-data-master: 17필드 보완"` (대괄호 누락)

```bash
curl -s -X POST "https://careerwiki.org/api/job/{id}/edit" \
  -H "Content-Type: application/json; charset=utf-8" \
  -H "X-Admin-Secret: careerwiki-admin-2026" \
  -d @draft.json
# 응답: {"success": true} 확인. false이면 오류 메시지 확인 후 수정
```

또는 Node.js fetch (Windows curl mojibake 회피):
```js
await fetch(`https://careerwiki.org/api/job/${id}/edit`, {
  method: 'POST',
  headers: { 'X-Admin-Secret': 'careerwiki-admin-2026', 'Content-Type': 'application/json; charset=utf-8' },
  body: JSON.stringify(payload),
});
```

---

## Phase 4-MARKER. 본문 마커 뭉침 절대 금지 ⚠️

본문에 `[N1][N2][N3]...` **연속된 마커 뭉침 절대 금지** — 시각적으로 뭉쳐 보여 UX 망가짐.

**사고 사례**: 가상현실전문가 `overviewProspect.main` 끝에 `[1][2][3][4]` 뭉침 (apply-rebuild.cjs가 본문 끝에 [1]..[N] 그대로 append한 게 원인). 사용자가 캡처로 발견.

**룰**:
- 본문에서 `\[\d+\](\s*\[\d+\])+` 정규식 매칭 시 즉시 FAIL — validate Gate `[markerCluster]`
- 한 sentence 끝에 마커 max 1개 권장
- 다중 출처 같은 위치 모인 경우 → **옵션 b 채택**: 가운뎃점 분리 → `[1]·[2]·[3]·[4]` (프론트가 [N] 패턴 그대로 인식 + 시각적 분리)
- 자동 fix: `node scripts/skill-cache/fix-marker-cluster.cjs --slug={X}`

**작성 시**:
- 본문 작성 시 한 sentence 끝에 마커 ≤ 1
- 다중 출처 필요 시 sentence 분할 또는 가운뎃점 분리
- 절대 `[N1][N2]` 연속 X (validate에서 FAIL)

---

## Phase 5: 각주·출처 수선 (5종 진단 코드)

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
way → overviewProspect.main → trivia
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

> ⚠️ **GN과 OM이 동시에 뜨는 것은 정상**. 예: trivia [4][5][6][7] / source 4개 → max(7)>4=OM이지만, 실제론 GN. 5-2에서 SK→GN 수선 후 [1][2][3][4]가 되면 max(4)=4=OM 해소.

### 5-2: 수선 실행

**⚠️ 수선 순서 엄수: SK → GN → FP → OM → OS**
(키 오류를 먼저 고쳐야 고아 마커가 줄어들고, GN을 고쳐야 OM 판정이 정확해짐)

#### SK 수선 (sources 키 교정)
```json
// Before                           After
"way_sources": [{...}]           → "way": [{...}]
"1": [{...}]                     → (본문 [N] 위치 기준으로 필드키 추론)
"overviewProspect_sources": [{...}] → "overviewProspect.main": [{...}]
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
curl -s -X POST "https://careerwiki.org/api/job/{id}/edit" \
  -H "Content-Type: application/json; charset=utf-8" \
  -H "X-Admin-Secret: careerwiki-admin-2026" \
  -d '{
    "fields": {
      "trivia": "수선된 텍스트...[1] ...[2]"
    },
    "sources": {
      "trivia": [
        {"text": "[1] 출처명", "url": "https://..."},
        {"text": "[2] 출처명", "url": "https://..."}
      ]
    },
    "changeSummary": "[job-data-master] Phase 5: trivia GN 재번호"
  }'
```

> ⚠️ master 스킬에서는 **overviewSalary 전체를 전송하지 않는다**. 임금 정보 정리는 별도 복구/정비 작업으로만 처리한다.
> 변경 안 한 필드(way 등)는 fields에 넣지 않는다.

### 5-4: 수선 검증

1. `node scripts/validate-job-edit.cjs < draft.json` — PASS
2. `curl -s -o /dev/null -w "%{http_code}" "https://careerwiki.org/job/{slug}"` — 200
3. `node scripts/full-quality-audit.cjs --slug={slug}` — **Gate1 PASS 필수**
4. 수선 전후 diff: 마커·출처·id 외에 **본문 텍스트 내용 변경 없음** 확인

---

## Phase 5-DEDUP. 자동 dedup sweep (Phase 5 직후, END_TRACKING 직전)

각 직업 enhance 사이클이 끝나는 직후 **자동 dedup 검사**. 본 직업의 careerTree self-promotion + 글로벌 동명이인 신규 발생을 자동 탐지.

```bash
# dry-run: 검출만
node scripts/skill-cache/auto-dedup-sweep.cjs --slug={대상_slug}

# apply: 본 직업 self-promotion 자동 정리(max stage_index link DELETE)
node scripts/skill-cache/auto-dedup-sweep.cjs --slug={대상_slug} --apply
```

**검사 항목**:
1. **본 직업 self-promotion** (`(job_slug, ct_id)` multi-stage groups)
   - 발견 시: stages_json의 max stage_index link 자동 DELETE 권장 (--apply)
   - 정책: 평생 동일 직업 활동 사례(stages "1,2") 보존 vs 자기강조 정리는 사용자 가이드 룰 적용
2. **글로벌 활성 동명이인** (`is_active=1 GROUP BY person_name HAVING COUNT>1`)
   - 발견 시: **보고만** — 자동 처리 금지 (김홍희=학예사+해양경찰청장 같은 의도 보존 케이스 회피)
   - 사용자 검토 후 수동 처리: `UPDATE career_trees SET is_active=0 WHERE id=<inactive_id>`

**효과**: 머지 사이클의 dedup 작업 자동화. 직접 처리한 9건+ (정철·김빛내리·하정우·오준호·손석희·이병헌·외환딜러·연극연출가) 같은 사고 실시간 방지.

---

## Phase 5-AUDIT. 사후 sources 사고 감사 (Phase 5-DEDUP 직후, END_TRACKING 직전) ⚠️

각 직업 enhance 사이클 종료 직전, 본 직업의 _sources에 사고 패턴 (mojibake·[N] prefix·raw URL·marker mapping 누락)이 잔존하는지 자동 감사. PASS 받기 전 **종료 금지**.

```bash
# 본 직업만 audit
node scripts/skill-cache/audit-sources.cjs --pattern=mojibake --json | grep "{대상_slug}"
node scripts/skill-cache/audit-sources.cjs --pattern=bracket_prefix --json | grep "{대상_slug}"
node scripts/skill-cache/audit-sources.cjs --pattern=raw_url --json | grep "{대상_slug}"
node scripts/skill-cache/audit-sources.cjs --pattern=sources_NULL --json | grep "{대상_slug}"
```

또는 `audit-via-api.cjs --exclude-sal` 1회 실행으로 전체 패턴 검증.

**판정**:
- 4 패턴 모두 0건 → PASS (END_TRACKING 진행)
- 1+ 패턴 본 직업 발견 → **즉시 Phase 1 다시** (단축 처리 절대 금지)
  - mojibake → UCJ 본문·sources 한글 새로 작성 + Node.js fetch UTF-8
  - bracket_prefix → text의 `[N] ` prefix 제거 후 재저장
  - raw_url → text를 기관명으로 변경
  - sources_NULL → _sources 객체 신규 작성

**🚫 minimal POST 절대 금지** (사용자 신뢰 회복 작업 — 2026-04-29 사고 교훈):
- 토큰 제약 = 단축 사유 절대 안 됨
- 1 직업 개별 처리해도 OK, 9 직업 한 번에 못 하면 1개씩 처리 후 다음
- validate PASS ≠ 작업 끝. **Phase 5-AUDIT도 PASS 받아야 종료 가능**
- context 부족하면 SKILL.md 다시 read 후 재작성

**🛑 validate-job-edit.cjs `[minimalPOST]` FAIL** (commit 2026-04-29):
- changeSummary에 [job-data-master] 마커만 있고 fields/sources 비어있으면 즉시 FAIL
- 단축 처리 사고 시 server-side에서 차단됨

---

## Phase 5-VERIFY. POST 직후 _sources URL 실시간 검증 ⚠️

API POST 성공 직후 (Phase 3 완료 + Phase 5-AUDIT PASS 직후) `post-edit-verify.cjs` 호출 → _sources URL 전수 HTTP HEAD fetch → BROKEN (4xx/5xx/timeout/SSL/DNS) 발견 시 즉시 stop + 사용자 보고.

```bash
node scripts/skill-cache/post-edit-verify.cjs --slug={SLUG} --strict
# exit 0: 모든 URL 200 OK (작업 완료 가능)
# exit 1: BROKEN 발견 (purge-broken-urls 호출 또는 다른 출처로 즉시 교체)
```

**왜 필요한가**: Phase 4-SRC에서 subagent가 WebFetch로 검증했어도 다음 사고 가능:
- TLS expired 전환 (예: k-caddie.com SSL 만료)
- 게시판 ID 변경 (예: humanrights.go.kr boardid 만료)
- subagent가 LLM 자가검증 도피 조항 우회 (이전 사고)

→ POST 직후 1회 더 검증해서 fabricated/만료 URL을 user 보기 전 차단.

**대안**: validate-job-edit.cjs 호출 시 `VALIDATE_CHECK_URLS=1` 환경변수 설정하면 API 호출 *전*에 검증 가능.

```bash
VALIDATE_CHECK_URLS=1 node scripts/validate-job-edit.cjs draft.json
# [urlBroken] FAIL — _sources.way[0] HTTP 404 — https://example.com/...
```

---

## END_TRACKING (skill 1회 실행 시간·결과 영구 로그) ⚠️ **필수 실행 단계**

Phase 5 수선까지 모두 완료된 직후, 1회 enhance 작업의 결과를 `data/skill-runs.jsonl`에 append하고 임시 start 파일을 정리한다. 실패해도 다음 사이클에 영향 없음 (stale start 파일은 분석기가 무시).

> 🚫 **절대 skip 금지** — START_TRACKING과 짝을 이뤄야 1회 실행 시간이 정상 측정됨.
> ✅ **체크 방법**: 실행 후 `tail -1 data/skill-runs.jsonl` 으로 본 직업 row append 확인.

```bash
node -e '
const fs = require("fs"), path = require("path");
const slug = process.argv[2];
const sessionId = process.argv[3] || process.env.CC_SESSION_ID || "unknown";
const startFile = path.join(".skill-runs", `.start-${sessionId}-${slug}.json`);
if (!fs.existsSync(startFile)) { console.error("start file missing — skipping"); process.exit(0); }
const start = JSON.parse(fs.readFileSync(startFile, "utf8"));
const end_ts = new Date().toISOString();
const duration_sec = Math.max(0, Math.round((new Date(end_ts) - new Date(start.start_ts)) / 1000));
const row = {
  slug: start.slug, session_id: start.session_id,
  start_ts: start.start_ts, end_ts, duration_sec,
  validate_status: process.argv[4] || null,         // PASS / WARN / FAIL
  audit_status: process.argv[5] || null,            // PASS / WARN / FAIL
  fields_modified: (process.argv[6] || "").split(",").filter(Boolean),
  careerTree_changes: parseInt(process.argv[7] || "0", 10),
  tokens_in: parseInt(process.argv[8] || "0", 10) || null,
  tokens_out: parseInt(process.argv[9] || "0", 10) || null,
};
fs.mkdirSync("data", { recursive: true });
fs.appendFileSync("data/skill-runs.jsonl", JSON.stringify(row) + "\n");
fs.unlinkSync(startFile);
console.log(`[skill-runs] ${row.slug} ${row.duration_sec}s validate=${row.validate_status} audit=${row.audit_status}`);
' "{대상_slug}" "${SESSION_ID}" "{validate_status}" "{audit_status}" "{fields_csv}" "{careerTree_changes_count}" "{tokens_in}" "{tokens_out}"
```

분석은 `node scripts/skill-runs-stats.cjs` 로 수행 (median/p90 시간, 결과별 count, 누적 토큰 등).

---

## 체크리스트

### 작업 전
- [ ] **START_TRACKING 실행** (`.skill-runs/.start-{session}-{slug}.json` 생성 확인) ⚠️ 필수
- [ ] Phase 0 진단 완료 (각 직업 현황 파악)
- [ ] `_archive/job-data-enhance/references/lessons.md` 확인 (과거 실수 반복 방지)

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
- [ ] Phase 4-MARKER: 본문 마커 뭉침 0건 (`[1][2][3]` 연속 X)

### Phase 5 완료 후
- [ ] 5-1 진단 완료 (문제 유형별 분류)
- [ ] 마커와 _sources 1:1 매칭
- [ ] 각 필드 [N]이 [1]부터 순차
- [ ] 본문 텍스트 내용 무변경 확인 (마커 외)
- [ ] wage/prospect/구조화 데이터 보존 확인
- [ ] validate-job-edit.cjs PASS
- [ ] full-quality-audit.cjs PASS
- [ ] Phase 5-DEDUP / 5-AUDIT / 5-VERIFY PASS
- [ ] **END_TRACKING 실행** (`tail -1 data/skill-runs.jsonl` 본 직업 row 확인) ⚠️ 필수

### 배치 완료 후
- [ ] 처리 건수 보고
- [ ] 실패 건 원인 분석
- [ ] 커버리지 변화 보고

---

## See Also

- `enhance-strict-rules.md` — 출처·사실성 철칙 + 핵심 기술 규칙 표 + 필드별 판단 원칙
- `enhance-fields-spec.md` — 12 필드 상세 spec + careerTree
- `safety-rules.md` — 15 안전 룰 + sal/careerTree 보호
- `phase-flow.md` — 자동 분기 + Phase 0~7 전체 흐름
- `fact-verification.md` — 본문 fact 정확성 검증
- `_archive/job-data-enhance/SKILL.md` — 본 doc의 원본 (Phase 0-PRE / 0-MODE / 0-DIAG / 2 4 게이트 / 3.5 / 5-DEDUP / 5-AUDIT / 5-VERIFY)

# Area Classification — 산문 / detailReady array / sidebar 영역별 정책

> SKILL.md Phase 2-0 의 확장본. 각 finding이 어느 영역에 속하는지 분류 후 fix 패턴 결정.

---

## 왜 영역 분류가 우선인가

같은 룰 위반 (rootURL, origin, listPage 등)이라도 영역에 따라 fix 패턴이 다르다. 잘못된 fix 적용 시 다른 룰 (UCJ 룰 A `[UCJ각주항목누락]`) 즉시 FAIL.

| 사고 패턴 | 발생 사례 |
|---|---|
| 산문 fix 패턴을 detailReady array에 잘못 적용 | rootURL src REMOVE → body [N] 제거 → UCJ 룰 A FAIL (항목 마커 누락) |
| sidebar*에 _sources 등록 | 본문 [N] 마커 안 만들어져 orphan 발생 (룰 L) |
| trivia/overviewWork.main을 array로 인식 | _proseRaw 도입 전 silent skip (PR 14 fix) |

---

## 3 영역 정의

### 1. 산문 필드 (Prose Body)

```
way / summary / trivia / overviewWork.main / overviewProspect.main /
overviewAbilities.technKnow / overviewSalary.sal /
detailWlb.wlbDetail / detailWlb.socialDetail
```

= `PROSE_BODY_FIELDS` (detect-patterns.cjs export, validate / audit 공유 source).

**특성**:
- 본문이 단일 raw string
- 본문 [N] 마커 = field-local 1..N 연속
- `_sources[fieldKey][N-1]` 매핑
- UCJ 룰 A 적용 X (항목 단위 각주 의무 X)

**audit/validate 적용 룰**:
- orphanSrc / brokenRef / dup / orderViolation / origin / rootURL / listPage / mojibake / bracketPrefix / wikiQuota
- proseBodyOrphan (NEW PR 14 — `_proseRaw` namespace로 활성화)

**fix 패턴 (rootURL/origin/listPage)**:
1. WebFetch deep page 시도 → 본문 fact cover 확인 → url 교체
2. cover 실패 → src REMOVE + body [N] 제거 + 후속 마커 RE-INDEX

### 2. detailReady array (UCJ array)

```
detailReady.curriculum / detailReady.recruit / detailReady.training
```

(`detailReady.researchList`는 CareerNet 원본 — 수정 금지, 각주 면제)
(`detailReady.certificate`는 enhance 추가 X — sidebarCerts에서 처리)
(`detailReady.pathExplore`는 array but UCJ 일부 분기 다름 — pathExplore는 enhance 작성 X)

**특성**:
- 항목별 plain string 배열
- 각 항목 끝에 `[N]` 마커 (UCJ 룰 A — 모든 항목 각주 의무)
- `_sources["detailReady.{sub}"][N-1]` 매핑
- 항목별 본문 fact 다른 출처면 각 항목 별도 [N]
- 연속 항목 동일 출처면 마지막 항목에만 [N]

**audit/validate 적용 룰**:
- arrayBrokenRef (J) / orderViolation (K, 합본 처리) / origin / rootURL / listPage / mojibake / bracketPrefix
- UCJ 룰 A `[UCJ각주항목누락]` — 모든 항목 [N] 의무

**fix 패턴 (rootURL/origin/listPage)** — **4단계 fallback 적용** (`fix-patterns.md` 참조):
1. URL 교체 (선호)
2. 본문 fact 일반화 + url 교체
3. 항목 merge (4+ 항목)
4. 인정 + pending 기록

⚠️ **단순 src REMOVE 금지** — 항목이 [N] 잃으면 UCJ FAIL.

### 3. sidebar (사이드바)

```
sidebarCerts / sidebarOrgs / sidebarMajors / sidebarJobs
```

**특성**:
- 자체 `{name, url}` 객체 배열로 표시
- 본문에 `[N]` 마커 박지 X (UI에 숫자 그대로 노출)
- `_sources` 등록 시 글로벌 idx만 부여 + 본문 sup 안 만들어짐 → **orphan 발생** (룰 L)

**audit/validate 적용 룰**:
- sidebarSources (L) — `_sources["sidebar*"]` 등록 자체 금지
- 항목별 url 검증 (WebFetch verify)

**fix 패턴**:
- `_sources["sidebar*"]` 통째 DELETE (`{delete: true}` merge):
```js
sources: { "sidebarOrgs": { delete: true } }
fields: {}    // 본문 변경 없음 — sidebar 항목 자체는 미접촉
```

⚠️ 빈 배열 `[]` 전송하지 X (일부 케이스에서 빈 배열로 남아 idxGap 가능). 명시적 `{delete: true}` 사용.

---

## 룰별 영역 적용 매트릭스

| 룰 | 산문 | detailReady array | sidebar |
|---|---|---|---|
| origin (F) | src REMOVE + body RE-INDEX | **4단계 fallback** | 통째 DELETE |
| selfCite (F') | 동일 | 동일 | 동일 |
| rootURL (13) | 1단계 deep → 실패 시 REMOVE | **4단계 fallback** | 통째 DELETE |
| listPage (E) | 1단계 deep article → 실패 시 REMOVE | **4단계 fallback** | 통째 DELETE |
| wikiQuota (14) | wiki cover 약한 것부터 REMOVE | 동일 | — |
| sidebarSources (L) | — | — | `{delete:true}` |
| arrayBrokenRef (J) | — | element 안 [N] 정정 | — |
| orderViolation (K) | 본문+array 합본 첫 등장 1..N | 동일 | — |
| idxGap | 글로벌 id 1..N 재할당 | 동일 | 동일 |
| mojibake | UTF-8 재인코딩 | 동일 | 동일 |
| bracketPrefix | text 시작 [N] 제거 | 동일 | 동일 |
| brokenRef (I) | 마커 정정 또는 제거 | (룰 J가 처리) | — |
| dup | 한 sentence 1 마커 max | 동일 | — |
| **proseBodyOrphan (NEW)** | 본문 [N] 추가 또는 src REMOVE | (룰 J) | — |
| **factSourceMismatch (NEW)** | fact 정정 + 새 출처 등록 | 동일 | — |

---

## UCJ 룰 영향 (항목 단위 각주 의무)

`detailReady.curriculum/recruit/training` 항목은 validate 룰 A 적용:
- 항목별 [N] 마커 의무 (없으면 `[UCJ각주항목누락]` FAIL)
- 단순 src REMOVE → 항목 마커 잃음 → 즉시 FAIL

**원칙**: 외부 출처 데이터가 있으면 무조건 인라인 [N] 필수. 마침표 있으면 마침표 뒤(`이수한다.[1]`), 명사구/동사구면 항목 끝(`안전보건교육 이수[1]`) — 억지로 마침표 추가하지 않아도 됨.

**연속된 항목이 동일 출처일 때만**: 마지막 항목에만 [N] 1회 (validate `[각주중복]` 회피).

**예외**: `detailReady.researchList`는 CareerNet 원본 — 각주 면제.

---

## 산문 필드 fact 정확성 검증 (factSourceMismatch)

`fact-verification.md` 참조. 본문 구체 fact (회사명·통계·연도·금액·순위)는 출처 페이지에 직접 등장 의무 — WebSearch + WebFetch cross-check.

mismatch 검출 시:
1. 본문 정정 (정확한 값으로) + 새 출처 등록
2. 또는 본문 일반화 (구체 → 추상)
3. 또는 fact 자체 제거

상세 절차: `fact-verification.md`.

---

## 영역 분류 빠른 판정

```js
function classifyArea(fieldKey) {
  if (PROSE_BODY_FIELDS.includes(fieldKey)) return 'prose';
  if (/^detailReady\.(curriculum|recruit|training)$/.test(fieldKey)) return 'array';
  if (SIDEBAR_FIELDS_FORBIDDEN.includes(fieldKey)) return 'sidebar';
  return 'other';
}
```

`PROSE_BODY_FIELDS` + `SIDEBAR_FIELDS_FORBIDDEN`는 `scripts/_shared/detect-patterns.cjs` export.

---

## 영역별 사고 사례

### 산문 영역 사고

- **방사선사 trivia** (rev 14299 cleanup): trivia 산문 src REMOVE + body [1] 제거 → 정상 작동 (UCJ 룰 적용 X)
- **게임-프로그래머 trivia orphan** (PR 14 검출): trivia _sources 3개 등록 + body 0 markers → proseBodyOrphan 검출 (PR 14 활성화 후)

### detailReady array 사고

- **국무총리 / 게임-기획자 / 산부인과의사 / 가상현실전문가** (rev 14244-14247, 2026-05-06): detailReady.curriculum/recruit/training 배열에 글로벌 idx [N] 박았는데 _sources["detailReady.X"]는 field-local 길이만큼만 등록 → broken ref. 룰 J `arrayBrokenRef` 검출.
- **게임-프로그래머 detailReady root URL 6건** (rev 14299, 2026-05-08, 4단계 인정): curriculum 4건 + recruit 2건 root URL → 단순 REMOVE 금지 + deep URL 부재 → 4단계 인정 + pending 기록.

### sidebar 영역 사고

- **게임-기획자 _sources.sidebarCerts[0]** (rev 14249, 2026-05-06): sidebar 본문에 [N] 없는데 _sources 등록 → orphan. 룰 L `sidebarSources` 검출. fix: `{delete:true}` 통째 삭제.

---

## 영역 분류 우선 순위 (Phase 2 진입 시)

1. **finding의 path 추출** (예: `_sources["way"]` → 산문, `_sources["detailReady.curriculum"]` → array, `_sources["sidebarOrgs"]` → sidebar)
2. **영역별 fix 패턴 적용** (위 매트릭스)
3. **영역 cross-link 발생 시** (예: 산문 [N] 매핑이 array의 [N]과 충돌): 룰 J / K로 처리
4. **영역 외 fieldKey** (예: heroTags / overviewAbilities.abilityList 배열): 일반 _sources 검사 (mojibake / bracketPrefix / origin 등) 적용

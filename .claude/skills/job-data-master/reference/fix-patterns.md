# Fix Patterns — 룰별 fix 패턴 + 4단계 fallback (영역별)

> SKILL.md Phase 2 표의 확장본. 본 doc은 reference 전용 — 실행 시 룰별 fix 결정에 참고.

---

## Common helpers (모든 fix에 공유)

### body 마커 RE-INDEX

본문에서 src 1건 제거 → 후속 마커들의 number를 1씩 줄임.

```js
function reindexBody(body, removedIdx) {
  return body.replace(/\[(\d+)\]/g, (m, n) => {
    const num = parseInt(n);
    if (num < removedIdx) return m;
    if (num === removedIdx) return '';     // 제거된 마커 자체 삭제
    return `[${num - 1}]`;                 // shift
  });
}
```

여러 src 제거 시 **큰 idx부터** 적용 (작은 idx부터 적용하면 후속 idx가 shift되어 잘못된 src 제거).

### _sources 배열 RE-INDEX (field-local)

```js
function reindexSources(srcArr, removedIdx) {
  const filtered = srcArr.filter((_, i) => i !== removedIdx - 1);
  return filtered.map((s, i) => ({ ...s, id: i + 1 }));
}
```

`id`는 field-local idx (1부터). 글로벌 idx는 audit `idxGap` 룰 책임.

### 글로벌 idx 1..N 연속 강제 (idxGap fix)

```js
function reassignGlobalIds(allSources) {
  let g = 1;
  for (const fk of Object.keys(allSources)) {
    if (!Array.isArray(allSources[fk])) continue;
    for (const s of allSources[fk]) {
      s.id = g++;
    }
  }
}
```

본문 [N]은 field-local 번호이므로 글로벌 id 변경과 무관 (변경 불필요).

---

## Fix 패턴 표 (룰 × 영역)

| 룰 | 산문 필드 | detailReady array | sidebar |
|---|---|---|---|
| **origin (F)** | src REMOVE + body [N] 제거 + RE-INDEX | **4단계 fallback** (1단계 deep page 우선) | 통째 DELETE (`{delete:true}`) |
| **selfCite (F')** | src REMOVE + body [N] 제거 + RE-INDEX | 동일 | 동일 |
| **rootURL (룰 13)** | 1단계 deep page (WebFetch verify) → 실패 시 REMOVE | **4단계 fallback** | 통째 DELETE |
| **listPage (E)** | 1단계 deep article → 실패 시 REMOVE | **4단계 fallback** | 통째 DELETE |
| **wikiQuota (룰 14) >30%** | wiki src 중 cover 약한 것부터 REMOVE → ≤30% 도달 시 stop | 동일 | — |
| **sidebarSources (L)** | — | — | `{delete:true}` 통째 |
| **arrayBrokenRef (J)** | — | element 안 [N] 정정 (field-local 1..N 연속) | — |
| **orderViolation (K)** | 본문 + array 합본 첫 등장 1..N sequential 강제 | 동일 (합본 처리) | — |
| **idxGap** | 글로벌 id 1..N 연속 재할당 | 동일 | 동일 |
| **mojibake** | text/url UTF-8 재인코딩 (Node.js fetch UTF-8). 발굴 실패 시 REMOVE | 동일 | 동일 |
| **bracketPrefix** | text 시작 `[N] ` regex 제거 | 동일 | 동일 |
| **brokenRef (I)** | 마커 정정 또는 [N] 제거 | — (룰 J가 처리) | — |
| **dup** | 한 sentence 1 마커 max — 두 번째부터 제거 (또는 sentence 분리) | 동일 | — |
| **proseBodyOrphan (NEW, PR 14)** | 본문 [N] 추가 또는 _sources REMOVE — `_proseRaw` raw string 기준 | — (룰 J가 처리) | — |
| **factSourceMismatch (NEW)** | fact 정정 + 새 출처 등록 (WebSearch verified) | 동일 | — |

---

## 4단계 fallback (detailReady array 영역)

detailReady.{curriculum, recruit, training} 항목은 validate 룰 A `[UCJ각주항목누락]`로 모든 항목 [N] 필수. 단순 REMOVE 시 즉시 FAIL. 따라서:

### 1단계 — URL 교체 (선호)

1. 항목 본문 fact 추출 (예: "Unity·Unreal Engine 실습 + C++·C# 프로그래밍" — Unity 학습 path가 cover 대상)
2. WebFetch root URL → site map / 검색 / `/about` / `/news` 등에서 deep page 후보 발굴
3. deep page (path depth ≥ 2) WebFetch → fact 키워드 등장 확인
4. PASS → `_sources[idx].url`만 교체. body는 그대로. 항목 [N] 마커 유지 → UCJ PASS

```js
sources['detailReady.curriculum'] = sources['detailReady.curriculum'].map(s => {
  if (s.id === 7) return { ...s, url: 'https://learn.unity.com/pathway/junior-programmer' };
  return s;
});
// body 그대로
```

### 2단계 — 본문 fact 일반화 + url 교체

- 1단계 deep page 발굴 실패 시: 항목 본문을 더 일반적 fact로 약화 (예: "kgames.or.kr 회원사 list" → "협회 회원사 list" — 산업 표현)
- 일반화된 fact를 cover하는 deeper URL 발굴 (1단계만큼 specific X 가능)
- body 항목 1개 변경 + src url 교체. UCJ 마커 [N] 유지 → UCJ PASS
- **일반화는 정보 가치 ↓** — 1단계 시도 후만 진입

### 3단계 — 항목 merge

- 단일 항목 fact가 너무 약해서 cover URL 부재 시
- 인접 항목과 합칠 수 있다면 (같은 출처 cover 가능) 한 sentence로 merge
- _sources idx 정리 + 항목 idx RE-INDEX
- 항목 수 4 이상일 때만 권장 (3 이하면 정보 손실 임팩트 큼)

### 4단계 — 인정 + pending 기록

- src 그대로 유지 (root URL 잔존)
- 사고 인정 → `~/.claude/projects/.../memory/deck/04-pending.md`에 직업명 + 룰 + 잔존 finding 기록
- audit는 영구 FAIL N건 잔존 (게임-기획자 sal id=3 같은 패턴)
- 사용자에게 **명시 보고** + 다음 cleanup 사이클 또는 별도 enhance 사이클로 이관

---

## 룰별 상세

### `[origin]` (F) — 산문

**원칙**: origin domain은 CareerWiki가 데이터 가져오는 source. 1건이라도 즉시 FAIL.

**fix 절차**:
1. `_sources[fieldKey]` 안 origin URL 찾기
2. 같은 fact를 외부 1차 출처로 cover 가능한지 시도 (WebFetch)
3. cover 가능 → src의 url + text 교체 (host 변경)
4. cover 불가 → src REMOVE + body RE-INDEX

**예외**: 정부 부처 정책 페이지 (`*.go.kr` 정책 deep page)는 origin 아님 — `detectOriginDomain` ALLOWLIST 처리.

```js
// 예: way._sources [src1, src2(origin), src3] → [src1, src3]
//     body "[1][2][3]" → "[1][2]"
const newSources = sources.way.filter(s => s.id !== 2);
const newBody = body.way.replace(/\[2\]/g, '').replace(/\[3\]/g, '[2]');
```

### `[origin]` (F) — detailReady array

**4단계 fallback 적용** (1단계 우선). 단순 REMOVE 시 UCJ FAIL — 금지.

### `[rootURL]` (룰 13) — 산문

**원칙**: 협회/회사/학술 publisher root URL은 fact cover X. path depth ≥ 2 + WebFetch 본문 fact 등장 둘 다 만족 필수.

**fix 절차**:
1. WebFetch root URL → site map / 검색 / `/about` / `/news` 등에서 deep page 후보 발굴
2. deep page (path depth ≥ 2) WebFetch → 본문 fact 키워드 등장 확인
3. PASS → url만 교체 (text 유지). 본문 RE-INDEX 불필요
4. FAIL → src REMOVE + body `[N]` 제거 + 후속 마커 RE-INDEX

### `[rootURL]` (룰 13) — detailReady array

**4단계 fallback 적용**.

### `[listPage]` (E)

**원칙**: 검색결과/목록/카테고리 페이지는 직업-specific X. 동적 결과라 출처 무효.

**검출 패턴**: `seq=`/`SEQ=`/`jobsCd=`/`jmCd=` 식별자 미포함 + `/list`/`/category`/`/index` path. work24/worker도 list 추가 차단.

**fix 절차**:
1. WebFetch listPage URL → 본문 fact에 매핑되는 단일 article/detail page 후보 추출
2. deep article WebFetch → fact 키워드 등장 확인
3. PASS → url 교체 (text 유지)
4. FAIL → src REMOVE + body RE-INDEX

### `[wikiQuota]` (룰 14) >30%

**원칙**: wiki host (`*.wikipedia.org` / `namu.wiki` / `*.wikia.com` / `*.fandom.com`) 점유율 > 30% 즉시 FAIL.

**fix 절차**:
1. 모든 _sources field 순회하며 wiki host src 수집 + 글로벌 총수 계산
2. 현재 ratio = wikiCount / total
3. ratio > 0.3 → wiki src 중 cover 가장 약한 것부터 REMOVE
   - "약한 cover" = 일반론/정의 위키 페이지. 직업-specific 통계나 특정 인물 사건은 cover 강
4. 본문 마커 제거 + RE-INDEX
5. ratio ≤ 0.3 (또는 0.2 안전 buffer)면 stop

**예외**: total < 5 → 룰 SKIP (분모 작아 ratio 무의미).

### `[sidebarSources]` (룰 L)

**대상 fieldKey**: `sidebarOrgs`, `sidebarCerts`, `sidebarMajors`, `sidebarJobs`.

**fix**:
```js
sources: { "sidebarOrgs": { delete: true } }
fields: {}    // 본문 변경 없음 — sidebar 항목 자체는 미접촉
```

서버 side merge 정책 — 필드 명시 시 `{ delete: true }`로 키 자체 제거. 빈 배열 `[]`로 전송하면 일부 케이스에서 빈 배열로 남아 idxGap.

### `[arrayBrokenRef]` (룰 J)

**원칙**: `detailReady.{curriculum,recruit,training}` element 안 `[N]` 마커가 `_sources["detailReady.{sub}"]` 길이 초과면 broken.

**fix 절차**:
1. element[i] 안 `[N]` 마커 추출
2. `_sources["detailReady.{sub}"][N-1]` 존재 확인
3. 부재 시:
   - 해당 element가 cover하는 fact 검증해서 **올바른 idx**로 정정
   - 또는 `[N]` 마커 자체 제거
   - 또는 새 src 추가 + 본문 idx에 매핑 (단 fact-source coherence 검증 필수)

### `[orderViolation]` (룰 K)

**원칙**: 본문 `[N]` 첫 등장 순서가 1, 2, 3, ... sequential.

**fix 절차** (산문 + detailReady 합본):
```js
function fixOrderViolation(body, srcArr) {
  const firstOrder = [];
  body.replace(/\[(\d+)\]/g, (m, n) => {
    const num = parseInt(n);
    if (!firstOrder.includes(num)) firstOrder.push(num);
    return m;
  });
  // firstOrder = [3, 1, 2] 등 → 새 매핑 [3→1, 1→2, 2→3]
  const mapping = {};
  firstOrder.forEach((origIdx, newIdx) => mapping[origIdx] = newIdx + 1);
  const newBody = body.replace(/\[(\d+)\]/g, (m, n) => `[${mapping[parseInt(n)]}]`);
  const newSrc = firstOrder.map((origIdx, i) => ({
    ...srcArr[origIdx - 1], id: i + 1
  }));
  return { body: newBody, src: newSrc };
}
```

### `[selfCite]` (F') — careerwiki.org / careerwiki.kr host

**fix 절차**: src REMOVE + body RE-INDEX. origin과 동일 패턴 — host 매칭만 다름.

### `[idxGap]`

**원칙**: 글로벌 idx (모든 _sources field 합쳐서 id 1..N) 연속.

**fix 절차**:
1. 모든 _sources entry 순회하며 글로벌 id 재할당 (`reassignGlobalIds` helper)
2. 본문 [N] 마커는 field-local이라 영향 X (변경 불필요)

minimal POST 시 일부 _sources만 보내면 idxGap 발생 가능 — 변경 영역의 모든 _sources field를 함께 보내고 변경 영역만 갱신해야.

### `[mojibake]`

**fix 절차**:
1. text/url 원본을 다시 발굴 (WebFetch + 정확한 utf-8 인코딩)
2. 원본 발굴 실패 → src REMOVE
3. POST는 **반드시 Node.js fetch + UTF-8** (Windows curl 인라인 한글 절대 X)

**검출 패턴**: `�` (replacement char) 또는 한자/아랍/키릴/라틴확장 등 한글이 변환된 패턴.

### `[bracketPrefix]`

**fix 절차**: text의 시작 `[\d+]\s*` regex 매칭 → 제거.

```js
src.text = src.text.replace(/^\s*\[\d+\]\s*/, '');
```

### `[brokenRef]` (I)

**fix 절차**:
1. 마커 N의 cover 의도 확인 (어느 src를 가리키려 했는지)
2. 의도 src 존재 → N을 그 idx로 정정
3. 의도 불명/존재 X → 마커 제거

### `[dup]`

**fix 절차**: 한 sentence 1 마커 max. 두 번째부터 제거. sentence 분리가 더 적절하면 sentence를 두 개로 나눠 각각 1 마커.

### `[proseBodyOrphan]` (NEW, PR 14)

**원칙**: 산문 9 BODY_FIELDS (`way` / `summary` / `trivia` / `overviewWork.main` / `overviewProspect.main` / `overviewAbilities.technKnow` / `overviewSalary.sal` / `detailWlb.wlbDetail` / `detailWlb.socialDetail`) `_sources[fieldKey]`에 등록만 되고 본문 [N] 마커 미인용 → orphan.

**fix 절차** (옵션):
1. **본문 [N] 추가** (선호) — 의미 있는 src면 본문에 [N] 마커 추가. 단 신규 fact 추가 X — 기존 본문 안에서 cover 가능한지 검토. cover 가능 시 sentence 끝에 [N] (한 sentence 1 마커 max).
2. **src REMOVE** — 의미 없는 등록이면 _sources에서 제거 + (남은 _sources의 id 재정렬).

```js
// trivia _sources 3개 + body 0 markers 케이스:
// 옵션 1 — 본문 fact가 _sources URL을 cover하면:
fields.trivia = "<원본 trivia> [1][2][3].";    // 단, 한 sentence 3 마커는 cluster — 분리 권장
//
// 옵션 2 — _sources 통째 의미 없으면:
sources.trivia = [];   // 빈 배열 (idxGap 주의 — 다른 _sources도 동봉)
```

### `[factSourceMismatch]` (NEW)

**원칙**: 본문 fact (구체 회사명·통계·연도·금액·순위)가 출처 페이지에 직접 등장 X → mismatch.

**fix 절차**:
1. WebSearch + WebFetch로 본문 fact의 정확한 값 cross-check
2. mismatch 발견 시:
   - 본문 통계/숫자/회사명 정정 (정확한 값으로) + 새 출처 등록
   - 또는 본문 fact 일반화 (구체 → 추상)
   - 또는 fact 자체 제거

상세는 `fact-verification.md` 참조.

---

## Edge cases (cross-rule)

### 한 src가 여러 룰 위반 (origin + rootURL 동시)

origin이 우선. origin 룰 fix (REMOVE)로 처리하면 rootURL도 자동 해결.

### body 변경 없이 _sources만 변경 (sidebar DELETE 등)

minimal POST에 fields 빈 객체 (`{}`) — 정상. server side가 fields 빈 객체 = 본문 미변경으로 처리.

### body 변경하지만 _sources 변경 없음 (마커 dup 제거)

minimal POST에 sources 빈 객체 (`{}`) — 정상.

### 모든 fix가 1회 retry로도 안 풀림

STOP. 보고. 강제 진행 X. 4단계 fallback의 인정+pending이 가능하면 그렇게.

### `[idxGap]` vs minimal POST 충돌

일부 _sources만 보내면 idxGap FAIL. **회피**: 변경 영역의 모든 _sources field를 함께 보내고 변경 영역만 갱신. server-side merge 정책상 안 보내도 OK인 영역도 함께 보내는 게 안전.

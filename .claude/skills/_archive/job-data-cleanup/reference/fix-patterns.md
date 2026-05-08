# Fix Patterns — 룰별 상세 + edge cases + snippet

> SKILL.md Phase 2 표의 확장본. 본 doc은 reference 전용 — Phase 2 실행 시 룰별 fix 결정에 참고.

---

## Common helpers (모든 fix에 공유)

### body 마커 RE-INDEX

본문에서 src 1건 제거 → 후속 마커들의 number를 1씩 줄인다.

```js
function reindexBody(body, removedIdx) {
  // body 안 [N] 마커 중 N > removedIdx 인 것을 N-1로 변환
  return body.replace(/\[(\d+)\]/g, (m, n) => {
    const num = parseInt(n);
    if (num < removedIdx) return m;
    if (num === removedIdx) return '';     // 제거된 마커 자체 삭제
    return `[${num - 1}]`;                 // shift
  });
}
```

여러 src 제거 시 **큰 idx부터** 적용 (작은 idx부터 적용하면 후속 idx가 shift되어 잘못된 src 제거).

### _sources 배열 RE-INDEX

```js
function reindexSources(srcArr, removedIdx) {
  // srcArr 에서 idx 제거 + id 재할당 (1..N 연속)
  const filtered = srcArr.filter((_, i) => i !== removedIdx - 1);
  return filtered.map((s, i) => ({ ...s, id: i + 1 }));
}
```

**주의**: `id`는 field-local idx (1부터). 글로벌 idx는 audit `idxGap` 룰 책임 — Phase 2 시점에는 field 단위로 관리.

### 글로벌 idx 1..N 연속 강제 (idxGap fix)

field-local re-index 후 글로벌 id 재할당이 필요한 경우 — 모든 _sources entry를 순회하며 1..N 부여:

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

단 본문 [N] 마커는 **field-local 번호**라 글로벌 id 변경과 무관 (사고 사례: 글로벌 id 변경 후 본문 [N] 그대로 둬서 깨짐 X — 본문 [N]은 field-local).

---

## 룰별 상세

### `[origin]` (career.go.kr / work.go.kr / work24.go.kr / wagework.go.kr / job.go.kr)

**원칙**: origin domain은 CareerWiki가 데이터를 가져오는 source라 자기인용. 1건이라도 즉시 FAIL.

**fix 절차**:
1. `_sources[fieldKey]` 안 origin URL 찾기
2. 같은 fact를 외부 1차 출처로 cover 가능한지 시도 (WebFetch)
3. cover 가능 → src의 url + text 교체 (host 변경)
4. cover 불가 → src REMOVE + body RE-INDEX

**예외**: 정부 부처 정책 페이지 (`*.go.kr` 의 정책 deep page)는 origin 아님. 정확히 origin host인지 확인 — `detectOriginDomain` 검증.

**edge case**: origin URL 1개에 본문 마커 [1] 1회만 있으면 단순. 마커 [1]이 본문 여러 군데 있으면 모두 제거 + 후속 마커 shift.

```js
// 예: way._sources [src1, src2(origin), src3] → [src1, src3]
//     body "[1][2][3]" → "[1][2]"  (마커 2 제거 후 마커 3을 2로 shift)
const newSources = sources.way.filter(s => s.id !== 2);
const newBody = body.way.replace(/\[2\]/g, '').replace(/\[3\]/g, '[2]');
```

---

### `[rootURL]` (룰 13)

**원칙**: 협회/회사/학술 publisher의 root URL은 fact cover X. path depth ≥ 2 + WebFetch 본문 fact 등장 둘 다 만족 필수.

**⚠️ 영역에 따라 fix 패턴이 다르다** — 산문 필드 vs detailReady array 분류 먼저 (SKILL.md Phase 2.0).

#### 산문 필드 (`trivia`, `overviewProspect.main`, `way`, `summary`, `detailWlb.*`, `overviewWork.main`, `overviewAbilities.technKnow`)

**fix 절차**:
1. WebFetch root URL → site map / 검색 / `/about` / `/news` 등에서 deep page 후보 발굴
2. deep page (path depth ≥ 2) WebFetch → 본문 fact 키워드 등장 확인
3. PASS → url만 교체 (text 유지). 본문 RE-INDEX 불필요
4. FAIL → src REMOVE + body `[N]` 제거 + 후속 마커 RE-INDEX

#### detailReady array (`detailReady.curriculum`, `detailReady.recruit`, `detailReady.training`)

**⚠️ 단순 REMOVE 금지** — 항목이 [N] 마커를 잃으면 validate `[UCJ각주항목누락]` FAIL.

**4단계 fallback** (SKILL.md Phase 2.1 참조):

**1단계 — URL 교체 (선호)**
1. 항목 본문 fact 추출 (예: "Unity·Unreal Engine 실습 + C++·C# 프로그래밍" — Unity 학습 path가 cover 대상)
2. WebFetch root URL → site map 발굴 (예: `learn.unity.com/` → `/pathway/junior-programmer`)
3. deep page (path depth ≥ 2) WebFetch → fact 키워드 등장 확인
4. PASS → `_sources[idx].url`만 교체. body는 그대로. 항목 [N] 마커 유지 → UCJ PASS

```js
// curriculum item[1] [2] (field-local idx 2) → src id 7 url 교체
sources['detailReady.curriculum'] = sources['detailReady.curriculum'].map(s => {
  if (s.id === 7) return { ...s, url: 'https://learn.unity.com/pathway/junior-programmer' };
  return s;
});
// body 그대로
```

**2단계 — 본문 fact 일반화 + url 교체**
- 1단계 deep page 발굴 실패 시: 항목 본문을 더 일반적 fact로 약화 (예: "kgames.or.kr 회원사 list" → "협회 회원사 list" — 산업 표현)
- 일반화된 fact를 cover하는 deeper URL 발굴 (1단계만큼 specific X 가능)
- body 항목 1개 변경 + src url 교체. UCJ 마커 [N] 유지 → UCJ PASS
- **일반화는 정보 가치 ↓** — 1단계 시도 후만 진입

**3단계 — 항목 merge**
- 단일 항목 fact가 너무 약해서 cover URL 부재 시
- 인접 항목과 합칠 수 있다면 (같은 출처 cover 가능) 한 sentence로 merge
- _sources idx 정리 + 항목 idx RE-INDEX
- 항목 수 4 이상일 때만 권장 (3 이하면 정보 손실 임팩트 큼)

**4단계 — 인정 + pending 기록**
- src 그대로 유지 (root URL 잔존)
- `~/.claude/projects/.../memory/deck/04-pending.md`에 직업명 + 룰 + 잔존 finding 기록
- audit 영구 FAIL 1건. 사용자 명시 보고

**edge case**:
- **정부 부처 root** (`*.go.kr` 메인 페이지)는 룰 F (origin)가 처리. 룰 13 검출 대상 X
- **trailing slash**: `https://example.org/` 와 `https://example.org` 모두 root로 검출 (`detectRootDomainOnly`)

**snippet (산문 필드 — 직접 REMOVE)**:
```js
// rootURL → deep URL 교체 (cover 검증 PASS)
const idx = sources.way.findIndex(s => s.url === 'https://www.kgames.or.kr/');
sources.way[idx].url = 'https://www.kgames.or.kr/partnership/partner-list/';
// text 유지 — id, text 그대로
```

---

### `[listPage]` (룰 E)

**원칙**: 검색결과/목록/카테고리 페이지는 직업-specific X. 동적 결과라 출처 무효.

**검출 패턴**: `seq=`/`SEQ=`/`jobsCd=`/`jmCd=` 등 식별자 미포함 + `/list`/`/category`/`/index` path. work24/worker도 list 추가 차단.

**fix 절차**:
1. WebFetch listPage URL → 본문 fact에 매핑되는 단일 article/detail page 후보 추출
2. deep article WebFetch → fact 키워드 등장 확인
3. PASS → url 교체 (text 유지)
4. FAIL → src REMOVE + body RE-INDEX

**edge case**: list URL 1개를 deep page 1개로 1:1 매핑 어려운 경우 — fact를 1:1 cover하는 deep article 없음. 이 경우 fact 자체를 일반화하거나 (회사명 → 산업 표현) src를 통째로 제거.

---

### `[wikiQuota]` (룰 14)

**원칙**: wiki host (`*.wikipedia.org` / `namu.wiki` / `*.wikia.com` / `*.fandom.com`) 점유율 > 30% 즉시 FAIL.

**fix 절차**:
1. 모든 _sources field 순회하며 wiki host src 수집 + 글로벌 총수 계산
2. 현재 ratio = wikiCount / total
3. ratio > 0.3 → wiki src 중 cover 가장 약한 것부터 REMOVE
   - "약한 cover" = 일반론/정의 위키 페이지 (예: `위키백과 → 가수`). 직업-specific 통계나 특정 인물 사건은 cover 강
4. 본문 마커 제거 + RE-INDEX
5. ratio ≤ 0.3 (또는 0.2 안전 buffer)면 stop

**예외**: total < 5 → 룰 SKIP (분모 작아 ratio 무의미)

**edge case**:
- wiki 5건 모두 1차 출처와 매핑 안 되면 일부만 제거 후 fact를 일반화
- 1차 출처 발굴 (deep page) 가능하면 wiki를 1차로 교체 (REMOVE 후 신규 src 추가) — 단 ADD는 신규 fact 추가가 아니라 동일 fact의 더 권위 있는 cover

---

### `[sidebarSources]` (룰 L)

**원칙**: sidebar* 영역은 자체 `{name, url}` 배열로 표시되며 본문에 `[N]` 마커가 박히지 않는다. `_sources` 등록 시 글로벌 idx만 부여되고 본문 sup이 안 만들어져 orphan.

**대상 fieldKey**: `sidebarOrgs`, `sidebarCerts`, `sidebarMajors`, `sidebarJobs`.

**fix 절차**:
- `_sources[<sidebar*>]` 통째 DELETE — `{ delete: true }` merge로

```js
sources: { "sidebarOrgs": { delete: true } }
fields: {}    // 본문 변경 없음 — sidebar 항목 자체는 미접촉
```

서버 side merge 정책 — 필드 명시 시 `{ delete: true }`로 키 자체 제거. 빈 배열 `[]`로 전송하면 일부 케이스에서 빈 배열로 남아 idxGap.

**edge case**: sidebar 항목 자체에는 출처 url이 `{name, url}` 의 url 필드로 박혀있다 — 이건 미접촉.

---

### `[arrayBrokenRef]` (룰 J)

**원칙**: `detailReady.{curriculum,recruit,training}` element 안 `[N]` 마커가 `_sources["detailReady.{sub}"]` 길이를 초과하면 broken.

**fix 절차**:
1. element[i] 안 `[N]` 마커 추출
2. `_sources["detailReady.{sub}"][N-1]` 존재 확인
3. 부재 시:
   - 해당 element가 cover하는 fact를 검증해서 **올바른 idx**로 정정 (다른 N으로 변경)
   - 또는 `[N]` 마커 자체 제거
   - 또는 새 src 추가 + 본문 idx에 매핑 (단 fact-source coherence 검증 필수)

**edge case**: element가 plain string이라 idx가 없는 경우 — `_sources["detailReady.{sub}"]`는 element-level이 아닌 field-level array. element[i] body 안 [N] = `_sources["detailReady.{sub}"][N-1]` 단순 매핑.

---

### `[orderViolation]` (룰 K)

**원칙**: 본문 `[N]` 첫 등장 순서가 1, 2, 3, ... sequential이어야 한다 (예: [3]이 [2]보다 먼저 나오면 FAIL).

**fix 절차**:
1. 본문 + detailReady 항목 모두 합쳐서 `[\d+]` regex로 첫 등장 순서 추출
2. 1, 2, 3, ... 1부터 sequential하게 매핑 (예: 첫 등장 [3] → [1], 다음 등장 [1] → [2])
3. body + `_sources` 동시 RE-INDEX
4. `_sources` 배열 reorder 필요

**snippet**:
```js
function fixOrderViolation(body, srcArr) {
  const firstOrder = [];      // first appearance order of original idx
  body.replace(/\[(\d+)\]/g, (m, n) => {
    const num = parseInt(n);
    if (!firstOrder.includes(num)) firstOrder.push(num);
    return m;
  });
  // firstOrder = [3, 1, 2] 등 → 새 매핑 [3→1, 1→2, 2→3]
  const mapping = {};
  firstOrder.forEach((origIdx, newIdx) => mapping[origIdx] = newIdx + 1);
  // body 변환
  const newBody = body.replace(/\[(\d+)\]/g, (m, n) => `[${mapping[parseInt(n)]}]`);
  // srcArr reorder
  const newSrc = firstOrder.map((origIdx, i) => ({
    ...srcArr[origIdx - 1], id: i + 1
  }));
  return { body: newBody, src: newSrc };
}
```

---

### `[selfCite]` (룰 F')

**원칙**: `careerwiki.org` / `careerwiki.kr` host는 자기인용. 의미 없음 + 출처로 무효.

**fix 절차**: src REMOVE + body RE-INDEX.

origin과 동일 패턴 — host 매칭만 다름.

---

### `[idxGap]`

**원칙**: 글로벌 idx (모든 _sources field 합쳐서 id 1..N) 연속.

**fix 절차**:
1. 모든 _sources entry 순회하며 글로벌 id 재할당 (`reassignGlobalIds` helper)
2. 본문 [N] 마커는 field-local이라 영향 X (변경 불필요)

minimal POST 시 일부 _sources만 보내면 idxGap 발생 가능 — 변경 영역의 모든 _sources field를 함께 보내고 변경 영역만 갱신해야.

---

### `[mojibake]`

**원칙**: text/url에 `�` (U+FFFD) 또는 CP949 깨진 패턴 금지.

**fix 절차**:
1. text/url 원본을 다시 발굴 (WebFetch + 정확한 utf-8 인코딩)
2. 원본 발굴 실패 → src REMOVE
3. POST는 **반드시 Node.js fetch + UTF-8** (Windows curl 인라인 한글 절대 X)

**검출 패턴**: `�` (replacement char) 또는 한자/아랍/키릴/라틴확장 등 한글이 변환된 패턴.

---

### `[bracketPrefix]`

**원칙**: `_sources[*].text` 시작에 `[N] ` prefix 금지. text는 기관명만.

**fix 절차**: text의 시작 `[\d+]\s*` regex 매칭 → 제거.

```js
src.text = src.text.replace(/^\s*\[\d+\]\s*/, '');
```

---

### `[brokenRef]` (룰 I)

**원칙**: 본문 `[N]` 마커 N이 `_sources[fieldKey].length`를 초과.

**fix 절차**:
1. 마커 N의 cover 의도 확인 (어느 src를 가리키려 했는지)
2. 의도 src 존재 → N을 그 idx로 정정
3. 의도 불명/존재 X → 마커 제거

**edge case**: 마커 [5]가 있는데 `_sources["way"]` 길이가 3 → 3, 4, 5 모두 broken 가능. 사실관계 cover하는 src 발굴 + 추가 또는 마커 제거.

---

### `[dup]`

**원칙**: 본문 같은 `[N]` 마커가 한 sentence 안에 2회 이상.

**fix 절차**: 두 번째부터 제거. sentence 분리가 더 적절하면 sentence를 두 개로 나눠 각각 1 마커.

---

### `[orphan]` (룰 H, 보통 WARN — cleanup 대상 X)

**원칙**: `_sources[fieldKey][i]`가 등록만 되고 본문에서 [N] 마커로 인용 안 됨.

**fix 절차** (cleanup 시):
1. 의미 있는 src면 본문에 [N] 마커 추가 (단 신규 fact 추가 X — 기존 본문 안에서 cover 가능한지)
2. 의미 없으면 src REMOVE

**보통은 WARN이라 cleanup이 적극 처리하지 않음** — orphan만 단독으로는 audit FAIL이 되지 않으므로.

---

## Edge cases (cross-rule)

### 한 src가 여러 룰 위반 (origin + rootURL 동시)

origin이 우선. origin 룰 fix (REMOVE)로 처리하면 rootURL도 자동 해결.

### body 변경 없이 _sources만 변경 (sidebar DELETE 등)

minimal POST에 fields 빈 객체 (`{}`) — 정상. server side가 fields 빈 객체 = 본문 미변경으로 처리.

### body 변경하지만 _sources 변경 없음 (마커 dup 제거)

minimal POST에 sources 빈 객체 (`{}`) — 정상.

### 모든 fix가 1회 retry로도 안 풀림

STOP. 보고. 강제 진행 X.

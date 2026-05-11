# Enhance Strict Rules — 출처·사실성 철칙 + 핵심 기술 규칙 표 + 필드별 판단 원칙

> archive `job-data-enhance/SKILL.md` L17-101 본문 그대로 통합 (2026-05-09 master 통합).
> ENHANCE 모드 (마커 미보유 신규 직업 + `--force-enhance`) 진입 시 반드시 숙지.

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
| 검색결과 페이지 URL 금지 | `_sources` URL로 동적 검색결과 페이지(예: `work24.go.kr/wk/a/b/1200/retriveDtlEmpSrchList.do`, `worker.co.kr/job/list.asp`) 사용 금지 — 검색 조건에 따라 결과가 달라지는 페이지는 출처로 부적합. **고정된 상세 페이지 URL만 사용** |
| **`sidebar*` `_sources` 등록 금지** ⚠️ (2026-05-06) | `sidebarCerts` / `sidebarOrgs` / `sidebarMajors` / `sidebarJobs` 어느 것도 `_sources`에 등록 금지. 본문에 `[N]` 마커가 박히지 않는 영역(자체 `{name, url}` 객체 배열로 표시)이라 `_sources` 등록 시 글로벌 idx만 부여되고 본문 sup이 안 만들어져 **orphan 발생**. URL은 sidebar 항목 자체 `url` 필드에만 |
| **`_sources[*].text` 필드 형식** ⚠️ | **반드시 기관명만**. raw URL 절대 금지·`[N]` 마커 prefix 절대 금지. 정답: `{"text":"한국직업능력연구원","url":"https://www.krivet.re.kr"}`. validate-job-edit.cjs가 [출처형식]·[출처마커prefix]로 차단 |
| **`_sources` mojibake 금지** ⚠️ | `text`/`url`/본문 어디든 `�` (U+FFFD replacement char) 또는 CP949 깨짐 패턴 금지. 원인: Windows curl POST body 인코딩 사고. **반드시 Node.js fetch + UTF-8 JSON.stringify로 전송**. validate-job-edit.cjs `[Mojibake]`로 차단 |
| **본문 [N] 마커 ↔ _sources 매핑 필수** ⚠️ | way/trivia/prospect/detailReady 등 본문에 `[1][2]` 마커가 있으면 반드시 동일 필드의 `_sources[fieldKey]` 배열에 같은 개수의 entry 존재. validate `[출처]` 룰로 차단되지만 Phase 2 단축 시 우회됨 → **Phase 2 validate 호출 필수** |
| `detailReady.researchList` 수정 금지 | CareerNet 원본 데이터 필드. **스킬이 추가/수정/삭제 금지**. 출처 각주도 달지 않음. 해당 필드가 draft에 포함되면 validate-job-edit.cjs가 **FAIL** 처리 |
| `detailReady.certificate` 본문 추천 자격증 금지 | enhance 스킬은 **본문 추천 자격증을 추가/수정하지 않음**. 추천 자격증 보강은 `sidebarCerts`에서만 수행. 기존 본문 certificate에 출처가 없으면 cleanup 대상으로 보고 제거 검토 |
| 출처 배지 카운트 | 배지 숫자 = API 출처(커리어넷 1개) + 사용자 추가 출처. 스킬은 배지 카운트에 신경 쓸 필요 없음 (렌더러가 자동 계산) |
| 편집 API URL | `POST https://careerwiki.org/api/job/{id}/edit` |
| 직업 페이지 URL | `https://careerwiki.org/job/슬러그` (`.kr` 또는 `/jobs` 절대 금지) |
| R2 이미지 키 | `jobs/job-{slug}.webp` — `uploads/` prefix 절대 금지 |
| DB image_url | `/uploads/jobs/job-{slug}.webp?v={timestamp}` |
| 인증 헤더 | `-H "X-Admin-Secret: careerwiki-admin-2026"` |
| 배포 | **반드시 main 브랜치** — worktree에서 배포하면 다음 main 배포 시 롤백됨 |
| DB 명령 | `npx wrangler d1 execute careerwiki-kr --remote --command "SQL문"` |
| 프로젝트 경로 | `C:\Users\user\Careerwiki` |
| `career_tree_job_links.stage_index` | **입직 스테이지에만 설정** — `order` 기준 sorted 배열의 마지막 스테이지(거장·회장·전직) 금지. `job_slug`는 해당 직업에 처음 진입하는 스테이지에만 설정. 마지막 스테이지에 설정 시 validate `[careerTree-자기강조]` FAIL |
| `career_tree_job_links` 중복 금지 | 같은 career_tree_id + job_slug 조합이 2개 이상이면 `[careerTree-자기강조]` FAIL — 반드시 하나만 존재 |
| `_youtubeSearchNote` | youtubeLinks를 빈 배열 `[]`로 제출할 때 **필수** — 탐색어 ≥6개 OR 카테고리(현직자·인터뷰/직무·실무/강의·교육/진로·면접) ≥3개 커버 필수. 미달 시 `[YouTubeNote얕음]` FAIL |
| `_careerTreeNote` | careerTree를 `null`로 제출할 때 **필수** — 후보 ≥5명(이름(이유) 형식) OR 카테고리(재벌·대기업/컨설팅/공공·정부/학계·연구/스타트업·CxO) ≥3개 커버. 미달 시 `[CareerTreeNote얕음]` FAIL |
| **UCJ 배열 각주 필수** | `detailReady.{curriculum,recruit,training}` 각 항목에 `[N]` 필수. 누락 시 `[UCJ각주항목누락]` FAIL. **`detailReady.researchList`는 CareerNet 원본 — 각주 면제** |
| **한글 인코딩 — Mojibake 금지** | API 전송 시 **Node.js `fetch()` 필수** — Windows `curl -d`로 한글 JSON 전송 시 CP949 인코딩 오류로 한글이 아랍·키릴·라틴확장 문자로 깨짐. validate `[Mojibake]` FAIL, audit `[Gate5/Mojibake]` FAIL |
| **🚫 자기 사이트 인용 절대 금지** ⚠️ | `_sources`의 URL host에 `careerwiki.org` / `careerwiki.kr` 포함 금지 — 자기 사이트를 출처로 쓰는 것은 의미 없음. validate `[selfDomain]` FAIL |
| **🚫 origin 도메인 절대 금지** ⚠️ | `career.go.kr` / `work.go.kr` / `work24.go.kr` / **`wagework.go.kr`** ⚠️ / `job.go.kr` 및 `.go.kr` + 직업정보 path keyword (job/career/work/wage/employ) 는 CareerWiki가 직접 데이터를 가져오는 **데이터 origin**이다. **_sources에 1건이라도 있으면 즉시 FAIL**. validate `[originDomain]` FAIL |
| **🚫 list-page URL 출처 금지** ⚠️ | `_sources` URL은 반드시 직업 specific 식별자(`seq=`/`SEQ=`/`jobsCd=`/`jmCd=` 등)를 포함해야 함. 인덱스/카테고리 페이지는 `/list`/`/category`/`/index` 끝 path 차단. validate `[listPageURL]` FAIL |
| **본문 [N] = field-local 번호** ⚠️ | 본문 `[N]`은 항상 **필드별 1부터 시작하는 로컬 번호**다. 렌더러가 `_sources[fieldKey][N-1]`로 매핑 후 footnoteMap을 통해 글로벌 번호로 변환. **본문 [N] = _sources[fieldKey] 배열의 (N-1)번째 항목**. _sources의 글로벌 `id` 필드는 페이지 통합 출처 카운트용일 뿐 본문 매핑과 무관 |
| **brokenRef 금지** | 산문 필드 본문에 `[N]` 마커가 있는데 `_sources[fieldKey]` 길이가 N보다 작으면 매핑 실패. validate `[brokenRef]` FAIL. 본문 마커는 1..N 연속 필수 |
| **orphanSrc 자제** | `_sources[fieldKey]`에 등록만 하고 본문에서 `[N]` 마커로 인용하지 않으면 의미 없음 — validate `[orphanSrc]` WARN. 등록한 모든 출처를 본문에서 1회 이상 인용하거나 _sources에서 제거 |
| **🚫 sourcesWithoutMarkers (룰 ZZZ, 2026-05-11)** ⚠️ | 산문 8 영역 (`way` / `overviewProspect.main` / `trivia` / `detailWlb.wlbDetail` / `detailWlb.socialDetail` / `overviewWork.main` / `summary` / `overviewAbilities.technKnow`) 본문 100자+ AND `_sources[field]` URL 1+ 인데 본문에 `[N]` 마커 0개 → **FAIL**. 출처를 등록했으면 본문에 반드시 [N] 박혀야 함. fact 미등장이면 출처 부적격(제거). audit `sourcesWithoutMarkers(N: field(bodyLen/srcsCount))` FAIL. 경찰관 사고 (2026-05-11) 후속 |
| **🚫 orphanSources (룰 ZZZZ, 2026-05-11)** ⚠️ | `_sources` fieldKey 중 본문이 _proseRaw에도 detailReady에도 API top-level에도 없거나 trim 후 50자 미만인 영역에 출처 등록 → **FAIL**. 차단 정책: **존재하지 않는 fieldKey에 _sources 등록 금지** (예: detailGrowth.growth / detailWork.workDetail 영역은 master skill이 작성 대상 아니면 _sources 키 자체 생성 X). audit `orphanSources(N: field[area/srcs])` FAIL. area: `body-missing` / `body-too-short` / `detailReady-empty`. 경찰관 사고 (2026-05-11) 후속 |

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
   → "보강 가능" (sidebarCerts/sidebarMajors/overviewProspect.main)
      → API 충분하면 스킵, 부족하면 보강
   → "절대 수정 금지" (overviewSalary — sal/wage/wageSource 포함)
      → 스킬이 overviewSalary를 포함한 draft 전송 시 validate [sal-수정금지] FAIL
   → "API에 있으면 스킵" (overviewWork.main/overviewAbilities.technKnow/detailWlb.wlb 등)
      → API 있으면 스킵, null이면 리서치하여 채움
   → "공식 통계만 허용" (abilityList/aptitude/satisfaction/educationDistribution 등)
      → 공식 통계 있으면 채움, 없으면 null 유지 (추정값 절대 금지)

⚠️ 마이너 직업은 API 데이터가 대부분 비어있을 수 있다. "스킵" 판단 전 실제 데이터 유무 확인.
```

**4 카테고리 판단 매트릭스**:

| 카테고리 | 대상 필드 | 행동 |
|----------|----------|------|
| **항상 새로 작성** | way, detailReady, trivia, wlbDetail, socialDetail, 커리어트리 | API 데이터와 무관하게 반드시 작성 |
| **보강 가능** | sidebarCerts, sidebarMajors, prospect | API 충분→스킵, 부족→보강 |
| **🔒 절대 수정 금지** | overviewSalary (sal/wage/wageSource) | 스킬에서 절대 건드리지 않음 — validate FAIL |
| **API 있으면 스킵** | overviewWork.main, technKnow, wlb/social 등급 | API null이면 리서치+출처 필수로 채움 |
| **공식 통계만** | abilityList, aptitude, educationDistribution, detailIndicators | 출처 없으면 **null 유지** — 추정값 절대 금지 |

> **빈 칸이 거짓 정보보다 100배 낫다** — 공식 통계 전용 필드에 AI 추정값 넣으면 사용자에게 거짓 수치 제공.

---

## 출처 수집 규칙

**핵심 원칙**: 출처 수가 아니라 **정보 퀄리티(최신성·디테일)**가 목적. 다양한 출처는 다양한 관점의 디테일을 얻기 위한 수단.

**우선순위:**

🚨 **절대 금지 (origin 도메인 — _sources에 1건이라도 있으면 validate `[originDomain]` FAIL)**:
- `career.go.kr` (커리어넷)
- `work.go.kr` (워크넷 구버전)
- `work24.go.kr` (고용24)
- `wagework.go.kr` (한국노동연구원 임금직업정보 / 워크피디아)
- `job.go.kr` (직업포털)
- 기타 `.go.kr` 도메인 중 path에 `job` / `career` / `work` / `wage` / `employ` 키워드 포함 시 origin 후보로 자동 검출

❌ **자기 사이트 인용 절대 금지**:
- `careerwiki.org` / `careerwiki.kr` (validate `[selfDomain]` FAIL)

✅ **1등급 (외부 핵심 — 적극 활용)**:
- 한국고용정보원 (keis.or.kr) — 직업전망보고서
- 한국직업능력연구원 (krivet.re.kr) — 훈련·자격
- KOSIS (kosis.kr) — 통계청 통계
- Q-Net (q-net.or.kr) — 자격증
- 한국산업인력공단 (hrdkorea.or.kr)
- 정부 부처 정책 페이지 (moel.go.kr/policy/..., mohw.go.kr/policy/... 등 직업정보 path 아닌 정책 페이지)
- 협회·학회 공식 사이트 (한국간호협회 kna.or.kr, 한국변호사협회 koreanbar.or.kr 등)
- 대학 학과 소개 페이지

✅ **2등급 (적극 활용 권장)**:
- 업계 보고서, 통계청 별도 페이지, 전문 미디어 (한경 hankyung.com, 매경 mk.co.kr, IT조선 it.chosun.com 등)
- 학술논문 (RISS, KISS, DBpia)
- ⚠️ 단, 블라인드 / 디시인사이드 / 개인 블로그 단독 출처 금지

**출처 다양화 원칙**: 커리어넷/고용24/워크넷은 API로 이미 가져온 데이터와 중복될 수 있음. 업계 보고서, 학회 자료, 전문 미디어(신문/뉴스), 통계청, 직업 관련 전문 사이트 등 고급 출처를 적극 활용. 동일 내용이면 더 최신이고 신뢰도 높은 출처 우선 선택.

**필드 간 출처 재사용 지양 원칙**: 동일 출처(같은 URL)를 여러 필드에 걸쳐 반복 사용하는 것을 최대한 지양한다. 가능하면 각 필드(way, trivia, overviewProspect.main 등)마다 해당 내용에 더 적합한 별도 출처를 찾아서 사용한다. 부득이하게 동일 URL을 여러 필드에 쓰는 것은 허용되지만, 같은 필드 내 sources 배열에 동일 URL을 2번 이상 등록하는 것은 validate FAIL이므로 절대 금지.

**리서치 탐색 범위**: 커리어넷·워크넷 외에도 아래를 적극 탐색:
- 해당 직업 관련 **협회·단체 공식 사이트** (예: 한국간호협회, 한국건축사협회)
- 관련 **정부부처·공공기관** 공식 통계/보고서 (고용부, 복지부, 교육부 등)
- 업계 **언론 기사** (한겨레, 중앙, 한경, 매경 등 — 발행일 확인 필수)
- **학회지·학술논문** (RISS, KISS, DBpia 등)
- **통계청** KOSIS 통계

**리서치 금지 사항**:
- **없는 내용을 지어내거나 출처를 조작 금지** — 반드시 WebFetch로 해당 URL에서 해당 수치/사실이 실제로 존재하는지 확인 후 사용
- **같은 URL을 하나의 필드 sources에 2번 이상 등록 금지** — 동일 필드 내 같은 URL 중복은 validate FAIL
- **sources.text 필드에 URL 포함 금지** — `"[1] 커리어넷"` (O) / `"[1] https://career.go.kr/..."` (X) — text는 기관명만
- **외부 출처 다양성 권장** — 한 직업 _sources에 외부 host 1개만 있으면 WARN. 2개 이상 외부 host 권장 (협회·KOSIS·전문 미디어 등 분산)

### 커리어넷 URL (신형만 사용)

```
https://www.career.go.kr/cloud/w/job/view?seq={job_cd}   ← 반드시 이 형식
```

구버전(`/cnet/front/base/job/jobView.do`) 사용 금지 — 링크가 깨지는 경우 있음.

### 저작권 원칙 (비공공 출처 사용 시)

- CC/공공누리 표시 → 사용 가능
- "무단전재 금지" → 수치/사실만 **자체 문장으로 재작성** (원문 복사 금지)
- 크롤링 금지/유료 → 사용 금지
- 어떤 출처든 **원문 그대로 복사 금지**

### 출처 URL 유효성 규칙 (제출 전 필수 확인)

- 출처 URL은 반드시 실제로 해당 내용을 보여주는 페이지여야 한다 — 메인 페이지, 빈 검색폼, JS만 로딩되는 동적 페이지는 부적합
- 채용 관련 sources URL: **검색결과 페이지 URL 전면 금지**. 사람인/잡코리아/고용24/건설워커 등의 검색결과 페이지는 사용하지 않는다. 기관 공식 채용공고 페이지, 회사 채용 페이지, 구체적 직업 상세 페이지처럼 고정된 URL만 사용
- `https://www.work24.go.kr/` (고용24 메인), `https://www.worker.co.kr/` (건설워커 메인) 단독도 채용 출처로 부적합 — 메인 페이지를 recruit 출처로 쓰지 않는다
- WebFetch로 후보 URL에 직접 접속해 실제 채용공고 목록 또는 관련 내용이 노출되는지 확인 후 사용
- 접근 불가(TLS 오류, 연결 거부) 또는 빈 페이지이면 다른 URL로 대체 (recruit.hdec.kr 등 JS 동적 로딩 사이트 주의)

### 출처-텍스트 일치 원칙 (recruit 필드 특히 중요)

- **출처는 진실의 원천이다**: recruit 텍스트 설명과 _sources URL이 가리키는 실제 페이지 내용이 반드시 일치해야 한다.
- 불일치 발견 시 **텍스트를 출처 실제 내용에 맞게 조정**하는 것이 원칙 (출처 내용이 기준).
- 출처 URL에 실제로 없는 특정 회사명·부서명·자격요건을 텍스트에 기재 금지.
  - 예: worker.co.kr 메인이 "삼성물산 상품개발팀 신입공채"를 뒷받침하지 못함 → 텍스트를 "건설워커를 통해 대형 건설사 ~부서 채용공고 검색 및 지원"으로 일반화
  - 예: 잡코리아 "건설재료연구원" 검색에 한국도로공사 도로교통연구원 공고 없음 → 텍스트를 실제 검색결과에 나오는 기관명으로 수정
- 검색결과 URL은 텍스트를 아무리 일반화해도 출처로 쓰지 않는다. 고정 URL을 찾지 못하면 해당 recruit 항목은 추가하지 않는다.

---

## 무출처 문장 발견 시 처리 절차 (절대 바로 제거 금지)

무출처 문장([N] 각주가 없는 서술 문장)을 발견했을 때 반드시 아래 순서를 따른다:

1. **바로 앞 [N] 출처 확인**: 해당 문장 바로 앞에 있는 [N]의 출처 URL을 WebFetch로 방문하여, 해당 문장 내용이 같은 출처에 포함되어 있는지 확인
2. **같은 출처 범위이면 → [N] 이동**: [N] 마커를 해당 문장 끝으로 이동 (출처 범위 확장)
3. **같은 출처가 아니면 → 다른 출처 탐색**: merged_profile_json 원문, 공식 사이트 등에서 해당 내용의 출처를 찾음
4. **새 출처 확인되면 → [N+1] 추가**: _sources에 새 출처 등록, 문장 끝에 새 각주 추가
5. **어디서도 확인 불가일 때만 → 제거**: 출처를 찾을 수 없는 경우에만 문장 제거

⚠️ 출처 확인 없이 바로 제거하는 것은 금지. 유용한 정보가 출처만 빠진 채 삭제될 수 있음.

---

## 기존 데이터 수정·대체 금지 원칙

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

---

## 🔒 prospect(전망) 필드 원문 보존 규칙 (특별 강조)

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

---

## 최신 데이터 우선 규칙

**동일 출처에 연도별 데이터가 여러 개 있으면 반드시 가장 최신 연도를 사용.**

- ✅ 2023년 통계 vs 2019년 통계 → **2023년 선택**
- ❌ 오래된 연도 데이터를 "있으니까" 사용하는 것 금지

**출처 발행 연도가 현재 기준 3년 이상 오래된 경우**: 본문에 `(YYYY년 기준)` 명시.

- ✅ `"2021년 기준 평균 연봉은 6,500만 원이다.[1]"` — 2024년 기준 3년차라면 연도 표기
- 단, 커리어넷·워크넷의 기본 직업 소개 텍스트는 연도 무관하게 사용 가능 (정적 정보)

---

## 기존 콘텐츠 보존 규칙 (F3)

**새 내용을 추가하거나 수정할 때, 기존 UCJ에 있던 내용이 새 내용과 겹치지 않으면 기존 내용을 유지하면서 새 내용을 append해야 한다. 기존 내용을 새 내용으로 통째로 대체하지 않는다.**

| 상황 | 행동 |
|------|------|
| 기존 UCJ 필드가 있고 새 내용과 겹침 | 최신 내용 우선, 중복 제거 |
| 기존 UCJ 필드가 있고 새 내용과 겹치지 않음 | **기존 내용 유지 + 새 내용 append** |
| 기존 UCJ 필드가 없음 | 새 내용으로 채움 |

이 규칙은 **모든 필드**에 적용 (way, trivia, detailReady 배열 등 포함).

---

## 차단 사이트 접근 폴백 체인

한국 공공기관·공기업 사이트(.go.kr, .or.kr 등)가 WebFetch에서 egress 차단되는 경우가 잦다. 꼭 필요한 1차 출처면 다음 순서로 시도:

1. **WebFetch 직접** — 가장 저렴. 막히면 다음.
2. **Jina Reader 경유** — `https://r.jina.ai/https://TARGET_URL` 로 WebFetch.
3. **Wayback Machine** — `https://web.archive.org/web/2025/URL` 로 WebFetch (오래된 자료 한정).
4. **WebSearch** — 기관명·URL 패턴·일부 본문 추출.
5. **Chrome MCP** — 본 worktree 환경에서는 사용 X (테스트 룰 명시).
   - **naked 도메인 거부 시 www 서브도메인 시도** (komcc.or.kr 사례: naked는 ERR_CONNECTION_REFUSED, www는 정상)

**토큰 효율 순위**: WebFetch > WebSearch > Jina Reader > Wayback Machine

**출처 품질**: 공식 협회·정부 사이트 > 자격증넷/블로그/크롤러 2차 사이트. 차단되더라도 1차 출처를 우선 시도하고, 폴백 모두 실패 시에만 2차 출처로 대체.

---

## __SOURCE_FIELD_MAP__ 등록 필수 (리스트 필드 각주 렌더링)

리스트 배열 필드(curriculum, recruit, training, certificate, researchList 등)는 `formatRichText` 인라인 각주가 아닌 클라이언트 JS가 heading에 동적으로 각주를 붙이는 방식이다. 이를 위해 `src/templates/unifiedJobDetail.ts`의 `window.__SOURCE_FIELD_MAP__`에 해당 fieldKey가 등록되어 있어야 한다. **미등록 필드에 sources를 저장하면 heading 각주가 렌더링되지 않는다.**

현재 등록된 리스트 필드: `detailReady.curriculum`, `detailReady.recruit`, `detailReady.training`, `detailReady.researchList`, `detailReady.certificate`, `sidebarJobs`, `sidebarMajors`.

새로운 리스트 필드에 sources를 추가할 경우 반드시 `__SOURCE_FIELD_MAP__`에도 매핑을 등록해야 한다.

---

## See Also

- `enhance-fields-spec.md` — 12 필드 상세 spec
- `enhance-phase-procedures.md` — Phase 0-PRE / 0-MODE / 0-DIAG / 2 4 게이트 / 3.5 / 5-DEDUP / 5-AUDIT / 4-MARKER / 5-VERIFY / END_TRACKING
- `safety-rules.md` — 15 안전 룰 + sal/careerTree 보호
- `fact-verification.md` — 본문 fact 정확성 검증
- `fix-patterns.md` — 룰별 fix 패턴 + 4단계 fallback
- `_archive/job-data-enhance/SKILL.md` — 본 doc의 원본 (archive 보존)

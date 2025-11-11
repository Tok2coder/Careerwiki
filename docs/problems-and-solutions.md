## 문제 / 해결 기록

프로젝트 진행 중 발생했던 주요 이슈와 해결 방법을 정리한 문서입니다. 신규 이슈가 해결될 때마다 이 문서를 갱신해 주세요.

---

### 2025-11-11 · 직업명이 ID 코드(K000000847)로 표시되는 문제

- **현상**  
  `http://localhost:3000/job/기업고위임원` 페이지에서 직업명이 "기업고위임원" 대신 "K000000847" (고용24 직업 코드)로 표시되었습니다. 페이지 제목과 탭 제목 모두 ID로 표시되었습니다.  
  흥미롭게도 `http://localhost:3000/job/변호사` 등 다른 직업 페이지는 정상적으로 이름이 표시되었습니다.

- **원인**  
  고용24 API에서 제공하는 "기업고위임원" 직업 데이터(`summary` 객체)의 `jobNm` 필드가 빈 문자열(`''`)로 되어 있었습니다.  
  `src/api/goyong24API.ts`의 `normalizeGoyong24JobDetail()` 함수에서 `extractJobTitle(summary) || summary.jobCd`로 fallback을 설정했는데, `extractJobTitle()`이 빈 문자열을 반환하면 즉시 `summary.jobCd`로 넘어가게 되어 있었습니다.  
  반면, 다른 직업들은 `jobNm`이 정상적으로 제공되거나 CareerNet 데이터가 우선 적용되어 문제가 없었습니다.

- **진단 절차**  
  1. `scripts/checkJobFields.tsx`를 실행하여 병합된 profile의 `name` 필드가 `K000000847`로 저장되어 있음을 확인했습니다.  
  2. `scripts/inspectGoyongData.tsx`로 고용24 원본 API 데이터를 확인한 결과, `summary.jobNm`이 빈 문자열(`''`)임을 발견했습니다.  
  3. 고용24 API 데이터에는 `jobNm` 대신 `jobSmclNm`(소분류명), `jobMdclNm`(중분류명), `jobLrclNm`(대분류명) 등 분류 필드에 실제 직업명이 들어 있었습니다.  
  4. ISR 캐시를 확인한 결과, 변호사는 이전 버전(v4)에서 캐시되어 정상 이름이 유지되었고, 기업고위임원은 최근(04:51)에 캐시되어 버그가 반영된 상태였습니다.

- **해결**  
  1. `src/api/goyong24API.ts` 수정  
     - `normalizeGoyong24JobDetail()` 함수의 `jobTitle` 추출 로직을 강화했습니다.  
     - 기존: `extractJobTitle(summary) || summary.jobCd`  
     - 수정: `extractJobTitle(summary) || summary.jobNm || summary.jobSmclNm || summary.jobMdclNm || summary.jobLrclNm || summary.jobCd`  
     - 이제 `jobNm`이 비어 있어도 분류 필드들을 순차적으로 시도하여 가장 구체적인 직업명을 추출합니다.
  
  2. ISR 캐시 무효화  
     - 기존 v4 캐시를 D1에서 직접 삭제했습니다 (`DELETE FROM wiki_pages WHERE slug = '기업고위임원'`).  
     - `src/constants/template-versions.ts`의 `JOB` 버전을 **4 → 5**로 증가시켰습니다.

- **검증**  
  - 서버 재시작 후 `http://localhost:3000/job/기업고위임원`을 새로고침하여 직업명이 **"기업고위임원"**으로 정상 표시되는지 확인합니다.  
  - 페이지 제목과 브라우저 탭 제목 모두 "기업고위임원 - Careerwiki" 형태로 표시되는지 확인합니다.  
  - 디버그 모드(`?debug=true`)에서 병합된 profile의 `name` 필드가 올바른지 검증합니다.

- **재발 방지 가이드**  
  - 고용24 API 데이터 구조는 필드명이 직관적이지 않으므로, 새로운 필드를 매핑할 때는 실제 API 응답 데이터를 먼저 확인합니다.  
  - 직업/전공명 추출 로직에는 항상 여러 단계의 fallback을 설정하여 빈 값에 대비합니다.  
  - 템플릿이나 데이터 변환 로직을 수정한 경우, 반드시 템플릿 버전을 올리고 ISR 캐시를 확인합니다.

---

### 2025-11-11 · 직업 상세 페이지에 출처가 1개만 표시되던 문제

- **현상**  
  `http://localhost:3000/job/기업고위임원` 페이지에서 “데이터 출처” 배지가 항상 `1개 출처`로 표시되었고, 디버그 모드에서는 “고용24 API 응답 없음”으로 표기되었습니다.

- **원인**  
  D1에는 동일한 직업명이 서로 다른 소스(CareerNet, 고용24)로 저장되어 있는데, `/job/:slug` 라우트가 D1에서 ID `238`(CareerNet) 레코드만 조회한 뒤 그대로 캐시해 버렸습니다.  
  캐시 생성 시점에는 고용24 데이터를 찾지 못해 병합 결과가 “커리어넷 1개”로 확정되었고, 이후 ISR 캐시가 계속 재사용되면서 문제가 지속되었습니다.

- **진단 절차**  
  1. `scripts/checkJobD1.tsx` 를 이용해 `jobs` 테이블을 확인한 결과, `기업고위임원` 이름으로 CareerNet/고용24 레코드가 각각 존재함을 확인했습니다.  
  2. `getUnifiedJobDetailWithRawData()` 를 직접 호출해 보니, `id='기업고위임원'`일 때는 두 소스가 모두 병합되지만, `id='238'`로 호출하면 CareerNet만 남는 것을 확인했습니다.  
  3. 서버 로그에서 ISR 캐시가 ID `238`을 기준으로 생성되어 이후에도 같은 결과를 반환하고 있음을 확인했습니다.

- **해결**  
  1. `src/services/profileDataService.ts`  
     - D1에서 단일 레코드만 반환된 경우에도, **같은 이름을 가진 다른 레코드를 추가로 탐색**하여 비어 있는 소스 데이터를 자동으로 채우도록 로직을 보강했습니다.  
     - 동일한 이름을 가진 형제 레코드를 순회하며 `careernet_id` 또는 `goyong24_id`가 있는 경우 JSON을 파싱해 병합에 포함합니다.
  2. `src/constants/template-versions.ts`  
     - `JOB` 템플릿 버전을 **3 → 4**로 증가시켜 기존 ISR 캐시를 모두 무효화했습니다.

- **검증**  
  - 서버 재시작 후 `http://localhost:3000/job/기업고위임원`을 새로고침하여 “데이터 출처” 배지가 **`2개 출처`** 로 표시되는 것을 확인했습니다.  
  - 로그에 `[ISR Cache MISS]`, `커리어넷 데이터 수집 완료`, `고용24 데이터 수집 완료`, `D1 병합 완료` 메시지가 순차적으로 출력되는지를 확인했습니다.  
  - 브라우저 개발자 도구에서 `X-Template-Version: 4`, `X-Cache-Status: MISS` 응답 헤더를 확인했습니다.

- **재발 방지 가이드**  
  - 새로운 직업 데이터를 시딩할 때 동일 명칭이 복수 소스에 존재하는지 확인하고, 테스트 시 `slug`뿐 아니라 실제 D1 ID로도 접근하여 병합 결과를 점검합니다.  
  - 병합 로직을 수정한 경우 반드시 템플릿 버전을 올려 기존 ISR 캐시가 남지 않도록 합니다.

---

### 2025-11-06 · JavaScript 403 Forbidden (직업 상세 탭 전환 실패)

- **현상**  
  Cloudflare Workers 환경에서 정적 자바스크립트 파일이 차단되어 직업/전공 상세 페이지의 탭 전환이 작동하지 않았습니다.

- **원인**  
  `serveStatic` 미들웨어가 와일드카드(`*.js`) 경로를 지원하지 않는데, 빌드 파이프라인이 JS 번들 파일을 `/public/js/*.js` 형태로 배치하고 있었습니다.

- **해결**  
  - 모든 자바스크립트 번들을 `/public/static/` 경로로 이동했습니다.  
  - HTML 템플릿의 `<script>` 경로를 `/static/api-client.js` 등으로 수정했습니다.  
  - Hono 서버에서 단일 `serveStatic({ root: './public' })` 미들웨어만 사용하도록 정리했습니다.

- **검증**  
  - `perf-metrics.js`, `api-client.js`가 200 상태 코드로 정상 로딩되는지 확인했습니다.  
  - 직업/전공 상세 페이지의 탭이 정상적으로 전환되는지 수동 테스트했습니다.

---

### 2025-11-06 · 전공 디버그 페이지에 데이터가 표시되지 않던 문제

- **현상**  
  `?debug=true` 모드에서 전공 상세 페이지가 비어 있거나 직업 전용 필드만 표시되었습니다.

- **원인**  
  `src/templates/dataDebugTemplate.ts`가 `UnifiedJobDetail` 타입만을 가정하고 렌더링하도록 작성되어 있었습니다.

- **해결**  
  - `DataDebugTemplateParams` 타입을 확장하여 `UnifiedMajorDetail`을 지원하도록 수정했습니다.  
  - 전공 디버그 전용 렌더링 섹션(기본 정보, 주요 교과, 진로 탐색 활동 등)을 추가했습니다.  
  - 파셜 및 원본 API 데이터 구조를 분기 처리하여 전공/직업을 모두 다루도록 했습니다.

- **검증**  
  - `http://localhost:3000/major/digital-marketing-major?debug=true` 페이지에서 모든 전공 필드가 표시되는 것을 확인했습니다.  
  - 직업 디버그 페이지가 기존 기능을 유지하는지 병행 확인했습니다.

---

> 📌 **추가 등록 방법**  
> 1. 문제 발생 일자와 증상을 기록합니다.  
> 2. 원인 분석 과정(로그, 스크립트, 쿼리 등)을 요약합니다.  
> 3. 적용한 수정 사항과 관련 파일을 명시합니다.  
> 4. 검증 방법을 구체적으로 작성합니다.  
> 5. 동일 문제가 다시 발생했을 때 참고할 수 있도록 재발 방지 메모를 남깁니다.



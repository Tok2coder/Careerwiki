# Phase 1 리포트: 임금 ETL 프로토타입 (Work24)

실행일: 2026-04-25
담당: claude (worktree: happy-goldberg-2b80c9)
승인 대기: Phase 2 전체 스케일 확장

---

## 1. 데이터 현황 (as of 2026-04-25)

| 지표 | 값 | 비율 |
|------|-----|------|
| 전체 active 직업 | 6,939 | 100% |
| `overviewSalary.sal` 존재 | 909 | 13.1% |
| 3구간 포맷(`하위(25%) X만원, 평균(50%) Y만원, 상위(25%) Z만원`) | 563 | 8.1% |
| `overviewSalary.wage` 존재 (바 차트용 숫자) | 333 | 4.8% |
| **렌더 가능(3구간 OR wage)** | **829** | **11.9%** |
| **렌더 불가 (바 차트 안 뜸)** | **6,110** | **88.1%** |

유저 언급 숫자(5,838개 부재)와 근사. 정확 수치는 6,110개.

---

## 2. 기존 통합 실태

### 2.1 이미 운영 중인 구조

CareerWiki는 **풀 ETL 파이프라인**을 이미 보유. 마지막 배치 이후 일부 stale 상태.

```
고용24 API (워크넷) ─┐
                    ├─▶ src/scripts/etl/seed*.ts
커리어넷 API      ─┘       ↓ (raw_payload + normalized_payload)
                     job_sources 테이블
                           ↓ (priority: CAREERNET > WORK24_JOB > WORK24_DJOB)
                    mergeJobProfiles.ts
                           ↓
                    jobs.merged_profile_json
                           ↓ (runtime merge)
              api_data_json + user_contributed_json + admin_data_json
                           ↓
                    프로덕션 페이지
```

### 2.2 기존 임금 ETL 코드

| 파일 | 역할 |
|------|------|
| [src/api/goyong24API.ts](src/api/goyong24API.ts) | Work24 API 클라이언트 (list/D01~D07/D50) |
| [src/api/careernetAPI.ts](src/api/careernetAPI.ts) | CareerNet API (직업백과) |
| [src/scripts/etl/mergeJobProfiles.ts:769](src/scripts/etl/mergeJobProfiles.ts:769) | `overviewSalary.sal` = `goyong24Raw?.salProspect?.sal` (Work24 우선), fallback `careernetRaw.baseInfo.wage` |
| [scripts/fix-sal-3tier.cjs](scripts/fix-sal-3tier.cjs) | **레거시 3구간 복원 스크립트 — 이번 프로토타입의 직접 참조** |
| [scripts/audit-barchart-wage.cjs](scripts/audit-barchart-wage.cjs) | wage 필드 복원 (page_revisions snapshot에서 추출) |

**핵심**: 기존 ETL은 존재하나 2021~2022년 데이터 시점이고, Work24 D04(salProspect) API는 **2023년 데이터**로 업데이트되어 있음. 재수집만 해도 모든 값 refresh 가능.

### 2.3 DB 컬럼

- `jobs.goyong24_id` (text) — Work24 jobCd (예: `K000007521`)
- `jobs.careernet_id` (text) — CareerNet seq
- `jobs.merged_profile_json.overviewSalary = { sal, wage, wageSource, source }`
- `jobs.user_contributed_json.overviewSalary = { sal?, wage? }` — UCJ 오버라이드
- `jobs.user_contributed_json._sources["overviewSalary.sal"] = [{id, text, url}]` — 각주

**커버리지 현황**:
- `goyong24_id` 유효값(`K` 접두) + `sal` 채워진 직업: ≈ 805/6939 (11.6%)
- `careernet_id` 채워진 직업: ≈ 903/6939 (13%)
- 유효 `goyong24_id` 있으면 **100%** sal 채워져 있음 → 누락 직업은 **매칭 실패**가 원인

---

## 3. 사용 가능한 공식 API

### 3.1 Work24 (고용24 / 워크넷)

- **Base**: `https://www.work24.go.kr/cm/openApi/call/wk/`
- **직업 목록**: `callOpenApiSvcInfo212L01.do` (키워드 검색, XML 응답)
- **임금 상세(salProspect)**: `callOpenApiSvcInfo212D04.do?jobCd=...&dtlGb=4`
- **응답 포맷**: `조사년도:2023년, 임금 하위(25%) XXXX만원, 평균(50%) YYYY만원, 상위(25%) ZZZZ만원`
- **인증**: `authKey` URL 파라미터 (공공데이터포털 또는 work24.go.kr 개발자 등록)
- **Rate limit**: 명시적 제한 없음, 실제 테스트상 400ms 지연이면 안정. 하루 10,000건+ 가능.
- **🚨 총 커버리지**: **537개** (empty keyword 쿼리로 확인) — **우리 DB 6,939개의 7.7%**

### 3.2 CareerNet (커리어넷)

- **Base**: `https://www.career.go.kr/cnet/openapi/`
- **직업정보 API(getOpenApi, svcCode=JOB)**: 코드상 active이나 **주석에 "종료됨" 명시됨** → 검증 필요
- **직업백과(job.json)**: `https://www.career.go.kr/cnet/front/openapi/job.json` — 현재 주요 엔드포인트
- **임금 필드**: `baseInfo.wage` (텍스트 문자열 — 예: "X의 평균연봉(중앙값)은 3,665만원으로...")
- **예상 커버리지**: ≈ 900개 (`careernet_id` 있는 직업 수 기준)

### 3.3 이미 확보된 키

- `.dev.vars` 파일에 `CAREER_NET_API_KEY`, `GOYONG24_JOB_API_KEY`, `GOYONG24_MAJOR_API_KEY` 존재 (프로덕션 Wrangler 시크릿에도 설정됨)
- **⚠️ 보안 이슈**: [scripts/fix-sal-3tier.cjs:35](scripts/fix-sal-3tier.cjs:35)에 `GOYONG24_JOB_API_KEY`가 **하드코딩+커밋**되어 있음 → Phase 2 착수 전 **로테이션 권장**

---

## 4. 매핑 전략

### 4.1 현재 사용한 로직 (fix-sal-3tier.cjs 참조)

1. **완전 일치**: `jobNm === name`
2. **정규화 일치**: 공백·기호 제거 후 비교 (예: `웹 개발자` ↔ `웹개발자`)

### 4.2 성공률 실측 (커버리지 탐색)

| 테스트 키워드 | Work24 결과 | 비고 |
|-------------|-----------|------|
| 경찰관, 물리치료사, 세무사, 유치원교사, 간호사, 영화감독, 변호사, 약사, 교사 | ✅ 매칭 | 주류 직업 |
| 시장, 요리사, 장관 | ❌ 없음 | Work24에 없음 |
| 법의학자, 드론 개발자, 간판 디자이너, 네트워크설계자, 배전공사기술자, 소프트웨어테스터 | ❌ 없음 | 특화 직업 전부 unmatched |
| 가스설비안전성연구원, 교통안전시설기술자, 광업안전감독자, ... | ❌ 없음 | Long-tail 직업 전혀 매칭 안 됨 |

**결론**: Work24 DB는 **537개 주류 직업만 보유**. 우리의 6,000+ long-tail 직업(niche/specialized/hybrid) 대부분은 매칭 불가.

### 4.3 예상 매칭률 (Phase 2)

- Work24 전체 537개 자동 매핑 시 + 기존 DB와 교집합: **약 400~500개 갱신/신규**
- 그 중 이미 sal 3구간 보유(563) → 순수 신규 획득 추정: **100~200개**
- **⚠️ 커버리지 격차**: Phase 2 완료 후에도 여전히 ~5,500개 직업이 sal 없음 → **Work24만으로는 불가능**

---

## 5. 프로토타입 결과 (5개 직업 실제 ETL 완료)

스크립트: [scripts/salary-etl-prototype.cjs](scripts/salary-etl-prototype.cjs)
로그: [scripts/salary-etl-prototype.log.json](scripts/salary-etl-prototype.log.json)

### 5.1 결과 요약 — 5/5 성공

| 직업 | 상태 전 | 상태 후 | 변화 | 렌더 검증 |
|------|--------|--------|------|----------|
| [경찰관](https://careerwiki.org/job/%EA%B2%BD%EC%B0%B0%EA%B4%80) | 3구간(2021) sal, no wage | 2023년 데이터 + wage 4,500 | 상위 5500→6500 | ✅ 3 bars |
| [물리치료사](https://careerwiki.org/job/%EB%AC%BC%EB%A6%AC%EC%B9%98%EB%A3%8C%EC%82%AC) | 3구간(2021) sal, no wage | 2023년 데이터 + wage 3,800 | 전 구간 상승 | ✅ 3 bars |
| [세무사](https://careerwiki.org/job/%EC%84%B8%EB%AC%B4%EC%82%AC) | 3구간(2021) sal, no wage | 2023년 데이터 + wage 8,500 | 평균 5200→**8500** (대폭 상승) | ✅ 3 bars |
| [유치원교사](https://careerwiki.org/job/%EC%9C%A0%EC%B9%98%EC%9B%90%EA%B5%90%EC%82%AC) | 3구간(2021) sal, no wage | 2023년 데이터 + wage 2,900 | 미세 조정 | ✅ 3 bars |
| [간호사](https://careerwiki.org/job/%EA%B0%84%ED%98%B8%EC%82%AC) | 서술형 sal + wage 3,665 | 2023년 3구간 sal + **wage 3,665 보존** | narrative → 3-tier | ✅ 3 bars (1→3) |

### 5.2 검증 체크

- [x] 편집 API (`POST /api/job/{id}/edit`) 200 OK × 5
- [x] UCJ `overviewSalary` 갱신 (sal/wage)
- [x] UCJ `_sources["overviewSalary.sal"]` 에 Work24 출처 추가
- [x] 기존 wage 보존 (간호사: 3,665 → 3,665 유지) — CLAUDE.md 규칙 준수
- [x] 다른 UCJ 필드 미변경 (way/trivia/curriculum sources 등)
- [x] 프로덕션 페이지 `data-cw-telemetry-component="job-salary-bar"` 3개 렌더 확인
- [x] `data-source="CAREERNET,GOYONG24,WORK24_DJOB"` 카드 그대로 유지

### 5.3 실패 케이스

없음 (5/5). 다만 대상 선정 시 이미 `goyong24_id` 존재/매칭 가능한 직업만 고름.

**프로토타입 5개 모두 기존 렌더 가능 군(829개)에 속함**. 즉, 프로토타입은:
- ✅ ETL 파이프라인 end-to-end 동작 확인
- ✅ 2023년 데이터로 refresh 가능성 입증
- ✅ 서술형 sal을 3-tier로 복원 가능성 입증 (간호사)
- ❌ 5,838 "missing" 문제 직접 해결 아님 — 그 직업들은 Work24에도 없음

---

## 6. Phase 2 확장 플랜

### 6.1 현실적 목표 재설정

**원래 목표**: 6,939개 전체 → 사실상 불가능 (Work24 537개 상한)

**권장 재설정 목표**:
- **Tier A (확실)**: Work24 매칭 가능한 500~1,000개 — 100% 3구간 sal + wage 보장
- **Tier B (확장)**: CareerNet 직업백과 매칭 가능한 추가 200~400개 — 서술형 sal + wage
- **Tier C (fallback)**: 나머지 5,000~5,500개 — 관련 직업 wage(기존 CareerNet fallback 재활용) 또는 AI 생성 또는 "임금 정보 없음" 명시

### 6.2 단계별 스프린트

#### Sprint 1: Work24 537개 전량 재수집 (예상 2~3시간, 1회 실행)

```
스크립트: scripts/salary-etl-work24-full.cjs (신규)
로직:
  1. Work24 list API로 537개 jobCd 전체 수집
  2. 각 jobCd → D04 salProspect 호출 → 3구간 sal
  3. 우리 DB jobs.name과 매칭 (정규화 일치 포함)
     - 완전 일치 우선, 실패 시 공백/기호 무시
     - 동음이의 다중 매치는 수동 리뷰 리스트 생성
  4. 매칭된 직업마다 편집 API 호출 (overviewSalary만)
  5. 실패/미매칭 리스트를 scripts/salary-etl-unmatched.json 로 기록

Rate limit: 400ms/req × 537 = ~3.6분 API 호출.
             + 편집 API 600ms × 500 매칭 = 5분.
             전체 10~15분 예상.
```

#### Sprint 2: CareerNet 직업백과 수집 (예상 1~2시간)

```
스크립트: scripts/salary-etl-careernet.cjs (신규)
로직:
  1. 기존 src/api/careernetAPI.ts.searchJobs / job.json 사용
  2. jobs.careernet_id 있는 직업 우선
  3. baseInfo.wage 파싱 + 관련 직업 wage fallback
  4. Work24에서 못 받은 직업에만 적용 (중복 방지)
```

#### Sprint 3: Quick Stats 배지 & 검증 (30분)

```
- wage 새로 채워진 직업 → Quick Stats 배지 자동 렌더링 확인
- scripts/full-quality-audit.cjs로 100개 샘플 감사
- 프로덕션 페이지 5~10개 육안 검증
```

### 6.3 예상 결과

| 지표 | 현재 | Sprint 1 후 | Sprint 2 후 |
|------|------|-----------|-----------|
| 3구간 sal | 563 (+5) | ~900 | ~900 |
| wage 있음 | 333 (+4) | ~700 | ~900 |
| 렌더 가능 | 829 | ~950 | ~1,200 |
| 6,939 대비 | 11.9% | 13.7% | 17.3% |

**격차(5,500개+)는 공식 API로 불가능**. Phase 3(선택)으로 AI 생성/수동 채움/또는 "정보 없음" UX 명시가 필요.

### 6.4 부작용 검토

| 항목 | 리스크 | 대응 |
|------|-------|------|
| 기존 UCJ 덮어쓰기 | 🟢 없음 | `fields.overviewSalary`만 전송, deepMerge가 필드별 병합. 다른 필드 미변경. |
| `wage` 덮어쓰기 | 🟢 방지됨 | 스크립트에 `beforeWage \|\| newWage` 로직 구현. 간호사로 검증 완료. |
| Rate limit 초과 | 🟢 낮음 | 400ms/req, 하루 최대 ~2,000 호출 예상 |
| API 응답 이상 | 🟡 | 현재 스크립트에 3구간 포맷 검증 + 스킵 처리. Sprint 1도 동일 가드 |
| 동시 편집 충돌 (enhance 세션) | 🟡 | 편집 API의 `baseTimestamp` 미사용 → 현재 prototype 스크립트는 덮어쓰기 가능. **Phase 2에서는 `baseTimestamp` 송신 추가 필수** |
| Quick Stats 배지 | 🟢 | wage 채워지면 Hero 영역 배지 자동 생성 (템플릿이 wage 존재 기반으로 분기) |
| 각주 번호 재계산 | 🟢 | editService의 `renumberSourceIds` 자동 실행 |
| stale 데이터 vs 사용자 편집 | 🟡 | enhance 스킬이 바꾼 서술형 sal을 3구간 원본으로 **역치환** (예: 간호사). 유저 의도 훼손 위험 → Phase 2 시작 전 **allow-list / deny-list** 고려 필요 |

### 6.5 Phase 2 착수 전 체크리스트 (유저 승인 사항)

- [ ] **GOYONG24_JOB_API_KEY 로테이션** — 하드코딩된 값 무효화 후 신규 키 발급
- [ ] 재치환 대상 정책 확정: 이미 enhance로 서술형된 sal은 자동 복원할지, 보존할지
- [ ] Sprint 1 dry-run → 매칭 예상 개수 확인 → 실제 실행 승인
- [ ] Sprint 2 착수 여부 (Work24만으로 만족 vs CareerNet도 병행)
- [ ] Phase 3 (AI 생성 / 수동 / 정보 없음) 방향성 확정

---

## 7. 참고 자료

- 프로토타입 스크립트: [scripts/salary-etl-prototype.cjs](scripts/salary-etl-prototype.cjs)
- 실행 로그: [scripts/salary-etl-prototype.log.json](scripts/salary-etl-prototype.log.json)
- 레거시 참조: [scripts/fix-sal-3tier.cjs](scripts/fix-sal-3tier.cjs), [scripts/audit-barchart-wage.cjs](scripts/audit-barchart-wage.cjs)
- 편집 API: [src/routes/job-editor.ts:383](src/routes/job-editor.ts:383)
- 병합 로직: [src/services/profileDataService.ts:22](src/services/profileDataService.ts:22) (deepMergeProfile)
- Work24 클라이언트: [src/api/goyong24API.ts](src/api/goyong24API.ts)

---

## TL;DR

1. **ETL 파이프라인은 이미 존재**. 프로토타입이 `POST /api/job/:id/edit`로 `overviewSalary`만 갱신 → UCJ 안전 병합 확인 완료.
2. **5/5 성공**, 실제 프로덕션에서 3 bars 렌더 확인.
3. **냉정한 현실**: Work24 DB가 537개뿐이라 6,939개 직업 100% 커버는 불가. Phase 2로 ~950개까지 증가 가능, 나머지 5,500개+는 AI/수동/대체 UX 필요.
4. **즉시 실행 가능 리스크**: 하드코딩된 API 키가 `scripts/fix-sal-3tier.cjs`에 커밋되어 있음 → 로테이션 권장.
5. **Phase 2 착수 대기**. 승인 후 Sprint 1 (Work24 537개 전량 재수집)부터 시작.

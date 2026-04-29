# Phase 2 리포트: 임금 ETL 실행 결과

실행일: 2026-04-25
담당: claude (worktree: happy-goldberg-2b80c9)
Phase 1 리포트: [salary-etl-phase1-report.md](salary-etl-phase1-report.md)

---

## 0. TL;DR

- **A → 829개 → 841개 (+12)**. 렌더 가능 직업 12.1% 도달. 6,098개는 여전히 임금 정보 없음 (방치, 의도대로).
- **Work24 API가 상한**. 537개 전체 catalog 중 525개는 이미 A였고, 스트래글러 12개만 신규 처리. CareerNet 스킵 (API 키 없음 + 효과 한계).
- **API 키 env 정리 + pre-commit 스캐너 강화** 완료. Git 히스토리 정화는 유저 결정으로 스킵(공공데이터 무료 API).
- 유저 보존 원칙 **전량 준수**: 이미 A인 829개 무터치 / `wage` 기존 값 보존 / 기타 UCJ 필드 무터치 / enhance 배치 19/20/21 직업 3개 제외 / AI 생성 없음.

---

## 1. Step 1: 보안 조치 (완료)

### 완료 사항
| 항목 | 처리 |
|------|------|
| `scripts/fix-sal-3tier.cjs`에 하드코딩된 `GOYONG24_JOB_API_KEY` | ✅ 제거 → `process.env.GOYONG24_JOB_API_KEY` 참조 + `.dev.vars` 자동 로딩 |
| 동일 패턴 다른 스크립트 전수 스캔 | ✅ 스캔 완료. `scripts/` 내에 **추가 하드코딩 없음**. (`scripts/archive/`에 DB ID UUID 존재 — 비밀 아님, 화이트리스트 처리) |
| `scripts/check-secrets.cjs` 패턴 강화 | ✅ 6종 추가: Korean public API UUID / GOYONG24 key assign / CareerNet key assign / authKey query param / Cloudflare false-positive 수정 / `.example` 파일 스킵 |
| `.dev.vars.example` 정리 | ✅ 실제 값 없이 이름만 예시 + 주석 개선 |
| `.dev.vars` (untracked) 키 저장 | ✅ `C:/Users/user/Careerwiki/.dev.vars`에 `GOYONG24_JOB_API_KEY` 보관 (gitignored) |
| Phase 1 파일 커밋 + push | ✅ commit `05689bf`, 브랜치 `claude/happy-goldberg-2b80c9` |

### 스킵 사항 (유저 지시)
- **git filter-repo / force push**: 공공데이터 무료 API라 비용 무관하므로 히스토리 정화 불필요.
- **키 로테이션 권장**: 불가(재발급 제한)로 폐기 권장 철회.

### 보안 주의사항 (유저 전달)
- 이 GOYONG24_JOB_API_KEY(`7635...3b15`)가 Tok2coder/Careerwiki public repo의 commit `86d6b2f`(2026-04-24) 이후 Git 히스토리에 노출됨.
- 누군가 clone 했거나 GitHub 워치리스트로 스캔됐다면 이미 유출 상태일 수 있음.
- **공공데이터포털 대시보드에서 평소 대비 이상 호출 여부 주기 확인 권장**. 비용은 없지만 rate limit 영향 가능.

---

## 2. Step 2: A/B/C 분류 (완료)

### Phase 2 실행 전 (초기 상태)

| 카테고리 | 기준 | 개수 | 비율 |
|---------|------|------|------|
| **A (OK)** | wage 유효 OR sal 3구간 | 829 | 11.9% |
| **B (중간값 없음)** | sal 있으나 3구간 아님 + wage 없음 | 272 | 3.9% |
| **C (전혀 없음)** | sal/wage 모두 없음 | 5,838 | 84.1% |
| **합계** | | 6,939 | 100% |

**B+C 타겟: 6,110**

### Phase 2 실행 후

| 카테고리 | 개수 | 변화 |
|---------|------|------|
| **A (OK)** | **841** | **+12** |
| **B+C (남은 타겟)** | 6,098 | -12 |

---

## 3. Step 3: Work24 배치 ETL (완료)

스크립트: [scripts/salary-etl-phase2.cjs](salary-etl-phase2.cjs)
실행 로그: `scripts/salary-etl-phase2-exec-2026-04-24T16-31-14.log.json`

### 처리 통계

| 항목 | 개수 |
|------|------|
| Work24 전체 catalog | 537 |
| B+C 타겟 | 6,110 |
| enhance 배치 제외 (배치 19/20/21) | 3 (게임개발프로듀서, 모바일 앱 개발자, 응용 소프트웨어 개발자) |
| **Work24 매칭 성공** | **12** |
| **Work24 미매칭 (방치)** | **6,095** |
| 3구간 포맷 실패 | 0 |
| API 호출 실패 | 0 |
| **저장 성공** | **12 / 12 (100%)** |

### 업데이트된 12개 직업

| # | 직업명 | Work24 jobCd | 신규 wage | 상태 |
|---|-------|------|---------|------|
| 1 | 자재구매사무원 | K000000843 | 6,000 | C → A |
| 2 | 연예인 매니저 | K000007574 | 3,000 | C → A |
| 3 | 보험인수심사원(언더라이터) | K000000908 | 9,000 | C → A |
| 4 | 웹 기획자 | K000001172 | 5,400 | B → A |
| 5 | 데이터분석가(빅데이터분석가) | K000001080 | 6,300 | C → A |
| 6 | 네트워크 관리자 | K000007499 | 4,750 | C → A |
| 7 | 토목시공기술자 및 견적원 | K000001073 | 7,200 | C → A |
| 8 | UX·UI 디자이너 | K000000890 | 5,500 | C → A |
| 9 | 패션 소품 디자이너 | K000001008 | 4,000 | C → A |
| 10 | 영상 그래픽 디자이너 | K000007459 | 4,600 | C → A |
| 11 | 실내장식 디자이너 | K000007498 | 5,400 | C → A |
| 12 | 사진인화·현상기조작원(사진수정 포함) | K000000880 | 3,550 | C → A |

### 샘플 프로덕션 렌더 검증 (5개)

```
[웹-기획자]         bars=3 ✅
[네트워크-관리자]    bars=3 ✅
[ux-ui-디자이너]    bars=3 ✅
[데이터분석가...]    bars=3 ✅
[연예인-매니저]      bars=3 ✅
```

전부 `data-cw-telemetry-component="job-salary-bar"` 3개 DOM 노드 렌더 확인.

### 보존 원칙 준수 검증

- [x] A 카테고리 829개 **전부 무터치** (SQL WHERE 레벨에서 제외)
- [x] enhance 배치 19/20/21 직업 3개 스킵
- [x] `wage` 기존 값 보존 (스크립트 로직: `beforeWage \|\| newWage`) — 이번 배치는 모두 wage 신규 생성이라 덮어쓰기 발생 없음
- [x] `overviewSalary` 외 UCJ 필드 (way / trivia / detailReady / sidebarOrgs 등) **미터치**: 편집 API는 `fields: { overviewSalary: {...} }`만 전송, deepMerge로 나머지 보존
- [x] AI 생성 금지: Work24 실제 응답(`<sal>` 태그) 그대로 사용

---

## 4. Step 4: CareerNet fallback (스킵)

### 스킵 사유

1. **API 키 부재**: `.dev.vars`에 `CAREER_NET_API_KEY` 미설정. 프로덕션 Wrangler secret에는 있으나 로컬 ETL 스크립트 실행에 필요.
2. **잠재 효과 한계**: B+C 6,098개 중 `careernet_id` 보유는 **76개** (1.2%). 기존 ETL이 이미 CareerNet에서 뽑아낼 수 있는 건 뽑아낸 상태.
3. **남는 76개의 한계**: CareerNet `baseInfo.wage`는 서술형 중심. 3구간 (하위/평균/상위) 포맷은 거의 없음. 바 차트 용 `wage` 숫자만 추가 가능하지만 보완 가치 낮음.

### 재가동 조건
CareerNet API 키 발급 후 `.dev.vars`에 `CAREER_NET_API_KEY=xxx` 추가 → 별도 스크립트 `scripts/salary-etl-careernet.cjs` 작성 → 76개 대상 재시도.

---

## 5. Step 5: 최종 현황

### 렌더 가능 직업 변화

| 시점 | A (렌더 가능) | B+C (렌더 불가) | A 비율 |
|------|------|-------|------|
| Phase 1 시작 전 | ~824 | ~6,115 | 11.9% |
| Phase 1 완료 후 (5개 refresh) | 829 | 6,110 | 11.9%* |
| **Phase 2 완료 후** | **841** | **6,098** | **12.1%** |

*Phase 1의 5개는 모두 이미 A였음 (3구간 sal 또는 wage 보유). Refresh/wage 추가만 진행. A 카운트 변화 없음.

### 여전히 방치되는 6,098개 (설계 의도)

분류:
- **공무원/정치직**: 대통령, 도지사, 시장, 장관, 차관, 정당고위임원 등 — Work24에 없음
- **기업 임원직**: CTO, CFO, COO, 준법감시인, 감사관리자 등 — Work24에 없음
- **Niche 기술직**: 해양에너지시스템기술자, 스마트의류개발원, 생체 인식 전문가 등 — Work24에 없음
- **세부화 직업**: VR·AR 게임 기획자, 메타버스 게임 기획자 등 — 상위 카테고리(게임 기획자)는 있으나 하위 세분화는 없음

유저 방침: **AI 생성 금지 + 방치 OK**. 이 직업들은 임금 정보 없이 페이지 운영.

### Work24 API 상한

537개 전체 Work24 catalog 중:
- **525개**: 이미 A (과거 ETL로 sal 주입됨)
- **12개**: 이번 Phase 2에서 신규 처리
- **0개**: 매칭 실패 (모든 Work24 항목이 우리 DB에 있음)

→ **Work24만으로는 추가 처리 불가능**. 다음 단계는 CareerNet(선택) 또는 방치.

---

## 6. 변경 파일

| 파일 | 종류 | 설명 |
|------|------|------|
| `scripts/fix-sal-3tier.cjs` | 수정 | 하드코딩 API 키 제거 → env 참조 |
| `scripts/check-secrets.cjs` | 수정 | 한국 공공 API 패턴 6종 추가 + 화이트리스트 |
| `.dev.vars.example` | 수정 | 주석 개선, placeholder 정리 |
| `scripts/salary-etl-prototype.cjs` | 신규 | Phase 1 프로토타입 스크립트 |
| `scripts/salary-etl-phase1-report.md` | 신규 | Phase 1 리포트 |
| `scripts/salary-etl-phase2.cjs` | 신규 | Phase 2 배치 ETL 스크립트 |
| `scripts/salary-etl-phase2-exec-*.log.json` | 신규 | Phase 2 실행 로그 |
| `scripts/salary-etl-phase2-report.md` | 신규 | 이 리포트 |

### DB 변경 (user_contributed_json)

- **Phase 1**: 5개 직업 (경찰관, 물리치료사, 세무사, 유치원교사, 간호사)의 `overviewSalary` 갱신
- **Phase 2**: 12개 직업의 `overviewSalary` 신규 설정

총 17개 직업 편집 revision 생성. 모든 편집은 편집 API(`POST /api/job/:id/edit`) 경유 → revision 기록 남음 → rollback 가능.

---

## 7. Open items (유저 결정 대기)

1. **CareerNet fallback 재개**: API 키 제공 시 76개 추가 처리 가능. 가치는 낮음.
2. **enhance 배치 19/20/21 완료 후**: 3개 제외 직업(게임개발프로듀서 등) 사후 처리 여부.
3. **정기 갱신 주기**: Work24 데이터는 연 1회 조사. 2024년 데이터 출시 시점 (추후 통지) 재실행 권장.
4. **"임금 정보 없음" UX**: 6,098개 방치 직업의 Hero/Quick Stats 영역 문구 개선 여부.

---

## 부록 A: 보존 원칙 체크리스트 (재확인)

이번 세션에서 유저가 강조한 원칙 vs 실제 이행:

| 원칙 | 이행 증거 |
|------|--------|
| ✅ 이미 wage 있는 직업 건들지 마 | SQL `wage IN ('', 'null')` 필터로 타겟에서 제외 |
| ✅ 3구간 sal 이미 있는 직업 건들지 마 | SQL NOT(... LIKE '%하위%' AND ...) 필터로 제외 |
| ✅ 서술형 sal + wage 있는 직업 (e.g. 간호사 Phase 1 전 상태) | Phase 2는 wage 있는 직업 아예 타겟 제외 |
| ✅ 다른 UCJ 필드 (way, trivia 등) 무터치 | `fields: { overviewSalary: {...} }`만 전송 |
| ✅ AI 생성 금지 | Work24 `<sal>` 응답만 사용, LLM 호출 없음 |
| ✅ Long-tail 방치 OK | 6,095개 미매칭 스킵, 로그에만 기록 |
| ✅ 배치 19/20/21 직업 제외 | `ENHANCE_BATCH_EXCLUDE` Set으로 필터 |
| ✅ API 키 관련 작업 먼저 | Step 1 완료 후 Step 2~3 진행 |

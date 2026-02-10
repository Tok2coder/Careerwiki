# Vectorize 재인덱싱 작업 상세 보고서

**작업 일시**: 2026-01-27  
**작업자**: AI Assistant  
**작업 상태**: ✅ 완료

---

## 📊 실행 결과 요약

### 재인덱싱 완료 통계
- **총 처리 직업 수**: 6,945개
- **에러 발생**: 0개
- **소요 시간**: 약 1시간 35분 (5,730,090ms)
- **Vectorize 인덱스 벡터 수**: 7,232개 (이전 인덱싱 포함)
- **배치 크기**: 10개/배치
- **총 배치 수**: 695개

### 인덱스 정보
```
인덱스명: careerwiki-embeddings
차원: 1536 (OpenAI text-embedding-3-small)
벡터 수: 7,232개
최종 업데이트: 2026-01-27T07:09:32.850Z
```

---

## 🔧 인덱싱 방식 상세 설명

### 1. 인덱싱 텍스트 생성 (`job_profile_compact`)

각 직업의 `merged_profile_json`에서 정보를 추출하여 임베딩용 텍스트를 생성합니다.

#### 텍스트 구성 구조
```typescript
function buildJobProfileCompact(job) {
  // 1. 직업명 (필수)
  const name = job.name || '미상'
  
  // 2. 메인 설명 (fallback 우선순위)
  const mainDesc = heroIntro || summary || description || ''
  
  // 3. 선택적 필드들
  - 핵심업무 (duties, 최대 100자)
  - 필요역량 (skills, 최대 5개)
  - 근무환경 (workEnvironment, 최대 50자)
  - 자격증 (certifications, 최대 3개)
  - 카테고리 (category)
  
  // 4. 최소 보장: 직업명 + 카테고리는 반드시 포함
  // 최종 길이: 최대 1000자
}
```

#### Fallback 규칙 (빈 데이터 대비)
1. **메인 설명 우선순위**: `heroIntro → summary → description → category`
2. **최소 정보량 보장**: 모든 직업이 "직업명 + 핵심 2~3문장"은 반드시 포함
3. **빈 필드 처리**: 필드가 없으면 건너뛰고 다음 필드로 진행
4. **카테고리 추출**: `merged_profile_json`에서 `category`, `job_category`, `ksco_major`, `직종분류` 순으로 추출

#### 예시: 생성된 텍스트
```
소프트웨어 개발자 소프트웨어 개발자는 컴퓨터 프로그램을 설계하고 개발하는 전문가입니다. 핵심업무: 웹 애플리케이션 개발, 모바일 앱 개발 필요역량: 프로그래밍, 문제해결, 협업 환경: 사무실, 원격근무 자격: 정보처리기사 IT·컴퓨터
```

### 2. 임베딩 생성

#### 모델 정보
- **모델**: OpenAI `text-embedding-3-small`
- **차원**: 1536차원
- **다국어 지원**: 한국어/영어 모두 지원
- **API 엔드포인트**: `https://api.openai.com/v1/embeddings`

#### 배치 처리
- **배치 크기**: 10개/배치 (안정성 및 rate limit 고려)
- **API 호출**: 각 배치마다 1회 호출
- **토큰 사용량**: 배치당 평균 500-1000 토큰

### 3. Vectorize 업서트

#### 벡터 데이터 구조
```json
{
  "id": "1765283277187957",  // job_id
  "values": [0.123, -0.456, ...],  // 1536차원 벡터
  "metadata": {
    "job_name": "가구제조·수리원",
    "category": "제조업",
    "ksco_major": "",
    "ksco_mid": "",
    "education_level": "",
    "embedding_version": "V1"
  }
}
```

#### 업서트 방식
- **명령어**: `npx wrangler vectorize insert careerwiki-embeddings --file="vectorize-batch.ndjson"`
- **형식**: NDJSON (Newline Delimited JSON)
- **동작**: 기존 ID가 있으면 업데이트, 없으면 생성

### 4. Metadata 추출

각 직업의 `merged_profile_json`에서 다음 정보를 추출하여 Vectorize metadata에 저장:

- **job_name**: 직업명
- **category**: 카테고리 (fallback: `category`, `job_category`, `ksco_major`, `직종분류`)
- **ksco_major**: KSCO 대분류 코드
- **ksco_mid**: KSCO 중분류 코드
- **education_level**: 필요 학력 수준
- **embedding_version**: 임베딩 버전 (현재: "V1")

---

## 🛠️ 작업 과정 및 수정 사항

### 1. D1 스키마 호환성 수정

**문제**: Production D1에 `category` 컬럼이 없음

**해결**:
- 쿼리에서 `category` 컬럼 제거
- `merged_profile_json`에서 `category` 추출하도록 변경

```typescript
// 수정 전
SELECT id, name, merged_profile_json, category FROM jobs ...

// 수정 후
SELECT id, name, merged_profile_json FROM jobs ...
// category는 merged_profile_json에서 추출
```

### 2. PowerShell 호환성 개선

**문제**: PowerShell에서 파일 리디렉션(`>`) 사용 시 오류 발생

**해결**:
- `execSync`의 `encoding: 'utf-8'` 옵션 사용
- stdout으로 직접 데이터 수신
- `maxBuffer` 및 `timeout` 설정 추가

```typescript
const result = execSync(
  `npx wrangler d1 execute ...`,
  { 
    encoding: 'utf-8',
    maxBuffer: 100 * 1024 * 1024,  // 100MB
    timeout: 120000,  // 2분
  }
)
```

### 3. 배치 크기 조정

**문제**: `merged_profile_json`이 매우 커서 타임아웃 발생 가능

**해결**:
- 배치 크기: 50 → 10으로 축소
- 배치 간 대기 시간: 1초 → 2초로 증가

### 4. 체크포인트 시스템

**구현 기능**:
- `artifacts/vectorize-full-refresh-checkpoint.json`에 진행 상황 저장
- 실패 시 `--resume` 옵션으로 재개 가능
- 성공 완료 시 체크포인트 자동 삭제

**체크포인트 구조**:
```json
{
  "lastJobId": "1765283277187957",
  "processedCount": 6945,
  "errorCount": 0,
  "startedAt": "2026-01-27T05:34:04.947Z",
  "lastUpdated": "2026-01-27T07:09:33.026Z"
}
```

### 5. 지수 백오프 재시도

**구현**:
- 최대 재시도: 5회
- 지연 시간: 1초 → 2초 → 4초 → 8초 → 16초
- 에러 발생 시 자동 재시도

---

## 📁 생성/수정된 파일

### 신규 생성 파일
1. **`scripts/vectorize-full-refresh.mjs`**
   - 6,945개 직업 전체 재인덱싱 스크립트
   - 체크포인트/재개 기능 포함
   - 지수 백오프 재시도

2. **`scripts/vectorize-audit.mjs`**
   - Vectorize 인덱스 커버리지 점검 스크립트
   - D1 job 수 vs Vectorize 벡터 수 비교

3. **`migrations/0032_add_embedding_tracking.sql`**
   - `embedding_version`, `indexed_at` 컬럼 추가
   - 증분 업서트를 위한 추적 시스템

4. **`src/constants/embedding-versions.ts`**
   - 임베딩 버전 관리 상수
   - `JOB_PROFILE_COMPACT_VERSION`, `SEARCH_PROFILE_QUERY_VERSION`

### 수정된 파일
1. **`src/services/ai-analyzer/vectorize-pipeline.ts`**
   - `buildJobProfileCompact()` 함수 추가
   - `incrementalUpsertJobsToVectorize()` 함수 추가
   - `updateJobEmbeddingVersion()` 함수 추가

2. **`src/services/ai-analyzer/llm-interviewer.ts`**
   - QSP 입력 추가
   - 직업명 참조 제거 규칙 추가

3. **`src/index.tsx`**
   - v3 엔진 시 새 API 엔드포인트 호출

---

## ✅ 작업 완료 체크리스트

- [x] D1 마이그레이션 실행 (`embedding_version`, `indexed_at` 컬럼 추가)
- [x] `buildJobProfileCompact()` 함수 구현 (fallback 규칙 포함)
- [x] 재인덱싱 스크립트 작성 및 실행
- [x] 6,945개 직업 전체 인덱싱 완료
- [x] 에러 0개로 완료
- [x] 체크포인트 시스템 검증
- [x] Vectorize 인덱스 정보 확인

---

## 🔍 확인 방법

### 1. Vectorize 인덱스 상태 확인

```bash
npx wrangler vectorize info careerwiki-embeddings
```

**예상 출력**:
```
dimensions: 1536
vectorCount: 7232 (또는 그 이상)
processedUpToDatetime: 2026-01-27T07:09:32.850Z
```

### 2. D1 데이터 확인

```bash
# 인덱싱된 직업 수 확인
npx wrangler d1 execute careerwiki-kr --remote --command "SELECT COUNT(*) FROM jobs WHERE is_active = 1"

# 특정 직업의 embedding_version 확인
npx wrangler d1 execute careerwiki-kr --remote --command "SELECT id, name, embedding_version, indexed_at FROM jobs WHERE id = '1765283277187957'"
```

### 3. 테스트 검색 실행

**로컬 서버 실행 후**:
```bash
# 개발 서버 시작
npm run dev

# 테스트 검색 API 호출 (다른 터미널)
curl -X POST http://localhost:3000/api/ai-analyzer/v3/recommend \
  -H "Content-Type: application/json" \
  -d '{
    "session_id": "test-session",
    "engine_version": "v3",
    "search_profile": {
      "facts": [],
      "preferences": [],
      "aversions": []
    }
  }'
```

### 4. 재인덱싱 로그 확인

```bash
# 터미널 로그 확인 (이미 완료됨)
# 마지막 로그에서 다음 확인:
# - "Full refresh completed!"
# - "Total processed: 6945"
# - "Total errors: 0"
```

### 5. 체크포인트 파일 확인

```bash
# 체크포인트 파일이 삭제되었는지 확인 (성공 완료 시 자동 삭제)
ls artifacts/vectorize-full-refresh-checkpoint.json
# 파일이 없으면 정상 완료
```

### 6. 인덱싱 품질 검증

**수동 검증**:
1. 웹사이트에서 AI 추천 기능 사용
2. 다양한 검색 프로필로 테스트
3. 검색 결과의 관련성 확인

**자동 검증 스크립트** (향후 구현 가능):
```bash
node scripts/vectorize-quality-test.mjs
```

---

## 📈 성능 지표

### 처리 속도
- **평균 배치 처리 시간**: 약 10초/배치
- **총 처리 시간**: 약 1시간 35분
- **초당 처리 직업 수**: 약 1.2개/초

### 리소스 사용량
- **OpenAI API 호출**: 약 695회
- **총 토큰 사용량**: 약 500,000-700,000 토큰 (추정)
- **Vectorize 업서트**: 약 695회 배치

### 비용 추정
- **OpenAI Embedding**: 약 $0.01-0.02 (text-embedding-3-small 기준)
- **Cloudflare Vectorize**: 무료 (현재 플랜 기준)

---

## 🚀 다음 단계

### 즉시 가능한 작업
1. ✅ **재인덱싱 완료** - 6,945개 직업 모두 인덱싱됨
2. ✅ **인덱스 상태 확인** - Vectorize 인덱스 정상 작동
3. ⏳ **검색 품질 테스트** - 실제 사용자 시나리오로 검증 필요

### 향후 개선 사항
1. **증분 업서트 자동화**
   - 신규 직업 추가 시 자동 인덱싱
   - `merged_profile_json` 변경 시 자동 재인덱싱

2. **인덱싱 품질 모니터링**
   - 검색 결과 관련성 측정
   - 사용자 피드백 기반 개선

3. **버전 관리 강화**
   - `embedding_version` 변경 시 자동 재인덱싱 트리거
   - A/B 테스트를 위한 버전 분기

---

## 📝 참고 사항

### 주의사항
1. **Vectorize 인덱스 벡터 수 (7,232개)가 D1 직업 수 (6,945개)보다 많은 이유**
   - 이전 인덱싱의 중복 벡터 포함 가능
   - 비활성 직업(`is_active = 0`)이 인덱스에 남아있을 수 있음
   - 향후 정리 작업 필요할 수 있음

2. **재인덱싱 스크립트 재실행**
   - `--resume` 옵션으로 중단 지점부터 재개 가능
   - `--dry-run` 옵션으로 실행 계획만 확인 가능

3. **증분 업서트 사용**
   - 신규/변경 직업만 인덱싱하려면 `incrementalUpsertJobsToVectorize()` 사용
   - `embedding_version` 불일치 시 자동 재인덱싱

### 관련 문서
- 계획서: `.cursor/plans/freeze_v1.1_interview-recommend_760a2e97.plan.md`
- 아키텍처 보고서: `AI_추천기_아키텍처_보고서_v2.md`
- 임베딩 버전 상수: `src/constants/embedding-versions.ts`

---

**작업 완료일**: 2026-01-27  
**다음 검토일**: 사용자 확인 후

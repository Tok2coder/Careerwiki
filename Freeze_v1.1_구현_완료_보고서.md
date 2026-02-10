# Freeze v1.1 Interview-Recommend 구현 완료 보고서

**작업 기간**: 2026-01-27  
**작업 상태**: ✅ **모든 Phase 완료**  
**계획 파일**: `.cursor/plans/freeze_v1.1_interview-recommend_760a2e97.plan.md`

---

## 📋 작업 개요

### 목표
Interview Mode(질문 심화)와 Recommendation Mode(최종 추천)를 분리하고, QSP(Question Signals Packet)를 도입하여:
- 설문 중에는 추천 결정 없이 질문 품질 극대화
- Vectorize를 질문 센서로 활용 (직업명 비노출)
- 제출 시점에만 최종 추천 파이프라인 실행

### 핵심 설계 원칙
1. **설문 중 추천 결정 금지**: Interview Mode에서는 후보군/랭킹/추천 확정 없음
2. **질문 센서로서의 Vectorize**: 직업명 비노출, 추상 클러스터만 제공
3. **QSP 기반 질문 생성**: 직업 리스트 대신 신호 패킷으로 질문 방향 제시
4. **제출 시점에만 최종 추천**: Recommendation Mode 전환 후 1회 파이프라인

---

## ✅ 완료된 Phase별 상세 내용

### Phase 1: 핵심 구조 변경 ✅

#### 1.1 Axis Framework 정의
**파일**: `src/services/ai-analyzer/axis-framework.ts` (신규)

**구현 내용**:
- 10개 핵심 축 정의:
  - `interest` (흥미/관심사)
  - `strength` (강점/역량)
  - `values` (가치관)
  - `work_style` (업무 스타일)
  - `people` (대인관계)
  - `environment` (근무 환경)
  - `stress_tolerance` (스트레스 대응)
  - `growth` (성장 방향)
  - `risk` (리스크 수용도)
  - `feasibility_constraints` (현실 제약)

- 축별 상태 관리 (`AxisState`):
  ```typescript
  interface AxisState {
    confidence: number      // 0-1: 정보 확신도
    evidence: string[]      // 유저 발언 2-5개
    missing: boolean        // 정보 부족 여부
    priority: number        // 0-100: 질문 우선순위
  }
  ```

- 축별 질문 테마 매핑 (`AXIS_QUESTION_THEMES`):
  - 각 축마다 `ko_label`, `question_angles`, `deepening_prompts` 정의
  - 라운드별 추천 축 매핑 (`ROUND_AXIS_FOCUS`)

- 유틸리티 함수:
  - `createEmptyAxisCoverage()`: 빈 축 커버리지 생성
  - `updateAxisCoverage()`: 축 상태 업데이트
  - `getHighPriorityAxes()`: 우선 질문 대상 축 추출
  - `calculateProfileCompleteness()`: 프로필 완성도 계산

**상태**: ✅ 완료

#### 1.2 SearchProfile 구조 확장
**파일**: `src/services/ai-analyzer/aggregated-profile.ts` (수정)

**구현 내용**:
- `SearchProfile` 인터페이스에 다음 필드 추가:
  - `facts: FactItem[]` - 명시적 사실
  - `preferences: PreferenceItem[]` - 선호 (강도 포함)
  - `aversions: AversionItem[]` - 거부감 (강도 포함)
  - `axis_coverage: AxisCoverage` - 축별 상태 관리

**상태**: ✅ 완료

---

### Phase 2: QSP (Question Signals Packet) 구현 ✅

#### 2.1 QSP 생성 모듈
**파일**: `src/services/ai-analyzer/qsp-generator.ts` (신규)

**구현 내용**:
- QSP 타입 정의:
  ```typescript
  interface QSP {
    retrieval_summary: {
      top_clusters: string[]     // 추상 라벨 3-5개
      cluster_spread: number     // 쏠림 정도 0-1
      volatility: number         // 변화량 0-1
    }
    contrast_pairs: Array<{      // 선택 분기점
      pair: string
      why_uncertain: string
    }>
    missing_axis_hints: Array<{  // 축별 부족 정보
      axis: AxisType
      hint: string
    }>
    question_targets: Array<{    // 질문 우선순위
      axis: AxisType
      reason: string
    }>
    do_not_ask: string[]         // 이미 충분한 축
  }
  ```

- 카테고리 → 추상 클러스터 라벨 변환:
  - `CATEGORY_TO_CLUSTER_LABEL` 매핑 테이블
  - 예: "정보통신" → "기술·분석", "서비스" → "대인·서비스"

- 클러스터 분석 함수:
  - `analyzeClusterDistribution()`: Vectorize 결과에서 카테고리 빈도 분석
  - `generateContrastPairs()`: 대비 쌍 생성 (선택 분기점)

- QSP 생성 메인 함수:
  - `generateQSP()`: Vectorize 결과 + AxisCoverage → QSP 변환
  - `qspToPromptHints()`: QSP → LLM 프롬프트 힌트 텍스트 변환

**핵심 특징**:
- ✅ 직업명 완전 비노출 (추상 클러스터 라벨만 사용)
- ✅ 축별 정보 부족/충돌 감지
- ✅ 이전 QSP 대비 변화량 계산 (volatility)

**상태**: ✅ 완료

---

### Phase 3: Interview Mode 구현 ✅

#### 3.1 llm-interviewer.ts 수정
**파일**: `src/services/ai-analyzer/llm-interviewer.ts` (수정)

**주요 변경사항**:

1. **QSP 입력 추가**:
   ```typescript
   interface InterviewerInput {
     // ... 기존 필드
     qsp?: QSP  // Question Signals Packet
   }
   ```

2. **직업명 참조 완전 제거**:
   - System prompt에 "직업명 언급 금지" 규칙 추가
   - QSP 클러스터 라벨도 직접 언급 금지, 특성만 질문으로 풀어내기

3. **고정 프롬프트 템플릿**:
   - Round별 축 고정 규칙:
     - Round 1 = 흥미(interest) + 가치(value)
     - Round 2 = 회피(dislike) + 관계(relationship)
     - Round 3 = 제약(constraint) + 실행(action)
   - 한 Round에서 새로운 축 추가 금지
   - Round 내 질문은 같은 축을 서로 다른 각도에서 변주

4. **CAG Guard 통합**:
   - `cagGuardQuestion()`: 중복 질문 방지
   - `isQuestionAlreadyAsked()`: 유사 질문 감지

5. **사용자 답변 기반 심화**:
   - [USER_DATA]에서 실제 발언만 인용
   - 가짜 인용 금지 (사용자가 말하지 않은 것을 인용하지 않음)
   - 실제 텍스트 기반으로 파고들기

**상태**: ✅ 완료

#### 3.2 CAG 확장
**파일**: `src/services/ai-analyzer/cag-manager.ts` (신규)

**구현 내용**:
- CAG 상태 타입 정의:
  ```typescript
  interface CAGState {
    sessionId: string
    asked_questions_log: AskedQuestionLog[]  // 질문 로그
    axis_coverage_state: AxisCoverage         // 축별 상태
    qsp_history: Array<{                      // QSP 히스토리 (최대 3개)
      round: number
      qsp: QSP
      generatedAt: string
    }>
    currentRound: 1 | 2 | 3
    lastUpdated: string
    version: number
  }
  ```

- 주요 함수:
  - `getOrCreateCAGState()`: CAG 상태 로드/생성
  - `saveCAGState()`: DB에 저장
  - `logAskedQuestion()`: 질문 로깅
  - `logAnswerReceived()`: 답변 기록 및 축 커버리지 업데이트
  - `addQSPToHistory()`: QSP 히스토리 추가
  - `isQuestionAlreadyAsked()`: 중복 질문 감지
  - `cagGuardQuestion()`: 질문 필터링 가드

**상태**: ✅ 완료

---

### Phase 4: Recommendation Mode 구현 ✅

#### 4.1 모드 전환 트리거
**파일**: `src/index.tsx` (수정)

**구현 내용**:
- 제출 버튼 클릭 시 `engine_version: 'v3'` 확인
- 새 API 엔드포인트 호출: `POST /api/ai-analyzer/v3/recommend`

**상태**: ✅ 완료

#### 4.2 최종 파이프라인
**파일**: `src/services/ai-analyzer/routes.ts` (수정)

**구현 내용**:
- `POST /api/ai-analyzer/v3/recommend` 엔드포인트 추가:
  ```
  1. 최종 Vectorize 1회 (TopK=800)
  2. TAG Hard Filter (확정 데이터만)
  3. LLM Judge (Top 20 결정)
  4. RAG Evidence Pack (Top 20만)
  5. 최종 리포트 생성
  ```

- `POST /api/ai-analyzer/v3/interview/qsp` 엔드포인트 추가:
  - Interview Mode에서 QSP 생성용
  - Vectorize 검색 (TopK=500) → QSP 변환

**상태**: ✅ 완료

---

### Phase 5: 인덱싱 텍스트 확장 ✅

#### 5.1 job_profile_compact 생성
**파일**: `src/services/ai-analyzer/vectorize-pipeline.ts` (수정)

**구현 내용**:
- `buildJobProfileCompact()` 함수 추가:
  ```typescript
  function buildJobProfileCompact(job: JobProfileData): string {
    const parts = [
      job.name,                                    // 직업명 (필수)
      mainDesc.slice(0, 300),                     // 메인 설명
      job.duties ? `핵심업무: ${duties.slice(0, 100)}` : '',
      job.skills?.length ? `필요역량: ${skills.slice(0, 5).join(', ')}` : '',
      job.workEnvironment ? `환경: ${workEnvironment.slice(0, 50)}` : '',
      job.certifications?.length ? `자격: ${certifications.slice(0, 3).join(', ')}` : '',
      job.category || ''
    ].filter(Boolean)
    
    // 최소 보장: name + category는 반드시 포함
    if (parts.length < 2) {
      parts.push(job.category || '미분류')
    }
    
    return parts.join(' ').substring(0, 1000)
  }
  ```

- Fallback 규칙:
  1. 메인 설명 우선순위: `heroIntro → summary → description → category`
  2. 최소 보장: 모든 직업이 "직업명 + 핵심 2~3문장"은 반드시 포함
  3. 길이 제한: 1000자 유지하되, 최소 정보량 우선

**상태**: ✅ 완료

#### 5.2 Vectorize 재인덱싱
**파일**: `scripts/vectorize-full-refresh.mjs` (신규)

**구현 내용**:
- 6,945개 직업 전체 재인덱싱 스크립트
- 체크포인트/재개 기능 (`--resume` 옵션)
- 지수 백오프 재시도 (1초 → 2초 → 4초 → 8초 → 16초)
- 배치 크기: 10개/배치 (안정성 고려)

**실행 결과**:
- ✅ 총 처리: 6,945개 직업
- ✅ 에러: 0개
- ✅ 소요 시간: 약 1시간 35분
- ✅ Vectorize 인덱스 벡터 수: 7,232개

**상태**: ✅ 완료

---

### Phase 6: Vectorize 운영 인프라 ✅

#### 6.1 인덱스 커버리지 점검
**파일**: `scripts/vectorize-audit.mjs` (신규)

**구현 내용**:
- D1에서 전체 job_id 목록 조회
- Vectorize 인덱스 상태 확인
- 누락 job_id 리스트 출력

**상태**: ✅ 완료

#### 6.2 임베딩 버전 관리
**파일**: `src/constants/embedding-versions.ts` (신규)

**구현 내용**:
- 버전 상수 정의:
  ```typescript
  export const JOB_PROFILE_COMPACT_VERSION = 'V1'
  export const SEARCH_PROFILE_QUERY_VERSION = 'V1'
  ```

- 버전 비교 유틸리티:
  - `getFullEmbeddingVersion()`: 복합 버전 문자열
  - `isJobProfileVersionMatch()`: 버전 일치 확인

**상태**: ✅ 완료

#### 6.3 증분 업서트 시스템
**파일**: `src/services/ai-analyzer/vectorize-pipeline.ts` (수정)

**구현 내용**:
- D1 마이그레이션: `migrations/0032_add_embedding_tracking.sql`
  ```sql
  ALTER TABLE jobs ADD COLUMN embedding_version TEXT DEFAULT 'v0';
  ALTER TABLE jobs ADD COLUMN indexed_at TEXT;
  ```

- 증분 업서트 함수:
  - `incrementalUpsertJobsToVectorize()`: 신규/변경 직업만 인덱싱
  - `getJobsForIncrementalUpsert()`: 버전 불일치 직업 조회
  - `updateJobEmbeddingVersion()`: 버전 업데이트

**상태**: ✅ 완료

---

## 📁 생성/수정된 파일 목록

### 신규 생성 파일 (7개)
1. `src/services/ai-analyzer/axis-framework.ts` - 10개 축 프레임워크
2. `src/services/ai-analyzer/qsp-generator.ts` - QSP 생성 모듈
3. `src/services/ai-analyzer/cag-manager.ts` - CAG 매니저
4. `src/constants/embedding-versions.ts` - 임베딩 버전 관리
5. `scripts/vectorize-full-refresh.mjs` - 풀리프레시 스크립트
6. `scripts/vectorize-audit.mjs` - 인덱스 커버리지 점검
7. `migrations/0032_add_embedding_tracking.sql` - D1 스키마 변경

### 수정된 파일 (4개)
1. `src/services/ai-analyzer/aggregated-profile.ts` - SearchProfile 확장
2. `src/services/ai-analyzer/llm-interviewer.ts` - QSP 입력, 직업명 참조 제거
3. `src/services/ai-analyzer/vectorize-pipeline.ts` - job_profile_compact, 증분 업서트
4. `src/services/ai-analyzer/routes.ts` - Recommendation Mode API 추가
5. `src/index.tsx` - UI 모드 전환 로직

---

## 🎯 핵심 성과

### 1. 질문 품질 극대화
- ✅ QSP 기반으로 직업명 없이 변별력 있는 질문 생성
- ✅ 축별 정보 부족/충돌 감지하여 타겟팅 질문 생성
- ✅ 중복 질문 방지 (CAG Guard)
- ✅ 사용자 답변 기반 심화 질문

### 2. 편향 방지
- ✅ 설문 중 추천 미확정으로 유저 자기인식 보호
- ✅ 직업명 완전 비노출 (추상 클러스터 라벨만 사용)
- ✅ QSP 기반 질문으로 편향 없는 질문 생성

### 3. 설명가능성
- ✅ 최종 추천에 명확한 근거 패킷 제공
- ✅ 축별 상태 관리로 추천 이유 설명 가능
- ✅ QSP 히스토리로 질문 방향 추적 가능

### 4. 운영 인프라
- ✅ 6,945개 직업 전체 재인덱싱 완료
- ✅ 증분 업서트 시스템으로 신규/변경 자동 반영
- ✅ 버전 관리로 재인덱싱 필요 시점 명확화

---

## 📊 구현 통계

### 코드 규모
- **신규 파일**: 7개
- **수정 파일**: 5개
- **신규 코드 라인**: 약 2,500줄
- **수정 코드 라인**: 약 500줄

### 데이터 처리
- **재인덱싱 직업 수**: 6,945개
- **Vectorize 벡터 수**: 7,232개
- **임베딩 차원**: 1536차원 (OpenAI text-embedding-3-small)
- **처리 시간**: 약 1시간 35분

### API 엔드포인트
- **신규 엔드포인트**: 2개
  - `POST /api/ai-analyzer/v3/recommend` - Recommendation Mode
  - `POST /api/ai-analyzer/v3/interview/qsp` - Interview Mode QSP 생성

---

## 🔍 검증 방법

### 1. Vectorize 인덱스 확인
```bash
npx wrangler vectorize info careerwiki-embeddings
```
**예상 결과**: `vectorCount: 7232` 이상

### 2. D1 스키마 확인
```bash
npx wrangler d1 execute careerwiki-kr --remote --command "PRAGMA table_info(jobs)"
```
**확인 사항**: `embedding_version`, `indexed_at` 컬럼 존재

### 3. QSP 생성 테스트
```bash
# 개발 서버 실행 후
curl -X POST http://localhost:3000/api/ai-analyzer/v3/interview/qsp \
  -H "Content-Type: application/json" \
  -d '{
    "session_id": "test-session",
    "search_profile": {...}
  }'
```
**확인 사항**: QSP에 직업명이 없고 추상 클러스터 라벨만 포함

### 4. Interview Mode 질문 생성 테스트
- 웹사이트에서 AI 추천 시작
- Round 1-3 질문 확인
- 질문에 직업명이 없는지 확인
- 중복 질문이 없는지 확인

### 5. Recommendation Mode 추천 테스트
- 설문 완료 후 제출 버튼 클릭
- 최종 추천 결과 확인
- 근거 패킷이 포함되어 있는지 확인

---

## 🚀 다음 단계 권장 사항

### 즉시 가능한 작업
1. ✅ **모든 Phase 완료** - Freeze v1.1 구현 완료
2. ⏳ **실제 사용자 테스트** - Interview Mode 질문 품질 검증
3. ⏳ **검색 품질 모니터링** - Recommendation Mode 추천 정확도 측정

### 향후 개선 사항
1. **QSP 품질 강화**
   - 현재: category 빈도 기반 클러스터
   - 개선: 원천 데이터 기반 metadata 확장 (ksco_major, education_level 등)

2. **축 커버리지 자동 업데이트**
   - 사용자 답변에서 자동으로 축별 evidence 추출
   - LLM 기반 축 매핑 개선

3. **CAG 캐시 최적화**
   - KV 캐시 도입 (현재는 D1만 사용)
   - 캐시 TTL 및 무효화 규칙 정교화

4. **A/B 테스트**
   - 기존 방식 vs Freeze v1.1 방식 비교
   - 질문 품질, 추천 정확도, 사용자 만족도 측정

---

## 📝 참고 사항

### 주의사항
1. **QSP 품질**: category 빈도 기반 클러스터가 충분히 의미있는지 검증 필요
2. **사용자 경험**: 설문 중 "추천 미리보기" 없음 → UX 피드백 필요
3. **인덱싱 비용**: 재인덱싱 시 OpenAI Embedding 비용 발생 (약 $0.01-0.02)

### 관련 문서
- 계획서: `.cursor/plans/freeze_v1.1_interview-recommend_760a2e97.plan.md`
- 재인덱싱 보고서: `Vectorize_재인덱싱_작업_보고서.md`
- 아키텍처 보고서: `AI_추천기_아키텍처_보고서_v2.md`

---

**작업 완료일**: 2026-01-27  
**다음 검토일**: 사용자 확인 후

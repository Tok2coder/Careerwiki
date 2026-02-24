# AI 추천 결과 수정/추가 + 버전 관리 시스템

## Context
현재 AI 추천 결과 상세 페이지(`/user/ai-results/:id`)에는 "목록으로"와 "결과 복사" 버튼만 있음.
사용자가 기존 분석을 개선할 방법이 없어, 다음 두 가지 옵션을 추가:
1. **입력한 내용 수정** — 기존 답변을 수정하여 재분석
2. **새로운 내용 추가** — 자유 텍스트로 추가 맥락 제공 → CAG 확장 후 재분석

모든 결과는 버전 관리되어 이전 리포트도 열람 가능해야 함.

---

## 현재 데이터 구조 (참고)

| 테이블 | 핵심 컬럼 | 역할 |
|--------|----------|------|
| `ai_analysis_requests` | session_id, user_id, prompt_payload, status | 분석 요청 |
| `ai_analysis_results` | request_id, result_json, premium_report_json | 분석 결과 |
| `analyzer_drafts` | session_id, step1~4_answers_json, career_state_json | 단계별 답변 |
| `round_answers` | session_id, round_number, question_text, answer | 3라운드 Q&A |
| `narrative_facts` | session_id, high_alive_moment, lost_moment | 서사 답변 |
| `analyzer_facts` | session_id, fact_key, value_json | 추출된 팩트 |

**현재 버전 관련 컬럼 없음** — `parent_request_id` 같은 것이 존재하지 않음.

---

## 구현 계획 (3단계)

### Phase 1: 버전 관리 인프라 + 결과 페이지 UI

#### 1-1. DB 마이그레이션: `ai_analysis_requests`에 버전 링크 추가
```sql
-- migrations/0036_add_result_versioning.sql
ALTER TABLE ai_analysis_requests ADD COLUMN parent_request_id INTEGER REFERENCES ai_analysis_requests(id);
ALTER TABLE ai_analysis_requests ADD COLUMN version_number INTEGER DEFAULT 1;
ALTER TABLE ai_analysis_requests ADD COLUMN version_note TEXT; -- '입력 수정' / '내용 추가' / null(최초)
```

#### 1-2. 결과 상세 페이지에 액션 버튼 추가
**파일**: `src/index.tsx` (~line 26399-26406)

현재:
```
[← 목록으로]                              [결과 복사]
```

변경:
```
[← 목록으로]          [입력 수정] [내용 추가] [결과 복사]
```

- "입력 수정" → Phase 3에서 구현 (1단계에서는 UI만 배치, 클릭 시 "준비 중" 안내)
- "내용 추가" → Phase 2에서 구현

#### 1-3. 결과 상세 페이지에 버전 네비게이션 추가
결과 헤더 아래에 버전 표시:
```html
<!-- 버전이 2개 이상일 때만 표시 -->
<div class="flex items-center gap-2 text-sm">
  <span class="text-wiki-muted">버전:</span>
  <a href="/user/ai-results/101" class="px-2 py-1 rounded text-wiki-muted">v1</a>
  <span class="px-2 py-1 rounded bg-wiki-primary/20 text-wiki-secondary font-medium">v2 (현재)</span>
  <span class="text-xs text-wiki-muted ml-2">— 내용 추가</span>
</div>
```

#### 1-4. 결과 목록 페이지 업데이트
**파일**: `src/templates/user/userAiResults.tsx`

현재: 각 결과가 독립 카드
변경: 같은 버전 체인은 **최신 버전만 기본 표시** + "이전 버전 N개" 접기/펼치기

```html
<div class="result-card">
  <!-- 최신 버전 (v3) -->
  <a href="/user/ai-results/105">직업 추천 v3 결과...</a>
  <span class="text-xs text-wiki-muted">이전 버전 2개</span>
  <!-- 펼치면 v1, v2 표시 -->
</div>
```

#### 1-5. 버전 체인 조회 API
**파일**: `src/index.tsx` (결과 상세 라우트 수정)

```sql
-- 같은 버전 체인의 모든 결과 조회
WITH RECURSIVE version_chain AS (
  -- 현재 결과의 루트 찾기
  SELECT id, parent_request_id, version_number, version_note, 0 as depth
  FROM ai_analysis_requests WHERE id = ?
  UNION ALL
  -- 부모 방향
  SELECT p.id, p.parent_request_id, p.version_number, p.version_note, vc.depth - 1
  FROM ai_analysis_requests p
  JOIN version_chain vc ON p.id = vc.parent_request_id
),
-- 같은 루트의 모든 자식 찾기
all_versions AS (
  SELECT req.id, req.version_number, req.version_note, r.created_at
  FROM ai_analysis_requests req
  JOIN ai_analysis_results r ON r.request_id = req.id
  WHERE req.id IN (
    SELECT id FROM version_chain
    UNION
    SELECT a.id FROM ai_analysis_requests a WHERE a.parent_request_id IN (SELECT id FROM version_chain)
  )
)
SELECT * FROM all_versions ORDER BY version_number ASC
```

> 참고: D1은 CTE를 지원하므로 이 패턴 사용 가능. 단, 성능이 우려되면 단순 루프 쿼리로 대체.

---

### Phase 2: "새로운 내용 추가" 기능

#### 2-1. UI: 결과 상세 페이지에 모달/인라인 폼
"내용 추가" 버튼 클릭 → 모달 표시:

```html
<div class="modal">
  <h3>추가 정보 입력</h3>
  <p class="text-wiki-muted text-sm">
    기존 분석에 반영되지 않은 추가 정보가 있나요?<br>
    예: 새로 취득한 자격증, 변경된 관심사, 추가 경력 등
  </p>
  <textarea placeholder="추가로 알려주고 싶은 내용을 자유롭게 입력하세요..." rows="5"></textarea>
  <div class="flex justify-end gap-3">
    <button onclick="closeModal()">취소</button>
    <button onclick="submitAdditionalContext()">분석에 반영하기</button>
  </div>
</div>
```

#### 2-2. API 엔드포인트: `POST /api/ai-analyzer/add-context`
**파일**: `src/services/ai-analyzer/routes.ts`

```typescript
// 요청
{
  original_request_id: number,  // 원본 결과의 request_id
  additional_text: string       // 사용자가 입력한 자유 텍스트
}

// 처리 흐름:
// 1. 원본 request의 session_id 조회
// 2. 자유 텍스트를 facts로 추출하여 analyzer_facts에 추가
//    - fact_key: 'additional_context.v{N}'
//    - source: 'user_input'
// 3. round_answers에 추가 턴으로 저장
//    - round_number: 4 (추가 입력용)
//    - purpose_tag: 'SUPPLEMENT'
// 4. 새 ai_analysis_request 생성
//    - parent_request_id = original_request_id
//    - version_number = 원본.version_number + 1
//    - version_note = '내용 추가'
// 5. 기존 분석 파이프라인 재실행 (확장된 context 포함)
// 6. 새 ai_analysis_result 저장
// 7. 새 결과 페이지로 리다이렉트
```

#### 2-3. 분석 파이프라인에 추가 컨텍스트 반영
기존 `ReporterInput`에 `additionalContext` 필드 추가:
```typescript
interface ReporterInput {
  // ... 기존 필드
  additionalContext?: string  // 자유 텍스트 추가 입력
}
```

`llm-reporter.ts`의 프롬프트에 추가 컨텍스트 섹션 포함:
```
[추가 정보 (사용자 직접 입력)]
{additionalContext}
```

---

### Phase 3: "입력한 내용 수정" 기능

#### 3-1. 경고 페이지 (수정 전 안내)
"입력 수정" 클릭 → 전용 안내 페이지 표시:

```html
<div class="max-w-2xl mx-auto space-y-6">
  <h2>입력 내용 수정 안내</h2>

  <!-- 경고 1: 초반 단계 수정 -->
  <div class="warning-card border-amber-500/30">
    <h4>⚠️ 기본 정보 수정 시 (Step 1-2)</h4>
    <p>상태좌표, 기본 질문 등 초기 단계 답변을 수정하면,
       이를 기반으로 생성되는 <strong>심층 질문(Step 3)이 완전히 새로 생성</strong>됩니다.</p>
    <div class="example">
      <p>예시: "현재 직장인"에서 "학생"으로 변경하면,
         경력 관련 심층 질문이 학업/진로 관련 질문으로 바뀝니다.
         이전에 답했던 심층 질문 답변은 모두 초기화됩니다.</p>
    </div>
  </div>

  <!-- 경고 2: 심층 질문만 수정 -->
  <div class="info-card border-blue-500/30">
    <h4>ℹ️ 심층 질문 답변만 수정 시 (Step 3)</h4>
    <p>특정 라운드의 답변만 수정하면,
       <strong>해당 라운드 이후의 질문과 답변이 초기화</strong>됩니다.</p>
    <div class="example">
      <p>예시: Round 1 답변을 수정하면, Round 2·3의 질문이
         새로 생성되며 다시 답해야 합니다.
         Round 3만 수정하면 Round 3 답변만 다시 작성합니다.</p>
    </div>
  </div>

  <!-- 현재 답변 요약 표시 -->
  <div class="summary-card">
    <h4>현재 입력 내용 요약</h4>
    <div>Step 1: 상태좌표 — 직장인 / 5년차 / ...</div>
    <div>Step 2: 기본 질문 — 관심 분야: AI, 데이터... </div>
    <div>Step 3: 심층 질문 — 3라운드 완료</div>
  </div>

  <button onclick="startEditing()">수정 시작하기</button>
  <a href="javascript:history.back()">취소</a>
</div>
```

#### 3-2. 수정 모드 분석기 진입
**URL**: `/analyzer/{type}?session={sessionId}&edit=true&from_result={requestId}`

분석기 프론트엔드 수정사항:
- `edit=true` 쿼리 파라미터 감지
- Step 1: `analyzer_drafts.step1_answers_json`에서 pre-fill
- Step 2: `analyzer_drafts.step2_answers_json`에서 pre-fill
- Step 3: 기존 `round_answers`에서 pre-fill (수정 시 cascade warning)

#### 3-3. Cascade Reset 로직
```
수정 감지 체크:
├── Step 1-2 답변이 변경됨?
│   ├── YES → Step 3 (모든 라운드) 답변 초기화
│   │         → 새 질문 생성 (LLM interviewer 재실행)
│   │         → 경고 모달: "심층 질문이 새로 생성됩니다"
│   └── NO → Step 3로 이동 (기존 답변 유지)
│
└── Step 3 특정 라운드 답변이 변경됨?
    ├── Round 1 변경 → Round 2, 3 초기화 + 새 질문
    ├── Round 2 변경 → Round 3 초기화 + 새 질문
    └── Round 3 변경 → Round 3만 재답변
```

#### 3-4. API 엔드포인트: `POST /api/ai-analyzer/edit-reanalyze`
```typescript
{
  original_request_id: number,
  modified_steps: {
    step1?: StepAnswers,  // 수정된 경우만
    step2?: StepAnswers,
    // step3는 분석기 플로우에서 직접 처리
  },
  cascade_acknowledged: boolean  // 사용자가 cascade 경고에 동의함
}
```

#### 3-5. 완료 시 결과 저장
- 새 `ai_analysis_request` 생성 (parent_request_id 연결)
- version_note = '입력 수정'
- 전체 분석 파이프라인 실행
- 결과 저장 후 새 결과 상세 페이지로 이동

---

## 수정 대상 파일 요약

| Phase | 파일 | 변경 내용 |
|-------|------|----------|
| 1 | `migrations/0036_add_result_versioning.sql` | 신규: parent_request_id, version_number, version_note |
| 1 | `src/index.tsx` (~26399) | 결과 상세: 액션 버튼 + 버전 네비 + 버전 체인 조회 |
| 1 | `src/templates/user/userAiResults.tsx` | 결과 목록: 버전 그룹핑 |
| 1 | `src/index.tsx` (~26051) | 결과 목록 쿼리: 버전 체인 JOIN |
| 2 | `src/services/ai-analyzer/routes.ts` | 신규 endpoint: POST /api/ai-analyzer/add-context |
| 2 | `src/services/ai-analyzer/llm-reporter.ts` | additionalContext 프롬프트 반영 |
| 2 | `src/services/ai-analyzer/types.ts` | ReporterInput에 additionalContext 추가 |
| 3 | `src/index.tsx` (~2200-8400, 분석기 UI) | edit mode: pre-fill + cascade warning |
| 3 | `src/services/ai-analyzer/routes.ts` | 신규 endpoint: POST /api/ai-analyzer/edit-reanalyze |
| 3 | `src/services/ai-analyzer/draft-routes.ts` | 기존 답변 로드 API |

---

## 구현 순서 (권장)

```
Phase 1 (인프라)      ← 먼저. 버전 관리 없이 2·3 진행 불가
  ↓
Phase 2 (내용 추가)   ← 비교적 단순. 자유 텍스트 → CAG → 재분석
  ↓
Phase 3 (입력 수정)   ← 가장 복잡. 분석기 UI 대폭 수정 필요
```

예상 작업량:
- Phase 1: 중간 (DB 마이그레이션 + 결과 페이지 UI + 목록 UI)
- Phase 2: 중간 (모달 UI + API + 리포터 수정)
- Phase 3: 대형 (분석기 전체 플로우 수정 + cascade 로직 + pre-fill)

---

## 검증 방법

### Phase 1
- 마이그레이션 적용 → 기존 결과 정상 조회 확인 (parent_request_id = NULL)
- 결과 상세 페이지에 버튼 표시 확인

### Phase 2
- 결과 상세에서 "내용 추가" → 텍스트 입력 → 새 버전 결과 생성 확인
- 버전 네비에서 v1 ↔ v2 전환 확인
- 결과 목록에서 버전 그룹핑 확인

### Phase 3
- "입력 수정" → 경고 페이지 표시 확인
- 분석기에서 기존 답변 pre-fill 확인
- Step 1 수정 시 cascade reset 경고 확인
- 완료 후 새 버전 결과 생성 + 이전 버전 보존 확인

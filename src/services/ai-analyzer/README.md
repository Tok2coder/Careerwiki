# AI Analyzer Service

CareerWiki 직업 추천 AI 분석기

## Version

- **Scoring**: `scoring-v0.2.1-final`
- **Recipe**: `recipe-v1.0.0`
- **Tagger**: `tagger-v1.0.0`

## 라우트 연결

```typescript
// src/index.tsx
import { analyzerRoutes } from './services/ai-analyzer'

app.route('/api/ai-analyzer', analyzerRoutes)
```

**Prefix**: `/api/ai-analyzer`

## Phase 0 Setup

### 1. D1 바인딩 확인 (wrangler.jsonc)

```jsonc
"d1_databases": [{
  "binding": "DB",                    // ← env.DB로 접근
  "database_name": "careerwiki-db",
  "database_id": "edc21e23-c2ac-4693-bb79-389b6914e173"
}]
```

### 2. D1 스키마 생성

```bash
# 로컬 개발
wrangler d1 execute careerwiki-db --local --file=src/services/ai-analyzer/schema.sql

# 프로덕션
wrangler d1 execute careerwiki-db --file=src/services/ai-analyzer/schema.sql
```

### 2. 스키마 확인

```bash
wrangler d1 execute careerwiki-db --local --command="SELECT name FROM sqlite_master WHERE type='table'"
```

예상 출력:
```
┌──────────────────────────┐
│ name                     │
├──────────────────────────┤
│ raw_events               │
│ ai_analysis_requests     │
│ ai_analysis_results      │
│ followup_responses       │
│ confirmed_constraints    │
└──────────────────────────┘
```

## API Endpoints

### `POST /api/ai-analyzer/analyze`

분석 요청 생성 및 처리

**Request:**
```json
{
  "session_id": "session-123",
  "user_id": "user-456",
  "profile": {
    "interest": { "keywords": ["AI", "데이터분석", "성장"] },
    "value": { "priority": ["성장", "자율"] },
    "skill": [
      { "name": "python", "level": "intermediate" },
      { "name": "sql", "level": "beginner" }
    ],
    "dislike": { "keywords": ["영업", "반복업무"] },
    "constraints": {
      "work_hours_strict": true,
      "remote_only": false
    }
  }
}
```

**Response:**
```json
{
  "success": true,
  "request_id": 1,
  "result": {
    "versions": { ... },
    "fit_top3": [ ... ],
    "ux_flags": { ... }
  }
}
```

### `POST /api/ai-analyzer/followup`

follow-up 응답 처리

**Request:**
```json
{
  "request_id": 1,
  "question_id": "q-123",
  "constraint": "work_hours_strict",
  "job_id": "job-456",
  "answer": "no"
}
```

**Response (answer: "no"):**
```json
{
  "success": true,
  "action": "replaced",
  "replaced_with": { "job_id": "job-789", "job_name": "대체 직업" },
  "fact_saved": {
    "fact_key": "confirmed_constraint.work_hours_strict",
    "fact_value": { ... }
  }
}
```

### `GET /api/ai-analyzer/result/:requestId`

분석 결과 조회

### `GET /api/ai-analyzer/session/:sessionId`

세션별 전체 이력 조회 (Event Sourcing 재생용)

## Constraint Types (표준 5개만 허용!)

| Type | Label | Risk Penalty |
|------|-------|--------------|
| `work_hours_strict` | 야근 절대 불가 | 40 |
| `remote_only` | 원격만 가능 | 35 |
| `shift_work_no` | 교대근무 절대 불가 | 40 |
| `degree_impossible` | 학위 취득 불가 | 30 |
| `license_impossible` | 자격증 준비 불가 | 25 |

⚠️ **금지 키 (절대 사용 금지)**:
- ❌ `work_hours` → ✅ `work_hours_strict`
- ❌ `shift_work` → ✅ `shift_work_no`

## File Structure

```
src/services/ai-analyzer/
├── index.ts          # 모듈 export
├── types.ts          # TypeScript 타입 정의
├── routes.ts         # API 핸들러 (Hono)
├── schema.sql        # D1 테이블 스키마
└── README.md         # 이 문서
```

## 설계 결정 사항

### FK intentionally omitted

D1/SQLite 환경에서 FK 제약이 개발/리플레이를 불편하게 만들어서 제거함.
대신 "논리적 join + event sourcing" 패턴 사용.

- 조회 성능은 INDEX로 보강
- 데이터 정합성은 애플리케이션 레벨에서 관리

## 착수 확인 체크리스트

Phase 0 완료 시 아래 3가지가 YES여야 함:

- [x] D1에 request/result/followup이 **모두 저장되고 조회되는지**
- [x] result_json에 versions(레시피/태거/스코어링)가 **항상 포함되는지**
- [x] constraint_type이 **표준 5개 외에는 절대 안 들어오는지** (CHECK 제약)


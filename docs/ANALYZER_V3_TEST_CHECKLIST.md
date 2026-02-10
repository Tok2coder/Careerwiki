# AI Analyzer V3 테스트 체크리스트

## 버전
- V3 LLM+RAG 리팩토링 (2026-01-16)
- 브랜치: `feature/analyzer-llm-rag-main`

## 개요

V3 리팩토링의 핵심 목표:
1. **TAG 의존도 축소**: 80개 → 500개+ 후보 검색
2. **LLM+RAG 중심**: TAG는 필터/리스크로만 사용
3. **3라운드 심층 질문**: 개인화된 LLM 질문 생성
4. **프리미엄 리포트**: 전문가급 심리 분석 + 직업 추천

---

## 테스트 시나리오

### 시나리오 A: 학생 탐색형

**프로필**:
- 단계: `job_explore` 또는 `job_student`
- 관심사: 기술, 분석
- 싫어하는 것: 영업, 반복
- 우선순위: 성장

**검증 포인트**:
- [ ] Step1 상태 선택 정상 작동
- [ ] Step2 서술형 질문 2개 표시됨 (성인 단계)
- [ ] Step2 서술형 최소 50자 검증 작동
- [ ] Step3 3라운드 UI 표시됨
- [ ] Round 1 질문이 "동기/에너지" 관련
- [ ] Round 2 질문이 "회피/두려움" 관련
- [ ] Round 3 질문이 "현실/실행" 관련
- [ ] 결과에 evidenceQuotes 포함 (원문 인용)
- [ ] Top 결과가 80개 태깅 직업에 갇히지 않음

### 시나리오 B: 직장인 이직형

**프로필**:
- 단계: `job_mid`
- 관심사: 창의, 자율
- 싫어하는 것: 야근, 회의
- 우선순위: WLB
- 제약: 야근 불가 (`work_hours_strict`)

**검증 포인트**:
- [ ] Hard Exclusion 작동: 야근 많은 직업 제외됨
- [ ] Risk Penalty 작동: 야근 종종 있는 직업에 경고 표시
- [ ] 서술형 답변이 SearchProfile에 반영됨
- [ ] 라운드 질문이 이전 답변 기반으로 개인화됨
- [ ] Fit/Desire/Feasibility 점수 표시
- [ ] 30일 실행 플랜 포함

### 시나리오 C: 경력전환/번아웃형

**프로필**:
- 단계: `job_transition`
- 서술형 1: "매일 같은 보고서를 작성할 때 나를 잃었다고 느꼈다"
- 서술형 2: "새로운 프로젝트 기획할 때 살아있다고 느꼈다"
- 우선순위: 의미

**검증 포인트**:
- [ ] 서술형 답변이 분석에 반영됨 (evidenceQuotes에 인용)
- [ ] 내면 갈등 분석 섹션 표시
- [ ] 성장 곡선 유형 표시
- [ ] 스트레스 프로필 표시
- [ ] 전문가 조언 (doNow/stopDoing/experiment) 표시
- [ ] 삶의 버전 문장 표시

---

## 검증 기준 (필수 통과)

### 1. 후보군 다양성
```
✓ Top 결과가 태그 있는 80개에 갇히지 않는다
✓ Vectorize 검색 결과 최소 200개 이상 반환
✓ 태깅되지 않은 직업도 결과에 포함될 수 있음
```

### 2. 근거 인용
```
✓ 각 추천 직업에 evidenceQuotes 2개 이상 존재
✓ 인용은 사용자 원문 그대로 (새로 만들지 않음)
✓ source 정보 (step, round, questionId) 포함
```

### 3. 3세트 추천 다양성
```
✓ Overall Top5 / Fit Top10 / Desire Top10이 실제로 다르다
✓ 완전히 동일하면 실패
✓ 각 세트의 정렬 기준이 다름 확인
```

### 4. 리포트 섹션 완성도
```
✓ Executive Summary 존재
✓ Work Style Map 5개 축 점수 존재
✓ 내면 갈등 분석 존재
✓ 실패 패턴 / 스트레스 프로필 존재
✓ 성장 곡선 유형 존재
✓ 전환 타이밍 (30/60/90) 존재
✓ 삶의 버전 문장 존재
✓ 전문가 조언 존재
```

### 5. 안전 규칙 준수
```
✓ 진단명 단정 표현 없음 (우울증, ADHD 등)
✓ "~경향이 있다", "~패턴이 보인다" 등 완화 표현 사용
✓ 위험 신호 시 전문가 권유 1줄만 (과도 금지)
```

---

## API 테스트

### 1. 라운드 질문 생성
```bash
curl -X POST http://localhost:8788/api/ai-analyzer/v3/round-questions \
  -H "Content-Type: application/json" \
  -d '{
    "session_id": "test-123",
    "round_number": 1,
    "narrative_facts": {
      "highAliveMoment": "팀 프로젝트에서 제 아이디어가 채택됐을 때",
      "lostMoment": "매일 같은 보고서를 작성할 때"
    }
  }'

# 예상 응답
{
  "success": true,
  "round": 1,
  "questions": [...],
  "generated_by": "llm" | "fallback",
  "metadata": {...}
}
```

### 2. 서술형 답변 저장
```bash
curl -X POST http://localhost:8788/api/ai-analyzer/v3/narrative-facts \
  -H "Content-Type: application/json" \
  -d '{
    "session_id": "test-123",
    "high_alive_moment": "...",
    "lost_moment": "..."
  }'
```

### 3. 라운드 답변 저장
```bash
curl -X POST http://localhost:8788/api/ai-analyzer/v3/round-answers \
  -H "Content-Type: application/json" \
  -d '{
    "session_id": "test-123",
    "round_number": 1,
    "answers": [
      {"question_id": "q1", "answer": "...", "purpose_tag": "ENGINE"}
    ]
  }'
```

---

## 배포 전 체크리스트

### DB 마이그레이션
- [ ] `017_premium_report_v3.sql` 실행
- [ ] `narrative_facts` 테이블 생성 확인
- [ ] `round_answers` 테이블 생성 확인
- [ ] `llm_judge_cache` 테이블 생성 확인
- [ ] `ai_analysis_results.engine_version` 컬럼 추가 확인

### 바인딩 확인
- [ ] Vectorize 바인딩 활성화 (`wrangler.jsonc`)
- [ ] Workers AI 바인딩 활성화

### 기능 테스트
- [ ] V2 기존 로직 정상 작동 (하위 호환)
- [ ] V3 3라운드 플로우 정상 작동
- [ ] 프리미엄 리포트 UI 렌더링
- [ ] 직업 카드 CareerWiki 내부 링크 작동

---

## 알려진 제한사항

1. **Workers AI 토큰 제한**: Llama 3.1 8B는 응답 길이 제한이 있어, 긴 JSON은 잘릴 수 있음
2. **비용**: 현재 Workers AI는 저비용이나, 추후 Gemini 전환 시 비용 관리 필요
3. **전공 추천**: 직업과 동일한 구조로 적용 예정 (majors 임베딩 필요)
4. **Fallback**: LLM 실패 시 rule-based 결과로 대체됨

---

## 롤백 가이드

V3에 문제가 있을 경우:

```javascript
// index.tsx에서 V3 모드 비활성화
window.V3_MODE = false;

// 또는 routes.ts에서 V3 엔드포인트 비활성화
// analyzerRoutes.post('/v3/round-questions', ...) 주석 처리
```

기존 V2 로직은 그대로 유지되어 있으므로 V3 비활성화만으로 롤백 가능.

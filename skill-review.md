# job-data-enhance 스킬 종합 검토 보고서

검토일: 2026-04-16  
검토자: Claude Sonnet 4.6 (sweet-driscoll worktree)  
변경사항: 없음 (read-only review)

---

## 1. 현황 요약

| 파일 | 라인 수 | 추정 토큰 | 용도 |
|------|--------|----------|------|
| `SKILL.md` | 1,296 | ~33,698 | 메인 워크플로우 |
| `references/fields.md` | 322 | ~4,000 | 12개 필드 스펙 |
| `references/field-decision-matrix.md` | 108 | ~1,300 | 처리 판단 매트릭스 |
| `references/lessons.md` | 164 | ~2,000 | 교훈 모음 |
| `references/researcher-agent-prompt.md` | 109 | ~1,400 | 서브에이전트 템플릿 |
| `references/sources.md` | 201 | ~2,500 | 출처 등급/포맷 |
| `scripts/validate-job-edit.cjs` | 860 | ~10,000 | 저장 전 검증 |
| `scripts/full-quality-audit.cjs` | 802 | ~9,500 | 저장 후 감사 |
| **합계** | **3,862** | **~64,398** | |

**복잡도 평가**: SKILL.md 단독 33,698 토큰은 Claude 컨텍스트 로드 시 과도한 부담. 실제 Phase 실행 시 전체를 로드하지만 Phase별로 필요한 정보는 전체의 20~30%에 불과.

---

## 2. 토큰 효율성

### 2-A. 코드 중복 (하네스 스크립트)

| 중복 대상 | validate.cjs | audit.cjs | 중복 라인 |
|-----------|-------------|----------|---------|
| `detectMergedSourceText()` 함수 | L26~57 | L98~129 | **~35줄 완전 동일** |
| `TRUNCATED_PATTERNS` 배열 | L432~450 (16개) | L52~71 (17개) | **95% 중복**, audit에 `/[가-힣]{1}에$/` 1개 추가 |
| `COMPLETE_ENDINGS` 배열 | L452~462 | L74~85 | **거의 동일** (audit에 `됩니다` 중복 1개 있음) |

→ `detectMergedSourceText`를 별도 `shared/detect-merged.cjs`로 추출하면 ~35라인 제거 가능. TRUNCATED_PATTERNS도 공유 가능.

### 2-B. SKILL.md 내 규칙 중복

| 규칙 | 등장 위치 | 중복 횟수 |
|------|---------|---------|
| `way`는 반드시 string | 핵심기술규칙 + Phase 1 필수 필드 + lessons[치명-1] + researcher-agent-prompt 절대금지 + Gate1 예시 | **5회** |
| detailReady plain string | 핵심기술규칙 + Phase 1 필수 필드 상세 + lessons[치명-5] + researcher-agent-prompt 절대금지 | **4회** |
| sources 키 오류 (`way_sources` 금지) | Phase 3-B 흔한 키 실수 + lessons[출처-4] + researcher-agent-prompt 절대금지 | **3회** |
| 각주 [N] 중복/순차 규칙 | Phase 2 Gate 1 + lessons[출처-0] + researcher-agent-prompt Gate 1 + fields.md _sources 섹션 | **4회** |
| overviewSalary 수정 금지 | 핵심기술규칙 + Phase 0 보존체크리스트 + Phase 0-C 표 + Phase 1 보강가능 섹션 + Phase 2 추가규칙 | **5회** |
| DB 이미지 키/URL 규칙 | 핵심기술규칙 + (CLAUDE.md에도 동일) | 2회 |

→ 핵심 규칙을 "최상단 1회"로 정규화하고 나머지는 "→ 핵심 기술 규칙 참조" 포인터로 대체하면 SKILL.md 200~300라인 절감 가능.

### 2-C. 감축 가능 영역 (우선순위 순)

1. **각주 규칙 예시 축약**: Gate 1에 ✅/❌ 예시가 12개 이상. 핵심 3개만 남기고 나머지는 `references/footnote-validation.md`로 분리 → 약 80라인
2. **Phase 3-B curl 예시**: 완전한 curl 블록이 있고 sources 키 매핑표도 있음. sources 키 매핑표는 `shared/source-key-mapping.md` 참조로 대체 → 약 50라인
3. **prospect 원문 보존 규칙**: Phase 1 무출처 처리 + Phase 1 기존 데이터 수정 금지 + Phase 2 Gate 0 체크리스트 + Phase 5.5에 4번 반복. 1곳으로 통합 → 약 80라인
4. **Phase 3.5 ↔ Phase 3-C 중복**: 3-C에 커리어트리 요약, 3.5에 상세가 있는데 3.5가 3-C를 흡수하는 구조로 보임. 3-C를 제거하고 3.5로 단일화 → 약 30라인
5. **차단 사이트 폴백 체인**: Phase 1 중간에 삽입된 토큰 효율 가이드 (`WebFetch > WebSearch > Chrome MCP` 등). references 파일로 분리 가능 → 약 20라인

---

## 3. 커버리지 갭

### 3-A. 메모리 피드백 vs. SKILL.md 반영 현황

| 피드백 파일 | 핵심 교훈 | SKILL.md | validate | audit |
|-----------|---------|---------|---------|-------|
| `feedback_api_encoding_windows.md` | curl -d 한글 금지, `--data-binary @파일` 필수 | ✅ Phase 1 YouTube 섹션 | — | — |
| `feedback_audit_gate_incomplete_fields.md` | FAIL 0 ≠ 완료. Gate5 빈필드 FAIL 추가됨 | ❌ **미반영** — SKILL.md에 언급 없음 | — | ✅ Gate5 |
| `feedback_career_tree_politician_exclusion.md` | 역대 대통령 is_active=0, 절대 제외 | ⚠️ "가급적 피하고"만 언급 | ⚠️ WARN 의심만 | — |
| `feedback_chrome_mcp_render_verification.md` | 저장 후 반드시 육안 렌더 확인 | ✅ Phase 4 확인 항목 | — | — |
| `feedback_context_resume_phase_check.md` | draft 존재 ≠ Phase 0 완료. self-report 먼저 확인 | ⚠️ **재개 체크리스트 없음** | — | — |
| `feedback_curriculum_footnote_omission.md` | 항목마다 [N] 따로, 수정 시 전체 재부여 | ✅ Phase 5.5 curriculum 체크 | ✅ OS-Orphan FAIL | — |
| `feedback_silent_skip_forbidden.md` | youtubeLinks 빈배열 → _youtubeSearchNote FAIL | ❌ **SKILL.md에 없음** | ✅ FAIL | ⚠️ WARN |
| `feedback_silent_skip_forbidden.md` | careerTree 없음 → _careerTreeNote 필수 | ❌ **SKILL.md에 없음** | ❌ **없음** | ⚠️ WARN |
| `feedback_subagent_field_checklist.md` | 17개 필드 명시 + careerTree 추가 | ⚠️ 필드 목록 있지만 17개 카운트 없음 | — | — |
| `feedback_validate_bypass_risk.md` | 일회성 스크립트 = validate 미호출 → require() 필수 | ❌ **완전 미반영** | — | — |

### 3-B. SKILL.md 언급 있지만 validate/audit이 체크 못 하는 규칙

| 규칙 | 이유 |
|------|------|
| prospect 원문 방향 보존 (증가↔감소 반전 금지) | 텍스트 의미 분석 불가 → Gate 6에서 키워드 기반 부분 감지만 |
| 한국어 YouTube 영상만 허용 | 언어 감지 API 없음 → validate/audit 미체크 |
| sidebarOrgs URL 생존 여부 | WebFetch 필요 → validate 미체크 |
| 출처 URL ↔ 텍스트 내용 일치 (WebFetch 대조) | 외부 HTTP 요청 → 자동화 불가 |
| 기존 trivia 무단 교체 방지 | 의미 비교 불가 → Phase 5.5 수동 체크만 |
| 대통령 인물 제외 (is_active=0) | validate에 suspicious roles WARN만 있고 FAIL 아님 |

### 3-C. SKILL.md에 없지만 validate/audit에 있는 규칙

| 규칙 | 위치 | SKILL.md |
|------|------|---------|
| `_youtubeSearchNote` 미기재 시 FAIL | validate Rule 9b | ❌ 완전 없음 |
| `_careerTreeNote` 미기재 시 WARN | audit Gate 5(k) | ❌ 완전 없음 |
| 검색결과 URL 패턴 FAIL (saramin cat_kewd 등) | validate Rule 10 | Phase 1에 부분 언급 |
| OS-Orphan (출처 등록됐지만 마커 없음) FAIL | validate Rule 1 | 간략 언급만 |
| `detailReady.researchList` 포함 시 FAIL | validate Rule 1 | ✅ 핵심 기술 규칙에 있음 |
| `detailReady.certificate` 본문 FAIL | validate Rule 1 | ✅ 핵심 기술 규칙에 있음 |
| Gate 6: diff-snapshot 배열 수 감소 FAIL | audit Gate 6 | ⚠️ Phase 5.5에 수동 체크만 |

### 3-D. Self-Report 17필드 존재 여부

**SKILL.md에 "Self-Report 17필드" 표/섹션이 존재하지 않는다.**

- `grep "Self-Report"` → 0결과
- audit.cjs Gate 5(k)에서 `"SKILL.md Self-Report 17번"` 참조하지만 해당 섹션이 없음
- researcher-agent-prompt.md에는 qualityGates 4개 self-check이 있지만 17필드 표 아님
- **결론**: audit이 없는 섹션을 참조하는 "유령 참조" 존재

### 3-E. careerTree 지침 완성도

- 인물 선정 기준: Phase 3-C + Phase 3.5에 중복으로 있음
- 대통령 제외 규칙: "정치적 중립 — 정치인 출신은 가급적 피하고" (SKILL.md) vs 메모리 "역대 대통령 절대 제외(is_active=0 유지)" → **실제 규칙보다 약하게 기술됨**
- _careerTreeNote: SKILL.md에 완전히 없음

### 3-F. 이미지 재생성 연동

- SKILL.md에 이미지 관련 내용: R2 키 규칙 + DB image_url 형식만 (CLAUDE.md 수준)
- 이미지 재생성 트리거 조건, ComfyUI/Ollama 연동, LoRA 사용법 등 완전히 없음
- **결론**: job-data-enhance 스킬은 이미지 재생성과 연동되지 않음 (별도 시스템)

---

## 4. 구조/흐름 개선 여지

### 4-A. Phase 번호 순서 문제

실제 실행 순서와 SKILL.md 섹션 순서가 불일치:

```
실제 실행 순서:
Phase 0 → Phase 1 → Phase 2 → Phase 3 → Phase 5.5 (API 직전 self-check)
→ Phase 3.5 (careerTree) → Phase 4 (프로덕션 검증) → Phase 5 (각주 수선)

SKILL.md 섹션 순서:
Phase 0 → Phase 1 → Phase 2 → Phase 3 → Phase 3-C(careerTree 요약)
→ Phase 3.5(careerTree 상세) → Phase 4 → Phase 5.5 → Phase 5
```

**문제**: "Phase 5.5: API 호출 직전 Self-check"가 Phase 4 (배포 후 검증) **뒤에** 위치.  
논리적으로 Phase 3 직후 (API 호출 직전)에 있어야 하는데 Phase 4 다음에 나옴.  
이름은 "직전"인데 위치는 "직후" — 혼란 유발.

**제안**:
```
Before: Phase 3 → Phase 3.5 → Phase 4 → Phase 5.5 → Phase 5
After:  Phase 3 → Phase 3.5 (self-check 포함) → Phase 4 → Phase 5
```
Phase 5.5 내용을 Phase 3 말미 또는 Phase 3.5 앞에 통합하면 번호 혼란 해소.

### 4-B. Self-Report 메커니즘 실효성 문제

- SKILL.md에 "Self-Report 17필드" 섹션 자체가 없음
- researcher-agent-prompt.md의 `qualityGates` 4개 자가 검증은 구조적으로 잘 돼 있음
- 하지만 서브에이전트를 쓰지 않을 때 (팀 리더가 직접 작성할 때) 동일 체크를 강제하는 메커니즘이 없음
- **결론**: qualityGates 체크리스트를 Phase 2 말미에 명시하면 일관성 확보

### 4-C. Phase 3.5 위치 타당성

- "Phase 3 직후 또는 Phase 3과 병행" 명시 → 위치(Phase 3 직후)는 맞음
- 단, Phase 3-C와 Phase 3.5가 동일 주제(careerTree) 중복
- Phase 3-C (요약, 약 20라인)는 삭제하고 Phase 3.5로 완전 통합 권장

### 4-D. 서브에이전트 연동 방식 명시 부재

- researcher-agent-prompt.md 존재하지만 SKILL.md Phase 1에 "서브에이전트를 쓸 때는 이 프롬프트를 사용" 가이드 없음
- 언제 서브에이전트를 쓰고 언제 팀리더가 직접 하는지 기준 불명확
- **제안**: Phase 1 시작부에 "배치 처리 시 → researcher-agent-prompt.md 사용, 단일 직업 시 → 팀리더 직접" 분기점 추가

### 4-E. Resume/재개 안전장치 부재

`feedback_context_resume_phase_check.md`에 기록됐지만 SKILL.md에 재개 체크리스트 없음.

**제안 (Before/After)**:

Before: Phase 0부터 시작하는 설명만 있음

After (Phase 0 앞에 추가):
```
## ⚡ 재개 체크리스트 (이전 세션에서 이어받을 때)

draft 파일이 존재해도 아래를 먼저 확인한다:
- [ ] Phase 0 진단이 실제로 완료됐는가? (진단 결과 출력 확인)
- [ ] DB 현재값을 다시 조회하여 draft와 비교했는가?
- [ ] validate 실행 없이 API 호출하지 않았는가?

draft 존재 ≠ Phase 0-1 완료. 반드시 재확인 후 진행.
```

---

## 5. 실패 패턴 → 스킬 개선안 매핑

| 반복 실수 | 원인 (스킬 문구) | 개선안 |
|---------|--------------|-------|
| curriculum 항목 일부에만 [N] | "마지막 항목에만 [N]" 규칙이 "섹션 블록"과 "개별 항목" 규칙을 혼용하여 오독 유발 | "항목별 출처가 다르면 → 각 항목에 [N]" 규칙을 **첫 번째로** 제시하고, "동일 출처 연속 항목만 → 마지막 하나"를 예외로 명시 |
| 출처 병합 (validate WARN이지만 반복) | WARN이라 넘어가는 습관. SKILL.md에 "한 source = 한 기관" 규칙이 sources.md에만 있음 | 핵심 기술 규칙 표에 "병합 출처 금지" 행 추가 |
| context 재개 시 Phase 전제 | 재개 절차 없음 | 4-E 제안대로 재개 체크리스트 추가 |
| _youtubeSearchNote 누락 | SKILL.md에 이 필드 언급 자체 없음 | Phase 2 Gate 3 또는 핵심 기술 규칙에 "_youtubeSearchNote / _careerTreeNote 필수" 명시 |
| careerTree에 대통령 포함 | "가급적 피하고"라는 약한 표현 | "역대 대통령 절대 금지 (is_active=0 인물)" 으로 강도 상향 |
| researcher-agent에 17필드 누락 | "17개" 카운트가 없어 얼마나 넣어야 하는지 불명확 | researcher-agent-prompt.md 채울 필드 목록에 번호 붙이고 "총 17개" 명시 |

---

## 6. 하네스 정합성 (3-way diff)

| 규칙 | SKILL.md | validate.cjs | audit.cjs | 상태 |
|------|---------|-------------|----------|-----|
| `way` 배열 금지 | ✅ 5곳 | ✅ Rule 7 FAIL | ✅ Gate5 | ✅ 완전 커버 |
| detailReady plain string | ✅ 4곳 | ✅ Rule 12 FAIL (curriculum/training) | ❌ 객체 여부 미체크 | ⚠️ audit 갭 |
| 각주 중복/비순차 | ✅ Gate 1 | ✅ Rule 4 FAIL | ✅ Gate 1 | ✅ 완전 커버 |
| 잘린 문장 패턴 | ✅ Gate 2 (20개) | ✅ Rule 8 (16패턴) | ✅ Gate 2 (17패턴) | ⚠️ validate 1개 부족 (`[가-힣]{1}에$`) |
| YouTube oembed 실존 | ✅ Gate 3 | ❌ URL 포맷만 | ✅ Gate 3 FAIL | ⚠️ validate 미체크 |
| 한국어 YouTube | ✅ Gate 3 | ❌ 없음 | ❌ 없음 | ⚠️ 자동화 불가 (수동만) |
| overviewSalary 수정 금지 | ✅ 5곳 | ✅ Rule 9a FAIL | ✅ Gate2 wage 손실 | ✅ 완전 커버 |
| merged sources WARN | ✅ sources.md | ⚠️ WARN (FAIL 아님) | ⚠️ WARN (FAIL 아님) | ⚠️ 모두 WARN — FAIL 격상 검토 필요 |
| sidebarOrgs 필요 | ✅ Phase 0-E | ❌ [N] 마커만 체크 | ✅ Gate 5(h) FAIL | ⚠️ validate 갭 |
| _youtubeSearchNote | ❌ 없음 | ✅ Rule 9b FAIL | ⚠️ WARN | ⚠️ SKILL 갭 |
| _careerTreeNote | ❌ 없음 | ❌ 없음 | ⚠️ WARN | ⚠️ SKILL + validate 갭 |
| prospect 방향 보존 | ✅ 4곳 | ❌ 없음 | ✅ Gate 6 FAIL (키워드) | ⚠️ validate 갭 |
| validate bypass 방지 | ❌ 없음 | — | — | ❌ 완전 미반영 |
| 대통령 인물 제외 | ⚠️ 약하게 | ⚠️ WARN (suspicious roles) | ❌ 없음 | ⚠️ 전체 약함 |
| diff-snapshot Gate 6 | ⚠️ Phase 5.5 수동 | — | ✅ Gate 6 FAIL | ⚠️ SKILL 설명 약함 |
| Self-Report 17필드 | ❌ 섹션 없음 | — | ⚠️ WARN 참조 (유령) | ❌ 유령 참조 |

---

## 7. 우선순위별 액션 아이템

### 🔴 High (즉시 수정 필요 — 실제 버그/데이터 손실 위험)

**H1. SKILL.md에 `_youtubeSearchNote` / `_careerTreeNote` 추가**
- validate가 FAIL을 던지지만 SKILL.md에 설명 없음 → 실행 시 "왜 FAIL인지" 모름
- 위치: Phase 2 Gate 3 or 핵심 기술 규칙 표

**H2. Phase 5.5 위치 수정**
- "API 호출 직전 Self-check"인데 Phase 4 (배포 후 검증) 뒤에 있음
- Phase 3 말미 또는 Phase 3과 Phase 3.5 사이로 이동

**H3. 대통령 인물 제외 규칙 강화**
- "가급적 피하고" → "역대 대통령은 is_active=0 인물이므로 절대 금지"
- validate에서도 suspicious roles WARN → FAIL로 격상 검토

**H4. "Self-Report 17필드" 섹션 생성 또는 audit 참조 수정**
- audit.cjs Gate 5(k)에서 "SKILL.md Self-Report 17번" 참조하지만 해당 섹션 없음
- 섹션 추가 또는 audit 메시지에서 유령 참조 제거

**H5. validate에 `_careerTreeNote` 체크 추가**
- audit WARN이지만 validate는 체크 없음
- youtubeLinks와 동일하게 careerTree null 제출 시 _careerTreeNote 필수 FAIL 추가

### 🟡 Medium (품질 개선 — 반복 실수 방지)

**M1. 재개(resume) 체크리스트 추가**
- Phase 0 앞에 "이전 세션 재개 시" 절차 추가 (feedback_context_resume_phase_check 반영)

**M2. curriculum 각주 규칙 설명 순서 변경**
- "항목별 출처 다르면 각각 [N]"을 **첫 번째로**, "동일 출처 연속이면 마지막만"을 예외로
- 현재는 반대 순서라 "섹션 블록 마지막 하나" 오독 유발

**M3. detectMergedSourceText 공유 모듈 추출**
- validate.cjs + audit.cjs 에 35라인 완전 동일 코드 중복
- `scripts/shared/detect-merged.cjs`로 추출

**M4. TRUNCATED_PATTERNS 불일치 수정**
- validate: 16개 패턴, audit: 17개 (`/[가-힣]{1}에$/` 추가)
- validate에 누락된 1개 패턴 추가

**M5. validate_bypass_risk SKILL.md 반영**
- "일회성 스크립트 작성 시 validate() 직접 호출 필수" 규칙 추가
- 위치: Phase 3-A 또는 Critical Rules 하단

**M6. researcher-agent-prompt.md 필드에 번호 + "총 X개" 명시**
- 서브에이전트 누락 방지

**M7. 핵심 기술 규칙 정규화**
- way/detailReady/salary 규칙이 5군데 반복 → 각 필드 등장 위치에서 "→ 핵심 기술 규칙 참조" 포인터 사용

### 🟢 Low (장기적 최적화)

**L1. SKILL.md 분량 감축 목표**
- 현재 1,296라인 → 목표 900라인 (-30%)
- 중복 제거 + 예시 축약 + references 포인터 활용

**L2. Phase 3-C + Phase 3.5 통합**
- Phase 3-C (careerTree 20라인 요약) 삭제 → Phase 3.5로 단일화

**L3. 차단 사이트 폴백 체인 분리**
- Phase 1 본문 중간에 삽입된 WebFetch 폴백 가이드를 references로 이동

**L4. merged sources WARN → FAIL 격상 검토**
- 현재 양쪽 모두 WARN이라 무시하는 패턴 발생
- "워크넷 및 커리어넷"처럼 명백한 병합은 FAIL로 격상 검토

**L5. Gate 6 diff-snapshot 연동 가이드 SKILL.md 추가**
- Phase 0에서 스냅샷 저장 절차 명시 (현재 audit에만 있고 SKILL에 언급 없음)

---

## 8. 요약 판단

스킬의 **설계 자체는 우수**하다. Phase 구조, 하네스 자동화, lessons.md 학습 루프, researcher-agent 분리 모두 잘 설계됐다. 실패의 주요 원인은 설계 문제가 아니라:

1. **SKILL.md가 너무 길어** 중요 규칙이 묻힘 (way 규칙 5군데 반복인데도 실수 반복)
2. **Phase 5.5 위치 혼란** — "직전" 체크가 "직후" 위치에 있음
3. **_youtubeSearchNote / _careerTreeNote** — validate/audit에는 있는데 SKILL.md에 없어 "왜 FAIL인지" 불투명
4. **재개 체크리스트 없음** — 컨텍스트 이어받기 패턴 대응 부재
5. **Self-Report 유령 참조** — audit이 없는 섹션을 참조

이 5가지만 해결해도 반복 실수의 70%가 방지될 것으로 추정된다.

---

*보고서 생성: 2026-04-16, sweet-driscoll worktree, read-only*

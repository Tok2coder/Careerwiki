# Wave 2 / Session D — Phase 7: 직업 정보 데이터 보완

> **이 파일을 읽고 팀을 구성한 뒤 Phase 7 작업을 시작하세요.**
> **선행 조건**: Wave 1의 Phase 4 (편집 시스템 안정화) 완료 후 시작. `git pull` 필수.

---

## 1. 공통 컨텍스트

### 프로젝트 개요
- **CareerWiki**: 한국어 진로 정보 위키 + AI 직업/전공 추천 플랫폼
- **Production**: https://careerwiki.org
- **Tech Stack**: Cloudflare Workers (Pages) + Hono + D1 (SQLite) + R2 + KV + Vectorize

### 배포 절차 (코드 수정 없음 — API 호출 + D1 조회)
```
이 세션은 데이터 보완 작업이므로 코드 수정이 없습니다.
기존 편집 API로 데이터를 업데이트합니다.
```

### 절대 금지
- 코드 파일 수정
- `DROP TABLE`, `DELETE FROM` (WHERE 없이)
- 출처 없는 통계/수치 입력
- 기존 데이터 덮어쓰기 (기존 데이터가 있으면 보완만, 삭제 금지)

### 필수 읽기 파일
1. `CLAUDE.md` — 프로젝트 규칙 전체
2. `MASTER_PLAN.md` — Phase 7 섹션
3. `src/templates/unifiedJobDetail.ts` — 직업 상세 페이지 데이터 구조 (각 필드 포맷 확인)
4. `src/routes/job-editor.ts` — 편집 API 스펙

---

## 2. 팀 구성

| 역할 | 모델 | 실행 방식 | 임무 |
|------|------|----------|------|
| Team Leader | Opus (메인) | 메인 세션 | 조율, 데이터 품질 검수, 포맷 일관성 확인 |
| Analyst | Sonnet | Task(run_in_background) | 전체 직업 데이터 현황 분석, 빈 필드 통계 |
| Researcher | Sonnet | Task(run_in_background) | Deep Research: 직업별 정보 수집, 출처 검증 |
| Content Creator | Sonnet | Task(run_in_background) | 기존 포맷에 맞춰 데이터 가공 |
| Implementer | Sonnet | Task (순차) | 편집 API 호출, 프로덕션 확인 |

에이전트 정의: `.claude/agents/analyst.md`, `researcher.md`, `content-creator.md`, `implementer.md`

### 실행 패턴
```
1. Analyst → Task(run_in_background): 전체 직업 데이터 현황 분석
   - 어떤 직업에 어떤 필드가 비어있는지 전수 조사
   - 기존 데이터의 포맷/스타일 패턴 파악
2. Team Leader: 분석 결과 기반으로 보완 우선순위 결정
3. Researcher → Deep Research: 우선 직업들의 정보 수집
4. Content Creator → 기존 포맷에 맞춰 데이터 가공
5. Team Leader: 포맷 일관성 + 팩트 정확성 검수
6. Implementer → 편집 API 호출 + 프로덕션 확인
7. 반복
```

---

## 3. Phase 7 목표

모든 직업의 데이터 완성도를 높이는 것.
**기존 데이터 포맷/스타일을 정확히 파악한 후**, 일관된 형태로 빈 필드를 채움.

---

## 4. 직업 상세 페이지 데이터 구조

### 탭 1: 소개 (overview)
| 필드 경로 | 표시 섹션 | 포맷 |
|-----------|----------|------|
| `overviewWork.main` | 주요 업무 | string 또는 string[] → `▶` 불릿 ul 변환 |
| `overviewWork.workStrong` | 작업강도 메타카드 | 짧은 텍스트 (예: "보통") |
| `overviewWork.workPlace` | 작업장소 메타카드 | 짧은 텍스트 (예: "실내") |
| `overviewProspect.main` | 커리어 전망 | string 또는 string[] (들여쓰기 렌더링) |
| `overviewSalary.sal/wage` | 임금 정보 | "하위(25%) N만원, 평균(50%) N만원, 상위(25%) N만원" 형식 |
| `overviewAptitude.aptitudeList[]` | 적성 | string[] → 마침표 분리 → 불릿 ul |
| `overviewAptitude.interestList[]` | 흥미 | 동일 |
| `trivia` | 여담 | string[] → `•` 불릿 ul |

### 탭 2: 과정 (details)
| 필드 경로 | 표시 섹션 | 포맷 |
|-----------|----------|------|
| `overviewAbilities.abilityList[]` | 핵심 능력 | 아이콘 + 라벨 카드 그리드 |
| `overviewAbilities.technKnow` | 필요 지식 | formatRichText 처리 |
| `detailReady.curriculum[]` | 정규 교육과정 | `•` 불릿 ul |
| `detailReady.certificate[]` | 추천 자격증 | `•` 불릿 ul |
| `detailReady.training[]` | 필요 교육/훈련 | `•` 불릿 ul |
| `detailReady.recruit[]` | 채용 정보 | `•` 불릿 ul |
| `detailReady.researchList[]` | 진로 탐색 활동 | `•` 불릿 ul |

### 사이드바
| 필드 | 표시 | 연결 방식 |
|------|------|----------|
| `sidebarJobs[]` | 관련 직업 | DB slug 존재 시 링크, 아니면 검색 |
| `sidebarMajors[]` | 관련 전공 | slug 기반 링크 |
| `sidebarCerts[]` | 관련 자격증 | 텍스트 뱃지 |

### 데이터 소스 표시
```
CAREERNET       → "교육부 산하 진로·진학 정보 플랫폼"
GOYONG24        → "고용노동부 고용24 직업 정보"
USER_CONTRIBUTED → "사용자 기여 데이터"
ADMIN_OVERRIDE  → "관리자 검증 데이터"
```

---

## 5. 편집 API

### 다중 필드 편집 (권장)
```
POST https://careerwiki.org/api/job/{id}/edit
인증: Cookie: session_token=...

Body:
{
  "fields": {
    "way": "이 직업이 되기 위해서는...",
    "duties": "주요 업무 내용...",
    "salary": "하위(25%) 3,000만원, 평균(50%) 4,500만원, 상위(25%) 6,000만원"
  },
  "sources": {
    "way": { "url": "https://www.career.go.kr/...", "text": "커리어넷" },
    "salary": { "url": "https://www.work24.go.kr/...", "text": "고용24" }
  },
  "changeSummary": "way, duties, salary 필드 보완"
}

응답: { "success": true, "revisionId": "...", "message": "Edit saved successfully" }
```

### 빈 필드 조회 (wrangler CLI)
```bash
# way(되는 방법) 빈 직업
npx wrangler d1 execute careerwiki-kr --remote \
  --command "SELECT id, name, slug FROM jobs WHERE is_active = 1 AND (json_extract(merged_profile_json, '$.way') IS NULL OR json_extract(merged_profile_json, '$.way') = '') ORDER BY name LIMIT 100"

# 전체 필드 완성도 통계
npx wrangler d1 execute careerwiki-kr --remote \
  --command "SELECT
    COUNT(*) as total,
    SUM(CASE WHEN json_extract(merged_profile_json, '$.way') IS NOT NULL AND json_extract(merged_profile_json, '$.way') != '' THEN 1 ELSE 0 END) as has_way,
    SUM(CASE WHEN json_extract(merged_profile_json, '$.overviewWork.main') IS NOT NULL THEN 1 ELSE 0 END) as has_duties,
    SUM(CASE WHEN json_extract(merged_profile_json, '$.overviewSalary.sal') IS NOT NULL THEN 1 ELSE 0 END) as has_salary
  FROM jobs WHERE is_active = 1"
```

---

## 6. 데이터 작성 기준 (필드별)

### way (되는 방법) — 가장 중요
```
포맷: 줄바꿈(\n)으로 단락 구분, 200-500자
구조:
1. 필요한 학력/전공 (1-2줄)
2. 필수 자격증/시험 (있는 경우)
3. 단계별 경로: 학생 → 신입 → 경력
4. 실무 팁 1-2개

기존 데이터 예시를 먼저 확인하고 동일한 톤/깊이로 작성할 것.
출처: 커리어넷(career.go.kr), 워크넷(work24.go.kr), 한국직업능력연구원
```

### salary (임금)
```
포맷: "하위(25%) N만원, 평균(50%) N만원, 상위(25%) N만원"
→ 이 형식이어야 salary 차트가 정상 렌더링됨
출처: 고용24, 한국고용정보원 임금정보
```

### duties (주요 업무)
```
포맷: string[] (문장 단위) 또는 줄바꿈 구분 string
각 항목은 "~한다/~합니다" 형태
3-7개 항목이 적절
```

### prospect (전망)
```
포맷: formatRichText 처리 → 단락 텍스트
200-400자, 객관적 톤
"~할 것으로 전망됩니다" (추측이 아닌 데이터 기반)
```

---

## 7. 실행 흐름 (상세)

```
=== 1단계: 전수 조사 ===

1. Team Leader: 사용자에게 session_token 요청
2. Analyst → Task(run_in_background):
   - wrangler d1로 전체 직업 필드 완성도 통계 조회
   - 빈 필드가 많은 직업 TOP 50 추출
   - 기존 데이터가 잘 채워진 직업 3-5개 "모범 사례" 추출
     → 각 필드의 실제 포맷/톤/깊이 파악
3. Team Leader: Analyst 결과 리뷰 → 보완 대상 20개 + 우선순위 결정

=== 2단계: 직업별 보완 (20회 반복) ===

4. Researcher → Task(run_in_background):
   - 대상 직업의 빈 필드에 해당하는 정보 Deep Research
   - 커리어넷, 워크넷, 한국직업능력연구원 등 공식 소스 우선
   - 출처 URL 유효성 검증
5. Content Creator → Task(run_in_background):
   - Analyst가 파악한 "기존 포맷"에 맞춰 데이터 가공
   - 필드별 포맷 기준 (섹션 6) 준수
6. Team Leader: 품질 검수
   - 기존 데이터와 톤/포맷 일관성 확인
   - 출처 신뢰성 확인
7. Implementer → Task:
   - POST /api/job/{id}/edit 호출
   - careerwiki.org/job/{slug} 에서 필드 표시 확인
     - 차트/불릿/메타카드 정상 렌더링?
     - 출처 섹션에 소스 표시?
8. 다음 직업으로 → 4번 복귀
```

---

## 8. Context Compact 복원

컨텍스트가 compact되면 반드시:
1. 이 파일 (`docs/sessions/wave2-d-jobdata.md`) 다시 읽기
2. `docs/phase-progress/phase-7-state.md` 읽기
3. Team Leader의 가장 최근 메시지 확인

---

## 9. 완료 기준

- [ ] 전체 직업 필드 완성도 통계 파악 (Before)
- [ ] 상위 20개 직업의 빈 필드 보완
- [ ] 각 필드가 기존 데이터 포맷과 일관됨
- [ ] 모든 데이터에 유효한 출처(source) 포함
- [ ] salary 필드: "하위/평균/상위" 형식으로 차트 렌더링 확인
- [ ] way 필드: 단계별 경로 포함, 200-500자
- [ ] 프로덕션에서 직업 상세 페이지 정상 표시 확인
- [ ] 완성도 통계 (After) 기록
- [ ] 완료 보고서 작성

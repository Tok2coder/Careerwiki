# Wave 3 / Session B — Phase 8: 신규 직업 추가

> **이 파일을 읽고 팀을 구성한 뒤 Phase 8 작업을 시작하세요.**
> **선행 조건**: Phase 7 (직업 정보 보완) 완료 후 시작. 기존 직업 데이터 포맷 숙지 필수.

---

## 1. 공통 컨텍스트

### 프로젝트 개요
- **CareerWiki**: 한국어 진로 정보 위키 + AI 직업/전공 추천 플랫폼
- **Production**: https://careerwiki.org
- **Tech Stack**: Cloudflare Workers (Pages) + Hono + D1 (SQLite) + R2 + KV + Vectorize

### 배포 절차 (코드 수정 없음 — API 호출)
```
이 세션은 데이터 추가 작업이므로 코드 수정이 없습니다.
직업 생성 API + 편집 API로 데이터를 등록합니다.
```

### 절대 금지
- 코드 파일 수정
- 기존 직업과 중복 생성
- 출처 없는 정보 입력
- 기존 직업 포맷과 다른 형태로 데이터 입력

### 필수 읽기 파일
1. `CLAUDE.md` — 프로젝트 규칙 전체
2. `MASTER_PLAN.md` — Phase 8 섹션
3. `src/templates/unifiedJobDetail.ts` — 직업 상세 페이지 데이터 구조
4. `docs/phase-progress/phase-7-state.md` — Phase 7 결과 (데이터 포맷 확인)

---

## 2. 팀 구성

| 역할 | 모델 | 실행 방식 | 임무 |
|------|------|----------|------|
| Team Leader | Opus (메인) | 메인 세션 | 조율, 중복 확인, 품질 검수 |
| Analyst | Sonnet | Task(run_in_background) | 기존 직업 목록 분석, 누락 카테고리 식별 |
| Researcher | Sonnet | Task(run_in_background) | 신규 직업 정보 Deep Research, 출처 수집 |
| Content Creator | Sonnet | Task(run_in_background) | 기존 포맷에 맞춰 직업 데이터 작성 |
| Implementer | Sonnet | Task (순차) | 생성 API + 편집 API 호출, 프로덕션 확인 |

에이전트 정의: `.claude/agents/analyst.md`, `researcher.md`, `content-creator.md`, `implementer.md`

### 실행 패턴
```
1. Analyst → 기존 직업 카테고리별 분포 분석 → 누락 영역 식별
2. Researcher → 누락 영역의 신규 직업 후보 발굴 + Deep Research
3. Implementer → 중복 확인 (검색 API + D1 조회)
4. Content Creator → 기존 포맷에 맞춰 전체 데이터 작성
5. Team Leader → 품질 검수 (포맷 일관성, 팩트 정확성, 연결 관계)
6. Implementer → 생성 API + 편집 API 호출 + 프로덕션 확인
7. 반복
```

---

## 3. Phase 8 목표

기존 직업과 **동일한 수준과 포맷**의 신규 직업 10-20개 추가.
관련 직업, 관련 전공, 관련 HowTo가 자연스럽게 연결되어야 함.

---

## 4. 신규 직업 생성 프로세스

### Step 1: 생성 (기본 정보)
```
POST https://careerwiki.org/api/admin/job
인증: Cookie: session_token=... (admin role 필수)

Body:
{
  "id": "카테고리_slug_형태",
  "name": "직업명",
  "summary": "한줄 요약 (2자 이상)",
  "duties": "주요 업무 설명",
  "salary": "하위(25%) N만원, 평균(50%) N만원, 상위(25%) N만원",
  "prospect": "전망 설명",
  "way": "되는 방법"
}

응답: { "success": true, "id": "...", "revisionId": "..." }
→ 자동: slug 생성, 이미지 생성(Gemini+EVOLINK), auto-tagging(OpenAI), Vectorize 인덱싱
```

### Step 2: 상세 정보 보완 (편집 API)
```
POST https://careerwiki.org/api/job/{id}/edit

Body:
{
  "fields": {
    "overviewWork.main": "주요 업무 상세 (▶ 불릿 형태로 표시됨)",
    "overviewProspect.main": "전망 상세",
    "overviewAptitude.aptitudeList": "적성 목록",
    "detailReady.curriculum": "정규 교육과정",
    "detailReady.certificate": "관련 자격증",
    "detailReady.training": "필요 훈련",
    "sidebarJobs": "관련 직업 목록",
    "sidebarMajors": "관련 전공 목록"
  },
  "sources": {
    "way": { "url": "https://...", "text": "출처명" }
  }
}
```

### Step 3: 관련 엔티티 연결 확인
```
사이드바 연결 (자동/수동):
- 관련 직업: sidebarJobs[] → 기존 직업의 slug가 DB에 존재하는지 확인
- 관련 전공: sidebarMajors[] → 기존 전공의 slug 존재 확인
- 관련 HowTo: Phase 6에서 만든 HowTo와 자연스럽게 연결

검색 API로 slug 확인:
curl "https://careerwiki.org/api/search?q=관련직업명&type=job"
curl "https://careerwiki.org/api/search?q=관련전공명&type=major"
```

---

## 5. 신규 직업 발굴 기준

### 카테고리별 누락 확인
```
1. 기존 카테고리 분포 분석 (wrangler d1)
2. 비어있거나 적은 카테고리 식별
3. 각 카테고리에서 누락된 직업 발굴
```

### 발굴 우선순위
```
1순위: 검색량 높은 신생 직업
  - AI 프롬프트 엔지니어, AI 트레이너, 데이터 라벨러
  - MLOps 엔지니어, 클라우드 아키텍트

2순위: 기존 직업 세분화
  - "개발자" → 프론트엔드, 백엔드, 풀스택, DevOps, SRE
  - "디자이너" → UI, UX, 그래픽, 모션, 제품

3순위: 니치/전문 직업
  - 법의곤충학자, 풍미 개발자, 수면다원검사기사
  - 사용자가 검색할 수 있지만 현재 없는 직업

4순위: 트렌드 직업
  - 콘텐츠 크리에이터, 디지털 노마드, 메타버스 기획자
```

### 중복 확인 (필수)
```bash
# 검색 API
curl "https://careerwiki.org/api/search?q=직업명"

# D1 직접 조회
npx wrangler d1 execute careerwiki-kr --remote \
  --command "SELECT id, name, slug FROM jobs WHERE name LIKE '%키워드%' AND is_active = 1"

# 유사 직업 확인 (부분 일치)
npx wrangler d1 execute careerwiki-kr --remote \
  --command "SELECT id, name FROM jobs WHERE name LIKE '%엔지니어%' AND is_active = 1"
```

---

## 6. 데이터 품질 기준

### 기존 직업과 동일한 수준
```
□ name: 공식 직업명 사용 (커리어넷/워크넷 기준)
□ summary: 1-2문장, 핵심 역할 설명
□ way: 200-500자, 단계별 경로 + 필수 자격
□ duties: 3-7개 항목, "~한다" 형태
□ salary: "하위/평균/상위" 형식 (차트 렌더링 호환)
□ prospect: 200-400자, 데이터 기반 전망
□ sidebarJobs: 관련 직업 3-5개 (slug 존재 확인 필수)
□ sidebarMajors: 관련 전공 2-3개 (slug 존재 확인 필수)
□ 모든 필드에 유효한 출처 포함
```

### 연결 관계 자연스러움
```
□ 관련 직업: 실제로 유사하거나 전환 가능한 직업인가?
□ 관련 전공: 실제로 해당 직업에 진출하는 전공인가?
□ 관련 HowTo: Phase 6에서 만든 가이드 중 연결 가능한 것이 있는가?
□ 카테고리: 기존 카테고리 체계에 맞는가?
```

---

## 7. 실행 흐름 (상세)

```
=== 1단계: 현황 분석 + 후보 발굴 ===

1. Team Leader: session_token 요청
2. Analyst → Task(run_in_background):
   - 기존 직업 카테고리별 분포 조회 (D1)
   - 누락/과소 카테고리 식별
   - 기존 "잘 만들어진" 직업 3개 → 데이터 포맷 모범 사례 추출
3. Researcher → Task(run_in_background):
   - 누락 영역에서 신규 직업 후보 20-30개 발굴
   - 각 후보의 공식 직업명, 카테고리, 관련 직업 초안

=== 2단계: 중복 확인 + 확정 ===

4. Implementer → Task:
   - 후보 전체 중복 확인 (검색 API + D1)
   - 중복 제거 후 목록 Team Leader에게 보고
5. Team Leader: 10-20개 확정

=== 3단계: 직업별 생성 (10-20회 반복) ===

6. Researcher → Task(run_in_background):
   - 해당 직업 Deep Research (공식 소스 우선)
   - way, duties, salary, prospect 원본 정보 수집
   - 관련 직업/전공 slug 매핑
7. Content Creator → Task(run_in_background):
   - Phase 7 모범 사례 포맷에 맞춰 전체 필드 작성
   - salary는 반드시 "하위/평균/상위" 형식
8. Team Leader: 품질 검수
   - 기존 직업과 포맷 일관성
   - 관련 엔티티 slug 존재 여부
9. Implementer → Task:
   - POST /api/admin/job으로 생성
   - POST /api/job/{id}/edit으로 상세 정보 보완
   - careerwiki.org/job/{slug} 접속 확인
     - 모든 탭(소개/과정/업무특성) 정상?
     - 사이드바 관련 직업/전공 링크 동작?
     - salary 차트 렌더링?
10. 다음 직업 → 6번 복귀
```

---

## 8. Context Compact 복원

컨텍스트가 compact되면 반드시:
1. 이 파일 (`docs/sessions/wave3-b-newjobs.md`) 다시 읽기
2. `docs/phase-progress/phase-8-state.md` 읽기
3. Team Leader의 가장 최근 메시지 확인

---

## 9. 완료 기준

- [ ] 기존 직업 카테고리 분포 분석 완료
- [ ] 신규 직업 10-20개 추가 (중복 없음)
- [ ] 각 직업의 모든 주요 필드 채움 (way, duties, salary, prospect)
- [ ] 모든 필드가 기존 직업과 동일한 포맷
- [ ] salary: "하위/평균/상위" 형식 → 차트 정상 렌더링
- [ ] 관련 직업/전공 slug 존재 확인 + 링크 동작
- [ ] 모든 데이터에 유효한 출처(source) 포함
- [ ] 프로덕션에서 직업 페이지 전체 탭 정상 표시
- [ ] 완료 보고서 작성

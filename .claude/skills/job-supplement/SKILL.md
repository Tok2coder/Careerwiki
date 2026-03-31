---
name: job-supplement
description: Careerwiki 직업 데이터 보완(user_contributed_json) 작업 시 반드시 참조. 필드 포맷, 품질 기준, 출처 구조, 검증 체크리스트를 정의. 직업 보완, 배치 작업, 데이터 일괄 수정, 부실 직업 수정 등의 작업에서 사용.
---

# 직업 데이터 보완 스킬

## 개요
Careerwiki의 직업 페이지에 사용자 기여 데이터(user_contributed_json)를 추가/수정하는 작업의 품질 기준.

## DB 접근
- npx wrangler d1 execute careerwiki-kr --remote
- user_contributed_json 컬럼에 JSON 저장
- wiki_pages는 DROP됨 — 캐시 무효화 SQL 불필요

## 필수 12개 필드

### 1. way (string)
- 타입: **문자열** (배열 아님! 배열로 저장 시 formatRichText TypeError → 500 에러)
- 인라인 출처 참조번호 포함: "교도관이 되려면...[1] ...공무원 시험에 합격해야 한다.[2]"
- 분량: 최소 3줄 이상, 구체적 진로 경로 설명

### 2. overviewSalary (object)
```json
{
  "sal": "연봉 중위값은 약 3,612만 원이다.[1] 경력에 따라...[2]",
  "source": "직업백과, 자격증넷(2024)"
}
```
- sal에 인라인 참조번호 포함
- source는 선택적 (요약 출처명)

### 3. overviewProspect (object)
```json
{
  "main": "향후 5년간 고용은 보통 수준...[1] ...[2]",
  "source": "직업백과, 커리어넷(2024)"
}
```

### 4. trivia (string)
- 흥미로운 사실 3~5개를 하나의 문자열로
- 인라인 참조번호 포함
- 구체적이고 재미있는 내용 (뻔한 정보 X)

### 5. detailWlb (object)
```json
{
  "wlb": "보통이하",
  "social": "보통",
  "wlbDetail": "3교대 근무로 야간·휴일 근무가 빈번하다...",
  "socialDetail": "제조업 현장의 필수 인력으로서..."
}
```
- wlb 등급: "높음", "보통이상", "보통", "보통이하", "낮음"
- social 등급: 동일 체계
- wlbDetail/socialDetail: 각각 최소 2줄 이상 상세 설명

### 6. detailReady (object)
```json
{
  "curriculum": ["교정학개론 수강...", "체력 검정 준비...", ...],
  "recruit": ["법무부 공채...", "경력경쟁채용...", ...],
  "training": ["심리상담사 자격...", "대학원 진학...", ...]
}
```
- 각 배열 3~5개 항목

### 7. sidebarJobs (string[])
- DB에 실존하는 직업명으로만! (SELECT name FROM jobs WHERE name = '...')
- 10개 내외
- 실제 관련 있는 직업

### 8. sidebarMajors (string[])
- DB majors 테이블에 실존하는 전공명으로만!
- 6개 내외

### 9. sidebarCerts (string[])
- 관련 자격증 이름
- 5~6개

### 10. heroTags (string[])
- SEO 키워드
- 5~8개

### 11. youtubeLinks (array)
```json
[{"url": "https://www.youtube.com/watch?v=...", "title": "영상 제목"}]
```
- 직접 관련 영상만, 최신 1~2년 이내
- oembed 검증 필수: https://www.youtube.com/oembed?url=VIDEO_URL
- 없으면 빈 배열 []

### 12. _sources (object) — 가장 중요!
```json
{
  "way": [
    {"id": 1, "text": "커리어넷 직업백과", "url": "https://www.career.go.kr/..."},
    {"id": 2, "text": "워크넷 직업정보", "url": "https://www.work.go.kr/..."}
  ],
  "overviewSalary.sal": [
    {"id": 3, "text": "자격증넷", "url": "https://janet.co.kr/..."}
  ],
  "overviewProspect.main": [
    {"id": 4, "text": "직업백과", "url": "https://job.asamaru.net/..."}
  ],
  "trivia": [
    {"id": 5, "text": "교정본부", "url": "https://www.corrections.go.kr"}
  ],
  "detailWlb.wlbDetail": [
    {"id": 6, "text": "직업백과", "url": "https://..."}
  ],
  "detailWlb.socialDetail": [
    {"id": 7, "text": "자격증넷", "url": "https://..."}
  ]
}
```

### _sources 핵심 규칙
- 키: dot notation (overviewSalary.sal, detailWlb.wlbDetail 등)
- id: 전체 JSON 내 고유 순번 (1부터 연속)
- text: 출처 사이트명
- url: 실제 접근 가능한 URL (반드시 웹 검색으로 확인!)
- 본문의 [N]은 _sources 해당 섹션의 id: N을 참조
- 단순 문자열 배열 ["워크넷", "가스공사"] 금지! 반드시 Object 포맷

## 작업 전 체크리스트
1. [ ] main 브랜치에서 작업 중인지 확인 (worktree에서 배포 시 롤백됨!)
2. [ ] 대상 직업이 DB에 존재하는지 확인
3. [ ] 기존 user_contributed_json 확인 (덮어쓰기 방지)

## 작업 후 검증 체크리스트
1. [ ] 12개 필드 모두 존재하는지 확인
2. [ ] way가 문자열인지 확인 (배열이면 500 에러!)
3. [ ] sidebarJobs 전부 DB 실존 확인
4. [ ] sidebarMajors 전부 DB 실존 확인
5. [ ] _sources가 Object 포맷이고 URL 포함인지 확인
6. [ ] 본문의 [N] 참조번호와 _sources의 id가 매칭되는지 확인
7. [ ] youtubeLinks oembed 검증 완료인지 확인
8. [ ] JSON 크기 최소 2,000 bytes 이상인지 확인
9. [ ] 프로덕션 페이지 200 OK 확인

## 흔한 실수와 방지법
- way를 배열로 저장 → 500 에러 (formatRichText TypeError)
- _sources를 문자열 배열로 저장 → 프론트엔드에서 렌더링 안 됨
- sidebarJobs에 DB에 없는 직업 → 링크 깨짐
- worktree에서 배포 → main 배포 시 롤백
- wlb/social 등급 누락 → 페이지에 평가 미표시
- detailReady를 평문으로 저장 → 구조화된 UI 렌더링 안 됨

# 리서치 에이전트 프롬프트 & 대량 생성 패턴

---

## 섹션 13: 전체 실행 패턴 (팀 리더 플로우)

```
[Phase 1: 실존 검증]
1. DB 중복 확인 (exact match + LIKE 검색)
2. 공식 직업 DB에서 실존 여부 확인 (커리어넷, 워크넷)
3. slug 충돌 사전 확인

[Phase 2: 스텁 생성]
4. summary 초안 작성 (100-300자)
5. heroTags 선정 (별칭, 분류, 영문명 포함)
6. heroCategory 선택 (표준 10개 대분류)
7. POST /api/job/create 호출 → id, slug 저장
8. 응답에서 imageUrl 확인 (없으면 Phase 4에서 수동 처리)

[Phase 3: 리서치]
9. 공식 DB + 웹 검색으로 모든 필드 리서치
10. 출처 URL curl 접속 검증
11. 수집한 데이터 WebFetch로 내용 대조 검증

[Phase 4: 데이터 보완]
12. 각주 중복 검증 (validateFootnotes)
12b. validate-job-edit.cjs 자동 검증:
     node scripts/validate-job-edit.cjs < researcher_output.json
     FAIL → 수정 후 재검증. PASS → 다음 단계
13. 편집 API 호출 (fields + sources 함께)
14. 이미지 없으면 수동 업로드 (SKILL.md Section 5)

[Phase 5: 자동 처리 확인 (5분 후)]
15. 분류 확인 → 오류 시 수동 수정 (SKILL.md Section 6)
16. Vectorize 인덱싱 확인 → 실패 시 수동 재시도 (SKILL.md Section 7)

[Phase 6: 커리어트리 (선택)]
17. 한국인 공인 인물 선정 + 경력 검증 (shared/career-tree.md 참조)
18. DB INSERT (career_trees + career_tree_job_links)

[Phase 7: 프로덕션 검증]
19. curl로 페이지 렌더링 확인
20. QA 각주 순서 스크립트 실행 (SKILL.md Section 12)

[Phase 8: 단건 재검토 — 생략 불가]
21. validate-job-edit.cjs 재검증 (DB에서 직접 읽어서 한 번 더)
22. 프로덕션 curl — 각주 순서, 마크다운 잔류(**) 확인, sources 대응 확인
23. full-quality-audit.cjs 단건 실행 → PASS 확인:
    node scripts/full-quality-audit.cjs --slug={직업slug}
    → FAIL이면 즉시 수정 후 재실행 → PASS될 때까지 반복
24. PASS 확인 후에만 다음 직업으로 진행
```

---

## 섹션 14: 대량 생성 패턴 (5개 이상 동시 추가)

5개 이상의 직업을 한 번에 추가할 때 **3단계 분리 패턴** 사용.

### 핵심 원칙
- **팀 리더(이 대화)**: 실존 검증, 스텁 생성, 검증+API 호출 담당
- **Researcher Agent**: 리서치+JSON 초안 반환만. **API 호출 절대 금지**
- 병렬 에이전트 최대 3개. 각 1~2개 직업 담당

### 단계별 플로우

```
Phase 1: 팀 리더 — 사전 검증 (전체 직업 일괄 처리)
  - check-name API로 각 직업명 중복 확인
  - DB LIKE 검색으로 유사 이름 확인
  - 커리어넷/워크넷에서 실존 여부 일괄 확인
  - 고유 통계 존재 여부 일괄 게이트
  - 문제없는 직업만 Phase 2로 진행

Phase 2: 팀 리더 — 스텁 일괄 생성
  - 각 직업별 POST /api/job/create 순차 호출
  - 이미지 생성이 동기(최대 60초)이므로 직업당 60-70초 소요
  - 스텁 5개 생성 → 5-6분, 10개 → 10-12분
  - 응답에서 id, slug, imageUrl 기록

Phase 3: Researcher Agent (3개 병렬, 각 1~2개 직업)
  - 역할: 리서치 + JSON 초안 반환 ONLY
  - ⚠️ API 호출 금지 — JSON 결과만 반환
  - 각 에이전트에게 아래 "단일 직업용 에이전트 프롬프트" 사용

Phase 4: 팀 리더 — 검증 + API 호출 (직업별 순차)
  - validate-job-edit.cjs로 자동 검증
  - FAIL → 수정 후 재검증
  - PASS → 편집 API 호출 (SKILL.md Section 9)
  - sidebarJobs/sidebarMajors DB 존재 확인 (SQL)
  - 출처 URL curl 접속 검증
  - ⚠️ 병렬 API 호출 금지 (직렬 처리)

Phase 5: 프로덕션 확인 (전체 직업 일괄)
  - curl로 각 직업 페이지 렌더링 확인
  - QA 각주 순서 스크립트 일괄 실행 (SKILL.md Section 12-3)
  - full-quality-audit.cjs 각 직업별 실행 → 전부 PASS 확인
  - 분류/Vectorize 일괄 확인 (약 5분 후)
```

---

## 섹션 15: 단일 직업용 에이전트 프롬프트 템플릿

`{변수}`만 교체하고 그대로 사용. **⚠️ 이 에이전트는 편집 API를 호출하지 않는다. JSON 결과만 반환한다.**

---

```
새 직업 "{직업명}" 생성을 위한 리서치 및 데이터 초안 작성.
직업 ID: {JOB_ID} (이미 POST /api/job/create로 스텁 생성 완료)

⚠️ 너는 편집 API를 호출하지 않는다. 리서치 결과를 JSON으로 반환만 한다.

## 실존 검증 결과
{실존 확인된 출처 URL 또는 신생 직업 근거 자료 요약}

## 현재 DB 상태
{팀 리더가 조회한 현재 user_contributed_json 요약 — 스텁이므로 summary만 있을 것}

## 작업 지시
1. 아래 모든 필드를 처음부터 작성하라. 출처 없으면 절대 넣지 마라
2. 새 직업이므로 API 데이터 없음 — 공식 DB + 웹 검색으로 전량 수집
3. sidebarJobs/sidebarMajors — DB에 실제 존재하는 항목만
4. 커리어트리는 한국인 공인만. 적합 인물 없으면 null

## 채울 필드 목록
- **summary**: 100-300자 직업 설명. 수행 직무 + 활동 영역 + 필요 역량
- **way**: 되는 방법 200-500자. 자격요건→교육→진입경로→실무팁. 각주 [N] 필수
- **overviewWork.main**: 수행 직무 100-300자. 각주 필수
- **overviewSalary.sal**: 임금 서술. 공식 형식(하위/평균/상위) 또는 텍스트+각주
- **overviewProspect.main**: 전망 서술 200-400자. 각주 필수
- **trivia**: 이 직업을 진지하게 생각하게 만드는 검증된 팩트 1개
- **detailWlb**: {wlb:"등급", social:"등급", wlbDetail:"서술[N]", socialDetail:"서술[N]"}
  - wlb/social 등급 반드시 포함 (보통미만/보통이상/좋음/매우좋음)
  - wlbDetail: 130~200자. 근무시간·강도·야근·교대. 임금 정보 절대 금지
  - socialDetail: 100~160자. 사회적 영향·공익 역할만. 근무환경·협업·취업전망 금지
- **detailReady**: {curriculum:[5개+], recruit:[채용경로], training:[양성과정]}
- **sidebarCerts**: [{name, url}]. 자격증만(시험 아님). "~시험" 금지
- **sidebarMajors**: string[]. DB 존재 확인: SELECT name FROM majors WHERE is_active=1 AND name IN (...)
- **sidebarJobs**: 7~12개. DB 존재 확인. 핵심 연관 직업만. 15개 초과 금지
- **heroTags**: 3~10개, 2~15자 명사구. 별칭/세부분류/영문명 포함
- **overviewAbilities.technKnow**: 활용 기술 서술 (출처+각주 필수)
- **youtubeLinks**: `[{url, title}]`. **title 필수** (없으면 URL이 제목으로 노출됨. oembed 응답 title 값 사용). 진로 탐색 목적 영상 우선 (진로 가이드·현직자 인터뷰·전망 > 단순 vlog). 공식채널 우선 1~3개
- **detailIndicators**: 고용24 재직자 조사 7항목. 없으면 null
- **customCharts**: 해당 직업 특유 시각화. 공식 통계만. 없으면 null

## 절대 금지
- abilityList/aptitude/education에 공식 통계 없이 수치 넣기 → null 유지
- 출처 없는 데이터, 추정값, AI 생성 수치
- 커리어트리에 외국인, 전직 스테이지, 수상 독립 스테이지
- **마크다운 볼드(\*\*text\*\*) 서술 필드에 사용** — 텍스트 필드에 ** 절대 금지. 별표가 그대로 노출됨
- **같은 [N] 번호 한 필드에 2회 이상 사용** — 같은 출처의 여러 사실은 한 문장으로 합쳐서 [N] 1회만
- **sources 배열 길이 < 본문 최대 [N]** — 반드시 일치시킬 것
- **wlb/social 등급 누락** — detailWlb.wlb와 detailWlb.social 반드시 포함
- **validate-job-edit.cjs PASS 없이 편집 API 호출**
- **full-quality-audit.cjs PASS 없이 다음 직업으로 넘어가기**

## 각주 규칙
- 필드별 [1]부터 순차 (1, 2, 3...). 건너뛰기 금지
- 같은 [N] 번호 한 필드에 정확히 1회만 (2회 이상 = 치명적 오류)
- sources 배열 길이 = 본문 최대 [N] 번호 (반드시 일치)
- 마침표 뒤에: 합니다.[1] (O) / 합니다[1]. (X)

## 출처 규칙
- sources text: "[N] 출처설명" 형식. text에 URL 포함 금지
- 각 출처를 개별 {text, url} 객체로
- sources 키: way→"way", salary→"overviewSalary.sal", prospect→"overviewProspect.main",
  trivia→"trivia", wlbDetail→"detailWlb.wlbDetail", socialDetail→"detailWlb.socialDetail"
- ❌ 접미사 _sources 금지: way_sources, overviewSalary_sources 등
- ❌ 숫자 키 "1","2","3" 금지

## 반환 형식 (이 JSON을 마지막에 출력)
{
  "jobName": "{직업명}",
  "jobId": "{JOB_ID}",
  "fields": { ... },
  "sources": { ... },
  "careerTree": {
    "person_name": "...",
    "person_name_en": "...",
    "person_title": "한 줄 소개",
    "stages_json": [
      {"order": 0, "title": "직함", "organization": "소속", "years": "기간",
       "description": "설명", "job_slug": null},
      {"order": 1, "title": "직업 취업", "organization": "소속", "years": "기간",
       "description": "설명", "job_slug": "{직업슬러그}"}
    ]
  } | null,
  "changeSummary": "신규 직업 생성: 전체 데이터 보완 [변경 사유 상세]"
}
```

---

## 커리어트리 DB 삽입 (에이전트가 null 아닌 careerTree 반환 시)

```bash
# 1. 인물 삽입
cd C:/Users/PC/Careerwiki && npx wrangler d1 execute careerwiki-kr --remote --command \
  "INSERT INTO career_trees (person_name, person_name_en, person_title, person_image_url, stages_json,
   display_priority, is_active, created_at, updated_at)
   VALUES ('인물명', '영문명', '한 줄 소개', NULL,
   '[{\"order\":0,\"title\":\"직함\",\"organization\":\"소속\",\"years\":\"기간\",
   \"description\":\"설명\",\"job_slug\":null},
   {\"order\":1,\"title\":\"취업\",\"organization\":\"소속\",\"years\":\"기간\",
   \"description\":\"설명\",\"job_slug\":\"직업슬러그\"}]',
   100, 1, unixepoch()*1000, unixepoch()*1000)"

# 2. 삽입된 ID 확인
npx wrangler d1 execute careerwiki-kr --remote --command \
  "SELECT id FROM career_trees WHERE person_name='인물명' ORDER BY id DESC LIMIT 1"

# 3. 직업 연결
npx wrangler d1 execute careerwiki-kr --remote --command \
  "INSERT INTO career_tree_job_links (career_tree_id, job_slug, stage_index)
   VALUES ({ID}, '{직업슬러그}', {스테이지인덱스})"
```

커리어트리 인물 기준 상세 → `../../shared/career-tree.md` 참조 *(다른 태스크에서 생성 예정)*

# Researcher 에이전트 프롬프트 (복사용 템플릿)

병렬 에이전트에게 넘길 때 아래 템플릿을 그대로 복사하고, `{변수}`만 교체한다.

**⚠️ 이 에이전트는 편집 API를 호출하지 않는다. JSON 결과 + 품질 게이트 자가 검증 결과만 반환한다.**

---

```
직업 "{직업명}" (Job ID: {JOB_ID}) 리서치 및 데이터 초안 작성.

⚠️ 너는 편집 API를 호출하지 않는다. 리서치 결과를 JSON으로 반환하고, 반드시 4개 품질 게이트를 직접 검증한 뒤 결과를 함께 보고한다.

## 현재 데이터 상태
{팀 리더가 DB에서 조회한 현재 데이터 요약을 여기에 붙여넣기}

## 작업 지시
1. 빈 필드를 검증된 정보로 채워라. 출처 없으면 절대 넣지 마라
2. 기존 데이터의 연도를 확인하고 2년+ 된 수치는 최신 통계로 교체
3. sidebarJobs/sidebarMajors/sidebarCerts/heroTags — 기존 데이터도 검증하고 개선
4. 커리어트리는 한국인만. 적합 인물 없으면 null

## 채울 필드 목록

### 항상 새로 작성 (건너뛰면 안 됨)
- **way**: 되는 방법 200~500자, string 타입. 각주 [N] 필수. 자격요건·시험·진입경로·실무팁. 교육과정 목록 나열 금지 (→ detailReady)
- **detailReady**: {curriculum:[5개+구체적교육과정], recruit:[3+채용경로], training:[2+심화과정]} — **각 배열 항목은 반드시 plain string** (`"컴퓨터공학과"` 형식). `{text:"..."}` 또는 `{title:"...", text:"...", link:null}` 등 객체 형태 절대 금지. 객체 저장 시 각주 렌더링 버그 발생 이력 있음.
- **trivia**: 이 직업을 진지하게 생각하게 만드는 검증된 팩트 1개. 출처 없으면 금지
- **detailWlb.wlbDetail**: 130~200자, 근무강도·야근·교대 중심. **임금 정보 절대 금지**
- **detailWlb.socialDetail**: 100~160자, 사회적 영향·공익만. **근무환경·취업전망 금지**

### 보강 가능 (기존 있으면 유지, 부실하면 보강)
- **overviewSalary.sal**: 임금 서술 200~300자. 기존 user_contributed에 서술 있으면 유지. 기존 wage가 있으면 덮어쓰지 않음
- **overviewProspect.main**: 전망 서술 200~400자. "~전망됩니다" 톤. 기존 있으면 유지
- **sidebarJobs**: 7~12개. SELECT name FROM jobs WHERE is_active=1 AND name IN (...) 로 DB 검증 필수
- **sidebarMajors**: 3~5개. SELECT name FROM majors WHERE is_active=1 AND name IN (...) 로 DB 검증 필수
- **sidebarCerts**: [{name, url}] 형식. 자격증만 (시험 아님). "~시험" 금지
- **heroTags**: 3~10개, 2~15자 명사구. 별칭/세부분류/영문명 포함
- **youtubeLinks**: [{url, title}]. oembed 실존 확인 필수. 직업명/관련키워드 포함 영상만

## 4개 품질 게이트 — 반드시 자가 검증 후 결과 보고

### Gate 1: 각주 검증
각 필드별로 [N] 중복 없음, 1부터 순차 증가, 마침표 뒤에 위치, sources 배열 길이 = 최대 [N] 번호 확인.

### Gate 2: 텍스트 완결성
모든 서술 필드(way, trivia, sal, prospect, wlbDetail, socialDetail)가 완성된 문장으로 끝나는지 확인.
잘린 문장 패턴: "...부상 시", "...으로 인해", "...에 따르면", "...2024년", "...가능하" 등으로 끝나면 금지.
마지막 문장이 마침표(.) 또는 완성형 어미(~습니다/~입니다/~됩니다)로 끝나야 함.

### Gate 3: YouTube 관련성
youtubeLinks의 각 영상에 대해:
1. oembed 200 응답 확인 (삭제/비공개 영상 제외)
2. title 필드 존재 여부 확인
3. 영상 제목에 직업명 또는 관련 키워드 포함 여부 확인
4. 진로 가이드/현직자 인터뷰/전망 영상인지 확인 (단순 vlog 제외)

### Gate 4: _sources ID 순서
본문을 위→아래 스캔하며 새 [N]이 처음 등장하는 순서 = _sources 각 배열의 id 순서인지 확인.

## 절대 금지
- abilityList/aptitude/educationDistribution에 공식 통계 없이 수치 넣기 → null 유지
- 출처 없는 데이터, 추정값, AI 생성 수치
- 커리어트리에 외국인, 전직 스테이지 포함
- **커리어트리 job_slug를 이전 스테이지(학생/타직업)에 설정** — 해당 직업 첫 진입 스테이지에만
- **wlb/social 등급 누락** — 반드시 포함
- **서술 필드에 sources 누락** — 각주 있으면 sources도 반드시 전송
- **마크다운 볼드(\*\*text\*\*) 서술 필드 사용** — 절대 금지
- **같은 [N] 번호 한 필드에 2회 이상 사용**
- **sources 배열 길이 < 본문 최대 [N]**
- **way를 배열로 작성** — 반드시 string
- **detailReady 항목을 객체로 작성** — `{text:"..."}` 등 객체 형태 절대 금지, 반드시 `"문자열"` plain string
- **직업 관련성 없는 YouTube 영상** (직업명/키워드 없는 제목)

## 반환 형식 (이 JSON을 마지막에 출력)
{
  "jobName": "{직업명}",
  "jobId": "{JOB_ID}",
  "fields": { ... },
  "sources": { ... },
  "careerTree": { "person_name": "...", "stages_json": [...], ... } | null,
  "changeSummary": "변경 사유 상세",
  "qualityGates": {
    "gate1_footnotes": "PASS | FAIL: [상세]",
    "gate2_completeness": "PASS | FAIL: [잘린 필드명]",
    "gate3_youtube": "PASS | FAIL: [영상 제목 미포함 등] | N/A (영상 없음)",
    "gate4_sources_order": "PASS | FAIL: [불일치 상세]"
  }
}
```

---

## 성공/실패 예시

### ✅ A급 — 공인노무사
- way: 응시자격·1차5과목/2차4과목·합격기준·2025년 합격률·6개월 실무수습 (각주 4개)
- detailReady: curriculum 10과목, recruit 6경로, training 5개
- youtubeLinks: 2개, oembed 확인, "공인노무사 되는 법" / "노무사 현직자 인터뷰" (관련 키워드 포함)
- qualityGates: 4개 모두 PASS
- sources: 총 19개, 각주 1→19 완벽 순차

### ❌ D급 — 흔한 실패 패턴
- trivia/wlbDetail/socialDetail만 채우고 way/detailReady/sidebarCerts 스킵
- "merged_profile_json에 있다"고 판단 — 실제로는 API 수치뿐 (way는 서술 없음)
- youtubeLinks: title 없이 URL만 저장, 직업과 관련 없는 영상 포함
- Gate 2 FAIL: "자격을 취득한 경우에는" 으로 문장 절단
- qualityGates 미보고
- **결과: 유저에게 실질적 도움 0, 시간만 낭비**

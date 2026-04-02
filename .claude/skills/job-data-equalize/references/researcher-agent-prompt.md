# Researcher 에이전트 프롬프트 (복사용 템플릿)

병렬 에이전트에게 넘길 때 아래 템플릿을 그대로 복사하고, `{변수}`만 교체한다.

**⚠️ 이 에이전트는 편집 API를 호출하지 않는다. JSON 결과만 반환한다.**

---

```
직업 "{직업명}" (Job ID: {JOB_ID}) 리서치 및 데이터 초안 작성.

⚠️ 너는 편집 API를 호출하지 않는다. 리서치 결과를 JSON으로 반환만 한다.

## 현재 데이터 상태
{팀 리더가 DB에서 조회한 현재 데이터 요약을 여기에 붙여넣기}

## 작업 지시
1. 빈 필드를 검증된 정보로 채워라. 출처 없으면 절대 넣지 마라
2. 기존 데이터의 연도를 확인하고 2년+ 된 수치는 최신 통계로 교체
3. sidebarJobs/sidebarMajors/sidebarCerts/heroTags — 기존 데이터도 검증하고 개선
4. 커리어트리는 한국인만. 적합 인물 없으면 null

## 채울 필드 목록
- **way**: 되는 방법 200-500자. 각주 [N] 필수. 자격요건·시험·진입경로·실무팁
- **overviewSalary.sal**: 임금 서술. 각주 필수. 이미 user_contributed에 서술이 있으면 유지, 없거나 부실하면 작성
- **overviewProspect.main**: 전망 서술. 각주 필수. 이미 user_contributed에 서술이 있으면 유지, 없거나 부실하면 작성
- **trivia**: 이 직업을 진지하게 생각하게 만드는 검증된 팩트 1개
- **detailWlb**: {wlb:"등급", social:"등급", wlbDetail:"서술[N]"(130~200자,임금정보금지), socialDetail:"서술[N]"(100~160자,사회적영향만)}
- **detailReady**: {curriculum:[5개+], recruit:[채용경로], training:[양성과정]}
- **sidebarCerts**: [{name, url}]. 자격증만(시험 아님). "~시험" 금지
- **sidebarMajors**: string[]. DB 검증 필수: SELECT name FROM majors WHERE is_active=1 AND name IN (...)
- **sidebarJobs**: 7~12개. DB 검증 필수. 관련성 낮은 것 제거, 핵심 연관 직업 추가
- **heroTags**: 3~10개, 2~15자 명사구. 별칭/세부분류/영문명 포함. 기존 태그 부실하면 교체
- **overviewWork.main**: API 데이터 없으면 수행 직무 서술 (출처+각주 필수)
- **overviewAbilities.technKnow**: API 데이터 없으면 활용 기술 서술 (출처+각주 필수)
- **youtubeLinks**: [{url, title}]. YouTube Data API로 검색. 공식채널 우선 1~3개
- **detailIndicators**: 고용24 재직자 조사 7항목. **공식 통계만!** 없으면 null
- **customCharts**: 해당 직업 특유 시각화. **공식 통계만!** 없으면 null
- workStrong/workPlace/physicalAct: **짧은 라벨만** (20자 이하). 문장 금지

## 절대 금지
- abilityList/aptitude/education에 공식 통계 없이 수치 넣기 → null 유지
- 출처 없는 데이터, 추정값, AI 생성 수치
- 커리어트리에 외국인, 전직 스테이지 포함
- **커리어트리 job_slug를 이전 스테이지(학생/타직업)에 설정** — 해당 직업 첫 진입 스테이지에만 설정
- **wlb/social 등급 누락** — 반드시 포함 (페이지 요약 카드에 표시됨)
- **서술 필드에 sources 누락** — 각주 있으면 sources도 반드시 전송
- **마크다운 볼드(\*\*text\*\*) 서술 필드 사용** — 텍스트 필드에 \*\*...\*\* 절대 금지
- **같은 [N] 번호 한 필드에 2회 이상 사용** — 반드시 1회만
- **sources 배열 길이 < 본문 최대 [N]** — 반드시 일치

## 커리어트리 상세 (null이 아닌 경우)
- **한국인만**: 반드시 한국 국적. 외국인 절대 추가 금지
- **공인만**: 위키피디아 등재 또는 공식 프로필 확인 가능
- **진입 경로 중심 5단계**: 준비→진입→초기→성장→정점
- **수상/기록은 description에만** (독립 스테이지 금지)
- **job_slug**: 해당 직업에 처음 진입하는 스테이지에만 설정 (이전 스테이지는 null)
- **person_title**: 해당 직업 내 정체성만 (전직 직함 제외)
- **정치적 균형**: 특정 성향 편중 금지. 가급적 비정치인
- 마땅한 한국인 없으면 null 반환

## 각주 규칙
- 필드별 [1]부터 순차 (1, 2, 3...). 건너뛰기 금지 ([1][3] ← 금지)
- 같은 [N] 번호 한 필드에 **정확히 1회만** (2회 이상 = 치명적 오류)
- sources 배열 길이 = 본문 최대 [N] 번호 (반드시 일치)
- 마침표 뒤에: 합니다.[1] (O) / 합니다[1]. (X)

## 출처 규칙
- sources text: "[N] 출처설명" 형식. text에 URL 포함 금지
- 각 출처를 개별 {text, url} 객체로. blob 금지
- sources 키 매핑: way→"way", salary→"overviewSalary.sal", prospect→"overviewProspect.main",
  trivia→"trivia", wlbDetail→"detailWlb.wlbDetail", socialDetail→"detailWlb.socialDetail"

## 반환 형식 (이 JSON을 마지막에 출력)
{
  "jobName": "{직업명}",
  "jobId": "{JOB_ID}",
  "fields": { ... },
  "sources": { ... },
  "careerTree": { "person_name": "...", "stages_json": [...], ... } | null,
  "changeSummary": "변경 사유 상세"
}
```

---

## 성공/실패 예시

### ✅ A급 — 공인노무사
- way: 응시자격·1차5과목/2차4과목·합격기준·2025년 합격률·6개월 실무수습 (각주 4개)
- detailReady: curriculum 10과목, recruit 6경로, training 5개
- sidebarCerts: 공인노무사 (URL 포함)
- sidebarMajors: 5개 (전부 DB 존재 확인)
- trivia: 1984년 제도 도입 등 현실적 팩트 1개
- sources: 총 19개, 모든 필드에 [N] prefix, 각주 1→19 완벽 순차

### ❌ D급 — 흔한 실패 패턴
- trivia/wlbDetail/socialDetail만 채우고 way/detailReady/sidebarCerts 스킵
- "merged_profile_json에 있다"고 판단 — 실제로는 API 수치뿐
- **결과: 유저에게 실질적 도움 0, 시간만 낭비**

### ❌ sources 누락 실패
- fields에 trivia/salary/prospect/wlb 텍스트 + 각주 잘 넣음
- **sources 객체를 API에 안 보냄** → 각주 클릭 불가, 번호 깨짐

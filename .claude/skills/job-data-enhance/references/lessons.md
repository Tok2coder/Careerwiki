# 교훈 모음 — 직업 데이터 보완 작업 (통합판)

새 작업 시작 전 반드시 이 파일을 읽어라.

---

## 🔴 2026-04-17 trivia 각주 중간 배치 — 룰 D 신설

### [강화-4] trivia 중간 [N] 배치 → 마지막 문장 끝에만 → 룰 D 신설
**원인**: 임상심리사 enhance 시 `trivia = "..세 가지 병존한다.[1] 이후 두 문장이 이어짐."` 패턴으로 저장됨. 전수 스캔 결과 873개 UCJ trivia 중 130개(15%)가 동일 패턴 위반.
**강화**: `detectTriviaInlineFootnote(trivia)` — 마지막 [N] 이후 한글·영문·숫자 등 실질 텍스트가 있으면 FAIL. `[Trivia/각주중간배치]` FAIL로 차단 (validate + audit Gate5).
**실행**: trivia는 반드시 모든 문장을 쓴 뒤 맨 마지막에 [N]을 한 번만 배치. 각 문장이 다른 출처인 경우에만 문장별 [N] 허용하되 마지막 [N] 뒤 추가 문장 금지.
**수정**: 임상심리사 trivia [1] 마지막 문장 끝으로 이동 → rev 11961.
**전수 스캔**: 기존 DB 130건 위반 — 신규 저장부터 차단, 기존 데이터는 재enhance 시 점진적 정리.

---

## 🔴 2026-04-16 하네스 근본 강화 — 반복 실수 3건 차단

### [강화-1] youtubeLinks "없음" 결론 전 탐색 깊이 부족 → 룰 B 신설
**원인**: 기획관리자 enhance 시 탐색어 4개로 "영상 없음" 결론 → 재탐색 시 3개 발견.
**강화**: `_youtubeSearchNote` 탐색어 ≥6개 OR 카테고리(현직자·인터뷰/직무·실무/강의·교육/진로·면접) ≥3개 커버 필수.
`[YouTubeNote얕음]` FAIL로 차단 (validate + audit Gate5).
**실행**: 재탐색 시 최소 3개 카테고리를 명시적으로 커버하는 검색어 사용.

### [강화-2] careerTree "없음" 결론 전 후보 탐색 깊이 부족 → 룰 C 신설
**원인**: 기획관리자 careerTree "적합 없음" 결론 → 재탐색 시 정기선(HD현대) 발견.
**강화**: `_careerTreeNote` 후보 ≥5명 탐색됨(이름(이유) 형식) OR 카테고리(재벌·대기업/컨설팅/공공·정부/학계·연구/스타트업·CxO) ≥3개 커버 필수.
`[CareerTreeNote얕음]` FAIL로 차단.
**실행**: 최소 5명 + 소속/역할 + 판정 이유를 `_careerTreeNote`에 기재.

### [강화-3] UCJ detailReady 배열 항목에 [N] 누락 → 룰 A 신설
**원인**: 기획관리자 `detailReady.recruit[0]` 항목이 각주 없이 저장됨. self-check가 배열 항목 단위 검사 미수행.
**강화**: `detailReady.{curriculum,recruit,training}` 각 항목에 `[N]` 필수. `[UCJ각주항목누락]` FAIL로 차단.
**제외**: `detailReady.researchList` (CareerNet 원본, 각주 면제).

### 전수 감사 결과 (오늘 enhance 9개 직업)
- 룰 A 위반: 최고기술책임자(recruit 0,1), 자재구매관리자(recruit 2), 준법감시인(curriculum 0,3), 경찰서장(recruit 0,1)
- 룰 B 위반: 카지노딜러·캐스팅디렉터·최고기술책임자·자재구매관리자·준법감시인·광고홍보관리자·사설학원원장·경찰서장 (8개 — 노트 탐색어 5개가 많은 직업에서 카테고리 커버 부족)
- 룰 C 위반: 준법감시인, 바이오화학제품연구기획자
- **기존 데이터 자동 수정 금지** — 재enhance 시 FAIL로 걸리며 점진적 정리.

---

## 🔴 치명적 오류 (즉시 500 에러 또는 데이터 손실)

### [치명-5] detailReady.curriculum / training 항목을 객체로 저장하면 각주 렌더링 불가
**원인**: `extractReadyItem()` 함수가 처음엔 `typeof item === 'string'`만 처리했음. `{title, text, link}` 객체를 넣으면 항목 텍스트가 공백이 되어 각주 마커([N])가 사라짐.
**해결**: extractReadyItem에 객체 처리 추가로 fix됨 (2026-04-07). 하지만 **저장 자체를 막는 것이 최선**. curriculum/training은 반드시 plain string 배열.
```json
// 금지
"curriculum": [{"title":"교육기관","text":"설명","link":null}]
// 올바름
"curriculum": ["교육기관에서 설명한다.[1]"]
```
**재발 방지**: validate-job-edit.cjs Rule 12에서 객체 항목 FAIL 처리. SKILL.md detailReady 설명에 명시.

### [치명-1] way 필드를 배열로 저장하면 즉시 500 에러
**원인**: `formatRichText()` 함수가 way를 string으로 기대하는데 배열이 오면 TypeError
**해결**: way는 반드시 string. 단계별 내용은 줄바꿈(`\n`)이나 번호로 구분
```json
// 금지
"way": ["1단계: 학교 졸업", "2단계: 시험 합격"]
// 올바름
"way": "1단계: 학교를 졸업해야 한다.[1] 2단계: 국가시험에 합격해야 한다.[2]"
```

### [치명-2] fields만 전송하고 sources 누락 → 각주 완전히 깨짐
**원인**: 각주 `[N]`이 있는 필드를 저장했지만 sources 객체를 API에 안 보냄
**결과**: UI에서 참조번호가 클릭 불가, 번호 표시 깨짐
```
✅ { "fields": {"way":"..."}, "sources": {"way":[...]}, "changeSummary":"..." }
❌ { "fields": {"way":"..."}, "changeSummary":"..." }  ← sources 누락!
```

### [치명-3] worktree에서 배포하면 다음 main 배포 시 롤백
**해결**: 데이터 보완 작업은 항상 main 브랜치에서. 작업 전 `git branch --show-current` 확인.

### [치명-4] _sources를 배열/문자열로 저장하면 출처 렌더링 불가
**해결**: 반드시 A등급 포맷 `{"id":N, "text":"기관명", "url":"https://..."}` 사용

---

## 🟡 데이터 보호 오류

### [데이터-1] 기존 overviewSalary.wage 덮어쓰면 바 차트 사라짐
**원인**: `wage` 숫자값 + 구조화 포맷이 있어야 임금 바 차트 렌더링
**방지**: 보완 전 `overviewSalary.wage`가 이미 있는지 확인. 있으면 `sal` 텍스트 보강만

### [데이터-2] 기존 데이터를 낮은 품질 출처로 교체
**방지**: 변경하려면 기존 출처보다 공신력 있는 출처(정부기관, 공식 통계) 필요

---

## 🟡 각주/출처 오류

### [출처-0] 각주 번호는 필드별 독립 [1]부터 시작 (전역 번호 금지!)
**원인**: SKILL.md Gate 4 예시에 전역 id 순서(예: sal=[{id:3}], trivia=[{id:4},{id:5}])가 나와 있지만, 실제 `full-quality-audit.cjs`는 각 필드 내 [N]이 [1]부터 순차 증가하는지 독립 검사한다. 전역 번호(예: sal에 [3]) 쓰면 Gate 1 FAIL.
**해결**: 각 필드마다 독립적으로 [1], [2]... 번호 사용. sources 배열도 {id:1}, {id:2}...로 per-field 지정.
**시스템 동작**: editService가 저장 시 렌더링 순서에 따라 자동으로 전역 ID를 재할당 → 페이지에서는 [3],[4] 등 전역 번호로 표시됨.
```
✅ way: "[1]...[2]"  sources.way: [{id:1},{id:2}]
✅ sal: "[1]"        sources["overviewSalary.sal"]: [{id:1}]
✅ trivia: "[1]...[2]"  sources.trivia: [{id:1},{id:2}]
❌ sal: "[3]"        sources["overviewSalary.sal"]: [{id:3}]  ← full-quality-audit FAIL
```

### [출처-1] _sources id 순서가 본문 [N] 등장 순서와 불일치
**원인**: 섹션별로 id를 매기다 보니 본문 위→아래 등장 순서와 달라짐
**결과**: 참조번호 클릭 시 엉뚱한 출처가 표시됨
**해결**: 본문 전체를 위→아래 스캔하며 새 `[N]`이 처음 나올 때마다 메모 → 그 순서로 id 부여

```
검증 예시:
본문 스캔: [1]@way → [2]@way → [3]@sal → [4]@prospect
_sources: way=[{id:1},{id:2}], overviewSalary.sal=[{id:3}], overviewProspect.main=[{id:4}] ✅
```

### [출처-2] [N] 참조번호와 _sources id 불일치 (고아 참조)
**방지**: 본문 작성 후 사용된 모든 `[N]` 번호 목록 만들고 빠짐없이 id 부여. 반대로 sources에 id가 있는데 본문에 없는 경우도 금지.

### [출처-3] 도메인만 있는 URL 사용
**금지**: `"url": "https://www.career.go.kr"` (메인 페이지)
**올바름**: `"url": "https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=229"` (직업 상세)

### [출처-4] sources 키 이름 오류
**자주 발생하는 오류:**
- ❌ `way_sources` → ✅ `way`
- ❌ `overviewSalary_sources` → ✅ `overviewSalary.sal`
- ❌ `detailWlb_sources` → ✅ `detailWlb.wlbDetail`
- ❌ 숫자 키 `"1"`, `"2"` → ✅ 필드명 키

### [출처-5] 같은 [N] 번호를 한 필드에 2회 이상 사용
**해결**: 두 문장을 합쳐서 `[N]`을 1회만 남기기
- ❌ `초임 249만 원입니다.[1] 20호봉은 348만 원입니다.[1]`
- ✅ `초임 249만 원이며, 20호봉은 348만 원입니다.[1]`

---

## 🟡 필드 혼동 오류

### [필드-1] way와 detailReady 렌더링 위치 혼동
- `way` → 페이지 **"되는 방법" 섹션** (서술형 진로 경로)
- `detailReady` → **교육과정/채용/훈련 섹션** (curriculum/recruit/training 배열)
- way에 교육과정 목록 나열 금지 → detailReady.curriculum에 넣기

### [필드-2] wlbDetail에 임금 정보 삽입
**금지**: wlbDetail은 근무시간·야근·교대만. 임금은 overviewSalary에.

### [필드-3] socialDetail에 근무환경/취업전망 포함
**규칙**: socialDetail은 사회적 영향·공익·인식만. 근무환경은 wlbDetail에.

### [필드-4] 서술 필드에 마크다운 볼드 `**...**` 사용
**결과**: UI에 `**볼드 텍스트**` 문자열 그대로 노출. 텍스트 필드에 마크다운 금지.

---

## 🟡 YouTube 오류

### [유튜브-1] oembed 검증 없이 추가
**결과**: 삭제/비공개 영상 링크가 사용자에게 노출됨
**방지**: 추가 전 반드시 oembed 200 응답 확인

### [유튜브-2] title 없이 저장
**결과**: UI에 YouTube URL 전체 문자열이 제목 자리에 표시
**방지**: `{"url": "...", "title": "oembed 응답 title 값"}` 형식 필수

### [유튜브-3] 직업과 관련 없는 영상 선택
**결과**: 진로 탐색 사용자에게 참고 가치 없는 콘텐츠 제공
**방지**: 영상 제목에 직업명 또는 관련 키워드 포함 여부 반드시 확인 (Gate 3)

### [유튜브-4] 단순 일과 vlog 선택
**방지**: 진로 가이드 > 현직자 인터뷰 > 전망 분석 > vlog 우선순위

---

## 🟡 DB/사이드바 오류

### [DB-1] sidebarJobs/sidebarMajors에 DB에 없는 항목 추가
**결과**: 404 링크 생성. 사용자가 클릭해도 페이지 없음.
**방지**: 추가 전 `SELECT name FROM jobs WHERE name='직업명'` 확인 필수

### [DB-2] SQL 작은따옴표 충돌 (직접 wrangler 사용 시)
```sql
-- 오류: '가 SQL 문자열 구분자와 충돌
UPDATE jobs SET user_contributed_json = '{"way": "it's a job"}' ...;
-- 올바름: '' 로 이스케이프
UPDATE jobs SET user_contributed_json = '{"way": "it''s a job"}' ...;
```

---

## 🟢 작업 효율 교훈

### [효율-1] Python 스크립트/SQL 파일 생성 금지 — `--command`로 직접 실행
SQL이 너무 길 때만 `--file` 옵션 사용.

### [효율-2] 10개 배치 단위로 끊어서 처리
50개 한꺼번에 처리 중 오류 발생 시 어디서 실패했는지 파악 어려움. 10개씩 → 검증 → 다음.

### [효율-3] 출처 URL은 반드시 WebFetch로 직접 내용 대조
해당 수치/사실이 출처 페이지에 실제로 존재하는지 확인. "이 URL이면 이 내용이 있겠지" 추정 금지.

# 교훈 모음 — 직업 데이터 보완 작업 (통합판)

새 작업 시작 전 반드시 이 파일을 읽어라.

---

## 🔴 치명적 오류 (즉시 500 에러 또는 데이터 손실)

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

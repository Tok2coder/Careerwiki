# 커리어트리 작성 가이드 (Career Tree)

> 이 파일은 `job-data-create` 및 `job-data-equalize` 스킬 공통 참조 문서입니다.

직업 상세 페이지에 **"이 직업에 도달하기까지의 실제 경로 지도"**를 표시하는 기능.
게임의 스킬트리처럼, 유저가 보고 **"이 루트를 따라가면 되겠구나"** 참고할 수 있어야 한다.

---

## 인물 선정 기준

- **한국인만**: 반드시 한국 국적의 인물만 추가. 외국인은 절대 추가하지 않음
- **공인/유명인만**: 위키피디아에 등재되었거나 공식 프로필이 확인 가능한 인물
- **정확한 경력만**: 추정/소문이 아닌 **공식 출처로 확인 가능한** 경력 사항만 입력
- **다양성**: 같은 직업에 2~3명 정도, 가급적 다른 시대/분야/성별 배경
- **⚠️ 마땅한 한국인 인물이 없으면 안 넣는다** — 지어내거나 억지로 넣지 않음
- **사생활 침해 금지**: 논란이 있거나 사생활 노출 우려가 있는 경력은 제외
- **정치적 중립**: 특정 정치 성향으로 편향되지 않도록 인물 선정. 정치인 출신은 가급적 피하고, 해당 직업 자체로 유명한 인물 우선. 부득이하게 정치인을 넣을 경우 진보/보수 균형 맞출 것

---

## 스테이지 작성 기준 (핵심!)

커리어트리는 **업적 나열이 아니라 진입 과정과 성장 경로**를 보여줘야 한다.

**올바른 스테이지 구성:**
1. **진입 전 준비** — 어떤 학교, 어떤 전공, 왜 이 길을 선택했는지
2. **진입 과정** — 시험, 훈련, 자격 취득, 수습 과정
3. **초기 커리어** — 첫 직장, 신입 시절, 적응 과정
4. **성장 단계** — 승진, 전문화, 역량 확장
5. **현재/정점** — 해당 직업 내에서의 현재 위치

**필수 규칙:**
- **반드시 하나의 스테이지에 해당 직업 페이지의 직업이 포함되어야 함** (`job_slug` 연결)
- **`job_slug`는 해당 직업에 처음 진입하는 스테이지에만 설정** — 이전 스테이지(학생, 타 직업 등)에는 반드시 `null`
  - ❌ 잘못: 대학 재학 스테이지(order=0)에 job_slug 설정 → 프로덕션에서 엉뚱한 스테이지가 강조됨
  - ✅ 올바름: "직업명 취업/입사/데뷔" 스테이지(order=N)에만 job_slug 설정
- 해당 직업 이후의 전직(감독, 정치인 등)은 **제외** — 이 페이지는 그 직업에 관한 것
- 수상/업적 자체를 스테이지로 만들지 않음 — description에 간략히 언급만
- "대학 졸업" 같은 모호한 스테이지 금지 — "서울대 체육교육과 졸업 (자전거 선수 출신)"처럼 구체적으로

**❌ 잘못된 예시 (업적 나열):**
```
1. 대학 졸업 (2005)
2. 데뷔 (2006)
3. 금메달 수상 (2010)
4. 47연승 (2015)
5. 감독 취임 (2020)  ← 전직이므로 제외
```

**✅ 올바른 예시 (진입 경로):**
```
1. 용인체육고 자전거부 (2000-2003) — "중학교 자전거대회 입상 후 체육고 진학"
2. 경륜훈련원 입소 (2003-2004) — "11개월 합숙 훈련, 실기·필기 검정 통과"
3. 경륜선수 데뷔 (2004) — "광명경륜장 첫 출주, C급에서 시작" ← job_slug: 경륜선수
4. A급 승격 (2007) — "3년 만에 최상위 등급, 연간 승률 35%"
5. 국가대표 선발 (2010) — "아시안게임 대표, 트랙사이클 종목"
```

---

## 데이터 구조

```typescript
interface CareerTreeStage {
  order: number           // 정렬 순서 (0-based)
  title: string           // 직함/역할 (예: '수학교사', '교장')
  organization?: string   // 소속 (예: '서울과학고등학교')
  years?: string          // 기간 (예: '1998-2011')
  description?: string    // 한 줄 설명
  job_slug?: string | null // CW 직업 페이지 슬러그 (있으면 링크 생성)
}
```

---

## DB 삽입 방법

Admin API에 관리자 권한이 필요하므로, **wrangler d1으로 직접 삽입**:

```bash
# 1. career_trees 테이블에 인물 삽입
cd C:/Users/PC/Careerwiki && npx wrangler d1 execute careerwiki-kr --remote --command \
  "INSERT INTO career_trees (person_name, person_name_en, person_title, person_image_url, stages_json, display_priority, is_active, created_at, updated_at)
   VALUES ('인물명', '영문명', '한 줄 소개', NULL,
   '[{\"order\":0,\"title\":\"직함\",\"organization\":\"소속\",\"years\":\"기간\",\"description\":\"설명\",\"job_slug\":null}]',
   100, 1, unixepoch()*1000, unixepoch()*1000)"

# 2. 삽입된 ID 확인
npx wrangler d1 execute careerwiki-kr --remote --command \
  "SELECT id FROM career_trees WHERE person_name='인물명' ORDER BY id DESC LIMIT 1"

# 3. career_tree_job_links에 직업 연결 (stage_index = 해당 직업 스테이지의 배열 인덱스)
npx wrangler d1 execute careerwiki-kr --remote --command \
  "INSERT INTO career_tree_job_links (career_tree_id, job_slug, stage_index) VALUES ({ID}, '{직업슬러그}', {스테이지인덱스})"
```

---

## job_slug 매칭 규칙

- `job_slug`는 jobs 테이블의 `slug` 컬럼 값 (보통 직업명과 동일)
- stages 배열에서 CW에 존재하는 직업에만 `job_slug` 설정 → 해당 직업 페이지에서 하이라이트
- 존재 여부 확인: `SELECT slug FROM jobs WHERE slug='슬러그' AND is_active=1`

---

## 리서치 절차

1. WebSearch로 `"{인물명}" 경력 이력` 검색
2. 위키피디아, 나무위키, 공식 프로필 등에서 경력 단계 확인
3. **반드시 2개 이상 출처로 교차 검증** — 한 출처만으로 경력 입력 금지
4. 불확실한 경력 단계는 제외

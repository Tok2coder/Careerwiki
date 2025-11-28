<!-- c1d24d26-228f-480a-9d98-e168cd266a51 2c3e436d-e865-40a5-934a-49f05844cf4f -->
# 히어로 섹션 병합 규칙 업데이트

## 현재 구조 분석

- ETL (`mergeJobProfiles.ts`): `job_sources` → `jobs.merged_profile_json` 병합
- 템플릿 (`unifiedJobDetail.ts`): `merged_profile_json` → HTML 렌더링
- 병합은 **ETL 단계**에서 수행

## 구현 계획

### 1. ETL 병합 로직 수정 (`src/scripts/etl/mergeJobProfiles.ts`)

#### 1.1 카테고리 필드 (조건부 병합)

```typescript
// 고용24 대/중/소분류가 모두 있으면 브레드크럼 스타일
// 없으면 단일 우선순위 선택
const jobLrclNm = goyong24Normalized?.jobLrclNm
const jobMdclNm = goyong24Normalized?.jobMdclNm
const jobSmclNm = goyong24Normalized?.jobSmclNm

if (jobLrclNm && jobMdclNm && jobSmclNm) {
  heroCategory = {
    type: 'breadcrumb',
    large: jobLrclNm,
    medium: jobMdclNm,
    small: jobSmclNm
  }
} else {
  // Fallback: 커리어넷 → 직업사전
  heroCategory = {
    type: 'single',
    value: careernetData?.aptit_name || djobData?.dJobICdNm
  }
}
```

#### 1.2 직업명 (우선순위)

```typescript
heroTitle = selectBestValue(
  careernetData?.jobName,
  jobData?.jobNm,
  djobData?.dJobNm
)
```

#### 1.3 직업 소개 (우선순위)

```typescript
heroIntro = selectBestValue(
  careernetData?.summary,
  jobData?.jobSum,
  djobData?.workSum
)
```

#### 1.4 태그 (병합 + 중복제거)

```typescript
// 4개 소스 수집
const allTags = [
  careernetData?.tag,
  careernetData?.tagList,
  djobData?.similarNm,
  djobData?.connectJob
]

// 쉼표/공백 기준 split 후 중복 제거
const tagSet = new Set()
allTags.forEach(source => {
  if (source) {
    const tags = typeof source === 'string' 
      ? source.split(/[,，\s]+/)
      : Array.isArray(source) 
        ? source 
        : []
    tags.forEach(tag => {
      const cleaned = tag.trim()
      if (cleaned) tagSet.add(cleaned)
    })
  }
})

heroTags = Array.from(tagSet)
```

### 2. merged_profile_json 스키마 확장

`UnifiedJobDetail` 인터페이스에 추가:

```typescript
interface HeroCategory {
  type: 'breadcrumb' | 'single'
  large?: string
  medium?: string
  small?: string
  value?: string
}

interface UnifiedJobDetail {
  // ... 기존 필드
  heroCategory?: HeroCategory
  heroTitle?: string
  heroIntro?: string
  heroTags?: string[]
}
```

### 3. 템플릿 렌더링 업데이트 (`src/templates/unifiedJobDetail.ts`)

#### 3.1 카테고리 렌더링

```typescript
// line ~2578 근처
let categoryHtml = ''
if (profile.heroCategory) {
  if (profile.heroCategory.type === 'breadcrumb') {
    categoryHtml = `<div class="text-sm text-wiki-muted mb-2">
      ${profile.heroCategory.large} > 
      ${profile.heroCategory.medium} > 
      ${profile.heroCategory.small}
    </div>`
  } else if (profile.heroCategory.value) {
    categoryHtml = `<span class="inline-block px-3 py-1 text-sm bg-wiki-card rounded-full text-wiki-muted mb-3">
      ${escapeHtml(profile.heroCategory.value)}
    </span>`
  }
}
```

#### 3.2 제목 및 소개

```typescript
const heroTitle = profile.heroTitle || profile.name
const heroDescription = profile.heroIntro?.split('\n')[0]?.trim() 
  || profile.summary?.split('\n')[0]?.trim()
```

#### 3.3 태그 렌더링

```typescript
let tagsHtml = ''
if (profile.heroTags && profile.heroTags.length > 0) {
  tagsHtml = renderChips(profile.heroTags.slice(0, 8)) // 최대 8개만 표시
}
```

### 4. 템플릿 버전 증가

`src/constants/template-versions.ts`:

```typescript
export const TEMPLATE_VERSIONS = {
  JOB: 42,  // 41 → 42
  MAJOR: 108
}
```

### 5. 타입 정의 업데이트

`src/types/unifiedProfiles.ts`에 `HeroCategory` 인터페이스 추가

## 주요 파일

- `src/scripts/etl/mergeJobProfiles.ts` - 병합 로직
- `src/templates/unifiedJobDetail.ts` - 렌더링 로직
- `src/types/unifiedProfiles.ts` - 타입 정의
- `src/constants/template-versions.ts` - 버전 관리

## 검증 방법

1. ETL 재실행: `npm run etl:merge-jobs`
2. 페이지 확인: `http://localhost:3000/job/software-developer`
3. 카테고리 브레드크럼 표시 확인
4. 태그 중복 제거 확인
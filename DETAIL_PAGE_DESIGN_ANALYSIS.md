# Detail Page Layout Design Analysis
## CareerWiki - Optimized for SEO & Information Quality

**Last Updated**: 2025-10-07  
**Purpose**: Analyze CareerNet API data structure and design optimal detail pages for Job, Major, and HowTo content

---

## 1. Executive Summary

Based on the analysis of CareerNet API responses and current Careerwiki implementation, I've identified key data fields available and designed three comprehensive detail page layouts that prioritize:

1. **SEO Optimization**: Rich structured data, semantic HTML, meta tags
2. **Information Quality**: Maximum utilization of available API data
3. **User Experience**: Clear hierarchy, scannable content, mobile-friendly
4. **Engagement**: Related content, user comments, CTA buttons

---

## 2. Available API Data Analysis

### 2.1 Job API Data (고용24 직업정보)

#### Primary Fields from XML Response:
```typescript
interface JobAPIResponse {
  // 기본 정보
  jobdicSeq: string;        // 직업 코드 (고유 ID)
  job: string;              // 직업명
  profession: string;       // 직업 분류 (대분류)
  summary: string;          // 직업 요약 설명
  
  // 경제적 정보
  salery: string;           // 평균 연봉
  
  // 전망 및 동향
  possibility: string;      // 직업 전망
  equalemployment: string;  // 고용 평등 정보 / 고용 동향
  
  // 유사 직업
  similarJob: string;       // 유사 직업군
  
  // 적성 유형
  aptd_type_code: string;   // 적성 유형 코드
  
  // 분류 코드
  job_ctg_code: string;     // 직업 카테고리 코드
  job_code: string;         // 직업 코드
}
```

#### Additional Data Available (from Category Constants):
- **직업 카테고리**: 21개 대분류 (관리직, IT, 의료, 교육 등)
- **적성 유형**: 11개 유형 (IT관련전문직, 공학전문직 등)

#### Currently Missing Fields (require supplemental data):
- 상세 업무 내용 (하는 일)
- 필요 학력
- 필요 자격증
- 관련 학과
- 진출 분야
- 근무 환경
- 직업 훈련

### 2.2 Major API Data (학과정보)

#### Primary Fields from XML Response:
```typescript
interface MajorAPIResponse {
  // 기본 정보
  majorSeq: string;         // 학과 코드 (고유 ID)
  mClass: string;           // 학과명 (중분류)
  lClass: string;           // 학과 계열 (대분류)
  facilName: string;        // 시설/학과 전체명
  
  // 대학 정보
  university: string;       // 개설 대학 목록
  campus: string;           // 캠퍼스 정보
  url: string;              // 학과 URL
  
  // 분류 정보
  subject: string;          // 학문 분야
  facilSeq: string;         // 시설 코드
}
```

#### Currently Missing Fields (require supplemental data):
- 학과 상세 설명
- 적성 및 흥미
- 교과목 (고등학교 이수 과목)
- 대학 전공 커리큘럼
- 취업률
- 평균 초봉
- 진출 가능 직업
- 자격증

---

## 3. Detail Page Design Recommendations

### 3.1 Job Detail Page Layout

#### Page Structure:
```
┌─────────────────────────────────────────┐
│ 1. Hero Section (직업 헤더)              │
│    - 직업명 (H1)                         │
│    - 직업 분류 (Breadcrumb)               │
│    - Quick Stats (연봉/전망/고용동향)      │
│    - Action Buttons (편집/공유/AI분석)    │
├─────────────────────────────────────────┤
│ 2. Content Grid (70% | 30%)             │
│ ┌──────────────────┬──────────────────┐ │
│ │ Left Column (70%) │ Right Sidebar    │ │
│ │                   │ (30%)            │ │
│ │ ▼ 직업 개요        │ ▶ 관련 학과      │ │
│ │ ▼ 하는 일          │ ▶ 유사 직업      │ │
│ │ ▼ 적성 및 흥미     │ ▶ 관련 자격증    │ │
│ │ ▼ 필요 학력/전공   │ ▶ HowTo 가이드   │ │
│ │ ▼ 근무 환경        │ ▶ 추천 교육과정  │ │
│ │ ▼ 취업 현황        │                  │ │
│ │ ▼ 임금 정보        │                  │ │
│ │ ▼ 직업 전망        │                  │ │
│ │ ▼ 관련 직업        │                  │ │
│ │ ▼ 댓글 섹션        │                  │ │
│ └──────────────────┴──────────────────┘ │
└─────────────────────────────────────────┘
```

#### SEO Optimizations:
1. **Meta Tags**:
```html
<title>[직업명] 연봉 · 전망 · 되는 법 총정리 | Careerwiki</title>
<meta name="description" content="[직업명] 평균 연봉 [금액], 전망 [전망], 필요 학력, 자격증, 진출 방법까지 완벽 정리. AI 기반 맞춤 분석도 받아보세요.">
<meta property="og:title" content="[직업명] 완벽 가이드 | Careerwiki">
<meta property="og:description" content="연봉 정보, 취업 전망, 필요 역량까지 한눈에">
<link rel="canonical" href="https://careerwiki.org/job/[slug]">
```

2. **Structured Data (JSON-LD)**:
```json
{
  "@context": "https://schema.org",
  "@type": "Occupation",
  "name": "소프트웨어 엔지니어",
  "description": "컴퓨터 프로그램과 시스템을 설계...",
  "occupationalCategory": "IT/소프트웨어",
  "estimatedSalary": {
    "@type": "MonetaryAmountDistribution",
    "name": "연봉 범위",
    "currency": "KRW",
    "duration": "P1Y",
    "percentile10": 35000000,
    "median": 50000000,
    "percentile90": 100000000
  },
  "skills": "프로그래밍, 알고리즘, 데이터베이스",
  "responsibilities": "소프트웨어 설계, 개발, 테스트..."
}
```

3. **Semantic HTML**:
```html
<article itemscope itemtype="https://schema.org/Occupation">
  <header>
    <h1 itemprop="name">소프트웨어 엔지니어</h1>
    <nav aria-label="breadcrumb">
      <ol class="breadcrumb">
        <li><a href="/job">직업위키</a></li>
        <li><a href="/job/category/IT">IT</a></li>
        <li class="active">소프트웨어 엔지니어</li>
      </ol>
    </nav>
  </header>
  
  <section itemprop="description">
    <h2>직업 개요</h2>
    <p>...</p>
  </section>
  
  <section itemprop="responsibilities">
    <h2>하는 일</h2>
    <ul>
      <li>...</li>
    </ul>
  </section>
</article>
```

#### Content Sections Detail:

**1. Hero Section**:
```html
<!-- Stats Cards -->
<div class="stats-grid grid-cols-4">
  <div class="stat-card">
    <span class="label">평균 연봉</span>
    <span class="value">{salery}</span>
  </div>
  <div class="stat-card">
    <span class="label">직업 전망</span>
    <span class="value">{possibility}</span>
  </div>
  <div class="stat-card">
    <span class="label">고용 동향</span>
    <span class="value">{equalemployment}</span>
  </div>
  <div class="stat-card">
    <span class="label">적성 유형</span>
    <span class="value">{aptd_type_code}</span>
  </div>
</div>
```

**2. 직업 개요** (from API: `summary`):
- API `summary` 필드 직접 표시
- 2-3 문단으로 구성
- 핵심 업무 한 줄 요약

**3. 하는 일** (supplemental data needed):
- 주요 업무 리스트 (bullet points)
- 일일 업무 루틴
- 프로젝트/과제 유형

**4. 적성 및 흥미** (from API: `aptd_type_code`):
- 적성 유형 설명
- 필요한 성격 특성
- 관심사 매칭

**5. 필요 학력/전공** (supplemental):
- 최소 학력 요구사항
- 관련 전공 링크 (내부 링크 to /major pages)
- 대체 경로 (부트캠프, 자격증 등)

**6. 임금 정보** (from API: `salery`):
```html
<div class="salary-section">
  <h3>평균 연봉</h3>
  <div class="salary-range">
    <span class="amount">{salery}</span>
  </div>
  <p class="note">* 고용24 기준 평균값</p>
  
  <!-- 경력별 연봉 (supplemental) -->
  <div class="salary-by-experience">
    <div>신입: X만원</div>
    <div>3년차: X만원</div>
    <div>10년차: X만원</div>
  </div>
</div>
```

**7. 직업 전망** (from API: `possibility`):
- API 전망 데이터 표시
- 성장 요인 분석
- 미래 변화 예측

**8. 관련 직업** (from API: `similarJob`):
```html
<div class="related-jobs grid-cols-3">
  {#each similarJob.split(',') as job}
    <a href="/job/{slug(job)}" class="job-card">
      <h4>{job}</h4>
      <p>유사 업무 ⋯</p>
    </a>
  {/each}
</div>
```

**9. Right Sidebar**:
- **관련 학과**: (supplemental, link to /major pages)
- **유사 직업**: (from `similarJob` API field)
- **관련 자격증**: (supplemental)
- **HowTo 가이드**: (link to /howto pages)
- **AI 분석 CTA**: "이 직업이 나에게 맞을까? AI 분석 받기"

---

### 3.2 Major Detail Page Layout

#### Page Structure:
```
┌─────────────────────────────────────────┐
│ 1. Hero Section (학과 헤더)              │
│    - 학과명 (H1)                         │
│    - 학과 계열 (Breadcrumb)               │
│    - Quick Stats (취업률/초봉/대학수)     │
│    - Action Buttons                      │
├─────────────────────────────────────────┤
│ 2. Content Grid (70% | 30%)             │
│ ┌──────────────────┬──────────────────┐ │
│ │ Left Column (70%) │ Right Sidebar    │ │
│ │                   │ (30%)            │ │
│ │ ▼ 학과 개요        │ ▶ 개설 대학      │ │
│ │ ▼ 적성 및 흥미     │ ▶ 관련 학과      │ │
│ │ ▼ 고등학교 교과목  │ ▶ 진출 직업      │ │
│ │ ▼ 대학 커리큘럼    │ ▶ 자격증         │ │
│ │ ▼ 졸업 후 진로     │ ▶ HowTo 가이드   │ │
│ │ ▼ 취업 현황        │                  │ │
│ │ ▼ 연봉 정보        │                  │ │
│ │ ▼ 관련 학과        │                  │ │
│ │ ▼ 댓글 섹션        │                  │ │
│ └──────────────────┴──────────────────┘ │
└─────────────────────────────────────────┘
```

#### SEO Optimizations:
1. **Meta Tags**:
```html
<title>[학과명] 취업률 · 연봉 · 커리큘럼 총정리 | Careerwiki</title>
<meta name="description" content="[학과명] 개설 대학 [N]개, 취업률 [%], 평균 초봉 [금액]. 커리큘럼, 진출 분야, 필요 역량까지 완벽 가이드.">
<meta property="og:title" content="[학과명] 완벽 가이드 | Careerwiki">
<link rel="canonical" href="https://careerwiki.org/major/[slug]">
```

2. **Structured Data (JSON-LD)**:
```json
{
  "@context": "https://schema.org",
  "@type": "EducationalOccupationalProgram",
  "name": "컴퓨터공학과",
  "description": "컴퓨터 시스템과 소프트웨어를...",
  "provider": {
    "@type": "CollegeOrUniversity",
    "name": "서울대, KAIST, POSTECH 외 124개 대학"
  },
  "occupationalCredentialAwarded": "학사학위",
  "occupationalCategory": "공학계열",
  "timeToComplete": "P4Y"
}
```

#### Content Sections Detail:

**1. Hero Section**:
```html
<div class="stats-grid grid-cols-4">
  <div class="stat-card">
    <span class="label">취업률</span>
    <span class="value">{employmentRate}%</span>
  </div>
  <div class="stat-card">
    <span class="label">평균 초봉</span>
    <span class="value">{salaryAfterGraduation}</span>
  </div>
  <div class="stat-card">
    <span class="label">개설 대학</span>
    <span class="value">{universityCount}개</span>
  </div>
  <div class="stat-card">
    <span class="label">경쟁률</span>
    <span class="value">{competitionRate}:1</span>
  </div>
</div>
```

**2. 학과 개요** (from API: `facilName`, `summary`):
- API 데이터 기반 설명
- 학문 분야 소개
- 학과 특징

**3. 적성 및 흥미** (supplemental):
- 적합한 성격 유형
- 관심 분야
- 필요한 능력

**4. 고등학교 교과목** (supplemental):
```html
<div class="curriculum-section">
  <h3>공통과목</h3>
  <div class="subject-tags">
    <span class="tag">수학</span>
    <span class="tag">과학</span>
    <span class="tag">기술·가정</span>
  </div>
  
  <h3>일반선택과목</h3>
  <p>수학Ⅰ, 수학Ⅱ, 미적분, 확률과 통계, 물리학Ⅰ, 화학Ⅰ...</p>
  
  <h3>진로선택과목</h3>
  <p>기하, 물리학Ⅱ, 화학Ⅱ, 공학 일반</p>
</div>
```

**5. 대학 커리큘럼** (supplemental):
- 주요 전공 과목
- 학년별 과목 구성
- 실습/프로젝트

**6. 졸업 후 진로** (supplemental + link to jobs):
```html
<div class="career-paths grid-cols-3">
  <a href="/job/{slug}" class="career-card">
    <i class="icon"></i>
    <h4>{jobName}</h4>
    <p>{jobDesc}</p>
  </a>
</div>
```

**7. 개설 대학** (from API: `university`):
```html
<div class="university-list">
  <h3>주요 개설 대학 ({count}개)</h3>
  {#if university}
    {#each university.split(',') as univ}
      <div class="university-item">
        <span class="name">{univ}</span>
        <a href="{campus_url}" target="_blank">홈페이지</a>
      </div>
    {/each}
  {/if}
  <button class="view-all">전체 대학 보기</button>
</div>
```

**8. Right Sidebar**:
- **개설 대학** (from `university` API field)
- **관련 학과** (similar majors)
- **진출 가능 직업** (link to /job pages)
- **취득 가능 자격증**
- **HowTo 가이드** (대학 선택, 전과 가이드 등)

---

### 3.3 HowTo Detail Page Layout

#### Page Structure:
```
┌─────────────────────────────────────────┐
│ 1. Hero Section (가이드 헤더)            │
│    - 제목 (H1)                           │
│    - 카테고리 (Breadcrumb)                │
│    - 작성일/업데이트                       │
│    - 난이도/소요시간                       │
├─────────────────────────────────────────┤
│ 2. Table of Contents (목차)             │
│    - 자동 생성 anchor 링크               │
├─────────────────────────────────────────┤
│ 3. Content Grid (70% | 30%)             │
│ ┌──────────────────┬──────────────────┐ │
│ │ Left Column (70%) │ Right Sidebar    │ │
│ │                   │ (30%)            │ │
│ │ ▼ Step 1          │ ▶ 관련 직업      │ │
│ │ ▼ Step 2          │ ▶ 관련 전공      │ │
│ │ ▼ Step 3          │ ▶ 다른 HowTo     │ │
│ │ ▼ Step 4          │ ▶ AI 분석 CTA    │ │
│ │ ▼ 성공 사례        │                  │ │
│ │ ▼ 주의사항         │                  │ │
│ │ ▼ FAQ             │                  │ │
│ │ ▼ 댓글             │                  │ │
│ └──────────────────┴──────────────────┘ │
└─────────────────────────────────────────┘
```

#### SEO Optimizations:
1. **Meta Tags**:
```html
<title>[목표] 되는 법 · 완벽 로드맵 | Careerwiki HowTo</title>
<meta name="description" content="[목표] 달성을 위한 단계별 완벽 가이드. 필요 학력, 자격증, 준비 기간, 성공 전략까지 실전 노하우 총정리.">
<meta property="og:title" content="[목표] 되는 법 | Careerwiki">
<meta property="og:type" content="article">
<link rel="canonical" href="https://careerwiki.org/howto/[slug]">
```

2. **Structured Data (JSON-LD)**:
```json
{
  "@context": "https://schema.org",
  "@type": "HowTo",
  "name": "로스쿨 들어가는 법",
  "description": "법학전문대학원 입학 준비부터...",
  "totalTime": "P2Y",
  "step": [
    {
      "@type": "HowToStep",
      "name": "1단계: 학부 성적 관리",
      "text": "...",
      "url": "https://careerwiki.org/howto/law-school#step1"
    }
  ]
}
```

#### Content Sections Detail:

**1. Hero Section**:
```html
<div class="howto-meta">
  <div class="meta-item">
    <i class="fas fa-clock"></i>
    <span>소요 시간: 2-4년</span>
  </div>
  <div class="meta-item">
    <i class="fas fa-signal"></i>
    <span>난이도: 상</span>
  </div>
  <div class="meta-item">
    <i class="fas fa-won-sign"></i>
    <span>예상 비용: 5,000-10,000만원</span>
  </div>
  <div class="meta-item">
    <i class="fas fa-calendar"></i>
    <span>업데이트: 2024.10.01</span>
  </div>
</div>
```

**2. Table of Contents**:
```html
<nav class="toc">
  <h2>목차</h2>
  <ol>
    <li><a href="#step1">1단계: 학부 준비</a></li>
    <li><a href="#step2">2단계: LEET 준비</a></li>
    <li><a href="#step3">3단계: 서류 준비</a></li>
    <li><a href="#step4">4단계: 면접 준비</a></li>
    <li><a href="#success">성공 사례</a></li>
    <li><a href="#faq">FAQ</a></li>
  </ol>
</nav>
```

**3. Step-by-Step Content**:
```html
<section id="step1" class="howto-step">
  <h2>
    <span class="step-number">1</span>
    학부 성적 관리
  </h2>
  <div class="step-content">
    <h3>목표</h3>
    <p>GPA 3.5 이상 유지</p>
    
    <h3>구체적 방법</h3>
    <ul>
      <li>전공 과목 A 이상</li>
      <li>교양 과목 균형</li>
      <li>...</li>
    </ul>
    
    <h3>소요 기간</h3>
    <p>4년 (학부 전체 기간)</p>
    
    <div class="tip-box">
      <i class="fas fa-lightbulb"></i>
      <strong>Tip:</strong> 1학년부터 관리하는 것이 중요합니다.
    </div>
  </div>
</section>
```

**4. 성공 사례**:
```html
<section id="success" class="success-stories">
  <h2>성공 사례</h2>
  <div class="story-card">
    <div class="author">
      <img src="avatar.png" alt="익명">
      <div>
        <h4>K대 로스쿨 합격</h4>
        <span>2023년 입학</span>
      </div>
    </div>
    <p>저는 지방대 출신으로...</p>
    <div class="stats">
      <span>학부 GPA: 3.8</span>
      <span>LEET: 140점</span>
    </div>
  </div>
</section>
```

**5. FAQ**:
```html
<section id="faq" class="faq-section">
  <h2>자주 묻는 질문</h2>
  <details class="faq-item">
    <summary>Q. 비법대생도 로스쿨 갈 수 있나요?</summary>
    <p>A. 네, 가능합니다. 오히려...</p>
  </details>
</section>
```

**6. Right Sidebar**:
- **관련 직업**: "변호사", "법무사", "로클럭" 등
- **관련 전공**: "법학과", "행정학과" 등
- **다른 HowTo**: "검사 되는 법", "판사 되는 법" 등
- **AI 분석 CTA**: "나에게 맞는 진로인지 AI로 분석받기"

---

## 4. Common Design Elements

### 4.1 Unified Component Library

All three page types share these components:

**1. Glass Card**:
```css
.glass-card {
  background: rgba(26, 26, 46, 0.8);
  backdrop-filter: blur(10px);
  border: 1px solid rgba(67, 97, 238, 0.2);
  border-radius: 12px;
  padding: 24px;
}
```

**2. Stat Card**:
```html
<div class="stat-card glass-card">
  <div class="stat-icon">
    <i class="fas fa-won-sign text-wiki-secondary"></i>
  </div>
  <div class="stat-content">
    <span class="stat-label">평균 연봉</span>
    <span class="stat-value">5,000만원</span>
  </div>
</div>
```

**3. Action Buttons**:
```html
<div class="action-buttons">
  <button class="btn-primary">
    <i class="fas fa-brain"></i>
    AI 분석 받기
  </button>
  <button class="btn-secondary">
    <i class="fas fa-edit"></i>
    편집 제안
  </button>
  <button class="btn-secondary">
    <i class="fas fa-share"></i>
    공유
  </button>
</div>
```

**4. Related Content Grid**:
```html
<div class="related-content">
  <h3>관련 {type}</h3>
  <div class="grid grid-cols-3 gap-4">
    <a href="/job/{slug}" class="related-card glass-card hover-glow">
      <h4>{title}</h4>
      <p class="text-sm text-wiki-muted">{description}</p>
      <div class="meta">
        <span>{metadata}</span>
      </div>
    </a>
  </div>
</div>
```

**5. Comment Section**:
```html
<section class="comments-section glass-card">
  <h2>전체 의견</h2>
  
  <!-- Best Comments -->
  <div class="best-comments">
    <h3 class="text-wiki-secondary">베스트 의견</h3>
    <div class="comment best-comment">
      <div class="comment-header">
        <span class="author">사용자123</span>
        <span class="date">2024.10.26</span>
        <span class="badge">베스트</span>
      </div>
      <p class="comment-body">...</p>
      <div class="comment-actions">
        <button class="upvote">👍 128</button>
        <button class="reply">답글</button>
      </div>
    </div>
  </div>
  
  <!-- Comment Form -->
  <form class="comment-form">
    <textarea placeholder="의견을 작성해주세요 (300자 이내)" maxlength="300"></textarea>
    <button type="submit" class="btn-primary">의견 등록</button>
  </form>
  
  <!-- All Comments -->
  <div class="all-comments">
    <!-- Comments list -->
  </div>
</section>
```

### 4.2 Responsive Breakpoints

```css
/* Mobile First */
.content-grid {
  display: block; /* Stack on mobile */
}

/* Tablet */
@media (min-width: 768px) {
  .content-grid {
    display: grid;
    grid-template-columns: 1fr;
  }
}

/* Desktop */
@media (min-width: 1024px) {
  .content-grid {
    grid-template-columns: 70% 30%;
    gap: 2rem;
  }
}
```

### 4.3 Dark Theme Color System

```css
:root {
  --wiki-bg: #0f0f23;
  --wiki-card: #1a1a2e;
  --wiki-border: #2a2a3e;
  --wiki-primary: #4361ee;
  --wiki-secondary: #64b5f6;
  --wiki-text: #e0e0e0;
  --wiki-muted: #9ca3af;
}
```

---

## 5. Data Limitations & Solutions

### 5.1 Missing API Data

**Problem**: CareerNet API provides limited fields (summary, salary, outlook only)

**Solutions**:
1. **Phase 1 (MVP)**: Use available API data + hardcoded supplemental content
2. **Phase 2**: Build internal CMS for community contributions
3. **Phase 3**: AI-generated content using GPT-4 based on API data
4. **Phase 4**: Wikipedia-style user editing system

### 5.2 Supplemental Data Sources

**Immediate Sources**:
- **워크넷** (work.go.kr): 직업 상세 정보
- **커리어넷 웹사이트**: 스크래핑 (합법적 범위 내)
- **한국직업능력연구원**: 직업 분류 체계
- **대학 알리미**: 학과별 통계
- **사람인/잡코리아**: 실제 채용 데이터

**Long-term Strategy**:
- User-generated content (위키 방식)
- AI content generation
- 파트너십 (대학, 기업)

### 5.3 Data Freshness Strategy

```typescript
// Cache strategy for API data
const CACHE_DURATIONS = {
  job: 7 * 24 * 60 * 60,      // 7 days
  major: 30 * 24 * 60 * 60,   // 30 days
  howto: 90 * 24 * 60 * 60    // 90 days (manual content)
}

// Cloudflare KV cache
async function getCachedData(key: string, type: 'job' | 'major' | 'howto') {
  const cached = await KV.get(key)
  if (cached) {
    const data = JSON.parse(cached)
    const age = Date.now() - data.timestamp
    if (age < CACHE_DURATIONS[type] * 1000) {
      return data.content
    }
  }
  return null
}
```

---

## 6. SEO Strategy Summary

### 6.1 On-Page SEO Checklist

**Every Detail Page Must Have**:
- [ ] Unique H1 with target keyword
- [ ] Meta title (50-60 characters) with keyword
- [ ] Meta description (150-160 characters) with CTA
- [ ] Canonical URL
- [ ] Open Graph tags
- [ ] Structured data (JSON-LD)
- [ ] Semantic HTML5 (article, section, header, nav)
- [ ] Image alt texts
- [ ] Internal links (to related content)
- [ ] External links (to authoritative sources)
- [ ] Mobile-responsive
- [ ] Fast load time (<3s)

### 6.2 Content SEO Strategy

**Target Keywords**:
- **Job Pages**: "[직업명] 연봉", "[직업명] 되는 법", "[직업명] 전망"
- **Major Pages**: "[학과명] 취업률", "[학과명] 커리큘럼", "[학과명] 대학"
- **HowTo Pages**: "[목표] 되는 법", "[목표] 로드맵", "[목표] 준비"

**Content Length**:
- **Minimum**: 1,500 words per page
- **Optimal**: 2,500-3,500 words
- **Include**: Lists, tables, visual elements

**Update Frequency**:
- Job pages: Monthly (salary, outlook data)
- Major pages: Quarterly (university data)
- HowTo pages: As needed (regulatory changes)

### 6.3 Technical SEO

**URL Structure**:
```
https://careerwiki.org/job/[slug]           # 직업
https://careerwiki.org/major/[slug]         # 전공
https://careerwiki.org/howto/[slug]         # HowTo
```

**Sitemap**:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  <url>
    <loc>https://careerwiki.org/job/software-engineer</loc>
    <lastmod>2024-10-01</lastmod>
    <changefreq>monthly</changefreq>
    <priority>0.8</priority>
  </url>
</urlset>
```

**robots.txt**:
```
User-agent: *
Allow: /
Sitemap: https://careerwiki.org/sitemap.xml
```

---

## 7. Implementation Priority

### Phase 1: MVP (Week 1-2)
1. Create 3 sample pages for each type (9 total)
2. Implement basic layout with API data
3. Add essential SEO tags
4. Deploy to production

### Phase 2: Content Expansion (Week 3-4)
1. Generate 50 job detail pages
2. Generate 50 major detail pages
3. Write 20 HowTo guides
4. Implement internal linking

### Phase 3: Enhancement (Week 5-6)
1. Add comment system
2. Implement user editing
3. Add AI content generation
4. Performance optimization

### Phase 4: Scale (Week 7+)
1. Generate all available job pages (1000+)
2. Generate all available major pages (500+)
3. Community features
4. Advanced analytics

---

## 8. Metrics & Success Criteria

### Key Performance Indicators

**SEO Metrics**:
- Organic traffic: Target 10,000 monthly visits (6 months)
- Average position: Top 10 for target keywords
- Click-through rate: >5%
- Bounce rate: <40%

**User Engagement**:
- Time on page: >3 minutes
- Pages per session: >2.5
- Comment rate: >2% of visitors
- Return visitor rate: >30%

**Content Quality**:
- Page completeness: 100% (all sections filled)
- Internal link density: 5-10 per page
- Content freshness: Updated within 90 days
- User satisfaction score: >4.0/5.0

---

## 9. Next Steps

### Immediate Actions (This Week)
1. ✅ Complete this analysis document
2. [ ] Create unified detail page template (Hono component)
3. [ ] Implement 3 sample job pages with real API data
4. [ ] Implement 3 sample major pages with real API data
5. [ ] Implement 3 sample HowTo pages
6. [ ] Set up SEO monitoring (Google Search Console)

### Short-term (Next 2 Weeks)
1. [ ] Expand to 50 pages each type
2. [ ] Implement comment system (D1 database)
3. [ ] Add structured data to all pages
4. [ ] Set up sitemap generation
5. [ ] Submit to search engines

### Medium-term (Next Month)
1. [ ] Scale to 100+ pages per type
2. [ ] Implement AI content enhancement
3. [ ] Add user contribution system
4. [ ] Performance optimization
5. [ ] A/B testing for conversions

---

## 10. CareerNet + Work24 Data Fusion Blueprint

### 10.1 Source Capability Matrix

| 정보 영역 | 커리어넷 (CareerNet) | 고용24 (Work24) | 통합 전략 |
|-----------|----------------------|-----------------|------------|
| 기본 프로필 | 직업/전공 코드, 직업명, 요약(summary) | 직업/전공 코드, 직업명, 요약, 세부 분류 | 코드·명칭은 공통키로 매칭, 분류 필드는 Work24 우선 + CareerNet 보정 |
| 직무 설명/하는 일 | summary 필드에 문단 형태로 존재 (직업 기준) | jobCont (직무 상세), workDuty, workDetail 등 세부 필드 제공 | Work24 상세 설명을 기본 본문으로, CareerNet summary는 인트로/강조 문구로 보완 |
| 연봉/임금 | salery (평균 임금) | salaryAvg, salaryBegin, salaryExperienced 등 구간별 데이터 | Work24의 구간별 정보를 히어로 카드에 사용, CareerNet salery는 툴팁/출처용 |
| 전망/고용동향 | possibility, equalemployment | prospectScore, employTrend, industryOutlook | 전망 지표는 Work24 점수 기반 차트, CareerNet 텍스트는 분석 코멘트로 추가 |
| 필요 역량/적성 | aptd_type_code (코드), aptitude (텍스트), 관련 직업/전공 | capacity, ability, aptitudeCd, aptitudeNm | 역량/적성은 Work24 텍스트를 메인, CareerNet 코드/태그를 배지로 병합 |
| 준비 방법/로드맵 | wayBecome, certification, relatedMajor | prepCourse, educationPath, certificateList | Work24 준비 단계 → HowTo 섹션, CareerNet 데이터는 참고 링크/요약 |
| 근무 환경/경력 경로 | equalemployment, similarJob | workEnvironment, jobPath, careerProgress | 근무 환경은 Work24 필드, CareerNet 유사 직업은 사이드바 추천 |
| 전공 정보 | majorSeq, mClass, lClass, university | majorCd, majorNm, curriculum, careerField | 전공 기본 정보는 CareerNet, Work24 커리큘럼/취업 데이터로 상세 강화 |
| 출처 표기 | "출처: 커리어넷" | "출처: 고용24" | 섹션별 출처 배지 자동 삽입 + 마지막 개요에 통합 출처 표시 |

### 10.2 Unified Domain Models

```typescript
// 직업 상세 표준 스키마
interface JobProfile {
  id: string;             // canonical ID (e.g., "job:W_7635eb78")
  sourceIds: {
    careernet?: string;
    work24?: string;
  };
  name: string;
  category: {
    main: string;
    sub?: string;
  };
  summary: {
    intro: string;        // CareerNet summary 첫 문단
    detail: string;       // Work24 jobCont / duty
  };
  salary: {
    average?: string;
    entry?: string;
    experienced?: string;
    source: 'CAREERNET' | 'WORK24';
    updatedAt?: string;
  };
  outlook: {
    trendText?: string;   // CareerNet possibility/equalemployment
    score?: number;       // Work24 prospectScore (0-100)
    comments?: string;
  };
  skills: string[];       // Work24 capacity + CareerNet aptitude split
  preparation: {
    steps: string[];      // Work24 prepCourse → HowTo
    certifications: string[];
    education: string;
  };
  environment?: string;   // Work24 workEnvironment
  related: {
    majors: string[];     // canonical major IDs
    jobs: string[];
    howtos: string[];
  };
  sources: string[];      // e.g., ['CAREERNET', 'WORK24']
}

// 전공 상세 표준 스키마
interface MajorProfile {
  id: string;
  sourceIds: {
    careernet?: string;
    work24?: string;
  };
  name: string;
  category: string;
  summary: string;
  universities: string[]; // CareerNet university split
  curriculum: {
    overview?: string;    // Work24 curriculum
    highschoolSubjects?: string[]; // CareerNet 추천과목
    coreCourses?: string[];        // Work24 전공필수
  };
  outcomes: {
    employmentRate?: string;      // Work24 careerField stats
    salary?: string;
    careerPaths?: string[];
  };
  aptitude?: string;
  relatedJobs: string[];
  relatedCertificates: string[];
  sources: string[];
}
```

### 10.3 Merge & Precedence Rules

1. **ID 정규화**: `job:${sourcePrefix}_${originId}` 형태로 저장 (ex. `job:W_7635...`). 동일 직업을 서로 다른 소스에서 찾으면 `sourceIds`에 매핑하고 단일 `JobProfile`로 병합.
2. **텍스트 필드 결합**: Work24의 서술형 필드를 본문으로, CareerNet 텍스트는 `summary.intro` 혹은 `outlook.comments`에 누적. 중복 문장은 Levenshtein 유사도 0.9 이상 시 제거.
3. **수치 데이터 우선순위**:
   - 연봉: Work24 (entry/experienced) → CareerNet salery (fallback)
   - 취업률/전망 점수: Work24 score → CareerNet 텍스트 변환(긍정/보통/부정)
   - 취업률 미제공 시 CareerNet employmentRate로 보강
4. **리스트 필드 병합**: 관련 직업/전공/자격증은 소스별 배열을 합치고 소문자/공백 정규화 후 유일값 유지. 값마다 `source` 메타데이터 추가해 편집 시 출처 유지.
5. **출처 추적**: 각 섹션 렌더링 시 `sources` 배열 기반으로 배지 자동 노출 (`커리어넷`, `고용24`, `커뮤니티`). 커뮤니티 작성(뇌피셜)은 사용자 편집 시 별도 플래그 `source: 'COMMUNITY'` 부여.
6. **업데이트 타임스탬프**: Work24 응답의 `updDt`(있는 경우)와 CareerNet 수집 시각을 `metadata.lastSyncedAt`에 저장해 캐시 무효화 기준으로 활용.

### 10.4 Template Binding Plan

| 템플릿 섹션 | 데이터 소스 맵핑 | 렌더링 전략 |
|--------------|-------------------|--------------|
| Hero Stats (직업) | `salary`, `outlook.score`, `outlook.trendText` | Work24 수치를 카드로, CareerNet 텍스트를 `tooltip`/`note`로 보조 |
| 직업 개요 | `summary.intro`, `summary.detail` | 인트로 문단 → CareerNet, 본문 상세 → Work24, 문단 사이에 출처 표기 |
| 하는 일 | Work24 `jobCont` split → bullet, CareerNet `similarJob`는 "관련 직업" 리스트로 이동 |
| 필요 역량 | Work24 `capacity` + CareerNet `aptitude` → 배지/칩, 부족 시 AI 보충 계획 |
| 연봉/전망 | Work24 `salaryBegin/Experienced`, `prospectScore`; CareerNet `salery`, `equalemployment` → 비교표 |
| 로드맵/HowTo | Work24 `prepCourse` 단계 → HowTo 탭 자동 생성, 커뮤니티 HowTo가 있으면 우선 표시 |
| 전공 개요 | CareerNet `summary`; Work24 `curriculum`을 교과목 표로 삽입 |
| 취업 현황 | Work24 `careerField` 통계 → 그래프, CareerNet `employment` 문장 병행 |
| 관련 콘텐츠 | `related` 배열 사용 → 내부 링크 생성, 출처별 라벨 (예: "고용24 추천 전공") |
| 출처 표시 | `sources` + 섹션별 `source` 메타 | 각 카드/섹션 footer에 `출처: ...` 자동 삽입 |

### 10.5 Implementation Roadmap

1. **데이터 수집 레이어**
   - `src/api/work24API.ts` 생성: 고용24 직업/전공 목록 및 상세 fetch 함수 구현 (fetch + XML/JSON 파서).
   - `src/api/careernetAPI.ts` 보완: 현재 summary-only 처리를 세분화하고, 공통 타입을 export.
2. **정규화 파이프라인**
   - `normalizeJobFromCareerNet` / `normalizeJobFromWork24` 작성 → `JobProfile` 반환.
   - 동일 ID 매칭 로직: 직업명 한글 정규화 + Jaro-Winkler > 0.92 시 동일 직업으로 간주.
3. **병합 유틸**
   - `mergeJobProfiles(primary: JobProfile, secondary: JobProfile)` 함수에서 위 우선순위 규칙 적용.
   - 전공도 동일한 `mergeMajorProfiles` 함수 구성.
4. **템플릿 어댑터**
   - 현재 `renderJobDetail` / `renderMajorDetail` 를 `JobProfile`/`MajorProfile` 기반으로 리팩터링.
   - 소스별 배지를 템플릿 컴포넌트로 분리 (`<SourceBadge source="CAREERNET" />`).
5. **캐싱 & 버전 관리**
   - Cloudflare KV에 `job:${id}` JSON 저장, `metadata.lastSyncedAt` 비교로 TTL 관리 (직업 7일, 전공 30일).
   - 초기 일괄 수집 시 D1에 snapshot 저장 → 편집 이력과 동기화 용.
6. **편집 워크플로우 준비**
   - 로그인한 사용자가 수정 시 `source: 'COMMUNITY'`, `editorId`, `editedAt` 기록.
   - 원본 API 필드와 사용자 편집본을 diff로 저장하여 재동기화 시 충돌 관리.

---

## 11. Sample Detail Template (2025-10-07 Update)

> 이 섹션은 실제 API 연동 전에 프론트엔드 탭 레이아웃을 검증하기 위한 단일 샘플 데이터 세트를 정의합니다. 커리어넷과 고용24에서 각각 한 개만 선별하여 정규화하며, 이후 확장 시 동일한 템플릿에 주입할 수 있도록 구조를 고정합니다.

### 11.1 Job Detail Sample — 데이터 분석가 (Data Analyst)

#### Source Snapshots

##### CareerNet (careernetId: 100140)
- **요약(summary)**: 데이터 기반 의사결정을 지원하기 위해 대규모 정형·비정형 데이터를 수집·정제하고 통계/머신러닝 기법으로 인사이트를 도출한다.
- **주요 업무(duties)**: 문제 정의 → 데이터 파이프라인 점검 → 탐색적 분석 → 모델링 → 시각화 및 리포트 작성.
- **필요 역량(abilities)**: 통계적 사고, SQL 최적화, 복잡한 데이터를 스토리로 풀어내는 커뮤니케이션.
- **필수 지식(knowledge)**: 통계학, 데이터 거버넌스, 머신러닝 기초.
- **성격·가치(personality/values)**: 탐구형(RIASEC I), 진취형(E), 정확성과 팀워크를 중시.
- **추천 전공(relatedMajors)**: 통계학과, 데이터사이언스학과, 산업공학과.
- **평균 연봉(salary)**: 4,500만원 (상위 25% 6,200만원).
- **직무 만족도(satisfaction)**: 4.2 / 5.
- **커리어 전망(prospect)**: 「데이터 인력 수급전망(2024)」 기준 5년간 수요 26% 증가 예상.
- **학력 분포**: 대학 졸업 52%, 대학원 이상 24%, 전문대 18%, 고졸 6%.
- **전공 분포**: 공학 41%, 자연 23%, 사회 19%, 인문 9%, 예체능 5%, 의약 3%.

##### 고용24 (jobdicSeq: J2024-03102)
- **직무 설명(jobCont)**: 디지털·오프라인 채널 데이터를 수집·정제하여 KPI를 설계하고, 머신러닝 모델과 시각화를 통해 경영진에게 의사결정 가이드를 제공한다.
- **업무 방식(workDuty)**: 제품/마케팅 조직과 스프린트 단위로 협업하며, OKR 기반 데이터 과제를 운영한다.
- **근무 환경(workEnvironment)**: 하이브리드 근무(주 2회 오피스), 보안 승인 구역에서 데이터 접근, 슬랙·노션·Tableau 서버 사용.
- **보상 정보**: 평균 5,200만원 / 입문 3,800만원 / 경력 7,800만원.
- **전망 점수(prospectScore)**: 87 (상위 10%).
- **핵심 기술(technKnow)**: Python(pandas, scikit-learn), SQL, Tableau, Airflow.
- **핵심 활동(activitiesImportance)**: 데이터 이해 94, 문제 정의 91, 커뮤니케이션 88.
- **필요 역량(capacity)**: 통계 해석, 비즈니스 감각, 스토리텔링.
- **관련 자격증(certifications)**: ADsP, SQLD, 빅데이터분석기사.
- **커리어 경로(careerProgress)**: 주니어 분석가 → 시니어 → 데이터 사이언티스트 → 데이터 총괄(Head of Data).

#### Unified Rendering Template (Tab-first order)

| 탭 ID | 라벨 | 핵심 메시지 | 주요 데이터 소스 | CTA / Telemetry 포인트 |
| --- | --- | --- | --- | --- |
| overview | 개요 | 데이터 기반 문제 해결의 핵심 역할 소개 | CareerNet.summary 첫 문단 + Work24.jobCont 요약 | 상단 CTA(`data-cw-cta`) 클릭 → `cw-detail-action:cta-click` |
| work | 업무·환경 | 실무 루틴과 협업 형태, 근무 환경을 명확히 제시 | Work24.workDuty, workEnvironment, CareerNet.way | 탭 전환(`cw-detail-action:tab-change`) |
| skills | 역량·지식 | 필수 역량/기술 스택과 활동 지표 강조 | CareerNet.abilities/knowledge + Work24.technKnow/activitiesImportance | 섹션 내 배지 hover 추적 예정 |
| persona | 인성·가치 | 성향·가치관 정보로 적합도 자가진단 | CareerNet.personality/interests/values | 댓글 플레이스홀더(`cw-detail-action:comments-placeholder`) |
| network | 연결·기회 | 연관 전공/직업/자격증 네트워크 제공 | CareerNet.relatedMajors/relatedJobs/relatedCertificates | 공유 버튼(`data-share`) → `cw-detail-action:share` |
| insights | 데이터 | 학력/전공 분포와 KECO 코드로 시장 인사이트 제시 | CareerNet.educationDistribution/majorDistribution/kecoCodes | 후속 대시보드 연동 시 `cw-detail-action` 확장 |

#### UnifiedJobDetail sample object

```json
{
  "id": "job:data-analyst",
  "name": "데이터 분석가",
  "sourceIds": {
    "careernet": "100140",
    "goyong24": "J2024-03102"
  },
  "category": {
    "code": "02-01-04",
    "name": "데이터·AI 직무"
  },
  "sources": ["CAREERNET", "GOYONG24"],
  "summary": "데이터를 수집·정제하고 통계/머신러닝 기법을 활용해 비즈니스 인사이트를 제시하는 직무입니다.",
  "prospect": "데이터 인력 투자 확대와 규제 완화로 향후 5년간 연평균 26% 성장이 전망됩니다.",
  "salary": "평균 5,200만원 (상위 25% 6,600만원)",
  "satisfaction": "직무 만족도 4.2 / 5",
  "status": "정규직 중심 · 하이브리드 근무 비중 48%",
  "duties": "- 문제 정의 및 KPI 설정\n- 데이터 파이프라인 점검과 전처리\n- 분석 모델 구축 및 성과 리포트 작성",
  "way": "제품/마케팅 조직과 스프린트 단위 애자일 협업을 진행하며 데이터 가드레일을 유지합니다.",
  "environment": "보안 승인 구역에서 데이터 접근, Slack / Notion / Tableau 서버 사용, 주 2회 오피스 출근.",
  "abilities": "통계적 사고, SQL 최적화, 커뮤니케이션",
  "knowledge": "통계학, 머신러닝, 데이터 거버넌스",
  "technKnow": "Python (pandas, scikit-learn), SQL, Tableau, Airflow",
  "personality": "탐구형 + 진취형 (RIASEC IE)",
  "interests": "문제 해결, 지적 탐구, 협업",
  "values": "정확성, 실용성, 팀워크",
  "activitiesImportance": "데이터 이해 94, 문제 정의 91, 커뮤니케이션 88",
  "activitiesLevels": "프로그래밍 83, 통계 분석 86, 시각화 79",
  "relatedMajors": [
    { "id": "major:data-science", "name": "데이터사이언스학과" },
    { "id": "major:statistics", "name": "통계학과" }
  ],
  "relatedJobs": [
    { "id": "job:data-engineer", "name": "데이터 엔지니어" },
    { "id": "job:business-analyst", "name": "비즈니스 애널리스트" }
  ],
  "relatedCertificates": ["ADsP", "SQLD", "빅데이터분석기사"],
  "educationDistribution": {
    "university": "52%",
    "graduate": "24%",
    "college": "18%",
    "highSchool": "6%"
  },
  "majorDistribution": {
    "engineering": "41%",
    "natural": "23%",
    "social": "19%",
    "humanities": "9%",
    "artsSports": "5%",
    "medical": "3%"
  },
  "relatedOrganizations": [
    { "name": "한국데이터산업진흥원", "url": "https://www.kdata.or.kr" },
    { "name": "한국데이터마이닝학회" }
  ],
  "kecoCodes": [
    { "code": "02-01-04-01", "name": "데이터 분석가" }
  ],
  "classifications": {
    "large": "전문·과학·기술 서비스직",
    "medium": "데이터·AI 분석",
    "small": "데이터 분석가"
  }
}
```

### 11.2 Major Detail Sample — 데이터사이언스학과 (Data Science)

#### Source Snapshots

##### CareerNet (careernetId: 200512)
- **학과 요약(summary)**: 데이터 기반 문제 해결을 위해 통계·프로그래밍·AI를 복합적으로 학습하는 융합 전공.
- **적성(aptitude)**: 수리논리 사고, 탐구심, 협업 능력.
- **주요 교과(mainSubjects)**: 데이터베이스, 확률과 통계, 파이썬 프로그래밍, 머신러닝, 데이터 시각화.
- **학과에서 배우는 것(whatStudy)**: 데이터 수집·정제, 모델링, 서비스 설계, 윤리/법적 이슈.
- **준비 방법(howPrepare)**: 고교 수학Ⅰ·Ⅱ/미적분/확률과통계 이수 + 정보 과목 실습, 코딩(SW 특기자 전형) 준비.
- **관련 직업(relatedJobs)**: 데이터 분석가, 데이터 엔지니어, AI 서비스 기획자.
- **졸업 후 초봉(salaryAfterGraduation)**: 평균 3,800만원.
- **취업률(employmentRate)**: 78.5% (2023년 졸업자 기준).

##### 고용24 (majorCd: M2024-14220)
- **전공 설명(majorNm)**: 산업 전반의 디지털 전환을 지원하는 데이터 전문 교육과정.
- **커리큘럼(curriculum)**: 1학년 기초수학/통계 → 2학년 프로그래밍·데이터구조 → 3학년 머신러닝·데이터마이닝 → 4학년 프로젝트/캡스톤.
- **모집 정원(recruitmentStatus)**: 2024학년도 정원 180명, 지원 경쟁률 3.8:1, 졸업자 162명.
- **자격증(certificateList)**: ADsP, 빅데이터분석기사, SQLP, TensorFlow Developer.
- **진출 분야(careerField)**: 데이터 분석, AI 연구, 핀테크, 스마트팩토리, 공공데이터 전략.
- **산학 특징(industryLink)**: ICT 기업 산학협력랩, 캡스톤과제 KPI와 연계.

#### Unified Rendering Template (Tab-first order)

| 탭 ID | 라벨 | 핵심 메시지 | 주요 데이터 소스 | CTA / Telemetry 포인트 |
| --- | --- | --- | --- | --- |
| overview | 개요 | 학과 정체성과 학습 목표를 한눈에 제시 | CareerNet.summary + aptitude | 상단 CTA 그룹 (`data-cw-cta`) |
| curriculum | 커리큘럼 | 학년별 학습 로드맵과 핵심 과목 | CareerNet.mainSubjects, Work24.curriculum | 탭 변화 `cw-detail-action:tab-change` |
| career | 진로 · 전망 | 취업률, 초봉, 진출 직업 요약 | CareerNet.jobProspect / employmentRate / salaryAfterGraduation | 댓글 플레이스홀더 |
| universities | 개설 대학 | 개설 학교/모집 정원/경쟁률 표 | CareerNet.universities + Work24.recruitmentStatus | 향후 필터/정렬 telemetry 연결 예정 |
| network | 연결 정보 | 추천 유사 전공 및 연계 자원 | CareerNet.relatedMajors + source 배지 | 공유 버튼 이벤트 |

#### UnifiedMajorDetail sample object

```json
{
  "id": "major:data-science",
  "name": "데이터사이언스학과",
  "sourceIds": {
    "careernet": "200512",
    "goyong24": "M2024-14220"
  },
  "categoryName": "공학계열",
  "sources": ["CAREERNET", "GOYONG24"],
  "summary": "데이터 기반 문제 해결 능력을 갖춘 인재를 양성하기 위해 통계·프로그래밍·AI를 융합적으로 학습하는 학과입니다.",
  "aptitude": "수리논리 사고, 탐구심, 협업 능력",
  "mainSubjects": ["데이터베이스", "확률과 통계", "파이썬 프로그래밍", "머신러닝", "데이터 시각화"],
  "licenses": ["ADsP", "빅데이터분석기사", "SQLP"],
  "universities": [
    { "name": "서울대학교", "department": "데이터사이언스학과", "universityType": "국립대", "url": "https://ds.snu.ac.kr" },
    { "name": "한양대학교", "department": "데이터사이언스학부", "universityType": "사립대", "url": "https://ds.hanyang.ac.kr" }
  ],
  "recruitmentStatus": [
    { "year": "2024", "universityType": "국립대", "enrollmentQuota": "80명", "applicants": "3.6:1", "graduates": "74명" },
    { "year": "2024", "universityType": "사립대", "enrollmentQuota": "100명", "applicants": "4.0:1", "graduates": "88명" }
  ],
  "relatedJobs": ["데이터 분석가", "AI 엔지니어", "BI 분석가"],
  "relatedMajors": ["통계학과", "소프트웨어학과", "산업공학과"],
  "whatStudy": "데이터 수집·정제, 통계 모델링, 머신러닝, 데이터 시각화, 서비스 설계, 데이터 윤리.",
  "howPrepare": "고등학교 수학·과학 심화 이수, SW·AI 관련 비교과 참여, 포트폴리오형 프로젝트 경험.",
  "jobProspect": "디지털 전환 확산으로 공공·민간 전 산업에서 데이터 인재 수요 지속 확대.",
  "salaryAfterGraduation": "평균 초봉 3,800만원",
  "employmentRate": "취업률 78.5% (2023)"
}
```

#### Notes for Engineering

1. 위 샘플 오브젝트는 `UnifiedJobDetail` / `UnifiedMajorDetail` 타입에 맞춰 작성되었으며, 탭 렌더링 템플릿에 바로 주입할 수 있습니다.
2. 실제 API 연동 시에는 D1/캐시 계층에서 동일한 키(`job:data-analyst`, `major:data-science`)로 조회하여 병합 후 반환합니다.
3. 프론트엔드 QA 순서: (a) 탭 전환 키보드 접근성, (b) CTA telemetry (`cw-detail-action`), (c) 댓글 placeholder 이벤트 수집, (d) 샘플 데이터 기반의 UI 캡처 공유.

---

## 12. Conclusion

This design analysis provides a comprehensive roadmap for creating SEO-optimized, information-rich detail pages for CareerWiki. The key strengths of this approach:

1. **Maximizes Available API Data**: Uses all CareerNet API fields effectively
2. **SEO-First Design**: Every element optimized for search visibility
3. **Scalable Architecture**: Can easily generate hundreds of pages
4. **User-Centric**: Clear hierarchy, scannable content, mobile-friendly
5. **Future-Proof**: Modular design allows easy additions

**Critical Success Factors**:
- Consistent implementation of unified templates
- Regular content updates (monthly for jobs, quarterly for majors)
- Active community engagement (comments, edits)
- Continuous SEO monitoring and optimization

With this design, CareerWiki can become the definitive Korean resource for career and education information, ranking highly for thousands of long-tail keywords and serving hundreds of thousands of users monthly.

---

**Document Version**: 1.1  
**Author**: AI Assistant  
**Last Updated**: 2025-10-07  
**Status**: Ready for Implementation

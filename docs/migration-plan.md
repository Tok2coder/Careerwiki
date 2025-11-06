# CareerWiki 정적 위키 페이지 마이그레이션 계획

## 📋 현재 상황 분석

### 현재 아키텍처 (SSR)
```
사용자 요청 → D1 조회 → 템플릿 렌더링 → HTML 응답
- 매 요청마다 렌더링 (CPU 사용)
- 사용자 기여 데이터 병합 복잡
- 확장성 제한
```

### 목표 아키텍처 (정적 위키)
```
사용자 요청 → D1에서 완성된 HTML 조회 → 즉시 응답
- 초고속 응답 (0.1초 이내)
- 사용자 기여 데이터 섹션별 병합
- 무한 확장 가능
```

---

## 🚀 마이그레이션 3단계 계획

## Phase 1: 데이터 완전성 검증 및 병합 (1-2일)

### Task 1.1: API 데이터 완전성 검증
**목표**: 커리어넷과 고용24 API의 모든 필드가 D1에 저장되었는지 확인

#### 1.1.1 커리어넷 학과정보 API 검증
- [ ] API 문서 분석: https://www.career.go.kr/cnet/front/openapi/openApiMajorCenter.do
- [ ] 현재 수집 필드 vs 전체 필드 비교
- [ ] 누락된 필드 식별
- [ ] `seedAllMajors.ts` 수정

**체크리스트:**
```typescript
// 커리어넷 학과정보 전체 필드
{
  majorSeq: string           // ✅
  major: string              // ✅
  categoryName: string       // ✅
  summary: string            // ✅
  aptitude: string           // ✅
  
  // ⚠️ 확인 필요
  courseList: string[]       // 전공 교과목
  certificate: string[]      // 관련 자격증
  department: string         // 학과 분류
  highschoolCourse: string   // 고교 선택과목
  university: Array<{        // 대학 정보
    schoolName: string
    department: string
    universityType: string
    url: string
  }>
  relatedMajor: string[]     // 관련 학과
  relatedJob: string[]       // 관련 직업
  // ... 더 있을 수 있음
}
```

#### 1.1.2 커리어넷 직업백과 API 검증
- [ ] API 문서 분석: https://www.career.go.kr/cnet/front/openapi/jobCenter.do
- [ ] 현재 수집 필드 vs 전체 필드 비교
- [ ] 누락된 필드 식별
- [ ] `seedAllJobs.ts` 수정

#### 1.1.3 고용24 API 검증
- [ ] 업로드된 API 문서 분석
- [ ] 현재 수집 필드 vs 전체 필드 비교
- [ ] 누락된 필드 식별
- [ ] 시딩 스크립트 수정

**산출물:**
- `docs/api-field-comparison.md` (필드 비교표)
- 수정된 시딩 스크립트
- 완전한 데이터를 포함한 D1 데이터베이스

---

### Task 1.2: 데이터 병합 로직 구현
**목표**: 커리어넷과 고용24의 중복 데이터 병합

#### 중복 감지 전략
```typescript
// 전공 병합 예시
{
  // 커리어넷: "컴퓨터공학과" (ID: 569)
  // 고용24: "컴퓨터공학과" (ID: G8_컴퓨터공학과)
  
  // 병합 규칙:
  // 1. 이름 정확 매칭 (대소문자 무시)
  // 2. 유사도 90% 이상 매칭 (예: "컴퓨터공학" vs "컴퓨터공학과")
  // 3. 수동 매핑 테이블 (불일치 항목)
}
```

**구현 단계:**
1. [ ] 전공 이름 기반 자동 매칭 로직
2. [ ] 직업 이름 기반 자동 매칭 로직
3. [ ] 유사도 알고리즘 적용 (Levenshtein distance)
4. [ ] 수동 매핑 테이블 생성
5. [ ] 병합 결과 검증 스크립트

**산출물:**
- `src/services/dataMergeService.ts` (병합 로직)
- `data/manual-mappings.json` (수동 매핑)
- `docs/merge-report.md` (병합 결과 리포트)

---

## Phase 2: 정적 위키 페이지 생성 시스템 구축 (2-3일)

### Task 2.1: D1 스키마 마이그레이션
- [ ] `migrations/0003_wiki_pages.sql` 생성
- [ ] 기존 `majors`, `jobs` 테이블과의 호환성 유지
- [ ] 로컬 D1 마이그레이션 실행
- [ ] 프로덕션 D1 마이그레이션 계획

**새 테이블:**
- `wiki_pages` - 완성된 HTML 페이지 저장
- `api_data_cache` - API 원본 데이터 캐시
- `user_contributions` - 사용자 기여 데이터
- `ai_generated_content` - AI 생성 콘텐츠
- `page_revisions` - 버전 이력
- `page_update_queue` - 업데이트 큐

---

### Task 2.2: 정적 페이지 생성기 구현

#### 2.2.1 페이지 빌더 서비스
```typescript
// src/services/pageBuilderService.ts

export class PageBuilder {
  // 완전한 HTML 페이지 생성
  async buildWikiPage(slug: string, type: 'job' | 'major'): Promise<string> {
    // 1. API 데이터 조회
    const apiData = await this.getApiData(slug)
    
    // 2. 사용자 기여 데이터 조회
    const userContributions = await this.getUserContributions(slug)
    
    // 3. AI 생성 콘텐츠 조회
    const aiContent = await this.getAiContent(slug)
    
    // 4. 섹션별 렌더링
    const sections = {
      overview: this.renderOverview(apiData),
      universities: this.renderUniversities(apiData),
      reviews: this.renderReviews(userContributions),
      careerPath: this.renderCareerPath(aiContent),
      // ...
    }
    
    // 5. 최종 HTML 조립
    return this.assembleFullPage(sections)
  }
  
  // 특정 섹션만 재생성
  async rebuildSection(slug: string, sectionName: string): Promise<string> {
    // ...
  }
}
```

#### 2.2.2 초기 페이지 생성 스크립트
```bash
# 모든 전공/직업 페이지 일괄 생성
npm run build:wiki-pages

# 특정 페이지만 생성
npm run build:wiki-page -- --slug=컴퓨터공학과 --type=major
```

**구현 단계:**
1. [ ] `PageBuilder` 클래스 구현
2. [ ] 섹션별 렌더링 함수 작성
3. [ ] 초기 생성 스크립트 작성
4. [ ] 1,435개 전공 페이지 생성
5. [ ] 587개 직업 페이지 생성

**산출물:**
- `src/services/pageBuilderService.ts`
- `src/scripts/buildAllWikiPages.ts`
- D1 `wiki_pages` 테이블에 2,022개 페이지 저장

---

### Task 2.3: 라우팅 시스템 변경

#### 현재 (SSR)
```typescript
app.get('/major/:slug', async (c) => {
  const result = await getUnifiedMajorDetail(...)
  const html = renderUnifiedMajorDetail(result)
  return c.html(html)
})
```

#### 변경 후 (정적 위키)
```typescript
app.get('/major/:slug', async (c) => {
  const slug = c.req.param('slug')
  
  // D1에서 완성된 HTML 조회
  const page = await c.env.DB
    .prepare('SELECT content FROM wiki_pages WHERE slug = ? AND status = ?')
    .bind(slug, 'published')
    .first()
  
  if (!page) {
    return c.notFound()
  }
  
  // view_count 증가 (비동기)
  c.executionCtx.waitUntil(
    c.env.DB.prepare('UPDATE wiki_pages SET view_count = view_count + 1 WHERE slug = ?')
      .bind(slug).run()
  )
  
  return c.html(page.content)
})
```

**구현 단계:**
1. [ ] `/major/:slug` 라우트 변경
2. [ ] `/job/:slug` 라우트 변경
3. [ ] Fallback 로직 추가 (페이지 없을 시 SSR)
4. [ ] 성능 테스트

**예상 성능:**
- 현재 SSR: ~500ms
- 변경 후: ~50ms (10배 향상)

---

## Phase 3: 증분 업데이트 시스템 구축 (2-3일)

### Task 3.1: API 데이터 동기화

#### 3.1.1 변경 감지 시스템
```typescript
// src/services/apiSyncService.ts

export class ApiSyncService {
  // API 데이터 변경 감지
  async detectChanges(): Promise<ChangeSet[]> {
    const changes: ChangeSet[] = []
    
    // 1. 커리어넷 API 폴링
    for (const major of await getAllMajors()) {
      const newData = await fetchCareerNetMajorDetail(major.id)
      const oldHash = await getStoredDataHash(major.id)
      const newHash = await generateDataHash(newData)
      
      if (oldHash !== newHash) {
        changes.push({
          slug: major.slug,
          type: 'api_sync',
          sections: ['overview', 'universities', 'jobs']
        })
      }
    }
    
    return changes
  }
  
  // 변경된 페이지 업데이트 큐에 추가
  async queueUpdates(changes: ChangeSet[]): Promise<void> {
    for (const change of changes) {
      await db.prepare(`
        INSERT INTO page_update_queue (page_slug, update_type, sections_to_update, priority)
        VALUES (?, ?, ?, ?)
      `).bind(change.slug, change.type, JSON.stringify(change.sections), 5).run()
    }
  }
}
```

#### 3.1.2 스케줄러 (Cloudflare Cron)
```typescript
// src/index.tsx

export default {
  async scheduled(event: ScheduledEvent, env: Env, ctx: ExecutionContext) {
    if (event.cron === '0 2 * * *') {  // 매일 오전 2시
      const syncService = new ApiSyncService(env)
      const changes = await syncService.detectChanges()
      await syncService.queueUpdates(changes)
    }
  }
}
```

**구현 단계:**
1. [ ] `ApiSyncService` 구현
2. [ ] Cloudflare Cron 설정
3. [ ] 변경 감지 로직 테스트
4. [ ] 모니터링 대시보드

---

### Task 3.2: 사용자 기여 시스템

#### 3.2.1 기여 API 엔드포인트
```typescript
// POST /api/contributions
app.post('/api/contributions', async (c) => {
  const { pageSlug, sectionName, contributionType, content } = await c.req.json()
  
  // 1. 사용자 인증 (향후 구현)
  // const userId = await authenticate(c)
  
  // 2. 기여 저장
  const contribution = await db.prepare(`
    INSERT INTO user_contributions 
    (page_slug, section_name, contribution_type, content, status, created_at, updated_at)
    VALUES (?, ?, ?, ?, 'pending', ?, ?)
  `).bind(pageSlug, sectionName, contributionType, content, Date.now(), Date.now()).run()
  
  // 3. 자동 승인 (초기에는) 또는 관리자 검토 대기
  if (autoApprove) {
    await queuePageUpdate(pageSlug, [sectionName])
  }
  
  return c.json({ success: true, id: contribution.meta.last_row_id })
})

// GET /api/contributions/:pageSlug
app.get('/api/contributions/:pageSlug', async (c) => {
  const slug = c.req.param('pageSlug')
  
  const contributions = await db.prepare(`
    SELECT * FROM user_contributions
    WHERE page_slug = ? AND status = 'approved'
    ORDER BY created_at DESC
  `).bind(slug).all()
  
  return c.json(contributions.results)
})
```

#### 3.2.2 프론트엔드 기여 UI
```html
<!-- 페이지 하단에 기여 섹션 추가 -->
<div class="contribution-section">
  <h3>이 페이지에 기여하기</h3>
  
  <button onclick="openContributionModal('review')">
    졸업생 후기 작성
  </button>
  
  <button onclick="openContributionModal('tip')">
    학습 팁 추가
  </button>
  
  <button onclick="openContributionModal('correction')">
    정보 수정 제안
  </button>
</div>
```

**구현 단계:**
1. [ ] 기여 API 엔드포인트
2. [ ] 프론트엔드 기여 폼
3. [ ] 관리자 검토 대시보드
4. [ ] 자동 승인 규칙

---

### Task 3.3: 업데이트 워커 (백그라운드 처리)

```typescript
// src/workers/pageUpdateWorker.ts

export class PageUpdateWorker {
  async processQueue(): Promise<void> {
    // 1. 대기 중인 업데이트 조회
    const pendingUpdates = await db.prepare(`
      SELECT * FROM page_update_queue
      WHERE status = 'pending'
      ORDER BY priority ASC, created_at ASC
      LIMIT 10
    `).all()
    
    // 2. 각 업데이트 처리
    for (const update of pendingUpdates.results) {
      try {
        // 상태를 'processing'으로 변경
        await markAsProcessing(update.id)
        
        // 해당 섹션만 재생성
        const pageBuilder = new PageBuilder()
        for (const section of JSON.parse(update.sections_to_update)) {
          const newSectionHtml = await pageBuilder.rebuildSection(
            update.page_slug,
            section
          )
          
          // 페이지 콘텐츠 업데이트
          await updatePageSection(update.page_slug, section, newSectionHtml)
        }
        
        // 버전 증가 & 타임스탬프 업데이트
        await incrementPageVersion(update.page_slug)
        
        // 완료 처리
        await markAsCompleted(update.id)
        
      } catch (error) {
        await markAsFailed(update.id, error.message)
      }
    }
  }
}

// Cloudflare Cron으로 매 분마다 실행
export default {
  async scheduled(event: ScheduledEvent, env: Env, ctx: ExecutionContext) {
    if (event.cron === '* * * * *') {  // 매 분
      const worker = new PageUpdateWorker(env)
      await worker.processQueue()
    }
  }
}
```

**구현 단계:**
1. [ ] `PageUpdateWorker` 구현
2. [ ] 큐 처리 로직
3. [ ] 오류 처리 & 재시도
4. [ ] 모니터링 & 알림

---

## 📊 예상 효과

### 성능 개선
| 지표 | 현재 (SSR) | 변경 후 (정적) | 개선율 |
|------|-----------|--------------|--------|
| 평균 응답 시간 | 500ms | 50ms | 10배 ↑ |
| 서버 CPU 사용률 | 80% | 10% | 8배 ↓ |
| 동시 처리 가능 | 100 req/s | 1,000 req/s | 10배 ↑ |

### 확장성
- ✅ 사용자 기여 데이터 무한 추가 가능
- ✅ AI 생성 콘텐츠 섹션별 관리
- ✅ 버전 이력 완전 추적
- ✅ 무한 확장 가능한 아키텍처

### 운영 편의성
- ✅ API 업데이트 자동 감지 & 반영
- ✅ 사용자 기여 관리자 검토 시스템
- ✅ 섹션별 독립적 업데이트
- ✅ 롤백 가능한 버전 관리

---

## 🚦 다음 단계 결정 필요

정우님, 이 계획에 대해:

1. **전체적인 방향성**이 맞나요?
2. **우선순위**를 변경하고 싶은 부분이 있나요?
3. **Phase 1부터 시작**할까요, 아니면 **프로토타입 먼저** 만들어볼까요?
4. 특별히 **강조하고 싶은 기능**이 있나요?

제 제안:
- **Option A (안전)**: Phase 1 → Phase 2 → Phase 3 순차적 진행
- **Option B (빠름)**: 소규모 프로토타입 먼저 (10개 페이지만) → 검증 → 전체 적용
- **Option C (하이브리드)**: Phase 1 완료 → Phase 2 프로토타입 → 검증 → Phase 2/3 완료

어떤 방식이 좋을까요?

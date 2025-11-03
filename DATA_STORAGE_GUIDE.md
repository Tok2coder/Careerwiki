# 직업 데이터 영구 저장 가이드

## 📋 개요

Careerwiki는 **3가지 독립적인 데이터 레이어**를 사용합니다:

```
┌─────────────────────────────────────┐
│       최종 사용자에게 표시           │
│  (API + User + Admin 데이터 병합)   │
└─────────────────────────────────────┘
         ↑          ↑          ↑
         │          │          │
┌────────┴──┐  ┌───┴────┐  ┌──┴──────┐
│ API 데이터 │  │ 유저    │  │ 운영진   │
│ (자동)    │  │ 기여    │  │ 데이터   │
│           │  │ (수동)  │  │ (수동)   │
└───────────┘  └────────┘  └─────────┘
```

### 데이터 우선순위
```
운영진 데이터 > 유저 기여 데이터 > API 데이터
```

---

## 🎯 핵심 특징

### ✅ API 데이터 자동 업데이트
- **주기**: 2주일에 1번 (매월 1일, 15일 새벽 2시)
- **방법**: 해시 비교로 변경 감지
- **보존**: 기존 데이터 유지 (새 데이터 없어도 삭제 안됨)

### ✅ 사용자 데이터 완전 보호
- API 업데이트 시 **절대 손실 안됨**
- 독립적인 JSON 컬럼에 저장
- 우선순위가 API보다 높음

### ✅ 템플릿 독립성
- 템플릿 수정 = 모든 페이지 즉시 반영
- 데이터와 표현(템플릿)의 완전한 분리

---

## 🗄️ 데이터베이스 구조

### `jobs` 테이블
```sql
CREATE TABLE jobs (
    id TEXT PRIMARY KEY,
    
    -- API 데이터 (자동 업데이트)
    api_data_json TEXT,           -- 커리어넷 + 고용24 통합
    api_data_hash TEXT,            -- SHA-256 해시
    api_last_fetched_at INTEGER,
    api_last_updated_at INTEGER,
    
    -- 사용자 기여 데이터 (보호됨)
    user_contributed_json TEXT,
    user_last_updated_at INTEGER,
    
    -- 운영진 데이터 (최우선)
    admin_data_json TEXT,
    admin_last_updated_at INTEGER,
    
    created_at INTEGER NOT NULL,
    is_active INTEGER DEFAULT 1
);
```

### `update_logs` 테이블
```sql
CREATE TABLE update_logs (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    job_id TEXT,
    update_type TEXT,      -- 'api', 'user', 'admin'
    changed_fields TEXT,    -- JSON array
    updated_at INTEGER,
    updated_by TEXT         -- 'cron', 'user:123', 'admin:456'
);
```

---

## 🚀 설정 가이드

### 1️⃣ D1 데이터베이스 생성

```bash
cd /home/user/webapp

# D1 데이터베이스 생성
npx wrangler d1 create careerwiki-jobs

# 출력된 database_id를 복사하여 wrangler.jsonc에 추가
```

### 2️⃣ wrangler.jsonc 설정

```jsonc
{
  "d1_databases": [{
    "binding": "DB",
    "database_name": "careerwiki-jobs",
    "database_id": "복사한-database-id"
  }],
  "triggers": {
    "crons": ["0 2 1,15 * *"]  // 매월 1일, 15일 오전 2시
  }
}
```

### 3️⃣ 마이그레이션 실행

```bash
# 로컬 개발
npx wrangler d1 migrations apply careerwiki-jobs --local

# 프로덕션
npx wrangler d1 migrations apply careerwiki-jobs
```

### 4️⃣ index.tsx에 scheduled 핸들러 추가

```typescript
import { syncJobsWithAPI } from './services/jobSyncCron'

export default {
  fetch: app.fetch,
  
  // Cron 핸들러 (2주일에 1번 실행)
  async scheduled(event: ScheduledEvent, env: Env, ctx: ExecutionContext) {
    console.log('⏰ Cron triggered:', event.cron)
    
    // API 동기화 실행
    const result = await syncJobsWithAPI(env)
    
    console.log('📊 Sync result:', result)
  }
}
```

---

## 🔄 데이터 흐름

### 사용자 요청 처리

```typescript
app.get('/job/:slug', async (c) => {
  const jobId = resolveIdFromSlug(slug)
  
  // 1. D1에서 데이터 조회 (API + User + Admin 병합)
  let jobData = await getStoredJob(c.env.DB, jobId)
  
  if (!jobData) {
    // 2. 없으면 API 호출 후 저장
    const result = await getUnifiedJobDetailWithRawData(...)
    await updateApiData(c.env.DB, jobId, result.profile)
    jobData = result.profile
  }
  
  // 3. 템플릿으로 렌더링
  return c.html(renderJobDetailPage(jobData))
})
```

### Cron 자동 업데이트 (2주일마다)

```
매월 1일, 15일 새벽 2시:
1. 모든 활성 직업 ID 조회
2. 각 직업마다:
   - API 호출
   - 해시 비교
   - 변경 있으면: DB 업데이트 + 로그
   - 변경 없으면: last_fetched_at만 갱신
3. 결과 요약 로그
```

---

## 🛡️ 데이터 보호 메커니즘

### 1. API 업데이트 시 사용자 데이터 보존

```typescript
// updateApiData()는 api_data_json만 업데이트
// user_contributed_json과 admin_data_json은 절대 건드리지 않음

await db.prepare(`
  UPDATE jobs SET
    api_data_json = ?,      -- ✅ 업데이트
    api_data_hash = ?,      -- ✅ 업데이트
    -- user_contributed_json은 그대로 유지
    -- admin_data_json은 그대로 유지
  WHERE id = ?
`).bind(...).run()
```

### 2. 데이터 병합 우선순위

```typescript
// getStoredJob()에서 데이터 병합
const finalData = {
  ...apiData,        // 기본 API 데이터
  ...userData,       // 유저 기여 덮어쓰기
  ...adminData       // 운영진 데이터가 최우선
}
```

### 3. 새 데이터 없어도 기존 데이터 유지

```typescript
if (!result.profile) {
  // API 응답 없음 -> 기존 DB 데이터 그대로 유지
  console.log('⚠️ No API data, keeping existing')
  continue
}
```

---

## 📊 모니터링 및 관리

### 최근 업데이트 확인

```typescript
const updates = await getRecentUpdates(env.DB, 50)

// 출력 예시:
// [
//   {
//     jobId: 'lawyer',
//     jobName: '변호사',
//     changedFields: ['salary', 'duties'],
//     updatedAt: '2025-01-15T02:00:00Z',
//     updatedBy: 'cron'
//   }
// ]
```

### 특정 직업 강제 업데이트

```typescript
// 관리자 도구로 특정 직업만 즉시 업데이트
const result = await forceUpdateJob(env, 'lawyer')
console.log('Updated fields:', result.changedFields)
```

### D1 콘솔로 직접 확인

```bash
# 로컬
npx wrangler d1 execute careerwiki-jobs --local --command="
  SELECT id, name, api_last_updated_at 
  FROM jobs 
  ORDER BY api_last_updated_at DESC 
  LIMIT 10
"

# 프로덕션
npx wrangler d1 execute careerwiki-jobs --command="
  SELECT * FROM update_logs 
  ORDER BY updated_at DESC 
  LIMIT 20
"
```

---

## 🎨 템플릿 업데이트

템플릿 수정 시 **모든 직업 페이지에 즉시 반영**:

```typescript
// src/templates/unifiedJobDetail.ts 수정
export const renderJobDetailPage = (profile: UnifiedJobDetail) => {
  return `
    <h1>${profile.name}</h1>
    <!-- 여기를 수정하면 모든 직업 페이지에 즉시 적용 -->
  `
}
```

데이터는 DB에 저장되고, 템플릿은 런타임에 적용되므로 **완전히 독립적**입니다.

---

## ⚡ 성능 최적화

### Cloudflare Cache + D1

```
사용자 요청
  ↓
Cloudflare Cache (1시간)
  ↓ (캐시 미스)
D1 Database (영구)
  ↓ (DB 미스)
API 호출 + D1 저장
```

**응답 시간**:
- Cache Hit: 10-20ms
- D1 Hit: 50-100ms
- API Call: 2-3초

---

## 🔧 트러블슈팅

### D1 데이터베이스가 비어있을 때

```bash
# 기존 직업 데이터 초기 로드
# (API에서 가져와서 D1에 저장하는 스크립트 필요)
```

### Cron이 실행 안될 때

```bash
# Cron 로그 확인
npx wrangler tail --format json | grep scheduled

# 수동 실행 (테스트용)
curl -X POST https://your-domain.com/api/admin/sync-jobs \
  -H "Authorization: Bearer admin-token"
```

### 사용자 데이터가 덮어써질까 걱정될 때

**걱정 마세요!** 코드 설계상 불가능합니다:
- API 업데이트는 `api_data_json` 컬럼만 수정
- `user_contributed_json`과 `admin_data_json`은 별도 함수로만 수정 가능
- 데이터 병합 시 항상 사용자 데이터가 우선

---

## 📝 체크리스트

### 초기 설정
- [ ] D1 데이터베이스 생성
- [ ] wrangler.jsonc 설정
- [ ] 마이그레이션 실행
- [ ] scheduled 핸들러 추가
- [ ] 배포 및 테스트

### 운영
- [ ] 2주마다 Cron 로그 확인
- [ ] 업데이트 로그 모니터링
- [ ] 사용자 기여 데이터 검토
- [ ] 템플릿 업데이트 시 테스트

---

## 📚 추가 리소스

- [Cloudflare D1 문서](https://developers.cloudflare.com/d1/)
- [Cloudflare Cron Triggers](https://developers.cloudflare.com/workers/configuration/cron-triggers/)
- [Hono Framework 문서](https://hono.dev/)

---

**구현 완료 시 예상 효과**:
- ✅ 응답 속도 20-60배 향상
- ✅ API 비용 99% 절감
- ✅ 사용자 데이터 100% 보호
- ✅ 완벽한 변경 추적
- ✅ 오프라인 작동 가능

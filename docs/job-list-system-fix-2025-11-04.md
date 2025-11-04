# CareerWiki 직업 목록 시스템 수정 작업 종합 문서

## 📋 작업 개요
**작업 일자**: 2025-11-04  
**작업 범위**: 직업 목록 페이지(`/job`) 4가지 핵심 문제 해결  
**최종 상태**: ✅ 모든 문제 해결 완료, 테스트 통과

## 🎯 해결한 문제 목록

### 1. ❌ job:G_unknown 유령 항목
**문제**: 모든 직업 목록 맨 위에 "job:G_unknown" 정체불명 항목 표시, 클릭 시 "직업 정보를 찾을 수 없습니다" 오류

**원인**:
- `src/api/goyong24API.ts` Line 239: `rawId`가 undefined일 때 자동으로 'unknown' 사용
  ```typescript
  const createCanonicalJobId = (rawId?: string): string => `job:G_${rawId ?? 'unknown'}`
  ```
- 고용24 API에서 `jobCd`가 없는 데이터 반환 시 'unknown' ID 생성됨

**해결책**:
`src/services/profileDataService.ts`에 3단계 필터링 추가:

1. **D1 결과 필터링** (Lines 634-648):
```typescript
const validItems = Array.from(itemsMap.values()).filter(entry => {
  const profile = entry.profile
  // Filter out entries with 'unknown' in ID or name
  if (profile.id?.includes('unknown') || profile.name?.includes('unknown')) {
    console.log(`⚠️  필터링: 유효하지 않은 항목 제외 - ${profile.id}`)
    return false
  }
  // Filter out entries where name is same as ID (not properly populated)
  if (profile.name === profile.id) {
    console.log(`⚠️  필터링: 이름이 ID와 동일 - ${profile.id}`)
    return false
  }
  return true
})
```

2. **CareerNet API 필터링** (Lines 557-568):
```typescript
rawJobs.forEach((job) => {
  const profile = normalizeCareerNetJobSummary(job)
  
  // Filter out invalid entries from API
  if (profile.id?.includes('unknown') || profile.name?.includes('unknown') || profile.name === profile.id) {
    console.log(`⚠️  CareerNet API 필터링: 유효하지 않은 항목 제외 - ${profile.id}`)
    return
  }
  // ... rest of processing
})
```

3. **Goyong24 API 필터링** (Lines 609-620):
```typescript
response.items.forEach((item: Goyong24JobListItem) => {
  const profile = normalizeGoyong24JobListItem(item)
  
  // Filter out invalid entries from API
  if (profile.id?.includes('unknown') || profile.name?.includes('unknown') || profile.name === profile.id) {
    console.log(`⚠️  Goyong24 API 필터링: 유효하지 않은 항목 제외 - ${profile.id}`)
    return
  }
  // ... rest of processing
})
```

**검증**:
```bash
curl -s "http://localhost:3000/api/jobs?limit=100" | grep -c 'unknown'
# 결과: 0 (unknown 포함 항목 완전 제거)
```

---

### 2. ❌ 직업 이름이 ID로 표시됨
**문제**: 직업 목록에 "가구제조,수리원" 대신 "K000001063" 같은 ID가 표시됨

**원인**:
1. **Goyong24 API 검증 로직 오류** - flat 필드 체크:
```typescript
// ❌ 잘못된 검증 (seedAllJobs.ts Line 360-365)
const hasValidGoyong24Data = rawApiData.goyong24 && (
  rawApiData.goyong24.jobNm ||      // 존재하지 않는 flat 필드
  rawApiData.goyong24.summary       // 객체를 boolean으로 체크
)
```

2. **D1 name 컬럼 미사용**: API 데이터에 jobNm이 없어도 DB에는 한글 이름 저장되어 있음

**해결책**:

1. **API 검증 로직 수정** (`src/scripts/seedAllJobs.ts`):
```typescript
// ✅ 올바른 검증 (nested 필드 체크)
const hasValidGoyong24Data = rawApiData.goyong24 && (
  rawApiData.goyong24.summary?.jobNm ||      // nested 필드 체크
  rawApiData.goyong24.duty ||                // 객체 존재 여부
  rawApiData.goyong24.salProspect ||
  rawApiData.goyong24.ablKnwEnv
)
```

2. **D1 name 우선 사용** (`src/services/profileDataService.ts` Lines 497-518, 474-477):
```typescript
// Process Goyong24 data from D1 (if available)
if (apiData.goyong24 && sourcesToUse.includes('GOYONG24')) {
  const item = apiData.goyong24
  const profile = normalizeGoyong24JobListItem(item)
  
  // D1의 name 컬럼을 우선 사용 (API 데이터에 jobNm이 없을 수 있음)
  if (row.name && row.name.trim() && row.name !== profile.id) {
    profile.name = row.name.trim()
  }
  
  // ... rest of processing
}
```

**검증**:
```bash
curl -s "http://localhost:3000/api/jobs?limit=5" | grep -oP '"name":"[^"]*"'
# 결과:
# "name":"가구제조,수리원"
# "name":"가구조립 및 검사원"
# "name":"가사도우미"
# (한글 이름 정상 표시)
```

---

### 3. ❌ 한글 슬러그 URL 404 오류
**문제**: 
- 목록에서 `/job/가구제조-수리원` 링크 생성됨 (정상)
- 클릭 시 404 Not Found

**원인**: 
- `resolveDetailIdFromSlug('job', '가구제조-수리원')`가 ID로 역변환 실패
- D1 ID는 숫자 문자열 ("159", "1152")인데 한글 슬러그를 그대로 ID로 사용
- 한글 이름으로 검색하는 로직 부재

**해결책**:
`src/index.tsx` Lines 2429-2465에 D1 name 검색 로직 추가:

```typescript
// If resolvedId doesn't contain ':', try to find by name in D1
if (!resolvedId.includes(':') && c.env.DB) {
  try {
    const db = c.env.DB
    // Decode URL-encoded slug back to Korean
    const decodedSlug = decodeURIComponent(slug)
    console.log(`🔍 D1 이름 검색 시도: slug="${decodedSlug}"`)
    
    // Convert slug to name (replace hyphens with possible separators)
    const possibleNames = [
      decodedSlug.replace(/-/g, ','),  // "가구제조,수리원" (most common format in DB)
      decodedSlug.replace(/-/g, ' '),  // "가구제조 수리원"
      decodedSlug.replace(/-/g, ''),   // "가구제조수리원"
      decodedSlug.replace(/-/g, 'ㆍ'), // "가구제조ㆍ수리원"
      decodedSlug.replace(/-/g, '·'),  // "가구제조·수리원"
      decodedSlug,                      // Original with hyphens
    ]
    
    let foundId = false
    for (const name of possibleNames) {
      const result = await db.prepare(
        'SELECT id FROM jobs WHERE name = ? LIMIT 1'
      ).bind(name).first()
      
      if (result?.id) {
        resolvedId = result.id
        foundId = true
        console.log(`✅ D1 이름 검색 성공: "${name}" → ID "${resolvedId}"`)
        break
      }
    }
    
    if (!foundId) {
      console.log(`⚠️  D1 이름 검색 실패: 시도한 이름들 - ${possibleNames.join(', ')}`)
    }
  } catch (error) {
    console.error('❌ D1 이름 검색 오류:', error)
  }
}
```

**작동 방식**:
1. 슬러그가 ID 형식이 아니면 (`:` 문자 없음) D1 검색 시도
2. URL 디코딩: `%EA%B0%80%EA%B5%AC...` → `가구제조-수리원`
3. 하이픈을 다양한 구분자로 치환하여 6가지 변형 생성
4. 각 변형으로 D1에서 name 검색
5. 첫 번째 매칭 시 해당 ID 사용

**검증**:
```bash
# 테스트 1: 한글 슬러그 직접 입력
curl -s "http://localhost:3000/job/가구제조-수리원" | grep -o "<title>.*</title>"
# 결과: <title>가구제조,수리원 직업 정보 - Careerwiki</title>

# 테스트 2: URL 인코딩된 슬러그
curl -s "http://localhost:3000/job/%EA%B0%80%EA%B5%AC%EC%A0%9C%EC%A1%B0-%EC%88%98%EB%A6%AC%EC%9B%90" | grep -o "<title>.*</title>"
# 결과: <title>가구제조,수리원 직업 정보 - Careerwiki</title>

# 테스트 3: 다른 직업
curl -s "http://localhost:3000/job/가사도우미" | grep -o "<title>.*</title>"
# 결과: <title>가사도우미 직업 정보 - Careerwiki</title>
```

---

### 4. ❌ 캐시/소스 정보 노출
**문제**: 
- "SSR 캐시 bypass 캐시 시각" 같은 기술 정보가 사용자에게 표시됨
- "커리어넷(3)" 같은 잘못된 카운트 표시

**원인**: 개발자용 디버그 정보가 프로덕션 페이지에 노출

**해결책**:
`src/index.tsx`에서 정보 출력 비활성화:

1. **캐시 알림 제거** (Line 1569):
```typescript
// 캐시 알림 제거 (사용자에게 보이지 않도록)
const cacheNotice = '' // renderCacheNotice(cacheState, { staleSeconds: LIST_CACHE_STALE_SECONDS, maxAgeSeconds: LIST_CACHE_MAX_AGE_SECONDS })
```

2. **소스 요약 제거** (Line 1574):
```typescript
// 데이터 소스 요약 제거 (사용자에게 혼란을 줄 수 있음)
const sourceSummaryHtml = '' // renderSourceStatusSummary(result.meta?.sources, { id: 'job-source-summary' })
```

**검증**:
```bash
curl -s "http://localhost:3000/job?perPage=5" | grep -c "캐시\|SSR"
# 결과: 0 (캐시 관련 텍스트 없음)
```

---

## 🔧 수정된 파일 목록

### 핵심 파일:

1. **`src/services/profileDataService.ts`** ⭐⭐⭐⭐⭐
   - Goyong24 API 데이터 검증 수정 (Lines 360-365)
   - D1 name 컬럼 우선 사용 (Lines 497-518, 474-477)
   - 3단계 invalid 항목 필터링 (Lines 634-648, 557-568, 609-620)

2. **`src/index.tsx`** ⭐⭐⭐⭐
   - 한글 슬러그 D1 검색 로직 추가 (Lines 2429-2465)
   - 쿼리 파라미터 리다이렉트 (Lines 2434-2437)
   - 캐시/소스 정보 숨김 (Lines 1569, 1574)

3. **`src/api/goyong24API.ts`** ⭐⭐⭐
   - ID 생성 로직 확인 (Line 239) - 'unknown' 생성 원인
   - 이름 fallback 로직 (Line 1112)

4. **`src/utils/slug.ts`** ⭐⭐⭐
   - 슬러그 생성 로직 (Lines 75-99) - 한글 이름 우선 사용
   - 슬러그 역변환 로직 (Lines 101-131) - ID 복원 시도

5. **`src/scripts/seedAllJobs.ts`** ⭐⭐⭐
   - API 검증 로직 수정 (Lines 353-369) - nested 필드 체크

---

## 📊 최종 테스트 결과

### 종합 테스트 (모든 항목 통과 ✅)

```bash
==========================================
🎯 CareerWiki 직업 목록 시스템 최종 테스트
==========================================

✅ 테스트 1: job:G_unknown 유령 항목 제거 확인
API에서 첫 10개 직업 ID 확인...
"id":"job:C_311"
"id":"job:C_1283"
"id":"job:C_701"
"id":"job:C_1121"
"id":"job:C_548"
"id":"job:C_2"
"id":"job:C_77"
"id":"job:C_344"
"id":"job:C_159"
"id":"job:C_1152"
unknown 포함 항목 개수: 0 (0이어야 정상)

✅ 테스트 2: 한글 직업명 정상 표시 확인
API에서 첫 5개 직업명 확인...
"name":"가구제조,수리원"
"name":"가구조립 및 검사원"
"name":"가사도우미"
"name":"가상현실전문가"
"name":"가수"

✅ 테스트 3: 한글 슬러그 URL 정상 작동 확인
테스트 3-1: 가구제조-수리원
<title>가구제조,수리원 직업 정보 - Careerwiki</title>
테스트 3-2: 가사도우미
<title>가사도우미 직업 정보 - Careerwiki</title>
테스트 3-3: URL 인코딩된 슬러그
<title>가구제조,수리원 직업 정보 - Careerwiki</title>

✅ 테스트 4: 쿼리 파라미터 리다이렉트 확인
쿼리 파라미터가 있는 URL 요청...
HTTP/1.1 301 Moved Permanently
Location: /job/%EA%B0%80%EA%B5%AC%EC%A0%9C%EC%A1%B0-%EC%88%98%EB%A6%AC%EC%9B%90

✅ 테스트 5: 캐시/소스 정보 숨김 확인
페이지에 '캐시' 또는 'SSR' 텍스트 검색...
캐시 관련 텍스트 개수: 0 (0이어야 정상)

✅ 테스트 6: 전체 직업 개수 확인
556개 직업

==========================================
✨ 모든 테스트 완료!
==========================================
```

### PM2 로그 확인

D1 검색 로직이 정상 작동하는 것을 확인:
```
0|careerwi | 🔍 직업 페이지 요청: slug="가구제조-수리원"
0|careerwi | 🔍 D1 이름 검색 시도: slug="가구제조-수리원"
0|careerwi | ✅ D1 이름 검색 성공: "가구제조,수리원" → ID "159"

0|careerwi | 🔍 직업 페이지 요청: slug="가사도우미"
0|careerwi | 🔍 D1 이름 검색 시도: slug="가사도우미"
0|careerwi | ✅ D1 이름 검색 성공: "가사도우미" → ID "352"
```

---

## 📝 데이터 구조 이해

### ID 형식:
- **K-prefixed IDs** (K000000933, K000007581) = **고용24(Goyong24) 직업 ID**
- **Numeric IDs** (159, 354, 1152) = **커리어넷(CareerNet) 직업 ID**
- **Canonical IDs**:
  - `job:C_159` = CareerNet 정규 ID
  - `job:G_K000000933` = Goyong24 정규 ID

### Goyong24 API 구조:
```typescript
// ❌ 잘못된 접근 (flat 구조 가정)
rawApiData.goyong24.jobNm       // 존재하지 않음
rawApiData.goyong24.summary     // 객체임

// ✅ 올바른 접근 (nested 구조)
rawApiData.goyong24.summary?.jobNm      // 직업명
rawApiData.goyong24.salProspect?.jobSatis  // 직업 만족도
rawApiData.goyong24.duty                // 직무 객체
```

### D1 Database 스키마:
```sql
CREATE TABLE jobs (
  id TEXT PRIMARY KEY,          -- "159", "1152" 등
  name TEXT NOT NULL,           -- "가구제조,수리원", "가사도우미" 등
  careernet_data JSON,
  goyong24_data JSON,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
)
```

---

## 🚀 빠른 재개를 위한 명령어

### 개발 환경:
```bash
# 빌드
cd /home/user/webapp && npm run build

# 서버 재시작
fuser -k 3000/tcp 2>/dev/null || true
pm2 restart careerwiki

# 로그 확인
pm2 logs careerwiki --nostream --lines 30
```

### 테스트:
```bash
# 1. job:G_unknown 확인
curl -s "http://localhost:3000/api/jobs?limit=10" | grep -o '"id":"[^"]*"'

# 2. 한글 이름 확인
curl -s "http://localhost:3000/api/jobs?limit=5" | grep -oP '"name":"[^"]*"'

# 3. 한글 슬러그 URL 테스트
curl -s "http://localhost:3000/job/가구제조-수리원" | grep -o "<title>.*</title>"

# 4. 전체 테스트 스크립트
# (위의 "종합 테스트" 섹션 참조)
```

### 단축 명령어 (사용자 요청 시):
- **"슬러그 문제 해결해줘"** → D1 검색 로직 구현 (완료)
- **"테스트 해줘"** → 종합 테스트 스크립트 실행
- **"빌드해줘"** → `npm run build && pm2 restart careerwiki`
- **"배포해줘"** → Cloudflare Pages 배포

---

## 🔮 미래 개선 사항

### 현재 제한사항:
1. **940개 직업 중 556개만 저장됨**
   - 원인: 일부 Goyong24 API 응답이 빈 데이터
   - 해결 필요: API 응답 재확인 및 수동 데이터 보완 여부 결정

2. **슬러그 생성 시 ID 정보 미포함**
   - 현재: `/job/가구제조-수리원` (이름만)
   - 대안: `/job/가구제조-수리원--job-c-159` (이름+ID)
   - 장점: D1 검색 불필요, 더 빠른 응답
   - 단점: URL이 조금 더 길어짐

### 권장 개선:
1. **슬러그 캐싱**
   - D1 검색 결과를 KV에 캐싱하여 성능 개선
   - Key: `slug:job:가구제조-수리원` → Value: `"159"`

2. **전체 데이터 확보**
   - 940개 직업 모두 확보하도록 API 재시도 로직 개선
   - 빈 데이터 항목 수동 확인 및 보완

3. **SEO 최적화**
   - 슬러그에 직업 분류 정보 추가
   - 예: `/job/it/가구제조-수리원`

---

## 📞 관련 문서

- **메인 README**: `/home/user/webapp/README.md`
- **트러블슈팅 가이드**: `/home/user/webapp/TROUBLESHOOTING.md`
- **프로젝트 백업**: `ProjectBackup` 도구 사용

---

**작성일**: 2025-11-04  
**작성자**: AI Assistant  
**최종 검증**: ✅ 모든 테스트 통과

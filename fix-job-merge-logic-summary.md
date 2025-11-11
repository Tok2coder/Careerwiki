# 직업 데이터 병합 로직 수정 계획

**작성일**: 2025-11-06  
**문제**: 같은 이름의 직업이 2개 레코드로 분리되어 있는데, 현재는 하나만 조회됨

---

## 🔍 현재 문제

### 데이터 구조
- "기업고위임원" → 2개 레코드
  - 레코드 1 (ID: 238): careernet_id=238, goyong24_id=NULL, careernet 데이터만
  - 레코드 2 (ID: K000000847): careernet_id=NULL, goyong24_id=K000000847, goyong24 데이터만

### 현재 코드 동작
```typescript
// src/services/profileDataService.ts - getUnifiedJobDetailWithRawData()

// Strategy 3: Try by name
if (!jobRow && id && !id.includes(':')) {
  jobRow = await db.prepare(`
    SELECT id, name, careernet_id, goyong24_id, api_data_json 
    FROM jobs 
    WHERE name = ?
    LIMIT 1  // ❌ 문제: 하나만 가져옴!
  `).bind(id).first()
}
```

**결과:**
- 같은 이름으로 검색하면 2개 중 첫 번째 레코드만 조회
- 병합이 안 됨

---

## ✅ 해결 방안

### 수정 계획

**위치:** `src/services/profileDataService.ts` - `getUnifiedJobDetailWithRawData()` 함수

**변경 내용:**

```typescript
// 🆕 Strategy 3-2: 이름으로 모든 레코드 조회하여 병합
if (!jobRow && id && !id.includes(':')) {
  const allJobRows = await db.prepare(`
    SELECT id, name, careernet_id, goyong24_id, api_data_json 
    FROM jobs 
    WHERE name = ?
  `).bind(id).all()  // ✅ all()로 모든 레코드 가져오기
  
  console.log(`🔍 D1 name 검색: name="${id}", found=${allJobRows.results?.length || 0}개`)
  
  if (allJobRows.results && allJobRows.results.length > 0) {
    // 여러 레코드가 있으면 병합
    for (const row of allJobRows.results) {
      if (row.api_data_json) {
        try {
          const apiData = JSON.parse(row.api_data_json)
          
          // careernet 데이터 수집
          if (apiData.careernet && sourcesToUse.includes('CAREERNET')) {
            rawCareernetData = apiData.careernet
            careernetProfile = normalizeCareerNetJobDetail(apiData.careernet)
            sourcesStatus.CAREERNET.attempted = true
            sourcesStatus.CAREERNET.count = 1
          }
          
          // goyong24 데이터 수집
          if (apiData.goyong24 && sourcesToUse.includes('GOYONG24')) {
            rawGoyong24Data = apiData.goyong24
            goyongProfile = normalizeGoyong24JobDetail(apiData.goyong24)
            sourcesStatus.GOYONG24.attempted = true
            sourcesStatus.GOYONG24.count = 1
          }
        } catch (e) {
          console.error('JSON 파싱 오류:', e)
        }
      }
    }
    
    // 병합 처리 (기존 로직)
    if (careernetProfile || goyongProfile) {
      const merged = mergeJobProfiles(goyongProfile ?? undefined, careernetProfile ?? undefined)
      const partialsRecord: Partial<Record<DataSource, UnifiedJobDetail | null>> = {
        CAREERNET: careernetProfile,
        GOYONG24: goyongProfile
      }
      const enhancedProfile = applyJobDetailOverrides(merged, partialsRecord)
      
      // 첫 번째 레코드의 이름 사용
      if (allJobRows.results[0].name && allJobRows.results[0].name.trim()) {
        enhancedProfile.name = allJobRows.results[0].name.trim()
      }
      
      return {
        profile: enhancedProfile,
        partials: partialsRecord,
        sources: sourcesStatus,
        rawApiData: {
          careernet: rawCareernetData,
          goyong24: rawGoyong24Data
        }
      }
    }
  }
}
```

---

## 📝 수정 범위

### 파일 수정
1. `src/services/profileDataService.ts`
   - `getUnifiedJobDetailWithRawData()` 함수 수정
   - Strategy 3 (이름 검색) 로직 개선

### 테스트
1. `/job/기업고위임원` 페이지 확인
2. `/job/238` (커리어넷 ID) 확인
3. `/job/K000000847` (고용24 ID) 확인
4. 병합 데이터 표시 확인

---

## 🎯 기대 효과

### Before (현재)
- "기업고위임원" 검색 → 1개 레코드만 조회
- 커리어넷 또는 고용24 데이터 중 하나만 표시

### After (수정 후)
- "기업고위임원" 검색 → 2개 레코드 모두 조회
- 커리어넷 + 고용24 데이터 병합
- 풍부한 정보 제공

### 영향 범위
- 136개 매칭 직업에 모두 적용
- 나머지 844개는 영향 없음 (단일 소스만 있음)

---

## ✅ 다음 단계

1. `src/services/profileDataService.ts` 수정 (15분)
2. 로컬 테스트 (10분)
3. 병합 데이터 확인 (5분)

**예상 소요 시간**: 30분

---

**작성일**: 2025-11-06


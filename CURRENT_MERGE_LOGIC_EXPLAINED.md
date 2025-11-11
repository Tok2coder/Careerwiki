# 현재 직업 데이터 병합 로직 설명

**위치**: `src/services/profileMerge.ts` - `mergeJobProfiles()` 함수

---

## 📋 현재 병합 규칙

### 기본 원칙
```typescript
export const mergeJobProfiles = (
  goyong?: UnifiedJobDetail,      // 고용24 (첫 번째 파라미터)
  careernet?: UnifiedJobDetail    // 커리어넷 (두 번째 파라미터)
): UnifiedJobDetail | null
```

**우선순위 표기법:**
- `goyong?.field ?? careernet?.field` → **고용24 우선**
- `careernet?.field ?? goyong?.field` → **커리어넷 우선**
- `merge(goyong, careernet)` → **병합 (중복 제거)**

---

## 🎯 필드별 병합 규칙

### 1. 기본 정보
| 필드 | 병합 방식 | 우선순위 | 코드 |
|------|-----------|---------|------|
| **id** | 우선 선택 | 고용24 | `goyong?.id ?? careernet!.id` |
| **name** | 우선 선택 | **커리어넷** | `careernet?.name ?? goyong?.name` |
| **category** | 우선 선택 | 고용24 | `goyong?.category?.code ?? careernet?.category?.code` |
| **classifications** | 우선 선택 | 고용24 | `goyong?.classifications?.large ?? careernet?.classifications?.large` |

### 2. 설명 텍스트
| 필드 | 병합 방식 | 설명 |
|------|-----------|------|
| **summary** | **병합 (개행)** | `mergeRichText(careernet?.summary, goyong?.summary)` |
| **duties** | 우선 선택 | **고용24 우선**: `goyong?.duties ?? careernet?.duties` |
| **way** | 우선 선택 | **고용24 우선**: `goyong?.way ?? careernet?.way` |

### 3. 관련 정보 (배열)
| 필드 | 병합 방식 | 설명 |
|------|-----------|------|
| **relatedMajors** | **병합 (중복 제거)** | `mergeRelatedEntities(goyong, careernet)` |
| **relatedCertificates** | **병합 (중복 제거)** | `mergeCertificates(goyong, careernet)` |
| **relatedJobs** | **병합 (중복 제거)** | `mergeRelatedEntities(goyong, careernet)` |
| **relatedOrganizations** | **병합 (중복 제거)** | `mergeOrganizations(goyong, careernet)` |

### 4. 통계 데이터
| 필드 | 병합 방식 | 우선순위 |
|------|-----------|---------|
| **salary** | 우선 선택 | **고용24** |
| **satisfaction** | 우선 선택 | **고용24** |
| **prospect** | 우선 선택 | **고용24** |
| **status** | 우선 선택 | **고용24** |

### 5. 특성 데이터
| 필드 | 병합 방식 | 우선순위 |
|------|-----------|---------|
| **abilities** | 우선 선택 | **고용24** |
| **knowledge** | 우선 선택 | **고용24** |
| **environment** | 우선 선택 | **고용24** |
| **personality** | 우선 선택 | **고용24** |
| **interests** | 우선 선택 | **고용24** |
| **values** | 우선 선택 | **고용24** |
| **activitiesImportance** | 우선 선택 | **고용24** |
| **activitiesLevels** | 우선 선택 | **고용24** |
| **technKnow** | 우선 선택 | **고용24** |

### 6. 분포 데이터
| 필드 | 병합 방식 | 우선순위 |
|------|-----------|---------|
| **educationDistribution** | 병합 | **고용24 우선** |
| **majorDistribution** | 병합 | **고용24 우선** |

---

## 📝 실제 코드

```typescript
export const mergeJobProfiles = (
  goyong?: UnifiedJobDetail,
  careernet?: UnifiedJobDetail
): UnifiedJobDetail | null => {
  if (!goyong && !careernet) {
    return null
  }

  const base = goyong ?? careernet!
  const merged: UnifiedJobDetail = {
    ...base,
    
    // 기본 정보
    id: goyong?.id ?? careernet!.id,
    sourceIds: mergeSourceIds(goyong?.sourceIds, careernet?.sourceIds),
    sources: mergeSources(goyong?.sources, careernet?.sources),
    name: careernet?.name ?? goyong?.name ?? base.name,  // ⚠️ 커리어넷 우선!
    
    category: {
      code: goyong?.category?.code ?? careernet?.category?.code,      // 고용24 우선
      name: goyong?.category?.name ?? careernet?.category?.name       // 고용24 우선
    },
    
    classifications: {
      large: goyong?.classifications?.large ?? careernet?.classifications?.large,    // 고용24 우선
      medium: goyong?.classifications?.medium ?? careernet?.classifications?.medium, // 고용24 우선
      small: goyong?.classifications?.small ?? careernet?.classifications?.small     // 고용24 우선
    },
    
    // 설명 텍스트
    summary: mergeRichText(careernet?.summary, goyong?.summary),  // 병합 (커리어넷 먼저)
    duties: goyong?.duties ?? careernet?.duties,                  // 고용24 우선
    way: goyong?.way ?? careernet?.way,                          // 고용24 우선
    
    // 관련 정보 (배열 - 중복 제거)
    relatedMajors: mergeRelatedEntities(goyong?.relatedMajors, careernet?.relatedMajors),
    relatedCertificates: mergeCertificates(goyong?.relatedCertificates, careernet?.relatedCertificates),
    relatedJobs: mergeRelatedEntities(goyong?.relatedJobs, careernet?.relatedJobs),
    relatedOrganizations: mergeOrganizations(goyong?.relatedOrganizations, careernet?.relatedOrganizations),
    
    // 통계 데이터 - 고용24 우선
    salary: goyong?.salary ?? careernet?.salary,
    satisfaction: goyong?.satisfaction ?? careernet?.satisfaction,
    prospect: goyong?.prospect ?? careernet?.prospect,
    status: goyong?.status ?? careernet?.status,
    
    // 특성 데이터 - 고용24 우선
    abilities: goyong?.abilities ?? careernet?.abilities,
    knowledge: goyong?.knowledge ?? careernet?.knowledge,
    environment: goyong?.environment ?? careernet?.environment,
    personality: goyong?.personality ?? careernet?.personality,
    interests: goyong?.interests ?? careernet?.interests,
    values: goyong?.values ?? careernet?.values,
    activitiesImportance: goyong?.activitiesImportance ?? careernet?.activitiesImportance,
    activitiesLevels: goyong?.activitiesLevels ?? careernet?.activitiesLevels,
    technKnow: goyong?.technKnow ?? careernet?.technKnow,
    
    // 분포 데이터
    educationDistribution: mergeDistribution<EducationDistribution>(
      goyong?.educationDistribution,
      careernet?.educationDistribution
    ),
    majorDistribution: mergeDistribution<MajorDistribution>(
      goyong?.majorDistribution,
      careernet?.majorDistribution
    ),
    
    kecoCodes: mergeKecoCodes(goyong?.kecoCodes, careernet?.kecoCodes)
  }

  return merged
}
```

---

## 🎯 요약

### 고용24 우선 필드 (대부분)
- **통계**: salary, satisfaction, prospect, status
- **특성**: abilities, knowledge, environment, personality, interests, values
- **직무**: duties, way
- **분류**: category, classifications
- **기술**: technKnow, activitiesImportance, activitiesLevels

### 커리어넷 우선 필드 (1개만!)
- **name** (직업명) ← **이것만 커리어넷 우선**

### 병합 필드
- **summary** (요약) - 커리어넷 + 고용24 개행 병합
- **relatedMajors** (관련 학과) - 중복 제거 병합
- **relatedCertificates** (자격증) - 중복 제거 병합
- **relatedJobs** (관련 직업) - 중복 제거 병합

---

## 💡 결론

**현재 로직은 이미 거의 모든 필드에서 고용24를 우선시합니다!**

유일한 예외:
- **name** (직업명): 커리어넷 우선

이유: 커리어넷이 표준 직업명을 사용하기 때문

---

**수정이 필요한 부분이 있으신가요?**


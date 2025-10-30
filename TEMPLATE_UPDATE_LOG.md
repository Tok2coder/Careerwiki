# 템플릿 업데이트 작업 로그

## 📅 작업 일자: 2025-10-30

---

## 🎯 전체 작업 계획

### **Phase 1: 직업 상세페이지 템플릿** ✅ 진행 중
- **파일**: `src/templates/unifiedJobDetail.ts`
- **상태**: 80% 완료
- **완료 항목**:
  1. ✅ 법조 직업 매트릭스 섹션 제거
  2. ✅ 하는 일 - 주요 업무 포맷 수정 (불릿포인트 + 내용만)
  3. ✅ 커리어 전망 - 가독성 개선 (줄바꿈/들여쓰기)
  4. ✅ 핵심 능력 - 필수 지식 데이터 정리
  5. ✅ 임금 정보 - 파싱 로직 수정 (하위/평균/상위 25%)
  6. ✅ 한국표준직업분류 코드 섹션 제거
  7. ✅ 나머지 정보 상세 정보 탭에 추가

### **Phase 2: 전공 상세페이지 템플릿** ⏳ 예정
- **파일**: `src/templates/unifiedMajorDetail.ts`
- **상태**: 대기 중

### **Phase 3: HowTo 템플릿** ⏳ 예정
- **파일**: `src/templates/howtoDetail.ts`
- **상태**: 대기 중

---

## 📊 Phase 1 상세 작업 내역

### 1. 데이터 병합 시스템 구축

#### **파일**: `src/services/jobDataMerger.ts` (신규 생성)
- **위치**: `/home/user/webapp/src/services/jobDataMerger.ts`
- **크기**: ~300 lines
- **기능**: Type A/B/C/D 병합 규칙 구현

**병합 규칙**:
```typescript
// Type A: 동일 데이터 → 병합 (중복 제거)
- jobName: 직업명 (중복 제거)
- classification: 직업 분류 (대/중/소)

// Type B: 유사 데이터 → 우선순위 선택
- salary: salProspect > summary > encyclopedia
- satisfaction: salProspect > summary > encyclopedia
- prospect: salProspect > summary > encyclopedia

// Type C: 보완 데이터 → 계층적 활용
- work: { simple, summary, detailed }
- abilities: { simple, summary, detailedComparison }
- knowledge: { simple, summary, detailedComparison }
- education: { simple, summary, detailedDistribution }
- major: { simple, summary, detailedDistribution }

// Type D: 독립 데이터 → 각자 유지
- careernetOnly: { wlb, social, researchList, tagList, jobReadyList, licenseAdv, videos }
- goyong24Only: { prospectDetail, educationDistribution, majorDistribution, personality, interest, values, activity, workEnvironment, entryStatistics }
```

---

### 2. 템플릿 수정 사항

#### **파일**: `src/templates/unifiedJobDetail.ts`
- **위치**: `/home/user/webapp/src/templates/unifiedJobDetail.ts`
- **총 라인**: ~1,700 lines

#### **주요 수정 위치**:

**A. 법조 직업 매트릭스 제거** (Line 1632-1638)
```typescript
// Before
const lawyerMatrixSection = lawyerMatrix ? `...` : ''

// After
const lawyerMatrixSection = ''  // 제거됨
```

**B. 하는 일 섹션** (Line 1344-1367)
```typescript
// work 필드만 추출
const workList = workSimple
  .map((item: any) => {
    const text = typeof item === 'string' ? item : item.work || item.list_content || ''
    return text.trim() ? `<li>${escapeHtml(text)}</li>` : ''
  })
  .filter(Boolean)
  .join('')
```

**C. 커리어 전망** (Line 1369-1395)
```typescript
// 줄바꿈 블록 처리 + 들여쓰기
const prospectBlocks = prospectPrimary.map((item: any) => {
  const text = typeof item === 'string' ? item : item.list_content || ''
  if (!text.trim()) return ''
  return `<div class="mb-3"><span class="inline-block w-4"></span>${escapeHtml(text)}</div>`
})
```

**D. 필수 지식** (Line 1450-1477)
```typescript
// inform 필드 우선 + 중요도 표시
const displayText = item.inform || item.knowledge || item.list_content
if (importance) {
  return `<li>${escapeHtml(displayText)} <span class="text-wiki-muted text-xs">(중요도 ${importance})</span></li>`
}
```

**E. 임금 정보 파싱** (Line 587-647)
```typescript
// 고용24 형식 전용 파서
const goyong24Pattern = /하위\(25%\)\s*([\d,]+)만원.*?평균\(50%\)\s*([\d,]+)만원.*?상위\(25%\)\s*([\d,]+)만원/
const goyong24Match = raw.match(goyong24Pattern)

if (goyong24Match) {
  dataset = [
    { label: '하위 25%', value: lower },
    { label: '평균 50%', value: median },
    { label: '상위 25%', value: upper }
  ]
}
```

**F. 한국표준직업분류 제거** (Line 1609-1613)
```typescript
// 주석 처리됨
// const kecoList = renderKecoCodeList(profile)
// if (kecoList) {
//   pushDetailCard('한국표준직업분류 코드', 'fa-layer-group', kecoList)
// }
```

**G. 상세 정보 탭 추가 섹션** (Line 1599-1644)
```typescript
// 새로운 섹션들:
- 업무 상세 (work.detailed)
- 워라밸 & 사회적 평가 (wlb, social)
- 진로 준비방법 (jobReadyList)
- 근무환경 상세 (workEnvironment)
```

---

### 3. 라우터 수정

#### **파일**: `src/index.tsx`
- **위치**: `/home/user/webapp/src/index.tsx`

**수정 사항** (Line 2067-2077):
```typescript
// Before: debug 모드일 때만 rawApiData 가져오기
const result = debugMode 
  ? await getUnifiedJobDetailWithRawData(...)
  : await getUnifiedJobDetail(...)

// After: 항상 rawApiData 가져오기 (병합 위해 필요)
const result = await getUnifiedJobDetailWithRawData(...)
```

**rawApiData 전달** (Line 2143-2147):
```typescript
const content = renderUnifiedJobDetail({
  profile,
  partials: result.partials,
  sources: result.sources,
  rawApiData: result.rawApiData  // 추가됨
})
```

---

## 🌐 API 데이터 소스

### **커리어넷 API** (창고 A)
- **엔드포인트**: 1개
- **제공 데이터**:
  - 직업 기본정보 (job_nm, wage, satisfication)
  - 하는 일 (workList)
  - 능력/지식 (abilityList, knowledgeList)
  - 전망 (forecastList)
  - 워라밸/사회적 기여도 (wlb, social)
  - 준비방법 (jobReadyList)

### **고용24 API** (창고 B)
- **엔드포인트**: 7개 (D01-D07 병렬 호출)
  - D01: Summary (요약정보)
  - D02: Salary Prospect (임금전망)
  - D03: Duty (직무정보)
  - D04: Ability/Knowledge/Environment (능력/지식/환경)
  - D05: Educational Path (교육경로)
  - D06: Work Conditions (근무여건)
  - D07: Prospect (전망정보)

---

## 🔄 데이터 흐름도

```
1. 사용자 요청: /job/lawyer
   ↓
2. 라우터 (index.tsx)
   ↓
3. API 호출 (profileDataService.ts)
   ├─→ 커리어넷 API (1개 엔드포인트)
   └─→ 고용24 API (7개 엔드포인트 병렬)
   ↓
4. 데이터 병합 (jobDataMerger.ts)
   - Type A/B/C/D 규칙 적용
   ↓
5. 템플릿 렌더링 (unifiedJobDetail.ts)
   - HTML 생성
   ↓
6. 브라우저에 표시
```

---

## 📝 테스트 결과

### **테스트 URL**:
```
# 변호사 페이지 (실제 API)
https://3000-iy8xtwcphw6exxjb1hgnf-6532622b.e2b.dev/job/lawyer?careernetId=375&goyongJobId=K000007482

# 변호사 페이지 (샘플)
https://3000-iy8xtwcphw6exxjb1hgnf-6532622b.e2b.dev/job/lawyer

# 디버그 페이지
https://3000-iy8xtwcphw6exxjb1hgnf-6532622b.e2b.dev/job/job:C_375
```

### **확인된 수정 사항**:
- ✅ 주요 업무: 불릿 포인트로 깔끔하게 표시
- ✅ 커리어 전망: 줄바꿈 + 들여쓰기로 가독성 향상
- ✅ 필수 지식: inform 필드 + 중요도 표시
- ✅ 임금 정보: "하위 25%, 평균 50%, 상위 25%" 정확히 표시
- ✅ 법조 매트릭스: 제거됨
- ✅ 한국표준직업분류: 제거됨
- ✅ 상세 정보 탭: 4개 새 섹션 추가 (업무 상세, 워라밸, 진로 준비, 근무환경)

### **에러 상태**:
- ✅ 빌드 에러: 없음
- ✅ 런타임 에러: 없음
- ✅ 로그: 깨끗

---

## 🎯 남은 작업 (직업 상세페이지)

### **우선순위 1: 추가 섹션 완성**
- [ ] 성격/흥미/가치관 섹션 (personality, interest, values)
- [ ] 업무활동 분석 섹션 (activity.importance, activity.level)
- [ ] 능력/지식 상세 비교 섹션 (detailedComparison)

### **우선순위 2: 데이터 검증**
- [ ] 모든 필드 매핑 확인
- [ ] Edge case 처리 (빈 값, null, 배열 등)
- [ ] 다양한 직업으로 테스트 (의사, 간호사, 개발자 등)

### **우선순위 3: UX 개선**
- [ ] 로딩 상태 표시
- [ ] 데이터 없을 때 폴백 메시지
- [ ] 섹션 접기/펼치기 기능
- [ ] 모바일 반응형 최적화

---

## 📦 다음 단계: Phase 2 & 3

### **Phase 2: 전공 상세페이지**
- **파일**: `src/templates/unifiedMajorDetail.ts`
- **작업 예상 시간**: 4-6시간
- **주요 작업**:
  - 커리어넷 전공 API 연동
  - 고용24 전공 API 연동 (있는 경우)
  - 병합 로직 구현
  - 템플릿 수정

### **Phase 3: HowTo 템플릿**
- **파일**: `src/templates/howtoDetail.ts`
- **작업 예상 시간**: 2-4시간
- **주요 작업**:
  - 현재 구조 파악
  - 필요한 수정 사항 확인
  - 템플릿 정리

---

## 🚀 배포 전 체크리스트

### **코드 품질**
- [x] TypeScript 컴파일 에러 없음
- [x] 빌드 성공
- [x] PM2 정상 실행
- [ ] 전체 직업 페이지 샘플 테스트 (10개 이상)

### **성능**
- [ ] API 호출 최적화 (캐싱)
- [ ] 페이지 로딩 속도 측정
- [ ] 메모리 사용량 확인

### **SEO & 접근성**
- [ ] 메타 태그 확인
- [ ] 구조화된 데이터 (JSON-LD)
- [ ] 시맨틱 HTML
- [ ] 대체 텍스트 (alt)

---

## 📚 참고 문서

### **주요 파일 경로**
```
/home/user/webapp/
├── src/
│   ├── index.tsx                          # 라우터
│   ├── services/
│   │   ├── profileDataService.ts          # API 호출
│   │   └── jobDataMerger.ts               # 데이터 병합 ⭐ NEW
│   ├── templates/
│   │   ├── unifiedJobDetail.ts            # 직업 템플릿 ⭐ 수정됨
│   │   ├── unifiedMajorDetail.ts          # 전공 템플릿
│   │   └── howtoDetail.ts                 # HowTo 템플릿
│   ├── api/
│   │   ├── careernetAPI.ts                # 커리어넷 API
│   │   └── goyong24API.ts                 # 고용24 API (7 endpoints)
│   └── types/
│       └── unifiedProfiles.ts             # 타입 정의
├── package.json
└── wrangler.jsonc
```

### **Git 커밋 메시지 템플릿**
```bash
# 작업 완료 후
git add .
git commit -m "feat(template): 직업 상세페이지 템플릿 업데이트

- 데이터 병합 시스템 구축 (jobDataMerger.ts)
- 하는 일 섹션 불릿 포인트 포맷 수정
- 커리어 전망 가독성 개선 (들여쓰기)
- 필수 지식 데이터 정리 (중요도 표시)
- 임금 정보 파싱 로직 수정 (하위/평균/상위 25%)
- 법조 매트릭스 섹션 제거
- 한국표준직업분류 코드 제거
- 상세 정보 탭 4개 섹션 추가

Closes #1"

git push origin main
```

---

## 💡 중요 노트

### **템플릿 수정 시 주의사항**
1. **항상 빌드 후 테스트**: `npm run build && pm2 restart careerwiki`
2. **다양한 직업으로 테스트**: 변호사만이 아닌 여러 직업 확인
3. **Edge case 처리**: null, undefined, 빈 배열 등
4. **타입 체크**: typeof로 타입 확인 후 처리
5. **에러 핸들링**: try-catch 또는 옵셔널 체이닝 사용

### **성능 최적화 팁**
1. API 호출은 병렬로 (Promise.all)
2. 불필요한 데이터 전송 최소화
3. 캐싱 전략 고려 (특히 static 데이터)
4. 이미지 lazy loading
5. 코드 스플리팅

---

## 📞 연락처 & 리소스

### **API 문서**
- 커리어넷 API: https://www.career.go.kr/cnet/front/openapi/openApiTestView.do
- 고용24 API: https://www.work.go.kr/openApi/service/rest/job

### **프로젝트 정보**
- **프로젝트명**: Careerwiki
- **코드명**: webapp
- **경로**: /home/user/webapp/
- **Git 브랜치**: main
- **배포 환경**: Cloudflare Pages

---

## 🔖 버전 히스토리

### **v0.3.0 (2025-10-30)** - 현재
- ✅ 데이터 병합 시스템 구축
- ✅ 직업 상세페이지 템플릿 7개 항목 수정
- ✅ 상세 정보 탭 4개 섹션 추가

### **v0.2.0 (이전)**
- 커리어넷 + 고용24 API 통합
- 7개 고용24 엔드포인트 추가 (D01-D07)
- 디버그 페이지 구현

### **v0.1.0 (초기)**
- 프로젝트 초기 설정
- Hono + Cloudflare Pages 구조

---

**마지막 업데이트**: 2025-10-30
**작성자**: Claude (AI Assistant)
**검토자**: 정우 (Product Owner)

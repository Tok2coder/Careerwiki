# 개요 탭 병합 규칙 (제안)

> **작성일**: 2025-11-24  
> **현재 상태**: 템플릿 커스터마이징 대기 중

---

## 📋 개요 탭 섹션 구조

### 2.1.1. 주요 업무 (이전: "하는 일")
**Rule Type**: 3 (커스텀 규칙)

**필드**:
1. `careernet.summary` (직업 소개)
2. `goyong24.job.duty.execJob` (수행 직무)
3. `goyong24.djob.doWork` (직무 개요)
4. `goyong24.djob.optionJobInfo.workStrong` (작업강도)
5. `goyong24.djob.optionJobInfo.workPlace` (작업장소)
6. `goyong24.djob.optionJobInfo.physicalAct` (육체활동)

**커스텀 규칙**:
- 1, 2, 3번: 우선순위에 따라 **하나만 선택**
- 4번: 있으면 **무조건 표시**, 소제목 "작업강도"
- 5번: 있으면 **무조건 표시**, 소제목 "작업장소"
- 6번: 있으면 **무조건 표시**, 소제목 "육체활동"

**템플릿 구현 예시**:
```typescript
const introBlocks = []

// 주요 업무 설명 (우선순위)
const workDesc = selectBestValue(
  profile.summary,
  profile.duties,
  profile.doWork
)
if (workDesc) {
  introBlocks.push(formatRichText(workDesc))
}

// 작업강도 (무조건)
if (profile.workStrong) {
  introBlocks.push(`<h4 class="subsection-title">작업강도</h4>${formatRichText(profile.workStrong)}`)
}

// 작업장소 (무조건)
if (profile.workPlace) {
  introBlocks.push(`<h4 class="subsection-title">작업장소</h4>${formatRichText(profile.workPlace)}`)
}

// 육체활동 (무조건)
if (profile.physicalAct) {
  introBlocks.push(`<h4 class="subsection-title">육체활동</h4>${formatRichText(profile.physicalAct)}`)
}

pushOverviewCard('주요 업무', 'fa-rocket', introBlocks.join(''))
```

---

### 2.1.2. 커리어 전망
**Rule Type**: 1 (우선순위)

**필드**:
1. `careernet.encyclopedia.forecastList` ⭐ 1순위
2. `goyong24.job.salProspect.jobProspect` 
3. `goyong24.job.summary.jobProspect`
4. `goyong24.job.salProspect.jobSumProspect` (전망 요약 차트)

**주의**: 고용24 직업정보 사용 시 전망 요약도 함께 표시

**템플릿 구현 예시**:
```typescript
const prospectText = selectBestValue(
  profile.prospect_careernet,
  profile.prospect_job,
  profile.prospect_summary
)

let prospectHtml = prospectText ? formatRichText(prospectText) : ''

// 고용24 전망 요약 차트 추가
if (profile.jobSumProspect) {
  prospectHtml += renderProspectChart(profile.jobSumProspect)
}

if (prospectHtml) {
  pushOverviewCard('커리어 전망', 'fa-chart-line', prospectHtml)
}
```

---

### 2.1.3. 한국의 직업지표
**Rule Type**: 1 (우선순위)

**필드**:
1. `careernet.encyclopedia.indicatorChart` (7개 지표)

**현재 상태**: ✅ 이미 구현됨

**지표 항목**:
- 융합성
- 대인관계
- 창의성
- 일·가정 균형
- 소득수준
- 고용유지
- 사회공헌

---

### 2.1.4. 핵심 능력·자격
**Rule Type**: 3 (커스텀 규칙)

**필드**:
1. `careernet.encyclopedia.abilityList` (핵심 역량)
2. `careernet.encyclopedia.jobReadyList.curriculum` (정규교육과정)
3. `goyong24.job.path.technKnow` (필수 기술 및 지식)
4. `goyong24.djob.optionJobInfo.eduLevel` (교육수준)
5. `goyong24.djob.optionJobInfo.skillYear` (숙련기간)

**커스텀 규칙**:
- 1번: 있으면 **무조건 표시**, 소제목 "핵심 역량"
- 2번: 있으면 **무조건 표시**, 소제목 "정규교육과정"
- 3번: 있으면 **무조건 표시**, 소제목 "필수 기술 및 지식"
- 4번: 있으면 **무조건 표시**, 소제목 "정규교육"
- 5번: 있으면 **무조건 표시**, 소제목 "숙련기간"

**템플릿 구현 예시**:
```typescript
const abilityBlocks = []

// 핵심 역량
if (profile.abilityList?.length) {
  abilityBlocks.push(`
    <h4 class="subsection-title">핵심 역량</h4>
    ${renderAbilityList(profile.abilityList)}
  `)
}

// 정규교육과정
if (profile.curriculum) {
  abilityBlocks.push(`
    <h4 class="subsection-title">정규교육과정</h4>
    ${formatRichText(profile.curriculum)}
  `)
}

// 필수 기술 및 지식
if (profile.technKnow) {
  abilityBlocks.push(`
    <h4 class="subsection-title">필수 기술 및 지식</h4>
    ${formatRichText(profile.technKnow)}
  `)
}

// 교육수준
if (profile.eduLevel) {
  abilityBlocks.push(`
    <h4 class="subsection-title">정규교육</h4>
    ${formatRichText(profile.eduLevel)}
  `)
}

// 숙련기간
if (profile.skillYear) {
  abilityBlocks.push(`
    <h4 class="subsection-title">숙련기간</h4>
    ${formatRichText(profile.skillYear)}
  `)
}

if (abilityBlocks.length > 0) {
  pushOverviewCard('핵심 능력·자격', 'fa-bolt', abilityBlocks.join(''))
}
```

---

### ~~2.1.5. 추가 리소스~~ ❌ **삭제**
이전에 HowTo 가이드가 표시되었으나 제거됨.

---

### ~~2.1.6. 기본 정보~~ ❌ **삭제**
사이드바로 이동됨.

---

### 2.1.5. 적성 및 흥미 (이전 2.1.7)
**Rule Type**: 3 (커스텀 규칙)

**필드**:
1. `careernet.encyclopedia.aptitudeList` (적성)
2. `careernet.encyclopedia.interestList` (흥미)

**커스텀 규칙**:
- 1번: 소제목 "적성"
- 2번: 소제목 "흥미"

**템플릿 구현 예시**:
```typescript
const traitBlocks = []

if (profile.aptitudeList?.length) {
  traitBlocks.push(`
    <h4 class="subsection-title">적성</h4>
    <ul class="trait-list">
      ${profile.aptitudeList.map(item => `<li>${escapeHtml(item.aptitude)}</li>`).join('')}
    </ul>
  `)
}

if (profile.interestList?.length) {
  traitBlocks.push(`
    <h4 class="subsection-title">흥미</h4>
    <ul class="trait-list">
      ${profile.interestList.map(item => `<li>${escapeHtml(item.interest)}</li>`).join('')}
    </ul>
  `)
}

if (traitBlocks.length > 0) {
  pushOverviewCard('적성 및 흥미', 'fa-heart', traitBlocks.join(''))
}
```

**현재 상태**: ✅ 이미 구현됨 (위치만 조정)

---

### 2.1.6. 여담 (이전 2.1.8) 🆕 **신규**
**Rule Type**: 3 (커스텀)

**필드**: 없음 (유저 기여 공간)

**설명**: 
- 데이터 없이 빈 섹션으로 표시
- 사용자가 직접 내용 추가 가능
- 커뮤니티 기여 섹션

**템플릿 구현 예시**:
```typescript
pushOverviewCard(
  '여담', 
  'fa-comments', 
  `
    <div class="empty-section">
      <p class="text-wiki-muted">
        <i class="fas fa-pencil-alt"></i> 
        이 섹션은 여러분의 경험과 팁을 공유하는 공간입니다. 
        <a href="#comments" class="text-wiki-primary">의견을 남겨주세요!</a>
      </p>
    </div>
  `
)
```

---

### 2.1.7. 임금 정보 (이전 2.1.9)
**Rule Type**: 1 (우선순위)

**필드**:
1. `goyong24.job.salProspect.sal` ⭐ 1순위
2. `goyong24.job.summary.sal`
3. `careernet.encyclopedia.baseInfo.wage`

**현재 상태**: ✅ 이미 구현됨 (게이지 차트 포함)

---

## 🎯 개요 탭 최종 순서

1. **주요 업무** (작업강도/장소/육체활동 포함)
2. **커리어 전망** (전망 요약 차트 포함)
3. **핵심 능력·자격** (5가지 소제목)
4. **적성 및 흥미** (적성/흥미 분리)
5. **임금 정보** (게이지 차트)
6. **여담** (유저 기여 공간) ← 마지막으로 이동

## 🎯 상세정보 탭 구조 변경

**추가**:
- **한국의 직업지표** (개요 탭에서 이동)

**제거**:
- ~~교육·자격~~ ❌ (삭제됨)

---

## 🔧 구현 방법

### 방법 A: **템플릿에서 구현** (추천)
- ✅ 유연성 높음
- ✅ ETL 단순 유지
- ✅ 스타일 변경 쉬움
- ⚠️ 템플릿 로직 복잡해짐

### 방법 B: **ETL에서 구현**
- ✅ 템플릿 단순
- ✅ DB에 정제된 데이터 저장
- ⚠️ ETL 복잡
- ⚠️ 스타일 변경 시 ETL 재실행 필요

---

## 📝 다음 단계

1. **템플릿 수정** (`unifiedJobDetail.ts`)
   - 개요 탭 순서 조정
   - 소제목 추가
   - "여담" 섹션 추가

2. **템플릿 버전 업데이트**
   ```typescript
   // src/constants/template-versions.ts
   export const TEMPLATE_VERSIONS = {
     JOB: 43,  // 42 → 43
   }
   ```

3. **테스트**
   ```
   http://localhost:3000/job/lawyer
   ```

4. **ETL 재실행 (필요 시)**
   ```bash
   npx tsx src/scripts/etl/mergeJobProfiles.ts
   ```


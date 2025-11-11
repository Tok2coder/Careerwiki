# 🌱 데이터 시딩 가이드

> CareerWiki D1 데이터베이스에 전공 및 직업 데이터 수집하기

---

## 📊 시딩 개요

### 예상 데이터량
- **전공 (Majors)**: 약 1,424개
  - CareerNet: 약 501개
  - Goyong24: 약 923개
- **직업 (Jobs)**: 약 587개
  - CareerNet + Goyong24 통합

### 예상 소요 시간
- **전공 시딩**: 2-3시간 (API 호출 제한 고려)
- **직업 시딩**: 1-2시간
- **총 소요 시간**: 약 3-5시간

---

## 🚀 시딩 실행 방법

### 전공 데이터 시딩

```bash
npx tsx src/scripts/seedAllMajors.ts
```

**진행 과정:**
1. CareerNet에서 전공 목록 수집
2. Goyong24에서 전공 목록 수집
3. 중복 제거
4. 각 전공별 상세 정보 수집 및 D1 저장
5. Phase 1 필드 수집 통계 출력

**출력 예시:**
```
🌱 전공 데이터 시딩 시작...

1단계: 전공 목록 수집
✅ CareerNet: 501개 전공 발견
✅ Goyong24: 923개 전공 발견

✅ 총 1,424개 전공 발견

2단계: 전공 상세 데이터 수집 및 D1 저장
[1/1424] 컴퓨터공학과... ✅
[2/1424] 간호학과... ✅
...
```

---

### 직업 데이터 시딩

```bash
npx tsx src/scripts/seedAllJobs.ts
```

**진행 과정:**
1. CareerNet에서 직업 목록 수집
2. Goyong24에서 직업 목록 수집
3. 중복 제거
4. 각 직업별 상세 정보 수집 및 D1 저장

---

## 📈 진행 상황 확인

### 실시간 확인

시딩 중에 다른 터미널에서 확인:

```bash
# 전공 수 확인
npx wrangler d1 execute careerwiki-jobs --local --command="SELECT COUNT(*) FROM majors;"

# 직업 수 확인
npx wrangler d1 execute careerwiki-jobs --local --command="SELECT COUNT(*) FROM jobs;"

# 최근 추가된 데이터 확인
npx wrangler d1 execute careerwiki-jobs --local --command="SELECT id, name, created_at FROM majors ORDER BY created_at DESC LIMIT 10;"
```

### 데이터 소스별 통계

```bash
# 전공 데이터 소스별 통계
npx wrangler d1 execute careerwiki-jobs --local --command="
SELECT 
  (SELECT COUNT(*) FROM majors WHERE careernet_id IS NOT NULL) as careernet_count,
  (SELECT COUNT(*) FROM majors WHERE goyong24_id IS NOT NULL) as goyong24_count,
  (SELECT COUNT(*) FROM majors) as total;
"
```

---

## ⚠️ 주의사항

### API Rate Limiting
- API 호출 제한을 피하기 위해 스크립트에 지연 시간이 포함되어 있습니다
- 시딩 중에는 스크립트를 중단하지 마세요

### 중단 시
시딩이 중단되면:
1. 이미 저장된 데이터는 유지됩니다
2. 나머지 데이터만 다시 시딩하면 됩니다 (upsert 방식)
3. 해시 비교로 중복 저장을 방지합니다

### 재시작
시딩을 다시 시작해도:
- 이미 저장된 데이터는 스킵됩니다
- 새로운 데이터만 추가됩니다
- 안전하게 재실행 가능합니다

---

## 🔍 시딩 완료 후 검증

### 1. 데이터 수 확인
```bash
npx wrangler d1 execute careerwiki-jobs --local --command="SELECT COUNT(*) FROM majors;"
npx wrangler d1 execute careerwiki-jobs --local --command="SELECT COUNT(*) FROM jobs;"
```

### 2. 샘플 데이터 확인
```bash
# 전공 샘플
npx wrangler d1 execute careerwiki-jobs --local --command="SELECT id, name, careernet_id, goyong24_id FROM majors LIMIT 5;"

# 직업 샘플
npx wrangler d1 execute careerwiki-jobs --local --command="SELECT id, name, careernet_id, goyong24_id FROM jobs LIMIT 5;"
```

### 3. Phase 1 필드 확인 (전공)
```bash
# Phase 1 필드가 포함된 전공 데이터 확인
npx tsx verify-phase1-data.ts
```

---

## 📝 시딩 스크립트 위치

- **전공 시딩**: `src/scripts/seedAllMajors.ts`
- **직업 시딩**: `src/scripts/seedAllJobs.ts`

---

## 🎯 예상 결과

### 전공 데이터
- 총 레코드: 약 1,424개
- CareerNet: 약 501개
- Goyong24: 약 923개
- Phase 1 필드: 44개 필드 포함

### 직업 데이터
- 총 레코드: 약 587개
- CareerNet + Goyong24 통합

---

**마지막 업데이트**: 2025-11-06


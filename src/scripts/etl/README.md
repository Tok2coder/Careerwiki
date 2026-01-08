# CareerWiki ETL Scripts

> 상세 가이드: `docs/ETL_SEEDING_GUIDE.md`

## 📁 디렉토리 구조

```
src/scripts/
├── loadJobDictionaryIndex.ts       # 직업사전 마스터 CSV 로드
├── runCareerNetJobsSeeding.ts      # 커리어넷 직업 시딩 runner
├── runWork24JobsSeeding.ts         # 고용24 직업 시딩 runner
├── runWork24JobDictionarySeeding.ts # 고용24 직업사전 시딩 runner
├── runCareerNetMajorsSeeding.ts    # 커리어넷 전공 시딩 runner
├── runWork24MajorsSeeding.ts       # 고용24 전공 시딩 runner
├── runWork24MajorsCSVSeeding.ts    # 고용24 전공 CSV 시딩 runner
├── runJobMerge.ts                  # 직업 병합 runner
├── runMajorMerge.ts                # 전공 병합 runner
└── etl/
    ├── seedCareerNetJobs.ts        # 커리어넷 직업 시딩 로직
    ├── seedCareerNetMajors.ts      # 커리어넷 전공 시딩 로직
    ├── seedWork24Jobs.ts           # 고용24 직업 시딩 로직
    ├── seedWork24JobDictionary.ts  # 고용24 직업사전 시딩 로직
    ├── seedWork24JobDictionaryFromCSV.ts
    ├── seedWork24Majors.ts         # 고용24 전공 시딩 로직
    ├── seedWork24MajorsFromCSV.ts
    ├── mergeJobProfiles.ts         # job_sources → jobs 병합
    └── mergeMajorProfiles.ts       # major_sources → majors 병합
```

## 🚀 실행 순서

### 직업 데이터 (Phase 1)

```bash
# 1. 직업사전 마스터 코드 로드
npx tsx src/scripts/loadJobDictionaryIndex.ts

# 2. 커리어넷 직업 시딩
npx tsx src/scripts/runCareerNetJobsSeeding.ts

# 3. 고용24 직업 시딩
npx tsx src/scripts/runWork24JobsSeeding.ts

# 4. 고용24 직업사전 시딩 (⚠️ 시간 오래 걸림)
npx tsx src/scripts/runWork24JobDictionarySeeding.ts

# 5. 직업 병합 (최종)
npx tsx src/scripts/runJobMerge.ts
```

### 전공 데이터 (Phase 2)

```bash
# 6. 커리어넷 전공 시딩
npx tsx src/scripts/runCareerNetMajorsSeeding.ts

# 7. 고용24 전공 시딩
npx tsx src/scripts/runWork24MajorsSeeding.ts
# 또는 CSV 버전
npx tsx src/scripts/runWork24MajorsCSVSeeding.ts

# 8. 전공 병합 (최종)
npx tsx src/scripts/runMajorMerge.ts
```

## 🔧 옵션

| 옵션 | 설명 | 예시 |
|------|------|------|
| `--limit=N` | 처리할 개수 제한 | `--limit=100` |
| `--skip=true` | 기존 데이터 스킵 | `--skip=true` |

**예시:**
```bash
npx tsx src/scripts/runCareerNetJobsSeeding.ts --limit=100
npx tsx src/scripts/runMajorMerge.ts --majorGb=1 --name=컴퓨터공학과
```

## 📊 모니터링

```sql
-- 시딩 진행 상황
SELECT * FROM seed_logs ORDER BY started_at DESC LIMIT 10;

-- 실패 항목
SELECT * FROM seed_errors WHERE resolved_at IS NULL;
```

## ⚠️ 주의사항

- **HowTo는 시딩 대상이 아님** (사용자가 직접 작성)
- Rate limiting: 최소 **300ms 간격**
- 재시도: 3회까지 자동
- 직업사전 시딩: **6,581개** 항목 (3~6시간 소요)

## 📚 상세 문서

👉 **`docs/ETL_SEEDING_GUIDE.md`** 참조

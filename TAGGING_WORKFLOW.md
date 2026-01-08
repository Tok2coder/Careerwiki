# Job Attributes 수동 태깅 워크플로우

> **목표**: Coverage Set 408개 고품질 태깅
> **진행 방식**: AI 태깅 + 수동 검증
> **완료 목표**: 2026-01-05 내 태깅 완료

---

## 1. 태깅 작업 개요

### 1.1 현재 상태
- ✅ Coverage Set 추출 완료: 408개 직업
- ✅ AI 프롬프트 생성 완료: 14개 버킷별 상세 프롬프트
- ⏳ 태깅 작업 시작

### 1.2 작업 방식
1. **AI 태깅**: 각 버킷별로 AI에게 태깅 요청
2. **수동 검증**: AI 결과 검토 및 수정
3. **DB 반영**: 검증된 데이터 D1에 저장
4. **테스트**: 스코어링에 실제 반영되는지 확인

---

## 2. AI 태깅 실행 방법

### 2.1 준비 파일들

```
scripts/tagging/output/
├── coverage-set-final.csv          # 전체 Coverage Set (408개)
├── ai-prompt-phase1-final.txt      # Phase 1: Coverage Set 검증
└── ai-prompt-phase2-{bucket}-final.txt  # Phase 2: 각 버킷 태깅 (14개)
```

### 2.2 태깅 순서 (우선순위 기반)

| 순서 | 버킷 | 개수 | 난이도 | 이유 |
|------|------|------|--------|------|
| 1 | `IT_DATA` | 50개 | ⭐⭐ | 가장 일반적, 스코어링 영향 큼 |
| 2 | `MEDICAL_HEALTH` | 45개 | ⭐⭐⭐ | 전문성 높아 검증 필요 |
| 3 | `MANUFACTURING` | 35개 | ⭐⭐ | 생산직 특성 명확 |
| 4 | `FINANCE_ACCOUNTING` | 35개 | ⭐⭐ | 전문 자격증 영향 |
| 5 | `EDUCATION` | 40개 | ⭐⭐ | 안정성 높음 |
| 6 | `CONSTRUCTION` | 30개 | ⭐⭐ | 현장 업무 특성 |
| 7 | `ARTS_DESIGN` | 35개 | ⭐⭐⭐ | 창의성 지표 중요 |
| 8 | `SERVICE_HOSPITALITY` | 35개 | ⭐⭐ | 대면 업무 비중 높음 |
| 9 | `SALES_MARKETING` | 40개 | ⭐⭐ | 영업 특성 |
| 10 | `MANAGEMENT_HR` | 3개 | ⭐ | 데이터 부족 |
| 11 | `LAW_PUBLIC` | 12개 | ⭐⭐⭐ | 전문성 매우 높음 |
| 12 | `MEDIA_CONTENTS` | 9개 | ⭐⭐ | 콘텐츠 특성 |
| 13 | `LOGISTICS_TRANSPORT` | 14개 | ⭐⭐ | 운송 특성 |
| 14 | `AGRICULTURE_ENVIRONMENT` | 25개 | ⭐ | 농업 특성 |

### 2.3 AI 태깅 프롬프트 사용법

#### Step 1: AI에게 프롬프트 전달

**ChatGPT/Claude/Gemini 등에 다음을 복사해서 붙여넣기:**

```
[여기에 ai-prompt-phase2-it_data-final.txt 내용 전체 복사]
```

#### Step 2: AI 응답 받기

AI가 다음과 같은 CSV를 반환할 것임:

```csv
job_id,job_name,bucket,wlb,growth,stability,income,teamwork,solo_deep,analytical,creative,execution,people_facing,work_hours,shift_work,travel,remote_possible,degree_required,license_required,confidence,notes
176528335019564,웹마스터,IT_DATA,70,75,60,65,60,70,65,70,60,40,overtime_some,none,none,partial,bachelor,none,0.9,웹사이트 운영/관리 중심, 크리에이티브한 업무 포함
...
```

#### Step 3: 수동 검증 및 수정

**검증 포인트:**
- [ ] `wlb` 0~100 범위 맞는가?
- [ ] 같은 버킷 내 상대 비교가 타당한가? (가장 좋은 직업=80+, 가장 나쁜=30-)
- [ ] `work_hours`가 `wlb`와 일관되는가?
- [ ] `degree_required`/`license_required`가 직업에 맞는가?
- [ ] `confidence` 0.8~0.95 범위인가?

**수정 예시:**
```csv
# AI 결과
70,75,60,65,60,70,65,70,60,40,overtime_some,none,none,partial,bachelor,none,0.9,웹사이트 운영/관리 중심

# 검증 후 수정 (wlb를 더 높게, remote를 full로)
75,75,60,65,60,70,65,70,60,40,regular,none,none,full,bachelor,none,0.95,웹사이트 운영/관리 중심, 재택 가능성 높음
```

#### Step 4: 파일 저장

```
scripts/tagging/output/
└── tagged-it_data-final.csv    # 검증 완료된 태깅 결과
```

---

## 3. DB 반영 방법

### 3.1 CSV → D1 업로드

```bash
# 1. 검증된 CSV를 D1 SQL로 변환
npx tsx scripts/tagging/csv-to-d1-upsert.ts scripts/tagging/output/tagged-it_data-final.csv

# 2. 생성된 SQL로 DB 업데이트
wrangler d1 execute careerwiki-db --local --file scripts/tagging/output/upsert-job-attributes.sql

# 3. 확인
wrangler d1 execute careerwiki-db --local --command="SELECT COUNT(*) FROM job_attributes WHERE status = 'tagged' AND job_id IN (SELECT job_id FROM job_sources WHERE json_extract(normalized_payload, '$.name') LIKE '%웹마스터%')"
```

### 3.2 스코어링 테스트

```bash
# 태깅된 직업이 스코어링에 반영되는지 테스트
# /analyzer/job?debug=true에서 Applied facts 확인
```

---

## 4. 품질 관리 기준

### 4.1 Pass/Fail 기준

| 항목 | Pass | Fail |
|------|------|------|
| **수치 범위** | 0~100 | 벗어남 |
| **범주 값** | 유효 enum | 잘못된 값 |
| **논리 일관성** | wlb↔work_hours 일치 | 모순 |
| **버킷 비교** | 상대적 순위 타당 | 역전 |
| **confidence** | 0.8~0.95 | 벗어남 |

### 4.2 QA 샘플링

**각 버킷당 3개 랜덤 샘플링:**
- [ ] 같은 버킷 내 순위가 타당한가?
- [ ] 전문가 판단과 일치하는가?
- [ ] 스코어링 결과에 말이 되는가?

### 4.3 수정 정책

| 오류 유형 | 수정 방식 |
|-----------|-----------|
| **단순 오류** | 즉시 수정 |
| **판단 차이** | notes에 근거 기록 |
| **불확실성** | confidence 낮추고 중간값 사용 |

---

## 5. 작업 일정

### 5.1 1일차 목표 (오늘)

**IT_DATA 버킷 태깅 완료:**
- [ ] AI 태깅 요청
- [ ] 수동 검증
- [ ] DB 반영
- [ ] 스코어링 테스트

### 5.2 주간 목표

| 일차 | 버킷 | 개수 | 누적 |
|------|------|------|------|
| 1 | IT_DATA | 50 | 50 |
| 2 | MEDICAL_HEALTH | 45 | 95 |
| 3 | MANUFACTURING + FINANCE | 70 | 165 |
| 4 | EDUCATION + CONSTRUCTION | 70 | 235 |
| 5 | ARTS_DESIGN + SERVICE | 70 | 305 |
| 6 | SALES_MARKETING | 40 | 345 |
| 7 | 나머지 버킷 | 63 | 408 |

### 5.3 완료 검증

```bash
# 전체 태깅 개수 확인
wrangler d1 execute careerwiki-db --local --command="SELECT COUNT(*) FROM job_attributes WHERE status = 'tagged'"

# 버킷별 분포 확인
wrangler d1 execute careerwiki-db --local --command="SELECT bucket, COUNT(*) as count FROM (SELECT CASE WHEN job_name LIKE '%개발%' OR job_name LIKE '%데이터%' THEN 'IT_DATA' WHEN job_name LIKE '%의사%' OR job_name LIKE '%간호%' THEN 'MEDICAL_HEALTH' ELSE 'OTHER' END as bucket FROM job_attributes WHERE status = 'tagged') GROUP BY bucket"
```

---

## 6. 문제 해결

### 6.1 AI 태깅 품질 이슈

**증상:** AI가 너무 보수적으로 태깅 (모든 값이 50 근처)

**해결:**
```
프롬프트에 추가: "버킷 내 상대 비교를 명확히 해라. 가장 좋은 직업은 80+, 가장 나쁜 직업은 30-로 설정"
```

### 6.2 일관성 오류

**증상:** wlb=80인데 work_hours=overtime_frequent

**해결:**
```
논리적 검증 추가: wlb >= 70이면 work_hours는 regular 또는 overtime_some만 가능
```

### 6.3 DB 반영 실패

**증상:** wrangler 명령어 실패

**해결:**
```bash
# 로컬에서 테스트
wrangler d1 execute careerwiki-db --local --command="SELECT 1"

# SQL 파일 확인
head -20 scripts/tagging/output/upsert-job-attributes.sql
```

---

## 7. 시작하기

### 7.1 즉시 실행

```bash
# 1. IT_DATA 버킷 태깅 시작
cat scripts/tagging/output/ai-prompt-phase2-it_data-final.txt

# 2. 위 내용을 AI에게 복사해서 태깅 요청
# 3. 응답받은 CSV를 검증
# 4. DB 반영 테스트
```

### 7.2 예상 결과

**태깅 완료 후:**
- `/analyzer/job?debug=true`에서 Applied facts가 의미 있게 표시
- TOP3 추천이 더 정확해짐
- Follow-up 질문이 실제로 순위를 바꾸는 효과 발생

---

*Version: v1.0.0*
*Created: 2026-01-05*
*Next: Phase 5 캘리브레이션 시나리오 QA*







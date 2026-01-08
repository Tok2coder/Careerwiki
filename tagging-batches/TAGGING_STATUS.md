# 태깅 진행 현황

## 📊 전체 현황

| 항목 | 수량 |
|------|------|
| 전체 고유 직업 | 6,944개 |
| 태깅 완료 | 403개 |
| 미태깅 | 6,541개 |
| 진행률 | 5.8% |

---

## 📁 배치 계획

100개씩 66개 배치 (마지막 배치 41개)

| 배치 # | 범위 | 상태 | 완료일 |
|--------|------|------|--------|
| 001 | 0-99 | ⏳ 대기 | - |
| 002 | 100-199 | ⏳ 대기 | - |
| 003 | 200-299 | ⏳ 대기 | - |
| 004 | 300-399 | ⏳ 대기 | - |
| 005 | 400-499 | ⏳ 대기 | - |
| ... | ... | ... | ... |

---

## 🚀 빠른 시작

### 1. 다음 배치 추출
```bash
npx tsx scripts/export-jobs-for-tagging.ts --limit 100 --offset 0 --output tagging-batches/batch_001.json
```

### 2. Cursor/Grok으로 태깅
1. `docs/TAGGING_PROMPT_TEMPLATE.md` 열기
2. 프롬프트 복사
3. `batch_001.json`에서 직업 정보 붙여넣기
4. 결과 JSON을 `tagging-batches/results/batch_001_tagged.json`에 저장

### 3. SQL 생성 및 적용
```bash
npx tsx scripts/generate-tagging-sql.ts --input tagging-batches/results/batch_001_tagged.json --output tagging-batches/completed/batch_001.sql
npx wrangler d1 execute careerwiki-db --local --file tagging-batches/completed/batch_001.sql
```

### 4. 다음 배치로 진행
```bash
npx tsx scripts/export-jobs-for-tagging.ts --limit 100 --offset 100 --output tagging-batches/batch_002.json
```

---

## ✅ 완료 기록

| 날짜 | 배치 | 개수 | 비고 |
|------|------|------|------|
| - | 초기 태깅 | 403 | 기존 완료분 |

---

## 📝 메모

- 배치당 소요 시간: 약 10-15분 (수동 태깅)
- 전체 예상 소요: 66배치 × 15분 = 약 16시간




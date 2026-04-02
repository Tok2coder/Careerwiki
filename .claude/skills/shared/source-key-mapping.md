# 출처 소스 키 매핑 (Sources Key Mapping)

> 이 파일은 `job-data-create` 및 `job-data-equalize` 스킬 공통 참조 문서입니다.

---

## 소스 키 표 (⚠️ 반드시 이 키 이름을 사용!)

| 소스 키 | 한국어 라벨 (렌더링) | 설명 |
|---------|---------------------|------|
| `way` | 되는 방법 | 되는 방법 필드의 출처 |
| `overviewSalary.sal` | 임금 정보 | 임금 필드의 출처 |
| `overviewProspect.main` | 전망 정보 | 전망 필드의 출처 |
| `trivia` | 여담 | 여담 필드의 출처 |
| `summary` | 직업 설명 | 요약 필드의 출처 |
| `detailWlb.wlbDetail` | 워라밸 상세 | 워라밸 상세 필드의 출처 |
| `detailWlb.socialDetail` | 사회적 기여 상세 | 사회적 기여 상세 필드의 출처 |
| `overviewAbilities.technKnow` | 활용 기술 | 활용 기술 필드의 출처 |

---

## ⚠️ 절대 금지 — 흔한 sources 키 실수

> - ❌ `way_sources` → ✅ `way` (접미사 `_sources` 금지)
> - ❌ `overviewSalary_sources` → ✅ `overviewSalary.sal`
> - ❌ `detailWlb_sources` → ✅ `detailWlb.wlbDetail`
> - ❌ 숫자 키 `"1"`, `"2"`, `"3"` → ✅ 반드시 필드명 키 (`way`, `trivia` 등)
> - sources 없이 fields만 전송 금지 (각주 깨짐)
>
> 서버에서 잘못된 키 형식을 일부 자동 보정하지만, 처음부터 올바른 키를 사용할 것.

---

## 각주 source.text의 [N] prefix 규칙

- `[N]`의 N은 **해당 필드 내 로컬 순서 번호** (1부터 시작)
- `source.id`는 서버가 자동 부여하므로 전송 시 생략 가능
- 예: way 출처 3개 → `[1] 설명A`, `[2] 설명B`, `[3] 설명C`
- 예: trivia 출처 1개 → `[1] 설명X` (way와 별개로 1부터 시작)

---

## 기존 소스 삭제

불필요한 기존 소스 키를 삭제하려면:
```json
{
  "fields": {},
  "sources": {
    "summary": {"delete": true}
  },
  "changeSummary": "불필요한 summary 소스 삭제"
}
```

---

## Google Indexing 자동 알림

편집 API로 저장이 성공하면 **자동으로** Google Indexing API에 URL 업데이트 알림이 전송된다.
- 별도 작업 불필요 — 코드에서 `waitUntil`로 백그라운드 처리
- 실패해도 편집 저장에 영향 없음
- Google이 보통 수 시간~1일 내에 크롤링하여 인덱스 업데이트

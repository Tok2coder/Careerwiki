# Revision 복원 가이드

## 데이터 안전성
✅ **모든 편집은 revision으로 저장되며 데이터가 삭제되지 않습니다.**
✅ **언제든지 이전 버전으로 복원할 수 있습니다.**

## 복원 방법

### 1. 편집 이력 확인

```bash
# 직업의 편집 이력 조회
curl http://localhost:3000/api/job/{jobId}/revisions

# 전공의 편집 이력 조회  
curl http://localhost:3000/api/major/{majorId}/revisions
```

응답 예시:
```json
{
  "success": true,
  "data": {
    "revisions": [
      {
        "id": 1,
        "revisionNumber": 1,
        "editorName": "익명 1",
        "changeSummary": "Edited summary",
        "createdAt": "2024-01-01T00:00:00Z",
        "isCurrent": true
      },
      {
        "id": 2,
        "revisionNumber": 2,
        "editorName": "익명 2",
        "changeSummary": "Edited duties",
        "createdAt": "2024-01-02T00:00:00Z",
        "isCurrent": false
      }
    ],
    "total": 2
  }
}
```

### 2. 특정 Revision으로 복원

```bash
# 로그인 사용자 편집인 경우
curl -X POST http://localhost:3000/api/revision/{revisionId}/restore \
  -H "Content-Type: application/json" \
  -H "Cookie: your-auth-cookie"

# 익명 편집인 경우 (비밀번호 필요)
curl -X POST http://localhost:3000/api/revision/{revisionId}/restore \
  -H "Content-Type: application/json" \
  -d '{"password": "1234"}'
```

### 3. 가장 최근 편집 취소 (현재 버전의 이전 버전으로 복원)

1. 편집 이력 조회에서 `isCurrent: true`인 revision 찾기
2. 그 revision의 `revisionNumber - 1`인 revision 찾기
3. 해당 revision의 `id`로 복원 요청

## 주의사항

- 복원 시 현재 상태도 revision으로 저장되므로, 복원 후에도 다시 복원 가능합니다
- 익명 편집인 경우 복원 시 4자리 비밀번호가 필요합니다
- 복원 후 ISR 캐시가 자동으로 무효화되어 변경사항이 즉시 반영됩니다

## 데이터 보호 원리

1. **Revision 저장**: 모든 편집은 `page_revisions` 테이블에 저장됨
2. **스냅샷 보존**: 변경 전 상태가 `data_snapshot`에 JSON으로 저장됨
3. **현재 버전 관리**: `is_current` 플래그로 현재 활성 버전만 표시
4. **복원 안전성**: 복원 시에도 현재 상태를 보존하므로 되돌리기 가능

## 예시: 테스트 수정 후 복원

```bash
# 1. 테스트 수정 후 편집 이력 확인
curl http://localhost:3000/api/job/software-developer/revisions

# 2. 수정 전 revision ID 확인 (예: revisionNumber가 1인 revision)
# 3. 해당 revision으로 복원
curl -X POST http://localhost:3000/api/revision/1/restore \
  -H "Content-Type: application/json"
```


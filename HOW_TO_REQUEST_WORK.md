# 작업 요청 가이드

## 📝 작업 요청 방법

### 기본 형식
```
"[파일명] 보고 [작업 내용] 시작해줘"
```

### 예시

#### ✅ 좋은 예시
```
"PHASE4_IMPLEMENTATION_STEPS.md 보고 Phase 1부터 시작해줘"
"src/middleware/auth.ts 보고 익명 편집 허용하도록 수정해줘"
"PHASE4_IMPLEMENTATION_PLAN.md 보고 API 엔드포인트 설계 확인하고 구현 시작해줘"
```

#### ❌ 나쁜 예시
```
"시작해줘" (어떤 파일을 봐야 하는지 모름)
"편집 시스템 만들어줘" (너무 광범위)
"수정해줘" (무엇을 수정할지 불명확)
```

### 구체적인 요청 예시

1. **단계별 진행**
   ```
   "PHASE4_IMPLEMENTATION_STEPS.md 보고 Phase 1 (데이터베이스 마이그레이션) 시작해줘"
   ```

2. **특정 파일 수정**
   ```
   "src/middleware/auth.ts 보고 requireJobMajorEdit 함수를 익명 허용하도록 수정해줘"
   ```

3. **새 파일 생성**
   ```
   "PHASE4_IMPLEMENTATION_STEPS.md Phase 2 보고 src/utils/anonymousEdit.ts 파일 생성해줘"
   ```

4. **여러 파일 참조**
   ```
   "src/services/commentService.ts와 PHASE4_IMPLEMENTATION_STEPS.md 보고 익명 편집 유틸리티 함수 만들어줘"
   ```

---

## 💾 백업 관련

### GitHub 백업 (이미 완료됨)
- ✅ **현재 상태**: 모든 변경사항이 GitHub에 푸시됨 (commit: 673cdf9)
- ✅ **백업 내용**: 코드, 문서, 마이그레이션 파일 등 모든 변경사항

### 추가 백업이 필요한 경우

#### 1. 현재 작업 중인 변경사항 백업
```
"현재 변경사항 Git에 커밋하고 푸시해줘"
또는
"지금까지 작업한 내용 백업해줘"
```

#### 2. 특정 시점으로 되돌리기
```
"Git 커밋 673cdf9 상태로 되돌려줘"
또는
"이전 버전으로 복원해줘"
```

#### 3. 특정 파일만 복원
```
"src/middleware/auth.ts 파일을 이전 버전으로 복원해줘"
```

---

## 🔄 백업 파일 불러오기 (Git 복원)

### 방법 1: 특정 커밋으로 되돌리기
```
"Git 커밋 [커밋해시] 상태로 되돌려줘"
예: "Git 커밋 673cdf9 상태로 되돌려줘"
```

### 방법 2: 특정 파일만 복원
```
"[파일경로] 파일을 [커밋해시] 버전으로 복원해줘"
예: "src/middleware/auth.ts 파일을 673cdf9 버전으로 복원해줘"
```

### 방법 3: 브랜치로 복원
```
"Git 브랜치 [브랜치명]으로 전환해줘"
```

### 방법 4: 최신 원격 저장소로 동기화
```
"GitHub에서 최신 코드 가져와줘"
또는
"git pull 해줘"
```

---

## 📋 작업 요청 템플릿

### 템플릿 1: 단계별 진행
```
"[계획서 파일명] 보고 [Phase 번호]부터 시작해줘"
```

### 템플릿 2: 특정 기능 구현
```
"[참고 파일명] 보고 [기능명] 구현해줘"
예: "PHASE4_IMPLEMENTATION_STEPS.md 보고 익명 편집 유틸리티 함수 구현해줘"
```

### 템플릿 3: 파일 수정
```
"[파일명] 보고 [수정 내용] 해줘"
예: "src/middleware/auth.ts 보고 익명 편집 허용하도록 수정해줘"
```

### 템플릿 4: 문제 해결
```
"[파일명]에서 [문제 내용] 확인하고 수정해줘"
예: "src/index.tsx에서 편집 API 엔드포인트 오류 확인하고 수정해줘"
```

---

## 🎯 현재 Phase 4 작업 요청 예시

### Phase 1 시작
```
"PHASE4_IMPLEMENTATION_STEPS.md 보고 Phase 1 (데이터베이스 마이그레이션) 시작해줘"
```

### Phase 2 시작
```
"PHASE4_IMPLEMENTATION_STEPS.md Phase 2 보고 src/utils/anonymousEdit.ts 파일 생성해줘"
```

### Phase 3 시작
```
"PHASE4_IMPLEMENTATION_STEPS.md Phase 3 보고 src/services/revisionService.ts 파일 생성해줘"
```

### Phase 5 (미들웨어 수정)
```
"PHASE4_IMPLEMENTATION_STEPS.md Phase 5 보고 src/middleware/auth.ts 수정해줘"
```

---

## ⚠️ 주의사항

1. **파일명은 정확히**: 대소문자 구분, 확장자 포함
2. **경로 명시**: 가능하면 전체 경로 또는 상대 경로 명시
3. **참고 문서 명시**: 계획서나 설계 문서가 있으면 함께 언급
4. **구체적인 요청**: "수정해줘"보다 "익명 편집 허용하도록 수정해줘"가 더 명확

---

## 💡 팁

### 효과적인 요청 방법
1. **파일명 + 작업 내용**: 가장 명확함
2. **계획서 참조**: 단계별 작업 시 계획서 파일명 명시
3. **에러 발생 시**: 에러 메시지와 함께 파일명 제공

### 예시
```
✅ 좋음: "PHASE4_IMPLEMENTATION_STEPS.md 보고 Phase 1 시작해줘"
✅ 좋음: "src/middleware/auth.ts 보고 requireJobMajorEdit 함수 익명 허용하도록 수정해줘"
❌ 나쁨: "시작해줘"
❌ 나쁨: "수정해줘"
```

---

## 🔍 현재 상태 확인

### Git 상태 확인
```
"현재 Git 상태 확인해줘"
또는
"git status 확인해줘"
```

### 특정 파일 확인
```
"[파일명] 파일 내용 확인해줘"
예: "src/middleware/auth.ts 파일 내용 확인해줘"
```

### 커밋 히스토리 확인
```
"최근 Git 커밋 히스토리 확인해줘"
또는
"git log 확인해줘"
```

---

**요약**: 
- 작업 요청 시: `"[파일명] 보고 [작업 내용] 해줘"` 형식 사용
- 백업: GitHub에 이미 완료됨 (추가 백업 필요 시 요청)
- 복원: `"Git 커밋 [해시]로 되돌려줘"` 또는 `"[파일명]을 [커밋] 버전으로 복원해줘"`



<!-- 2bb7ef23-347c-42c4-8204-e70dd6de1cb4 33dd0768-d122-4f66-ba0f-91890295ce65 -->
# 로그인 후 리다이렉트 개선

## 목표

1. 로그인 페이지(`/login`)로 직접 접근 시: 이전 페이지(Referer)로 리다이렉트, 없으면 홈으로
2. 유저 아이콘 클릭 시: 현재 페이지로 리다이렉트

## 수정 사항

### 1. `/login` 페이지 - Referer 헤더 활용

**파일**: `src/index.tsx` (line 3739-3787)

- `c.req.header('Referer')` 확인
- Referer가 있고 유효한 내부 URL이면 `redirect`로 사용
- 없거나 유효하지 않으면 기본값 `/` 사용
- Referer가 외부 도메인이면 무시하고 `/` 사용
```typescript
// 수정 전 (line 3740):
const redirect = c.req.query('redirect') || '/'

// 수정 후:
const queryRedirect = c.req.query('redirect')
const referer = c.req.header('Referer')
let redirect = queryRedirect || '/'

// Referer가 있고 내부 URL이면 사용
if (!queryRedirect && referer) {
  try {
    const refererUrl = new URL(referer)
    const currentUrl = new URL(c.req.url)
    // 같은 도메인이면 Referer 사용
    if (refererUrl.origin === currentUrl.origin && refererUrl.pathname !== '/login') {
      redirect = refererUrl.pathname + refererUrl.search
    }
  } catch (e) {
    // URL 파싱 실패 시 기본값 사용
  }
}
```


### 2. 유저 메뉴 로그인 링크 - 클라이언트 사이드 동적 업데이트

**파일**: `src/index.tsx` (line 239-245, 1166-1179)

- 서버 사이드 렌더링된 로그인 링크에 `data-login-link` 속성 추가
- 클라이언트 사이드 스크립트에서 현재 경로를 `return_url`로 추가

**서버 사이드 (line 240):**

```typescript
// 수정 전:
<a href="/auth/google" class="...">

// 수정 후:
<a href="/auth/google" data-login-link class="...">
```

**클라이언트 사이드 스크립트 추가 (line 1166 이후):**

```typescript
// 로그인 링크에 현재 경로 추가
document.querySelectorAll('[data-login-link]').forEach(link => {
  const currentPath = window.location.pathname + window.location.search
  link.href = '/auth/google?return_url=' + encodeURIComponent(currentPath)
})
```

## 테스트 시나리오

1. `/job/software-developer`에서 유저 아이콘 클릭 → 로그인 → `/job/software-developer`로 돌아가야 함
2. `/howto`에서 유저 아이콘 클릭 → 로그인 → `/howto`로 돌아가야 함
3. 브라우저에서 직접 `/login` 입력 → 로그인 → 이전 페이지 또는 홈으로
4. `/login?redirect=/howto/write` → 로그인 → `/howto/write`로

### To-dos

- [ ] 데이터 출처 → 출처 변경, 각주 추가 시 스크롤 수정
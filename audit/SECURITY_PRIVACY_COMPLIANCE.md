# SECURITY / PRIVACY / COMPLIANCE

## 인증/인가
- Google OAuth 라우트 및 역할(user/expert/admin) 존재  
- 미들웨어: authMiddleware, requireAuth/requireAdmin 등  
증거: `src/index.tsx`, `src/middleware/auth.ts`
- 토큰 수명/세션 저장 방식: 명시 없음 → UNKNOWN

## 민감정보 처리/보존/암호화
- 비밀 관리 방법 문서화 없음 → UNKNOWN
- 개인정보/로그 보존 기간 미정 → UNKNOWN

## 접근 통제
- 라우트 보호 미들웨어 존재, 세부 정책(관리자 전용 경로) 코드에 한정  
- 인프라 수준(Cloudflare Access/WAF) 설정 미확인 → UNKNOWN

## 감사로그/비상접근
- 감사로그/비상 접근 절차 미문서 → UNKNOWN

## 취약점 스캔
- 보고서/스캔 결과 없음 → UNKNOWN

## 권장 즉시 조치
- wrangler secrets 인벤토리화, 노출 키 회수  
- OAuth 클라이언트/콜백/토큰 수명 문서화  
- WAF/Rate Limit 정책 정의, 에러/보안 이벤트 로깅+알림 설정


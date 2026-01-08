# ASSETS / AI IMAGE PIPELINE

## 이미지 스타일 가이드
- 히어로: 1200x675(16:9), <500KB 업로드, Alt 규칙 “{직업/전공명} … 모습”  
- 포맷: JPEG/PNG 입력, CF Images가 WebP/AVIF 변환  
증거: `docs/IMAGE_STORAGE_PLAN.md`

## 파이프라인 (계획)
- 저장소: 권장 Cloudflare Images (imagedelivery.net/{account}/{id}/{variant}), 대안 R2  
- 업로드 API/admin UI/일괄 업로드 스크립트 계획, 미구현  
증거: `docs/IMAGE_STORAGE_PLAN.md`

## 자산 관리
- 파일명/경로: CF Images variant 사용, alt/credits 필드 jobs/majors 스키마 포함  
증거: `docs/IMAGE_STORAGE_PLAN.md`, `migrations/0019_add_image_fields.sql`(추정) → 적용상태 UNKNOWN

## 대량 생성/AI
- 향후 Cloudflare AI Workers (stable-diffusion) 제안, 프롬프트 예시 포함  
증거: `docs/IMAGE_STORAGE_PLAN.md`

## 샘플 10건
- 샘플 메타/프롬프트 저장 없음 → UNKNOWN (생성/업로드 필요)


# IMG_V0 SPEC (코드 스캐폴드, 배포 금지)

- 스타일 버전: `imgStyle_v1` (고정)  
  - 사이즈: 800x533 webp, 배경 neutral, 톤 미드톤, 노출 균형  
  - 프롬프트 예시: "portrait of {{job_title}} at work, neutral background, soft light, webp 800x533, professional, no text"
- 파일명/경로: `public/images/jobs/<slug>__v1.webp`
- DB 필드: `image_url`, `image_alt`, `image_credits`, `image_style_version`
- 트리거:
  - 배치(A): 슬러그 리스트 입력 → 생성 → URL만 jobs 테이블에 바인딩
  - 요청(B): 최초 방문 시 비동기 큐 등록(동기 생성 금지)
- ISR 무효화: 이미지가 채워지면 해당 slug 캐시 무효화(템플릿/데이터 버전 키 포함)
- 플레이스홀더/접근성: 이미지 없으면 placeholder + alt 자동 생성(`{{job_title}} 대표 이미지 준비 중`)
- 샘플 10건: `software-developer`, `network-systems-developer`, `data-analyst`, `game-designer`, `virtual-reality-specialist`, `ai-researcher`, `cloud-engineer`, `security-analyst`, `product-manager`, `ux-designer` → 목업 URL `/images/jobs/<slug>__v1.webp` 바인딩 가능


# SEO / AEO / GEO STATUS

## 구조화 데이터/마크업
- JSON-LD 생성: `createJobJsonLd`, `createMajorJsonLd`  
증거: `src/templates/unifiedJobDetail.ts`, `src/templates/unifiedMajorDetail.ts`
- SSR + ISR로 완성 HTML 제공 → AEO/GEO 친화  
증거: `docs/SEO_AEO_GEO_ANALYSIS.md`

## 내부링크/허브
- nav/partials로 상단 내비, 상세 내 관련직업/전공 링크 존재  
증거: `src/templates/partials/nav`, 상세 템플릿 내 사이드바

## 크롤러 접근
- robots.txt/sitemap 설정 미확인 → UNKNOWN

## 콘솔/지표
- GSC/Bing/AIO 콘솔 지표(노출/CTR/색인) 없음 → UNKNOWN

## AEO/GEO 준비도
- 구조화 데이터·SSR 제공, Freshness는 ISR로 자동  
- 외부 엔티티 신호/백링크/브랜드 신호 측정 없음 → UNKNOWN

## 권장 액션
- robots.txt/sitemap.xml 생성·배포  
- og/meta 일관성 점검, article:modified_time 템플릿 반영 상태 유지  
- GSC 등록 및 색인 상태 모니터링, AIO/Bing 등록


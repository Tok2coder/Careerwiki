# 🖼️ 이미지 저장 전략 계획서

## 📋 개요
- **대상**: 직업/전공 페이지의 히어로 이미지
- **예상 규모**: ~1,000개 직업 + ~200개 전공 = 약 1,200개 이미지
- **용도**: 상세 페이지 상단 히어로 섹션

## 🗄️ DB 구조 (완료)
```sql
jobs.image_url TEXT         -- CDN URL
jobs.image_alt TEXT         -- 접근성 alt text
jobs.image_credits TEXT     -- 출처/저작권

majors.image_url TEXT
majors.image_alt TEXT
majors.image_credits TEXT
```

## 📦 저장소 옵션 비교

### 옵션 1: Cloudflare Images (✅ 추천)
**장점**:
- 자동 최적화 (WebP, AVIF 변환)
- 글로벌 CDN 자동 적용
- Resizing/Cropping API 제공
- Workers와 통합 용이
- Bandwidth 무제한

**비용**:
- 저장: $5/월 (최대 100,000 이미지)
- 전송: 무제한 (추가 비용 없음)
- **예상 월 비용**: $5 (1,200개 이미지)

**URL 형식**:
```
https://imagedelivery.net/{account_hash}/{image_id}/{variant}
```

**설정 필요**:
```bash
# .dev.vars
CLOUDFLARE_IMAGES_ACCOUNT_ID=your_account_id
CLOUDFLARE_IMAGES_API_TOKEN=your_token
```

### 옵션 2: Cloudflare R2 Storage
**장점**:
- S3 호환 (기존 도구 사용 가능)
- 더 저렴한 저장 비용
- Egress 무료

**비용**:
- 저장: $0.015/GB/월
- Class A: $4.50/백만 requests
- Class B: $0.36/백만 requests
- **예상 월 비용**: < $1 (1,200개 × 500KB = 0.6GB)

**단점**:
- 직접 최적화 필요
- CDN 설정 필요 (R2 + Custom Domain)

**설정 필요**:
```bash
# .dev.vars
R2_BUCKET_NAME=careerwiki-images
R2_ACCESS_KEY_ID=your_key
R2_SECRET_ACCESS_KEY=your_secret
```

### 옵션 3: External CDN (imgix, Cloudinary 등)
**장점**:
- 강력한 이미지 처리 기능
- AI 기반 최적화

**단점**:
- 추가 벤더 종속성
- 더 높은 비용

## 🎯 최종 추천: Cloudflare Images

### 이유
1. **단순성**: 별도 CDN 설정 불필요
2. **자동 최적화**: WebP/AVIF 자동 변환
3. **비용 효율**: $5/월로 충분
4. **Workers 통합**: 기존 인프라와 통합 용이

## 📸 이미지 규격

### 권장 사양
```yaml
히어로 이미지:
  크기: 1200x675 (16:9 비율)
  포맷: JPEG/PNG (Cloudflare가 자동 WebP/AVIF 변환)
  용량: < 500KB (업로드 전)
  최적화: Cloudflare가 자동 처리

썸네일 (향후):
  크기: 400x225 (16:9 비율)
  Cloudflare variant로 자동 생성
```

### Alt Text 가이드
```
직업 이미지: "{직업명} 직업 종사자가 업무를 수행하는 모습"
전공 이미지: "{전공명} 전공 관련 학습 환경"

예시:
- "소프트웨어 개발자 직업 종사자가 업무를 수행하는 모습"
- "컴퓨터공학 전공 관련 학습 환경"
```

## 🔧 구현 단계 (향후)

### Phase 1: 인프라 설정
```bash
# 1. Cloudflare Images 계정 설정
# 2. API 토큰 발급
# 3. .dev.vars 업데이트
# 4. wrangler.toml에 바인딩 추가
```

### Phase 2: 업로드 API 구현
```typescript
// src/index.tsx
app.post('/admin/upload-image/:type/:slug', async (c) => {
  // 파일 업로드 → Cloudflare Images
  // DB 업데이트 (image_url, image_alt)
})
```

### Phase 3: 관리 UI 구축
```
/admin/images
- 직업/전공 목록
- 이미지 업로드 폼
- 미리보기
- 일괄 업로드 (CSV)
```

### Phase 4: 템플릿 통합
```typescript
// unifiedJobDetail.ts
<div class="hero-section">
  {profile.image_url && (
    <img 
      src={`${profile.image_url}/public`}
      alt={profile.image_alt}
      loading="lazy"
    />
  )}
</div>
```

## 📊 이미지 소싱 전략

### 1. 무료 스톡 이미지
```
추천 사이트:
- Unsplash (https://unsplash.com)
- Pexels (https://pexels.com)
- Pixabay (https://pixabay.com)

라이선스: 상업적 사용 가능, 출처 표기 권장
```

### 2. AI 생성 (향후 자동화)
```typescript
// Cloudflare AI Workers
@cf/stabilityai/stable-diffusion-xl-base-1.0

프롬프트 예시:
"Professional {job_name} working in modern office, 
 clean illustration style, no text, 16:9 aspect ratio"
```

### 3. 일괄 처리 스크립트
```bash
# scripts/bulk-upload-images.ts
# CSV 형식:
# slug,image_path,alt_text,credits

software-developer,./images/jobs/software-developer.jpg,"소프트웨어 개발자 업무 모습","Unsplash - John Doe"
```

## 🚀 즉시 실행 가능한 명령어

### 마이그레이션 적용
```bash
# 로컬 D1
npm run db:migrate:local

# 프로덕션 (준비되면)
npm run db:migrate:prod
```

### 이미지 필드 확인
```bash
npx wrangler d1 execute careerwiki --local --command \
  "SELECT name, image_url, image_alt FROM jobs LIMIT 5"
```

## 📝 체크리스트

### 현재 상태 ✅
- [x] DB 마이그레이션 파일 생성
- [x] 테이블 스키마 설계 완료
- [x] 저장소 옵션 조사 완료
- [x] 이미지 규격 정의 완료

### 다음 단계 (이미지 준비 후)
- [ ] Cloudflare Images 계정 설정
- [ ] API 토큰 발급
- [ ] 업로드 API 구현
- [ ] 관리 UI 구축
- [ ] 이미지 소싱 (1,200개)
- [ ] 일괄 업로드 스크립트 작성
- [ ] 템플릿 업데이트
- [ ] 템플릿 버전 증가

## 💰 예상 비용 요약

```
Cloudflare Images: $5/월
- 1,200개 이미지 저장
- 무제한 전송
- 자동 최적화 포함

총 연간 비용: $60
```

---

**참고**: 이미지가 준비되면 `docs/IMAGE_UPLOAD_GUIDE.md`에 구체적인 업로드 절차 문서화 예정


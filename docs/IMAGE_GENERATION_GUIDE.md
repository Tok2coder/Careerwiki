# 🎨 이미지 생성 가이드

## 개요

Z-Image Turbo와 ComfyUI를 사용하여 직업/전공 이미지를 자동 생성하는 방법입니다.

## 사전 준비

### 1. ComfyUI 설치 및 설정

```bash
# ComfyUI 설치 (GitHub)
git clone https://github.com/comfyanonymous/ComfyUI.git
cd ComfyUI

# 의존성 설치
pip install -r requirements.txt

# Z-Image Turbo 모델 다운로드
# 모델을 ComfyUI/models/checkpoints/ 디렉토리에 배치
```

### 2. ComfyUI 실행

```bash
cd ComfyUI
python main.py --listen 127.0.0.1 --port 8188
```

서버가 실행되면 `http://127.0.0.1:8188`에서 접근 가능합니다.

### 3. 환경 변수 설정 (선택사항)

```bash
# .env 파일 또는 환경 변수
export COMFYUI_API_URL="http://127.0.0.1:8188"
export IMAGE_OUTPUT_DIR="./public/images/generated"
export BATCH_SIZE=10
```

## 사용 방법

### 방법 1: 자동 이미지 생성 (ComfyUI API 사용)

```bash
# 직업 이미지 10개 생성
node scripts/generate_images_comfyui.cjs job 10 0

# 전공 이미지 10개 생성
node scripts/generate_images_comfyui.cjs major 10 0

# 다음 배치 처리
node scripts/generate_images_comfyui.cjs job 10 10
```

**매개변수:**
- 첫 번째: `job` 또는 `major`
- 두 번째: 배치 크기 (기본값: 10)
- 세 번째: 시작 위치 (기본값: 0)

### 방법 2: 수동 이미지 업로드

ComfyUI에서 직접 이미지를 생성한 후, 로컬 파일을 데이터베이스에 업로드:

```bash
# 생성된 이미지 파일들을 public/images/generated/ 에 배치한 후
node scripts/upload_images_to_db.cjs job ./public/images/generated

# 전공 이미지
node scripts/upload_images_to_db.cjs major ./public/images/generated
```

**파일명 형식:**
- `job_{id}_v1.png` 또는 `job_{id}_v1.webp`
- `major_{id}_v1.png` 또는 `major_{id}_v1.webp`

예: `job_1765283277187957_v1.webp`

## 이미지 생성 프로세스

### 1. 프롬프트 확인

데이터베이스에 이미 `image_prompt`가 저장되어 있습니다:

```sql
SELECT id, name, name_en, image_prompt 
FROM jobs 
WHERE image_prompt IS NOT NULL 
LIMIT 5;
```

### 2. 이미지 생성

각 항목의 `image_prompt`를 사용하여 Z-Image Turbo로 이미지를 생성합니다.

### 3. 이미지 저장

생성된 이미지는 다음 위치에 저장됩니다:
- `public/images/generated/job_{id}_v1.webp`
- `public/images/generated/major_{id}_v1.webp`

### 4. 데이터베이스 업데이트

생성된 이미지의 URL이 자동으로 데이터베이스에 업데이트됩니다:
- `image_url`: 이미지 파일 경로
- `image_alt`: 접근성용 alt 텍스트
- `image_credits`: "AI Generated (Z-Image Turbo)"
- `image_style_version`: "v1"

## 배치 처리 예시

### 직업 이미지 생성 (100개씩)

```bash
# 배치 1: 0-99
node scripts/generate_images_comfyui.cjs job 100 0

# 배치 2: 100-199
node scripts/generate_images_comfyui.cjs job 100 100

# 배치 3: 200-299
node scripts/generate_images_comfyui.cjs job 100 200
```

### 진행 상황 확인

```bash
# 이미지가 있는 직업 수 확인
npx wrangler d1 execute careerwiki --local --command \
  "SELECT COUNT(*) as count FROM jobs WHERE image_url IS NOT NULL AND image_url != '';"

# 이미지가 없는 직업 수 확인
npx wrangler d1 execute careerwiki --local --command \
  "SELECT COUNT(*) as count FROM jobs WHERE (image_url IS NULL OR image_url = '') AND image_prompt IS NOT NULL;"
```

## 문제 해결

### ComfyUI 서버 연결 실패

```
❌ ComfyUI 서버 연결 실패
```

**해결 방법:**
1. ComfyUI 서버가 실행 중인지 확인
2. 포트 번호 확인 (기본값: 8188)
3. 방화벽 설정 확인

### 이미지 생성 타임아웃

```
❌ Image generation timeout
```

**해결 방법:**
1. ComfyUI 워크플로우 확인
2. 모델 파일 확인 (Z-Image Turbo)
3. GPU 메모리 확인

### 파일명 매칭 실패

```
⚠️  DB에서 항목을 찾을 수 없음
```

**해결 방법:**
1. 파일명 형식 확인: `{type}_{id}_v{version}.{ext}`
2. ID 형식 확인 (특수문자 제거 여부)

## 다음 단계

1. **이미지 최적화**: WebP 변환 및 압축
2. **CDN 업로드**: Cloudflare Images 또는 R2에 업로드
3. **템플릿 업데이트**: 이미지 표시 로직 추가
4. **캐시 무효화**: ISR 캐시 업데이트

## 참고 자료

- [ComfyUI 공식 문서](https://github.com/comfyanonymous/ComfyUI)
- [Z-Image Turbo 튜토리얼](https://www.nextdiffusion.ai/tutorials/consistent-z-image-turbo-images-controlnet-comfyui-t2i)
- [이미지 저장 전략](./IMAGE_STORAGE_PLAN.md)




# CareerWiki 비버 캐릭터 LoRA 학습 가이드

## 목적

CareerWiki 비버 캐릭터의 시각적 일관성을 높이기 위해 LoRA를 학습합니다.
트리거 워드 `cwbeaver`를 프롬프트에 넣으면 동일한 스타일의 비버가 생성됩니다.

## 사전 요구사항

- Python 3.10+
- CUDA 지원 GPU (VRAM 8GB+)
- ComfyUI가 `C:\Users\user\Documents\ComfyUI`에 설치됨
- z_image_turbo_bf16.safetensors 모델

## Step 1: 학습 데이터 수집

```bash
cd C:\Users\user\Careerwiki
node scripts/collect-beaver-images.cjs --count=30
```

결과: `scripts/lora-training-data/` 폴더에 이미지(.webp) + 캡션(.txt) 생성

수집 후 반드시:
- 품질 안 좋은 이미지 삭제 (비버가 잘 안 보이는 것, 스타일 다른 것)
- 최종 15~30장이 적당
- 캡션 파일 확인 (모두 `cwbeaver`로 시작하는지)

## Step 2: kohya_ss 설치

```bash
git clone https://github.com/bmaltais/kohya_ss.git
cd kohya_ss
python -m venv venv
venv\Scripts\activate
pip install -r requirements.txt
```

## Step 3: 학습 설정

### 폴더 구조
```
lora-training/
├── img/
│   └── 30_cwbeaver/      # "30"은 반복 횟수, "cwbeaver"은 트리거 워드
│       ├── image001.webp
│       ├── image001.txt   # 캡션
│       ├── image002.webp
│       └── image002.txt
├── model/                 # 학습된 LoRA 출력
└── log/                   # 학습 로그
```

### 핵심 파라미터

| 파라미터 | 값 | 설명 |
|---------|------|------|
| base_model | z_image_turbo_bf16.safetensors | 베이스 체크포인트 |
| network_module | networks.lora | LoRA 네트워크 |
| network_dim | 32 | LoRA rank (32~64 권장) |
| network_alpha | 16 | alpha = dim/2 |
| learning_rate | 1e-4 | 학습률 |
| unet_lr | 1e-4 | UNet 학습률 |
| text_encoder_lr | 5e-5 | 텍스트 인코더 학습률 |
| max_train_steps | 1000~1500 | 총 학습 스텝 |
| save_every_n_steps | 250 | 중간 저장 |
| resolution | 1024 | 학습 해상도 |
| batch_size | 1 | 배치 크기 |
| optimizer | AdamW8bit | 옵티마이저 |
| mixed_precision | bf16 | 혼합 정밀도 |

### CLI 실행

```bash
accelerate launch --num_cpu_threads_per_process 1 train_network.py \
  --pretrained_model_name_or_path="C:/Users/user/Documents/ComfyUI/models/diffusion_models/z_image_turbo_bf16.safetensors" \
  --train_data_dir="./lora-training/img" \
  --output_dir="./lora-training/model" \
  --logging_dir="./lora-training/log" \
  --network_module=networks.lora \
  --network_dim=32 \
  --network_alpha=16 \
  --resolution=1024 \
  --train_batch_size=1 \
  --learning_rate=1e-4 \
  --unet_lr=1e-4 \
  --text_encoder_lr=5e-5 \
  --max_train_steps=1500 \
  --save_every_n_steps=250 \
  --mixed_precision=bf16 \
  --optimizer_type=AdamW8bit \
  --caption_extension=.txt \
  --cache_latents \
  --output_name=cwbeaver
```

## Step 4: 학습 결과 검증

학습 완료 후 `lora-training/model/` 에 여러 체크포인트 생성:
- `cwbeaver-000250.safetensors`
- `cwbeaver-000500.safetensors`
- `cwbeaver-000750.safetensors`
- ...
- `cwbeaver.safetensors` (최종)

각 단계별 결과를 비교해서 가장 좋은 것을 선택합니다.

## Step 5: ComfyUI에 배치

```bash
# 최종 선택한 LoRA 파일을 ComfyUI에 복사
copy lora-training\model\cwbeaver.safetensors "C:\Users\user\Documents\ComfyUI\models\loras\cwbeaver.safetensors"
```

## Step 6: 테스트

```bash
cd C:\Users\user\Careerwiki

# ComfyUI 실행 후
node scripts/local-image-gen.cjs --type=jobs --slug=테스트직업 --prompt="cwbeaver, a small cute baby beaver wearing a chef hat, cooking in a kitchen"

# LoRA 없이 비교
node scripts/local-image-gen.cjs --type=jobs --slug=테스트직업-nolora --prompt="a small cute baby beaver wearing a chef hat, cooking in a kitchen" --no-lora
```

## 트러블슈팅

### LoRA 효과가 너무 강함 (비버가 과장됨)
- `local-image-gen.cjs`의 `strength_model`을 0.8 → 0.6으로 낮추기
- 또는 더 적은 스텝(750~1000)에서 학습 중단

### LoRA 효과가 너무 약함 (차이가 없음)
- `strength_model`을 0.8 → 1.0으로 올리기
- 학습 데이터 품질 확인 (다양한 포즈/배경이 포함되었는지)
- 학습 스텝 늘리기 (2000까지)

### VRAM 부족
- `batch_size` 1로 유지
- `resolution` 768로 낮추기
- gradient_checkpointing 활성화

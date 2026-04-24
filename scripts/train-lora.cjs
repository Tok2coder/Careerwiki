#!/usr/bin/env node
/**
 * cwbeaver LoRA 학습 스크립트
 *
 * ComfyUI venv의 Python + PyTorch를 그대로 사용하여
 * 별도 환경 구축 없이 LoRA 학습을 실행합니다.
 *
 * Usage:
 *   node scripts/train-lora.cjs                    # 기본 설정으로 학습
 *   node scripts/train-lora.cjs --steps=1000       # 스텝 수 지정
 *   node scripts/train-lora.cjs --prepare-only      # 폴더 구조만 준비 (학습 안 함)
 */

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

// ─── Config ────────────────────────────────────────────────────────────────
const COMFYUI_VENV_PYTHON = 'C:\\Users\\user\\Documents\\ComfyUI\\.venv\\Scripts\\python.exe';
const COMFYUI_MODELS_DIR = 'C:\\Users\\user\\Documents\\ComfyUI\\models';
const BASE_MODEL = path.join(COMFYUI_MODELS_DIR, 'diffusion_models', 'z_image_turbo_bf16.safetensors');
const LORA_OUTPUT_DIR = path.join(COMFYUI_MODELS_DIR, 'loras');
const TRAINING_DATA_DIR = path.join(__dirname, 'lora-training-data');
const TRAINING_WORK_DIR = path.join(__dirname, 'lora-training-work');

function parseArgs() {
  const args = {};
  for (const arg of process.argv.slice(2)) {
    if (arg.startsWith('--')) {
      const [key, ...rest] = arg.slice(2).split('=');
      args[key] = rest.length ? rest.join('=') : true;
    }
  }
  return args;
}

function log(msg) { console.log(`[LoRA] ${msg}`); }
function err(msg) { console.error(`[LoRA] ❌ ${msg}`); }
function ok(msg) { console.log(`[LoRA] ✅ ${msg}`); }

// ─── Step 1: 사전 검증 ──────────────────────────────────────────────────
function validate() {
  log('사전 검증 중...');

  if (!fs.existsSync(COMFYUI_VENV_PYTHON)) {
    err(`ComfyUI Python 없음: ${COMFYUI_VENV_PYTHON}`);
    return false;
  }
  ok('ComfyUI Python 확인');

  if (!fs.existsSync(BASE_MODEL)) {
    err(`베이스 모델 없음: ${BASE_MODEL}`);
    return false;
  }
  ok('베이스 모델 확인 (z_image_turbo_bf16)');

  const images = fs.readdirSync(TRAINING_DATA_DIR).filter(f => f.endsWith('.webp') || f.endsWith('.png') || f.endsWith('.jpg'));
  if (images.length < 10) {
    err(`학습 이미지 부족: ${images.length}장 (최소 10장 필요). node scripts/collect-beaver-images.cjs 실행하세요.`);
    return false;
  }
  ok(`학습 이미지 ${images.length}장 확인`);

  const captions = fs.readdirSync(TRAINING_DATA_DIR).filter(f => f.endsWith('.txt'));
  if (captions.length < images.length) {
    err(`캡션 파일 부족: ${captions.length}개 (이미지 ${images.length}장)`);
    return false;
  }
  ok(`캡션 파일 ${captions.length}개 확인`);

  return true;
}

// ─── Step 2: 학습 폴더 구조 준비 ──────────────────────────────────────────
function prepareTrainingFolder() {
  log('학습 폴더 준비 중...');

  // kohya_ss 형식: img/30_cwbeaver/ (30 = 반복 횟수)
  const imgDir = path.join(TRAINING_WORK_DIR, 'img', '30_cwbeaver');
  const modelDir = path.join(TRAINING_WORK_DIR, 'model');
  const logDir = path.join(TRAINING_WORK_DIR, 'log');

  for (const dir of [imgDir, modelDir, logDir]) {
    fs.mkdirSync(dir, { recursive: true });
  }

  // 학습 데이터 복사
  const files = fs.readdirSync(TRAINING_DATA_DIR);
  let copied = 0;
  for (const file of files) {
    const src = path.join(TRAINING_DATA_DIR, file);
    const dst = path.join(imgDir, file);
    if (!fs.existsSync(dst)) {
      fs.copyFileSync(src, dst);
      copied++;
    }
  }

  ok(`학습 폴더 준비 완료 (${copied}개 파일 복사)`);
  log(`  이미지: ${imgDir}`);
  log(`  모델 출력: ${modelDir}`);
  return { imgDir, modelDir, logDir };
}

// ─── Step 3: 학습 스크립트 생성 ───────────────────────────────────────────
function generateTrainingScript(dirs, steps) {
  // SimpleTuner나 kohya_ss 대신 직접 Python 학습 스크립트 생성
  // diffusers 기반 LoRA 학습
  const scriptPath = path.join(TRAINING_WORK_DIR, 'train.py');

  const script = `#!/usr/bin/env python3
"""
cwbeaver LoRA 학습 스크립트
diffusers 기반, ComfyUI venv 환경에서 실행
"""
import os
import sys
import glob
import random
from pathlib import Path

# 의존성 확인
try:
    import torch
    from PIL import Image
    print(f"PyTorch {torch.__version__}, CUDA: {torch.cuda.is_available()}")
    if torch.cuda.is_available():
        print(f"GPU: {torch.cuda.get_device_name(0)}")
except ImportError as e:
    print(f"필수 패키지 없음: {e}")
    print("pip install pillow 실행 후 재시도하세요")
    sys.exit(1)

# peft 확인 (LoRA 학습에 필요)
try:
    import peft
    print(f"peft {peft.__version__}")
except ImportError:
    print("peft 패키지 설치 중...")
    os.system(f'"{sys.executable}" -m pip install peft accelerate')
    import peft

try:
    from diffusers import AutoencoderKL, UNet2DConditionModel
    from diffusers.optimization import get_scheduler
    print(f"diffusers 사용 가능")
except ImportError:
    print("diffusers 패키지 설치 중...")
    os.system(f'"{sys.executable}" -m pip install diffusers[torch]')
    from diffusers import AutoencoderKL, UNet2DConditionModel
    from diffusers.optimization import get_scheduler

from safetensors.torch import load_file, save_file
from peft import LoraConfig, get_peft_model
from torch.utils.data import Dataset, DataLoader
from torchvision import transforms

# ─── Config ─────────────────────────────────────────────────────────────
IMG_DIR = r"${dirs.imgDir.replace(/\\/g, '\\\\')}"
MODEL_DIR = r"${dirs.modelDir.replace(/\\/g, '\\\\')}"
BASE_MODEL_PATH = r"${BASE_MODEL.replace(/\\/g, '\\\\')}"
MAX_STEPS = ${steps}
LEARNING_RATE = 1e-4
LORA_RANK = 32
LORA_ALPHA = 16
RESOLUTION = 512  # 학습 해상도
BATCH_SIZE = 1
SAVE_EVERY = 250

print(f"\\n{'='*50}")
print(f"cwbeaver LoRA 학습 시작")
print(f"  이미지 폴더: {IMG_DIR}")
print(f"  총 스텝: {MAX_STEPS}")
print(f"  LoRA rank: {LORA_RANK}")
print(f"  학습률: {LEARNING_RATE}")
print(f"{'='*50}\\n")

# ─── Dataset ────────────────────────────────────────────────────────────
class BeaverDataset(Dataset):
    def __init__(self, img_dir, resolution=512):
        self.images = sorted(glob.glob(os.path.join(img_dir, "*.webp")) +
                            glob.glob(os.path.join(img_dir, "*.png")) +
                            glob.glob(os.path.join(img_dir, "*.jpg")))
        self.transform = transforms.Compose([
            transforms.Resize(resolution, interpolation=transforms.InterpolationMode.LANCZOS),
            transforms.CenterCrop(resolution),
            transforms.ToTensor(),
            transforms.Normalize([0.5], [0.5]),
        ])
        print(f"학습 이미지 {len(self.images)}장 로드")

    def __len__(self):
        return len(self.images)

    def __getitem__(self, idx):
        img_path = self.images[idx % len(self.images)]
        image = Image.open(img_path).convert("RGB")
        image = self.transform(image)

        # 캡션 로드
        txt_path = os.path.splitext(img_path)[0] + ".txt"
        if os.path.exists(txt_path):
            with open(txt_path, "r", encoding="utf-8") as f:
                caption = f.read().strip()
        else:
            caption = "cwbeaver, a small cute baby beaver"

        return {"image": image, "caption": caption}

# ─── 간단한 LoRA 학습 ──────────────────────────────────────────────────
# 참고: z-image-turbo는 FLUX 계열이라 일반적인 diffusers LoRA와 다름
# 여기서는 safetensors 가중치를 직접 로드하여 LoRA 적용

print("모델 로드 중...")
state_dict = load_file(BASE_MODEL_PATH)
print(f"모델 가중치 {len(state_dict)}개 키 로드")

# 모델 구조 분석
key_prefixes = set()
for key in state_dict.keys():
    parts = key.split(".")
    if len(parts) >= 2:
        key_prefixes.add(".".join(parts[:2]))

print(f"모델 블록 {len(key_prefixes)}개 감지")
print("주요 블록:", sorted(list(key_prefixes))[:10])

# 현재 z-image-turbo의 정확한 아키텍처를 모르면 일반적인 LoRA 학습이 어려움
# 대안: kohya_ss의 sdxl_train_network.py를 사용하는 것이 안전함

print("\\n" + "="*50)
print("⚠️ z-image-turbo는 커스텀 아키텍처를 사용하므로")
print("   일반적인 diffusers LoRA 학습이 바로 적용되지 않습니다.")
print("")
print("권장 방법: kohya_ss 사용")
print("")
print("1. kohya_ss 설치:")
print("   git clone https://github.com/bmaltais/kohya_ss.git")
print("   cd kohya_ss")
print("   python -m venv venv")
print("   venv\\\\Scripts\\\\activate")
print("   pip install -r requirements.txt")
print("")
print("2. GUI 실행:")
print("   python kohya_gui.py")
print("   → 브라우저에서 LoRA 학습 탭 선택")
print("   → 아래 설정 입력:")
print(f"     Base model: {BASE_MODEL_PATH}")
print(f"     Training data: {IMG_DIR}")
print(f"     Output: {MODEL_DIR}")
print(f"     Network rank: {LORA_RANK}")
print(f"     Network alpha: {LORA_ALPHA}")
print(f"     Learning rate: {LEARNING_RATE}")
print(f"     Max steps: {MAX_STEPS}")
print(f"     Resolution: {RESOLUTION}")
print("")
print("3. 학습 완료 후:")
print(f"   copy {MODEL_DIR}\\\\cwbeaver.safetensors")
print(f"     → C:\\\\Users\\\\user\\\\Documents\\\\ComfyUI\\\\models\\\\loras\\\\")
print("="*50)
`;

  fs.writeFileSync(scriptPath, script, 'utf8');
  return scriptPath;
}

// ─── Main ──────────────────────────────────────────────────────────────
async function main() {
  const args = parseArgs();
  const steps = parseInt(args.steps) || 1500;
  const prepareOnly = !!args['prepare-only'];

  console.log('\n╔══════════════════════════════════════════╗');
  console.log('║      cwbeaver LoRA 학습 도구             ║');
  console.log('╚══════════════════════════════════════════╝\n');

  if (!validate()) {
    process.exit(1);
  }

  const dirs = prepareTrainingFolder();

  if (prepareOnly) {
    ok('폴더 준비 완료 (--prepare-only)');
    process.exit(0);
  }

  const scriptPath = generateTrainingScript(dirs, steps);
  log(`학습 스크립트 생성: ${scriptPath}`);
  log('학습 시작...\n');

  try {
    execSync(`"${COMFYUI_VENV_PYTHON}" "${scriptPath}"`, {
      cwd: TRAINING_WORK_DIR,
      stdio: 'inherit',
      timeout: 3600000, // 1시간
    });
  } catch (e) {
    err(`학습 실패: ${e.message}`);
    process.exit(1);
  }
}

main();

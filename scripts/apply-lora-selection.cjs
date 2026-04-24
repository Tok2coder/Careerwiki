#!/usr/bin/env node
const fs = require('fs');
const path = require('path');

const DEFAULT_OUTPUT = 'C:\\Users\\user\\ai-toolkit\\datasets\\cwbeaver_curated';
const DEFAULT_CONFIG = 'C:\\Users\\user\\ai-toolkit\\config\\cwbeaver_lora.yaml';
const DATASET_ROOT = 'C:\\Users\\user\\ai-toolkit\\datasets';

function parseArgs() {
  const args = {};
  for (const arg of process.argv.slice(2)) {
    if (!arg.startsWith('--')) continue;
    const [key, ...rest] = arg.slice(2).split('=');
    args[key] = rest.length ? rest.join('=') : true;
  }
  return args;
}

function ensureSafeOutputDir(outputDir) {
  const normalized = path.resolve(outputDir);
  if (!normalized.startsWith(path.resolve(DATASET_ROOT))) {
    throw new Error(`출력 폴더는 ${DATASET_ROOT} 아래여야 합니다: ${normalized}`);
  }
  return normalized;
}

function cleanDir(dir) {
  if (fs.existsSync(dir)) {
    fs.rmSync(dir, { recursive: true, force: true });
  }
  fs.mkdirSync(dir, { recursive: true });
}

function updateConfig(configPath, datasetDir) {
  if (!fs.existsSync(configPath)) return false;
  const current = fs.readFileSync(configPath, 'utf8');
  const next = current.replace(/folder_path:\s*"[^"]+"/, `folder_path: "${datasetDir.replace(/\\/g, '\\\\')}"`);
  if (next === current) {
    throw new Error(`config에서 folder_path를 찾지 못했습니다: ${configPath}`);
  }
  fs.writeFileSync(configPath, next, 'utf8');
  return true;
}

function main() {
  const args = parseArgs();
  const selectionPath = args.selection ? path.resolve(args.selection) : null;
  const outputDir = ensureSafeOutputDir(args.output || DEFAULT_OUTPUT);
  const configPath = args.config || DEFAULT_CONFIG;
  const updateConfigEnabled = !args['no-update-config'];

  if (!selectionPath || !fs.existsSync(selectionPath)) {
    throw new Error('선택 JSON 파일이 필요합니다. 예: --selection=C:\\Users\\user\\Downloads\\cwbeaver-selection.json');
  }

  const selection = JSON.parse(fs.readFileSync(selectionPath, 'utf8'));
  const sourceDir = selection.sourceDir;
  if (!sourceDir || !fs.existsSync(sourceDir)) {
    throw new Error(`선택 JSON의 sourceDir가 유효하지 않습니다: ${sourceDir}`);
  }

  const selectedItems = (selection.items || []).filter(item => item.selected);
  if (selectedItems.length === 0) {
    throw new Error('선택된 이미지가 없습니다. 최소 1개 이상 선택하세요.');
  }

  cleanDir(outputDir);

  for (const item of selectedItems) {
    const imageSrc = path.join(sourceDir, item.sourceImageFile);
    const imageDst = path.join(outputDir, item.sourceImageFile);
    const captionDst = path.join(outputDir, item.sourceCaptionFile || `${item.baseName}.txt`);
    const caption = String(item.caption || '').trim();

    if (!fs.existsSync(imageSrc)) {
      throw new Error(`원본 이미지가 없습니다: ${imageSrc}`);
    }

    fs.copyFileSync(imageSrc, imageDst);
    fs.writeFileSync(captionDst, caption, 'utf8');
  }

  let configUpdated = false;
  if (updateConfigEnabled) {
    configUpdated = updateConfig(configPath, outputDir);
  }

  console.log(`curated 데이터셋 생성 완료: ${outputDir}`);
  console.log(`선택 이미지 수: ${selectedItems.length}`);
  if (configUpdated) {
    console.log(`학습 설정 업데이트 완료: ${configPath}`);
  } else if (updateConfigEnabled) {
    console.log(`학습 설정 파일이 없어 업데이트는 건너뜀: ${configPath}`);
  }
}

main();

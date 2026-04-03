#!/usr/bin/env node
/**
 * 스크린샷 파일들을 HowTo 이미지 UUID로 업로드
 * 시간순으로 매핑 (스크린샷 촬영 시간 = 이미지 사용 순서)
 */

import { execSync } from 'child_process';
import { readdirSync, existsSync } from 'fs';
import { join } from 'path';

// HowTo 글에서 필요한 이미지 (사용 순서)
const REQUIRED_IMAGES = [
  'howto/2025/12/27/4710a7d8-323b-42b7-901b-a2c6adbd2f51.png',
  'howto/2025/12/27/c38450f9-d640-406a-a8e0-f5b7eb8e1811.png',
  'howto/2025/12/27/cfcb7487-37d4-422a-b265-bda3a90b33fc.png',
  'howto/2025/12/27/82b38c8e-baa8-4e7e-8b2f-daaf89b5d26e.png',
  'howto/2025/12/27/52f9a55a-24d1-4142-a4b9-22b79fc45264.png',
  'howto/2025/12/27/3446e6eb-3a50-4787-a1b5-3cf759293f1a.png',
  'howto/2025/12/27/a7675dcd-b3ce-43bd-a046-2fe1df61f0df.png',
  'howto/2025/12/27/c184e7d8-8320-47ce-a9c9-6d6e077bc66d.png',
  'howto/2025/12/27/51e96aaf-666e-4b77-8c13-af0ef4f3e30e.png',
  'howto/2025/12/27/428d1d6e-b3b0-4d63-a68d-50b90d241d68.png',
  'howto/2025/12/27/5a912669-3c9a-4be5-9e7a-f0e7ef4f4d9b.png',
  'howto/2025/12/27/d565c53b-d8d1-4db1-b126-0f2b4ed0e2ca.png',
  'howto/2025/12/27/0d7cd3d5-392f-4d30-aeb0-61e1ba540af5.png',
  'howto/2025/12/27/dc7bc991-ea8c-40e2-9db3-42ea10b2c659.png',
  'howto/2025/12/27/da19ce14-b7b2-4329-8dfe-67a1c937d8c5.png',
  'howto/2025/12/27/ff4ccba9-fb4a-4afe-912c-69228f376cb3.png',
  'howto/2025/12/27/97d4cfca-5a94-4d70-8cd6-d4a457f06938.png'
];

// 스크린샷 폴더
const SCREENSHOTS_DIR = 'C:/Users/PC/OneDrive/그림/Screenshots';

// 12/27 스크린샷 파일들 (시간순 정렬)
const files = readdirSync(SCREENSHOTS_DIR)
  .filter(f => f.startsWith('스크린샷 2025-12-27') && f.endsWith('.png'))
  .sort();

console.log(`📁 스크린샷 ${files.length}개 발견, 필요한 이미지 ${REQUIRED_IMAGES.length}개\n`);

if (files.length < REQUIRED_IMAGES.length) {
  console.error('❌ 스크린샷이 부족합니다!');
  process.exit(1);
}

// 매핑 및 업로드
let success = 0;
let failed = 0;

for (let i = 0; i < REQUIRED_IMAGES.length; i++) {
  const imageKey = REQUIRED_IMAGES[i];
  const screenshot = files[i];
  const screenshotPath = join(SCREENSHOTS_DIR, screenshot);
  
  console.log(`${i + 1}. ${screenshot} → ${imageKey.split('/').pop()}`);
  
  try {
    execSync(
      `npx wrangler r2 object put "careerwiki-uploads/${imageKey}" --file="${screenshotPath}" --remote --content-type="image/png"`,
      { stdio: 'pipe' }
    );
    console.log(`   ✅ 업로드 완료`);
    success++;
  } catch (e) {
    console.log(`   ❌ 실패: ${e.message}`);
    failed++;
  }
}

console.log('\n========================================');
console.log(`✅ 성공: ${success}`);
console.log(`❌ 실패: ${failed}`);
console.log('========================================\n');

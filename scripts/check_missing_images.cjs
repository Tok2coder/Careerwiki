const { execSync } = require('child_process');

/**
 * 이미지가 없는 직업/전공 확인
 */
function checkMissingImages(type = 'job') {
  console.log(`📊 ${type === 'job' ? '직업' : '전공'} 이미지 상태 확인 중...\n`);

  // 전체 항목 수
  const totalQuery = `SELECT COUNT(*) as count FROM ${type}s WHERE name_en IS NOT NULL AND name_en != '';`;
  const totalResult = execSync(
    `npx wrangler d1 execute careerwiki-db --local --command "${totalQuery.replace(/"/g, '\\"')}"`,
    { encoding: 'utf8', cwd: process.cwd() }
  );
  const totalMatch = totalResult.match(/"count":\s*(\d+)/);
  const total = totalMatch ? parseInt(totalMatch[1]) : 0;

  // 이미지가 있는 항목 수
  const withImageQuery = `SELECT COUNT(*) as count FROM ${type}s WHERE image_url IS NOT NULL AND image_url != '';`;
  const withImageResult = execSync(
    `npx wrangler d1 execute careerwiki-db --local --command "${withImageQuery.replace(/"/g, '\\"')}"`,
    { encoding: 'utf8', cwd: process.cwd() }
  );
  const withImageMatch = withImageResult.match(/"count":\s*(\d+)/);
  const withImage = withImageMatch ? parseInt(withImageMatch[1]) : 0;

  // 프롬프트는 있지만 이미지가 없는 항목 수
  const missingImageQuery = `SELECT COUNT(*) as count FROM ${type}s WHERE name_en IS NOT NULL AND name_en != '' AND image_prompt IS NOT NULL AND image_prompt != '' AND (image_url IS NULL OR image_url = '');`;
  const missingImageResult = execSync(
    `npx wrangler d1 execute careerwiki-db --local --command "${missingImageQuery.replace(/"/g, '\\"')}"`,
    { encoding: 'utf8', cwd: process.cwd() }
  );
  const missingImageMatch = missingImageResult.match(/"count":\s*(\d+)/);
  const missingImage = missingImageMatch ? parseInt(missingImageMatch[1]) : 0;

  // 프롬프트가 없는 항목 수
  const noPromptQuery = `SELECT COUNT(*) as count FROM ${type}s WHERE name_en IS NOT NULL AND name_en != '' AND (image_prompt IS NULL OR image_prompt = '');`;
  const noPromptResult = execSync(
    `npx wrangler d1 execute careerwiki-db --local --command "${noPromptQuery.replace(/"/g, '\\"')}"`,
    { encoding: 'utf8', cwd: process.cwd() }
  );
  const noPromptMatch = noPromptResult.match(/"count":\s*(\d+)/);
  const noPrompt = noPromptMatch ? parseInt(noPromptMatch[1]) : 0;

  console.log(`📈 통계:`);
  console.log(`   전체 항목: ${total.toLocaleString()}개`);
  console.log(`   이미지 있음: ${withImage.toLocaleString()}개 (${total > 0 ? ((withImage / total) * 100).toFixed(1) : 0}%)`);
  console.log(`   프롬프트 있음, 이미지 없음: ${missingImage.toLocaleString()}개`);
  console.log(`   프롬프트 없음: ${noPrompt.toLocaleString()}개\n`);

  if (missingImage > 0) {
    console.log(`📋 이미지 생성 대기 중인 항목 샘플 (최대 10개):\n`);
    const sampleQuery = `SELECT id, name, name_en FROM ${type}s WHERE name_en IS NOT NULL AND name_en != '' AND image_prompt IS NOT NULL AND image_prompt != '' AND (image_url IS NULL OR image_url = '') ORDER BY id LIMIT 10;`;
    const sampleResult = execSync(
      `npx wrangler d1 execute careerwiki-db --local --command "${sampleQuery.replace(/"/g, '\\"')}"`,
      { encoding: 'utf8', cwd: process.cwd() }
    );

    const jsonStart = sampleResult.indexOf('[');
    const jsonEnd = sampleResult.lastIndexOf(']') + 1;
    if (jsonStart !== -1 && jsonEnd > jsonStart) {
      const jsonData = sampleResult.substring(jsonStart, jsonEnd);
      const items = JSON.parse(jsonData).results || [];
      items.forEach((item, index) => {
        console.log(`   ${index + 1}. ${item.name} (${item.name_en})`);
      });
    }
  }

  return {
    total,
    withImage,
    missingImage,
    noPrompt,
    percentage: total > 0 ? ((withImage / total) * 100).toFixed(1) : '0.0'
  };
}

// 메인 실행
function main() {
  const args = process.argv.slice(2);
  const type = args[0] || 'job';

  console.log('🔍 이미지 상태 확인\n');
  console.log('='.repeat(50) + '\n');

  if (type === 'all' || type === 'job') {
    checkMissingImages('job');
    console.log('\n' + '='.repeat(50) + '\n');
  }

  if (type === 'all' || type === 'major') {
    checkMissingImages('major');
  }

  console.log('\n💡 이미지 생성 명령어:');
  console.log('   node scripts/generate_images_comfyui.cjs job 10 0');
  console.log('   node scripts/generate_images_comfyui.cjs major 10 0\n');
}

if (require.main === module) {
  main();
}

module.exports = { checkMissingImages };




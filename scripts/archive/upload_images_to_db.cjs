const fs = require('fs');
const { execSync } = require('child_process');
const path = require('path');

/**
 * 로컬에 생성된 이미지 파일들을 데이터베이스에 업데이트
 * @param {string} type - 'job' 또는 'major'
 * @param {string} imageDir - 이미지 파일이 있는 디렉토리
 */
function uploadLocalImagesToDB(type, imageDir) {
  const imageFiles = fs.readdirSync(imageDir)
    .filter(file => file.startsWith(`${type}_`) && (file.endsWith('.png') || file.endsWith('.webp') || file.endsWith('.jpg')));

  console.log(`📁 발견된 이미지 파일: ${imageFiles.length}개\n`);

  const updates = [];

  for (const imageFile of imageFiles) {
    // 파일명에서 ID 추출: job_1765283277187957_v1.png -> 1765283277187957
    const match = imageFile.match(new RegExp(`${type}_(.+?)_v\\d+\\.(png|webp|jpg)`));
    if (!match) {
      console.warn(`⚠️  파일명 형식 오류: ${imageFile}`);
      continue;
    }

    const itemId = match[1].replace(/_/g, '-'); // ID 복원
    const imagePath = path.join(imageDir, imageFile);
    const relativePath = path.relative(
      path.join(__dirname, '../public'),
      imagePath
    ).replace(/\\/g, '/');
    const imageUrl = `/${relativePath}`;

    // 데이터베이스에서 해당 항목 조회
    try {
      const query = `SELECT id, name FROM ${type}s WHERE id = '${itemId}' OR id LIKE '%${itemId}%' LIMIT 1`;
      const result = execSync(
        `npx wrangler d1 execute careerwiki --local --command "${query.replace(/"/g, '\\"')}"`,
        { encoding: 'utf8', cwd: process.cwd() }
      );

      const jsonStart = result.indexOf('[');
      const jsonEnd = result.lastIndexOf(']') + 1;
      if (jsonStart === -1 || jsonEnd === 0) {
        console.warn(`⚠️  DB에서 항목을 찾을 수 없음: ${itemId}`);
        continue;
      }

      const jsonData = result.substring(jsonStart, jsonEnd);
      const items = JSON.parse(jsonData).results || [];

      if (items.length === 0) {
        console.warn(`⚠️  DB에서 항목을 찾을 수 없음: ${itemId}`);
        continue;
      }

      const item = items[0];
      const imageAlt = type === 'job'
        ? `${item.name} 직업 종사자가 업무를 수행하는 모습`
        : `${item.name} 전공 관련 학습 환경`;

      updates.push({
        id: item.id,
        imageUrl,
        imageAlt,
        imageCredits: 'AI Generated (Z-Image Turbo)',
        imageStyleVersion: 'v1'
      });

      console.log(`✅ 매칭: ${item.name} -> ${imageUrl}`);
    } catch (error) {
      console.error(`❌ 처리 실패 (${imageFile}):`, error.message);
    }
  }

  if (updates.length === 0) {
    console.log('⚠️  업데이트할 항목이 없습니다.');
    return;
  }

  // SQL 업데이트 파일 생성
  const sqlUpdates = updates.map(u => {
    const escapedUrl = u.imageUrl.replace(/'/g, "''");
    const escapedAlt = u.imageAlt.replace(/'/g, "''");
    const escapedCredits = u.imageCredits.replace(/'/g, "''");
    return `UPDATE ${type}s SET image_url = '${escapedUrl}', image_alt = '${escapedAlt}', image_credits = '${escapedCredits}', image_style_version = '${u.imageStyleVersion}' WHERE id = '${u.id}';`;
  });

  const sqlFile = `update_${type}s_images_${Date.now()}.sql`;
  const sqlContent = `-- Update images for ${updates.length} ${type}s\n${sqlUpdates.join('\n')}`;
  fs.writeFileSync(sqlFile, sqlContent);

  console.log(`\n📝 SQL 파일 생성: ${sqlFile}`);
  console.log(`🔄 데이터베이스 업데이트 중...\n`);

  execSync(`npx wrangler d1 execute careerwiki --local --file ${sqlFile}`, {
    stdio: 'inherit',
    cwd: process.cwd()
  });

  // 임시 SQL 파일 삭제
  if (fs.existsSync(sqlFile)) {
    fs.unlinkSync(sqlFile);
  }

  console.log(`\n✅ ${updates.length}개 항목 업데이트 완료!`);
}

// 메인 실행
function main() {
  const args = process.argv.slice(2);
  const type = args[0] || 'job';
  const imageDir = args[1] || path.join(__dirname, '../public/images/generated');

  if (!fs.existsSync(imageDir)) {
    console.error(`❌ 이미지 디렉토리가 없습니다: ${imageDir}`);
    process.exit(1);
  }

  console.log('🚀 이미지 업로드 시작...\n');
  console.log(`설정:`);
  console.log(`- 타입: ${type}`);
  console.log(`- 이미지 디렉토리: ${imageDir}\n`);

  uploadLocalImagesToDB(type, imageDir);
}

if (require.main === module) {
  main();
}

module.exports = { uploadLocalImagesToDB };




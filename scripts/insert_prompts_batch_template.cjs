/**
 * 배치 N 프롬프트 삽입 템플릿
 * 
 * 사용법:
 * 1. 이 파일을 복사해서 insert_prompts_batch{N}.cjs로 저장
 * 2. BATCH_NUMBER를 해당 배치 번호로 변경
 * 3. prompts 배열에 프롬프트 추가
 * 4. node scripts/insert_prompts_batch{N}.cjs 실행
 */

const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');

// ========================================
// 설정: 배치 번호 변경
// ========================================
const BATCH_NUMBER = 1;  // ← 변경하세요!

// ========================================
// 배치 파일에서 직업 목록 로드
// ========================================
const batchFilePath = path.resolve(__dirname, `batch_${BATCH_NUMBER}_jobs.json`);
if (!fs.existsSync(batchFilePath)) {
  console.error(`❌ 배치 파일을 찾을 수 없습니다: ${batchFilePath}`);
  process.exit(1);
}

const jobs = JSON.parse(fs.readFileSync(batchFilePath, 'utf-8'));
console.log(`📋 배치 ${BATCH_NUMBER}: ${jobs.length}개 직업`);
jobs.forEach((job, i) => {
  console.log(`  ${i + 1}. ${job.name} (${job.name_en})`);
});

// ========================================
// 프롬프트 정의 (여기에 추가!)
// ========================================
const prompts = [
  // 예시:
  // {
  //   slug: "방수원",
  //   prompt: `A small cute baby beaver with tiny teeth, big round glossy eyes, soft rounded cheeks, short limbs, light-brown fluffy fur and a creamy belly, drawn in simple 2D cartoon style, wearing waterproofing protective gear and safety boots, actively applying waterproof coating with spray equipment and sealant tools in a construction waterproofing site surrounded by waterproof membranes, sealing materials, application tools, and construction documentation, the beaver appearing very small at about 12% of the frame, positioned naturally in the foreground, rendered in 2D stylized realism with soft painterly shading, gentle gradients, atmospheric haze, cinematic rim light using a dark-mode palette of deep navy, muted violet, soft teal glow accents with rich background depth.`
  // },
  // ... 계속 추가
];

// ========================================
// 실행
// ========================================
async function insertPrompts() {
  if (prompts.length === 0) {
    console.log('\n⚠️ 프롬프트가 비어있습니다. prompts 배열에 프롬프트를 추가하세요.');
    console.log('\n📝 프롬프트 형식:');
    console.log(`{
  slug: "직업-슬러그",
  prompt: \`프롬프트 내용...\`
}`);
    return;
  }

  console.log(`\n🔄 ${prompts.length}개 프롬프트 삽입 중...`);

  // SQL 파일 생성
  const updates = prompts.map(item => {
    const escapedPrompt = item.prompt.replace(/'/g, "''");
    return `UPDATE jobs SET image_prompt = '${escapedPrompt}' WHERE slug = '${item.slug}';`;
  });

  const sqlContent = `-- 배치 ${BATCH_NUMBER}: ${prompts.length}개 프롬프트 삽입\n${updates.join('\n')}`;
  const sqlFilePath = `insert_batch${BATCH_NUMBER}_prompts.sql`;
  fs.writeFileSync(sqlFilePath, sqlContent);

  // 데이터베이스 업데이트
  execSync(`npx wrangler d1 execute careerwiki-db --local --file ${sqlFilePath}`, {
    stdio: 'inherit',
    cwd: process.cwd()
  });

  // SQL 파일 삭제
  fs.unlinkSync(sqlFilePath);

  console.log(`\n✅ 배치 ${BATCH_NUMBER} 프롬프트 삽입 완료!`);
  console.log(`\n💡 이미지 생성하려면:`);
  console.log(`   node scripts/generate_all_remaining_images.cjs`);
}

insertPrompts().catch(console.error);


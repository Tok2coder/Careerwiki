const fs = require('fs');
const { execSync } = require('child_process');
const path = require('path');

// ComfyUI API 설정 (환경변수 또는 설정 파일에서 읽기)
const COMFYUI_API_URL = process.env.COMFYUI_API_URL || 'http://127.0.0.1:8188';
const IMAGE_OUTPUT_DIR = process.env.IMAGE_OUTPUT_DIR || path.join(__dirname, '../public/images/generated');
const BATCH_SIZE = parseInt(process.env.BATCH_SIZE) || 10;

// 이미지 저장 디렉토리 생성
if (!fs.existsSync(IMAGE_OUTPUT_DIR)) {
  fs.mkdirSync(IMAGE_OUTPUT_DIR, { recursive: true });
}

/**
 * ComfyUI API를 통해 이미지 생성
 * @param {string} prompt - 이미지 생성 프롬프트
 * @param {string} jobId - 직업/전공 ID (파일명용)
 * @param {string} type - 'job' 또는 'major'
 * @returns {Promise<string>} 생성된 이미지 파일 경로
 */
async function generateImageWithComfyUI(prompt, jobId, type = 'job') {
  try {
    // ComfyUI API 워크플로우 JSON 생성
    // Z-Image Turbo를 사용하는 워크플로우
    const workflow = {
      "1": {
        "inputs": {
          "text": prompt,
          "clip": ["4", 0]
        },
        "class_type": "CLIPTextEncode",
        "_meta": { "title": "CLIP Text Encode (Prompt)" }
      },
      "2": {
        "inputs": {
          "text": "",
          "clip": ["4", 0]
        },
        "class_type": "CLIPTextEncode",
        "_meta": { "title": "CLIP Text Encode (Negative)" }
      },
      "3": {
        "inputs": {
          "seed": Math.floor(Math.random() * 1000000),
          "steps": 20,
          "cfg": 7,
          "sampler_name": "euler",
          "scheduler": "normal",
          "denoise": 1,
          "model": ["4", 0],
          "positive": ["1", 0],
          "negative": ["2", 0],
          "latent_image": ["5", 0]
        },
        "class_type": "KSampler",
        "_meta": { "title": "KSampler" }
      },
      "4": {
        "inputs": {
          "model_name": "z_image_turbo.safetensors"
        },
        "class_type": "CheckpointLoaderSimple",
        "_meta": { "title": "Load Checkpoint" }
      },
      "5": {
        "inputs": {
          "width": 1200,
          "height": 675,
          "batch_size": 1
        },
        "class_type": "EmptyLatentImage",
        "_meta": { "title": "Empty Latent Image" }
      },
      "6": {
        "inputs": {
          "filename_prefix": `${type}_${jobId}`,
          "images": ["3", 0]
        },
        "class_type": "SaveImage",
        "_meta": { "title": "Save Image" }
      }
    };

    // ComfyUI API에 워크플로우 제출
    const queueResponse = await fetch(`${COMFYUI_API_URL}/prompt`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({ prompt: workflow })
    });

    if (!queueResponse.ok) {
      throw new Error(`ComfyUI API error: ${queueResponse.statusText}`);
    }

    const queueData = await queueResponse.json();
    const promptId = queueData.prompt_id;

    // 이미지 생성 완료 대기 (폴링)
    let imageReady = false;
    let attempts = 0;
    const maxAttempts = 60; // 최대 5분 대기 (5초 간격)

    while (!imageReady && attempts < maxAttempts) {
      await new Promise(resolve => setTimeout(resolve, 5000)); // 5초 대기

      const historyResponse = await fetch(`${COMFYUI_API_URL}/history/${promptId}`);
      if (historyResponse.ok) {
        const history = await historyResponse.json();
        if (history[promptId] && history[promptId].status?.completed) {
          imageReady = true;
        }
      }
      attempts++;
    }

    if (!imageReady) {
      throw new Error('Image generation timeout');
    }

    // 생성된 이미지 다운로드
    const imageResponse = await fetch(`${COMFYUI_API_URL}/view?filename=${type}_${jobId}_00001_.png`);
    if (!imageResponse.ok) {
      throw new Error('Failed to download generated image');
    }

    const imageBuffer = await imageResponse.arrayBuffer();
    const outputPath = path.join(IMAGE_OUTPUT_DIR, `${type}_${jobId}_v1.webp`);
    
    // PNG를 WebP로 변환 (sharp 또는 다른 라이브러리 필요)
    // 여기서는 일단 PNG로 저장
    const pngPath = outputPath.replace('.webp', '.png');
    fs.writeFileSync(pngPath, Buffer.from(imageBuffer));

    return pngPath;
  } catch (error) {
    console.error(`❌ 이미지 생성 실패 (${jobId}):`, error.message);
    throw error;
  }
}

/**
 * 데이터베이스에서 이미지가 없는 항목들을 가져와서 이미지 생성
 * @param {string} type - 'job' 또는 'major'
 * @param {number} limit - 처리할 항목 수
 * @param {number} offset - 시작 위치
 */
async function processBatch(type, limit = BATCH_SIZE, offset = 0) {
  try {
    console.log(`📊 ${type} 배치 처리 시작 (limit: ${limit}, offset: ${offset})...`);

    // 데이터베이스에서 이미지가 없는 항목 조회
    const query = `SELECT id, name, name_en, image_prompt, slug 
                   FROM ${type}s 
                   WHERE name_en IS NOT NULL 
                     AND name_en != '' 
                     AND image_prompt IS NOT NULL 
                     AND image_prompt != ''
                     AND (image_url IS NULL OR image_url = '')
                   ORDER BY id 
                   LIMIT ${limit} OFFSET ${offset}`;

    const result = execSync(
      `npx wrangler d1 execute careerwiki-db --local --command "${query.replace(/"/g, '\\"')}"`,
      { encoding: 'utf8', cwd: process.cwd() }
    );

    // JSON 파싱
    const jsonStart = result.indexOf('[');
    const jsonEnd = result.lastIndexOf(']') + 1;
    if (jsonStart === -1 || jsonEnd === 0) {
      console.log(`✅ 더 이상 처리할 ${type}가 없습니다.`);
      return { processed: 0, failed: 0 };
    }

    const jsonData = result.substring(jsonStart, jsonEnd);
    const items = JSON.parse(jsonData).results || [];

    if (items.length === 0) {
      console.log(`✅ 더 이상 처리할 ${type}가 없습니다.`);
      return { processed: 0, failed: 0 };
    }

    console.log(`📝 ${items.length}개 ${type} 이미지 생성 시작...`);

    let processed = 0;
    let failed = 0;
    const updates = [];

    for (const item of items) {
      try {
        console.log(`🎨 생성 중: ${item.name} (${item.name_en})`);
        
        // 이미지 생성
        const imagePath = await generateImageWithComfyUI(
          item.image_prompt,
          item.id.replace(/[^a-zA-Z0-9]/g, '_'),
          type
        );

        // 이미지 URL 생성 (로컬 파일 경로 또는 CDN URL)
        // 여기서는 로컬 파일 경로를 상대 경로로 변환
        const relativePath = path.relative(
          path.join(__dirname, '../public'),
          imagePath
        ).replace(/\\/g, '/');
        const imageUrl = `/${relativePath}`;

        // Alt text 생성
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

        processed++;
        console.log(`✅ 완료: ${item.name} -> ${imageUrl}`);
      } catch (error) {
        failed++;
        console.error(`❌ 실패: ${item.name} - ${error.message}`);
      }
    }

    // 데이터베이스 업데이트
    if (updates.length > 0) {
      const sqlUpdates = updates.map(u => {
        const escapedUrl = u.imageUrl.replace(/'/g, "''");
        const escapedAlt = u.imageAlt.replace(/'/g, "''");
        const escapedCredits = u.imageCredits.replace(/'/g, "''");
        return `UPDATE ${type}s SET image_url = '${escapedUrl}', image_alt = '${escapedAlt}', image_credits = '${escapedCredits}', image_style_version = '${u.imageStyleVersion}' WHERE id = '${u.id}';`;
      });

      const sqlFile = `update_${type}s_images_batch_${Math.floor(offset / limit) + 1}.sql`;
      const sqlContent = `-- Batch ${Math.floor(offset / limit) + 1}: Update images for ${updates.length} ${type}s\n${sqlUpdates.join('\n')}`;
      fs.writeFileSync(sqlFile, sqlContent);

      console.log(`🔄 데이터베이스 업데이트 중...`);
      execSync(`npx wrangler d1 execute careerwiki-db --local --file ${sqlFile}`, {
        stdio: 'inherit',
        cwd: process.cwd()
      });

      // 임시 SQL 파일 삭제
      if (fs.existsSync(sqlFile)) {
        fs.unlinkSync(sqlFile);
      }
    }

    console.log(`\n✅ 배치 완료: ${processed}개 성공, ${failed}개 실패\n`);
    return { processed, failed };
  } catch (error) {
    console.error(`❌ 배치 처리 실패:`, error.message);
    return { processed: 0, failed: 0 };
  }
}

// 메인 실행
async function main() {
  const args = process.argv.slice(2);
  const type = args[0] || 'job'; // 'job' 또는 'major'
  const limit = parseInt(args[1]) || BATCH_SIZE;
  const offset = parseInt(args[2]) || 0;

  console.log('🚀 이미지 생성 시작...\n');
  console.log(`설정:`);
  console.log(`- 타입: ${type}`);
  console.log(`- 배치 크기: ${limit}`);
  console.log(`- 시작 위치: ${offset}`);
  console.log(`- ComfyUI API: ${COMFYUI_API_URL}`);
  console.log(`- 출력 디렉토리: ${IMAGE_OUTPUT_DIR}\n`);

  // ComfyUI 연결 확인
  try {
    const healthCheck = await fetch(`${COMFYUI_API_URL}/system_stats`);
    if (!healthCheck.ok) {
      throw new Error('ComfyUI 서버에 연결할 수 없습니다.');
    }
    console.log('✅ ComfyUI 서버 연결 확인\n');
  } catch (error) {
    console.error('❌ ComfyUI 서버 연결 실패:', error.message);
    console.error('💡 ComfyUI 서버가 실행 중인지 확인하세요.');
    console.error(`   예: python main.py --listen 127.0.0.1 --port 8188\n`);
    process.exit(1);
  }

  await processBatch(type, limit, offset);
  console.log('🎉 이미지 생성 완료!');
}

if (require.main === module) {
  main().catch(console.error);
}

module.exports = { generateImageWithComfyUI, processBatch };




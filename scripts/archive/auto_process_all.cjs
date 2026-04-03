const fs = require('fs');
const { execSync } = require('child_process');

// Job-specific actions and environments
function generatePrompt(jobNameEn) {
  const jobMappings = {
    'maker': { action: 'actively crafting and assembling', environment: 'woodworking shop filled with saws, hammers, drills, wood planks, measuring tools, and carpentry supplies' },
    'repairer': { action: 'actively repairing and refinishing', environment: 'maintenance workshop filled with tools, repair equipment, spare parts, and workbenches' },
    'assembler': { action: 'actively assembling and inspecting', environment: 'production facility filled with conveyor belts, quality control stations, assembly tools, and finished products' },
    'technician': { action: 'actively calibrating and adjusting', environment: 'technical workshop filled with specialized equipment, testing devices, diagnostic tools, and precision instruments' },
    'engineer': { action: 'actively designing and analyzing', environment: 'engineering office filled with computer workstations, technical drawings, blueprints, and prototype models' },
    'mechanic': { action: 'actively repairing and servicing', environment: 'automotive garage filled with tools, vehicle parts, diagnostic equipment, and service bays' },
    'electrician': { action: 'actively installing and wiring', environment: 'electrical workshop filled with cables, circuit breakers, testing equipment, and electrical panels' },
    'operator': { action: 'actively operating machinery', environment: 'industrial facility filled with control panels, machinery, monitoring systems, and operational equipment' },
    'developer': { action: 'actively coding and debugging', environment: 'modern office filled with computer screens, keyboards, programming books, coffee mugs, and ergonomic workstations' },
    'analyst': { action: 'actively analyzing data and reports', environment: 'data center filled with servers, multiple monitors displaying analytics, charts, and technical documentation' },
    'specialist': { action: 'actively operating specialized equipment', environment: 'high-tech laboratory filled with advanced equipment, control panels, LED screens, and technical instruments' },
    'administrator': { action: 'actively managing and monitoring', environment: 'server room filled with computer racks, monitoring screens, networking equipment, and control panels' },
    'designer': { action: 'actively creating and designing', environment: 'creative studio filled with computer workstations, design software, inspiration boards, and digital tablets' },
    'programmer': { action: 'actively coding and testing', environment: 'software development office filled with multiple screens, keyboards, coding books, and development tools' },
    'nurse': { action: 'actively caring for patients', environment: 'hospital ward filled with medical equipment, patient beds, monitoring devices, and medical supplies' },
    'therapist': { action: 'actively treating and assisting', environment: 'rehabilitation center filled with therapy equipment, exercise machines, treatment tables, and medical supplies' },
    'technologist': { action: 'actively operating medical equipment', environment: 'medical laboratory filled with diagnostic machines, test tubes, microscopes, and analysis equipment' },
    'assistant': { action: 'actively supporting medical procedures', environment: 'medical office filled with examination tables, medical instruments, patient records, and care supplies' },
    'manager': { action: 'actively overseeing and directing', environment: 'professional office filled with desks, computers, meeting rooms, organizational charts, and business documents' },
    'clerk': { action: 'actively processing and organizing', environment: 'office environment filled with desks, filing cabinets, computers, printers, and administrative supplies' },
    'worker': { action: 'actively performing service duties', environment: 'service facility filled with specialized equipment, tools, supplies, and customer service areas' },
    'driver': { action: 'actively driving and navigating', environment: 'vehicle interior filled with steering wheels, dashboards, navigation systems, and transportation equipment' },
    'teacher': { action: 'actively teaching and guiding', environment: 'classroom filled with desks, educational materials, teaching aids, whiteboards, and learning resources' },
    'instructor': { action: 'actively demonstrating and training', environment: 'training facility filled with equipment, instructional materials, practice areas, and teaching supplies' },
    'artist': { action: 'actively creating artwork', environment: 'art studio filled with easels, paints, brushes, canvases, palettes, and artistic supplies' },
    'musician': { action: 'actively playing and performing', environment: 'music studio filled with musical instruments, recording equipment, sheet music, and audio gear' },
    'writer': { action: 'actively writing and creating', environment: 'writing studio filled with computers, notebooks, reference books, and creative materials' },
    'farmer': { action: 'actively tending and harvesting', environment: 'farm field filled with crops, farming equipment, irrigation systems, and agricultural tools' },
    'grower': { action: 'actively cultivating and harvesting', environment: 'greenhouse filled with plants, cultivation equipment, irrigation systems, and growing supplies' },
    'officer': { action: 'actively patrolling and enforcing', environment: 'public facility filled with security equipment, communication devices, official vehicles, and administrative areas' },
    'attorney': { action: 'actively researching and advising', environment: 'law office filled with legal books, case files, computers, meeting rooms, and legal documents' },
    'researcher': { action: 'actively analyzing data and reports', environment: 'data center filled with servers, multiple monitors displaying analytics, charts, and technical documentation' },
    'default': { action: 'actively performing professional duties', environment: 'professional workplace filled with relevant tools, equipment, and work materials' }
  };

  const jobLower = jobNameEn.toLowerCase();
  let matchedJob = jobMappings.default;

  for (const [key, value] of Object.entries(jobMappings)) {
    if (jobLower.includes(key) && key !== 'default') {
      matchedJob = value;
      break;
    }
  }

  return `A small cute baby beaver with tiny teeth, big round glossy eyes, soft rounded cheeks, short limbs, light-brown fluffy fur and a creamy belly, drawn in simple 2D cartoon style, ${matchedJob.action} in a ${matchedJob.environment}, the beaver appearing small at about 20% of the frame, rendered in 2D stylized realism with soft painterly shading, gentle gradients, atmospheric haze, cinematic rim light using a dark-mode palette of deep navy, muted violet, soft teal glow accents with rich background depth.`;
}

function processBatch(batchNum) {
  console.log(`\n📦 배치 ${batchNum} 처리 시작...`);

  // Extract data
  const dataFile = `batch${batchNum}_data.txt`;
  try {
    execSync(`npx wrangler d1 execute careerwiki --local --command "SELECT id, name, name_en FROM jobs WHERE name_en IS NOT NULL AND name_en != '' AND image_prompt IS NULL ORDER BY id LIMIT 100;" > ${dataFile}`, { stdio: 'pipe' });
  } catch (error) {
    console.log('⚠️  데이터 추출 실패 또는 더 이상 데이터 없음');
    return false;
  }

  // Parse data
  const rawData = fs.readFileSync(dataFile, 'utf8');
  const jsonStart = rawData.indexOf('[');
  const jsonEnd = rawData.lastIndexOf(']') + 1;
  
  if (jsonStart === -1 || jsonEnd === 0) {
    console.log('⚠️  유효한 데이터가 없습니다.');
    fs.unlinkSync(dataFile);
    return false;
  }

  const jsonData = rawData.substring(jsonStart, jsonEnd);
  let jobs;
  try {
    jobs = JSON.parse(jsonData).results;
  } catch (error) {
    console.log('⚠️  JSON 파싱 실패');
    fs.unlinkSync(dataFile);
    return false;
  }

  if (!jobs || jobs.length === 0) {
    console.log('✅ 모든 작업 완료!');
    fs.unlinkSync(dataFile);
    return false;
  }

  console.log(`📝 ${jobs.length}개 직업 프롬프트 생성 중...`);

  // Generate SQL
  const updates = jobs.map(job => {
    const prompt = generatePrompt(job.name_en);
    const escapedPrompt = prompt.replace(/'/g, "''");
    return `UPDATE jobs SET image_prompt = '${escapedPrompt}' WHERE id = '${job.id}';`;
  });

  const sqlFile = `update_jobs_batch${batchNum}.sql`;
  const sqlContent = `-- Batch ${batchNum}: Update image_prompt for ${jobs.length} jobs\n${updates.join('\n')}`;
  fs.writeFileSync(sqlFile, sqlContent);

  // Execute SQL
  console.log(`🔄 데이터베이스 업데이트 중...`);
  try {
    execSync(`npx wrangler d1 execute careerwiki --local --file ${sqlFile}`, { stdio: 'pipe' });
    console.log(`✅ 배치 ${batchNum} 완료! (${jobs.length}개)`);

    // Cleanup
    fs.unlinkSync(dataFile);
    fs.unlinkSync(sqlFile);

    // Progress check
    const progressResult = execSync(`npx wrangler d1 execute careerwiki --local --command "SELECT COUNT(*) as count FROM jobs WHERE image_prompt IS NOT NULL AND image_prompt != '';"`, { encoding: 'utf8' });
    const countMatch = progressResult.match(/"count":\s*(\d+)/);
    if (countMatch) {
      const completed = parseInt(countMatch[1]);
      console.log(`📊 진행률: ${completed}/6947 (${((completed/6947)*100).toFixed(1)}%)`);
    }

    return true;
  } catch (error) {
    console.error(`❌ 배치 ${batchNum} 실행 실패:`, error.message);
    return false;
  }
}

// Main loop
let batchNum = 2;
let consecutiveErrors = 0;
const maxErrors = 3;

console.log('🚀 자동 배치 처리 시작 (멈추지 않고 계속 진행)...\n');

while (consecutiveErrors < maxErrors) {
  const success = processBatch(batchNum);
  
  if (!success) {
    consecutiveErrors++;
    if (consecutiveErrors >= maxErrors) {
      console.log('\n⚠️  연속 오류로 인해 처리 중단');
      break;
    }
  } else {
    consecutiveErrors = 0;
  }

  batchNum++;
  
  // Small delay to avoid overwhelming the system
  if (success) {
    // Continue immediately
  }
}

console.log('\n🎉 배치 처리 완료!');

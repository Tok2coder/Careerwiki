const fs = require('fs');
const { execSync } = require('child_process');

function generateMajorPrompt(majorNameEn) {
  // Major-specific actions and environments (educational/academic focus)
  const majorMappings = {
    // Engineering & Technology
    'engineering': { action: 'actively studying and designing', environment: 'engineering laboratory filled with computer workstations, technical drawings, prototype models, and engineering equipment' },
    'computer': { action: 'actively coding and learning', environment: 'computer lab filled with multiple screens, keyboards, programming books, and development tools' },
    'software': { action: 'actively coding and debugging', environment: 'software development lab filled with computer screens, keyboards, programming books, and coding projects' },
    'network': { action: 'actively configuring and testing', environment: 'networking lab filled with servers, routers, cables, and network equipment' },
    'mechanical': { action: 'actively designing and analyzing', environment: 'mechanical engineering lab filled with machinery, tools, blueprints, and prototype models' },
    'electrical': { action: 'actively wiring and testing', environment: 'electrical engineering lab filled with circuits, testing equipment, and electrical components' },
    'chemical': { action: 'actively experimenting and analyzing', environment: 'chemistry laboratory filled with beakers, test tubes, chemical equipment, and safety gear' },
    'civil': { action: 'actively designing and planning', environment: 'civil engineering office filled with blueprints, scale models, surveying equipment, and construction plans' },
    'architecture': { action: 'actively designing and drafting', environment: 'architecture studio filled with drawing boards, scale models, design software, and architectural tools' },

    // Medical & Health
    'medicine': { action: 'actively studying and practicing', environment: 'medical school filled with anatomy models, medical textbooks, examination tables, and medical equipment' },
    'nursing': { action: 'actively learning and practicing', environment: 'nursing school filled with patient simulators, medical equipment, textbooks, and clinical practice areas' },
    'pharmacy': { action: 'actively studying and compounding', environment: 'pharmacy school filled with medication bottles, compounding equipment, pharmaceutical textbooks, and laboratory equipment' },
    'dentistry': { action: 'actively learning and practicing', environment: 'dental school filled with dental chairs, dental equipment, models, and clinical practice areas' },
    'therapy': { action: 'actively learning and practicing', environment: 'therapy training facility filled with therapy equipment, exercise machines, treatment tables, and educational materials' },

    // Business & Management
    'business': { action: 'actively studying and analyzing', environment: 'business school filled with case studies, financial charts, meeting rooms, and business simulation software' },
    'management': { action: 'actively learning and strategizing', environment: 'management classroom filled with organizational charts, business models, presentation screens, and case studies' },
    'economics': { action: 'actively analyzing and researching', environment: 'economics department filled with data charts, research papers, statistical software, and economic models' },
    'accounting': { action: 'actively calculating and analyzing', environment: 'accounting classroom filled with financial statements, calculators, accounting software, and tax documents' },
    'marketing': { action: 'actively creating and analyzing', environment: 'marketing studio filled with design software, market research data, advertising materials, and presentation tools' },

    // Arts & Design
    'art': { action: 'actively creating and studying', environment: 'art studio filled with easels, paints, brushes, canvases, and artistic supplies' },
    'design': { action: 'actively designing and creating', environment: 'design studio filled with computer workstations, design software, inspiration boards, and creative materials' },
    'music': { action: 'actively playing and learning', environment: 'music school filled with musical instruments, practice rooms, sheet music, and recording equipment' },
    'dance': { action: 'actively practicing and performing', environment: 'dance studio filled with mirrors, practice floors, sound systems, and performance spaces' },
    'theater': { action: 'actively rehearsing and performing', environment: 'theater school filled with stages, props, lighting equipment, and rehearsal spaces' },

    // Education
    'education': { action: 'actively teaching and learning', environment: 'education department filled with classrooms, teaching materials, educational technology, and learning resources' },
    'teaching': { action: 'actively learning and practicing', environment: 'teacher training facility filled with classrooms, educational materials, teaching aids, and practice areas' },

    // Science
    'science': { action: 'actively experimenting and researching', environment: 'science laboratory filled with microscopes, test tubes, scientific equipment, and research materials' },
    'biology': { action: 'actively studying and researching', environment: 'biology lab filled with microscopes, specimens, petri dishes, and biological equipment' },
    'chemistry': { action: 'actively experimenting and analyzing', environment: 'chemistry lab filled with beakers, test tubes, chemical compounds, and safety equipment' },
    'physics': { action: 'actively experimenting and calculating', environment: 'physics lab filled with experimental equipment, measurement devices, and physics models' },
    'mathematics': { action: 'actively solving and analyzing', environment: 'mathematics classroom filled with equations, mathematical models, calculators, and problem-solving materials' },

    // Language & Literature
    'language': { action: 'actively studying and practicing', environment: 'language lab filled with audio equipment, language learning software, textbooks, and practice materials' },
    'literature': { action: 'actively reading and analyzing', environment: 'literature classroom filled with books, literary texts, writing materials, and discussion areas' },
    'english': { action: 'actively studying and practicing', environment: 'English language classroom filled with textbooks, writing materials, language learning tools, and practice exercises' },
    'korean': { action: 'actively studying and analyzing', environment: 'Korean language classroom filled with textbooks, writing materials, and language learning resources' },

    // Social Sciences
    'psychology': { action: 'actively studying and researching', environment: 'psychology lab filled with research equipment, observation rooms, psychological tests, and study materials' },
    'sociology': { action: 'actively researching and analyzing', environment: 'sociology department filled with research papers, survey data, statistical software, and social research tools' },
    'history': { action: 'actively researching and studying', environment: 'history department filled with historical documents, maps, archives, and research materials' },
    'philosophy': { action: 'actively reading and discussing', environment: 'philosophy classroom filled with philosophical texts, discussion areas, and critical thinking materials' },

    // Agriculture & Life Sciences
    'agriculture': { action: 'actively studying and practicing', environment: 'agricultural school filled with farming equipment, plant specimens, soil samples, and agricultural tools' },
    'food': { action: 'actively learning and practicing', environment: 'culinary school filled with cooking equipment, ingredients, recipe books, and kitchen facilities' },
    'nutrition': { action: 'actively studying and analyzing', environment: 'nutrition lab filled with food samples, nutritional analysis equipment, and dietary planning materials' },

    // Default fallback
    'default': { action: 'actively studying and learning', environment: 'university classroom filled with desks, educational materials, textbooks, and learning resources' }
  };

  const majorLower = majorNameEn.toLowerCase();
  let matchedMajor = majorMappings.default;

  for (const [key, value] of Object.entries(majorMappings)) {
    if (majorLower.includes(key) && key !== 'default') {
      matchedMajor = value;
      break;
    }
  }

  return `A small cute baby beaver with tiny teeth, big round glossy eyes, soft rounded cheeks, short limbs, light-brown fluffy fur and a creamy belly, drawn in simple 2D cartoon style, ${matchedMajor.action} in a ${matchedMajor.environment}, the beaver appearing small at about 20% of the frame, rendered in 2D stylized realism with soft painterly shading, gentle gradients, atmospheric haze, cinematic rim light using a dark-mode palette of deep navy, muted violet, soft teal glow accents with rich background depth.`;
}

function processMajorBatch(batchNum) {
  const sqlFile = `update_majors_batch${batchNum}.sql`;

  try {
    console.log(`📊 전공 배치 ${batchNum}: 데이터 추출 중...`);
    const result = execSync(`npx wrangler d1 execute careerwiki-db --local --command "SELECT id, name, name_en FROM majors WHERE name_en IS NOT NULL AND name_en != '' AND (image_prompt IS NULL OR image_prompt = '') ORDER BY id LIMIT 100;"`, {
      encoding: 'utf8',
      cwd: process.cwd()
    });

    const jsonStart = result.indexOf('[');
    const jsonEnd = result.lastIndexOf(']') + 1;
    if (jsonStart === -1 || jsonEnd === 0) {
      console.log(`✅ 전공 배치 ${batchNum}: 더 이상 처리할 데이터가 없습니다.`);
      return false;
    }

    const jsonData = result.substring(jsonStart, jsonEnd);
    const majors = JSON.parse(jsonData).results;

    if (!majors || majors.length === 0) {
      console.log(`✅ 전공 배치 ${batchNum}: 더 이상 처리할 데이터가 없습니다.`);
      return false;
    }

    console.log(`📝 전공 배치 ${batchNum}: ${majors.length}개 전공 프롬프트 생성 중...`);

    const updates = majors.map(major => {
      const prompt = generateMajorPrompt(major.name_en);
      const escapedPrompt = prompt.replace(/'/g, "''");
      return `UPDATE majors SET image_prompt = '${escapedPrompt}' WHERE id = '${major.id}';`;
    });

    const sqlContent = `-- Major Batch ${batchNum}: Update image_prompt for ${majors.length} majors\n${updates.join('\n')}`;
    fs.writeFileSync(sqlFile, sqlContent);

    console.log(`🔄 전공 배치 ${batchNum}: 데이터베이스 업데이트 중...`);
    execSync(`npx wrangler d1 execute careerwiki-db --local --file ${sqlFile}`, {
      stdio: 'inherit',
      cwd: process.cwd()
    });

    if (fs.existsSync(sqlFile)) fs.unlinkSync(sqlFile);

    const progressResult = execSync(`npx wrangler d1 execute careerwiki-db --local --command "SELECT COUNT(*) as count FROM majors WHERE image_prompt IS NOT NULL AND image_prompt != '';"`, {
      encoding: 'utf8'
    });
    const countMatch = progressResult.match(/"count":\s*(\d+)/);
    if (countMatch) {
      const completed = parseInt(countMatch[1]);
      const total = 608;
      const percentage = ((completed / total) * 100).toFixed(1);
      console.log(`✅ 전공 배치 ${batchNum} 완료! 진행률: ${completed}/${total} (${percentage}%)\n`);
    } else {
      console.log(`✅ 전공 배치 ${batchNum} 완료! (${majors.length}개 처리)\n`);
    }

    return true;
  } catch (error) {
    console.error(`❌ 전공 배치 ${batchNum} 실패:`, error.message);
    return false;
  }
}

// Main loop for majors
let batchNum = 1;
let consecutiveErrors = 0;
const maxErrors = 3;

console.log('🚀 전공 자동 프롬프트 생성 시작...\n');

while (true) {
  const success = processMajorBatch(batchNum);
  
  if (!success) {
    consecutiveErrors++;
    if (consecutiveErrors >= maxErrors) {
      console.log('⚠️  연속 오류로 인해 중단합니다.');
      break;
    }
  } else {
    consecutiveErrors = 0;
  }

  batchNum++;
  
  if (!success) {
    break;
  }
}

console.log('🎉 모든 전공 배치 처리 완료!');




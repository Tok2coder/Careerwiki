const fs = require('fs');
const { execSync } = require('child_process');

/**
 * 수동으로 세심하게 만든 프롬프트 생성 함수
 * 각 직업의 특성을 분석하여 구체적인 액션과 환경을 매핑
 */
function generateDetailedPrompt(jobNameEn) {
  const jobName = jobNameEn.toLowerCase();

  // 기본 비버 스타일
  const baseStyle = "a small cute baby beaver with tiny teeth, big round glossy eyes, soft rounded cheeks, short limbs, light-brown fluffy fur and a creamy belly, drawn in simple 2D cartoon style";

  // 직업별 구체적인 액션과 환경 매핑
  const jobMappings = {
    // IT/기술직
    'software developer': {
      action: 'writing code on a dual-monitor workstation',
      environment: 'a modern software development office filled with computer screens displaying code editors, keyboards, coffee mugs, and agile methodology whiteboards'
    },
    'systems software developer': {
      action: 'debugging system architecture diagrams',
      environment: 'a computer lab equipped with high-performance servers, network switches, and system monitoring dashboards'
    },
    'web developer': {
      action: 'implementing responsive web layouts',
      environment: 'a creative coding workspace surrounded by multiple browser windows, design mockups, and version control interfaces'
    },
    'mobile app developer': {
      action: 'testing app interfaces on mobile devices',
      environment: 'a smartphone testing station with various mobile devices, debugging tools, and user interface wireframes'
    },
    'game developer': {
      action: 'programming game physics engines',
      environment: 'a game development studio filled with gaming consoles, 3D modeling software, and character animation tools'
    },
    'data scientist': {
      action: 'analyzing complex data visualizations',
      environment: 'a data analytics center equipped with large monitors displaying statistical charts, machine learning models, and database servers'
    },
    'database administrator': {
      action: 'optimizing database query performance',
      environment: 'a server room filled with database servers, backup systems, and performance monitoring displays'
    },
    'network engineer': {
      action: 'configuring network routing equipment',
      environment: 'a network operations center with routers, switches, cable management systems, and network monitoring panels'
    },
    'security engineer': {
      action: 'monitoring intrusion detection systems',
      environment: 'a cybersecurity command center equipped with security dashboards, firewall appliances, and threat analysis tools'
    },
    'devops engineer': {
      action: 'managing container orchestration',
      environment: 'a cloud infrastructure workspace with Kubernetes dashboards, CI/CD pipelines, and deployment automation tools'
    },

    // 의료직
    'registered nurse': {
      action: 'administering patient medications',
      environment: 'a hospital ward equipped with medication carts, patient monitoring systems, and medical supply stations'
    },
    'doctor': {
      action: 'examining patient X-rays',
      environment: 'a medical examination room furnished with diagnostic equipment, patient charts, and medical examination tables'
    },
    'pharmacist': {
      action: 'compounding prescription medications',
      environment: 'a pharmacy lab equipped with pill counters, prescription bottles, and pharmaceutical compounding equipment'
    },
    'physical therapist': {
      action: 'guiding patient rehabilitation exercises',
      environment: 'a therapy gym furnished with exercise equipment, treatment tables, and rehabilitation assessment tools'
    },
    'radiologic technologist': {
      action: 'positioning patients for MRI scans',
      environment: 'a medical imaging suite equipped with MRI machines, radiation protection barriers, and imaging control consoles'
    },
    'dental hygienist': {
      action: 'performing dental cleanings',
      environment: 'a dental operatory equipped with dental chairs, ultrasonic scalers, and sterilization equipment'
    },
    'medical laboratory scientist': {
      action: 'analyzing blood samples',
      environment: 'a clinical laboratory equipped with microscopes, centrifuges, and automated analyzers'
    },

    // 교육직
    'teacher': {
      action: 'writing lesson plans on a chalkboard',
      environment: 'a classroom filled with student desks, educational posters, teaching materials, and interactive whiteboards'
    },
    'professor': {
      action: 'lecturing from presentation slides',
      environment: 'a university lecture hall equipped with podiums, projectors, academic journals, and student seating'
    },
    'school counselor': {
      action: 'conducting student career guidance sessions',
      environment: 'a counseling office furnished with psychological assessment tools, student files, and educational planning materials'
    },
    'librarian': {
      action: 'cataloging new book acquisitions',
      environment: 'a library reference desk surrounded by bookshelves, computer catalogs, and library management systems'
    },

    // 엔지니어링
    'mechanical engineer': {
      action: 'designing machine components in CAD software',
      environment: 'an engineering design studio equipped with CAD workstations, prototyping tools, and technical drawing tables'
    },
    'electrical engineer': {
      action: 'soldering circuit board components',
      environment: 'an electronics laboratory equipped with oscilloscopes, soldering stations, and circuit testing equipment'
    },
    'civil engineer': {
      action: 'reviewing structural blueprints',
      environment: 'a construction project office filled with architectural drawings, building specifications, and project management software'
    },
    'chemical engineer': {
      action: 'monitoring industrial chemical processes',
      environment: 'a chemical processing plant control room with reactor vessels, piping systems, and process control panels'
    },
    'aerospace engineer': {
      action: 'analyzing aircraft structural integrity',
      environment: 'an aerospace design facility equipped with wind tunnel models, structural analysis software, and aviation technical manuals'
    },

    // 금융/비즈니스
    'accountant': {
      action: 'preparing financial statements',
      environment: 'a corporate accounting office equipped with calculators, financial software displays, and tax preparation documents'
    },
    'financial analyst': {
      action: 'analyzing stock market trends',
      environment: 'an investment banking floor with multiple computer screens displaying financial charts, trading platforms, and market data'
    },
    'bank teller': {
      action: 'processing customer transactions',
      environment: 'a bank teller station equipped with cash registers, check scanners, and customer service terminals'
    },
    'insurance agent': {
      action: 'explaining policy benefits to clients',
      environment: 'an insurance agency office furnished with policy documents, actuarial tables, and client consultation areas'
    },

    // 법조계
    'attorney': {
      action: 'presenting legal arguments in court',
      environment: 'a courtroom furnished with judge benches, legal podiums, case law books, and court reporting equipment'
    },
    'judge': {
      action: 'presiding over legal proceedings',
      environment: 'a judicial chamber equipped with gavels, legal codes, court documents, and judicial robes'
    },
    'paralegal': {
      action: 'organizing case evidence files',
      environment: 'a legal office equipped with file cabinets, legal research databases, and document management systems'
    },

    // 건설/제조
    'construction worker': {
      action: 'operating heavy machinery equipment',
      environment: 'a construction site equipped with bulldozers, cranes, safety harnesses, and building materials'
    },
    'electrician': {
      action: 'installing electrical wiring systems',
      environment: 'a residential construction site with electrical panels, wire spools, and electrical testing equipment'
    },
    'plumber': {
      action: 'repairing pipe fittings and valves',
      environment: 'a plumbing service van equipped with pipe wrenches, pipe cutters, and plumbing repair tools'
    },
    'carpenter': {
      action: 'measuring and cutting lumber',
      environment: 'a woodworking shop equipped with saws, measuring tools, woodworking benches, and lumber stacks'
    },
    'welder': {
      action: 'fusing metal components with arc welding',
      environment: 'a metal fabrication shop equipped with welding helmets, arc welders, and metal cutting equipment'
    },

    // 서비스직
    'chef': {
      action: 'preparing gourmet sauces',
      environment: 'a professional kitchen equipped with gas ranges, culinary knives, ingredient stations, and cooking ventilation systems'
    },
    'waiter': {
      action: 'taking customer orders on a tablet',
      environment: 'a restaurant dining area with tables, menus, point-of-sale systems, and beverage service stations'
    },
    'hotel manager': {
      action: 'overseeing front desk operations',
      environment: 'a hotel lobby equipped with reservation systems, concierge desks, and guest service terminals'
    },
    'retail sales associate': {
      action: 'assisting customers with product selections',
      environment: 'a retail store sales floor equipped with product displays, cash registers, and inventory management systems'
    },

    // 예술/디자인
    'graphic designer': {
      action: 'creating digital illustrations',
      environment: 'a creative design studio equipped with graphic tablets, design software interfaces, and color calibration monitors'
    },
    'photographer': {
      action: 'adjusting camera settings for portraits',
      environment: 'a photography studio equipped with professional cameras, lighting equipment, and backdrop systems'
    },
    'architect': {
      action: 'developing building floor plans',
      environment: 'an architectural drafting office equipped with drafting tables, scale rulers, and architectural modeling software'
    },
    'fashion designer': {
      action: 'sketching clothing design concepts',
      environment: 'a fashion design studio furnished with sewing machines, fabric samples, design sketchbooks, and mannequins'
    },

    // 과학/연구
    'research scientist': {
      action: 'conducting laboratory experiments',
      environment: 'a research laboratory equipped with microscopes, test tubes, analytical instruments, and laboratory notebooks'
    },
    'environmental scientist': {
      action: 'collecting water samples for analysis',
      environment: 'a field research station equipped with sampling equipment, GPS devices, and environmental monitoring tools'
    },
    'biologist': {
      action: 'examining microscope slides',
      environment: 'a biology laboratory equipped with compound microscopes, specimen slides, and biological research equipment'
    },

    // 운송/물류
    'truck driver': {
      action: 'navigating delivery routes on GPS systems',
      environment: 'a commercial truck cab equipped with navigation displays, communication radios, and cargo management systems'
    },
    'pilot': {
      action: 'monitoring flight instrument panels',
      environment: 'an aircraft cockpit equipped with control yokes, navigation displays, and flight management systems'
    },
    'train conductor': {
      action: 'operating train control systems',
      environment: 'a train locomotive cab equipped with throttle controls, brake systems, and signal communication equipment'
    },

    // 미디어/커뮤니케이션
    'journalist': {
      action: 'conducting interviews with recording equipment',
      environment: 'a newsroom equipped with recording devices, notepads, cameras, and news editing workstations'
    },
    'broadcast journalist': {
      action: 'presenting news segments on camera',
      environment: 'a television studio equipped with cameras, teleprompters, lighting equipment, and broadcast control rooms'
    },
    'film director': {
      action: 'directing actors on set',
      environment: 'a film production set equipped with movie cameras, lighting rigs, clapperboards, and production crew stations'
    },

    // 기타 전문직
    'real estate agent': {
      action: 'showing property listings to clients',
      environment: 'a real estate office equipped with property listing displays, contract documents, and client consultation areas'
    },
    'human resources manager': {
      action: 'conducting employee performance reviews',
      environment: 'a corporate HR office furnished with employee files, performance evaluation forms, and talent management software'
    },
    'project manager': {
      action: 'updating project timelines on whiteboards',
      environment: 'a project management office equipped with Gantt charts, project planning software, and team collaboration tools'
    }
  };

  // 직업명에서 키워드를 추출하여 매핑 찾기
  let matchedJob = null;
  for (const [key, value] of Object.entries(jobMappings)) {
    if (jobName.includes(key) || key.split(' ').some(word => jobName.includes(word))) {
      matchedJob = value;
      break;
    }
  }

  // 매칭되는 직업이 없으면 기본값 사용
  if (!matchedJob) {
    matchedJob = {
      action: 'performing professional duties',
      environment: 'a professional workplace filled with relevant tools, equipment, and work materials'
    };
  }

  // 프레임 크기 랜덤 선택 (15-25%)
  const frameSize = Math.floor(Math.random() * 11) + 15; // 15-25 사이 랜덤

  // 최종 프롬프트 조합
  return `${baseStyle}, ${matchedJob.action} in ${matchedJob.environment}, the beaver appearing small at about ${frameSize}% of the frame, rendered in 2D stylized realism with soft painterly shading, gentle gradients, atmospheric haze, cinematic rim light using a dark-mode palette of deep navy, muted violet, soft teal glow accents with rich background depth.`;
}

/**
 * 배치 단위로 프롬프트 생성 및 저장
 */
function processBatch(batchNum, batchSize = 100) {
  console.log(`📊 배치 ${batchNum}: 데이터 추출 중...`);

  try {
    // 남은 직업들 조회
    const result = execSync(`npx wrangler d1 execute careerwiki --local --command "SELECT id, name, name_en FROM jobs WHERE name_en IS NOT NULL AND name_en != '' AND (image_prompt IS NULL OR image_prompt = '') ORDER BY id LIMIT ${batchSize};"`, {
      encoding: 'utf8',
      cwd: process.cwd()
    });

    const jsonStart = result.indexOf('[');
    const jsonEnd = result.lastIndexOf(']') + 1;
    const jsonData = result.substring(jsonStart, jsonEnd);
    const parsed = JSON.parse(jsonData);
    const items = Array.isArray(parsed) ? parsed[0]?.results : parsed.results || [];

    if (!items || items.length === 0) {
      console.log(`✅ 모든 배치 완료!`);
      return false;
    }

    console.log(`📝 배치 ${batchNum}: ${items.length}개 세부 프롬프트 생성 중...`);

    const updates = items.map(item => {
      const prompt = generateDetailedPrompt(item.name_en);
      const escapedPrompt = prompt.replace(/'/g, "''");
      return `UPDATE jobs SET image_prompt = '${escapedPrompt}' WHERE id = '${item.id}';`;
    });

    // SQL 파일 생성 및 실행
    const sqlFile = `update_jobs_detailed_batch${batchNum}.sql`;
    const sqlContent = `-- 세부 프롬프트 배치 ${batchNum}: ${items.length}개 직업 업데이트\n${updates.join('\n')}`;
    fs.writeFileSync(sqlFile, sqlContent);

    console.log(`🔄 배치 ${batchNum}: 데이터베이스 업데이트 중...`);
    execSync(`npx wrangler d1 execute careerwiki --local --file ${sqlFile}`, {
      stdio: 'inherit',
      cwd: process.cwd()
    });

    // SQL 파일 삭제
    if (fs.existsSync(sqlFile)) fs.unlinkSync(sqlFile);

    // 진행 상황 확인
    const progressResult = execSync(`npx wrangler d1 execute careerwiki --local --command "SELECT COUNT(*) as count FROM jobs WHERE image_prompt IS NOT NULL AND image_prompt != '';"`, {
      encoding: 'utf8'
    });
    const countMatch = progressResult.match(/"count":\s*(\d+)/);
    if (countMatch) {
      const completed = parseInt(countMatch[1]);
      const total = 6947;
      const percentage = ((completed / total) * 100).toFixed(1);
      console.log(`✅ 배치 ${batchNum} 완료! 진행률: ${completed}/${total} (${percentage}%) - ${items.length}개 처리\n`);
    }

    return true;
  } catch (error) {
    console.error(`❌ 배치 ${batchNum} 실패:`, error.message);
    return false;
  }
}

// 메인 실행
if (require.main === module) {
  const args = process.argv.slice(2);
  const batchNum = parseInt(args[0]) || 1;
  const batchSize = parseInt(args[1]) || 100;

  console.log(`🚀 세부 프롬프트 생성 배치 ${batchNum} 시작...\n`);
  console.log(`설정: 배치 크기 ${batchSize}개\n`);

  processBatch(batchNum, batchSize);
}

module.exports = { generateDetailedPrompt, processBatch };

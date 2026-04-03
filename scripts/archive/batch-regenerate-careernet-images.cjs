/**
 * 커리어넷 신규 직업 75개 이미지 일괄 재생성 스크립트
 *
 * 각 직업별 구체적인 환경/의상/동작 묘사 프롬프트로 이미지 생성
 * Evolink z-image-turbo → R2 업로드 (remote) → DB 업데이트
 *
 * 사용법: node scripts/batch-regenerate-careernet-images.cjs
 */

const path = require('path');
const fs = require('fs');
const { execSync } = require('child_process');

// .dev.vars에서 API 키 읽기 (워크트리 또는 메인 프로젝트 디렉토리)
const devVarsPath = (() => {
  const candidates = [
    path.resolve(__dirname, '../.dev.vars'),           // 워크트리 내
    path.resolve(__dirname, '../../../../../.dev.vars'), // 워크트리 → 메인 (5단계)
    path.resolve(__dirname, '../../../../.dev.vars'),   // 4단계
    'C:/Users/PC/Careerwiki/.dev.vars'                  // 절대 경로 폴백
  ];
  for (const p of candidates) {
    if (fs.existsSync(p)) return p;
  }
  return candidates[0]; // 없으면 에러 발생하게
})();
const devVars = fs.readFileSync(devVarsPath, 'utf-8');
const apiKeyMatch = devVars.match(/EVOLINK_API_KEY=(.+)/);
if (!apiKeyMatch) {
  console.error('❌ EVOLINK_API_KEY를 .dev.vars에서 찾을 수 없습니다.');
  process.exit(1);
}
const API_KEY = apiKeyMatch[1].trim();

// 임시 디렉토리
const TEMP_DIR = path.resolve(__dirname, '../temp_images');
if (!fs.existsSync(TEMP_DIR)) {
  fs.mkdirSync(TEMP_DIR, { recursive: true });
}

// 진행 상황 파일 (재시작 시 건너뛰기용)
const PROGRESS_FILE = path.resolve(__dirname, '../temp_images/careernet-progress.json');
function loadProgress() {
  if (fs.existsSync(PROGRESS_FILE)) {
    return JSON.parse(fs.readFileSync(PROGRESS_FILE, 'utf-8'));
  }
  return { completed: [], failed: [] };
}
function saveProgress(progress) {
  fs.writeFileSync(PROGRESS_FILE, JSON.stringify(progress, null, 2));
}

// BASE 프롬프트 패턴
const BASE = (clothing, action, env) =>
  `A small cute baby beaver with tiny teeth, big round glossy eyes, soft rounded cheeks, short limbs, light-brown fluffy fur and a creamy belly, drawn in simple 2D cartoon style, ${clothing}, ${action}, ${env}, the beaver appearing very small at about 12% of the frame, positioned naturally in the foreground, rendered in 2D stylized realism with soft painterly shading, gentle gradients, atmospheric haze, cinematic rim light using a dark-mode palette of deep navy, muted violet, soft teal glow accents with rich background depth.`;

// 75개 직업별 구체적 프롬프트
const JOBS = [
  {
    slug: '의료장비기사',
    name: '의료장비기사',
    prompt: BASE(
      'wearing a light-blue medical technician uniform with an ID badge and latex gloves',
      'carefully calibrating a large MRI scanner control panel with a digital multimeter in hand',
      'inside a hospital equipment room filled with towering MRI and CT scan machines, monitor racks displaying waveform diagnostics, shelves of spare circuit boards and cable bundles, ventilation ducts overhead, and blue LED indicator lights blinking across multiple machines'
    )
  },
  {
    slug: '산업공학기술자',
    name: '산업공학기술자',
    prompt: BASE(
      'wearing a hard hat, reflective safety vest, and steel-toe boots with a clipboard tucked under one arm',
      'analyzing a large production line flowchart pinned to an industrial whiteboard while pointing with a laser pointer',
      'inside a vast factory floor with conveyor belts transporting mechanical parts, robotic arms welding metal frames, overhead cranes, process flow diagrams mounted on walls, and a glass-walled engineering office visible in the background'
    )
  },
  {
    slug: '농수산물중개인',
    name: '농수산물중개인',
    prompt: BASE(
      'wearing a waterproof apron and rubber boots with a price list clipboard in hand',
      'negotiating with buyers by gesturing toward crates of fresh produce and seafood at an early morning market auction',
      'inside a sprawling wholesale fish and vegetable market with rows of crushed-ice display tables piled with shrimp, tuna, cabbage, and daikon, auctioneer podiums, flashing price boards, forklift trucks moving pallets, and misty refrigerated air creating teal-lit haze throughout the hall'
    )
  },
  {
    slug: 'ux-디자인-컨설턴트',
    name: 'UX 디자인 컨설턴트',
    prompt: BASE(
      'wearing a stylish dark blazer with a small tablet computer in one hand and a stylus in the other',
      'mapping user journey flows on a large touchscreen wall display surrounded by colorful sticky-note wireframes',
      'inside a modern UX design studio with a wall-sized interactive whiteboard showing user flow diagrams, multiple curved monitors displaying mobile app prototypes in wireframe mode, a table covered with user research printouts and journey maps, and soft indirect lighting casting teal glow across design mockups'
    )
  },
  {
    slug: '도시-재생-전문가',
    name: '도시 재생 전문가',
    prompt: BASE(
      'wearing an architect\'s hard hat and rolled-up blueprints tucked under one arm, with a measuring tape on a belt clip',
      'examining a detailed urban renewal scale model on a large planning table while pointing to a dilapidated building section',
      'inside a city planning office overlooking a half-demolished urban district through a wide panoramic window, walls covered with before-and-after district maps, zoning overlays, and renovation timeline boards, architectural models of revitalized streetscapes displayed on pedestals throughout the room'
    )
  },
  {
    slug: '곤충-음식-개발자조리사',
    name: '곤충 음식 개발자·조리사',
    prompt: BASE(
      'wearing a white chef\'s coat, tall toque blanche, and food-safe gloves',
      'carefully plating a gourmet dish featuring protein-rich mealworm fritters and cricket powder garnish with tweezers',
      'inside a high-end culinary lab kitchen with stainless steel counters holding breeding terrariums of mealworms and crickets behind glass, dehydrating machines, a large industrial blender for insect flour, recipe notebooks, and teal-lit display shelves showcasing packaged insect snack products'
    )
  },
  {
    slug: '스마트-팜-구축가',
    name: '스마트 팜 구축가',
    prompt: BASE(
      'wearing a construction hard hat, cargo pants, and a tool belt with smart sensors and cable ties',
      'installing an automated irrigation controller module onto a vertical hydroponic tower while holding a tablet showing sensor readings',
      'inside a greenhouse under construction filled with half-assembled vertical farming towers, bundles of irrigation pipes and electrical wiring, smart sensor nodes being mounted on steel frames, LED grow lights casting violet and teal hues over seedling trays, and engineering blueprints spread across a portable worktable'
    )
  },
  {
    slug: '원격진료-코디네이터',
    name: '원격진료 코디네이터',
    prompt: BASE(
      'wearing a medical coordinator\'s navy scrub top and a Bluetooth headset',
      'coordinating a remote patient consultation by managing multiple video call windows on a large curved monitor setup',
      'inside a telemedicine coordination hub with multiple high-resolution screens showing doctor and patient video feeds, electronic health record dashboards, a scheduling board with appointment slots, medical alert notification panels, and soft blue ambient lighting highlighting the digital patient care infrastructure'
    )
  },
  {
    slug: '노년-플래너',
    name: '노년 플래너',
    prompt: BASE(
      'wearing a warm cardigan with a reading glasses hanging on a neck chain and a planner binder in hand',
      'reviewing a customized senior lifestyle plan spreadsheet with a resident at a cozy consultation desk',
      'inside a bright senior living facility office with walls displaying age-friendly activity calendars, health goal tracking boards, retirement budget charts, framed photos of outdoor senior excursion groups, potted plants on windowsills, and a warm golden-and-teal ambient glow throughout the room'
    )
  },
  {
    slug: '헬스-케어-컨설턴트',
    name: '헬스 케어 컨설턴트',
    prompt: BASE(
      'wearing a smart professional blazer with a stethoscope around the neck and a tablet displaying health analytics',
      'presenting a personalized wellness plan on a digital board to a client with charts showing nutritional data and fitness metrics',
      'inside a modern corporate wellness consulting office with illuminated health metric dashboards on walls, anatomical posters, digital BMI and fitness assessment stations, a standing-height consultation desk, and mood lighting in soft teal and warm amber tones'
    )
  },
  {
    slug: '의료-기기-개발-전문가',
    name: '의료 기기 개발 전문가',
    prompt: BASE(
      'wearing a white lab coat, safety goggles, and ESD-safe gloves while holding a medical device PCB with tweezers',
      'soldering and testing a miniature wearable biosensor circuit board under a magnification lamp',
      'inside a medical device R&D lab with cleanroom-adjacent workbenches lined with oscilloscopes, circuit analyzers, 3D-printed medical device prototypes, FDA compliance documentation binders, sterile packaging equipment, and blue-white LED overhead lights illuminating precision assembly stations'
    )
  },
  {
    slug: '여행-기획자',
    name: '여행 기획자',
    prompt: BASE(
      'wearing a casual travel-chic blazer with a neck lanyard holding multiple airline boarding pass cards',
      'pinning destination photos and itinerary cards onto a large corkboard world map while cross-referencing a laptop booking screen',
      'inside a vibrant travel agency office with floor-to-ceiling world maps covered in destination pins, framed exotic destination photos on walls, brochure racks, a LED departure board showing flight destinations, globes and vintage suitcases as decor, and warm amber lighting creating a wanderlust atmosphere'
    )
  },
  {
    slug: '해양-레저-전문가',
    name: '해양 레저 전문가',
    prompt: BASE(
      'wearing a UV-protective rash guard, life vest, and waterproof watch with diving fins resting nearby',
      'demonstrating proper paddleboard balancing technique to a small group on a sunset-lit coastal dock',
      'at a coastal marine leisure center with rental racks of paddleboards, kayaks, and snorkeling gear lining a pier, safety briefing boards, an open-water course marked by buoys stretching into a deep teal ocean, sunset light glittering on wave crests, and a marine-grade equipment station in the background'
    )
  },
  {
    slug: '반려동물-훈련상담사',
    name: '반려동물 훈련·상담사',
    prompt: BASE(
      'wearing a practical trainer\'s polo shirt with a treat pouch on the hip and a clicker tool in hand',
      'guiding a dog through an agility tunnel course using hand signals and reward treats in a training arena',
      'inside a spacious indoor dog training facility with rubberized flooring, colorful agility equipment including weave poles, hurdle jumps, and pause tables, walls lined with training certification plaques and behavioral guidance charts, and overhead spotlights casting warm circles of light across the training course'
    )
  },
  {
    slug: '디지털-큐레이터',
    name: '디지털 큐레이터',
    prompt: BASE(
      'wearing an artsy casual blazer with a stylus pen in hand and a color-calibrated monitor tablet nearby',
      'organizing and tagging a massive digital art archive on a multi-monitor workstation with metadata panels open',
      'inside a digital curation studio with walls showing projected virtual gallery previews, a large curved triple-monitor desk covered with digital artwork thumbnails and metadata entry forms, archival hard drives on dedicated shelves, ambient gallery-style lighting in deep navy and violet, and a holographic display mock-up of a virtual exhibition space'
    )
  },
  {
    slug: '드론-콘텐츠-전문가',
    name: '드론 콘텐츠 전문가',
    prompt: BASE(
      'wearing a branded drone operator vest with FPV goggles pushed up on the forehead and a remote controller in hand',
      'reviewing high-altitude drone footage on a field monitor while adjusting gimbal stabilization settings',
      'on a scenic hilltop production site with a professional hexacopter drone hovering nearby, a portable editing station with RAW aerial footage playing on a monitor, cases of drone batteries and spare props, a wide panoramic landscape backdrop of mountains and valleys stretching into teal-haze distance below'
    )
  },
  {
    slug: '문화-콘텐츠-전문가',
    name: '문화 콘텐츠 전문가',
    prompt: BASE(
      'wearing a creative professional outfit with a scriptwriting notebook and a production slate clapper in hand',
      'pitching a cultural content series concept with storyboard panels spread across a large presentation table',
      'inside a cultural content development studio with mood boards covering every wall featuring traditional Korean motifs blended with modern multimedia designs, a storyboard wall of illustrated content sequences, a production timeline board, reference books on cultural heritage stacked on shelves, and studio lighting in warm amber and teal'
    )
  },
  {
    slug: '스마트-그리드-엔지니어',
    name: '스마트 그리드 엔지니어',
    prompt: BASE(
      'wearing a utility-grade hard hat, high-visibility vest, and insulated electrical safety gloves',
      'operating a smart grid control panel with real-time power flow visualization maps showing energy distribution nodes',
      'inside a power grid control center with floor-to-ceiling screens displaying national electricity grid topology maps, real-time load balancing dashboards, automated fault detection alerts, rows of server racks humming behind glass, engineers at monitoring stations, and cool teal LED ambient lighting throughout the command floor'
    )
  },
  {
    slug: '기후변화-대응-전문가',
    name: '기후변화 대응 전문가',
    prompt: BASE(
      'wearing a field researcher\'s jacket with a carbon measurement instrument in hand and a data logger around the neck',
      'planting atmospheric CO2 sensor stakes in a peat bog research site while reviewing emissions data on a rugged field tablet',
      'in an outdoor climate research environment with wetlands stretching to the horizon, weather monitoring towers equipped with anemometers and rain gauges, a portable field lab tent with climate modeling laptops, satellite image printouts of deforestation zones, and a dramatic dark-teal sky with storm clouds building overhead'
    )
  },
  {
    slug: '신재생에너지-전문가',
    name: '신재생에너지 전문가',
    prompt: BASE(
      'wearing a technical coverall with a solar panel testing kit and a voltage meter in hand',
      'measuring solar panel output efficiency on a rooftop installation while checking string inverter connections',
      'on a vast rooftop solar farm with hundreds of photovoltaic panels extending to the horizon, wind turbines visible on a nearby ridge, a ground-level monitoring station showing real-time energy production dashboards, cable management conduits, and the sky lit in deep navy with teal solar glow reflections across the panel surfaces'
    )
  },
  {
    slug: '스마트-재난-관리-전문가',
    name: '스마트 재난 관리 전문가',
    prompt: BASE(
      'wearing an emergency response commander\'s jacket with a radio communicator and a digital incident command tablet',
      'coordinating real-time disaster response by directing evacuation routes on a tactical situation map board',
      'inside an emergency operations center with a massive LED wall displaying live drone feeds of a disaster zone, city-wide sensor alert dashboards, agency communication channels, route mapping overlays, red emergency phone banks, and urgent amber alert lighting casting dramatic shadows across the command room'
    )
  },
  {
    slug: '블록체인-전문가',
    name: '블록체인 전문가',
    prompt: BASE(
      'wearing a dark hoodie with a hardware crypto wallet device in one hand and a laptop displaying smart contract code',
      'debugging and deploying a smart contract on a blockchain testnet via a command-line terminal with hash strings scrolling',
      'inside a crypto development workspace with walls showing a live blockchain ledger visualization with glowing transaction blocks linking in a chain, multiple monitors displaying Solidity code editors and network node status panels, a whiteboard with blockchain architecture diagrams, and deep navy ambient lighting with teal node connection glow effects'
    )
  },
  {
    slug: '크라우드-펀딩-전문가',
    name: '크라우드 펀딩 전문가',
    prompt: BASE(
      'wearing a smart casual outfit with a laptop and a campaign analytics dashboard visible on screen',
      'crafting a crowdfunding campaign pitch page with reward tier graphics and a funding progress bar nearly reaching goal',
      'inside a startup incubator workspace with a wall-mounted giant funding thermometer showing campaign progress, monitors displaying backer pledge data and reward tiers, campaign mockup posters on the wall, video production equipment for pitch videos, and energetic teal-and-violet ambient lighting throughout the collaborative workspace'
    )
  },
  {
    slug: '사이버-평판-관리자',
    name: '사이버 평판 관리자',
    prompt: BASE(
      'wearing a business-casual outfit with noise-cancelling headphones around the neck and a social media monitoring dashboard on screen',
      'analyzing brand sentiment score trends across social media platforms on a multi-screen monitoring workstation',
      'inside a digital reputation management command center with walls of real-time social media feed monitors, sentiment analysis graphs rising and falling, alert notification panels for brand mentions, keyword trend boards, press release drafting workstations, and cool deep-navy lighting with teal alert indicator glow'
    )
  },
  {
    slug: '사물-인터넷-전문가',
    name: '사물 인터넷 전문가',
    prompt: BASE(
      'wearing a tech-casual outfit with a Raspberry Pi development board in one hand and a soldering iron nearby',
      'wiring up a network of IoT sensor nodes on a development breadboard while monitoring signal packets on a laptop',
      'inside a smart home IoT lab with a prototype smart room environment featuring connected lighting, climate sensors, smart locks, and appliances all linked to a central dashboard, walls of shelving with IoT hardware modules, MQTT message flow diagrams, and a glowing mesh network topology map projected on a dark wall'
    )
  },
  {
    slug: '생물-정보-분석가',
    name: '생물 정보 분석가',
    prompt: BASE(
      'wearing a white lab coat with reading glasses pushed up and a bioinformatics software tool open on a dual-monitor workstation',
      'analyzing a genome sequencing alignment visualization with color-coded nucleotide sequences scrolling across the screen',
      'inside a bioinformatics research lab with walls displaying DNA sequence alignment charts, protein structure visualizations, phylogenetic tree diagrams, server clusters running genomic pipeline processes, a DNA sequencing machine with sample trays loaded, and cool teal bioluminescent lighting reflecting off glossy monitor screens'
    )
  },
  {
    slug: '로봇-윤리학자',
    name: '로봇 윤리학자',
    prompt: BASE(
      'wearing a scholarly blazer with a fountain pen in hand and a copy of robotics ethics guidelines on the desk',
      'presenting an AI ethics framework diagram at a conference podium in front of an audience of engineers and policymakers',
      'inside a technology ethics conference hall with a large projection screen showing an AI decision-making flowchart with ethical constraint nodes highlighted, rows of seated engineers and policy experts, bookshelves lined with philosophy and technology ethics volumes, and a warm-toned lecture hall ambiance with deep navy stage lighting'
    )
  },
  {
    slug: '드론-전문가',
    name: '드론 전문가',
    prompt: BASE(
      'wearing a drone pilot\'s flight suit with a remote control transmitter in hand and FPV goggles on the head',
      'launching a professional octacopter drone from a designated takeoff pad while checking GPS lock on the ground station screen',
      'at an industrial drone operations facility with a fleet of heavy-lift drones parked on charging pads, ground control station monitors showing telemetry data and flight paths, maintenance toolboxes, a large hangar opening to an airfield, and wide open sky above with deep navy and teal atmospheric light'
    )
  },
  {
    slug: '손실방지전문가',
    name: '손실방지전문가',
    prompt: BASE(
      'wearing a security blazer with an earpiece communicator and a tablet showing store floor CCTV feeds',
      'reviewing loss incident reports and analyzing suspicious inventory shrinkage patterns on a security analytics dashboard',
      'inside a retail loss prevention control room with a bank of CCTV monitors covering every aisle and exit of a large store, shrinkage trend graphs on wall displays, incident case log terminals, a evidence storage safe, door sensor alert panels, and red-tinted alert lighting contrasting with deep navy ambient glow'
    )
  },
  {
    slug: '소비생활어드바이저',
    name: '소비생활어드바이저',
    prompt: BASE(
      'wearing a professional blazer with a consumer rights handbook open on the desk and a phone headset',
      'advising a consumer on complaint resolution procedures while referencing product liability regulations on a compliance database',
      'inside a consumer protection advisory office with walls displaying consumer rights charts, product recall notice boards, complaint resolution flowcharts, a waiting area with informational brochures, a formal consultation desk with dual monitors showing case management software, and soft warm-teal advisory center lighting'
    )
  },
  {
    slug: '문화여가사',
    name: '문화여가사',
    prompt: BASE(
      'wearing a bright program coordinator vest with a whistle around the neck and a group activity schedule clipboard',
      'leading a senior group through a traditional crafts workshop activity in a community cultural center',
      'inside a multipurpose community leisure hall with activity stations set up for calligraphy, traditional folk crafts, and group games, colorful program announcement banners on walls, a performance stage area with a piano, shelves of leisure activity kits, and warm inviting amber lighting creating a welcoming cultural space'
    )
  },
  {
    slug: '개인브랜드매니저',
    name: '개인브랜드매니저',
    prompt: BASE(
      'wearing a sharp blazer with a personal brand mood board visible on a laptop and a design color palette in hand',
      'designing a personal brand identity kit with logo, color palette, and typography style guide on a wide creative workstation',
      'inside a personal branding studio with a wall showing before-and-after brand identity transformations, design software tools open across multiple monitors, pantone color swatch books, client portfolio mockups on display stands, a photography backdrop setup, and dramatic studio lighting in deep navy with warm spotlight accents'
    )
  },
  {
    slug: '재활용코디네이터',
    name: '재활용코디네이터',
    prompt: BASE(
      'wearing a bright green coordinator vest and protective gloves, holding a sorting checklist clipboard',
      'demonstrating correct material separation technique at a recycling facility sorting station with labeled collection bins',
      'inside a modern recycling facility with color-coded conveyor belt sorting lines processing glass, plastic, paper, and metal waste streams, material detection sensor arrays above the belt, a control room visible behind glass, wall-mounted recycling rate dashboards, and cool industrial teal-lit environment throughout the plant'
    )
  },
  {
    slug: '동물보호보안관',
    name: '동물보호보안관',
    prompt: BASE(
      'wearing a wildlife protection officer uniform with a badge, utility belt, and an animal first-aid kit',
      'rescuing an injured stray animal from a trap using protective handling gloves in a forested urban fringe area',
      'in an urban wildlife protection zone with a patrol vehicle parked on a forest path, animal rescue equipment laid out including transport cages, humane trap tools, and first-aid supplies, municipal animal shelter visible in the background, and dappled teal-and-navy light filtering through forest canopy'
    )
  },
  {
    slug: '식품융합엔지니어',
    name: '식품융합엔지니어',
    prompt: BASE(
      'wearing a food-grade white lab coat, hairnet, and safety goggles while holding a food texture analyzer probe',
      'testing novel plant-based protein texture properties in a food technology R&D kitchen lab',
      'inside a food science innovation lab with industrial food processing equipment, fermentation incubators, texture analyzers, 3D food printer prototypes on benches, walls displaying nutritional engineering diagrams and ingredient formulation charts, sterile stainless steel surfaces, and cool clinical-white lighting with teal tech-glow from instrument panels'
    )
  },
  {
    slug: '수의테크니션',
    name: '수의테크니션',
    prompt: BASE(
      'wearing teal-colored veterinary scrubs and nitrile exam gloves while gently restraining a patient animal',
      'assisting a surgical procedure by monitoring anesthesia equipment and vital signs on a veterinary monitor',
      'inside a veterinary surgical suite with stainless steel operating table, anesthesia machine with gas monitoring displays, surgical instrument tray, autoclave sterilization unit, wall-mounted X-ray viewer showing animal skeletal images, and bright clinical overhead surgical lamps casting clean white light against a deep navy-tinted background'
    )
  },
  {
    slug: '무인항공기시스템개발자',
    name: '무인항공기시스템개발자',
    prompt: BASE(
      'wearing an aerospace engineering lab coat with a UAV circuit diagram and a flight controller board in hand',
      'programming autopilot mission waypoints into a UAV flight controller via a ground station software interface',
      'inside a UAV development lab with a full-scale drone prototype suspended on a test rig, avionics testing equipment connected with probes, flight simulation screens running trajectory models, aerodynamic stress test reports on whiteboards, electronic component workbenches, and cool deep-navy ambient light with teal instrument panel glow'
    )
  },
  {
    slug: '지리정보시스템기사',
    name: '지리정보시스템기사',
    prompt: BASE(
      'wearing a field survey jacket with a GPS rover instrument on a pole and a rugged field tablet displaying GIS map layers',
      'collecting georeferenced elevation data in a terrain survey while overlaying satellite imagery on the GIS software',
      'in an outdoor terrain mapping environment with a total station surveying tripod set up on a hillside, GPS base station antenna, a laptop showing GIS contour mapping software, topographic maps spread on a portable table, and a sweeping landscape of hills and valleys rendered in deep teal-navy atmospheric haze in the background'
    )
  },
  {
    slug: '데이터마이너',
    name: '데이터마이너',
    prompt: BASE(
      'wearing a casual data scientist hoodie with a coffee mug nearby and a Python IDE open on a wide monitor',
      'running a clustering algorithm on a massive dataset with colorful scatter plot visualizations appearing on screen',
      'inside a data analytics workspace with floor-to-ceiling monitors displaying data visualization dashboards, Jupyter notebook cells with code and chart outputs, database schema diagrams on a wall whiteboard, a Hadoop cluster rack humming in the corner, and deep navy ambient lighting with teal data glow emanating from every screen'
    )
  },
  {
    slug: '웹접근성컨설턴트',
    name: '웹접근성컨설턴트',
    prompt: BASE(
      'wearing a smart casual blazer with a screen reader software interface on a laptop and WCAG accessibility checklist in hand',
      'auditing a website\'s accessibility compliance by running automated contrast ratio checks and keyboard navigation tests',
      'inside an inclusive design studio with walls showing WCAG 2.1 compliance matrices, accessibility audit report printouts, adaptive technology devices including screen readers and switch access controllers on a demonstration desk, before-and-after UI redesign comparison panels, and soft warm-teal inclusive design atmosphere lighting'
    )
  },
  {
    slug: '괴롭힘방지조언사',
    name: '괴롭힘방지조언사',
    prompt: BASE(
      'wearing a professional neutral-toned blazer with a confidential counseling folder and a policy handbook on the desk',
      'conducting a private workplace harassment consultation session across a mediation desk with case documentation open',
      'inside a confidential HR counseling office with soft indirect lighting, privacy screen partitions, a secure document filing wall, anti-bullying policy posters, a whiteboard showing organizational conflict resolution frameworks, comfortable counseling chairs, and a calm, trust-inspiring interior with warm amber and subtle teal ambient lighting'
    )
  },
  {
    slug: '재능기부코디네이터',
    name: '재능기부코디네이터',
    prompt: BASE(
      'wearing a volunteer coordinator vest with a matching volunteer schedule board and a community project folder',
      'facilitating a skills-matching session by connecting volunteer specialists with community organization needs on a bulletin board',
      'inside a community volunteer coordination center with a massive skills-matching board covered in volunteer talent cards and organization request notes, a wall timeline of community projects, volunteer orientation materials on tables, enthusiastic team meeting in progress, and warm energetic amber-teal lighting throughout the welcoming center'
    )
  },
  {
    slug: '장애인잡코치',
    name: '장애인잡코치',
    prompt: BASE(
      'wearing a supportive coach polo shirt with a vocational training assessment form and encouraging posture toward a student',
      'guiding a person with a disability through a workplace simulation task at a supported employment training station',
      'inside an inclusive vocational training facility with adaptive workstations equipped with accessibility tools, job skills practice stations for packaging, computer entry, and assembly tasks, motivational achievement boards on walls, ergonomic equipment, and soft empowering warm-golden and teal ambient lighting throughout the accessible space'
    )
  },
  {
    slug: '아동청소년시설보호사',
    name: '아동청소년시설보호사',
    prompt: BASE(
      'wearing a caring protective staff uniform with a child welfare casebook and a warm reassuring expression',
      'reading a picture book to a small group of children in a cozy residential care facility common room',
      'inside a child residential care facility with a colorful and safe common room featuring low bookshelves with picture books, soft play mats, children\'s artwork on every wall, a small kitchen area visible in the back, warm soft yellow lighting, and a protective calm atmosphere with teal and warm amber tones throughout'
    )
  },
  {
    slug: '케어매니저',
    name: '케어매니저',
    prompt: BASE(
      'wearing a care management polo shirt with a patient care plan binder and a tablet showing care schedule assignments',
      'coordinating a multi-service care plan for an elderly client by reviewing health, social, and housing need assessments',
      'inside a care management coordination office with a wall of client care plan files, service provider contact boards, community resource maps, a care coordination timeline display, intake assessment interview area with comfortable chairs, and warm empathetic amber-teal ambient lighting creating a trustworthy care environment'
    )
  },
  {
    slug: '평등관리사무원',
    name: '평등관리사무원',
    prompt: BASE(
      'wearing a formal office blazer with a gender equality compliance report and a diversity metrics dashboard on screen',
      'reviewing equal opportunity employment audit data and filing an organizational diversity compliance report at an administrative desk',
      'inside a DEI compliance office with walls showing diversity and inclusion statistics dashboards, equal opportunity policy frameworks, employee representation charts by gender and background, a consultation meeting table with open discrimination case review files, and professional neutral-toned office lighting with teal administrative glow'
    )
  },
  {
    slug: '애견테라피스트',
    name: '애견테라피스트',
    prompt: BASE(
      'wearing a certified animal therapist jacket with a therapy dog certification badge and a gentle-touch grooming brush',
      'conducting an animal-assisted therapy session where a well-trained therapy dog interacts with an elderly patient',
      'inside a hospital therapeutic recreation room with soft furnishings, a certified therapy Labrador retriever resting on a padded mat, patient seating in a circle, wall decorations of calming nature scenes, sensory activity tables, and warm healing amber light filtering through sheer curtains creating a calm teal-amber therapy atmosphere'
    )
  },
  {
    slug: '학습장애간호사',
    name: '학습장애간호사',
    prompt: BASE(
      'wearing specialized nursing scrubs with a communication aid board and a patient-centered care plan folder',
      'using visual communication cards and gentle gestures to conduct a health assessment with a patient with learning disabilities',
      'inside a specialized healthcare unit designed for patients with learning disabilities featuring picture-based signage, sensory-calm wall colors, low-stimulation patient rooms, Makaton symbol charts, accessible medical equipment at patient height, and warm comforting amber-teal therapeutic lighting throughout the inclusive healthcare space'
    )
  },
  {
    slug: '사설탐정',
    name: '사설탐정',
    prompt: BASE(
      'wearing a trench coat with an investigative notebook and a high-zoom camera with telephoto lens in hand',
      'conducting covert surveillance from behind a parked car while reviewing evidence photos on a laptop',
      'inside a dimly lit private investigation office with pinboard covered in evidence photos connected by red string, a case file wall, surveillance equipment laid on the desk including binoculars and audio recorder, street map with locations marked, a flickering desk lamp casting dramatic shadows, and noir-style deep navy and amber atmospheric lighting'
    )
  },
  {
    slug: '범죄과학수사관',
    name: '범죄과학수사관',
    prompt: BASE(
      'wearing a white forensic investigator jumpsuit with blue nitrile gloves and a forensic evidence collection kit',
      'collecting trace evidence at a crime scene with tweezers while photographing exhibits under a portable UV light',
      'inside a forensic crime scene investigation setting with evidence markers numbered across the floor, a fingerprint dusting station, portable DNA collection kits, a forensic lighting array, bagged evidence on numbered evidence tables, a forensic laboratory trailer visible through the doorway, and dramatic deep-teal forensic UV-light atmosphere'
    )
  },
  {
    slug: '야외활동지도사',
    name: '야외활동지도사',
    prompt: BASE(
      'wearing a trail instructor\'s vest with a topographic map, compass, and safety whistle on a lanyard',
      'leading a group through a rope challenge course in a forest outdoor education center',
      'in a forest outdoor activity center with wooden high-ropes course elements visible through the trees, climbing wall structures, zip line platforms, a fire circle for group reflection activities, safety helmets and harnesses hanging on a gear rack, and deep navy twilight sky above the tree canopy with teal bioluminescent forest floor glow'
    )
  },
  {
    slug: '스포츠기록분석연구원',
    name: '스포츠기록분석연구원',
    prompt: BASE(
      'wearing a sports analytics team polo with a multi-screen performance analysis workstation and a game footage tablet',
      'analyzing a football player\'s movement heatmap and pass accuracy statistics on a video analysis software platform',
      'inside a sports performance analytics center with a large tactical display screen showing player tracking overlays on a field map, multiple monitors with biomechanical movement data, video clip review stations, sports statistics database terminals, whiteboard with tactical formations, and deep navy and sports-blue ambient lighting throughout the high-tech analysis room'
    )
  },
  {
    slug: '비디오게임디자이너',
    name: '비디오게임디자이너',
    prompt: BASE(
      'wearing a gamer-chic hoodie with a digital drawing tablet stylus and a game design document spread across the desk',
      'sketching game level layouts and character ability trees on a design document while referencing a mood board of visual concepts',
      'inside a game design studio with walls covered in concept art sketches, level design blueprints, character development boards, 3D modeling software open on a large curved monitor, a reference wall of game controller inputs and UX flow diagrams, collectible game figurines on shelves, and deep navy studio lighting with violet LED strip accents'
    )
  },
  {
    slug: '게임감시관-및-조사관',
    name: '게임감시관 및 조사관',
    prompt: BASE(
      'wearing a gaming regulatory inspector uniform with a compliance checklist tablet and an official investigation badge',
      'auditing a gaming machine\'s randomness certificate and payout algorithm documentation at a casino floor inspection station',
      'inside a gaming regulatory inspection facility with rows of slot machine cabinets under assessment, testing equipment connected to gaming hardware, payout calculation verification terminals, regulatory compliance binders stacked on desks, a secure evidence storage room visible behind a glass wall, and serious deep navy official inspection lighting'
    )
  },
  {
    slug: '목소리코치',
    name: '목소리코치',
    prompt: BASE(
      'wearing a voice performance coach blazer with a pitch-measuring tuner device and a breath control exercise worksheet',
      'demonstrating diaphragmatic breathing and vocal resonance exercises at a professional vocal training studio podium',
      'inside a high-end vocal coaching studio with a grand piano in the corner, sound-absorbing acoustic foam panels on walls, a microphone on a studio stand connected to a vocal analysis spectrogram monitor, a mirror wall for performance observation, sheet music stands, and warm amber performance lighting with deep navy acoustic shadows'
    )
  },
  {
    slug: '동물랭글러',
    name: '동물랭글러',
    prompt: BASE(
      'wearing a durable animal handler\'s jacket with reinforced gloves, a training treat bag, and a capture net nearby',
      'safely guiding and positioning a trained exotic animal on a film set background mark using voice commands and treats',
      'on an outdoor film production set with a camera crew visible in the background, animal handling crates and transport vehicles parked nearby, safety perimeters marked with tape, a diverse collection of animal training equipment including leashes, barriers, and enrichment toys, and dramatic film-set golden lighting fading into deep navy dusk sky'
    )
  },
  {
    slug: '범죄심리분석관프로파일러',
    name: '범죄심리분석관(프로파일러)',
    prompt: BASE(
      'wearing a FBI-style profiler blazer with a criminal behavioral assessment report and a case evidence folder',
      'mapping a geographic criminal activity profile on a tactical crime mapping board with push pins and connection strings',
      'inside a criminal profiling analysis office with a floor-to-ceiling evidence wall covered in crime scene photos, behavioral pattern matrices, geographic offender profiling maps, psychological assessment reports, interview transcripts, dim interrogation-room-style lighting with a single overhead spotlight, and deep navy and muted violet investigative atmosphere'
    )
  },
  {
    slug: '다문화코디네이터',
    name: '다문화코디네이터',
    prompt: BASE(
      'wearing a multicultural coordinator vest with a multilingual welcome brochure and a translation earpiece device',
      'facilitating a multicultural community integration workshop by presenting cultural orientation materials on a projector screen',
      'inside a multicultural community center with national flags of many countries decorating the walls, multilingual signage in Korean, English, Vietnamese, and Chinese, a community bulletin board with cultural event announcements, integration support resource tables, comfortable multicultural gathering space, and warm welcoming amber and teal inclusive lighting'
    )
  },
  {
    slug: 'sns-마케터',
    name: 'SNS 마케터',
    prompt: BASE(
      'wearing a trendy marketing casual outfit with a ring light setup and a smartphone mounted on a content creation rig',
      'filming a short-form social media content piece at a branded studio setup while checking real-time engagement analytics on a tablet',
      'inside a social media content studio with multiple phone and camera setups, a backdrop wall of trending aesthetic tile designs, real-time analytics dashboards on monitors showing follower counts and engagement rates, a content calendar whiteboard, prop shelves with photography accessories, and energetic teal-and-violet influencer studio lighting'
    )
  },
  {
    slug: '국제개발협력전문가',
    name: '국제개발협력전문가',
    prompt: BASE(
      'wearing a field development worker jacket with a project needs assessment clipboard and a USAID-style cap',
      'facilitating a community development planning session with local stakeholders around a project implementation map',
      'in an international development project field site with a temporary coordination office featuring world development organization flags, project milestone boards with progress photos, community survey data maps, technical assistance equipment crates, local community members participating in a planning session, and warm outdoor golden-teal development site lighting'
    )
  },
  {
    slug: '공정무역전문가',
    name: '공정무역전문가',
    prompt: BASE(
      'wearing a fair trade organization polo with a Fairtrade certification documentation binder and a sourcing map',
      'conducting a fair trade supply chain audit by reviewing producer cooperative records and certification compliance documents',
      'inside a fair trade organization office with walls covered in world producer maps showing certified farming cooperatives, fair price comparison charts, certification audit checklists, product samples from developing country artisans on shelves, and warm ethical-sourcing amber lighting with global community teal accents throughout the principled workspace'
    )
  },
  {
    slug: '감성인식기술전문가',
    name: '감성인식기술전문가',
    prompt: BASE(
      'wearing a tech research lab coat with a facial action coding system chart and an emotion AI interface on screen',
      'training an emotion recognition AI model using annotated facial expression datasets on a deep learning workstation',
      'inside an affective computing research lab with facial micro-expression analysis monitors showing color-coded emotion probability heat maps over video faces, biometric sensor signal processing equipment, an EEG headset on a mannequin head, emotion AI model training progress bars, and cool teal neural-glow ambient lighting across the lab'
    )
  },
  {
    slug: '개인형-이동수단-개발자',
    name: '개인형 이동수단 개발자',
    prompt: BASE(
      'wearing a mobility engineering lab coat with a scooter motor controller PCB and a battery load tester in hand',
      'bench-testing the torque response and regenerative braking behavior of an electric scooter drivetrain on a dynamometer rig',
      'inside a personal mobility vehicle R&D workshop with multiple electric scooter and e-bike prototypes in various assembly stages, motor test rigs, battery cell testing chambers, chassis stress analysis CAD models on engineering monitors, safety certification documentation, and a tech-forward deep navy workshop with teal LED undercarriage accent glow on prototype vehicles'
    )
  },
  {
    slug: '유전자-재조합-식품-전문가',
    name: '유전자 재조합 식품 전문가',
    prompt: BASE(
      'wearing a biosafety level 2 lab coat with nitrile gloves, safety goggles, and a gene editing tool in hand',
      'performing a CRISPR gene editing procedure on crop cell cultures under a biosafety cabinet in a genetics lab',
      'inside a GMO research laboratory with sterile biosafety cabinets, PCR machines with reagent trays loaded, fluorescence microscopes showing cell culture images, gene sequence analysis posters on walls, a seed library of edited crop specimens in labeled vials, and cool clinical white and teal bioluminescent lighting throughout the sterile research environment'
    )
  },
  {
    slug: '배터리-기술자',
    name: '배터리 기술자',
    prompt: BASE(
      'wearing a battery lab coat with insulated electrical gloves and an electrochemical impedance spectrometer probe in hand',
      'testing lithium-ion cell capacity and internal resistance using a battery analyzer with discharge cycle graphs on a monitor',
      'inside a battery technology laboratory with rows of battery cycling test chambers humming with cell test cycles, electrode slurry mixing machines, an electrolyte preparation station with fume hood, safety shielded battery formation equipment, degradation analysis data dashboards, and cold deep-navy lab lighting with teal charge indicator glow from battery test racks'
    )
  },
  {
    slug: '양자-컴퓨팅-기술자',
    name: '양자 컴퓨팅 기술자',
    prompt: BASE(
      'wearing a cleanroom coverall with electrostatic protection and a qubit control circuit board in hand near cryogenic equipment',
      'calibrating qubit coherence times on a dilution refrigerator quantum processor while monitoring quantum error correction metrics',
      'inside a quantum computing research facility with a towering gold-plated dilution refrigerator cryostat at the center, microwave control cable trees hanging from its base, oscilloscope racks measuring qubit signal fidelity, quantum circuit diagrams on walls, a server room with quantum cloud interface terminals, and ethereal deep-navy teal cryogenic vapor glow environment'
    )
  },
  {
    slug: '핀테크-전문가',
    name: '핀테크 전문가',
    prompt: BASE(
      'wearing a fintech startup blazer with a digital payment API documentation tablet and a dual-monitor trading interface open',
      'designing a real-time payment gateway architecture on a whiteboard with transaction flow diagrams and API endpoint mappings',
      'inside a fintech innovation lab with walls showing live global payment transaction flow maps, cryptocurrency price ticker boards, API integration architecture diagrams, PCI-DSS compliance audit checklists, a blockchain transaction ledger visualization, and sleek deep-navy financial-tech lighting with teal network flow accent glow'
    )
  },
  {
    slug: '스마트공장-기술자',
    name: '스마트공장 기술자',
    prompt: BASE(
      'wearing an industry 4.0 technician uniform with an AR smart glasses headset and an industrial tablet displaying machine IoT data',
      'configuring a PLC automation sequence for a robotic assembly cell by programming ladder logic on an industrial controller',
      'inside a smart factory floor with robotic arm assembly cells, AGV autonomous transport vehicles carrying parts between stations, a real-time MES manufacturing execution system dashboard on a large wall screen, digital twin simulation models on engineers\' monitors, and cool factory-floor teal LED ambient lighting illuminating automated precision manufacturing'
    )
  },
  {
    slug: '지능형-로봇개발자',
    name: '지능형 로봇개발자',
    prompt: BASE(
      'wearing a robotics researcher\'s lab coat with a ROS development laptop and a robot arm control pendant in hand',
      'programming an autonomous mobile robot\'s path planning algorithm while a robot navigates an obstacle course in the lab',
      'inside a robotics AI research laboratory with multiple autonomous robot platforms being tested on indoor navigation maps, a robot arm performing precision pick-and-place tasks, large ROS visualization screens showing sensor point-cloud data and robot position maps, component workbenches, and deep-navy tech lab lighting with teal LIDAR scan glow'
    )
  },
  {
    slug: '디지털-헬스케어-기기-개발자',
    name: '디지털 헬스케어 기기 개발자',
    prompt: BASE(
      'wearing a medical device engineering lab coat with a wearable health sensor prototype and a PCB design tool on screen',
      'debugging a miniaturized ECG wearable sensor circuit while reviewing clinical accuracy test data on a biomedical monitor',
      'inside a digital health device R&D lab with cleanroom-adjacent PCB assembly benches, FDA medical device regulation compliance binders, clinical testing data comparison charts on walls, an electrophysiology testing station with human body phantom models, prototype wearable health devices on display, and precise cool-white and teal clinical-tech ambient lighting'
    )
  },
  {
    slug: '3d-프린팅-전문가',
    name: '3D 프린팅 전문가',
    prompt: BASE(
      'wearing a maker-space lab apron with safety goggles pushed up and a freshly printed component part in hand',
      'removing support structures from a complex 3D printed mechanical assembly with precision nippers while reviewing CAD design on a monitor',
      'inside a professional 3D printing workshop with a wall of industrial SLA, FDM, and SLS printers in various print states, post-processing workstations with curing UV lamps and sandblasting booths, shelves of resin and filament spools in every color, CAD design stations, a showcase shelf of finished printed prototypes, and deep navy workspace with teal printer display glow'
    )
  },
  {
    slug: '스마트-도시-전문가',
    name: '스마트 도시 전문가',
    prompt: BASE(
      'wearing an urban technology consultant blazer with a smart city platform tablet and a city sensor network diagram',
      'presenting a smart city data integration plan on a large digital city simulation wall showing real-time IoT urban sensor feeds',
      'inside a smart city operations center with a massive city digital twin visualization on the main screen showing live traffic flows, energy grids, waste management sensors, and public safety alerts, rows of analyst workstations, a 3D scale model of a future city district on a central table, and deep-navy command room lighting with teal city network glow'
    )
  },
  {
    slug: '개인관리컨설턴트',
    name: '개인관리컨설턴트',
    prompt: BASE(
      'wearing a polished life-coach blazer with a personalized goal-setting planner and a time management board',
      'conducting a one-on-one personal development coaching session with a detailed goal achievement roadmap displayed on a monitor',
      'inside an executive life coaching studio with a motivational quote wall, personal KPI tracking dashboards, time-blocking calendar systems on a large planning board, a comfortable coaching conversation seating area, journaling prompts on cards, a vision board display station, and warm inspiring amber-teal motivational lighting throughout the empowering space'
    )
  },
  {
    slug: '무인항공촬영감독',
    name: '무인항공촬영감독',
    prompt: BASE(
      'wearing a film director\'s hat and a director\'s viewfinder around the neck with a drone remote controller in hand',
      'directing a cinematic aerial shot sequence while monitoring live drone camera feed on a field production monitor',
      'on an outdoor cinematic production location with a large professional drone in the air, a field production tent with high-resolution monitors showing aerial footage, a director\'s chair, lighting reflectors, a production crew visible in the background, dramatic golden-hour landscape stretching to the horizon, and deep navy sky with warm cinematic lens flare effect'
    )
  },
  {
    slug: '신소재-개발-연구원',
    name: '신소재 개발 연구원',
    prompt: BASE(
      'wearing a materials science lab coat with a sample holder containing advanced composite material wafers and spectroscopy tools',
      'analyzing the microstructure of a novel nano-composite material sample using a scanning electron microscope interface',
      'inside a materials research laboratory with a scanning electron microscope, X-ray diffraction analyzer, a furnace for high-temperature material synthesis, tensile strength testing machine, a sample preparation room visible through glass, walls covered with crystalline material microstructure images and composition charts, and clinical deep-navy and teal materials lab ambient lighting'
    )
  }
];

// Evolink API로 이미지 생성 요청
async function requestImage(prompt, jobName) {
  try {
    const response = await fetch('https://api.evolink.ai/v1/images/generations', {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${API_KEY}`,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        model: 'z-image-turbo',
        prompt: prompt,
        size: '1280x720',
        nsfw_check: false
      })
    });

    if (!response.ok) {
      const error = await response.text();
      console.log(`   ❌ API 오류 ${response.status}: ${error.substring(0, 100)}`);
      return null;
    }

    const taskData = await response.json();
    return taskData.id;
  } catch (error) {
    console.log(`   ❌ 요청 오류: ${error.message}`);
    return null;
  }
}

// 태스크 완료 대기 (폴링)
async function waitForCompletion(taskId, jobName) {
  let attempts = 0;
  const maxAttempts = 40;

  while (attempts < maxAttempts) {
    await new Promise(resolve => setTimeout(resolve, 2500));
    attempts++;

    try {
      const response = await fetch(`https://api.evolink.ai/v1/tasks/${taskId}`, {
        headers: { 'Authorization': `Bearer ${API_KEY}` }
      });

      if (!response.ok) continue;

      const status = await response.json();

      if (status.status === 'completed') {
        const imageUrl = status.results?.[0] || status.data?.url || status.data?.urls?.[0];
        if (imageUrl) return imageUrl;
      } else if (status.status === 'failed') {
        console.log(`   ❌ 이미지 생성 실패 (서버 오류)`);
        return null;
      }

      if (attempts % 4 === 0) {
        const progress = status.progress || 0;
        console.log(`   ⏳ [${attempts}번째 확인] ${progress}%`);
      }
    } catch (error) {
      // 폴링 중 네트워크 오류는 무시하고 계속
      continue;
    }
  }
  console.log(`   ❌ 타임아웃 (${maxAttempts * 2.5}초 초과)`);
  return null;
}

// 이미지 다운로드
async function downloadImage(url, localPath) {
  try {
    const response = await fetch(url);
    if (!response.ok) {
      console.log(`   ❌ 다운로드 실패: ${response.status}`);
      return false;
    }
    const buffer = Buffer.from(await response.arrayBuffer());
    fs.writeFileSync(localPath, buffer);
    return true;
  } catch (error) {
    console.log(`   ❌ 다운로드 오류: ${error.message}`);
    return false;
  }
}

// R2에 업로드 (remote - 프로덕션)
function uploadToR2Remote(localPath, r2Key) {
  try {
    execSync(
      `npx wrangler r2 object put careerwiki-uploads/${r2Key} --file="${localPath}" --content-type image/webp --remote`,
      {
        cwd: path.resolve(__dirname, '..'),
        stdio: 'pipe'
      }
    );
    return true;
  } catch (error) {
    console.log(`   ❌ R2 업로드 실패: ${error.stderr?.toString()?.substring(0, 200) || error.message}`);
    return false;
  }
}

// DB 업데이트 (remote)
function updateDB(slug, imageUrl, imagePrompt) {
  try {
    // 프롬프트의 작은따옴표 이스케이프
    const escapedPrompt = imagePrompt.replace(/'/g, "''");
    const escapedUrl = imageUrl.replace(/'/g, "''");
    const sql = `UPDATE jobs SET image_url='${escapedUrl}', image_prompt='${escapedPrompt}' WHERE slug='${slug}'`;

    execSync(
      `npx wrangler d1 execute careerwiki-kr --remote --command "${sql.replace(/"/g, '\\"')}"`,
      {
        cwd: path.resolve(__dirname, '..'),
        stdio: 'pipe'
      }
    );
    return true;
  } catch (error) {
    // wrangler d1 json escape 방식으로 재시도
    try {
      const tempSqlFile = path.join(TEMP_DIR, `update-${slug}.sql`);
      const escapedPrompt = imagePrompt.replace(/'/g, "''");
      fs.writeFileSync(tempSqlFile, `UPDATE jobs SET image_url='${imageUrl}', image_prompt='${escapedPrompt}' WHERE slug='${slug}';`);
      execSync(
        `npx wrangler d1 execute careerwiki-kr --remote --file="${tempSqlFile}"`,
        {
          cwd: path.resolve(__dirname, '..'),
          stdio: 'pipe'
        }
      );
      fs.unlinkSync(tempSqlFile);
      return true;
    } catch (e2) {
      console.log(`   ❌ DB 업데이트 실패: ${e2.message?.substring(0, 200)}`);
      return false;
    }
  }
}

// 메인 실행
async function main() {
  const progress = loadProgress();

  console.log('\n🦫 커리어넷 신규 직업 75개 이미지 일괄 재생성');
  console.log('='.repeat(60));
  console.log(`✅ 이미 완료: ${progress.completed.length}개`);
  console.log(`❌ 이전 실패: ${progress.failed.length}개`);

  // 완료된 건 건너뛰기
  const pending = JOBS.filter(j => !progress.completed.includes(j.slug));
  console.log(`📋 처리 예정: ${pending.length}개\n`);

  let done = 0;
  let failed = 0;
  const startTime = Date.now();

  for (let i = 0; i < pending.length; i++) {
    const job = pending[i];
    const totalIndex = JOBS.findIndex(j => j.slug === job.slug) + 1;
    const elapsed = Math.floor((Date.now() - startTime) / 1000);
    const eta = i > 0 ? Math.floor((elapsed / i) * (pending.length - i)) : 0;
    const etaStr = eta > 0 ? `ETA ${Math.floor(eta / 60)}분${eta % 60}초` : '';

    console.log(`\n[${totalIndex}/75] 📝 ${job.name} ${etaStr}`);

    // 1. 이미지 생성 요청
    const taskId = await requestImage(job.prompt, job.name);
    if (!taskId) {
      progress.failed.push(job.slug);
      saveProgress(progress);
      failed++;
      continue;
    }
    console.log(`   🎨 생성 중 (taskId: ${taskId.substring(0, 8)}...)`);

    // 2. 완료 대기
    const evolinkUrl = await waitForCompletion(taskId, job.name);
    if (!evolinkUrl) {
      progress.failed.push(job.slug);
      saveProgress(progress);
      failed++;
      continue;
    }

    // 3. 다운로드
    const filename = `job-${job.slug}.webp`;
    const localPath = path.join(TEMP_DIR, filename);
    console.log(`   📥 다운로드 중...`);
    const downloaded = await downloadImage(evolinkUrl, localPath);
    if (!downloaded) {
      progress.failed.push(job.slug);
      saveProgress(progress);
      failed++;
      continue;
    }

    // 4. R2 업로드 (키: jobs/job-{slug}.webp, uploads/ prefix 없음)
    const r2Key = `jobs/${filename}`;
    console.log(`   ☁️  R2 업로드 중... (${r2Key})`);
    const uploaded = uploadToR2Remote(localPath, r2Key);
    if (!uploaded) {
      fs.unlinkSync(localPath);
      progress.failed.push(job.slug);
      saveProgress(progress);
      failed++;
      continue;
    }

    // 5. DB 업데이트
    const timestamp = Date.now();
    const imageUrl = `/uploads/jobs/${filename}?v=${timestamp}`;
    console.log(`   💾 DB 업데이트 중...`);
    const dbUpdated = updateDB(job.slug, imageUrl, job.prompt);

    // 임시 파일 삭제
    try { fs.unlinkSync(localPath); } catch (e) {}

    if (!dbUpdated) {
      console.log(`   ⚠️  이미지는 R2에 올라갔지만 DB 업데이트 실패! slug: ${job.slug}, url: ${imageUrl}`);
      // DB 실패해도 완료로 처리 (R2는 성공했으므로)
    }

    console.log(`   ✅ 완료! → ${imageUrl}`);
    progress.completed.push(job.slug);
    progress.failed = progress.failed.filter(s => s !== job.slug);
    saveProgress(progress);
    done++;

    // API 레이트 리밋 고려: 3초 대기
    if (i < pending.length - 1) {
      await new Promise(resolve => setTimeout(resolve, 3000));
    }
  }

  const totalTime = Math.floor((Date.now() - startTime) / 1000);
  console.log('\n' + '='.repeat(60));
  console.log(`✅ 완료: ${done}개 / ❌ 실패: ${failed}개`);
  console.log(`⏱️  총 소요: ${Math.floor(totalTime / 60)}분 ${totalTime % 60}초`);
  console.log(`📊 누적 완료: ${progress.completed.length}/${JOBS.length}개`);

  if (progress.failed.length > 0) {
    console.log(`\n❌ 실패한 직업 (재실행 시 자동 재시도):`);
    progress.failed.forEach(slug => console.log(`   - ${slug}`));
  }

  // 임시 디렉토리 정리
  if (progress.completed.length === JOBS.length) {
    console.log('\n🎉 모든 직업 이미지 생성 완료!');
    if (fs.existsSync(PROGRESS_FILE)) fs.unlinkSync(PROGRESS_FILE);
  }
}

main().catch(err => {
  console.error('💥 치명적 오류:', err);
  process.exit(1);
});

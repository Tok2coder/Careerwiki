import { Hono } from 'hono'
import { cors } from 'hono/cors'
import { serveStatic } from 'hono/cloudflare-workers'
import { renderer } from './renderer'

// Types
type Bindings = {
  DB: D1Database;
  KV: KVNamespace;
}

type Variables = {
  title?: string;
  description?: string;
}

const app = new Hono<{ Bindings: Bindings; Variables: Variables }>()

// Middleware
app.use('*', cors())
app.use('*', renderer)

// Serve static files
app.use('/static/*', serveStatic({ root: './public' }))

// Helper function for logo SVG (옵션 7: 플레이풀 둥근 폰트)
const getLogoSVG = (size: 'large' | 'small' = 'large') => {
  const fontSize = size === 'large' ? '48' : '28';
  const width = size === 'large' ? '320' : '180';
  const height = size === 'large' ? '80' : '40';
  
  return `
    <svg width="${width}" height="${height}" viewBox="0 0 ${width} ${height}">
      <defs>
        <linearGradient id="logoGrad" x1="0%" y1="0%" x2="100%" y2="100%">
          <stop offset="0%" style="stop-color:#4361ee;stop-opacity:1" />
          <stop offset="100%" style="stop-color:#64b5f6;stop-opacity:1" />
        </linearGradient>
      </defs>
      <text x="${parseInt(width)/2}" y="${parseInt(height)/2 + 10}" 
            font-family="'Comic Sans MS', 'Chalkboard SE', 'Marker Felt', cursive" 
            font-size="${fontSize}" font-weight="bold" 
            fill="url(#logoGrad)" text-anchor="middle">Careerwiki</text>
    </svg>
  `;
}

// Helper function to render layout
const renderLayout = (content: string, title = 'Careerwiki - AI 진로 분석 플랫폼', description = 'AI 기반 개인 맞춤형 진로 분석과 전략 리포트를 제공하는 플랫폼', isHomepage = false) => {
  return `
    <!DOCTYPE html>
    <html lang="ko">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>${title}</title>
        <meta name="description" content="${description}">
        <meta property="og:title" content="${title}">
        <meta property="og:description" content="${description}">
        <meta property="og:type" content="website">
        <meta property="og:url" content="https://careerwiki.org">
        <meta name="robots" content="index, follow">
        <link rel="canonical" href="https://careerwiki.org">
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.4.0/css/all.min.css" rel="stylesheet">
        <script>
          tailwind.config = {
            darkMode: 'class',
            theme: {
              extend: {
                colors: {
                  'wiki-bg': '#0f0f23',
                  'wiki-card': '#1a1a2e',
                  'wiki-border': '#2a2a3e',
                  'wiki-primary': '#4361ee',
                  'wiki-secondary': '#64b5f6',
                  'wiki-text': '#e0e0e0',
                  'wiki-muted': '#9ca3af',
                }
              }
            }
          }
        </script>
        <style>
          body { background: #0f0f23; color: #e0e0e0; }
          .gradient-text {
            background: linear-gradient(135deg, #4361ee 0%, #64b5f6 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
          }
          .glass-card {
            background: rgba(26, 26, 46, 0.8);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(67, 97, 238, 0.2);
          }
          .hover-glow:hover {
            box-shadow: 0 0 30px rgba(67, 97, 238, 0.3);
            transition: all 0.3s ease;
          }
          .search-input::placeholder {
            color: #6b7280;
          }
          .wiki-link {
            color: #64b5f6;
            text-decoration: none;
            transition: all 0.2s;
          }
          .wiki-link:hover {
            color: #4361ee;
            text-decoration: underline;
          }
          .google-search {
            max-width: 600px;
            margin: 0 auto;
          }
          .google-search input {
            width: 100%;
            padding: 12px 20px;
            font-size: 16px;
            border: 1px solid rgba(67, 97, 238, 0.3);
            border-radius: 24px;
            background: rgba(26, 26, 46, 0.6);
            color: #e0e0e0;
          }
          .google-search input:focus {
            outline: none;
            border-color: #4361ee;
            box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.1);
          }
        </style>
    </head>
    <body class="bg-wiki-bg text-wiki-text min-h-screen">
        ${!isHomepage ? `
        <!-- Navigation (Not on homepage) -->
        <nav class="glass-card sticky top-0 z-50 border-b border-wiki-border">
            <div class="container mx-auto px-4 py-4">
                <div class="flex items-center justify-between">
                    <a href="/" class="flex items-center">
                        ${getLogoSVG('small')}
                    </a>
                    
                    <!-- Search bar in header -->
                    <div class="flex-1 max-w-xl mx-8 hidden md:block">
                        <form action="/search" method="get">
                            <input type="text" name="q" 
                                   placeholder="직업, 전공, 진로를 검색하세요..." 
                                   class="w-full px-4 py-2 bg-wiki-bg rounded-full border border-wiki-border focus:border-wiki-primary focus:outline-none text-sm">
                        </form>
                    </div>
                    
                    <div class="hidden md:flex items-center space-x-6">
                        <a href="/analyzer" class="text-wiki-text hover:text-wiki-primary transition">
                            <i class="fas fa-brain mr-2"></i>AI 분석
                        </a>
                        <a href="/job" class="text-wiki-text hover:text-wiki-primary transition">
                            <i class="fas fa-briefcase mr-2"></i>직업
                        </a>
                        <a href="/major" class="text-wiki-text hover:text-wiki-primary transition">
                            <i class="fas fa-university mr-2"></i>전공
                        </a>
                    </div>
                    <button id="mobile-menu-btn" class="md:hidden text-wiki-text">
                        <i class="fas fa-bars text-xl"></i>
                    </button>
                </div>
            </div>
        </nav>
        
        <!-- Mobile Menu -->
        <div id="mobile-menu" class="hidden md:hidden glass-card border-b border-wiki-border">
            <div class="container mx-auto px-4 py-4 space-y-3">
                <form action="/search" method="get" class="mb-4">
                    <input type="text" name="q" 
                           placeholder="검색..." 
                           class="w-full px-4 py-2 bg-wiki-bg rounded-full border border-wiki-border focus:border-wiki-primary focus:outline-none text-sm">
                </form>
                <a href="/analyzer" class="block text-wiki-text hover:text-wiki-primary transition">
                    <i class="fas fa-brain mr-2"></i>AI 진로 분석
                </a>
                <a href="/job" class="block text-wiki-text hover:text-wiki-primary transition">
                    <i class="fas fa-briefcase mr-2"></i>직업 백과
                </a>
                <a href="/major" class="block text-wiki-text hover:text-wiki-primary transition">
                    <i class="fas fa-university mr-2"></i>전공 백과
                </a>
            </div>
        </div>
        ` : ''}
        
        <!-- Main Content -->
        <main class="${isHomepage ? '' : 'container mx-auto px-4 py-8'}">
            ${content}
        </main>
        
        <!-- Footer -->
        <footer class="glass-card border-t border-wiki-border mt-16">
            <div class="container mx-auto px-4 py-8">
                <div class="grid md:grid-cols-3 gap-8">
                    <div>
                        <h3 class="text-xl font-bold mb-4 gradient-text">Careerwiki</h3>
                        <p class="text-wiki-muted text-sm">AI 기반 개인 맞춤형 진로 분석 플랫폼</p>
                    </div>
                    <div>
                        <h4 class="text-lg font-semibold mb-3">바로가기</h4>
                        <ul class="space-y-2 text-sm">
                            <li><a href="/analyzer" class="wiki-link">AI 진로 분석기</a></li>
                            <li><a href="/job" class="wiki-link">직업 백과</a></li>
                            <li><a href="/major" class="wiki-link">전공 백과</a></li>
                        </ul>
                    </div>
                    <div>
                        <h4 class="text-lg font-semibold mb-3">문의</h4>
                        <p class="text-sm text-wiki-muted">contact@careerwiki.org</p>
                    </div>
                </div>
                <div class="mt-8 pt-8 border-t border-wiki-border text-center text-sm text-wiki-muted">
                    <p>© 2024 Careerwiki. All rights reserved. | careerwiki.org</p>
                </div>
            </div>
        </footer>
        
        <script>
            // Mobile menu toggle
            const menuBtn = document.getElementById('mobile-menu-btn');
            if(menuBtn) {
                menuBtn.addEventListener('click', () => {
                    document.getElementById('mobile-menu').classList.toggle('hidden');
                });
            }
        </script>
    </body>
    </html>
  `
}

// Homepage - Google style simplicity
app.get('/', (c) => {
  const content = `
    <div class="min-h-screen flex flex-col items-center justify-center px-4">
        <!-- Logo -->
        <div class="mb-12">
            ${getLogoSVG('large')}
        </div>
        
        <!-- Search Bar -->
        <div class="google-search w-full mb-8">
            <form action="/search" method="get">
                <input type="text" name="q" 
                       placeholder="직업, 전공, 진로를 검색하세요..." 
                       autofocus
                       class="google-search-input">
            </form>
        </div>
        
        <!-- Quick Actions -->
        <div class="flex gap-4 mb-12">
            <a href="/analyzer" 
               class="px-6 py-3 bg-wiki-primary text-white rounded-lg hover:bg-blue-600 transition">
                <i class="fas fa-brain mr-2"></i>AI 진로 분석
            </a>
            <a href="/job" 
               class="px-6 py-3 border border-wiki-primary text-wiki-primary rounded-lg hover:bg-wiki-primary hover:text-white transition">
                직업 탐색
            </a>
        </div>
        
        <!-- Simple Stats -->
        <div class="text-center text-wiki-muted text-sm">
            <p>1,000+ 직업 정보 · 500+ 전공 정보 · AI 기반 맞춤 분석</p>
        </div>
    </div>
  `
  
  return c.html(renderLayout(content, 'Careerwiki - AI 진로 분석 플랫폼', 'AI 기반 개인 맞춤형 진로 분석과 전략 리포트를 제공하는 플랫폼', true))
})

// AI Analyzer Page - Updated pricing
app.get('/analyzer', (c) => {
  const content = `
    <div class="max-w-4xl mx-auto">
        <h1 class="text-4xl font-bold mb-8 gradient-text text-center">
            <i class="fas fa-brain mr-3"></i>AI 커리어 분석기
        </h1>
        
        <div class="glass-card p-8 rounded-2xl mb-8">
            <h2 class="text-2xl font-bold mb-6">📊 퍼스널 커리어 분석 & 전략 리포트</h2>
            
            <div class="bg-wiki-bg p-6 rounded-xl mb-6">
                <h3 class="text-lg font-semibold mb-4 text-wiki-primary">제공되는 분석 내용</h3>
                <div class="grid md:grid-cols-2 gap-4">
                    <div class="flex items-start">
                        <i class="fas fa-check-circle text-wiki-secondary mr-3 mt-1"></i>
                        <div>
                            <h4 class="font-semibold">포지션 추천</h4>
                            <p class="text-sm text-wiki-muted">경험과 스킬 기반 최적 포지션</p>
                        </div>
                    </div>
                    <div class="flex items-start">
                        <i class="fas fa-check-circle text-wiki-secondary mr-3 mt-1"></i>
                        <div>
                            <h4 class="font-semibold">시장 적합도</h4>
                            <p class="text-sm text-wiki-muted">현재 시장 수요와 경쟁력 분석</p>
                        </div>
                    </div>
                    <div class="flex items-start">
                        <i class="fas fa-check-circle text-wiki-secondary mr-3 mt-1"></i>
                        <div>
                            <h4 class="font-semibold">스킬 갭 진단</h4>
                            <p class="text-sm text-wiki-muted">부족한 역량과 학습 우선순위</p>
                        </div>
                    </div>
                    <div class="flex items-start">
                        <i class="fas fa-check-circle text-wiki-secondary mr-3 mt-1"></i>
                        <div>
                            <h4 class="font-semibold">급여 예측</h4>
                            <p class="text-sm text-wiki-muted">경력 단계별 예상 연봉 범위</p>
                        </div>
                    </div>
                </div>
            </div>
            
            <form id="analyzer-form" class="space-y-6">
                <!-- Basic Info -->
                <div>
                    <label class="block text-lg font-semibold mb-3">기본 정보</label>
                    <div class="grid md:grid-cols-2 gap-4">
                        <input type="text" name="name" placeholder="이름" 
                               class="w-full px-4 py-3 bg-wiki-bg rounded-lg border border-wiki-border focus:border-wiki-primary focus:outline-none">
                        <input type="number" name="age" placeholder="나이" 
                               class="w-full px-4 py-3 bg-wiki-bg rounded-lg border border-wiki-border focus:border-wiki-primary focus:outline-none">
                    </div>
                </div>
                
                <!-- Experience -->
                <div>
                    <label class="block text-lg font-semibold mb-3">경력 사항</label>
                    <textarea name="experience" rows="4" 
                              placeholder="현재 직무, 경력 년수, 주요 프로젝트 등을 자유롭게 작성해주세요..."
                              class="w-full px-4 py-3 bg-wiki-bg rounded-lg border border-wiki-border focus:border-wiki-primary focus:outline-none"></textarea>
                </div>
                
                <!-- Skills -->
                <div>
                    <label class="block text-lg font-semibold mb-3">보유 스킬</label>
                    <input type="text" name="skills" 
                           placeholder="예: Python, 데이터 분석, 프로젝트 관리, 영어" 
                           class="w-full px-4 py-3 bg-wiki-bg rounded-lg border border-wiki-border focus:border-wiki-primary focus:outline-none">
                </div>
                
                <!-- Goals -->
                <div>
                    <label class="block text-lg font-semibold mb-3">커리어 목표</label>
                    <textarea name="goals" rows="3" 
                              placeholder="향후 3-5년 내 달성하고 싶은 커리어 목표를 작성해주세요..."
                              class="w-full px-4 py-3 bg-wiki-bg rounded-lg border border-wiki-border focus:border-wiki-primary focus:outline-none"></textarea>
                </div>
                
                <!-- Submit Button -->
                <div class="text-center">
                    <button type="submit" 
                            class="px-12 py-4 bg-gradient-to-r from-wiki-primary to-wiki-secondary text-white font-bold rounded-xl hover-glow transition transform hover:scale-105">
                        <i class="fas fa-magic mr-2"></i>AI 분석 시작하기
                    </button>
                </div>
            </form>
        </div>
        
        <!-- Updated Pricing - 2 tiers -->
        <div class="glass-card p-8 rounded-2xl">
            <h3 class="text-2xl font-bold mb-6 text-center">요금제</h3>
            <div class="grid md:grid-cols-2 gap-8 max-w-2xl mx-auto">
                <!-- Free Tier -->
                <div class="bg-wiki-bg p-6 rounded-xl text-center">
                    <h4 class="text-xl font-bold mb-3">무료 버전</h4>
                    <p class="text-3xl font-bold gradient-text mb-4">₩0</p>
                    <ul class="space-y-2 text-sm text-wiki-muted mb-6 text-left">
                        <li><i class="fas fa-check text-wiki-secondary mr-2"></i>기본 진로 분석</li>
                        <li><i class="fas fa-check text-wiki-secondary mr-2"></i>포지션 추천 3개</li>
                        <li><i class="fas fa-check text-wiki-secondary mr-2"></i>PDF 리포트</li>
                    </ul>
                    <button class="w-full py-3 border border-wiki-primary text-wiki-primary rounded-lg hover:bg-wiki-primary hover:text-white transition">
                        무료 시작하기
                    </button>
                </div>
                
                <!-- Pro Tier -->
                <div class="bg-wiki-bg p-6 rounded-xl text-center border-2 border-wiki-primary">
                    <span class="bg-wiki-primary text-white px-3 py-1 rounded-full text-sm">추천</span>
                    <h4 class="text-xl font-bold mb-3 mt-2">Pro 버전</h4>
                    <p class="text-3xl font-bold gradient-text mb-4">₩9,900</p>
                    <ul class="space-y-2 text-sm text-wiki-muted mb-6 text-left">
                        <li><i class="fas fa-check text-wiki-secondary mr-2"></i>심층 진로 분석</li>
                        <li><i class="fas fa-check text-wiki-secondary mr-2"></i>포지션 추천 10개</li>
                        <li><i class="fas fa-check text-wiki-secondary mr-2"></i>스킬 갭 상세 분석</li>
                        <li><i class="fas fa-check text-wiki-secondary mr-2"></i>맞춤형 학습 로드맵</li>
                        <li><i class="fas fa-check text-wiki-secondary mr-2"></i>1:1 전문가 피드백 (예정)</li>
                    </ul>
                    <button class="w-full py-3 bg-wiki-primary text-white rounded-lg hover:bg-blue-600 transition">
                        Pro 시작하기
                    </button>
                </div>
            </div>
        </div>
    </div>
    
    <script>
        document.getElementById('analyzer-form').addEventListener('submit', async (e) => {
            e.preventDefault();
            alert('AI 분석이 시작되었습니다. 2-3분 내에 결과를 받아보실 수 있습니다.');
            // TODO: Implement actual AI analysis
        });
    </script>
  `
  
  return c.html(renderLayout(content, 'AI 커리어 분석기 - Careerwiki', 'AI 기반 개인 맞춤형 진로 분석과 커리어 전략 리포트'))
})

// Job Wiki Page
app.get('/job/:slug?', async (c) => {
  const slug = c.req.param('slug')
  
  if (!slug) {
    // Job list page
    const content = `
      <div class="max-w-6xl mx-auto">
          <h1 class="text-4xl font-bold mb-8 gradient-text text-center">
              <i class="fas fa-briefcase mr-3"></i>직업 백과사전
          </h1>
          
          <div class="grid md:grid-cols-3 gap-6">
              <!-- Sample job cards -->
              <a href="/job/software-engineer" class="glass-card p-6 rounded-xl hover-glow block">
                  <h3 class="text-xl font-bold mb-2">소프트웨어 엔지니어</h3>
                  <p class="text-sm text-wiki-muted mb-3">소프트웨어를 설계, 개발, 테스트하는 전문가</p>
                  <div class="flex justify-between text-sm">
                      <span><i class="fas fa-won-sign text-wiki-secondary"></i> 6,500만원</span>
                      <span><i class="fas fa-chart-line text-wiki-secondary"></i> 성장중</span>
                  </div>
              </a>
              <a href="/job/data-scientist" class="glass-card p-6 rounded-xl hover-glow block">
                  <h3 class="text-xl font-bold mb-2">데이터 사이언티스트</h3>
                  <p class="text-sm text-wiki-muted mb-3">데이터를 분석하여 인사이트를 도출하는 전문가</p>
                  <div class="flex justify-between text-sm">
                      <span><i class="fas fa-won-sign text-wiki-secondary"></i> 7,000만원</span>
                      <span><i class="fas fa-chart-line text-wiki-secondary"></i> 급성장</span>
                  </div>
              </a>
              <a href="/job/product-manager" class="glass-card p-6 rounded-xl hover-glow block">
                  <h3 class="text-xl font-bold mb-2">프로덕트 매니저</h3>
                  <p class="text-sm text-wiki-muted mb-3">제품 전략과 개발을 총괄하는 관리자</p>
                  <div class="flex justify-between text-sm">
                      <span><i class="fas fa-won-sign text-wiki-secondary"></i> 8,000만원</span>
                      <span><i class="fas fa-chart-line text-wiki-secondary"></i> 성장중</span>
                  </div>
              </a>
          </div>
      </div>
    `
    return c.html(renderLayout(content, '직업 백과사전 - Careerwiki'))
  }
  
  // Individual job page (example: software-engineer)
  const jobData = {
    'software-engineer': {
      title: '소프트웨어 엔지니어',
      summary: '소프트웨어를 설계, 개발, 유지보수하는 IT 전문가',
      avgSalary: '6,500만원',
      growth: '매우 높음',
      description: '소프트웨어 엔지니어는 컴퓨터 프로그램과 애플리케이션을 설계, 개발, 테스트하는 전문가입니다.',
      tasks: [
        '소프트웨어 요구사항 분석 및 설계',
        '프로그래밍 언어를 사용한 코드 작성',
        '버그 수정 및 성능 최적화',
        '기술 문서 작성 및 코드 리뷰',
        '팀 협업 및 프로젝트 관리'
      ],
      skills: [
        'Python, Java, JavaScript 등 프로그래밍 언어',
        '자료구조와 알고리즘',
        '데이터베이스 설계 및 관리',
        'Git 등 버전 관리 시스템',
        '문제 해결 능력과 논리적 사고'
      ],
      education: [
        '컴퓨터공학과',
        '소프트웨어학과',
        '정보통신공학과',
        '전산학과'
      ]
    }
  }
  
  const job = jobData[slug] || jobData['software-engineer']
  
  const content = `
    <div class="max-w-4xl mx-auto">
        <!-- Breadcrumb -->
        <nav class="text-sm mb-6">
            <a href="/" class="wiki-link">홈</a> / 
            <a href="/job" class="wiki-link">직업</a> / 
            <span class="text-wiki-muted">${job.title}</span>
        </nav>
        
        <div class="flex gap-8">
            <!-- Main Content -->
            <div class="flex-1">
                <div class="glass-card p-8 rounded-2xl mb-8">
                    <h1 class="text-4xl font-bold mb-4">${job.title}</h1>
                    <p class="text-lg text-wiki-muted mb-6">${job.summary}</p>
                    
                    <!-- Key Info -->
                    <div class="grid md:grid-cols-3 gap-4 mb-8">
                        <div class="bg-wiki-bg p-4 rounded-lg">
                            <p class="text-sm text-wiki-muted mb-1">평균 연봉</p>
                            <p class="text-xl font-bold text-wiki-primary">${job.avgSalary}</p>
                        </div>
                        <div class="bg-wiki-bg p-4 rounded-lg">
                            <p class="text-sm text-wiki-muted mb-1">성장 전망</p>
                            <p class="text-xl font-bold text-wiki-secondary">${job.growth}</p>
                        </div>
                        <div class="bg-wiki-bg p-4 rounded-lg">
                            <p class="text-sm text-wiki-muted mb-1">난이도</p>
                            <p class="text-xl font-bold text-yellow-500">중상</p>
                        </div>
                    </div>
                    
                    <!-- Description -->
                    <section class="mb-8">
                        <h2 class="text-2xl font-bold mb-4 gradient-text">개요</h2>
                        <p class="text-wiki-text leading-relaxed">${job.description}</p>
                    </section>
                    
                    <!-- Main Tasks -->
                    <section class="mb-8">
                        <h2 class="text-2xl font-bold mb-4 gradient-text">주요 업무</h2>
                        <ul class="space-y-2">
                            ${job.tasks.map(task => `
                                <li class="flex items-start">
                                    <i class="fas fa-check-circle text-wiki-secondary mr-3 mt-1"></i>
                                    <span>${task}</span>
                                </li>
                            `).join('')}
                        </ul>
                    </section>
                    
                    <!-- Required Skills -->
                    <section class="mb-8">
                        <h2 class="text-2xl font-bold mb-4 gradient-text">필요 역량</h2>
                        <div class="flex flex-wrap gap-2">
                            ${job.skills.map(skill => `
                                <span class="px-4 py-2 bg-wiki-bg rounded-full text-sm">${skill}</span>
                            `).join('')}
                        </div>
                    </section>
                    
                    <!-- Education -->
                    <section class="mb-8">
                        <h2 class="text-2xl font-bold mb-4 gradient-text">관련 학과</h2>
                        <div class="grid md:grid-cols-2 gap-4">
                            ${job.education.map(edu => `
                                <a href="/major/${edu.toLowerCase().replace(/\s+/g, '-')}" class="wiki-link">
                                    <div class="bg-wiki-bg p-4 rounded-lg hover:border-wiki-primary border border-transparent transition">
                                        <i class="fas fa-university mr-2"></i>${edu}
                                    </div>
                                </a>
                            `).join('')}
                        </div>
                    </section>
                </div>
                
                <!-- Comments Section -->
                <div class="glass-card p-8 rounded-2xl">
                    <h2 class="text-2xl font-bold mb-6">댓글</h2>
                    <form class="mb-6">
                        <textarea placeholder="경험이나 조언을 공유해주세요..." 
                                  class="w-full px-4 py-3 bg-wiki-bg rounded-lg border border-wiki-border focus:border-wiki-primary focus:outline-none mb-4"
                                  rows="3"></textarea>
                        <button type="submit" class="px-6 py-2 bg-wiki-primary text-white rounded-lg hover:bg-blue-600 transition">
                            댓글 작성
                        </button>
                    </form>
                    
                    <!-- Sample Comments -->
                    <div class="space-y-4">
                        <div class="bg-wiki-bg p-4 rounded-lg">
                            <div class="flex justify-between mb-2">
                                <span class="font-semibold">현직자A</span>
                                <span class="text-sm text-wiki-muted">2024.01.15</span>
                            </div>
                            <p class="text-wiki-text">실제로 일해보니 문제 해결 능력이 가장 중요한 것 같아요. 기술은 계속 바뀌지만 문제를 분석하고 해결하는 능력은 변하지 않습니다.</p>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Sidebar -->
            <aside class="w-64 hidden lg:block">
                <div class="glass-card p-6 rounded-xl sticky top-24">
                    <h3 class="font-bold mb-4">목차</h3>
                    <ul class="space-y-2 text-sm">
                        <li><a href="#overview" class="wiki-link">개요</a></li>
                        <li><a href="#tasks" class="wiki-link">주요 업무</a></li>
                        <li><a href="#skills" class="wiki-link">필요 역량</a></li>
                        <li><a href="#education" class="wiki-link">관련 학과</a></li>
                    </ul>
                    
                    <hr class="my-6 border-wiki-border">
                    
                    <h3 class="font-bold mb-4">관련 직업</h3>
                    <ul class="space-y-2 text-sm">
                        <li><a href="/job/data-scientist" class="wiki-link">데이터 사이언티스트</a></li>
                        <li><a href="/job/devops-engineer" class="wiki-link">DevOps 엔지니어</a></li>
                        <li><a href="/job/ai-engineer" class="wiki-link">AI 엔지니어</a></li>
                    </ul>
                </div>
            </aside>
        </div>
    </div>
  `
  
  return c.html(renderLayout(content, `${job.title} - 직업 정보 | Careerwiki`))
})

// Major Wiki Page
app.get('/major/:slug?', async (c) => {
  const slug = c.req.param('slug')
  
  if (!slug) {
    // Major list page
    const content = `
      <div class="max-w-6xl mx-auto">
          <h1 class="text-4xl font-bold mb-8 gradient-text text-center">
              <i class="fas fa-university mr-3"></i>전공 백과사전
          </h1>
          
          <div class="grid md:grid-cols-3 gap-6">
              <a href="/major/computer-science" class="glass-card p-6 rounded-xl hover-glow block">
                  <h3 class="text-xl font-bold mb-2">컴퓨터공학과</h3>
                  <p class="text-sm text-wiki-muted mb-3">컴퓨터 시스템과 소프트웨어를 연구하는 학과</p>
                  <div class="text-sm">
                      <span class="text-wiki-secondary"><i class="fas fa-briefcase"></i> 취업률 95%</span>
                  </div>
              </a>
              <a href="/major/business" class="glass-card p-6 rounded-xl hover-glow block">
                  <h3 class="text-xl font-bold mb-2">경영학과</h3>
                  <p class="text-sm text-wiki-muted mb-3">기업 경영과 비즈니스를 연구하는 학과</p>
                  <div class="text-sm">
                      <span class="text-wiki-secondary"><i class="fas fa-briefcase"></i> 취업률 87%</span>
                  </div>
              </a>
              <a href="/major/law" class="glass-card p-6 rounded-xl hover-glow block">
                  <h3 class="text-xl font-bold mb-2">법학과</h3>
                  <p class="text-sm text-wiki-muted mb-3">법률과 법체계를 연구하는 학과</p>
                  <div class="text-sm">
                      <span class="text-wiki-secondary"><i class="fas fa-briefcase"></i> 취업률 78%</span>
                  </div>
              </a>
          </div>
      </div>
    `
    return c.html(renderLayout(content, '전공 백과사전 - Careerwiki'))
  }
  
  // Individual major page
  const content = `
    <div class="max-w-4xl mx-auto">
        <div class="glass-card p-8 rounded-2xl">
            <h1 class="text-4xl font-bold mb-4">컴퓨터공학과</h1>
            <p class="text-lg text-wiki-muted mb-6">컴퓨터 시스템, 소프트웨어, 네트워크를 연구하는 공학 분야</p>
            
            <!-- Similar structure to job page -->
        </div>
    </div>
  `
  
  return c.html(renderLayout(content, '컴퓨터공학과 - 전공 정보 | Careerwiki'))
})

// Search API
app.get('/api/search', async (c) => {
  const query = c.req.query('q') || ''
  
  // Mock search results
  const results = [
    { type: 'job', title: '소프트웨어 엔지니어', url: '/job/software-engineer' },
    { type: 'major', title: '컴퓨터공학과', url: '/major/computer-science' }
  ]
  
  return c.json({ query, results })
})

// Comments API
app.post('/api/comments', async (c) => {
  const body = await c.req.json()
  // TODO: Save to D1 database
  return c.json({ success: true, comment: body })
})

// Search Page
app.get('/search', (c) => {
  const query = c.req.query('q') || ''
  
  const content = `
    <div class="max-w-4xl mx-auto">
        <h1 class="text-3xl font-bold mb-6">검색 결과: "${query}"</h1>
        
        <div class="space-y-4">
            <a href="/job/software-engineer" class="glass-card p-6 rounded-xl hover-glow block">
                <span class="text-sm text-wiki-secondary">직업</span>
                <h3 class="text-xl font-bold mt-1">소프트웨어 엔지니어</h3>
                <p class="text-wiki-muted mt-2">소프트웨어를 설계, 개발, 테스트하는 전문가</p>
            </a>
        </div>
    </div>
  `
  
  return c.html(renderLayout(content, `"${query}" 검색 결과 - Careerwiki`))
})

// About Page
app.get('/about', (c) => {
  const content = `
    <div class="max-w-4xl mx-auto">
        <div class="glass-card p-8 rounded-2xl">
            <h1 class="text-4xl font-bold mb-6 gradient-text">Careerwiki 소개</h1>
            
            <section class="mb-8">
                <h2 class="text-2xl font-bold mb-4">우리의 미션</h2>
                <p class="text-wiki-text leading-relaxed mb-4">
                    Careerwiki는 AI 기술을 활용하여 개인 맞춤형 진로 분석과 전략을 제공하는 플랫폼입니다. 
                    우리는 모든 사람이 자신에게 맞는 최적의 커리어 경로를 찾을 수 있도록 돕습니다.
                </p>
            </section>
            
            <section class="mb-8">
                <h2 class="text-2xl font-bold mb-4">핵심 가치</h2>
                <div class="grid md:grid-cols-3 gap-6">
                    <div class="bg-wiki-bg p-6 rounded-xl">
                        <i class="fas fa-bullseye text-3xl text-wiki-primary mb-3"></i>
                        <h3 class="font-bold mb-2">정확성</h3>
                        <p class="text-sm text-wiki-muted">검증된 데이터와 AI 분석으로 신뢰할 수 있는 정보 제공</p>
                    </div>
                    <div class="bg-wiki-bg p-6 rounded-xl">
                        <i class="fas fa-users text-3xl text-wiki-primary mb-3"></i>
                        <h3 class="font-bold mb-2">커뮤니티</h3>
                        <p class="text-sm text-wiki-muted">현직자와 전문가의 실제 경험 공유</p>
                    </div>
                    <div class="bg-wiki-bg p-6 rounded-xl">
                        <i class="fas fa-rocket text-3xl text-wiki-primary mb-3"></i>
                        <h3 class="font-bold mb-2">혁신</h3>
                        <p class="text-sm text-wiki-muted">최신 AI 기술로 개인 맞춤 진로 솔루션</p>
                    </div>
                </div>
            </section>
            
            <section>
                <h2 class="text-2xl font-bold mb-4">연락처</h2>
                <p class="text-wiki-text">
                    문의사항이 있으시면 <a href="mailto:contact@careerwiki.org" class="wiki-link">contact@careerwiki.org</a>로 연락주세요.
                </p>
            </section>
        </div>
    </div>
  `
  
  return c.html(renderLayout(content, 'Careerwiki 소개'))
})

// Logo options page
app.get('/logo-options', (c) => {
  const logoOptionsHTML = `
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Careerwiki 로고 옵션</title>
    <style>
        body { 
            background: #0f0f23; 
            color: #e0e0e0; 
            font-family: -apple-system, BlinkMacSystemFont, sans-serif;
            padding: 40px;
        }
        .logo-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 40px;
            max-width: 1200px;
            margin: 0 auto;
        }
        .logo-option {
            background: rgba(26, 26, 46, 0.8);
            padding: 30px;
            border-radius: 16px;
            text-align: center;
            border: 1px solid rgba(67, 97, 238, 0.2);
        }
        .logo-option:hover {
            box-shadow: 0 0 30px rgba(67, 97, 238, 0.3);
        }
        .option-number {
            color: #64b5f6;
            font-size: 18px;
            margin-bottom: 20px;
            font-weight: bold;
        }
        .logo-container {
            background: #0f0f23;
            padding: 40px;
            border-radius: 12px;
            margin-bottom: 20px;
            min-height: 150px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        h1 {
            text-align: center;
            color: #4361ee;
            margin-bottom: 40px;
        }
    </style>
</head>
<body>
    <h1>Careerwiki 로고 옵션들</h1>
    
    <div class="logo-grid">
        <!-- Option 1: 그라디언트 텍스트 + 아이콘 -->
        <div class="logo-option">
            <div class="option-number">옵션 1: 그라디언트 + 졸업 모자</div>
            <div class="logo-container">
                <svg width="280" height="80" viewBox="0 0 280 80">
                    <defs>
                        <linearGradient id="grad1" x1="0%" y1="0%" x2="100%" y2="0%">
                            <stop offset="0%" style="stop-color:#4361ee;stop-opacity:1" />
                            <stop offset="100%" style="stop-color:#64b5f6;stop-opacity:1" />
                        </linearGradient>
                    </defs>
                    <!-- 졸업 모자 아이콘 -->
                    <path d="M15 35 L40 25 L65 35 L40 45 Z" fill="url(#grad1)"/>
                    <path d="M40 45 L40 55" stroke="url(#grad1)" stroke-width="3"/>
                    <circle cx="40" cy="55" r="3" fill="url(#grad1)"/>
                    <!-- 텍스트 -->
                    <text x="85" y="45" font-family="Arial, sans-serif" font-size="32" font-weight="bold" fill="url(#grad1)">Careerwiki</text>
                </svg>
            </div>
        </div>

        <!-- Option 2: 단순 굵은 텍스트 -->
        <div class="logo-option">
            <div class="option-number">옵션 2: 깔끔한 단색 (구글 스타일)</div>
            <div class="logo-container">
                <svg width="280" height="80" viewBox="0 0 280 80">
                    <text x="140" y="50" font-family="Arial, sans-serif" font-size="36" font-weight="bold" 
                          fill="#4361ee" text-anchor="middle">Careerwiki</text>
                </svg>
            </div>
        </div>

        <!-- Option 3: 책 아이콘 + 텍스트 -->
        <div class="logo-option">
            <div class="option-number">옵션 3: 책 아이콘 + 텍스트</div>
            <div class="logo-container">
                <svg width="280" height="80" viewBox="0 0 280 80">
                    <defs>
                        <linearGradient id="grad3" x1="0%" y1="0%" x2="100%" y2="0%">
                            <stop offset="0%" style="stop-color:#4361ee;stop-opacity:1" />
                            <stop offset="100%" style="stop-color:#64b5f6;stop-opacity:1" />
                        </linearGradient>
                    </defs>
                    <!-- 책 아이콘 -->
                    <rect x="20" y="25" width="40" height="30" fill="none" stroke="url(#grad3)" stroke-width="3" rx="2"/>
                    <line x1="40" y1="25" x2="40" y2="55" stroke="url(#grad3)" stroke-width="2"/>
                    <!-- 텍스트 -->
                    <text x="75" y="45" font-family="Arial, sans-serif" font-size="30" font-weight="600" fill="url(#grad3)">Careerwiki</text>
                </svg>
            </div>
        </div>

        <!-- Option 4: CW 이니셜 -->
        <div class="logo-option">
            <div class="option-number">옵션 4: CW 모노그램</div>
            <div class="logo-container">
                <svg width="280" height="80" viewBox="0 0 280 80">
                    <defs>
                        <linearGradient id="grad4" x1="0%" y1="0%" x2="100%" y2="0%">
                            <stop offset="0%" style="stop-color:#4361ee;stop-opacity:1" />
                            <stop offset="100%" style="stop-color:#64b5f6;stop-opacity:1" />
                        </linearGradient>
                    </defs>
                    <!-- CW 모노그램 -->
                    <circle cx="40" cy="40" r="25" fill="none" stroke="url(#grad4)" stroke-width="3"/>
                    <text x="40" y="50" font-family="Arial, sans-serif" font-size="24" font-weight="bold" 
                          fill="url(#grad4)" text-anchor="middle">CW</text>
                    <!-- 텍스트 -->
                    <text x="85" y="45" font-family="Arial, sans-serif" font-size="28" font-weight="600" fill="#4361ee">Careerwiki</text>
                </svg>
            </div>
        </div>

        <!-- Option 5: 미니멀 타이포 -->
        <div class="logo-option">
            <div class="option-number">옵션 5: 미니멀 타이포그래피</div>
            <div class="logo-container">
                <svg width="280" height="80" viewBox="0 0 280 80">
                    <text x="140" y="38" font-family="Georgia, serif" font-size="32" font-weight="300" 
                          fill="#4361ee" text-anchor="middle">Career</text>
                    <text x="140" y="58" font-family="Georgia, serif" font-size="32" font-weight="700" 
                          fill="#64b5f6" text-anchor="middle">Wiki</text>
                </svg>
            </div>
        </div>

        <!-- Option 6: 나침반 아이콘 (진로 상징) -->
        <div class="logo-option">
            <div class="option-number">옵션 6: 나침반 + 텍스트</div>
            <div class="logo-container">
                <svg width="280" height="80" viewBox="0 0 280 80">
                    <defs>
                        <linearGradient id="grad6" x1="0%" y1="0%" x2="100%" y2="0%">
                            <stop offset="0%" style="stop-color:#4361ee;stop-opacity:1" />
                            <stop offset="100%" style="stop-color:#64b5f6;stop-opacity:1" />
                        </linearGradient>
                    </defs>
                    <!-- 나침반 아이콘 -->
                    <circle cx="40" cy="40" r="20" fill="none" stroke="url(#grad6)" stroke-width="2.5"/>
                    <path d="M40 30 L45 40 L40 50 L35 40 Z" fill="url(#grad6)"/>
                    <circle cx="40" cy="40" r="3" fill="url(#grad6)"/>
                    <!-- 텍스트 -->
                    <text x="75" y="45" font-family="Arial, sans-serif" font-size="30" font-weight="600" fill="#4361ee">Careerwiki</text>
                </svg>
            </div>
        </div>

        <!-- Option 7: 플레이풀 -->
        <div class="logo-option">
            <div class="option-number">옵션 7: 플레이풀 (둥근 폰트)</div>
            <div class="logo-container">
                <svg width="280" height="80" viewBox="0 0 280 80">
                    <defs>
                        <linearGradient id="grad7" x1="0%" y1="0%" x2="100%" y2="100%">
                            <stop offset="0%" style="stop-color:#4361ee;stop-opacity:1" />
                            <stop offset="100%" style="stop-color:#64b5f6;stop-opacity:1" />
                        </linearGradient>
                    </defs>
                    <text x="140" y="50" font-family="Comic Sans MS, cursive" font-size="36" font-weight="bold" 
                          fill="url(#grad7)" text-anchor="middle">Careerwiki</text>
                </svg>
            </div>
        </div>

        <!-- Option 8: 한글 조합 -->
        <div class="logo-option">
            <div class="option-number">옵션 8: 한글 포함</div>
            <div class="logo-container">
                <svg width="280" height="80" viewBox="0 0 280 80">
                    <text x="140" y="35" font-family="Arial, sans-serif" font-size="14" font-weight="400" 
                          fill="#64b5f6" text-anchor="middle">커리어위키</text>
                    <text x="140" y="55" font-family="Arial, sans-serif" font-size="30" font-weight="bold" 
                          fill="#4361ee" text-anchor="middle">Careerwiki</text>
                </svg>
            </div>
        </div>
    </div>

    <div style="margin-top: 60px; text-align: center; color: #64b5f6;">
        <p style="font-size: 18px;">정우님, 어떤 로고가 마음에 드시나요?</p>
        <p style="color: #9ca3af;">번호를 알려주시면 해당 로고로 사이트를 업데이트하겠습니다.</p>
    </div>
</body>
</html>
  `
  return c.html(logoOptionsHTML)
})

export default app
import { Hono } from 'hono'
import { cors } from 'hono/cors'
import { serveStatic } from 'hono/cloudflare-workers'
import { renderer } from './renderer'
import { searchMajors, searchJobs, getMajorDetail, getJobDetail, JOB_CATEGORIES, APTITUDE_TYPES } from './api/careernetAPI'

// Types
type Bindings = {
  DB: D1Database;
  KV: KVNamespace;
  CAREER_NET_API_KEY?: string; // Cloudflare 환경 변수
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
          .menu-button {
            background: rgba(26, 26, 46, 0.9);
            border: 1px solid rgba(67, 97, 238, 0.3);
            padding: 10px 20px;
            border-radius: 8px;
            transition: all 0.3s;
          }
          .menu-button:hover {
            background: #4361ee;
            border-color: #4361ee;
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(67, 97, 238, 0.4);
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
                            <i class="fas fa-briefcase mr-2"></i>직업위키
                        </a>
                        <a href="/major" class="text-wiki-text hover:text-wiki-primary transition">
                            <i class="fas fa-university mr-2"></i>전공위키
                        </a>
                        <a href="/howto" class="text-wiki-text hover:text-wiki-primary transition">
                            <i class="fas fa-route mr-2"></i>HowTo
                        </a>
                        <a href="/help" class="text-wiki-text hover:text-wiki-primary transition">
                            <i class="fas fa-question-circle mr-2"></i>도움말
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
                    <i class="fas fa-brain mr-2"></i>AI 분석
                </a>
                <a href="/job" class="block text-wiki-text hover:text-wiki-primary transition">
                    <i class="fas fa-briefcase mr-2"></i>직업위키
                </a>
                <a href="/major" class="block text-wiki-text hover:text-wiki-primary transition">
                    <i class="fas fa-university mr-2"></i>전공위키
                </a>
                <a href="/howto" class="block text-wiki-text hover:text-wiki-primary transition">
                    <i class="fas fa-route mr-2"></i>HowTo
                </a>
                <a href="/help" class="block text-wiki-text hover:text-wiki-primary transition">
                    <i class="fas fa-question-circle mr-2"></i>도움말
                </a>
            </div>
        </div>
        ` : ''}
        
        <!-- Main Content -->
        <main class="${isHomepage ? '' : 'container mx-auto px-4 py-8'}">
            ${content}
        </main>
        
        <!-- Footer - Minimal & Trendy -->
        <footer class="border-t border-wiki-border mt-16">
            <div class="container mx-auto px-4 py-6">
                <div class="flex flex-col md:flex-row items-center justify-between gap-4">
                    <!-- Left: Logo & Links -->
                    <div class="flex items-center gap-6">
                        <span class="font-bold text-lg gradient-text">Careerwiki</span>
                        <div class="hidden md:flex items-center gap-4 text-sm">
                            <a href="/analyzer" class="text-wiki-muted hover:text-wiki-primary transition">AI 분석</a>
                            <span class="text-wiki-border">·</span>
                            <a href="/job" class="text-wiki-muted hover:text-wiki-primary transition">직업위키</a>
                            <span class="text-wiki-border">·</span>
                            <a href="/major" class="text-wiki-muted hover:text-wiki-primary transition">전공위키</a>
                            <span class="text-wiki-border">·</span>
                            <a href="/howto" class="text-wiki-muted hover:text-wiki-primary transition">HowTo</a>
                            <span class="text-wiki-border">·</span>
                            <a href="/help" class="text-wiki-muted hover:text-wiki-primary transition">도움말</a>
                        </div>
                    </div>
                    
                    <!-- Right: Contact & Copyright -->
                    <div class="flex items-center gap-4 text-sm text-wiki-muted">
                        <a href="mailto:contact@careerwiki.org" class="hover:text-wiki-primary transition">
                            <i class="fas fa-envelope mr-1"></i>contact@careerwiki.org
                        </a>
                        <span class="hidden md:inline text-wiki-border">|</span>
                        <span>© 2024 Careerwiki</span>
                    </div>
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
        <script src="/static/api-client.js"></script>
    </body>
    </html>
  `
}

// Homepage - Google style with menu buttons
app.get('/', (c) => {
  const content = `
    <div class="min-h-screen flex flex-col items-center justify-center px-4">
        <!-- Logo -->
        <div class="mb-8">
            ${getLogoSVG('large')}
        </div>
        
        <!-- Search Bar -->
        <div class="google-search w-full mb-10">
            <form action="/search" method="get">
                <input type="text" name="q" 
                       placeholder="직업 · 전공 · 진로 인사이트를 검색하세요..." 
                       autofocus
                       class="google-search-input">
            </form>
        </div>
        
        <!-- Main Menu Buttons -->
        <div class="grid grid-cols-2 md:grid-cols-5 gap-4 max-w-3xl w-full">
            <a href="/analyzer" class="menu-button text-center group">
                <i class="fas fa-brain text-2xl mb-2 text-wiki-secondary group-hover:text-white"></i>
                <div class="text-sm">AI 분석</div>
            </a>
            <a href="/job" class="menu-button text-center group">
                <i class="fas fa-briefcase text-2xl mb-2 text-wiki-secondary group-hover:text-white"></i>
                <div class="text-sm">직업위키</div>
            </a>
            <a href="/major" class="menu-button text-center group">
                <i class="fas fa-university text-2xl mb-2 text-wiki-secondary group-hover:text-white"></i>
                <div class="text-sm">전공위키</div>
            </a>
            <a href="/howto" class="menu-button text-center group">
                <i class="fas fa-route text-2xl mb-2 text-wiki-secondary group-hover:text-white"></i>
                <div class="text-sm">HowTo</div>
            </a>
            <a href="/help" class="menu-button text-center group">
                <i class="fas fa-question-circle text-2xl mb-2 text-wiki-secondary group-hover:text-white"></i>
                <div class="text-sm">도움말</div>
            </a>
        </div>
        
        <!-- Popular Jobs and Majors Section -->
        <div class="mt-16 max-w-6xl w-full px-4">
            <div class="grid md:grid-cols-2 gap-8">
                <!-- Popular Jobs -->
                <div>
                    <h2 class="text-2xl font-bold mb-6 gradient-text">
                        <i class="fas fa-fire mr-2"></i>인기 직업
                    </h2>
                    <div id="popular-jobs" class="min-h-[200px]">
                        <!-- Jobs will be loaded dynamically -->
                    </div>
                </div>
                
                <!-- Popular Majors -->
                <div>
                    <h2 class="text-2xl font-bold mb-6 gradient-text">
                        <i class="fas fa-star mr-2"></i>인기 전공
                    </h2>
                    <div id="popular-majors" class="min-h-[200px]">
                        <!-- Majors will be loaded dynamically -->
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Simple Stats -->
        <div class="text-center text-wiki-muted text-sm mt-12">
            <p>1,000+ 직업 정보 · 500+ 전공 정보 · AI 기반 맞춤 분석</p>
        </div>
    </div>
  `
  
  return c.html(renderLayout(content, 'Careerwiki - AI 진로 분석 플랫폼', 'AI 기반 개인 맞춤형 진로 분석과 전략 리포트를 제공하는 플랫폼', true))
})

// AI Analyzer Page - Choose between Job or Major
app.get('/analyzer', (c) => {
  const content = `
    <div class="max-w-4xl mx-auto">
        <h1 class="text-4xl font-bold mb-8 gradient-text text-center">
            <i class="fas fa-brain mr-3"></i>AI 커리어 분석기
        </h1>
        
        <div class="glass-card p-8 rounded-2xl">
            <h2 class="text-2xl font-bold mb-6 text-center">무엇을 추천받고 싶으신가요?</h2>
            
            <div class="grid md:grid-cols-2 gap-8 mt-8">
                <!-- Job Recommendation -->
                <a href="/analyzer/job" class="glass-card p-8 rounded-xl hover-glow block text-center group">
                    <i class="fas fa-briefcase text-6xl mb-4 text-wiki-secondary group-hover:text-wiki-primary transition"></i>
                    <h3 class="text-2xl font-bold mb-3">직업 추천</h3>
                    <p class="text-wiki-muted">
                        나의 성향, 능력, 가치관을 바탕으로<br>
                        적합한 직업을 AI가 추천해드립니다
                    </p>
                    <div class="mt-6">
                        <span class="px-6 py-3 bg-wiki-primary text-white rounded-lg inline-block group-hover:bg-blue-600 transition">
                            직업 추천받기 →
                        </span>
                    </div>
                </a>
                
                <!-- Major Recommendation -->
                <a href="/analyzer/major" class="glass-card p-8 rounded-xl hover-glow block text-center group">
                    <i class="fas fa-university text-6xl mb-4 text-wiki-secondary group-hover:text-wiki-primary transition"></i>
                    <h3 class="text-2xl font-bold mb-3">전공 추천</h3>
                    <p class="text-wiki-muted">
                        나의 적성, 흥미, 목표를 분석하여<br>
                        최적의 전공을 AI가 추천해드립니다
                    </p>
                    <div class="mt-6">
                        <span class="px-6 py-3 bg-wiki-primary text-white rounded-lg inline-block group-hover:bg-blue-600 transition">
                            전공 추천받기 →
                        </span>
                    </div>
                </a>
            </div>
            
            <div class="mt-12 text-center text-wiki-muted text-sm">
                <p>AI 분석은 개인정보를 안전하게 처리하며, 결과는 참고용으로만 활용하시기 바랍니다.</p>
            </div>
        </div>
    </div>
  `
  
  return c.html(renderLayout(content, 'AI 커리어 분석기 - Careerwiki'))
})

// AI Job Analyzer
app.get('/analyzer/job', (c) => {
  const content = `
    <div class="max-w-4xl mx-auto">
        <h1 class="text-3xl font-bold mb-8 text-center">
            <i class="fas fa-briefcase mr-3 text-wiki-secondary"></i>AI 직업 추천
        </h1>
        
        <div class="glass-card p-8 rounded-2xl">
            <form id="job-analyzer-form" class="space-y-6">
                <!-- MBTI -->
                <div>
                    <label class="block text-lg font-semibold mb-3">당신의 MBTI 유형을 선택해주세요</label>
                    <div class="grid grid-cols-4 gap-3">
                        ${['INTJ', 'INTP', 'ENTJ', 'ENTP', 'INFJ', 'INFP', 'ENFJ', 'ENFP', 
                           'ISTJ', 'ISFJ', 'ESTJ', 'ESFJ', 'ISTP', 'ISFP', 'ESTP', 'ESFP'].map(mbti => `
                            <button type="button" class="mbti-btn p-3 bg-wiki-bg rounded-lg border border-wiki-border hover:border-wiki-primary transition text-sm">
                                ${mbti}
                            </button>
                        `).join('')}
                    </div>
                    <input type="hidden" name="mbti" id="mbti-input">
                </div>
                
                <!-- Resume Upload -->
                <div>
                    <label class="block text-lg font-semibold mb-3">이력서를 업로드 해주세요 (선택)</label>
                    <input type="file" name="resume" 
                           class="w-full px-4 py-3 bg-wiki-bg rounded-lg border border-wiki-border focus:border-wiki-primary focus:outline-none">
                </div>
                
                <!-- Current Job/Field -->
                <div>
                    <label class="block text-lg font-semibold mb-3">현재 직무 또는 관심 분야</label>
                    <input type="text" name="current_field" 
                           placeholder="예: 마케팅, 개발, 디자인, 영업 등"
                           class="w-full px-4 py-3 bg-wiki-bg rounded-lg border border-wiki-border focus:border-wiki-primary focus:outline-none">
                </div>
                
                <!-- Values -->
                <div>
                    <label class="block text-lg font-semibold mb-3">추구하는 가치</label>
                    <input type="text" name="values" 
                           placeholder="예: 워라밸, 성장, 안정성, 창의성"
                           class="w-full px-4 py-3 bg-wiki-bg rounded-lg border border-wiki-border focus:border-wiki-primary focus:outline-none">
                </div>
                
                <!-- Life Goals -->
                <div>
                    <label class="block text-lg font-semibold mb-3">인생 목표</label>
                    <textarea name="goals" rows="3" 
                              placeholder="10년 후 어떤 모습이 되고 싶으신가요?"
                              class="w-full px-4 py-3 bg-wiki-bg rounded-lg border border-wiki-border focus:border-wiki-primary focus:outline-none"></textarea>
                </div>
                
                <!-- Skills -->
                <div>
                    <label class="block text-lg font-semibold mb-3">자신 있는 능력</label>
                    <input type="text" name="skills" 
                           placeholder="예: 커뮤니케이션, 분석력, 창의력, 리더십"
                           class="w-full px-4 py-3 bg-wiki-bg rounded-lg border border-wiki-border focus:border-wiki-primary focus:outline-none">
                </div>
                
                <!-- Weaknesses -->
                <div>
                    <label class="block text-lg font-semibold mb-3">약점 또는 피하고 싶은 것</label>
                    <input type="text" name="weaknesses" 
                           placeholder="예: 야근, 출장, 단순반복, 체력소모"
                           class="w-full px-4 py-3 bg-wiki-bg rounded-lg border border-wiki-border focus:border-wiki-primary focus:outline-none">
                </div>
                
                <!-- Pricing Options at the End -->
                <div class="border-t border-wiki-border pt-6">
                    <h3 class="text-xl font-bold mb-4 text-center">분석 옵션을 선택하세요</h3>
                    <div class="grid md:grid-cols-2 gap-6">
                        <!-- Free Option -->
                        <label class="glass-card p-6 rounded-xl cursor-pointer hover:border-wiki-primary border-2 border-transparent transition">
                            <input type="radio" name="pricing" value="free" class="hidden peer" checked>
                            <div class="text-center">
                                <h4 class="text-lg font-bold mb-2">무료 분석</h4>
                                <p class="text-2xl font-bold gradient-text mb-3">₩0</p>
                                <ul class="text-sm text-wiki-muted space-y-1">
                                    <li>✓ 기본 직업 분석</li>
                                    <li>✓ 포지션 추천 3개</li>
                                    <li>✓ PDF 리포트</li>
                                </ul>
                            </div>
                        </label>
                        
                        <!-- Pro Option -->
                        <label class="glass-card p-6 rounded-xl cursor-pointer hover:border-wiki-primary border-2 border-wiki-primary transition">
                            <input type="radio" name="pricing" value="pro" class="hidden peer">
                            <div class="text-center">
                                <span class="bg-wiki-primary text-white px-3 py-1 rounded-full text-xs">추천</span>
                                <h4 class="text-lg font-bold mb-2 mt-2">Pro 분석</h4>
                                <p class="text-2xl font-bold gradient-text mb-3">₩9,900</p>
                                <ul class="text-sm text-wiki-muted space-y-1">
                                    <li>✓ 심층 직업 분석</li>
                                    <li>✓ 포지션 추천 10개</li>
                                    <li>✓ 스킬 갭 분석</li>
                                    <li>✓ 학습 로드맵</li>
                                    <li>✓ 1:1 피드백 (예정)</li>
                                </ul>
                            </div>
                        </label>
                    </div>
                </div>
                
                <!-- Submit Button -->
                <div class="text-center pt-6">
                    <button type="submit" 
                            class="px-12 py-4 bg-gradient-to-r from-wiki-primary to-wiki-secondary text-white font-bold rounded-xl hover-glow transition transform hover:scale-105">
                        <i class="fas fa-magic mr-2"></i>AI 분석 시작하기
                    </button>
                </div>
            </form>
        </div>
    </div>
    
    <script>
        // MBTI Selection
        document.querySelectorAll('.mbti-btn').forEach(btn => {
            btn.addEventListener('click', () => {
                document.querySelectorAll('.mbti-btn').forEach(b => b.classList.remove('bg-wiki-primary', 'text-white'));
                btn.classList.add('bg-wiki-primary', 'text-white');
                document.getElementById('mbti-input').value = btn.textContent.trim();
            });
        });
        
        // Form submission
        document.getElementById('job-analyzer-form').addEventListener('submit', async (e) => {
            e.preventDefault();
            const pricing = document.querySelector('input[name="pricing"]:checked').value;
            alert('AI ' + (pricing === 'pro' ? 'Pro' : '무료') + ' 직업 분석이 시작되었습니다. 2-3분 내에 결과를 받아보실 수 있습니다.');
        });
    </script>
  `
  
  return c.html(renderLayout(content, 'AI 직업 추천 - Careerwiki'))
})

// AI Major Analyzer
app.get('/analyzer/major', (c) => {
  const content = `
    <div class="max-w-4xl mx-auto">
        <h1 class="text-3xl font-bold mb-8 text-center">
            <i class="fas fa-university mr-3 text-wiki-secondary"></i>AI 전공 추천
        </h1>
        
        <div class="glass-card p-8 rounded-2xl">
            <form id="major-analyzer-form" class="space-y-6">
                <!-- MBTI -->
                <div>
                    <label class="block text-lg font-semibold mb-3">당신의 MBTI 유형을 선택해주세요</label>
                    <div class="grid grid-cols-4 gap-3">
                        ${['INTJ', 'INTP', 'ENTJ', 'ENTP', 'INFJ', 'INFP', 'ENFJ', 'ENFP', 
                           'ISTJ', 'ISFJ', 'ESTJ', 'ESFJ', 'ISTP', 'ISFP', 'ESTP', 'ESFP'].map(mbti => `
                            <button type="button" class="mbti-btn p-3 bg-wiki-bg rounded-lg border border-wiki-border hover:border-wiki-primary transition text-sm">
                                ${mbti}
                            </button>
                        `).join('')}
                    </div>
                    <input type="hidden" name="mbti" id="mbti-input">
                </div>
                
                <!-- Current Status -->
                <div>
                    <label class="block text-lg font-semibold mb-3">현재 상태</label>
                    <select name="status" 
                            class="w-full px-4 py-3 bg-wiki-bg rounded-lg border border-wiki-border focus:border-wiki-primary focus:outline-none">
                        <option value="">선택해주세요</option>
                        <option value="high">고등학생</option>
                        <option value="freshman">대학 신입생</option>
                        <option value="student">대학 재학생</option>
                        <option value="transfer">전과 희망</option>
                        <option value="graduate">대학원 진학 희망</option>
                    </select>
                </div>
                
                <!-- Favorite Subjects -->
                <div>
                    <label class="block text-lg font-semibold mb-3">자신 있는 과목</label>
                    <input type="text" name="good_subjects" 
                           placeholder="예: 수학, 물리, 영어, 역사, 미술"
                           class="w-full px-4 py-3 bg-wiki-bg rounded-lg border border-wiki-border focus:border-wiki-primary focus:outline-none">
                </div>
                
                <!-- Weak Subjects -->
                <div>
                    <label class="block text-lg font-semibold mb-3">싫어하는 과목</label>
                    <input type="text" name="weak_subjects" 
                           placeholder="예: 국어, 화학, 체육"
                           class="w-full px-4 py-3 bg-wiki-bg rounded-lg border border-wiki-border focus:border-wiki-primary focus:outline-none">
                </div>
                
                <!-- Interests -->
                <div>
                    <label class="block text-lg font-semibold mb-3">관심 분야</label>
                    <input type="text" name="interests" 
                           placeholder="예: AI, 게임, 의료, 환경, 금융"
                           class="w-full px-4 py-3 bg-wiki-bg rounded-lg border border-wiki-border focus:border-wiki-primary focus:outline-none">
                </div>
                
                <!-- Values -->
                <div>
                    <label class="block text-lg font-semibold mb-3">추구하는 가치</label>
                    <input type="text" name="values" 
                           placeholder="예: 사회공헌, 창의성, 안정성, 높은 연봉"
                           class="w-full px-4 py-3 bg-wiki-bg rounded-lg border border-wiki-border focus:border-wiki-primary focus:outline-none">
                </div>
                
                <!-- Career Goals -->
                <div>
                    <label class="block text-lg font-semibold mb-3">희망 진로</label>
                    <textarea name="career_goals" rows="3" 
                              placeholder="졸업 후 어떤 일을 하고 싶으신가요?"
                              class="w-full px-4 py-3 bg-wiki-bg rounded-lg border border-wiki-border focus:border-wiki-primary focus:outline-none"></textarea>
                </div>
                
                <!-- Special Notes -->
                <div>
                    <label class="block text-lg font-semibold mb-3">특이사항</label>
                    <input type="text" name="notes" 
                           placeholder="예: 유학 희망, 복수전공 고려, 편입 계획"
                           class="w-full px-4 py-3 bg-wiki-bg rounded-lg border border-wiki-border focus:border-wiki-primary focus:outline-none">
                </div>
                
                <!-- Pricing Options at the End -->
                <div class="border-t border-wiki-border pt-6">
                    <h3 class="text-xl font-bold mb-4 text-center">분석 옵션을 선택하세요</h3>
                    <div class="grid md:grid-cols-2 gap-6">
                        <!-- Free Option -->
                        <label class="glass-card p-6 rounded-xl cursor-pointer hover:border-wiki-primary border-2 border-transparent transition">
                            <input type="radio" name="pricing" value="free" class="hidden peer" checked>
                            <div class="text-center">
                                <h4 class="text-lg font-bold mb-2">무료 분석</h4>
                                <p class="text-2xl font-bold gradient-text mb-3">₩0</p>
                                <ul class="text-sm text-wiki-muted space-y-1">
                                    <li>✓ 기본 전공 분석</li>
                                    <li>✓ 전공 추천 3개</li>
                                    <li>✓ PDF 리포트</li>
                                </ul>
                            </div>
                        </label>
                        
                        <!-- Pro Option -->
                        <label class="glass-card p-6 rounded-xl cursor-pointer hover:border-wiki-primary border-2 border-wiki-primary transition">
                            <input type="radio" name="pricing" value="pro" class="hidden peer">
                            <div class="text-center">
                                <span class="bg-wiki-primary text-white px-3 py-1 rounded-full text-xs">추천</span>
                                <h4 class="text-lg font-bold mb-2 mt-2">Pro 분석</h4>
                                <p class="text-2xl font-bold gradient-text mb-3">₩9,900</p>
                                <ul class="text-sm text-wiki-muted space-y-1">
                                    <li>✓ 심층 전공 분석</li>
                                    <li>✓ 전공 추천 10개</li>
                                    <li>✓ 커리큘럼 분석</li>
                                    <li>✓ 진로 로드맵</li>
                                    <li>✓ 1:1 피드백 (예정)</li>
                                </ul>
                            </div>
                        </label>
                    </div>
                </div>
                
                <!-- Submit Button -->
                <div class="text-center pt-6">
                    <button type="submit" 
                            class="px-12 py-4 bg-gradient-to-r from-wiki-primary to-wiki-secondary text-white font-bold rounded-xl hover-glow transition transform hover:scale-105">
                        <i class="fas fa-magic mr-2"></i>AI 분석 시작하기
                    </button>
                </div>
            </form>
        </div>
    </div>
    
    <script>
        // MBTI Selection
        document.querySelectorAll('.mbti-btn').forEach(btn => {
            btn.addEventListener('click', () => {
                document.querySelectorAll('.mbti-btn').forEach(b => b.classList.remove('bg-wiki-primary', 'text-white'));
                btn.classList.add('bg-wiki-primary', 'text-white');
                document.getElementById('mbti-input').value = btn.textContent.trim();
            });
        });
        
        // Form submission
        document.getElementById('major-analyzer-form').addEventListener('submit', async (e) => {
            e.preventDefault();
            const pricing = document.querySelector('input[name="pricing"]:checked').value;
            alert('AI ' + (pricing === 'pro' ? 'Pro' : '무료') + ' 전공 분석이 시작되었습니다. 2-3분 내에 결과를 받아보실 수 있습니다.');
        });
    </script>
  `
  
  return c.html(renderLayout(content, 'AI 전공 추천 - Careerwiki'))
})

// Job Wiki List Page
app.get('/job', async (c) => {
  const content = `
    <div class="max-w-6xl mx-auto">
        <h1 class="text-4xl font-bold mb-8 gradient-text text-center">
            <i class="fas fa-briefcase mr-3"></i>직업위키
        </h1>
        

        <div class="grid md:grid-cols-3 gap-6">
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
  return c.html(renderLayout(content, '직업위키 - Careerwiki'))
})

// Major Wiki List Page
app.get('/major', async (c) => {
  const content = `
    <div class="max-w-6xl mx-auto">
        <h1 class="text-4xl font-bold mb-8 gradient-text text-center">
            <i class="fas fa-university mr-3"></i>전공위키
        </h1>
        

        <div class="grid md:grid-cols-3 gap-6">
            <a href="/major/computer-science" class="glass-card p-6 rounded-xl hover-glow block">
                <h3 class="text-xl font-bold mb-2">컴퓨터공학과</h3>
                <p class="text-sm text-wiki-muted mb-3">컴퓨터 시스템과 소프트웨어를 연구하는 학과</p>
                <div class="text-sm">
                    <span class="text-wiki-secondary"><i class="fas fa-briefcase"></i> 취업률 95%</span>
                </div>
            </a>
            <a href="/major/chemical-engineering" class="glass-card p-6 rounded-xl hover-glow block">
                <h3 class="text-xl font-bold mb-2">화학공학과</h3>
                <p class="text-sm text-wiki-muted mb-3">화학 원리를 산업에 응용하는 공학 분야</p>
                <div class="text-sm">
                    <span class="text-wiki-secondary"><i class="fas fa-briefcase"></i> 취업률 88%</span>
                </div>
            </a>
            <a href="/major/business" class="glass-card p-6 rounded-xl hover-glow block">
                <h3 class="text-xl font-bold mb-2">경영학과</h3>
                <p class="text-sm text-wiki-muted mb-3">기업 경영과 비즈니스를 연구하는 학과</p>
                <div class="text-sm">
                    <span class="text-wiki-secondary"><i class="fas fa-briefcase"></i> 취업률 87%</span>
                </div>
            </a>
        </div>
    </div>
  `
  return c.html(renderLayout(content, '전공위키 - Careerwiki'))
})

// HowTo Page
app.get('/howto', (c) => {
  const content = `
    <div class="max-w-6xl mx-auto">
        <h1 class="text-4xl font-bold mb-8 gradient-text text-center">
            <i class="fas fa-route mr-3"></i>HowTo 시리즈
        </h1>
        

        <div class="grid md:grid-cols-2 gap-6">
            <a href="/howto/law-school" class="glass-card p-6 rounded-xl hover-glow block">
                <h3 class="text-xl font-bold mb-2">로스쿨 들어가는 법</h3>
                <p class="text-sm text-wiki-muted">법학전문대학원 입학 준비부터 합격까지의 완벽 가이드</p>
                <div class="flex gap-2 mt-3">
                    <span class="text-xs px-2 py-1 bg-wiki-bg rounded">법학</span>
                    <span class="text-xs px-2 py-1 bg-wiki-bg rounded">대학원</span>
                </div>
            </a>
            <a href="/howto/cpa" class="glass-card p-6 rounded-xl hover-glow block">
                <h3 class="text-xl font-bold mb-2">회계사 되는 법</h3>
                <p class="text-sm text-wiki-muted">공인회계사 시험 준비와 합격 전략</p>
                <div class="flex gap-2 mt-3">
                    <span class="text-xs px-2 py-1 bg-wiki-bg rounded">회계</span>
                    <span class="text-xs px-2 py-1 bg-wiki-bg rounded">자격증</span>
                </div>
            </a>
            <a href="/howto/chemical-engineer-career" class="glass-card p-6 rounded-xl hover-glow block">
                <h3 class="text-xl font-bold mb-2">화학공학 전공으로 취직하는 법</h3>
                <p class="text-sm text-wiki-muted">화공 전공자를 위한 진로 선택과 취업 전략</p>
                <div class="flex gap-2 mt-3">
                    <span class="text-xs px-2 py-1 bg-wiki-bg rounded">화학공학</span>
                    <span class="text-xs px-2 py-1 bg-wiki-bg rounded">취업</span>
                </div>
            </a>
            <a href="/howto/startup" class="glass-card p-6 rounded-xl hover-glow block">
                <h3 class="text-xl font-bold mb-2">스타트업 창업하는 법</h3>
                <p class="text-sm text-wiki-muted">아이디어부터 투자 유치까지 스타트업 창업 가이드</p>
                <div class="flex gap-2 mt-3">
                    <span class="text-xs px-2 py-1 bg-wiki-bg rounded">창업</span>
                    <span class="text-xs px-2 py-1 bg-wiki-bg rounded">비즈니스</span>
                </div>
            </a>
        </div>
    </div>
  `
  
  return c.html(renderLayout(content, 'HowTo 시리즈 - Careerwiki'))
})

// Help Page
app.get('/help', (c) => {
  const content = `
    <div class="max-w-4xl mx-auto">
        <h1 class="text-4xl font-bold mb-8 gradient-text text-center">
            <i class="fas fa-question-circle mr-3"></i>도움말
        </h1>
        
        <div class="grid md:grid-cols-2 gap-6 mb-8">
            <div class="glass-card p-6 rounded-xl">
                <h3 class="text-xl font-bold mb-3">이용가이드</h3>
                <p class="text-wiki-muted">Careerwiki는 진로·진학 정보공유 플랫폼입니다. 간단한 설문조사를 통해 AI가 나에게 맞는 정보를 추천해줍니다.</p>
            </div>
            <div class="glass-card p-6 rounded-xl">
                <h3 class="text-xl font-bold mb-3">FAQ</h3>
                <p class="text-wiki-muted">자주 묻는 질문과 답변을 확인하세요.</p>
            </div>
            <div class="glass-card p-6 rounded-xl">
                <h3 class="text-xl font-bold mb-3">건의사항</h3>
                <p class="text-wiki-muted">사이트 개선을 위한 의견을 보내주세요.</p>
            </div>
            <div class="glass-card p-6 rounded-xl">
                <h3 class="text-xl font-bold mb-3">저작권 관련</h3>
                <p class="text-wiki-muted">권리침해 및 저작권 관련 문의사항</p>
            </div>
        </div>
        
        <!-- FAQ Section -->
        <div class="glass-card p-8 rounded-2xl">
            <h2 class="text-2xl font-bold mb-6">자주 묻는 질문</h2>
            <div class="space-y-6">
                <div>
                    <h4 class="font-semibold mb-2">Q. AI 분석은 얼마나 정확한가요?</h4>
                    <p class="text-wiki-muted">A. AI 분석은 수많은 데이터를 기반으로 하지만, 참고용으로만 활용하시기 바랍니다. 최종 결정은 본인의 판단이 중요합니다.</p>
                </div>
                <div>
                    <h4 class="font-semibold mb-2">Q. 위키 내용을 수정할 수 있나요?</h4>
                    <p class="text-wiki-muted">A. 네, 회원가입 후 수정 제안을 하실 수 있으며, 관리자 검토 후 반영됩니다.</p>
                </div>
                <div>
                    <h4 class="font-semibold mb-2">Q. Pro 버전의 차이점은 무엇인가요?</h4>
                    <p class="text-wiki-muted">A. Pro 버전은 더 심층적인 분석과 많은 추천, 맞춤형 로드맵을 제공합니다.</p>
                </div>
            </div>
        </div>
    </div>
  `
  
  return c.html(renderLayout(content, '도움말 - Careerwiki'))
})

// Search Page with Relevance-based Results
app.get('/search', (c) => {
  const query = c.req.query('q') || ''
  const normalizedQuery = query.toLowerCase()
  
  // Mock data with relevance scoring
  const jobs = [
    { id: 'software-engineer', title: '소프트웨어 엔지니어', desc: '소프트웨어를 설계, 개발, 테스트하는 전문가. 프로그래밍, 코딩, 알고리즘 활용', keywords: ['코딩', '프로그래밍', '개발', '소프트웨어', '엔지니어', '알고리즘', 'IT'] },
    { id: 'data-scientist', title: '데이터 사이언티스트', desc: '데이터 분석과 머신러닝으로 인사이트를 도출하는 전문가. 파이썬 코딩 활용', keywords: ['데이터', '분석', '머신러닝', 'AI', '통계', '코딩', '파이썬'] },
    { id: 'security-consultant', title: '보안 컨설턴트', desc: '시스템 보안 취약점 분석 및 해결. 보안 코딩과 침투 테스트 수행', keywords: ['보안', '해킹', '네트워크', '시스템', '코딩', '취약점'] },
    { id: 'frontend-engineer', title: '프론트엔드 엔지니어', desc: '웹 인터페이스 개발 전문가. HTML, CSS, JavaScript 코딩', keywords: ['프론트엔드', '웹', 'UI', 'UX', '코딩', '자바스크립트', '리액트'] },
    { id: 'chemical-engineer', title: '화학공학 엔지니어', desc: '화학 공정 설계와 최적화를 담당하는 전문가', keywords: ['화학', '공정', '제조', '플랜트', '엔지니어'] },
  ]
  
  const majors = [
    { id: 'computer-science', title: '컴퓨터공학과', desc: '컴퓨터 시스템과 소프트웨어 개발을 배우는 학과. 프로그래밍과 코딩이 핵심', keywords: ['컴퓨터', '프로그래밍', '코딩', '알고리즘', '소프트웨어', 'IT'] },
    { id: 'information-science', title: '정보과학과', desc: '정보 시스템과 데이터 처리를 다루는 학과. 코딩과 데이터베이스 학습', keywords: ['정보', '데이터', '시스템', '코딩', '데이터베이스'] },
    { id: 'design', title: '디자인학과', desc: '시각 디자인과 UX/UI 디자인을 배우는 학과. 웹 코딩 기초 포함', keywords: ['디자인', 'UI', 'UX', '그래픽', '웹디자인', '코딩'] },
    { id: 'chemical-engineering', title: '화학공학과', desc: '화학 원리를 산업에 응용하는 공학 분야', keywords: ['화학', '공학', '공정', '재료', '에너지'] },
    { id: 'electrical-engineering', title: '전기전자공학과', desc: '전기, 전자 시스템과 임베디드 시스템 개발. 펌웨어 코딩 포함', keywords: ['전기', '전자', '회로', '임베디드', '코딩', '펌웨어'] },
  ]
  
  const howtos = [
    { id: 'career-exploration', title: '진로 탐색 가이드', desc: 'IT 직업과 코딩 교육 포함한 진로 탐색 방법', keywords: ['진로', '탐색', '직업', '코딩', 'IT', '교육'] },
    { id: 'coding-bootcamp', title: '코딩 부트캠프 선택 가이드', desc: '코딩 부트캠프 비교와 선택 방법', keywords: ['코딩', '부트캠프', '교육', '프로그래밍', '취업'] },
    { id: 'interview-prep', title: '기술 면접 준비하기', desc: '코딩 테스트와 기술 면접 준비 전략', keywords: ['면접', '코딩', '테스트', '알고리즘', '기술'] },
  ]
  
  // Calculate relevance score
  const calculateScore = (item) => {
    let score = 0
    const itemText = (item.title + ' ' + item.desc + ' ' + item.keywords.join(' ')).toLowerCase()
    
    // Exact match in title
    if (item.title.toLowerCase().includes(normalizedQuery)) score += 10
    
    // Match in description
    if (item.desc.toLowerCase().includes(normalizedQuery)) score += 5
    
    // Match in keywords
    item.keywords.forEach(keyword => {
      if (keyword.toLowerCase().includes(normalizedQuery)) score += 3
      if (normalizedQuery.includes(keyword.toLowerCase())) score += 2
    })
    
    return score
  }
  
  // Filter and sort results
  const jobResults = jobs
    .map(job => ({ ...job, score: calculateScore(job) }))
    .filter(job => job.score > 0)
    .sort((a, b) => b.score - a.score)
    .slice(0, 5)
  
  const majorResults = majors
    .map(major => ({ ...major, score: calculateScore(major) }))
    .filter(major => major.score > 0)
    .sort((a, b) => b.score - a.score)
    .slice(0, 5)
  
  const howtoResults = howtos
    .map(howto => ({ ...howto, score: calculateScore(howto) }))
    .filter(howto => howto.score > 0)
    .sort((a, b) => b.score - a.score)
    .slice(0, 3)
  
  const content = `
    <div class="max-w-4xl mx-auto">
        <!-- Search Bar with Query -->
        <div class="mb-8">
            <form action="/search" method="get" class="relative">
                <input 
                    type="text" 
                    name="q" 
                    value="${query}"
                    placeholder="검색어를 입력하세요" 
                    class="w-full px-6 py-4 bg-wiki-bg border border-wiki-border rounded-full text-lg focus:outline-none focus:border-wiki-primary transition"
                >
                <button type="submit" class="absolute right-2 top-1/2 -translate-y-1/2 px-6 py-2 bg-gradient-to-r from-wiki-primary to-wiki-secondary text-white rounded-full hover:scale-105 transition">
                    <i class="fas fa-search mr-2"></i>검색
                </button>
            </form>
        </div>
        
        ${jobResults.length > 0 ? `
        <!-- Job Results Section -->
        <div class="mb-8">
            <h2 class="text-xl font-bold mb-4 flex items-center">
                <span class="w-2 h-6 bg-wiki-primary mr-3"></span>
                직업위키
            </h2>
            <div class="space-y-3">
                ${jobResults.map(job => `
                    <a href="/job/${job.id}" class="glass-card p-4 rounded-lg hover-glow block transition">
                        <h3 class="text-lg font-semibold text-wiki-text">${job.title}</h3>
                        <p class="text-sm text-wiki-muted mt-1">${job.desc}</p>
                    </a>
                `).join('')}
            </div>
        </div>
        ` : ''}
        
        ${majorResults.length > 0 ? `
        <!-- Major Results Section -->
        <div class="mb-8">
            <h2 class="text-xl font-bold mb-4 flex items-center">
                <span class="w-2 h-6 bg-wiki-secondary mr-3"></span>
                전공위키
            </h2>
            <div class="space-y-3">
                ${majorResults.map(major => `
                    <a href="/major/${major.id}" class="glass-card p-4 rounded-lg hover-glow block transition">
                        <h3 class="text-lg font-semibold text-wiki-text">${major.title}</h3>
                        <p class="text-sm text-wiki-muted mt-1">${major.desc}</p>
                    </a>
                `).join('')}
            </div>
        </div>
        ` : ''}
        
        ${howtoResults.length > 0 ? `
        <!-- HowTo Results Section -->
        <div class="mb-8">
            <h2 class="text-xl font-bold mb-4 flex items-center">
                <span class="w-2 h-6 bg-green-500 mr-3"></span>
                HowTo
            </h2>
            <div class="space-y-3">
                ${howtoResults.map(howto => `
                    <a href="/howto/${howto.id}" class="glass-card p-4 rounded-lg hover-glow block transition">
                        <h3 class="text-lg font-semibold text-wiki-text">${howto.title}</h3>
                        <p class="text-sm text-wiki-muted mt-1">${howto.desc}</p>
                    </a>
                `).join('')}
            </div>
        </div>
        ` : ''}
        
        ${jobResults.length === 0 && majorResults.length === 0 && howtoResults.length === 0 ? `
        <div class="glass-card p-8 rounded-xl text-center">
            <i class="fas fa-search text-4xl text-wiki-muted mb-4"></i>
            <p class="text-lg text-wiki-muted">"${query}"에 대한 검색 결과가 없습니다.</p>
            <p class="text-sm text-wiki-muted mt-2">다른 검색어를 시도해보세요.</p>
        </div>
        ` : ''}
    </div>
  `
  
  return c.html(renderLayout(content, `${query ? query + ' - ' : ''}검색 - Careerwiki`))
})

// Major Detail Page (Based on design file)
app.get('/major/:slug', (c) => {
  const slug = c.req.param('slug')
  
  // Sample data for chemical engineering
  const content = `
    <div class="max-w-6xl mx-auto">
        <!-- Header Section -->
        <div class="glass-card p-8 rounded-2xl mb-6">
            <div class="flex justify-between items-start mb-6">
                <div>
                    <h1 class="text-4xl font-bold mb-2">화학공학</h1>
                    <p class="text-lg text-wiki-muted">화학공학을 다루는 학과</p>
                </div>
                <div class="flex gap-3">
                    <button class="px-4 py-2 bg-wiki-primary text-white rounded-lg hover:bg-blue-600 transition">
                        <i class="fas fa-edit mr-2"></i>편집
                    </button>
                    <button class="px-4 py-2 border border-wiki-primary text-wiki-primary rounded-lg hover:bg-wiki-primary hover:text-white transition">
                        <i class="fas fa-share mr-2"></i>공유
                    </button>
                </div>
            </div>
            
            <!-- Key Stats -->
            <div class="grid md:grid-cols-4 gap-4">
                <div class="bg-wiki-bg p-4 rounded-lg">
                    <p class="text-sm text-wiki-muted mb-1">취업률</p>
                    <p class="text-2xl font-bold text-wiki-primary">88%</p>
                </div>
                <div class="bg-wiki-bg p-4 rounded-lg">
                    <p class="text-sm text-wiki-muted mb-1">평균 초봉</p>
                    <p class="text-2xl font-bold text-wiki-secondary">4,200만원</p>
                </div>
                <div class="bg-wiki-bg p-4 rounded-lg">
                    <p class="text-sm text-wiki-muted mb-1">대학 수</p>
                    <p class="text-2xl font-bold">124개</p>
                </div>
                <div class="bg-wiki-bg p-4 rounded-lg">
                    <p class="text-sm text-wiki-muted mb-1">경쟁률</p>
                    <p class="text-2xl font-bold">8.5:1</p>
                </div>
            </div>
        </div>
        
        <div class="grid md:grid-cols-3 gap-6">
            <!-- Left Content -->
            <div class="md:col-span-2 space-y-6">
                <!-- Overview -->
                <div class="glass-card p-6 rounded-xl">
                    <h2 class="text-2xl font-bold mb-4 gradient-text">개요</h2>
                    <p class="text-wiki-text leading-relaxed">
                        화학공학은 화학 원리를 산업에 응용하여 유용한 제품을 대량 생산하는 방법을 연구하는 공학 분야입니다. 
                        석유화학, 정밀화학, 바이오, 에너지, 환경 등 다양한 산업 분야와 연결되어 있습니다.
                    </p>
                </div>
                
                <!-- Aptitude & Interest -->
                <div class="glass-card p-6 rounded-xl">
                    <h2 class="text-2xl font-bold mb-4 gradient-text">적성 및 흥미</h2>
                    <p class="text-wiki-text mb-4">
                        평소 화학실험이나 분석, 화학원리에 관심이 있거나 물질의 변화에 흥미가 있는 사람에게 적합합니다. 
                        화학이나 과학과목을 잘하거나 팀으로 업무나 실험 및 실습을 수행하는 경우도 많아 대인관계능력도 필요합니다.
                    </p>
                </div>
                
                <!-- Curriculum -->
                <div class="glass-card p-6 rounded-xl">
                    <h2 class="text-2xl font-bold mb-4 gradient-text">교과목</h2>
                    
                    <div class="mb-6">
                        <h3 class="text-lg font-semibold mb-3">공통과목</h3>
                        <div class="flex flex-wrap gap-2">
                            <span class="px-3 py-1 bg-wiki-bg rounded-full text-sm">수학</span>
                            <span class="px-3 py-1 bg-wiki-bg rounded-full text-sm">과학</span>
                            <span class="px-3 py-1 bg-wiki-bg rounded-full text-sm">기술·가정</span>
                        </div>
                    </div>
                    
                    <div class="mb-6">
                        <h3 class="text-lg font-semibold mb-3">일반선택과목</h3>
                        <p class="text-sm text-wiki-muted">
                            수학Ⅰ, 수학Ⅱ, 미적분, 확률과 통계, 물리학Ⅰ, 화학Ⅰ, 기술·가정, 정보
                        </p>
                    </div>
                    
                    <div>
                        <h3 class="text-lg font-semibold mb-3">진로선택과목</h3>
                        <p class="text-sm text-wiki-muted">
                            기하, 물리학Ⅱ, 화학Ⅱ, 공학 일반
                        </p>
                    </div>
                </div>
                
                <!-- Career Paths -->
                <div class="glass-card p-6 rounded-xl">
                    <h2 class="text-2xl font-bold mb-4 gradient-text">진출가능직업</h2>
                    <div class="grid grid-cols-2 gap-3">
                        <a href="/job/chemical-engineer" class="bg-wiki-bg p-3 rounded-lg hover:bg-wiki-border transition">
                            화학공학기술자
                        </a>
                        <a href="/job/energy-researcher" class="bg-wiki-bg p-3 rounded-lg hover:bg-wiki-border transition">
                            대체에너지 개발 연구원
                        </a>
                        <a href="/job/material-engineer" class="bg-wiki-bg p-3 rounded-lg hover:bg-wiki-border transition">
                            재료공학기술자
                        </a>
                        <a href="/job/environmental-engineer" class="bg-wiki-bg p-3 rounded-lg hover:bg-wiki-border transition">
                            환경공학기술자
                        </a>
                        <a href="/job/food-engineer" class="bg-wiki-bg p-3 rounded-lg hover:bg-wiki-border transition">
                            식품공학기술자
                        </a>
                        <a href="/job/professor" class="bg-wiki-bg p-3 rounded-lg hover:bg-wiki-border transition">
                            이공학계열 교수
                        </a>
                    </div>
                </div>
                
                <!-- Comments Section -->
                <div class="glass-card p-6 rounded-xl">
                    <h2 class="text-2xl font-bold mb-4">전체 의견</h2>
                    
                    <!-- Best Comments -->
                    <div class="mb-6">
                        <h3 class="text-lg font-semibold mb-3 text-wiki-secondary">베스트 의견</h3>
                        <div class="space-y-4">
                            <div class="bg-wiki-bg p-4 rounded-lg border-l-4 border-wiki-secondary">
                                <div class="flex justify-between mb-2">
                                    <span class="font-semibold">연구직가즈아</span>
                                    <span class="text-sm text-wiki-muted">2024.10.26</span>
                                </div>
                                <p class="text-wiki-text">화공과 오지마세요 절대오지마세요 연구비도없고 너무 힘들어요 랩실다니는데 월급 80만원받아요 진짜 박사하기힘들어요</p>
                            </div>
                            <div class="bg-wiki-bg p-4 rounded-lg">
                                <div class="flex justify-between mb-2">
                                    <span class="font-semibold">교수님살려주세요</span>
                                    <span class="text-sm text-wiki-muted">2024.10.28</span>
                                </div>
                                <p class="text-wiki-text">대단하시네요.. 전 석사하다 때려치고 그냥 취업했어요 ㅋㅋㅋㅋㅋㅋ</p>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Comment Form -->
                    <form class="mb-6">
                        <textarea placeholder="의견을 작성해주세요 (300자 이내)" 
                                  class="w-full px-4 py-3 bg-wiki-bg rounded-lg border border-wiki-border focus:border-wiki-primary focus:outline-none mb-3"
                                  rows="3" maxlength="300"></textarea>
                        <button type="submit" class="px-6 py-2 bg-wiki-primary text-white rounded-lg hover:bg-blue-600 transition">
                            의견 등록
                        </button>
                    </form>
                </div>
            </div>
            
            <!-- Right Sidebar -->
            <div class="space-y-6">
                <!-- Related Majors -->
                <div class="glass-card p-6 rounded-xl sticky top-24">
                    <h3 class="font-bold mb-4">관련학과</h3>
                    <div class="space-y-2">
                        <a href="/major/polymer-engineering" class="block text-wiki-link hover:text-wiki-primary">
                            고분자공학과
                        </a>
                        <a href="/major/bio-chemical-engineering" class="block text-wiki-link hover:text-wiki-primary">
                            생명화학공학과
                        </a>
                        <a href="/major/chemical-bio" class="block text-wiki-link hover:text-wiki-primary">
                            화공생명학
                        </a>
                    </div>
                    
                    <hr class="my-6 border-wiki-border">
                    
                    <h3 class="font-bold mb-4">관련 HowTo</h3>
                    <div class="space-y-2">
                        <a href="/howto/chemical-engineer-career" class="block text-wiki-link hover:text-wiki-primary text-sm">
                            화학공학 전공으로 취직하는 법
                        </a>
                        <a href="/howto/graduate-school" class="block text-wiki-link hover:text-wiki-primary text-sm">
                            대학원 진학 가이드
                        </a>
                    </div>
                    
                    <hr class="my-6 border-wiki-border">
                    
                    <h3 class="font-bold mb-4">취득가능 자격증</h3>
                    <div class="space-y-2 text-sm">
                        <div>• 화공기사</div>
                        <div>• 위험물산업기사</div>
                        <div>• 가스기사</div>
                        <div>• 수질환경기사</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
  `
  
  return c.html(renderLayout(content, '화학공학 - 전공 정보 | Careerwiki'))
})

// API 엔드포인트들

// 학과정보 검색 API
app.get('/api/majors', async (c) => {
  try {
    const keyword = c.req.query('keyword') || ''
    const page = parseInt(c.req.query('page') || '1')
    const perPage = parseInt(c.req.query('perPage') || '20')
    
    const majors = await searchMajors({
      keyword,
      thisPage: page,
      perPage
    }, c.env)
    
    return c.json({
      success: true,
      data: majors,
      page,
      perPage
    })
  } catch (error) {
    return c.json({
      success: false,
      error: error instanceof Error ? error.message : '학과 정보 검색 실패'
    }, 500)
  }
})

// 학과 상세 정보 API
app.get('/api/majors/:id', async (c) => {
  try {
    const majorSeq = c.req.param('id')
    const major = await getMajorDetail(majorSeq, c.env)
    
    if (!major) {
      return c.json({
        success: false,
        error: '학과 정보를 찾을 수 없습니다'
      }, 404)
    }
    
    return c.json({
      success: true,
      data: major
    })
  } catch (error) {
    return c.json({
      success: false,
      error: error instanceof Error ? error.message : '학과 정보 조회 실패'
    }, 500)
  }
})

// 직업정보 검색 API
app.get('/api/jobs', async (c) => {
  try {
    const keyword = c.req.query('keyword') || ''
    const category = c.req.query('category') || ''
    const page = parseInt(c.req.query('page') || '1')
    const perPage = parseInt(c.req.query('perPage') || '20')
    
    const jobs = await searchJobs({
      keyword,
      category,
      thisPage: page,
      perPage
    }, c.env)
    
    return c.json({
      success: true,
      data: jobs,
      page,
      perPage,
      categories: JOB_CATEGORIES
    })
  } catch (error) {
    return c.json({
      success: false,
      error: error instanceof Error ? error.message : '직업 정보 검색 실패'
    }, 500)
  }
})

// 직업 상세 정보 API
app.get('/api/jobs/:id', async (c) => {
  try {
    const jobdicSeq = c.req.param('id')
    const job = await getJobDetail(jobdicSeq, c.env)
    
    if (!job) {
      return c.json({
        success: false,
        error: '직업 정보를 찾을 수 없습니다'
      }, 404)
    }
    
    return c.json({
      success: true,
      data: job
    })
  } catch (error) {
    return c.json({
      success: false,
      error: error instanceof Error ? error.message : '직업 정보 조회 실패'
    }, 500)
  }
})

// 직업 카테고리 목록 API
app.get('/api/categories', async (c) => {
  return c.json({
    success: true,
    jobCategories: JOB_CATEGORIES,
    aptitudeTypes: APTITUDE_TYPES
  })
})

export default app
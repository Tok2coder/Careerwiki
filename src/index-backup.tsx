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

// Helper function to render layout
const renderLayout = (content: string, title = 'CareerWiki - AI 진로 분석 플랫폼', description = 'AI 기반 개인 맞춤형 진로 분석과 전략 리포트를 제공하는 플랫폼') => {
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
        <meta name="robots" content="index, follow">
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
        </style>
    </head>
    <body class="bg-wiki-bg text-wiki-text min-h-screen">
        <!-- Navigation -->
        <nav class="glass-card sticky top-0 z-50 border-b border-wiki-border">
            <div class="container mx-auto px-4 py-4">
                <div class="flex items-center justify-between">
                    <a href="/" class="flex items-center space-x-3">
                        <i class="fas fa-graduation-cap text-2xl text-wiki-primary"></i>
                        <span class="text-2xl font-bold gradient-text">CareerWiki</span>
                    </a>
                    <div class="hidden md:flex items-center space-x-6">
                        <a href="/analyzer" class="text-wiki-text hover:text-wiki-primary transition">
                            <i class="fas fa-brain mr-2"></i>AI 진로 분석
                        </a>
                        <a href="/job" class="text-wiki-text hover:text-wiki-primary transition">
                            <i class="fas fa-briefcase mr-2"></i>직업 백과
                        </a>
                        <a href="/major" class="text-wiki-text hover:text-wiki-primary transition">
                            <i class="fas fa-university mr-2"></i>전공 백과
                        </a>
                        <a href="/about" class="text-wiki-text hover:text-wiki-primary transition">
                            <i class="fas fa-info-circle mr-2"></i>소개
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
                <a href="/analyzer" class="block text-wiki-text hover:text-wiki-primary transition">
                    <i class="fas fa-brain mr-2"></i>AI 진로 분석
                </a>
                <a href="/job" class="block text-wiki-text hover:text-wiki-primary transition">
                    <i class="fas fa-briefcase mr-2"></i>직업 백과
                </a>
                <a href="/major" class="block text-wiki-text hover:text-wiki-primary transition">
                    <i class="fas fa-university mr-2"></i>전공 백과
                </a>
                <a href="/about" class="block text-wiki-text hover:text-wiki-primary transition">
                    <i class="fas fa-info-circle mr-2"></i>소개
                </a>
            </div>
        </div>
        
        <!-- Main Content -->
        <main class="container mx-auto px-4 py-8">
            ${content}
        </main>
        
        <!-- Footer -->
        <footer class="glass-card border-t border-wiki-border mt-16">
            <div class="container mx-auto px-4 py-8">
                <div class="grid md:grid-cols-3 gap-8">
                    <div>
                        <h3 class="text-xl font-bold mb-4 gradient-text">CareerWiki</h3>
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
                        <p class="text-sm text-wiki-muted">contact@careerwiki.com</p>
                    </div>
                </div>
                <div class="mt-8 pt-8 border-t border-wiki-border text-center text-sm text-wiki-muted">
                    <p>© 2024 CareerWiki. All rights reserved.</p>
                </div>
            </div>
        </footer>
        
        <script>
            // Mobile menu toggle
            document.getElementById('mobile-menu-btn').addEventListener('click', () => {
                document.getElementById('mobile-menu').classList.toggle('hidden');
            });
        </script>
    </body>
    </html>
  `
}

// Homepage
app.get('/', (c) => {
  const content = `
    <!-- Hero Section -->
    <section class="py-16 text-center">
        <h1 class="text-5xl md:text-6xl font-bold mb-6">
            <span class="gradient-text">AI가 분석하는</span><br>
            <span class="text-wiki-text">나만의 진로 로드맵</span>
        </h1>
        <p class="text-xl text-wiki-muted mb-12 max-w-2xl mx-auto">
            이력서와 경험을 분석하여 맞춤형 진로 전략과<br>
            시장 적합도, 성장 경로를 제시합니다
        </p>
        
        <!-- Search Bar -->
        <div class="max-w-3xl mx-auto mb-8">
            <div class="glass-card p-2 rounded-2xl hover-glow">
                <form action="/search" method="get" class="flex">
                    <input type="text" name="q" 
                           placeholder="직업, 전공, 진로를 검색해보세요..." 
                           class="flex-1 px-6 py-4 bg-transparent text-wiki-text search-input focus:outline-none">
                    <button type="submit" 
                            class="px-8 py-4 bg-wiki-primary text-white rounded-xl hover:bg-blue-600 transition">
                        <i class="fas fa-search mr-2"></i>검색
                    </button>
                </form>
            </div>
        </div>
        
        <!-- CTA Button -->
        <a href="/analyzer" 
           class="inline-flex items-center px-8 py-4 bg-gradient-to-r from-wiki-primary to-wiki-secondary text-white font-semibold rounded-xl hover-glow transition transform hover:scale-105">
            <i class="fas fa-rocket mr-3"></i>
            AI 진로 분석 시작하기
        </a>
    </section>
    
    <!-- Features -->
    <section class="py-16">
        <div class="grid md:grid-cols-3 gap-8">
            <!-- AI Analysis -->
            <div class="glass-card p-8 rounded-2xl hover-glow">
                <div class="text-4xl mb-4 text-wiki-primary">
                    <i class="fas fa-brain"></i>
                </div>
                <h3 class="text-2xl font-bold mb-3">AI 커리어 분석</h3>
                <p class="text-wiki-muted mb-4">
                    이력서와 경험을 바탕으로 포지션 추천, 
                    스킬 갭 진단, 학습 경로를 제안합니다
                </p>
                <ul class="space-y-2 text-sm">
                    <li><i class="fas fa-check text-wiki-secondary mr-2"></i>맞춤형 진로 추천</li>
                    <li><i class="fas fa-check text-wiki-secondary mr-2"></i>시장 적합도 분석</li>
                    <li><i class="fas fa-check text-wiki-secondary mr-2"></i>급여 예측 리포트</li>
                </ul>
            </div>
            
            <!-- Wiki Database -->
            <div class="glass-card p-8 rounded-2xl hover-glow">
                <div class="text-4xl mb-4 text-wiki-primary">
                    <i class="fas fa-book"></i>
                </div>
                <h3 class="text-2xl font-bold mb-3">진로 위키백과</h3>
                <p class="text-wiki-muted mb-4">
                    1,000+ 직업과 전공 정보를 체계적으로 정리한 
                    국내 최대 진로 데이터베이스
                </p>
                <ul class="space-y-2 text-sm">
                    <li><i class="fas fa-check text-wiki-secondary mr-2"></i>직업별 상세 정보</li>
                    <li><i class="fas fa-check text-wiki-secondary mr-2"></i>전공별 진로 경로</li>
                    <li><i class="fas fa-check text-wiki-secondary mr-2"></i>실시간 업데이트</li>
                </ul>
            </div>
            
            <!-- Community -->
            <div class="glass-card p-8 rounded-2xl hover-glow">
                <div class="text-4xl mb-4 text-wiki-primary">
                    <i class="fas fa-users"></i>
                </div>
                <h3 class="text-2xl font-bold mb-3">커뮤니티 인사이트</h3>
                <p class="text-wiki-muted mb-4">
                    현직자와 전문가의 생생한 경험과 조언을 
                    댓글과 수정 제안으로 공유합니다
                </p>
                <ul class="space-y-2 text-sm">
                    <li><i class="fas fa-check text-wiki-secondary mr-2"></i>현직자 댓글</li>
                    <li><i class="fas fa-check text-wiki-secondary mr-2"></i>전문가 검증</li>
                    <li><i class="fas fa-check text-wiki-secondary mr-2"></i>실무 노하우</li>
                </ul>
            </div>
        </div>
    </section>
    
    <!-- Popular Jobs -->
    <section class="py-16">
        <h2 class="text-3xl font-bold mb-8 text-center gradient-text">인기 직업 정보</h2>
        <div class="grid md:grid-cols-4 gap-4">
            <a href="/job/software-engineer" class="glass-card p-6 rounded-xl hover-glow block">
                <i class="fas fa-code text-wiki-primary text-2xl mb-3"></i>
                <h4 class="font-semibold mb-2">소프트웨어 엔지니어</h4>
                <p class="text-sm text-wiki-muted">평균 연봉: 6,500만원</p>
            </a>
            <a href="/job/data-scientist" class="glass-card p-6 rounded-xl hover-glow block">
                <i class="fas fa-chart-bar text-wiki-primary text-2xl mb-3"></i>
                <h4 class="font-semibold mb-2">데이터 사이언티스트</h4>
                <p class="text-sm text-wiki-muted">평균 연봉: 7,000만원</p>
            </a>
            <a href="/job/product-manager" class="glass-card p-6 rounded-xl hover-glow block">
                <i class="fas fa-tasks text-wiki-primary text-2xl mb-3"></i>
                <h4 class="font-semibold mb-2">프로덕트 매니저</h4>
                <p class="text-sm text-wiki-muted">평균 연봉: 8,000만원</p>
            </a>
            <a href="/job/ux-designer" class="glass-card p-6 rounded-xl hover-glow block">
                <i class="fas fa-palette text-wiki-primary text-2xl mb-3"></i>
                <h4 class="font-semibold mb-2">UX 디자이너</h4>
                <p class="text-sm text-wiki-muted">평균 연봉: 5,500만원</p>
            </a>
        </div>
    </section>
  `
  
  return c.html(renderLayout(content))
})

// AI Analyzer Page
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
        
        <!-- Pricing -->
        <div class="glass-card p-8 rounded-2xl">
            <h3 class="text-2xl font-bold mb-6 text-center">요금제</h3>
            <div class="grid md:grid-cols-3 gap-6">
                <div class="bg-wiki-bg p-6 rounded-xl text-center">
                    <h4 class="text-xl font-bold mb-3">Basic</h4>
                    <p class="text-3xl font-bold gradient-text mb-4">₩9,900</p>
                    <ul class="space-y-2 text-sm text-wiki-muted mb-6">
                        <li>기본 진로 분석</li>
                        <li>포지션 추천 3개</li>
                        <li>PDF 리포트</li>
                    </ul>
                    <button class="w-full py-3 border border-wiki-primary text-wiki-primary rounded-lg hover:bg-wiki-primary hover:text-white transition">
                        선택하기
                    </button>
                </div>
                <div class="bg-wiki-bg p-6 rounded-xl text-center border-2 border-wiki-primary">
                    <span class="bg-wiki-primary text-white px-3 py-1 rounded-full text-sm">인기</span>
                    <h4 class="text-xl font-bold mb-3 mt-2">Professional</h4>
                    <p class="text-3xl font-bold gradient-text mb-4">₩19,900</p>
                    <ul class="space-y-2 text-sm text-wiki-muted mb-6">
                        <li>심층 진로 분석</li>
                        <li>포지션 추천 10개</li>
                        <li>스킬 갭 상세 분석</li>
                        <li>맞춤형 학습 로드맵</li>
                    </ul>
                    <button class="w-full py-3 bg-wiki-primary text-white rounded-lg hover:bg-blue-600 transition">
                        선택하기
                    </button>
                </div>
                <div class="bg-wiki-bg p-6 rounded-xl text-center">
                    <h4 class="text-xl font-bold mb-3">Premium</h4>
                    <p class="text-3xl font-bold gradient-text mb-4">₩29,900</p>
                    <ul class="space-y-2 text-sm text-wiki-muted mb-6">
                        <li>프리미엄 분석</li>
                        <li>무제한 포지션 추천</li>
                        <li>1:1 전문가 피드백</li>
                        <li>3개월 팔로우업</li>
                    </ul>
                    <button class="w-full py-3 border border-wiki-primary text-wiki-primary rounded-lg hover:bg-wiki-primary hover:text-white transition">
                        선택하기
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
  
  return c.html(renderLayout(content, 'AI 커리어 분석기 - CareerWiki', 'AI 기반 개인 맞춤형 진로 분석과 커리어 전략 리포트'))
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
          
          <div class="glass-card p-6 rounded-2xl mb-8">
              <form action="/search" method="get" class="flex gap-4">
                  <input type="text" name="q" placeholder="직업명으로 검색..." 
                         class="flex-1 px-4 py-3 bg-wiki-bg rounded-lg border border-wiki-border focus:border-wiki-primary focus:outline-none">
                  <input type="hidden" name="type" value="job">
                  <button type="submit" class="px-6 py-3 bg-wiki-primary text-white rounded-lg hover:bg-blue-600 transition">
                      <i class="fas fa-search"></i> 검색
                  </button>
              </form>
          </div>
          
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
    return c.html(renderLayout(content, '직업 백과사전 - CareerWiki'))
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
  
  return c.html(renderLayout(content, `${job.title} - 직업 정보 | CareerWiki`))
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
          
          <div class="glass-card p-6 rounded-2xl mb-8">
              <form action="/search" method="get" class="flex gap-4">
                  <input type="text" name="q" placeholder="전공명으로 검색..." 
                         class="flex-1 px-4 py-3 bg-wiki-bg rounded-lg border border-wiki-border focus:border-wiki-primary focus:outline-none">
                  <input type="hidden" name="type" value="major">
                  <button type="submit" class="px-6 py-3 bg-wiki-primary text-white rounded-lg hover:bg-blue-600 transition">
                      <i class="fas fa-search"></i> 검색
                  </button>
              </form>
          </div>
          
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
    return c.html(renderLayout(content, '전공 백과사전 - CareerWiki'))
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
  
  return c.html(renderLayout(content, '컴퓨터공학과 - 전공 정보 | CareerWiki'))
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
  
  return c.html(renderLayout(content, `"${query}" 검색 결과 - CareerWiki`))
})

// About Page
app.get('/about', (c) => {
  const content = `
    <div class="max-w-4xl mx-auto">
        <div class="glass-card p-8 rounded-2xl">
            <h1 class="text-4xl font-bold mb-6 gradient-text">CareerWiki 소개</h1>
            
            <section class="mb-8">
                <h2 class="text-2xl font-bold mb-4">우리의 미션</h2>
                <p class="text-wiki-text leading-relaxed mb-4">
                    CareerWiki는 AI 기술을 활용하여 개인 맞춤형 진로 분석과 전략을 제공하는 플랫폼입니다. 
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
                    문의사항이 있으시면 <a href="mailto:contact@careerwiki.com" class="wiki-link">contact@careerwiki.com</a>으로 연락주세요.
                </p>
            </section>
        </div>
    </div>
  `
  
  return c.html(renderLayout(content, 'CareerWiki 소개'))
})

export default app
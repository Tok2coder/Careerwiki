/** @type {import('tailwindcss').Config} */
export default {
  content: ['./src/**/*.{ts,tsx}', './public/static/*.js'],
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
  },
  plugins: [
    require('@tailwindcss/typography'),
  ],
  // 동적 클래스 구성으로 JIT 스캐너가 감지하지 못하는 클래스들
  safelist: [
    // AI Analyzer 축 색상 (동적 문자열 결합)
    'text-cyan-400', 'text-blue-400', 'text-violet-400', 'text-amber-400', 'text-emerald-400',
    'bg-cyan-400/80', 'bg-blue-400/80', 'bg-violet-400/80', 'bg-amber-400/80', 'bg-emerald-400/80',
    // 페이지별 액센트 — Blue (직업)
    'from-blue-500/20', 'to-blue-400/20', 'border-blue-500/30', 'bg-blue-500/15',
    'hover:border-blue-400/40', 'bg-blue-500/10', 'border-blue-500/20',
    // 페이지별 액센트 — Emerald (전공)
    'from-emerald-500/20', 'to-teal-400/20', 'border-emerald-500/30', 'text-emerald-400',
    'bg-emerald-500/15', 'hover:border-emerald-400/40', 'bg-emerald-500/10', 'border-emerald-500/20',
    'hover:bg-emerald-500/20',
    // 페이지별 액센트 — Violet (HowTo)
    'from-violet-500/20', 'to-purple-400/20', 'border-violet-500/30', 'text-violet-400',
    'bg-violet-500/15', 'hover:border-violet-400/40', 'bg-violet-500/10', 'border-violet-500/20',
    'hover:bg-violet-500/20', 'bg-violet-400/15', 'bg-violet-400/10',
    'hover:border-violet-400/60', 'hover:bg-violet-400/5', 'bg-violet-500',
    'bg-purple-400/10', 'border-purple-400/30', 'bg-purple-400/20', 'text-purple-400',
    'border-violet-400', 'border-violet-500/25', 'hover:bg-violet-500/25',
    // 페이지별 액센트 — Amber (AI 추천)
    'from-amber-500/20', 'to-yellow-400/20', 'border-amber-500/30', 'text-amber-400',
    'bg-amber-500/15', 'hover:border-amber-400/40', 'bg-amber-500/10', 'border-amber-500/20',
  ],
}

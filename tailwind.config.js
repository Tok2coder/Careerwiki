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
        'wiki-primary': 'rgb(var(--wp) / <alpha-value>)',
        'wiki-secondary': 'rgb(var(--ws) / <alpha-value>)',
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
    // HowTo 페이지 직접 사용 violet/purple 클래스 (howtoDetail.ts)
    'text-violet-400', 'bg-violet-500/15', 'bg-violet-500/10', 'bg-violet-500',
    'border-violet-400', 'border-violet-500/25', 'hover:bg-violet-600',
    'bg-purple-400/10', 'border-purple-400/30', 'text-purple-400',
  ],
}

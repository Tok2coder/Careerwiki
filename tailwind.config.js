/** @type {import('tailwindcss').Config} */
export default {
  content: ['./src/**/*.{ts,tsx}', './public/static/*.js'],
  darkMode: 'class',
  theme: {
    extend: {
      colors: {
        'wiki-bg': '#0a0f1e',
        'wiki-card': '#111827',
        'wiki-border': '#1f2937',
        'wiki-primary': 'rgb(var(--wp) / <alpha-value>)',
        'wiki-secondary': 'rgb(var(--ws) / <alpha-value>)',
        'wiki-accent': '#d4a853',
        'wiki-text': '#e2e8f0',
        'wiki-muted': '#94a3b8',
      },
      fontFamily: {
        sans: ['"Pretendard Variable"', 'Pretendard', '-apple-system', 'BlinkMacSystemFont', 'system-ui', 'Roboto', '"Helvetica Neue"', '"Segoe UI"', '"Apple SD Gothic Neo"', '"Noto Sans KR"', '"Malgun Gothic"', 'sans-serif'],
      }
    }
  },
  plugins: [
    require('@tailwindcss/typography'),
  ],
  // 동적 클래스 구성으로 JIT 스캐너가 감지하지 못하는 클래스들
  safelist: [
    // AI Analyzer 축 색상 (동적 문자열 결합)
    'text-cyan-400', 'text-blue-400', 'text-violet-400', 'text-amber-400', 'text-emerald-400', 'text-indigo-400', 'text-slate-400',
    'group-hover:text-indigo-400', 'group-hover:text-amber-400', 'group-hover:text-emerald-400', 'group-hover:text-violet-400',
    'bg-cyan-400/80', 'bg-blue-400/80', 'bg-violet-400/80', 'bg-amber-400/80', 'bg-emerald-400/80',
    // HowTo 페이지 직접 사용 violet/purple 클래스 (howtoDetail.ts)
    'text-violet-400', 'bg-violet-500/15', 'bg-violet-500/10', 'bg-violet-500',
    'border-violet-400', 'border-violet-500/25', 'hover:bg-violet-600',
    'bg-purple-400/10', 'border-purple-400/30', 'text-purple-400',
  ],
}

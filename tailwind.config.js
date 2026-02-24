/** @type {import('tailwindcss').Config} */
export default {
  content: ['./src/**/*.{ts,tsx}'],
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
  // src/index.tsx:9647-9657 — 'text-' + axis.color + '-400' / `bg-${axis.color}-400/80`
  safelist: [
    'text-cyan-400', 'text-blue-400', 'text-violet-400', 'text-amber-400', 'text-emerald-400',
    'bg-cyan-400/80', 'bg-blue-400/80', 'bg-violet-400/80', 'bg-amber-400/80', 'bg-emerald-400/80',
  ],
}

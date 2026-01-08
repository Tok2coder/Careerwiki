import { defineConfig } from 'vite'
import { resolve } from 'path'

/**
 * Tiptap 에디터 번들 빌드 설정
 * 클라이언트용 별도 번들로 생성
 */
export default defineConfig({
  build: {
    lib: {
      entry: resolve(__dirname, 'src/editor/index.ts'),
      name: 'HowToEditor',
      fileName: 'editor.bundle',
      formats: ['iife'] // 브라우저에서 직접 사용
    },
    outDir: 'public/static',
    emptyOutDir: false, // 기존 파일 유지 (CSS 등)
    minify: 'esbuild',
    target: 'es2020',
    sourcemap: false,
    rollupOptions: {
      output: {
        // 전역 변수로 노출
        extend: true,
        globals: {}
      }
    }
  },
  resolve: {
    alias: {
      '@': resolve(__dirname, 'src')
    }
  }
})


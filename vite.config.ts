import build from '@hono/vite-build/cloudflare-pages'
import devServer from '@hono/vite-dev-server'
import adapter from '@hono/vite-dev-server/cloudflare'
import { defineConfig } from 'vite'

export default defineConfig({
  plugins: [
    build(),
    devServer({
      adapter,
      entry: 'src/index.tsx'
    })
  ],
  server: {
    port: 3000,
    host: true
  },
  build: {
    minify: 'esbuild',
    target: 'es2022',
    sourcemap: false,
    rollupOptions: {
      output: {
        manualChunks: undefined // 단일 번들 유지 (Cloudflare Workers 제약)
      }
    },
    chunkSizeWarningLimit: 1000
  },
  esbuild: {
    drop: process.env.NODE_ENV === 'production' ? ['console', 'debugger'] : []
  }
})

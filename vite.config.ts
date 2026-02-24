import build from '@hono/vite-build/cloudflare-pages'
import devServer from '@hono/vite-dev-server'
import adapter from '@hono/vite-dev-server/cloudflare'
import { defineConfig, type Plugin } from 'vite'
import { readFileSync, copyFileSync } from 'fs'
import { resolve, dirname } from 'path'
import { fileURLToPath } from 'url'

const __dirname = dirname(fileURLToPath(import.meta.url))

/**
 * Cloudflare Workers WASM plugin
 * - .wasm imports are externalized (kept as separate files)
 * - WASM files are emitted to the output directory alongside _worker.js
 * - At runtime, CF Workers treats `import x from './file.wasm'` as WebAssembly.Module
 */
function cloudflareWasmPlugin(): Plugin {
  return {
    name: 'cloudflare-wasm',
    enforce: 'pre',
    resolveId(id) {
      if (id.endsWith('.wasm') || id.endsWith('/index_bg.wasm')) {
        return { id: './index_bg.wasm', external: true }
      }
    },
    generateBundle() {
      const wasmPath = resolve(__dirname, 'node_modules/@resvg/resvg-wasm/index_bg.wasm')
      this.emitFile({
        type: 'asset',
        fileName: 'index_bg.wasm',
        source: readFileSync(wasmPath),
      })
    },
    writeBundle(options) {
      // Fallback: ensure WASM is in output directory
      const outDir = options.dir || resolve(__dirname, 'dist')
      try {
        const src = resolve(__dirname, 'node_modules/@resvg/resvg-wasm/index_bg.wasm')
        copyFileSync(src, resolve(outDir, 'index_bg.wasm'))
      } catch { /* already copied by generateBundle */ }
    },
  }
}

export default defineConfig({
  plugins: [
    cloudflareWasmPlugin(),
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
    chunkSizeWarningLimit: 5000
  },
  esbuild: {
    drop: process.env.NODE_ENV === 'production' ? ['debugger'] : []
  }
})

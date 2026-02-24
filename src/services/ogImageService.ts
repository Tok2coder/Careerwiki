/**
 * OG Image Service: SVG → PNG 변환 (resvg-wasm)
 *
 * - WASM 바이너리는 빌드 시점에 모듈로 임포트 (Cloudflare Workers 요구사항)
 * - 한국어 폰트는 R2에서 런타임 로드
 * - 변환된 PNG를 R2에 캐시 (7일)
 */

import { initWasm, Resvg } from '@resvg/resvg-wasm'
// @ts-ignore — Vite handles .wasm imports as WebAssembly.Module for CF Workers
import resvgWasm from '@resvg/resvg-wasm/index_bg.wasm'
import type { R2Bucket } from '@cloudflare/workers-types'

let wasmInitialized = false
let fontBuffer: Uint8Array | null = null

const FONT_R2_KEY = 'assets/NotoSansKR-Regular.ttf'
const OG_CACHE_PREFIX = 'og-cache/share/'
const OG_CACHE_TTL = 7 * 24 * 60 * 60 // 7 days in seconds

/**
 * WASM + 폰트 초기화 (lazy singleton)
 */
async function ensureInitialized(r2: R2Bucket): Promise<void> {
  if (wasmInitialized && fontBuffer) return

  // Initialize WASM from pre-compiled module (bundled at build time)
  if (!wasmInitialized) {
    await initWasm(resvgWasm)
    wasmInitialized = true
  }

  // Load Korean font from R2
  if (!fontBuffer) {
    const fontObj = await r2.get(FONT_R2_KEY)
    if (!fontObj) throw new Error('Korean font not found in R2')
    fontBuffer = new Uint8Array(await fontObj.arrayBuffer())
  }
}

/**
 * SVG 문자열을 PNG Uint8Array로 변환
 */
export async function svgToPng(svgString: string, r2: R2Bucket): Promise<Uint8Array> {
  await ensureInitialized(r2)

  const resvg = new Resvg(svgString, {
    fitTo: { mode: 'width', value: 1200 },
    font: {
      fontBuffers: [fontBuffer!],
      defaultFontFamily: 'Noto Sans KR',
      sansSerifFamily: 'Noto Sans KR',
    },
  })

  const rendered = resvg.render()
  const png = rendered.asPng()
  rendered.free()
  resvg.free()

  return png
}

/**
 * R2 캐시에서 OG 이미지 조회
 */
export async function getCachedOgImage(
  r2: R2Bucket,
  token: string
): Promise<Uint8Array | null> {
  const key = `${OG_CACHE_PREFIX}${token}.png`
  const obj = await r2.get(key)
  if (!obj) return null
  return new Uint8Array(await obj.arrayBuffer())
}

/**
 * OG 이미지를 R2에 캐시 저장
 */
export async function cacheOgImage(
  r2: R2Bucket,
  token: string,
  png: Uint8Array
): Promise<void> {
  const key = `${OG_CACHE_PREFIX}${token}.png`
  await r2.put(key, png, {
    httpMetadata: {
      contentType: 'image/png',
      cacheControl: `public, max-age=${OG_CACHE_TTL}`,
    },
  })
}

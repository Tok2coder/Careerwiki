/**
 * HowTo 에디터 메인 진입점
 * 브라우저에서 window.HowToEditor로 접근 가능
 */

import { HowToEditorManager } from './editor'

// 전역 노출
declare global {
  interface Window {
    HowToEditor: typeof HowToEditorManager
    HowToEditorInstance: HowToEditorManager | null
  }
}

window.HowToEditor = HowToEditorManager
window.HowToEditorInstance = null

export { HowToEditorManager }


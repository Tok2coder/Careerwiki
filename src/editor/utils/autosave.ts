/**
 * 자동저장 유틸리티
 */

export interface AutoSaveOptions {
  draftId: number
  debounceMs?: number
  onSave?: (result: { success: boolean; version?: number; error?: string }) => void
  onConflict?: (serverVersion: number) => void
}

export class AutoSaveManager {
  private timer: ReturnType<typeof setTimeout> | null = null
  private version: number
  private draftId: number
  private debounceMs: number
  private onSave: AutoSaveOptions['onSave']
  private onConflict: AutoSaveOptions['onConflict']

  constructor(options: AutoSaveOptions) {
    this.draftId = options.draftId
    this.version = 1
    this.debounceMs = options.debounceMs ?? 3000
    this.onSave = options.onSave
    this.onConflict = options.onConflict
  }

  setVersion(v: number) {
    this.version = v
  }

  getVersion() {
    return this.version
  }

  schedule(getData: () => { contentJson: string; contentHtml: string }) {
    if (this.timer) {
      clearTimeout(this.timer)
    }

    this.timer = setTimeout(async () => {
      await this.save(getData())
    }, this.debounceMs)
  }

  async save(data: { contentJson: string; contentHtml: string }): Promise<boolean> {
    try {
      // localStorage 백업
      localStorage.setItem(`howto-draft-${this.draftId}`, JSON.stringify({
        ...data,
        version: this.version,
        savedAt: new Date().toISOString()
      }))

      // 서버 저장
      const res = await fetch(`/api/howto/drafts/${this.draftId}`, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json',
          'If-Match': this.version.toString()
        },
        body: JSON.stringify(data)
      })

      const result = await res.json()

      if (result.success) {
        this.version = result.newVersion || this.version + 1
        this.onSave?.({ success: true, version: this.version })
        return true
      } else if (res.status === 409) {
        this.onConflict?.(result.serverVersion)
        return false
      } else {
        this.onSave?.({ success: false, error: result.error })
        return false
      }
    } catch (error) {
      this.onSave?.({ success: false, error: (error as Error).message })
      return false
    }
  }

  cancel() {
    if (this.timer) {
      clearTimeout(this.timer)
      this.timer = null
    }
  }

  destroy() {
    this.cancel()
  }
}

/**
 * localStorage에서 최신 초안 복구
 */
export function recoverFromLocalStorage(draftId: number): {
  content: unknown
  version: number
  savedAt: string
} | null {
  try {
    const data = localStorage.getItem(`howto-draft-${draftId}`)
    if (data) {
      return JSON.parse(data)
    }
  } catch (e) {
    console.warn('Failed to recover from localStorage:', e)
  }
  return null
}

/**
 * localStorage 초안 삭제
 */
export function clearLocalStorage(draftId: number) {
  localStorage.removeItem(`howto-draft-${draftId}`)
}


/**
 * 슬래시 커맨드 확장
 * "/" 입력 시 블록 삽입 메뉴 표시
 */

import { Extension } from '@tiptap/core'
import { Plugin, PluginKey } from '@tiptap/pm/state'

export interface SlashCommandOptions {
  onShow: (pos: { x: number; y: number }) => void
  onHide: () => void
  onFilter: (query: string) => void
}

export const SlashCommandExtension = Extension.create<SlashCommandOptions>({
  name: 'slashCommand',

  addOptions() {
    return {
      onShow: () => {},
      onHide: () => {},
      onFilter: () => {},
    }
  },

  addProseMirrorPlugins() {
    const { onShow, onHide, onFilter } = this.options

    return [
      new Plugin({
        key: new PluginKey('slashCommand'),
        props: {
          handleKeyDown: (view, event) => {
            const { state } = view
            const { selection } = state
            const { $from } = selection

            // "/" 키 입력 감지
            if (event.key === '/') {
              // 빈 줄에서만 슬래시 메뉴 표시
              const isEmptyLine = $from.parent.textContent === ''
              if (isEmptyLine) {
                // 커서 위치 계산
                const coords = view.coordsAtPos($from.pos)
                setTimeout(() => {
                  onShow({ x: coords.left, y: coords.bottom })
                }, 10)
              }
              return false
            }

            // 슬래시 이후 타이핑 시 필터링
            const textBefore = $from.parent.textContent.slice(0, $from.parentOffset)
            const slashMatch = textBefore.match(/\/(\w*)$/)
            if (slashMatch) {
              onFilter(slashMatch[1])
            }

            // Escape로 메뉴 닫기
            if (event.key === 'Escape') {
              onHide()
              return false
            }

            return false
          },
        },
      }),
    ]
  },
})


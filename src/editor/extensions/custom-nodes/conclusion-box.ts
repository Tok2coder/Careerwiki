/**
 * ConclusionBox 노드
 * 결론/요약을 위한 강조 박스
 */

import { Node, mergeAttributes } from '@tiptap/core'

export interface ConclusionBoxOptions {
  HTMLAttributes: Record<string, unknown>
}

declare module '@tiptap/core' {
  interface Commands<ReturnType> {
    conclusionBox: {
      setConclusionBox: () => ReturnType
      toggleConclusionBox: () => ReturnType
    }
  }
}

export const ConclusionBox = Node.create<ConclusionBoxOptions>({
  name: 'conclusionBox',

  group: 'block',

  content: 'block+',

  defining: true,

  addOptions() {
    return {
      HTMLAttributes: {},
    }
  },

  parseHTML() {
    return [
      { tag: 'div[data-conclusion-box]' },
    ]
  },

  renderHTML({ HTMLAttributes }) {
    return [
      'div',
      mergeAttributes(this.options.HTMLAttributes, HTMLAttributes, {
        'data-conclusion-box': '',
        class: 'conclusion-box'
      }),
      0
    ]
  },

  addCommands() {
    return {
      setConclusionBox: () => ({ commands }) => {
        return commands.wrapIn(this.name)
      },
      toggleConclusionBox: () => ({ commands }) => {
        return commands.toggleWrap(this.name)
      },
    }
  },
})


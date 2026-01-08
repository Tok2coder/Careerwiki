/**
 * CheckpointBox 노드
 * 중요한 단계나 체크포인트를 강조하는 박스
 */

import { Node, mergeAttributes } from '@tiptap/core'

export interface CheckpointBoxOptions {
  HTMLAttributes: Record<string, unknown>
}

declare module '@tiptap/core' {
  interface Commands<ReturnType> {
    checkpointBox: {
      setCheckpointBox: () => ReturnType
      toggleCheckpointBox: () => ReturnType
    }
  }
}

export const CheckpointBox = Node.create<CheckpointBoxOptions>({
  name: 'checkpointBox',

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
      { tag: 'div[data-checkpoint-box]' },
    ]
  },

  renderHTML({ HTMLAttributes }) {
    return [
      'div',
      mergeAttributes(this.options.HTMLAttributes, HTMLAttributes, {
        'data-checkpoint-box': '',
        class: 'checkpoint-box'
      }),
      0
    ]
  },

  addCommands() {
    return {
      setCheckpointBox: () => ({ commands }) => {
        return commands.wrapIn(this.name)
      },
      toggleCheckpointBox: () => ({ commands }) => {
        return commands.toggleWrap(this.name)
      },
    }
  },
})


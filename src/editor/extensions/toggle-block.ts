import { Node, mergeAttributes } from '@tiptap/core'

export const ToggleBlock = Node.create({
  name: 'toggleBlock',
  group: 'block',
  content: 'block+',
  defining: true,

  addAttributes() {
    return {
      summary: { default: '클릭하여 펼치기' },
    }
  },

  parseHTML() {
    return [{ tag: 'details.toggle-block' }]
  },

  renderHTML({ node, HTMLAttributes }) {
    return [
      'details',
      mergeAttributes(HTMLAttributes, { class: 'toggle-block', open: true }),
      ['summary', {}, node.attrs.summary || '클릭하여 펼치기'],
      ['div', { class: 'toggle-content' }, 0],
    ]
  },
})

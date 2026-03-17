import { Node, mergeAttributes } from '@tiptap/core'

export type CalloutType = 'tip' | 'warning' | 'danger' | 'info'

export const CalloutBox = Node.create({
  name: 'calloutBox',
  group: 'block',
  content: 'block+',
  defining: true,

  addAttributes() {
    return {
      type: { default: 'info' as CalloutType },
    }
  },

  parseHTML() {
    return [{ tag: 'div[data-callout]' }]
  },

  renderHTML({ node, HTMLAttributes }) {
    const calloutType = node.attrs.type as CalloutType
    return [
      'div',
      mergeAttributes(HTMLAttributes, {
        'data-callout': calloutType,
        class: `callout-box callout-${calloutType}`,
      }),
      0, // content hole
    ]
  },
})

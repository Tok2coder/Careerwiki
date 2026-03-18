import { Node, mergeAttributes } from '@tiptap/core'

export type CalloutType = 'tip' | 'warning' | 'danger' | 'info'

const CALLOUT_ICONS: Record<CalloutType, string> = {
  tip: '💡',
  warning: '⚠️',
  danger: '🚨',
  info: 'ℹ️',
}

const CALLOUT_LABELS: Record<CalloutType, string> = {
  tip: '팁',
  warning: '주의',
  danger: '위험',
  info: '정보',
}

export const CalloutBox = Node.create({
  name: 'calloutBox',
  group: 'block',
  content: 'block+',
  defining: true,

  addAttributes() {
    return {
      type: {
        default: 'info' as CalloutType,
        parseHTML: (element: HTMLElement) => element.getAttribute('data-callout') || 'info',
        renderHTML: (attributes: Record<string, string>) => ({
          'data-callout': attributes.type,
        }),
      },
    }
  },

  parseHTML() {
    return [{ tag: 'div[data-callout]' }]
  },

  renderHTML({ node, HTMLAttributes }) {
    const calloutType = (node.attrs.type || 'info') as CalloutType
    return [
      'div',
      mergeAttributes(HTMLAttributes, {
        'data-callout': calloutType,
        class: `callout-box callout-${calloutType}`,
      }),
      0,
    ]
  },

  addNodeView() {
    return ({ node, editor, getPos }) => {
      const calloutType = (node.attrs.type || 'info') as CalloutType

      const dom = document.createElement('div')
      dom.className = `callout-box callout-${calloutType}`
      dom.setAttribute('data-callout', calloutType)

      // 헤더 (아이콘 + 라벨 + 타입 변경 버튼)
      const header = document.createElement('div')
      header.className = 'callout-header'
      header.contentEditable = 'false'

      const icon = document.createElement('span')
      icon.className = 'callout-icon'
      icon.textContent = CALLOUT_ICONS[calloutType] || 'ℹ️'

      const label = document.createElement('span')
      label.className = 'callout-label'
      label.textContent = CALLOUT_LABELS[calloutType] || '정보'

      header.appendChild(icon)
      header.appendChild(label)

      // 타입 변경 드롭다운
      const typeSelector = document.createElement('div')
      typeSelector.className = 'callout-type-selector'
      typeSelector.contentEditable = 'false'
      const types: CalloutType[] = ['tip', 'warning', 'danger', 'info']
      types.forEach(t => {
        if (t === calloutType) return
        const btn = document.createElement('button')
        btn.type = 'button'
        btn.className = 'callout-type-btn'
        btn.textContent = `${CALLOUT_ICONS[t]} ${CALLOUT_LABELS[t]}`
        btn.addEventListener('click', (e) => {
          e.preventDefault()
          e.stopPropagation()
          if (typeof getPos === 'function') {
            const pos = getPos()
            if (pos != null) {
              editor.chain().focus().command(({ tr }) => {
                tr.setNodeMarkup(pos, undefined, { ...node.attrs, type: t })
                return true
              }).run()
            }
          }
        })
        typeSelector.appendChild(btn)
      })
      header.appendChild(typeSelector)

      dom.appendChild(header)

      // 콘텐츠 영역
      const contentDOM = document.createElement('div')
      contentDOM.className = 'callout-content'
      dom.appendChild(contentDOM)

      return { dom, contentDOM }
    }
  },
})

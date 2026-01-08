import { Node, mergeAttributes } from '@tiptap/core'

declare module '@tiptap/core' {
  interface Commands<ReturnType> {
    customBlockquote: {
      setBlockquote: () => ReturnType
      toggleBlockquote: () => ReturnType
      unsetBlockquote: () => ReturnType
      setBlockquoteAlign: (align: 'left' | 'center' | 'right') => ReturnType
      setBlockquoteSize: (size: 'small' | 'medium' | 'large') => ReturnType
    }
  }
}

export const CustomBlockquote = Node.create({
  name: 'blockquote',
  
  group: 'block',
  
  content: 'block+',
  
  defining: true,

  addAttributes() {
    return {
      align: {
        default: 'left',
        parseHTML: (element) => element.getAttribute('data-align') || 'left',
        renderHTML: (attributes) => ({
          'data-align': attributes.align,
        }),
      },
      size: {
        default: 'medium',
        parseHTML: (element) => element.getAttribute('data-size') || 'medium',
        renderHTML: (attributes) => ({
          'data-size': attributes.size,
        }),
      },
    }
  },

  parseHTML() {
    return [{ tag: 'blockquote' }]
  },

  renderHTML({ HTMLAttributes }) {
    const align = HTMLAttributes['data-align'] || 'left'
    const size = HTMLAttributes['data-size'] || 'medium'
    
    return [
      'blockquote',
      mergeAttributes(HTMLAttributes, {
        class: `custom-blockquote blockquote-align-${align} blockquote-size-${size}`,
      }),
      0
    ]
  },

  addNodeView() {
    return ({ node, getPos, editor }) => {
      // 컨테이너
      const container = document.createElement('div')
      container.className = 'blockquote-wrapper'
      container.setAttribute('data-align', node.attrs.align || 'left')
      container.setAttribute('data-size', node.attrs.size || 'medium')

      // blockquote 요소
      const blockquote = document.createElement('blockquote')
      blockquote.className = `custom-blockquote blockquote-align-${node.attrs.align || 'left'} blockquote-size-${node.attrs.size || 'medium'}`

      // 콘텐츠 영역
      const content = document.createElement('div')
      content.className = 'blockquote-content'
      blockquote.appendChild(content)

      // 툴바
      const toolbar = document.createElement('div')
      toolbar.className = 'blockquote-toolbar'
      toolbar.innerHTML = `
        <button type="button" data-action="align-left" title="왼쪽 정렬"><i class="fas fa-align-left"></i></button>
        <button type="button" data-action="align-center" title="가운데 정렬"><i class="fas fa-align-center"></i></button>
        <button type="button" data-action="align-right" title="오른쪽 정렬"><i class="fas fa-align-right"></i></button>
        <span class="toolbar-divider"></span>
        <button type="button" data-action="size-small" title="작게">S</button>
        <button type="button" data-action="size-medium" title="보통">M</button>
        <button type="button" data-action="size-large" title="크게">L</button>
        <span class="toolbar-divider"></span>
        <button type="button" data-action="delete" title="삭제"><i class="fas fa-trash"></i></button>
      `

      container.appendChild(blockquote)
      container.appendChild(toolbar)

      // 툴바 클릭 이벤트
      toolbar.addEventListener('click', (e) => {
        const target = e.target as HTMLElement
        const button = target.closest('button')
        if (!button) return

        e.preventDefault()
        e.stopPropagation()

        const action = button.getAttribute('data-action')
        const pos = typeof getPos === 'function' ? getPos() : 0

        if (action?.startsWith('align-')) {
          const align = action.replace('align-', '') as 'left' | 'center' | 'right'
          editor.chain().focus().setNodeSelection(pos).updateAttributes('blockquote', { align }).run()
          blockquote.className = `custom-blockquote blockquote-align-${align} blockquote-size-${node.attrs.size || 'medium'}`
          container.setAttribute('data-align', align)
        } else if (action?.startsWith('size-')) {
          const size = action.replace('size-', '') as 'small' | 'medium' | 'large'
          editor.chain().focus().setNodeSelection(pos).updateAttributes('blockquote', { size }).run()
          blockquote.className = `custom-blockquote blockquote-align-${node.attrs.align || 'left'} blockquote-size-${size}`
          container.setAttribute('data-size', size)
        } else if (action === 'delete') {
          editor.chain().focus().setNodeSelection(pos).deleteSelection().run()
        }
      })

      return {
        dom: container,
        contentDOM: content,
        update: (updatedNode) => {
          if (updatedNode.type.name !== 'blockquote') return false
          const align = updatedNode.attrs.align || 'left'
          const size = updatedNode.attrs.size || 'medium'
          blockquote.className = `custom-blockquote blockquote-align-${align} blockquote-size-${size}`
          container.setAttribute('data-align', align)
          container.setAttribute('data-size', size)
          return true
        },
      }
    }
  },

  addCommands() {
    return {
      setBlockquote: () => ({ commands }) => {
        return commands.wrapIn(this.name)
      },
      toggleBlockquote: () => ({ commands }) => {
        return commands.toggleWrap(this.name)
      },
      unsetBlockquote: () => ({ commands }) => {
        return commands.lift(this.name)
      },
      setBlockquoteAlign: (align) => ({ commands }) => {
        return commands.updateAttributes(this.name, { align })
      },
      setBlockquoteSize: (size) => ({ commands }) => {
        return commands.updateAttributes(this.name, { size })
      },
    }
  },

  addKeyboardShortcuts() {
    return {
      'Mod-Shift-b': () => this.editor.commands.toggleBlockquote(),
    }
  },
})

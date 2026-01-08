/**
 * Footnote 노드
 * 각주를 위한 인라인 노드 - 본문에 [1], [2] 형태로 표시되고
 * 클릭하면 하단 각주 섹션으로 이동
 */

import { Node, mergeAttributes } from '@tiptap/core'

export interface FootnoteOptions {
  HTMLAttributes: Record<string, unknown>
}

declare module '@tiptap/core' {
  interface Commands<ReturnType> {
    footnote: {
      /**
       * 각주 삽입
       */
      insertFootnote: (attrs: { id: number; text: string; url?: string }) => ReturnType
      /**
       * 각주 업데이트
       */
      updateFootnote: (id: number, attrs: { text: string; url?: string }) => ReturnType
    }
  }
}

export const Footnote = Node.create<FootnoteOptions>({
  name: 'footnote',

  group: 'inline',

  inline: true,

  atom: true,

  addAttributes() {
    return {
      id: {
        default: 1,
        parseHTML: element => parseInt(element.getAttribute('data-footnote-id') || '1'),
        renderHTML: attributes => ({
          'data-footnote-id': attributes.id,
        }),
      },
      text: {
        default: '',
        parseHTML: element => element.getAttribute('data-footnote-text') || '',
        renderHTML: attributes => ({
          'data-footnote-text': attributes.text,
        }),
      },
      url: {
        default: '',
        parseHTML: element => element.getAttribute('data-footnote-url') || '',
        renderHTML: attributes => attributes.url ? { 'data-footnote-url': attributes.url } : {},
      },
    }
  },

  addOptions() {
    return {
      HTMLAttributes: {},
    }
  },

  parseHTML() {
    return [
      { tag: 'sup[data-footnote]' },
    ]
  },

  renderHTML({ node, HTMLAttributes }) {
    const id = node.attrs.id
    const url = node.attrs.url
    return [
      'sup',
      mergeAttributes(this.options.HTMLAttributes, HTMLAttributes, {
        'data-footnote': '',
        class: 'footnote-ref',
      }),
      [
        'a',
        {
          href: url || `#fn-${id}`,
          ...(url ? { target: '_blank', rel: 'noopener noreferrer' } : {}),
          id: `fnref-${id}`,
          class: 'footnote-link',
        },
        `${id}`
      ]
    ]
  },

  addCommands() {
    return {
      insertFootnote: (attrs) => ({ chain, state }) => {
        return chain()
          .insertContent({
            type: this.name,
            attrs,
          })
          .run()
      },
      updateFootnote: (id, attrs) => ({ tr, state }) => {
        // 문서에서 해당 ID의 footnote를 찾아 업데이트
        let updated = false
        state.doc.descendants((node, pos) => {
          if (node.type.name === this.name && node.attrs.id === id) {
            tr.setNodeMarkup(pos, undefined, { ...node.attrs, ...attrs })
            updated = true
            return false
          }
          return true
        })
        return updated
      },
    }
  },

  // NodeView로 에디터에서 클릭 가능하게 만들기
  addNodeView() {
    return ({ node, HTMLAttributes, getPos, editor }) => {
      const dom = document.createElement('sup')
      dom.className = 'footnote-ref'
      dom.setAttribute('data-footnote', '')
      dom.setAttribute('data-footnote-id', String(node.attrs.id))
      
      const link = document.createElement('a')
      link.href = `#fn-${node.attrs.id}`
      link.id = `fnref-${node.attrs.id}`
      link.className = 'footnote-link'
      link.textContent = `${node.attrs.id}`
      link.title = node.attrs.text || '각주'
      
      // 클릭 시 각주 편집 모달 열기
      link.addEventListener('click', (e) => {
        e.preventDefault()
        const event = new CustomEvent('footnote-edit', {
          detail: {
            id: node.attrs.id,
            text: node.attrs.text,
            url: node.attrs.url,
            pos: typeof getPos === 'function' ? getPos() : 0
          }
        })
        window.dispatchEvent(event)
      })
      
      dom.appendChild(link)
      
      return {
        dom,
        update: (updatedNode) => {
          if (updatedNode.type.name !== this.name) return false
          link.textContent = `${updatedNode.attrs.id}`
          link.title = updatedNode.attrs.text || '각주'
          dom.setAttribute('data-footnote-id', String(updatedNode.attrs.id))
          return true
        }
      }
    }
  }
})


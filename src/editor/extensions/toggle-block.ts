import { Node, mergeAttributes } from '@tiptap/core'

export const ToggleBlock = Node.create({
  name: 'toggleBlock',
  group: 'block',
  content: 'block+',
  defining: true,

  addAttributes() {
    return {
      summary: {
        default: '클릭하여 펼치기',
        parseHTML: (element: HTMLElement) => {
          const summary = element.querySelector('summary')
          return summary?.textContent || '클릭하여 펼치기'
        },
      },
    }
  },

  parseHTML() {
    return [{ tag: 'details.toggle-block' }, { tag: 'details' }]
  },

  renderHTML({ node, HTMLAttributes }) {
    return [
      'details',
      mergeAttributes(HTMLAttributes, { class: 'toggle-block', open: true }),
      ['summary', {}, node.attrs.summary || '클릭하여 펼치기'],
      ['div', { class: 'toggle-content' }, 0],
    ]
  },

  addNodeView() {
    return ({ node, editor, getPos }) => {
      // 외부 컨테이너
      const dom = document.createElement('div')
      dom.className = 'toggle-block toggle-editor-wrapper'

      // 접기/펼치기 헤더
      const header = document.createElement('div')
      header.className = 'toggle-header'
      header.contentEditable = 'false'

      const arrow = document.createElement('span')
      arrow.className = 'toggle-arrow'
      arrow.textContent = '▶'

      const summaryInput = document.createElement('span')
      summaryInput.className = 'toggle-summary-text'
      summaryInput.contentEditable = 'true'
      summaryInput.textContent = node.attrs.summary || '클릭하여 펼치기'
      summaryInput.setAttribute('placeholder', '제목 입력...')

      // summary 편집 후 저장
      summaryInput.addEventListener('blur', () => {
        if (typeof getPos === 'function') {
          const pos = getPos()
          if (pos != null) {
            const newSummary = summaryInput.textContent?.trim() || '클릭하여 펼치기'
            if (newSummary !== node.attrs.summary) {
              editor.commands.command(({ tr }) => {
                tr.setNodeMarkup(pos, undefined, { ...node.attrs, summary: newSummary })
                return true
              })
            }
          }
        }
      })
      summaryInput.addEventListener('keydown', (e) => {
        if (e.key === 'Enter') {
          e.preventDefault()
          summaryInput.blur()
          // 포커스를 본문으로 이동
          const contentEl = dom.querySelector('.toggle-content') as HTMLElement
          contentEl?.focus()
        }
      })

      header.appendChild(arrow)
      header.appendChild(summaryInput)

      // 접기/펼치기 토글
      let isOpen = true
      const contentWrapper = document.createElement('div')
      contentWrapper.className = 'toggle-content'

      const toggleOpen = () => {
        isOpen = !isOpen
        dom.classList.toggle('toggle-closed', !isOpen)
        arrow.textContent = isOpen ? '▼' : '▶'
        contentWrapper.style.display = isOpen ? '' : 'none'
      }

      // 화살표 클릭으로만 토글 (summary 편집과 충돌 방지)
      arrow.addEventListener('click', (e) => {
        e.preventDefault()
        e.stopPropagation()
        toggleOpen()
      })

      // 초기 상태: 열림
      arrow.textContent = '▼'

      dom.appendChild(header)
      dom.appendChild(contentWrapper)

      return {
        dom,
        contentDOM: contentWrapper,
        update: (updatedNode) => {
          if (updatedNode.type.name !== 'toggleBlock') return false
          summaryInput.textContent = updatedNode.attrs.summary || '클릭하여 펼치기'
          return true
        },
      }
    }
  },
})

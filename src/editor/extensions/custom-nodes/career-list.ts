/**
 * CareerList 노드
 * 커리어위키 전용 목록 패턴
 */

import { Node, mergeAttributes } from '@tiptap/core'

// 커리어 목록 컨테이너
export const CareerList = Node.create({
  name: 'careerList',

  group: 'block',

  content: 'careerListItem+',

  defining: true,

  isolating: true,

  parseHTML() {
    return [
      { tag: 'div[data-career-list]' },
    ]
  },

  renderHTML({ HTMLAttributes }) {
    return [
      'div',
      mergeAttributes(HTMLAttributes, {
        'data-career-list': '',
        class: 'career-list'
      }),
      0
    ]
  },
})

// 커리어 목록 아이템 - paragraph로 변경하여 편집 안정성 확보
export const CareerListItem = Node.create({
  name: 'careerListItem',

  content: 'paragraph',

  defining: true,

  isolating: true,

  addAttributes() {
    return {
      id: {
        default: null,
        parseHTML: element => element.getAttribute('data-id'),
        renderHTML: attributes => {
          if (!attributes.id) return {}
          return { 'data-id': attributes.id }
        },
      },
      slug: {
        default: null,
        parseHTML: element => element.getAttribute('data-slug'),
        renderHTML: attributes => {
          if (!attributes.slug) return {}
          return { 'data-slug': attributes.slug }
        },
      },
      type: {
        default: 'job',
        parseHTML: element => element.getAttribute('data-type') || 'job',
        renderHTML: attributes => {
          return { 'data-type': attributes.type }
        },
      },
    }
  },

  parseHTML() {
    return [
      { tag: 'div[data-career-list-item]' },
    ]
  },

  renderHTML({ HTMLAttributes }) {
    return [
      'div',
      mergeAttributes(HTMLAttributes, {
        'data-career-list-item': '',
        class: 'career-list-item'
      }),
      ['span', { class: 'career-list-bullet', contenteditable: 'false' }, '▸'],
      ['div', { class: 'career-list-content' }, 0]
    ]
  },
})

/**
 * QnA 블록 노드
 * Q&A 형식의 교육적 콘텐츠
 */

import { Node, mergeAttributes } from '@tiptap/core'

// QnA 컨테이너
export const QnABlock = Node.create({
  name: 'qnaBlock',

  group: 'block',

  content: 'qnaQuestion qnaAnswer',

  defining: true,

  isolating: true,

  parseHTML() {
    return [
      { tag: 'div[data-qna-block]' },
    ]
  },

  renderHTML({ HTMLAttributes }) {
    return [
      'div',
      mergeAttributes(HTMLAttributes, {
        'data-qna-block': '',
        class: 'qna-block'
      }),
      0
    ]
  },
})

// Q 부분 - paragraph로 변경하여 IME 안정성 확보
export const QnAQuestion = Node.create({
  name: 'qnaQuestion',

  content: 'paragraph',

  defining: true,

  isolating: true,

  parseHTML() {
    return [
      { tag: 'div[data-qna-question]' },
    ]
  },

  renderHTML({ HTMLAttributes }) {
    return [
      'div',
      mergeAttributes(HTMLAttributes, {
        'data-qna-question': '',
        class: 'qna-question'
      }),
      ['span', { class: 'qna-label qna-label-q', contenteditable: 'false' }, 'Q'],
      ['div', { class: 'qna-content' }, 0]
    ]
  },
})

// A 부분
export const QnAAnswer = Node.create({
  name: 'qnaAnswer',

  content: 'block+',

  defining: true,

  isolating: true,

  parseHTML() {
    return [
      { tag: 'div[data-qna-answer]' },
    ]
  },

  renderHTML({ HTMLAttributes }) {
    return [
      'div',
      mergeAttributes(HTMLAttributes, {
        'data-qna-answer': '',
        class: 'qna-answer'
      }),
      ['span', { class: 'qna-label qna-label-a', contenteditable: 'false' }, 'A'],
      ['div', { class: 'qna-content' }, 0]
    ]
  },
})

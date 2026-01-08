/**
 * CareerWiki 커스텀 노드 모음
 */

import { CheckpointBox } from './checkpoint-box'
import { ConclusionBox } from './conclusion-box'
import { QnABlock, QnAQuestion, QnAAnswer } from './qna-block'
import { CareerList, CareerListItem } from './career-list'
import { Footnote } from './footnote'

export function getCustomNodes() {
  return [
    CheckpointBox,
    ConclusionBox,
    QnABlock,
    QnAQuestion,
    QnAAnswer,
    CareerList,
    CareerListItem,
    Footnote
  ]
}

export { CheckpointBox, ConclusionBox, QnABlock, QnAQuestion, QnAAnswer, CareerList, CareerListItem, Footnote }


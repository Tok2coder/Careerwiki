import BulletList from '@tiptap/extension-bullet-list'

// "- " 자동 변환 비활성화 - 슬래시 메뉴나 툴바로만 생성
export const CustomBulletList = BulletList.extend({
  addInputRules() {
    return []
  },
})

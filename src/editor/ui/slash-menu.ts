/**
 * 슬래시 메뉴 UI
 */

export interface SlashMenuItem {
  command: string
  label: string
  icon: string
  keywords: string
  group: string
}

const SLASH_MENU_ITEMS: SlashMenuItem[] = [
  // 기본
  { command: 'h1', label: '제목 1', icon: 'fa-heading', keywords: 'h1 heading 제목 헤딩', group: '기본' },
  { command: 'h2', label: '제목 2', icon: 'fa-heading', keywords: 'h2 heading 제목 헤딩', group: '기본' },
  { command: 'h3', label: '제목 3', icon: 'fa-heading', keywords: 'h3 heading 제목 헤딩', group: '기본' },
  { command: 'bulletList', label: '글머리 기호', icon: 'fa-list-ul', keywords: 'bullet list 목록 리스트', group: '기본' },
  { command: 'orderedList', label: '번호 매기기', icon: 'fa-list-ol', keywords: 'ordered numbered list 번호 목록', group: '기본' },
  { command: 'taskList', label: '체크리스트', icon: 'fa-tasks', keywords: 'task checklist todo 체크 할일', group: '기본' },
  { command: 'blockquote', label: '인용구', icon: 'fa-quote-left', keywords: 'quote blockquote 인용 따옴표', group: '기본' },
  { command: 'codeBlock', label: '코드 블록', icon: 'fa-code', keywords: 'code 코드 프로그래밍', group: '기본' },
  { command: 'horizontalRule', label: '구분선', icon: 'fa-minus', keywords: 'divider hr horizontal rule 구분선 가로선', group: '기본' },
  
  // 커스텀 블록
  { command: 'checkpointBox', label: '체크포인트 박스', icon: 'fa-check-circle', keywords: 'checkpoint 체크포인트 중요 핵심', group: '커스텀 블록' },
  { command: 'conclusionBox', label: '결론/요약 박스', icon: 'fa-lightbulb', keywords: 'conclusion summary 결론 요약 정리', group: '커스텀 블록' },
  { command: 'qnaBlock', label: 'Q&A 블록', icon: 'fa-question-circle', keywords: 'qna question answer 질문 답변', group: '커스텀 블록' },
  { command: 'careerList', label: '커리어 목록', icon: 'fa-list-check', keywords: 'career list 커리어 직업 목록', group: '커스텀 블록' },
  
  // 미디어
  { command: 'image', label: '이미지', icon: 'fa-image', keywords: 'image picture 이미지 사진 그림', group: '미디어' },
  { command: 'table', label: '표', icon: 'fa-table', keywords: 'table 표 테이블', group: '미디어' },
  
  // 참조
  { command: 'footnote', label: '각주 (출처)', icon: 'fa-asterisk', keywords: 'footnote reference 각주 출처 참조 주석', group: '참조' },
]

export interface SlashMenuOptions {
  onSelect: (item: SlashMenuItem) => void
  onClose: () => void
}

export function createSlashMenu(options: SlashMenuOptions): HTMLElement {
  const { onSelect, onClose } = options

  const menuEl = document.createElement('div')
  menuEl.id = 'slash-menu'
  menuEl.className = 'slash-menu hidden'
  
  let selectedIndex = 0
  let visibleItems: HTMLElement[] = []

  // 그룹별로 아이템 정리
  const groups = new Map<string, SlashMenuItem[]>()
  SLASH_MENU_ITEMS.forEach(item => {
    const list = groups.get(item.group) || []
    list.push(item)
    groups.set(item.group, list)
  })

  // HTML 생성
  let html = '<div class="slash-menu-header">블록 삽입</div><div class="slash-menu-items">'
  
  groups.forEach((items, groupName) => {
    html += `<div class="slash-menu-group-title">${groupName}</div>`
    items.forEach(item => {
      const iconClass = item.command === 'checkpointBox' ? 'text-green-500' 
        : item.command === 'conclusionBox' ? 'text-wiki-primary'
        : item.command === 'qnaBlock' ? 'text-amber-500'
        : item.command === 'careerList' ? 'text-wiki-secondary'
        : ''
      html += `
        <div class="slash-menu-item" data-command="${item.command}" data-keywords="${item.keywords}">
          <i class="fas ${item.icon} w-5 ${iconClass}"></i>
          <span>${item.label}</span>
        </div>
      `
    })
  })
  
  html += '</div>'
  menuEl.innerHTML = html

  // 아이템 이벤트 바인딩
  const itemEls = menuEl.querySelectorAll('.slash-menu-item')
  visibleItems = Array.from(itemEls) as HTMLElement[]
  
  itemEls.forEach((el, index) => {
    el.addEventListener('click', () => {
      const command = (el as HTMLElement).dataset.command!
      const item = SLASH_MENU_ITEMS.find(i => i.command === command)!
      onSelect(item)
    })
    
    el.addEventListener('mouseenter', () => {
      selectedIndex = index
      updateSelection()
    })
  })

  // 키보드 이벤트
  document.addEventListener('keydown', (e) => {
    if (menuEl.classList.contains('hidden')) return
    
    if (e.key === 'ArrowDown') {
      e.preventDefault()
      selectedIndex = (selectedIndex + 1) % visibleItems.length
      updateSelection()
    } else if (e.key === 'ArrowUp') {
      e.preventDefault()
      selectedIndex = (selectedIndex - 1 + visibleItems.length) % visibleItems.length
      updateSelection()
    } else if (e.key === 'Enter') {
      e.preventDefault()
      const el = visibleItems[selectedIndex]
      if (el) {
        const command = el.dataset.command!
        const item = SLASH_MENU_ITEMS.find(i => i.command === command)!
        onSelect(item)
      }
    } else if (e.key === 'Escape') {
      e.preventDefault()
      onClose()
    }
  })

  // 바깥 클릭으로 닫기
  document.addEventListener('click', (e) => {
    if (!menuEl.contains(e.target as Node) && !menuEl.classList.contains('hidden')) {
      onClose()
    }
  })

  function updateSelection() {
    visibleItems.forEach((el, i) => {
      el.classList.toggle('is-selected', i === selectedIndex)
    })
  }

  // 초기 선택
  updateSelection()

  return menuEl
}


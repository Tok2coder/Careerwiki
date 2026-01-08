/**
 * Tiptap 기반 HowTo 에디터 매니저
 */

import { Editor, type JSONContent } from '@tiptap/core'
import { StarterKit } from '@tiptap/starter-kit'
import { Placeholder } from '@tiptap/extension-placeholder'
import { Link } from '@tiptap/extension-link'
import { ResizableImage } from './extensions/resizable-image'
import { Underline } from '@tiptap/extension-underline'
import { Highlight } from '@tiptap/extension-highlight'
import { Color } from '@tiptap/extension-color'
import { TextStyle } from '@tiptap/extension-text-style'
import { TextAlign } from '@tiptap/extension-text-align'
import { FontFamily } from '@tiptap/extension-font-family'
import { Table } from '@tiptap/extension-table'
import { TableRow } from '@tiptap/extension-table-row'
import { TableHeader } from '@tiptap/extension-table-header'
import { CustomTableCell } from './extensions/custom-table-cell'
import { TaskList } from '@tiptap/extension-task-list'
import { TaskItem } from '@tiptap/extension-task-item'

import { getCustomNodes } from './extensions/custom-nodes'
import { SlashCommandExtension } from './extensions/slash-command'
import { FontSize } from './extensions/font-size'
import { CustomBlockquote } from './extensions/custom-blockquote'
import { CustomBulletList } from './extensions/custom-bullet-list'
import { createSlashMenu, type SlashMenuItem } from './ui/slash-menu'
import { uploadImage } from './utils/upload'

export interface EditorOptions {
  container: string | HTMLElement
  draftId?: number
  version?: number
  initialContent?: JSONContent | string
  onSave?: (data: { success: boolean; version?: number }) => void
  onError?: (error: Error) => void
  onUpdate?: () => void
}

export class HowToEditorManager {
  private editor: Editor | null = null
  private draftId: number | null
  private version: number
  private autoSaveTimer: ReturnType<typeof setTimeout> | null = null
  private isDirty = false
  private onSaveCallback: EditorOptions['onSave']
  private onErrorCallback: EditorOptions['onError']
  private onUpdateCallback: EditorOptions['onUpdate']
  private slashMenuEl: HTMLElement | null = null

  constructor(options: EditorOptions) {
    this.draftId = options.draftId ?? null
    this.version = options.version ?? 1
    this.onSaveCallback = options.onSave
    this.onErrorCallback = options.onError
    this.onUpdateCallback = options.onUpdate
    
    this.init(options)
  }

  private async init(options: EditorOptions) {
    const container = typeof options.container === 'string'
      ? document.querySelector(options.container)
      : options.container

    if (!container) {
      console.error('Editor container not found')
      return
    }

    // 슬래시 메뉴 UI 생성 (에디터 컨테이너에 추가)
    this.slashMenuEl = createSlashMenu({
      onSelect: (item) => this.executeSlashCommand(item),
      onClose: () => this.hideSlashMenu()
    })
    // 에디터 컨테이너의 부모에 추가하여 position: absolute가 올바르게 작동하도록
    const editorWrapper = (container as HTMLElement).parentElement
    if (editorWrapper) {
      editorWrapper.style.position = 'relative'
      editorWrapper.appendChild(this.slashMenuEl)
    } else {
      document.body.appendChild(this.slashMenuEl)
    }

    // 에디터 생성
    this.editor = new Editor({
      element: container as HTMLElement,
      extensions: this.getExtensions(),
      content: this.getInitialContent(options.initialContent),
      editorProps: {
        attributes: {
          class: 'howto-editor-content prose prose-invert max-w-none focus:outline-none min-h-[400px] p-4',
        },
        handleDrop: (view, event, slice, moved) => {
          // 이미지 드래그앤드롭 처리
          if (!moved && event.dataTransfer?.files?.length) {
            const file = event.dataTransfer.files[0]
            if (file.type.startsWith('image/')) {
              event.preventDefault()
              this.handleImageUpload(file)
              return true
            }
          }
          return false
        },
        handlePaste: (view, event) => {
          // 이미지 붙여넣기 처리
          const items = event.clipboardData?.items
          if (items) {
            for (const item of items) {
              if (item.type.startsWith('image/')) {
                event.preventDefault()
                const file = item.getAsFile()
                if (file) {
                  this.handleImageUpload(file)
                  return true
                }
              }
            }
          }
          return false
        }
      },
      onUpdate: () => {
        this.isDirty = true
        this.scheduleAutoSave()
        this.onUpdateCallback?.()
      },
      onSelectionUpdate: () => {
        this.updateToolbarState()
        this.updateTableToolbar()
        this.updateFontDisplay()
      }
    })

    // 툴바 바인딩
    this.bindToolbar()
    
    // 키보드 단축키
    this.setupKeyboardShortcuts()
    
    // 나가기 보호
    this.setupBeforeUnload()
    
    // 이미지 컨텍스트 메뉴 설정
    this.setupImageContextMenu()

    // 초기 콘텐츠에서 각주 로드
    setTimeout(() => this.loadFootnotesFromContent(), 100)

    console.log('HowTo Editor initialized')
  }

  // =====================================================
  // 썸네일 관리
  // =====================================================
  
  private thumbnailUrl: string = ''
  
  public getThumbnailUrl(): string {
    return this.thumbnailUrl
  }
  
  public setThumbnailUrl(url: string): void {
    // 이전 썸네일 표시 제거
    const editorEl = this.editor?.view.dom
    if (editorEl) {
      editorEl.querySelectorAll('img.is-thumbnail').forEach(img => {
        img.classList.remove('is-thumbnail')
      })
      
      // 새 썸네일 표시
      if (url) {
        const targetImg = editorEl.querySelector(`img[src="${url}"]`)
        if (targetImg) {
          targetImg.classList.add('is-thumbnail')
        }
      }
    }
    
    this.thumbnailUrl = url
    this.isDirty = true
    
    // 이벤트 발생
    window.dispatchEvent(new CustomEvent('thumbnail-changed', { detail: { url } }))
  }
  
  private setupImageContextMenu() {
    const editorEl = this.editor?.view.dom
    if (!editorEl) return
    
    // 컨텍스트 메뉴 엘리먼트 생성
    let contextMenu = document.getElementById('image-context-menu')
    if (!contextMenu) {
      contextMenu = document.createElement('div')
      contextMenu.id = 'image-context-menu'
      contextMenu.className = 'image-context-menu'
      contextMenu.style.display = 'none'
      contextMenu.innerHTML = `
        <button type="button" data-action="set-thumbnail">
          <i class="fas fa-image"></i>
          썸네일로 설정
        </button>
        <button type="button" data-action="remove-thumbnail">
          <i class="fas fa-times"></i>
          썸네일 해제
        </button>
      `
      document.body.appendChild(contextMenu)
      
      // 메뉴 버튼 이벤트
      contextMenu.querySelector('[data-action="set-thumbnail"]')?.addEventListener('click', () => {
        const currentImgSrc = contextMenu?.dataset.currentImgSrc
        if (currentImgSrc) {
          this.setThumbnailUrl(currentImgSrc)
        }
        this.hideImageContextMenu()
      })
      
      contextMenu.querySelector('[data-action="remove-thumbnail"]')?.addEventListener('click', () => {
        this.setThumbnailUrl('')
        this.hideImageContextMenu()
      })
    }
    
    // 이미지 우클릭 이벤트
    editorEl.addEventListener('contextmenu', (e: Event) => {
      const target = e.target as HTMLElement
      if (target.tagName === 'IMG') {
        e.preventDefault()
        const imgSrc = (target as HTMLImageElement).src
        this.showImageContextMenu(e as MouseEvent, imgSrc)
      }
    })
    
    // 바깥 클릭 시 메뉴 닫기
    document.addEventListener('click', (e) => {
      const menu = document.getElementById('image-context-menu')
      if (menu && !menu.contains(e.target as Node)) {
        this.hideImageContextMenu()
      }
    })
  }
  
  private showImageContextMenu(e: MouseEvent, imgSrc: string) {
    const menu = document.getElementById('image-context-menu')
    if (!menu) return
    
    menu.dataset.currentImgSrc = imgSrc
    menu.style.display = 'block'
    menu.style.left = `${e.pageX}px`
    menu.style.top = `${e.pageY}px`
    
    // 썸네일 여부에 따라 버튼 상태 업데이트
    const setBtn = menu.querySelector('[data-action="set-thumbnail"]')
    const removeBtn = menu.querySelector('[data-action="remove-thumbnail"]')
    
    if (this.thumbnailUrl === imgSrc) {
      setBtn?.classList.add('is-active')
      removeBtn?.classList.remove('hidden')
    } else {
      setBtn?.classList.remove('is-active')
    }
  }
  
  private hideImageContextMenu() {
    const menu = document.getElementById('image-context-menu')
    if (menu) {
      menu.style.display = 'none'
    }
  }

  private getExtensions() {
    return [
      StarterKit.configure({
        heading: { levels: [1, 2, 3] },
        blockquote: false, // CustomBlockquote 사용
        bulletList: false, // CustomBulletList 사용 (자동 변환 비활성화)
        history: {
          depth: 100,
          newGroupDelay: 500,
        },
      }),
      CustomBlockquote,
      CustomBulletList,
      Placeholder.configure({
        placeholder: ({ node, editor }) => {
          // 에디터가 비어있을 때만 메인 placeholder 표시
          if (node.type.name === 'paragraph') {
            // 문서가 비어있고 첫 번째 노드일 때
            const { isEmpty } = editor.state.doc
            if (isEmpty) {
              return '내용을 입력하세요... "/" 를 입력하면 블록 삽입 메뉴가 나타납니다.'
            }
          }
          return ''
        },
        emptyEditorClass: 'is-editor-empty',
        emptyNodeClass: 'is-empty',
        showOnlyWhenEditable: true,
        showOnlyCurrent: false,
        includeChildren: true,
      }),
      Link.configure({
        openOnClick: false,
        HTMLAttributes: {
          class: 'text-wiki-primary hover:underline',
        },
      }),
      ResizableImage.configure({
        HTMLAttributes: {
          class: 'rounded-lg max-w-full',
          loading: 'lazy',
        },
      }),
      Underline,
      Highlight.configure({ multicolor: true }),
      Color,
      TextStyle,
      FontSize,
      TextAlign.configure({
        types: ['heading', 'paragraph'],
      }),
      FontFamily.configure({
        types: ['textStyle'],
      }),
      Table.configure({ resizable: true }),
      TableRow,
      TableHeader,
      CustomTableCell,
      TaskList,
      TaskItem.configure({ nested: true }),
      SlashCommandExtension.configure({
        onShow: (pos: { x: number; y: number }) => this.showSlashMenu(pos),
        onHide: () => this.hideSlashMenu(),
        onFilter: (query: string) => this.filterSlashMenu(query)
      }),
      ...getCustomNodes()
    ]
  }

  private getInitialContent(content?: JSONContent | string): JSONContent | string {
    // localStorage에서 복구 시도
    if (this.draftId) {
      const localDraft = localStorage.getItem(`howto-draft-${this.draftId}`)
      if (localDraft) {
        try {
          const parsed = JSON.parse(localDraft)
          if (parsed.content) {
            console.log('Recovered from localStorage')
            return parsed.content
          }
        } catch (e) {
          console.warn('Local draft parse error:', e)
        }
      }
    }

    if (content) return content
    return '<p></p>'
  }

  // =====================================================
  // 슬래시 메뉴
  // =====================================================

  private showSlashMenu(pos: { x: number; y: number }) {
    if (!this.slashMenuEl) return
    
    // 슬래시 메뉴의 부모 요소(에디터 래퍼) 기준으로 상대 위치 계산
    const parent = this.slashMenuEl.parentElement
    if (parent) {
      const parentRect = parent.getBoundingClientRect()
      this.slashMenuEl.style.left = `${pos.x - parentRect.left}px`
      this.slashMenuEl.style.top = `${pos.y - parentRect.top + 24}px`
    } else {
      // fallback: 절대 위치 사용
      this.slashMenuEl.style.left = `${pos.x}px`
      this.slashMenuEl.style.top = `${pos.y + 24}px`
    }
    this.slashMenuEl.classList.remove('hidden')
  }

  private hideSlashMenu() {
    if (!this.slashMenuEl) return
    this.slashMenuEl.classList.add('hidden')
  }

  private filterSlashMenu(query: string) {
    if (!this.slashMenuEl) return
    const items = this.slashMenuEl.querySelectorAll('.slash-menu-item')
    const normalizedQuery = query.toLowerCase()
    
    items.forEach((item) => {
      const keywords = (item as HTMLElement).dataset.keywords || ''
      const isMatch = keywords.toLowerCase().includes(normalizedQuery)
      ;(item as HTMLElement).style.display = isMatch ? '' : 'none'
    })
  }

  private executeSlashCommand(item: SlashMenuItem) {
    if (!this.editor) return

    // 슬래시 문자 삭제
    const { from } = this.editor.state.selection
    const textBefore = this.editor.state.doc.textBetween(Math.max(0, from - 20), from)
    const slashIndex = textBefore.lastIndexOf('/')
    if (slashIndex !== -1) {
      this.editor.chain()
        .focus()
        .deleteRange({ from: from - (textBefore.length - slashIndex), to: from })
        .run()
    }

    // 명령 실행
    switch (item.command) {
      case 'h1':
        this.editor.chain().focus().toggleHeading({ level: 1 }).run()
        break
      case 'h2':
        this.editor.chain().focus().toggleHeading({ level: 2 }).run()
        break
      case 'h3':
        this.editor.chain().focus().toggleHeading({ level: 3 }).run()
        break
      case 'bulletList':
        this.editor.chain().focus().toggleBulletList().run()
        break
      case 'orderedList':
        this.editor.chain().focus().toggleOrderedList().run()
        break
      case 'taskList':
        this.editor.chain().focus().toggleTaskList().run()
        break
      case 'blockquote':
        this.editor.chain().focus().toggleBlockquote().run()
        break
      case 'codeBlock':
        this.editor.chain().focus().toggleCodeBlock().run()
        break
      case 'horizontalRule':
        this.editor.chain().focus().setHorizontalRule().run()
        break
      case 'image':
        this.promptImage()
        break
      case 'table':
        this.editor.chain().focus().insertTable({ rows: 3, cols: 3, withHeaderRow: true }).run()
        break
      case 'checkpointBox':
        this.insertCheckpointBox()
        break
      case 'conclusionBox':
        this.insertConclusionBox()
        break
      case 'qnaBlock':
        this.insertQnABlock()
        break
      case 'careerList':
        this.insertCareerList()
        break
      case 'footnote':
        this.promptFootnote()
        break
    }

    this.hideSlashMenu()
  }

  // =====================================================
  // 커스텀 블록 삽입
  // =====================================================

  private insertCheckpointBox() {
    this.editor?.chain().focus().insertContent({
      type: 'checkpointBox',
      content: [{ type: 'paragraph' }]
    }).run()
  }

  private insertConclusionBox() {
    this.editor?.chain().focus().insertContent({
      type: 'conclusionBox',
      content: [{ type: 'paragraph' }]
    }).run()
  }

  private insertQnABlock() {
    this.editor?.chain().focus().insertContent({
      type: 'qnaBlock',
      content: [
        { type: 'qnaQuestion', content: [{ type: 'paragraph' }] },
        { type: 'qnaAnswer', content: [{ type: 'paragraph' }] }
      ]
    }).run()
  }

  private insertCareerList() {
    this.editor?.chain().focus().insertContent({
      type: 'careerList',
      content: [
        { type: 'careerListItem', content: [] },
        { type: 'careerListItem', content: [] },
        { type: 'careerListItem', content: [] }
      ]
    }).run()
  }

  // =====================================================
  // 각주 (Footnote)
  // =====================================================

  private footnoteCounter = 0
  private footnotes: Map<number, { text: string; url?: string }> = new Map()

  private promptFootnote() {
    // 다음 각주 번호 계산
    this.footnoteCounter = this.getNextFootnoteId()
    
    // 모달 표시
    this.showFootnoteModal()
  }

  private getNextFootnoteId(): number {
    if (!this.editor) return 1
    
    let maxId = 0
    this.editor.state.doc.descendants((node) => {
      if (node.type.name === 'footnote' && node.attrs.id > maxId) {
        maxId = node.attrs.id
      }
    })
    return maxId + 1
  }

  public showFootnoteModal(editId?: number, editText?: string, editUrl?: string) {
    const existing = document.getElementById('footnote-modal')
    if (existing) existing.remove()

    const isEdit = editId !== undefined
    const id = isEdit ? editId : this.footnoteCounter

    const modal = document.createElement('div')
    modal.id = 'footnote-modal'
    modal.className = 'footnote-modal'
    modal.innerHTML = `
      <div class="footnote-modal-overlay" onclick="this.parentElement.remove()"></div>
      <div class="footnote-modal-content">
        <div class="footnote-modal-header">
          <h3>${isEdit ? '각주 편집' : '각주 추가'} [${id}]</h3>
          <button type="button" class="footnote-modal-close" onclick="this.closest('#footnote-modal').remove()">
            <i class="fas fa-times"></i>
          </button>
        </div>
        <div class="footnote-modal-body">
          <div class="footnote-field">
            <label>출처 설명 *</label>
            <input type="text" id="footnote-text" placeholder="출처에 대한 설명을 입력하세요" value="${editText || ''}" />
          </div>
          <div class="footnote-field">
            <label>URL (선택)</label>
            <input type="url" id="footnote-url" placeholder="https://example.com/..." value="${editUrl || ''}" />
          </div>
        </div>
        <div class="footnote-modal-footer">
          ${isEdit ? '<button type="button" class="btn-delete" data-action="delete">삭제</button>' : ''}
          <button type="button" class="btn-cancel" onclick="this.closest('#footnote-modal').remove()">취소</button>
          <button type="button" class="btn-save" data-action="save">${isEdit ? '저장' : '삽입'}</button>
        </div>
      </div>
    `

    document.body.appendChild(modal)

    // 포커스
    const textInput = modal.querySelector('#footnote-text') as HTMLInputElement
    setTimeout(() => textInput?.focus(), 100)

    // URL 정규화 (프로토콜 자동 추가)
    const normalizeUrl = (url: string): string => {
      if (!url) return url
      if (url.startsWith('http://') || url.startsWith('https://') || 
          url.startsWith('/') || url.startsWith('#') || url.startsWith('mailto:')) {
        return url
      }
      return 'https://' + url
    }

    // 저장 버튼
    modal.querySelector('[data-action="save"]')?.addEventListener('click', () => {
      try {
        const textInput = modal.querySelector('#footnote-text') as HTMLInputElement
        const urlInput = modal.querySelector('#footnote-url') as HTMLInputElement
        
        if (!textInput) {
          console.error('각주 텍스트 입력 필드를 찾을 수 없습니다.')
          return
        }
        
        const text = textInput.value.trim()
        const rawUrl = urlInput?.value.trim() || ''
        const url = normalizeUrl(rawUrl)

        if (!text) {
          alert('출처 설명을 입력해주세요.')
          return
        }

        if (isEdit) {
          this.updateFootnote(id, text, url)
        } else {
          this.insertFootnote(id, text, url)
        }

        modal.remove()
      } catch (error) {
        console.error('각주 저장 중 오류 발생:', error)
        alert('각주 저장 중 오류가 발생했습니다. 다시 시도해주세요.')
      }
    })

    // 삭제 버튼 (편집 모드에서만)
    modal.querySelector('[data-action="delete"]')?.addEventListener('click', () => {
      if (confirm('이 각주를 삭제하시겠습니까?')) {
        this.deleteFootnote(id)
        modal.remove()
      }
    })

    // Enter 키로 저장
    modal.querySelectorAll('input').forEach(input => {
      input.addEventListener('keydown', (e) => {
        if (e.key === 'Enter') {
          modal.querySelector('[data-action="save"]')?.dispatchEvent(new Event('click'))
        }
      })
    })
  }

  private insertFootnote(id: number, text: string, url?: string) {
    try {
      if (!this.editor) {
        console.warn('에디터가 초기화되지 않았습니다.')
        return
      }
      
      // 에디터 포커스 확인 및 설정
      if (!this.editor.isFocused) {
        this.editor.commands.focus()
      }
      
      this.footnotes.set(id, { text, url })
      const result = this.editor.commands.insertFootnote({ id, text, url: url || '' })
      
      if (!result) {
        console.warn('각주 삽입 실패: 커서 위치를 확인해주세요.')
        return
      }
      
      // 삽입 후 즉시 목록 업데이트
      this.updateFootnotesList()
      
      // 재정렬도 수행
      setTimeout(() => this.reorderFootnotes(), 10)
    } catch (error) {
      console.error('각주 삽입 중 오류 발생:', error)
    }
  }

  private updateFootnote(id: number, text: string, url?: string) {
    try {
      if (!this.editor) return
      
      this.footnotes.set(id, { text, url })
      this.editor.commands.updateFootnote(id, { text, url: url || '' })
      this.updateFootnotesList()
    } catch (error) {
      console.error('각주 업데이트 중 오류 발생:', error)
    }
  }

  public deleteFootnote(id: number) {
    try {
      if (!this.editor) return
      
      // 문서에서 해당 각주 노드 삭제
      const { tr, doc } = this.editor.state
      let deletedPos: number | null = null
      
      doc.descendants((node, pos) => {
        if (node.type.name === 'footnote' && node.attrs.id === id) {
          deletedPos = pos
          return false
        }
        return true
      })

      if (deletedPos !== null) {
        const nodeSize = this.editor.state.doc.nodeAt(deletedPos)?.nodeSize || 1
        this.editor.view.dispatch(
          tr.delete(deletedPos, deletedPos + nodeSize)
        )
      }

      this.footnotes.delete(id)
      // 삭제 후 재정렬
      setTimeout(() => this.reorderFootnotes(), 10)
    } catch (error) {
      console.error('각주 삭제 중 오류 발생:', error)
    }
  }

  // 각주를 문서 순서대로 재정렬
  private reorderFootnotes() {
    try {
      if (!this.editor) return
      
      // 문서에서 각주 위치와 정보 수집
      const footnotesInOrder: Array<{ pos: number; id: number; text: string; url: string }> = []
      
      this.editor.state.doc.descendants((node, pos) => {
        if (node.type.name === 'footnote') {
          footnotesInOrder.push({
            pos,
            id: node.attrs.id,
            text: node.attrs.text,
            url: node.attrs.url || ''
          })
        }
      })
      
      // 위치 순서대로 정렬
      footnotesInOrder.sort((a, b) => a.pos - b.pos)
      
      // 새 ID 할당이 필요한지 확인
      let needsReorder = false
      for (let i = 0; i < footnotesInOrder.length; i++) {
        if (footnotesInOrder[i].id !== i + 1) {
          needsReorder = true
          break
        }
      }
      
      if (needsReorder && footnotesInOrder.length > 0) {
        // 새 footnotes Map 생성
        const newFootnotes = new Map<number, { text: string; url?: string }>()
        
        // 트랜잭션으로 모든 각주 ID 업데이트
        // 역순으로 처리해야 위치 변경이 없음
        const { tr } = this.editor.state
        
        // 먼저 매핑 정보 저장
        const updates: Array<{ pos: number; newId: number; text: string; url: string }> = []
        footnotesInOrder.forEach((fn, index) => {
          const newId = index + 1
          newFootnotes.set(newId, { text: fn.text, url: fn.url || undefined })
          updates.push({ pos: fn.pos, newId, text: fn.text, url: fn.url })
        })
        
        // 각 노드 속성 업데이트
        updates.forEach(({ pos, newId, text, url }) => {
          const node = this.editor?.state.doc.nodeAt(pos)
          if (node && node.type.name === 'footnote') {
            tr.setNodeMarkup(pos, undefined, {
              id: newId,
              text: text,
              url: url
            })
          }
        })
        
        if (tr.docChanged) {
          this.editor.view.dispatch(tr)
        }
        this.footnotes = newFootnotes
      }
      
      this.updateFootnotesList()
    } catch (error) {
      console.error('각주 재정렬 중 오류 발생:', error)
    }
  }

  private updateFootnotesList() {
    // 문서 순서대로 각주 목록 생성
    const footnotesInOrder: Array<{ id: number; text: string; url?: string }> = []
    
    this.editor?.state.doc.descendants((node) => {
      if (node.type.name === 'footnote') {
        footnotesInOrder.push({
          id: node.attrs.id,
          text: node.attrs.text,
          url: node.attrs.url || undefined
        })
      }
    })
    
    // 각주 목록 UI 업데이트 (본문 하단)
    const event = new CustomEvent('footnotes-updated', {
      detail: { footnotes: footnotesInOrder }
    })
    window.dispatchEvent(event)
  }

  public getFootnotes(): Array<{ id: number; text: string; url?: string }> {
    // 문서에서 각주 정보 수집
    const footnotes: Array<{ id: number; text: string; url?: string }> = []
    
    this.editor?.state.doc.descendants((node) => {
      if (node.type.name === 'footnote') {
        footnotes.push({
          id: node.attrs.id,
          text: node.attrs.text,
          url: node.attrs.url || undefined
        })
      }
    })

    // ID로 정렬
    return footnotes.sort((a, b) => a.id - b.id)
  }

  // =====================================================
  // 툴바
  // =====================================================

  private bindToolbar() {
    const toolbar = document.getElementById('toolbar')
    if (!toolbar) return

    // 중복 바인딩 방지
    if (toolbar.dataset.bound) return
    toolbar.dataset.bound = 'true'

    // 메인 툴바의 [data-action] 버튼만 선택 (table-toolbar 제외)
    toolbar.querySelectorAll('[data-action]').forEach(btn => {
      btn.addEventListener('click', (e) => {
        e.preventDefault()
        e.stopPropagation()
        const action = (btn as HTMLElement).dataset.action
        if (action) this.executeToolbarAction(action)
      })
    })

    // 색상 선택
    toolbar.querySelectorAll('[data-color]').forEach(btn => {
      btn.addEventListener('click', (e) => {
        e.preventDefault()
        const color = (btn as HTMLElement).dataset.color
        if (color) this.editor?.chain().focus().setColor(color).run()
      })
    })

    // 하이라이트 색상
    toolbar.querySelectorAll('[data-highlight]').forEach(btn => {
      btn.addEventListener('click', (e) => {
        e.preventDefault()
        const color = (btn as HTMLElement).dataset.highlight
        if (color) this.editor?.chain().focus().toggleHighlight({ color }).run()
      })
    })

    // 폰트 선택
    toolbar.querySelectorAll('[data-font]').forEach(btn => {
      btn.addEventListener('click', (e) => {
        e.preventDefault()
        const font = (btn as HTMLElement).dataset.font
        if (font) {
          this.setFontFamily(font)
        }
      })
    })

    // 폰트 크기 선택
    toolbar.querySelectorAll('[data-size]').forEach(btn => {
      btn.addEventListener('click', (e) => {
        e.preventDefault()
        const size = (btn as HTMLElement).dataset.size
        if (size) {
          this.setFontSize(size)
        }
      })
    })
    
    // 커스텀 폰트 크기 입력칸
    toolbar.querySelectorAll('.size-input').forEach(input => {
      const inputEl = input as HTMLInputElement
      
      // 클릭 시 드롭다운 버튼 이벤트 방지
      inputEl.addEventListener('click', (e) => {
        e.stopPropagation()
      })
      
      // Enter 키 입력 시 적용
      inputEl.addEventListener('keydown', (e) => {
        if (e.key === 'Enter') {
          e.preventDefault()
          const size = parseInt(inputEl.value)
          if (!isNaN(size) && size >= 6 && size <= 72) {
            this.setFontSize(size + 'px')
          }
        }
      })
      
      // 포커스 잃을 때 적용
      inputEl.addEventListener('blur', () => {
        const size = parseInt(inputEl.value)
        if (!isNaN(size) && size >= 6 && size <= 72) {
          this.setFontSize(size + 'px')
        }
      })
    })

    // 표 툴바 바인딩
    const tableToolbar = document.getElementById('table-toolbar')
    if (tableToolbar) {
      // 이미 바인딩되었는지 확인하여 중복 등록 방지
      if (!tableToolbar.dataset.bound) {
        tableToolbar.dataset.bound = 'true'
        
        // 각 버튼에 개별적으로 바인딩 플래그 설정
        tableToolbar.querySelectorAll('[data-action]').forEach(btn => {
          const btnEl = btn as HTMLElement
          if (btnEl.dataset.eventBound) return // 이미 바인딩된 버튼 스킵
          btnEl.dataset.eventBound = 'true'
          
          btnEl.addEventListener('click', (e) => {
            e.preventDefault()
            e.stopPropagation() // 이벤트 버블링 방지
            e.stopImmediatePropagation() // 다른 리스너 실행 방지
            
            const action = btnEl.dataset.action
            if (action) {
              // 드롭다운 메뉴 닫기
              const dropdown = btnEl.closest('.toolbar-dropdown')
              if (dropdown) {
                dropdown.classList.remove('is-open')
                const menu = dropdown.querySelector('.row-menu, .col-menu')
                if (menu) menu.classList.add('hidden')
              }
              this.executeToolbarAction(action)
            }
          }, { capture: true }) // 캡처 단계에서 처리
        })
      }

      // 셀 배경색 선택 (중복 방지)
      tableToolbar.querySelectorAll('[data-cell-bg]').forEach(btn => {
        const btnEl = btn as HTMLElement
        if (btnEl.dataset.cellBgBound) return
        btnEl.dataset.cellBgBound = 'true'
        
        btnEl.addEventListener('click', (e) => {
          e.preventDefault()
          e.stopPropagation()
          const color = btnEl.dataset.cellBg || ''
          this.setCellBackground(color)
        })
      })

      // 테두리 스타일 선택 (중복 방지)
      tableToolbar.querySelectorAll('[data-border-style]').forEach(btn => {
        const btnEl = btn as HTMLElement
        if (btnEl.dataset.borderBound) return
        btnEl.dataset.borderBound = 'true'
        
        btnEl.addEventListener('click', (e) => {
          e.preventDefault()
          e.stopPropagation()
          const style = btnEl.dataset.borderStyle || 'solid'
          this.setCellBorderStyle(style)
        })
      })
    }
  }

  public executeToolbarAction(action: string) {
    if (!this.editor) return

    const chain = this.editor.chain().focus()

    switch (action) {
      case 'bold': chain.toggleBold().run(); break
      case 'italic': chain.toggleItalic().run(); break
      case 'underline': chain.toggleUnderline().run(); break
      case 'strike': chain.toggleStrike().run(); break
      case 'code': chain.toggleCode().run(); break
      case 'h1': chain.toggleHeading({ level: 1 }).run(); break
      case 'h2': chain.toggleHeading({ level: 2 }).run(); break
      case 'h3': chain.toggleHeading({ level: 3 }).run(); break
      case 'blockquote': chain.toggleBlockquote().run(); break
      case 'bulletList': chain.toggleBulletList().run(); break
      case 'orderedList': chain.toggleOrderedList().run(); break
      case 'taskList': chain.toggleTaskList().run(); break
      case 'codeBlock': chain.toggleCodeBlock().run(); break
      case 'horizontalRule': chain.setHorizontalRule().run(); break
      case 'link': this.promptLink(); break
      case 'internalLink': this.showInternalLinkPopup(); break
      case 'unlink': chain.unsetLink().run(); break
      case 'image': this.promptImage(); break
      case 'table': chain.insertTable({ rows: 3, cols: 3, withHeaderRow: true }).run(); break
      case 'checkpointBox': this.insertCheckpointBox(); break
      case 'conclusionBox': this.insertConclusionBox(); break
      case 'qnaBlock': this.insertQnABlock(); break
      case 'careerList': this.insertCareerList(); break
      case 'footnote': this.promptFootnote(); break
      case 'undo': chain.undo().run(); break
      case 'redo': chain.redo().run(); break
      // 정렬
      case 'alignLeft': this.setTextAlign('left'); break
      case 'alignCenter': this.setTextAlign('center'); break
      case 'alignRight': this.setTextAlign('right'); break
      case 'alignJustify': this.setTextAlign('justify'); break
      // 표 편집
      case 'addRowBefore': chain.addRowBefore().run(); break
      case 'addRowAfter': chain.addRowAfter().run(); break
      case 'addColBefore': chain.addColumnBefore().run(); break
      case 'addColAfter': chain.addColumnAfter().run(); break
      case 'deleteRow': chain.deleteRow().run(); break
      case 'deleteCol': chain.deleteColumn().run(); break
      case 'deleteTable': chain.deleteTable().run(); break
      case 'mergeCells': chain.mergeCells().run(); break
      case 'splitCell': chain.splitCell().run(); break
      case 'toggleHeaderRow': chain.toggleHeaderRow().run(); break
      case 'toggleHeaderCol': chain.toggleHeaderColumn().run(); break
    }

    this.updateToolbarState()
  }

  // =====================================================
  // 정렬
  // =====================================================

  private setTextAlign(align: 'left' | 'center' | 'right' | 'justify') {
    this.editor?.chain().focus().setTextAlign(align).run()
  }

  // =====================================================
  // 폰트
  // =====================================================

  public setFontFamily(font: string) {
    this.editor?.chain().focus().setFontFamily(font).run()
    // 툴바 표시 즉시 업데이트
    setTimeout(() => this.updateFontDisplay(), 0)
  }

  public unsetFontFamily() {
    this.editor?.chain().focus().unsetFontFamily().run()
    setTimeout(() => this.updateFontDisplay(), 0)
  }

  public setFontSize(size: string) {
    this.editor?.chain().focus().setFontSize(size).run()
    // 툴바 표시 즉시 업데이트
    setTimeout(() => this.updateFontDisplay(), 0)
  }

  public unsetFontSize() {
    this.editor?.chain().focus().unsetFontSize().run()
    setTimeout(() => this.updateFontDisplay(), 0)
  }

  // =====================================================
  // 표 셀 배경색
  // =====================================================

  public setCellBackground(color: string) {
    this.editor?.chain().focus().setCellAttribute('backgroundColor', color).run()
  }

  public setCellBorderStyle(style: string) {
    // 테두리 스타일을 선택된 셀에 적용
    const borderValue = style === 'none' 
      ? 'none' 
      : style === 'dashed' 
        ? '1px dashed rgba(255,255,255,0.2)' 
        : '1px solid rgba(255,255,255,0.1)'
    this.editor?.chain().focus().setCellAttribute('borderStyle', borderValue).run()
  }

  // =====================================================
  // 표 활성 상태 확인
  // =====================================================

  public isInTable(): boolean {
    return this.editor?.isActive('table') ?? false
  }

  // 표 툴바 표시/숨김
  private updateTableToolbar() {
    const tableToolbar = document.getElementById('table-toolbar')
    if (!tableToolbar) return
    
    if (this.isInTable()) {
      tableToolbar.classList.add('visible')
    } else {
      tableToolbar.classList.remove('visible')
    }
  }

  // 현재 폰트 표시
  private updateFontDisplay() {
    if (!this.editor) return
    
    // 현재 폰트 크기를 입력칸에 표시
    const fontSize = this.editor.getAttributes('textStyle').fontSize
    const sizeNum = fontSize ? parseInt(fontSize) : 15
    
    document.querySelectorAll('.size-input').forEach((input: any) => {
      input.value = sizeNum
    })
    
    // 드롭다운 메뉴에서 활성 항목 표시
    document.querySelectorAll('.size-menu [data-size]').forEach((btn: any) => {
      const btnSize = btn.dataset.size
      if (btnSize === (fontSize || '15px')) {
        btn.classList.add('is-active')
      } else {
        btn.classList.remove('is-active')
      }
    })
    
    // 현재 폰트 패밀리 표시
    const fontFamily = this.editor.getAttributes('textStyle').fontFamily || 'inherit'
    const fontNames: Record<string, string> = {
      'inherit': '기본',
      'sans-serif': '샌즈',
      'serif': '세리프',
      'monospace': '코드',
      "'Nanum Gothic', sans-serif": '고딕',
      "'Nanum Myeongjo', serif": '명조'
    }
    
    document.querySelectorAll('.current-font-name').forEach((el: any) => {
      el.textContent = fontNames[fontFamily] || '기본'
    })
    
    document.querySelectorAll('.font-menu [data-font]').forEach((btn: any) => {
      const btnFont = btn.dataset.font
      if (btnFont === fontFamily) {
        btn.classList.add('is-active')
      } else {
        btn.classList.remove('is-active')
      }
    })
  }

  // 현재 폰트 크기 가져오기
  public getCurrentFontSize(): string {
    const fontSize = this.editor?.getAttributes('textStyle').fontSize
    return fontSize || '15px'
  }

  // =====================================================
  // 내부링크 팝업
  // =====================================================
  
  private internalLinkPopup: HTMLElement | null = null
  private internalLinkTab: string = 'jobs'
  
  public showInternalLinkPopup() {
    if (!this.editor) return
    
    const { from } = this.editor.state.selection
    const coords = this.editor.view.coordsAtPos(from)
    
    this.createInternalLinkPopup(coords.left, coords.top)
  }
  
  private createInternalLinkPopup(x: number, y: number) {
    if (this.internalLinkPopup) {
      this.internalLinkPopup.remove()
    }
    
    this.internalLinkPopup = document.createElement('div')
    this.internalLinkPopup.className = 'internal-link-popup'
    this.internalLinkPopup.innerHTML = `
      <div class="tabs">
        <button type="button" class="tab-btn active" data-tab="jobs">직업</button>
        <button type="button" class="tab-btn" data-tab="majors">전공</button>
        <button type="button" class="tab-btn" data-tab="howtos">HowTo</button>
      </div>
      <input type="text" placeholder="검색..." />
      <div class="results"></div>
    `
    
    const editorWrapper = this.editor?.view.dom.parentElement?.parentElement
    if (editorWrapper) {
      editorWrapper.style.position = 'relative'
      const rect = editorWrapper.getBoundingClientRect()
      this.internalLinkPopup.style.left = `${Math.min(x - rect.left, rect.width - 320)}px`
      this.internalLinkPopup.style.top = `${y - rect.top + 24}px`
      editorWrapper.appendChild(this.internalLinkPopup)
    }
    
    // 탭 클릭
    this.internalLinkPopup.querySelectorAll('.tab-btn').forEach(btn => {
      btn.addEventListener('click', () => {
        this.internalLinkPopup?.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'))
        btn.classList.add('active')
        this.internalLinkTab = (btn as HTMLElement).dataset.tab || 'jobs'
        const input = this.internalLinkPopup?.querySelector('input') as HTMLInputElement
        if (input?.value) this.searchInternalLink(input.value)
      })
    })
    
    // 검색
    const input = this.internalLinkPopup.querySelector('input')
    let debounce: ReturnType<typeof setTimeout>
    input?.addEventListener('input', () => {
      clearTimeout(debounce)
      debounce = setTimeout(() => {
        this.searchInternalLink((input as HTMLInputElement).value)
      }, 300)
    })
    
    input?.focus()
    
    // 외부 클릭 시 닫기
    const closeHandler = (e: MouseEvent) => {
      if (!this.internalLinkPopup?.contains(e.target as Node)) {
        this.internalLinkPopup?.remove()
        this.internalLinkPopup = null
        document.removeEventListener('click', closeHandler)
      }
    }
    setTimeout(() => document.addEventListener('click', closeHandler), 100)
  }
  
  private async searchInternalLink(query: string) {
    if (!query || query.length < 2) {
      const results = this.internalLinkPopup?.querySelector('.results')
      if (results) results.innerHTML = '<div class="no-results">2글자 이상 입력하세요</div>'
      return
    }
    
    try {
      const res = await fetch(`/api/search?domain=${this.internalLinkTab}&q=${encodeURIComponent(query)}&limit=10`)
      const data = await res.json()
      
      const results = this.internalLinkPopup?.querySelector('.results')
      if (!results) return
      
      if (!data.success || !data.results?.length) {
        results.innerHTML = '<div class="no-results">검색 결과가 없습니다</div>'
        return
      }
      
      const typeLabel: Record<string, string> = { jobs: '직업', majors: '전공', howtos: 'HowTo' }
      const pathPrefix: Record<string, string> = { jobs: '/job/', majors: '/major/', howtos: '/howto/' }
      
      results.innerHTML = data.results.map((r: any) => `
        <div class="result-item" data-slug="${r.slug || r.name}" data-name="${r.name || r.title}">
          <span class="title">${this.escapeHtml(r.name || r.title)}</span>
          <span class="type">${typeLabel[this.internalLinkTab]}</span>
        </div>
      `).join('')
      
      results.querySelectorAll('.result-item').forEach(item => {
        item.addEventListener('click', () => {
          const slug = (item as HTMLElement).dataset.slug
          const name = (item as HTMLElement).dataset.name
          const url = pathPrefix[this.internalLinkTab] + slug
          
          this.editor?.chain().focus()
            .extendMarkRange('link')
            .setLink({ href: url })
            .insertContent(name || slug || '')
            .run()
          
          this.internalLinkPopup?.remove()
          this.internalLinkPopup = null
        })
      })
    } catch (e) {
      console.error('Internal link search error:', e)
    }
  }

  private escapeHtml(str: string): string {
    if (!str) return ''
    return String(str)
      .replace(/&/g, '&amp;')
      .replace(/</g, '&lt;')
      .replace(/>/g, '&gt;')
      .replace(/"/g, '&quot;')
  }

  private updateToolbarState() {
    const toolbar = document.getElementById('toolbar')
    if (!toolbar || !this.editor) return

    toolbar.querySelectorAll('[data-action]').forEach(btn => {
      const action = (btn as HTMLElement).dataset.action
      let isActive = false

      switch (action) {
        case 'bold': isActive = this.editor!.isActive('bold'); break
        case 'italic': isActive = this.editor!.isActive('italic'); break
        case 'underline': isActive = this.editor!.isActive('underline'); break
        case 'strike': isActive = this.editor!.isActive('strike'); break
        case 'code': isActive = this.editor!.isActive('code'); break
        case 'h1': isActive = this.editor!.isActive('heading', { level: 1 }); break
        case 'h2': isActive = this.editor!.isActive('heading', { level: 2 }); break
        case 'h3': isActive = this.editor!.isActive('heading', { level: 3 }); break
        case 'blockquote': isActive = this.editor!.isActive('blockquote'); break
        case 'bulletList': isActive = this.editor!.isActive('bulletList'); break
        case 'orderedList': isActive = this.editor!.isActive('orderedList'); break
        case 'taskList': isActive = this.editor!.isActive('taskList'); break
        case 'link': isActive = this.editor!.isActive('link'); break
      }

      btn.classList.toggle('is-active', isActive)
    })
  }

  // =====================================================
  // 링크 & 이미지
  // =====================================================

  private linkPopup: HTMLElement | null = null

  private promptLink() {
    if (!this.editor) return

    const previousUrl = this.editor.getAttributes('link').href || ''
    
    // 커서 위치 가져오기
    const { from } = this.editor.state.selection
    const coords = this.editor.view.coordsAtPos(from)
    
    this.showLinkPopup(coords.left, coords.top, previousUrl)
  }

  private showLinkPopup(x: number, y: number, existingUrl: string = '') {
    // 기존 팝업 제거
    if (this.linkPopup) {
      this.linkPopup.remove()
    }

    // 팝업 생성
    this.linkPopup = document.createElement('div')
    this.linkPopup.className = 'link-popup'
    this.linkPopup.innerHTML = `
      <input type="url" placeholder="https://..." value="${existingUrl}" />
      <button type="button" class="btn-apply"><i class="fas fa-check"></i></button>
      ${existingUrl ? '<button type="button" class="btn-remove"><i class="fas fa-unlink"></i></button>' : ''}
    `

    // 에디터 래퍼에 추가
    const editorWrapper = this.editor?.view.dom.parentElement?.parentElement
    if (editorWrapper) {
      editorWrapper.style.position = 'relative'
      const rect = editorWrapper.getBoundingClientRect()
      this.linkPopup.style.left = `${x - rect.left}px`
      this.linkPopup.style.top = `${y - rect.top + 24}px`
      editorWrapper.appendChild(this.linkPopup)
    } else {
      this.linkPopup.style.left = `${x}px`
      this.linkPopup.style.top = `${y + 24}px`
      document.body.appendChild(this.linkPopup)
    }

    const input = this.linkPopup.querySelector('input') as HTMLInputElement
    input.focus()
    input.select()

    // URL 정규화 (프로토콜 자동 추가)
    const normalizeUrl = (url: string): string => {
      if (!url) return url
      // 이미 프로토콜이 있거나 내부 링크(/, #, mailto:)면 그대로 반환
      if (url.startsWith('http://') || url.startsWith('https://') || 
          url.startsWith('/') || url.startsWith('#') || url.startsWith('mailto:')) {
        return url
      }
      // www로 시작하거나 도메인처럼 보이면 https:// 추가
      return 'https://' + url
    }

    // 적용 버튼
    this.linkPopup.querySelector('.btn-apply')?.addEventListener('click', () => {
      const url = normalizeUrl(input.value.trim())
      if (url) {
        this.editor?.chain().focus().setLink({ href: url }).run()
      }
      this.hideLinkPopup()
    })

    // 제거 버튼
    this.linkPopup.querySelector('.btn-remove')?.addEventListener('click', () => {
      this.editor?.chain().focus().unsetLink().run()
      this.hideLinkPopup()
    })

    // Enter 키
    input.addEventListener('keydown', (e) => {
      if (e.key === 'Enter') {
        const url = normalizeUrl(input.value.trim())
        if (url) {
          this.editor?.chain().focus().setLink({ href: url }).run()
        }
        this.hideLinkPopup()
      } else if (e.key === 'Escape') {
        this.hideLinkPopup()
      }
    })

    // 외부 클릭 시 닫기
    setTimeout(() => {
      document.addEventListener('click', this.handleLinkPopupOutsideClick)
    }, 100)
  }

  private handleLinkPopupOutsideClick = (e: MouseEvent) => {
    if (this.linkPopup && !this.linkPopup.contains(e.target as Node)) {
      this.hideLinkPopup()
    }
  }

  private hideLinkPopup() {
    if (this.linkPopup) {
      this.linkPopup.remove()
      this.linkPopup = null
    }
    document.removeEventListener('click', this.handleLinkPopupOutsideClick)
  }

  private promptImage() {
    const input = document.createElement('input')
    input.type = 'file'
    input.accept = 'image/jpeg,image/png,image/gif,image/webp'

    input.onchange = async (e) => {
      const file = (e.target as HTMLInputElement).files?.[0]
      if (file) {
        await this.handleImageUpload(file)
      }
    }

    input.click()
  }

  private async handleImageUpload(file: File) {
    try {
      const url = await uploadImage(file)
      if (url) {
        this.editor?.chain().focus().setImage({ 
          src: url, 
          alt: file.name 
        }).run()
      }
    } catch (error) {
      console.error('Image upload error:', error)
      this.onErrorCallback?.(error as Error)
    }
  }

  // =====================================================
  // 자동저장
  // =====================================================

  private scheduleAutoSave() {
    if (this.autoSaveTimer) {
      clearTimeout(this.autoSaveTimer)
    }

    this.autoSaveTimer = setTimeout(() => {
      this.autoSave()
    }, 3000)
  }

  async autoSave(): Promise<void> {
    if (!this.isDirty || !this.draftId || !this.editor) return

    try {
      const content = this.editor.getJSON()
      const html = this.editor.getHTML()

      // localStorage 백업
      localStorage.setItem(`howto-draft-${this.draftId}`, JSON.stringify({
        content,
        html,
        version: this.version,
        savedAt: new Date().toISOString()
      }))

      // 서버 저장
      const res = await fetch(`/api/howto/drafts/${this.draftId}`, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json',
          'If-Match': this.version.toString()
        },
        body: JSON.stringify({
          contentJson: JSON.stringify(content),
          contentHtml: html
        })
      })

      const data = await res.json()

      if (data.success) {
        this.version = data.newVersion || this.version + 1
        this.isDirty = false
        this.onSaveCallback?.({ success: true, version: this.version })
      } else if (res.status === 409) {
        this.handleVersionConflict(data.serverVersion)
      } else {
        throw new Error(data.error || '저장 실패')
      }
    } catch (error) {
      console.error('Auto-save error:', error)
      this.onErrorCallback?.(error as Error)
    }
  }

  private handleVersionConflict(serverVersion: number) {
    const dialog = document.getElementById('conflict-dialog')
    if (dialog) {
      dialog.classList.remove('hidden')
      const serverEl = dialog.querySelector('[data-server-version]')
      const localEl = dialog.querySelector('[data-local-version]')
      if (serverEl) serverEl.textContent = String(serverVersion)
      if (localEl) localEl.textContent = String(this.version)
    }

    this.onErrorCallback?.(new Error('버전 충돌이 발생했습니다.'))
  }

  // =====================================================
  // 키보드 단축키
  // =====================================================

  private setupKeyboardShortcuts() {
    document.addEventListener('keydown', (e) => {
      if ((e.ctrlKey || e.metaKey) && e.key === 's') {
        e.preventDefault()
        this.autoSave()
      }
    })
  }

  // =====================================================
  // 나가기 보호 (index.tsx에서 관리하므로 비활성화)
  // =====================================================

  private setupBeforeUnload() {
    // 나가기 경고는 index.tsx의 beforeUnloadHandler에서 관리
    // 여기서는 아무것도 하지 않음 (중복 등록 방지)
  }

  // =====================================================
  // Public API
  // =====================================================

  getContent(): JSONContent | null {
    return this.editor?.getJSON() ?? null
  }

  getHTML(): string {
    return this.editor?.getHTML() ?? ''
  }

  setContent(content: JSONContent | string) {
    this.editor?.commands.setContent(content)
    // 콘텐츠 설정 후 각주 목록 로드
    this.loadFootnotesFromContent()
  }

  // 콘텐츠에서 각주 정보 로드
  private loadFootnotesFromContent() {
    if (!this.editor) return
    
    // 기존 각주 맵 초기화
    this.footnotes.clear()
    
    // 문서에서 각주 노드 수집
    this.editor.state.doc.descendants((node) => {
      if (node.type.name === 'footnote') {
        this.footnotes.set(node.attrs.id, {
          text: node.attrs.text,
          url: node.attrs.url || undefined
        })
      }
    })
    
    // UI 업데이트
    setTimeout(() => this.updateFootnotesList(), 50)
  }

  setDraftId(id: number) {
    this.draftId = id
  }

  setVersion(v: number) {
    this.version = v
  }

  markClean() {
    this.isDirty = false
  }

  destroy() {
    if (this.autoSaveTimer) {
      clearTimeout(this.autoSaveTimer)
    }
    this.editor?.destroy()
    this.slashMenuEl?.remove()
  }
}


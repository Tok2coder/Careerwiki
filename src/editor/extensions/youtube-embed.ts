import { Node, mergeAttributes } from '@tiptap/core'

declare module '@tiptap/core' {
  interface Commands<ReturnType> {
    youtube: {
      setYoutubeVideo: (options: { src: string }) => ReturnType
    }
  }
}

// YouTube URL을 embed URL로 변환
function getYoutubeEmbedUrl(url: string): string | null {
  if (!url) return null

  // 이미 embed URL인 경우
  const embedMatch = url.match(/youtube\.com\/embed\/([a-zA-Z0-9_-]{11})/)
  if (embedMatch) return `https://www.youtube.com/embed/${embedMatch[1]}`

  // youtube.com/watch?v=XXX
  const watchMatch = url.match(/[?&]v=([a-zA-Z0-9_-]{11})/)
  if (watchMatch) return `https://www.youtube.com/embed/${watchMatch[1]}`

  // youtu.be/XXX
  const shortMatch = url.match(/youtu\.be\/([a-zA-Z0-9_-]{11})/)
  if (shortMatch) return `https://www.youtube.com/embed/${shortMatch[1]}`

  // youtube.com/shorts/XXX
  const shortsMatch = url.match(/youtube\.com\/shorts\/([a-zA-Z0-9_-]{11})/)
  if (shortsMatch) return `https://www.youtube.com/embed/${shortsMatch[1]}`

  return null
}

// embed URL에서 video ID 추출
function getVideoId(src: string): string | null {
  const match = src.match(/youtube\.com\/embed\/([a-zA-Z0-9_-]{11})/)
  return match ? match[1] : null
}

export const YoutubeEmbed = Node.create({
  name: 'youtube',
  group: 'block',
  atom: true,

  addAttributes() {
    return {
      src: {
        default: null,
        parseHTML: (element: HTMLElement) => {
          const iframe = element.querySelector('iframe')
          return iframe?.getAttribute('src') || null
        },
      },
      width: { default: '100%' },
    }
  },

  parseHTML() {
    return [
      { tag: 'div[data-youtube-video]' },
      { tag: 'div.youtube-embed' },
    ]
  },

  renderHTML({ HTMLAttributes }) {
    const src = HTMLAttributes.src || ''
    return [
      'div',
      mergeAttributes({ 'data-youtube-video': '', class: 'youtube-embed' }),
      [
        'iframe',
        {
          src,
          frameborder: '0',
          allowfullscreen: 'true',
          allow: 'accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture',
          style: 'position:absolute;top:0;left:0;width:100%;height:100%;border-radius:0.75rem',
        },
      ],
    ]
  },

  addNodeView() {
    return ({ node, editor, getPos }) => {
      const dom = document.createElement('div')
      dom.className = 'youtube-embed youtube-editor-wrapper'
      dom.setAttribute('data-youtube-video', '')

      const src = node.attrs.src || ''
      const videoId = getVideoId(src)

      // 썸네일 + 오버레이 (에디터에서 iframe 직접 쓰면 포커스/드래그 문제 발생)
      const preview = document.createElement('div')
      preview.className = 'youtube-preview'

      if (videoId) {
        const thumb = document.createElement('img')
        thumb.src = `https://img.youtube.com/vi/${videoId}/hqdefault.jpg`
        thumb.alt = 'YouTube'
        thumb.className = 'youtube-thumb'
        thumb.loading = 'lazy'
        preview.appendChild(thumb)
      }

      const playBtn = document.createElement('div')
      playBtn.className = 'youtube-play-btn'
      playBtn.innerHTML = '<svg viewBox="0 0 68 48" width="68" height="48"><path d="M66.5 7.7c-.8-2.9-2.5-5.4-5.4-6.2C55.8.1 34 0 34 0S12.2.1 6.9 1.6c-2.8.7-4.6 3.2-5.4 6.1C.1 13 0 24 0 24s.1 11 1.5 16.3c.8 2.9 2.5 5.4 5.4 6.2C12.2 47.9 34 48 34 48s21.8-.1 27.1-1.6c2.8-.7 4.6-3.2 5.4-6.1C67.9 35 68 24 68 24s-.1-11-1.5-16.3z" fill="red"/><path d="M45 24L27 14v20" fill="#fff"/></svg>'
      preview.appendChild(playBtn)

      const urlLabel = document.createElement('div')
      urlLabel.className = 'youtube-url-label'
      urlLabel.textContent = src ? `youtube.com/embed/${videoId || ''}` : 'YouTube URL 없음'
      preview.appendChild(urlLabel)

      // 삭제 버튼
      const deleteBtn = document.createElement('button')
      deleteBtn.type = 'button'
      deleteBtn.className = 'youtube-delete-btn'
      deleteBtn.innerHTML = '<i class="fas fa-trash"></i>'
      deleteBtn.title = '삭제'
      deleteBtn.addEventListener('click', (e) => {
        e.preventDefault()
        e.stopPropagation()
        if (typeof getPos === 'function') {
          const pos = getPos()
          if (pos != null) {
            editor.chain().focus().setNodeSelection(pos).deleteSelection().run()
          }
        }
      })
      preview.appendChild(deleteBtn)

      // URL 변경 버튼
      const editBtn = document.createElement('button')
      editBtn.type = 'button'
      editBtn.className = 'youtube-edit-btn'
      editBtn.innerHTML = '<i class="fas fa-edit"></i> URL 변경'
      editBtn.addEventListener('click', (e) => {
        e.preventDefault()
        e.stopPropagation()
        const newUrl = prompt('YouTube URL:', src)
        if (newUrl && typeof getPos === 'function') {
          const embedUrl = getYoutubeEmbedUrl(newUrl)
          if (embedUrl) {
            const pos = getPos()
            if (pos != null) {
              editor.commands.command(({ tr }) => {
                tr.setNodeMarkup(pos, undefined, { ...node.attrs, src: embedUrl })
                return true
              })
            }
          } else {
            alert('유효한 YouTube URL이 아닙니다.')
          }
        }
      })
      preview.appendChild(editBtn)

      dom.appendChild(preview)

      return {
        dom,
        update: (updatedNode) => {
          if (updatedNode.type.name !== 'youtube') return false
          const newSrc = updatedNode.attrs.src || ''
          const newVideoId = getVideoId(newSrc)
          const thumb = preview.querySelector('.youtube-thumb') as HTMLImageElement
          if (thumb && newVideoId) {
            thumb.src = `https://img.youtube.com/vi/${newVideoId}/hqdefault.jpg`
          }
          urlLabel.textContent = newSrc ? `youtube.com/embed/${newVideoId || ''}` : 'YouTube URL 없음'
          return true
        },
      }
    }
  },

  addCommands() {
    return {
      setYoutubeVideo:
        (options: { src: string }) =>
        ({ commands }) => {
          const embedUrl = getYoutubeEmbedUrl(options.src)
          if (!embedUrl) return false
          return commands.insertContent({ type: this.name, attrs: { src: embedUrl } })
        },
    }
  },
})

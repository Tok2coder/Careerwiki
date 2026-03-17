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

export const YoutubeEmbed = Node.create({
  name: 'youtube',
  group: 'block',
  atom: true, // 내부 편집 불가

  addAttributes() {
    return {
      src: { default: null },
      width: { default: '100%' },
    }
  },

  parseHTML() {
    return [{ tag: 'div[data-youtube-video]' }]
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

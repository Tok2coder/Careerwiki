import Image from '@tiptap/extension-image'
import { mergeAttributes } from '@tiptap/core'

declare module '@tiptap/core' {
  interface Commands<ReturnType> {
    resizableImage: {
      setImageSize: (options: { width?: number | string; height?: number | string }) => ReturnType
    }
  }
}

export const ResizableImage = Image.extend({
  name: 'image',

  addAttributes() {
    return {
      ...this.parent?.(),
      width: {
        default: null,
        parseHTML: (element) => {
          const width = element.getAttribute('width') || element.style.width
          return width ? width.replace('px', '') : null
        },
        renderHTML: (attributes) => {
          if (!attributes.width) {
            return {}
          }
          return {
            width: attributes.width,
            style: `width: ${attributes.width}px`,
          }
        },
      },
      height: {
        default: null,
        parseHTML: (element) => {
          const height = element.getAttribute('height') || element.style.height
          return height ? height.replace('px', '') : null
        },
        renderHTML: (attributes) => {
          if (!attributes.height) {
            return {}
          }
          return {
            height: attributes.height,
            style: `height: ${attributes.height}px`,
          }
        },
      },
      align: {
        default: 'center',
        parseHTML: (element) => {
          return element.getAttribute('data-align') || 'center'
        },
        renderHTML: (attributes) => {
          return {
            'data-align': attributes.align,
          }
        },
      },
    }
  },

  addCommands() {
    return {
      ...this.parent?.(),
      setImageSize:
        (options) =>
        ({ commands }) => {
          return commands.updateAttributes(this.name, options)
        },
    }
  },

  addNodeView() {
    return ({ node, getPos, editor }) => {
      const container = document.createElement('div')
      container.className = 'image-resizer'
      container.setAttribute('data-align', node.attrs.align || 'center')

      const img = document.createElement('img')
      img.src = node.attrs.src
      img.alt = node.attrs.alt || ''
      img.className = 'rounded-lg'
      img.loading = 'lazy'
      
      if (node.attrs.width) {
        img.style.width = `${node.attrs.width}px`
      }
      if (node.attrs.height) {
        img.style.height = `${node.attrs.height}px`
      }

      // 리사이즈 핸들
      const handles = ['nw', 'ne', 'sw', 'se']
      const handleElements: HTMLElement[] = []
      
      handles.forEach((pos) => {
        const handle = document.createElement('div')
        handle.className = `resize-handle resize-handle-${pos}`
        handle.setAttribute('data-position', pos)
        handleElements.push(handle)
        container.appendChild(handle)
      })

      // 이미지 툴바
      const toolbar = document.createElement('div')
      toolbar.className = 'image-toolbar'
      toolbar.innerHTML = `
        <button type="button" data-action="align-left" title="왼쪽 정렬"><i class="fas fa-align-left"></i></button>
        <button type="button" data-action="align-center" title="가운데 정렬"><i class="fas fa-align-center"></i></button>
        <button type="button" data-action="align-right" title="오른쪽 정렬"><i class="fas fa-align-right"></i></button>
        <span class="toolbar-separator"></span>
        <button type="button" data-action="size-small" title="작게 (25%)">S</button>
        <button type="button" data-action="size-medium" title="중간 (50%)">M</button>
        <button type="button" data-action="size-large" title="크게 (75%)">L</button>
        <button type="button" data-action="size-full" title="원본 (100%)">원본</button>
        <span class="toolbar-separator"></span>
        <button type="button" data-action="crop" title="자르기"><i class="fas fa-crop-alt"></i></button>
        <button type="button" data-action="mosaic" title="모자이크"><i class="fas fa-th"></i></button>
        <span class="toolbar-separator"></span>
        <button type="button" data-action="delete" title="삭제"><i class="fas fa-trash"></i></button>
      `

      container.appendChild(img)
      container.appendChild(toolbar)

      // 툴바 위치 조정 (화면 밖으로 나가지 않도록)
      const adjustToolbarPosition = () => {
        // 먼저 툴바를 보이게 해서 크기 측정
        const wasHidden = toolbar.style.display === 'none'
        if (wasHidden) toolbar.style.display = 'flex'
        
        // 기본 중앙 정렬로 초기화
        toolbar.style.left = '50%'
        toolbar.style.right = 'auto'
        toolbar.style.transform = 'translateX(-50%)'
        
        requestAnimationFrame(() => {
          const containerRect = container.getBoundingClientRect()
          const toolbarWidth = toolbar.offsetWidth
          
          // 에디터 영역 찾기
          const editorEl = container.closest('.howto-editor-content') || container.closest('.ProseMirror')
          const editorRect = editorEl?.getBoundingClientRect() || { left: 0, right: window.innerWidth }
          
          // 툴바 중앙 위치 계산
          const containerCenter = containerRect.left + (containerRect.width / 2)
          const toolbarLeftPos = containerCenter - (toolbarWidth / 2)
          const toolbarRightPos = containerCenter + (toolbarWidth / 2)
          
          // 툴바가 왼쪽으로 벗어나는 경우 - 왼쪽 정렬
          if (toolbarLeftPos < editorRect.left) {
            const offset = editorRect.left - containerRect.left + 4
            toolbar.style.left = `${Math.max(0, offset)}px`
            toolbar.style.right = 'auto'
            toolbar.style.transform = 'none'
          }
          // 툴바가 오른쪽으로 벗어나는 경우 - 오른쪽 정렬
          else if (toolbarRightPos > editorRect.right) {
            toolbar.style.left = 'auto'
            toolbar.style.right = '0'
            toolbar.style.transform = 'none'
          }
          
          if (wasHidden) toolbar.style.display = ''
        })
      }

      // 안전한 pos 가져오기 헬퍼 함수
      const getSafePos = (): number => {
        if (typeof getPos === 'function') {
          const pos = getPos()
          return pos !== undefined ? pos : 0
        }
        return 0
      }

      // 선택 상태 관리
      const updateSelection = () => {
        const { from, to } = editor.state.selection
        const pos = getSafePos()
        const isSelected = from <= pos && to >= pos + node.nodeSize
        container.classList.toggle('selected', isSelected)
        
        // 선택 시 툴바 위치 조정
        if (isSelected) {
          adjustToolbarPosition()
        }
      }

      // 클릭 시 선택
      container.addEventListener('click', (e) => {
        e.preventDefault()
        const pos = getSafePos()
        editor.commands.setNodeSelection(pos)
        updateSelection()
      })

      // 툴바 액션
      toolbar.addEventListener('click', (e) => {
        const target = e.target as HTMLElement
        const button = target.closest('button')
        if (!button) return
        
        e.stopPropagation()
        const action = button.getAttribute('data-action')
        const pos = getSafePos()
        
        switch (action) {
          case 'align-left':
          case 'align-center':
          case 'align-right':
            editor.chain().focus().setNodeSelection(pos).updateAttributes('image', { 
              align: action.replace('align-', '') 
            }).run()
            container.setAttribute('data-align', action.replace('align-', ''))
            break
          case 'size-small':
            updateImageSize(25)
            break
          case 'size-medium':
            updateImageSize(50)
            break
          case 'size-large':
            updateImageSize(75)
            break
          case 'size-full':
            updateImageSize(100)
            break
          case 'delete':
            editor.chain().focus().setNodeSelection(pos).deleteSelection().run()
            break
          case 'crop':
            openCropModal(img, (croppedDataUrl) => {
              const currentPos = getSafePos()
              editor.chain().focus().setNodeSelection(currentPos).updateAttributes('image', {
                src: croppedDataUrl,
                width: null,
                height: null
              }).run()
              img.src = croppedDataUrl
            })
            break
          case 'mosaic':
            openMosaicModal(img, (mosaicDataUrl) => {
              const currentPos = getSafePos()
              editor.chain().focus().setNodeSelection(currentPos).updateAttributes('image', {
                src: mosaicDataUrl
              }).run()
              img.src = mosaicDataUrl
            })
            break
        }
      })

      // 이미지 크기 업데이트
      const updateImageSize = (percent: number) => {
        const naturalWidth = img.naturalWidth || 800
        const newWidth = Math.round(naturalWidth * (percent / 100))
        const pos = getSafePos()
        
        editor.chain().focus().setNodeSelection(pos).updateAttributes('image', { 
          width: newWidth,
          height: null // 비율 유지를 위해 height는 auto
        }).run()
        
        img.style.width = `${newWidth}px`
        img.style.height = 'auto'
      }

      // 리사이즈 드래그
      let isResizing = false
      let startX = 0
      let startY = 0
      let startWidth = 0
      let startHeight = 0
      let aspectRatio = 1

      handleElements.forEach((handle) => {
        handle.addEventListener('mousedown', (e) => {
          e.preventDefault()
          e.stopPropagation()
          
          isResizing = true
          startX = e.clientX
          startY = e.clientY
          startWidth = img.offsetWidth
          startHeight = img.offsetHeight
          aspectRatio = startWidth / startHeight
          
          container.classList.add('resizing')
          
          const onMouseMove = (moveEvent: MouseEvent) => {
            if (!isResizing) return
            
            const position = handle.getAttribute('data-position')
            let deltaX = moveEvent.clientX - startX
            let deltaY = moveEvent.clientY - startY
            
            // 방향에 따라 델타 조정
            if (position?.includes('w')) deltaX = -deltaX
            if (position?.includes('n')) deltaY = -deltaY
            
            // 비율 유지하며 리사이즈
            let newWidth = startWidth + deltaX
            let newHeight = newWidth / aspectRatio
            
            // 최소/최대 크기 제한
            newWidth = Math.max(50, Math.min(newWidth, 1200))
            newHeight = newWidth / aspectRatio
            
            img.style.width = `${newWidth}px`
            img.style.height = `${newHeight}px`
          }
          
          const onMouseUp = () => {
            if (!isResizing) return
            isResizing = false
            container.classList.remove('resizing')
            
            // 에디터에 크기 저장
            const pos = getSafePos()
            editor.chain().focus().setNodeSelection(pos).updateAttributes('image', {
              width: Math.round(img.offsetWidth),
              height: Math.round(img.offsetHeight)
            }).run()
            
            document.removeEventListener('mousemove', onMouseMove)
            document.removeEventListener('mouseup', onMouseUp)
          }
          
          document.addEventListener('mousemove', onMouseMove)
          document.addEventListener('mouseup', onMouseUp)
        })
      })

      // 에디터 업데이트 리스너
      const updateHandler = () => updateSelection()
      editor.on('selectionUpdate', updateHandler)
      editor.on('transaction', updateHandler)

      return {
        dom: container,
        update: (updatedNode) => {
          if (updatedNode.type.name !== 'image') return false
          
          img.src = updatedNode.attrs.src
          img.alt = updatedNode.attrs.alt || ''
          
          if (updatedNode.attrs.width) {
            img.style.width = `${updatedNode.attrs.width}px`
          } else {
            img.style.width = ''
          }
          
          if (updatedNode.attrs.height) {
            img.style.height = `${updatedNode.attrs.height}px`
          } else {
            img.style.height = ''
          }
          
          container.setAttribute('data-align', updatedNode.attrs.align || 'center')
          
          return true
        },
        destroy: () => {
          editor.off('selectionUpdate', updateHandler)
          editor.off('transaction', updateHandler)
        }
      }
    }
  },

  renderHTML({ HTMLAttributes }) {
    const align = HTMLAttributes['data-align'] || 'center'
    return [
      'figure',
      { 
        class: `image-wrapper image-align-${align}`,
        'data-align': align
      },
      ['img', mergeAttributes(this.options.HTMLAttributes, HTMLAttributes)]
    ]
  },
})

// 크롭 모달
function openCropModal(img: HTMLImageElement, onComplete: (dataUrl: string) => void) {
  const modal = document.createElement('div')
  modal.className = 'image-edit-modal'
  modal.innerHTML = `
    <div class="image-edit-modal-backdrop"></div>
    <div class="image-edit-modal-content">
      <div class="image-edit-modal-header">
        <h3>이미지 자르기</h3>
        <button type="button" class="close-btn"><i class="fas fa-times"></i></button>
      </div>
      <div class="image-edit-modal-body">
        <div class="crop-container">
          <canvas id="crop-canvas"></canvas>
          <div class="crop-selection" id="crop-selection"></div>
        </div>
        <div class="crop-info">
          <span id="crop-size">선택 영역을 드래그하세요</span>
        </div>
      </div>
      <div class="image-edit-modal-footer">
        <button type="button" class="btn-cancel">취소</button>
        <button type="button" class="btn-apply">적용</button>
      </div>
    </div>
  `
  document.body.appendChild(modal)

  const canvas = modal.querySelector('#crop-canvas') as HTMLCanvasElement
  const ctx = canvas.getContext('2d')!
  const selection = modal.querySelector('#crop-selection') as HTMLElement
  const sizeInfo = modal.querySelector('#crop-size') as HTMLElement

  // 이미지 로드
  const tempImg = new window.Image()
  tempImg.crossOrigin = 'anonymous'
  tempImg.onload = () => {
    const maxSize = 600
    const scale = Math.min(maxSize / tempImg.width, maxSize / tempImg.height, 1)
    canvas.width = tempImg.width * scale
    canvas.height = tempImg.height * scale
    ctx.drawImage(tempImg, 0, 0, canvas.width, canvas.height)
  }
  tempImg.src = img.src

  // 선택 영역 드래그
  let isDragging = false
  let isResizing = false
  let startX = 0, startY = 0
  let cropX = 50, cropY = 50, cropW = 200, cropH = 150

  const updateSelection = () => {
    selection.style.left = `${cropX}px`
    selection.style.top = `${cropY}px`
    selection.style.width = `${cropW}px`
    selection.style.height = `${cropH}px`
    sizeInfo.textContent = `${Math.round(cropW)} x ${Math.round(cropH)}`
  }
  updateSelection()

  const container = modal.querySelector('.crop-container') as HTMLElement
  
  container.addEventListener('mousedown', (e) => {
    const rect = container.getBoundingClientRect()
    const x = e.clientX - rect.left
    const y = e.clientY - rect.top

    // 선택 영역 내부 클릭 = 이동
    if (x >= cropX && x <= cropX + cropW && y >= cropY && y <= cropY + cropH) {
      isDragging = true
      startX = x - cropX
      startY = y - cropY
    } else {
      // 새 선택 시작
      isDragging = false
      isResizing = true
      cropX = x
      cropY = y
      cropW = 0
      cropH = 0
      startX = x
      startY = y
    }
  })

  container.addEventListener('mousemove', (e) => {
    const rect = container.getBoundingClientRect()
    const x = Math.max(0, Math.min(e.clientX - rect.left, canvas.width))
    const y = Math.max(0, Math.min(e.clientY - rect.top, canvas.height))

    if (isDragging) {
      cropX = Math.max(0, Math.min(x - startX, canvas.width - cropW))
      cropY = Math.max(0, Math.min(y - startY, canvas.height - cropH))
      updateSelection()
    } else if (isResizing) {
      cropW = Math.abs(x - startX)
      cropH = Math.abs(y - startY)
      cropX = Math.min(x, startX)
      cropY = Math.min(y, startY)
      updateSelection()
    }
  })

  document.addEventListener('mouseup', () => {
    isDragging = false
    isResizing = false
  })

  // 닫기
  const close = () => {
    modal.remove()
  }
  modal.querySelector('.close-btn')?.addEventListener('click', close)
  modal.querySelector('.btn-cancel')?.addEventListener('click', close)
  modal.querySelector('.image-edit-modal-backdrop')?.addEventListener('click', close)

  // 적용
  modal.querySelector('.btn-apply')?.addEventListener('click', () => {
    const originalScale = tempImg.width / canvas.width
    const sx = cropX * originalScale
    const sy = cropY * originalScale
    const sw = cropW * originalScale
    const sh = cropH * originalScale

    const outputCanvas = document.createElement('canvas')
    outputCanvas.width = sw
    outputCanvas.height = sh
    const outCtx = outputCanvas.getContext('2d')!
    outCtx.drawImage(tempImg, sx, sy, sw, sh, 0, 0, sw, sh)

    const dataUrl = outputCanvas.toDataURL('image/png')
    onComplete(dataUrl)
    close()
  })
}

// 모자이크 모달
function openMosaicModal(img: HTMLImageElement, onComplete: (dataUrl: string) => void) {
  const modal = document.createElement('div')
  modal.className = 'image-edit-modal'
  modal.innerHTML = `
    <div class="image-edit-modal-backdrop"></div>
    <div class="image-edit-modal-content">
      <div class="image-edit-modal-header">
        <h3>모자이크 적용</h3>
        <button type="button" class="close-btn"><i class="fas fa-times"></i></button>
      </div>
      <div class="image-edit-modal-body">
        <div class="mosaic-container">
          <canvas id="mosaic-canvas"></canvas>
          <div class="mosaic-selection" id="mosaic-selection"></div>
        </div>
        <div class="mosaic-controls">
          <label>모자이크 강도: <input type="range" id="mosaic-intensity" min="5" max="30" value="15"></label>
          <span id="mosaic-info">영역을 선택하세요</span>
        </div>
      </div>
      <div class="image-edit-modal-footer">
        <button type="button" class="btn-cancel">취소</button>
        <button type="button" class="btn-apply-mosaic">모자이크 적용</button>
        <button type="button" class="btn-done">완료</button>
      </div>
    </div>
  `
  document.body.appendChild(modal)

  const canvas = modal.querySelector('#mosaic-canvas') as HTMLCanvasElement
  const ctx = canvas.getContext('2d')!
  const selection = modal.querySelector('#mosaic-selection') as HTMLElement
  const intensityInput = modal.querySelector('#mosaic-intensity') as HTMLInputElement
  const infoEl = modal.querySelector('#mosaic-info') as HTMLElement

  // 이미지 로드
  const tempImg = new window.Image()
  tempImg.crossOrigin = 'anonymous'
  let scale = 1
  
  tempImg.onload = () => {
    const maxSize = 600
    scale = Math.min(maxSize / tempImg.width, maxSize / tempImg.height, 1)
    canvas.width = tempImg.width * scale
    canvas.height = tempImg.height * scale
    ctx.drawImage(tempImg, 0, 0, canvas.width, canvas.height)
  }
  tempImg.src = img.src

  // 선택 영역
  let isDragging = false
  let isResizing = false
  let startX = 0, startY = 0
  let mosaicX = 0, mosaicY = 0, mosaicW = 0, mosaicH = 0

  const updateSelection = () => {
    selection.style.left = `${mosaicX}px`
    selection.style.top = `${mosaicY}px`
    selection.style.width = `${mosaicW}px`
    selection.style.height = `${mosaicH}px`
    selection.style.display = mosaicW > 0 ? 'block' : 'none'
    infoEl.textContent = mosaicW > 0 ? `${Math.round(mosaicW)} x ${Math.round(mosaicH)}` : '영역을 선택하세요'
  }

  const container = modal.querySelector('.mosaic-container') as HTMLElement

  container.addEventListener('mousedown', (e) => {
    const rect = container.getBoundingClientRect()
    const x = e.clientX - rect.left
    const y = e.clientY - rect.top

    if (mosaicW > 0 && x >= mosaicX && x <= mosaicX + mosaicW && y >= mosaicY && y <= mosaicY + mosaicH) {
      isDragging = true
      startX = x - mosaicX
      startY = y - mosaicY
    } else {
      isResizing = true
      mosaicX = x
      mosaicY = y
      mosaicW = 0
      mosaicH = 0
      startX = x
      startY = y
    }
  })

  container.addEventListener('mousemove', (e) => {
    const rect = container.getBoundingClientRect()
    const x = Math.max(0, Math.min(e.clientX - rect.left, canvas.width))
    const y = Math.max(0, Math.min(e.clientY - rect.top, canvas.height))

    if (isDragging) {
      mosaicX = Math.max(0, Math.min(x - startX, canvas.width - mosaicW))
      mosaicY = Math.max(0, Math.min(y - startY, canvas.height - mosaicH))
      updateSelection()
    } else if (isResizing) {
      mosaicW = Math.abs(x - startX)
      mosaicH = Math.abs(y - startY)
      mosaicX = Math.min(x, startX)
      mosaicY = Math.min(y, startY)
      updateSelection()
    }
  })

  document.addEventListener('mouseup', () => {
    isDragging = false
    isResizing = false
  })

  // 닫기
  const close = () => {
    modal.remove()
  }
  modal.querySelector('.close-btn')?.addEventListener('click', close)
  modal.querySelector('.btn-cancel')?.addEventListener('click', close)
  modal.querySelector('.image-edit-modal-backdrop')?.addEventListener('click', close)

  // 모자이크 적용
  modal.querySelector('.btn-apply-mosaic')?.addEventListener('click', () => {
    if (mosaicW < 10 || mosaicH < 10) {
      infoEl.textContent = '영역이 너무 작습니다'
      return
    }

    const intensity = parseInt(intensityInput.value)
    const sx = mosaicX / scale
    const sy = mosaicY / scale
    const sw = mosaicW / scale
    const sh = mosaicH / scale

    // 모자이크 처리
    const imageData = ctx.getImageData(mosaicX, mosaicY, mosaicW, mosaicH)
    const data = imageData.data
    const blockSize = intensity

    for (let y = 0; y < mosaicH; y += blockSize) {
      for (let x = 0; x < mosaicW; x += blockSize) {
        // 블록 평균 색상 계산
        let r = 0, g = 0, b = 0, count = 0
        for (let dy = 0; dy < blockSize && y + dy < mosaicH; dy++) {
          for (let dx = 0; dx < blockSize && x + dx < mosaicW; dx++) {
            const i = ((y + dy) * mosaicW + (x + dx)) * 4
            r += data[i]
            g += data[i + 1]
            b += data[i + 2]
            count++
          }
        }
        r = Math.round(r / count)
        g = Math.round(g / count)
        b = Math.round(b / count)

        // 블록 색상 적용
        for (let dy = 0; dy < blockSize && y + dy < mosaicH; dy++) {
          for (let dx = 0; dx < blockSize && x + dx < mosaicW; dx++) {
            const i = ((y + dy) * mosaicW + (x + dx)) * 4
            data[i] = r
            data[i + 1] = g
            data[i + 2] = b
          }
        }
      }
    }

    ctx.putImageData(imageData, mosaicX, mosaicY)
    
    // 선택 초기화
    mosaicW = 0
    mosaicH = 0
    updateSelection()
    infoEl.textContent = '모자이크 적용됨. 다른 영역을 선택하거나 완료를 누르세요.'
  })

  // 완료
  modal.querySelector('.btn-done')?.addEventListener('click', () => {
    const dataUrl = canvas.toDataURL('image/png')
    onComplete(dataUrl)
    close()
  })
}


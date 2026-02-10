// CareerWiki Resume Upload Client
// P0: 클라이언트 측에서 pdf.js로 텍스트 추출 후 서버에 전송
// pdf.js CDN: https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.11.174/pdf.min.js

(function() {
  'use strict';

  // pdf.js 라이브러리 로드 상태
  let pdfJsLoaded = false;
  let pdfJsLoading = false;

  // pdf.js 라이브러리 동적 로드
  async function loadPdfJs() {
    if (pdfJsLoaded) return;
    if (pdfJsLoading) {
      // 이미 로딩 중이면 완료될 때까지 대기
      return new Promise((resolve) => {
        const check = setInterval(() => {
          if (pdfJsLoaded) {
            clearInterval(check);
            resolve();
          }
        }, 100);
      });
    }

    pdfJsLoading = true;

    return new Promise((resolve, reject) => {
      const script = document.createElement('script');
      script.src = 'https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.11.174/pdf.min.js';
      script.onload = () => {
        // Worker 설정
        window.pdfjsLib.GlobalWorkerOptions.workerSrc = 
          'https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.11.174/pdf.worker.min.js';
        pdfJsLoaded = true;
        pdfJsLoading = false;
        resolve();
      };
      script.onerror = () => {
        pdfJsLoading = false;
        reject(new Error('pdf.js 라이브러리 로드 실패'));
      };
      document.head.appendChild(script);
    });
  }

  // PDF에서 텍스트 추출
  async function extractTextFromPdf(file) {
    await loadPdfJs();

    const arrayBuffer = await file.arrayBuffer();
    const pdf = await window.pdfjsLib.getDocument({ data: arrayBuffer }).promise;

    let fullText = '';
    const numPages = pdf.numPages;

    for (let pageNum = 1; pageNum <= numPages; pageNum++) {
      const page = await pdf.getPage(pageNum);
      const textContent = await page.getTextContent();
      const pageText = textContent.items
        .map(item => item.str)
        .join(' ');
      fullText += pageText + '\n\n';
    }

    return fullText.trim();
  }

  // 파일 검증
  function validateFile(file) {
    const errors = [];

    // 파일 타입 검사
    if (!file.type || file.type !== 'application/pdf') {
      errors.push('PDF 파일만 업로드 가능합니다');
    }

    // 파일 크기 검사 (5MB 제한)
    const maxSize = 5 * 1024 * 1024;
    if (file.size > maxSize) {
      errors.push('파일 크기는 5MB 이하여야 합니다');
    }

    // 파일명 검사
    if (!file.name.toLowerCase().endsWith('.pdf')) {
      errors.push('PDF 파일(.pdf)만 업로드 가능합니다');
    }

    return errors;
  }

  // 서버에 파싱 요청
  async function parseResumeOnServer(text, sessionId, saveToDraft = false) {
    const response = await fetch('/api/analyzer/resume/parse', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        text: text,
        session_id: sessionId,
        save_to_draft: saveToDraft,
      }),
    });

    if (!response.ok) {
      const error = await response.json();
      throw new Error(error.message || '이력서 파싱 실패');
    }

    return response.json();
  }

  // 메인 업로드 핸들러
  async function handleResumeUpload(file, options = {}) {
    const {
      sessionId = null,
      saveToDraft = false,
      onProgress = null,
      onError = null,
      onSuccess = null,
    } = options;

    try {
      // 1. 파일 검증
      if (onProgress) onProgress('validating', '파일 검증 중...');
      const errors = validateFile(file);
      if (errors.length > 0) {
        throw new Error(errors.join(', '));
      }

      // 2. PDF 텍스트 추출
      if (onProgress) onProgress('extracting', '텍스트 추출 중...');
      const text = await extractTextFromPdf(file);

      if (!text || text.length < 100) {
        throw new Error('이력서에서 텍스트를 추출할 수 없습니다. 다른 형식의 PDF를 시도해 주세요.');
      }

      // 3. 서버 파싱
      if (onProgress) onProgress('parsing', 'AI 분석 중...');
      const result = await parseResumeOnServer(text, sessionId, saveToDraft);

      // 4. 성공 콜백
      if (onSuccess) {
        onSuccess(result);
      }

      return result;
    } catch (error) {
      if (onError) {
        onError(error.message || '이력서 처리 중 오류가 발생했습니다');
      }
      throw error;
    }
  }

  // 드래그 앤 드롭 UI 초기화
  function initDropZone(dropZoneElement, options = {}) {
    const {
      sessionId = null,
      saveToDraft = false,
      onProgress = null,
      onError = null,
      onSuccess = null,
    } = options;

    // 파일 input 생성
    const fileInput = document.createElement('input');
    fileInput.type = 'file';
    fileInput.accept = '.pdf';
    fileInput.style.display = 'none';
    dropZoneElement.appendChild(fileInput);

    // 클릭으로 파일 선택
    dropZoneElement.addEventListener('click', () => {
      fileInput.click();
    });

    // 파일 선택 시
    fileInput.addEventListener('change', async (e) => {
      const file = e.target.files[0];
      if (file) {
        await handleResumeUpload(file, { sessionId, saveToDraft, onProgress, onError, onSuccess });
      }
      fileInput.value = ''; // 리셋
    });

    // 드래그 앤 드롭
    dropZoneElement.addEventListener('dragover', (e) => {
      e.preventDefault();
      e.stopPropagation();
      dropZoneElement.classList.add('drag-over');
    });

    dropZoneElement.addEventListener('dragleave', (e) => {
      e.preventDefault();
      e.stopPropagation();
      dropZoneElement.classList.remove('drag-over');
    });

    dropZoneElement.addEventListener('drop', async (e) => {
      e.preventDefault();
      e.stopPropagation();
      dropZoneElement.classList.remove('drag-over');

      const file = e.dataTransfer.files[0];
      if (file) {
        await handleResumeUpload(file, { sessionId, saveToDraft, onProgress, onError, onSuccess });
      }
    });

    return {
      destroy: () => {
        fileInput.remove();
      },
    };
  }

  // 전역 객체로 노출
  window.CareerWikiResume = {
    loadPdfJs,
    extractTextFromPdf,
    validateFile,
    parseResumeOnServer,
    handleResumeUpload,
    initDropZone,
  };
})();

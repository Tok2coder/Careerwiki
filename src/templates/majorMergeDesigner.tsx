/**
 * Major Template Structure Designer
 * 전공 데이터 필드 병합 규칙 설계 UI
 * 
 * 실제 템플릿 구조 (unifiedMajorDetail.ts)에 맞춘 설계:
 * - 히어로 섹션: 계열, 전공명, 개요, 이미지, 태그
 * - 탭: 개요, 상세정보, 대학정보 (3개)
 * - 사이드바: 관련 직업, 추천 자격증
 */

interface FieldInfo {
  name: string
  source: string
  path: string
  description: string
  examples: Array<{ value: any; majorName: string }>
  type: string
}

const escapeHtml = (value: string = ''): string =>
  value
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#039;')

const formatExampleValue = (value: any, maxLength?: number): string => {
  if (value === null || value === undefined) {
    return ''
  }

  let stringValue: string
  if (typeof value === 'string') {
    stringValue = value
  } else if (typeof value === 'number' || typeof value === 'boolean') {
    stringValue = String(value)
  } else {
    try {
      stringValue = JSON.stringify(value)
    } catch {
      stringValue = String(value)
    }
  }

  if (maxLength && stringValue.length > maxLength) {
    return `${stringValue.slice(0, maxLength)}…`
  }
  return stringValue
}

export function renderMajorMergeDesigner(
  careernetSamples: any[],
  work24MajorSamples: any[],
  majorName?: string,
  majorSlug?: string
): string {
  // 필드 정보 맵 (path를 키로 사용)
  const fieldMap = new Map<string, FieldInfo>()
  
  // 필드 추출 함수 (여러 샘플에서 예시 수집)
  function extractFields(samples: any[], source: string) {
    const currentMajorSamples = samples.filter(s => s._isCurrentMajor === true)
    const otherMajorSamples = samples.filter(s => s._isCurrentMajor !== true)
    
    currentMajorSamples.forEach(sample => {
      const majorName = sample._majorName || '알 수 없음'
      extractFieldsRecursive(sample, source, '', majorName, true)
    })
    
    otherMajorSamples.forEach(sample => {
      const majorName = sample._majorName || '알 수 없음'
      extractFieldsRecursive(sample, source, '', majorName, false)
    })
  }
  
  function extractFieldsRecursive(obj: any, source: string, path: string, majorName: string, isCurrentMajor: boolean) {
    if (!obj || typeof obj !== 'object') return
    
    for (const [key, value] of Object.entries(obj)) {
      if (key === '_majorName' || key === '_isCurrentMajor') continue
      
      const fullPath = path ? `${path}.${key}` : key
      const pathKey = `${source}.${fullPath}`
      
      const isNull = value === null || value === undefined
      const isArray = Array.isArray(value)
      const isObject = !isNull && !isArray && typeof value === 'object'
      const isPrimitive = !isNull && !isArray && !isObject
      
      if (isPrimitive || isArray || isNull) {
        let example: any = null
        let fieldType = 'unknown'
        
        if (isNull) {
          example = null
          fieldType = 'null'
        } else if (isArray) {
          example = value.length > 0 ? (typeof value[0] === 'object' ? JSON.stringify(value[0]).slice(0, 150) : value[0]) : null
          fieldType = 'array'
        } else {
          example = value
          fieldType = typeof value
        }
        
        if (!fieldMap.has(pathKey)) {
          fieldMap.set(pathKey, {
            name: key,
            source,
            path: fullPath,
            description: getFieldDescription(fullPath, source) || key,
            examples: [],
            type: fieldType
          })
        }
        
        const field = fieldMap.get(pathKey)!
        if (example !== null && example !== undefined && example !== '') {
          const normalizedExample = typeof example === 'string' 
            ? example.trim() 
            : (typeof example === 'object' 
              ? JSON.stringify(example) 
              : String(example))
          
          const hasDuplicate = field.examples.some(ex => {
            const normalizedExisting = typeof ex.value === 'string'
              ? ex.value.trim()
              : (typeof ex.value === 'object'
                ? JSON.stringify(ex.value)
                : String(ex.value))
            return normalizedExisting === normalizedExample
          })
          
          if (!hasDuplicate) {
            if (isCurrentMajor) {
              field.examples.unshift({ value: example, majorName })
            } else if (field.examples.length < 5) {
              field.examples.push({ value: example, majorName })
            }
          }
        }
      }
      
      if (isObject) {
        extractFieldsRecursive(value, source, fullPath, majorName, isCurrentMajor)
      }
    }
  }
  
  // 필드 설명 매핑
  function getFieldDescription(path: string, source: string): string {
    const key = path.split('.').pop() || ''
    
    const commonDesc: Record<string, string> = {
      'major': '전공명',
      'majorName': '전공명',
      'name': '이름',
      'summary': '학과 소개',
      'aptitude': '적성/흥미',
      'interest': '적성/흥미',
      'property': '학과 특성',
      'salary': '졸업 후 임금',
      'employment': '취업률',
      'department': '관련학과',
      'qualifications': '자격증',
      'licenses': '취득 자격',
      'university': '개설대학(텍스트)',
      'universities': '개설대학 목록',
      'universityList': '개설대학 목록',
      'relatedJobs': '관련직업',
      'relatedMajors': '관련학과',
      'mainSubjects': '주요교과목',
      'categoryId': '계열 ID',
      'categoryName': '계열명',
    }
    
    if (commonDesc[key]) return commonDesc[key]
    
    // CareerNet 전용
    if (source === 'CAREERNET') {
      const careernetDesc: Record<string, string> = {
        'relate_subject': '고교 추천 교과목',
        'career_act': '진로 탐색 활동',
        'enter_field': '진출 분야',
        'main_subject': '대학 주요 교과목',
        'job': '관련직업(텍스트)',
        'chartData': '차트 데이터',
        'majorSeq': '전공 번호',
        'salaryAfterGraduation': '졸업 후 임금',
        'employmentRate': '취업률',
        'relatedJob': '관련직업',
        'subject_name': '교과목명',
        'subject_description': '교과목 설명',
        'SBJECT_NM': '교과목명',
        'SBJECT_SUMRY': '교과목 설명',
        'act_name': '활동명',
        'act_description': '활동 설명',
        'gradeuate': '진출분야',
        'description': '설명',
        'schoolName': '학교명',
        'schoolURL': '학교URL',
        'area': '지역',
        'campus_nm': '캠퍼스',
        'lstVals': '가치관 목록',
      }
      if (careernetDesc[key]) return careernetDesc[key]
    }
    
    // Work24 Major 전용
    if (source === 'WORK24_MAJOR') {
      const work24Desc: Record<string, string> = {
        'majorGb': '학과구분(1:일반,2:이색)',
        'departmentId': '계열 ID',
        'majorId': '학과 ID',
        'departmentName': '계열명',
        'recruitmentStatus': '모집현황',
        'whatStudy': '하는 공부(이색학과)',
        'howPrepare': '준비방법(이색학과)',
        'jobProspect': '직업전망(이색학과)',
        'enrollmentQuota': '입학정원',
        'applicants': '지원자수',
        'graduates': '졸업자수',
        'universityType': '대학구분',
        'year': '연도',
        'url': '대학 URL',
      }
      if (work24Desc[key]) return work24Desc[key]
    }
    
    return key
  }
  
  // 데이터 추출
  extractFields(careernetSamples, 'CAREERNET')
  extractFields(work24MajorSamples, 'WORK24_MAJOR')
  
  // 미리 정의된 필드 목록
  // 정규화된 필드명 사용 (normalized_payload 기준)
  const predefinedFields: Array<{ source: string; path: string; description: string }> = [
    // CAREERNET 필드 (정규화된 필드명)
    { source: 'CAREERNET', path: 'name', description: '전공명' },
    { source: 'CAREERNET', path: 'categoryName', description: '관련학과(쉼표 구분 텍스트)' },
    { source: 'CAREERNET', path: 'summary', description: '학과 소개' },
    { source: 'CAREERNET', path: 'aptitude', description: '적성' },
    { source: 'CAREERNET', path: 'property', description: '학과 특성' },
    { source: 'CAREERNET', path: 'salaryAfterGraduation', description: '졸업 후 임금' },
    { source: 'CAREERNET', path: 'employmentRate', description: '취업률' },
    { source: 'CAREERNET', path: 'relatedJobs', description: '관련직업 배열' },
    { source: 'CAREERNET', path: 'universities', description: '개설대학 목록' },
    { source: 'CAREERNET', path: 'relateSubject', description: '고교 추천 교과목' },
    { source: 'CAREERNET', path: 'careerAct', description: '진로 탐색 활동' },
    { source: 'CAREERNET', path: 'enterField', description: '진출 분야' },
    { source: 'CAREERNET', path: 'mainSubject', description: '대학 주요 교과목' },
    { source: 'CAREERNET', path: 'chartData', description: '차트 데이터' },
    { source: 'CAREERNET', path: 'lstVals', description: '가치관 목록' },
    { source: 'CAREERNET', path: 'relatedMajors', description: '관련전공 배열' },
    
    // WORK24_MAJOR 필드
    { source: 'WORK24_MAJOR', path: 'majorGb', description: '학과구분(1:일반,2:이색)' },
    { source: 'WORK24_MAJOR', path: 'categoryId', description: '계열 ID' },
    { source: 'WORK24_MAJOR', path: 'categoryName', description: '계열명' },
    { source: 'WORK24_MAJOR', path: 'departmentId', description: '계열 ID' },
    { source: 'WORK24_MAJOR', path: 'majorId', description: '학과 ID' },
    { source: 'WORK24_MAJOR', path: 'departmentName', description: '계열명' },
    { source: 'WORK24_MAJOR', path: 'majorName', description: '전공명' },
    { source: 'WORK24_MAJOR', path: 'summary', description: '학과 소개' },
    { source: 'WORK24_MAJOR', path: 'aptitude', description: '적성/흥미' },
    { source: 'WORK24_MAJOR', path: 'relatedMajors', description: '관련학과' },
    { source: 'WORK24_MAJOR', path: 'mainSubjects', description: '주요교과목' },
    { source: 'WORK24_MAJOR', path: 'licenses', description: '취득 자격' },
    { source: 'WORK24_MAJOR', path: 'universities', description: '개설대학 목록' },
    { source: 'WORK24_MAJOR', path: 'recruitmentStatus', description: '모집현황' },
    { source: 'WORK24_MAJOR', path: 'relatedJobs', description: '관련직업' },
    { source: 'WORK24_MAJOR', path: 'whatStudy', description: '하는 공부(이색학과)' },
    { source: 'WORK24_MAJOR', path: 'howPrepare', description: '준비방법(이색학과)' },
    { source: 'WORK24_MAJOR', path: 'jobProspect', description: '직업전망(이색학과)' },
  ]
  
  // 미리 정의된 필드 중 누락된 것 추가
  predefinedFields.forEach(({ source, path, description }) => {
    const pathKey = `${source}.${path}`
    if (!fieldMap.has(pathKey)) {
      fieldMap.set(pathKey, {
        name: path.split('.').pop() || path,
        source,
        path,
        description,
        examples: [],
        type: 'unknown'
      })
    }
  })
  
  // 하위 필드가 있는 상위 객체 필드 제외
  const allFieldsRaw = Array.from(fieldMap.values())
  const fieldPaths = new Set(allFieldsRaw.map(f => `${f.source}.${f.path}`))
  
  const filteredByParent = allFieldsRaw.filter(field => {
    const fieldPath = `${field.source}.${field.path}`
    for (const otherPath of fieldPaths) {
      if (otherPath !== fieldPath && otherPath.startsWith(fieldPath + '.')) {
        return false
      }
    }
    return true
  })
  
  const allFields = filteredByParent
  
  // 출처별 색상
  const sourceColors: Record<string, { bg: string; border: string; text: string }> = {
    'CAREERNET': { bg: '#e8f5e9', border: '#4CAF50', text: '#2e7d32' },
    'WORK24_MAJOR': { bg: '#e3f2fd', border: '#2196F3', text: '#1565c0' }
  }
  
  // 출처별 한글명
  const sourceLabels: Record<string, string> = {
    'CAREERNET': '커리어넷 학과정보',
    'WORK24_MAJOR': '고용24 학과정보'
  }
  
  // 필드를 소스별로 그룹화
  const fieldsBySource: Record<string, FieldInfo[]> = {
    'CAREERNET': [],
    'WORK24_MAJOR': []
  }
  
  allFields.forEach(field => {
    if (fieldsBySource[field.source]) {
      fieldsBySource[field.source].push(field)
    }
  })
  
  // 필드 HTML 생성
  function renderFieldItem(field: FieldInfo): string {
    const colors = sourceColors[field.source]
    const pathKey = `${field.source}.${field.path}`
    const PREVIEW_LIMIT = 3
    const TRUNCATE_LENGTH = 120

    const hasLongExample = field.examples.some(
      (ex) => formatExampleValue(ex.value).length > TRUNCATE_LENGTH
    )
    const needsToggle = field.examples.length > PREVIEW_LIMIT || hasLongExample

    const renderExample = (ex: { value: any; majorName: string }, limit?: number) => {
      const content = formatExampleValue(ex.value, limit)
      const isExample = ex.majorName.startsWith('[예시]')
      const bgColor = isExample ? '#f5f5f5' : '#e8f5e9'
      const labelColor = isExample ? '#666' : '#2e7d32'
      return `
        <div class="field-example" style="border-left-color:${isExample ? '#ccc' : colors.border}; background:${bgColor};">
          <strong style="color:${labelColor};">${escapeHtml(ex.majorName)}:</strong>
          <span>${escapeHtml(content)}</span>
        </div>
      `
    }

    const previewExamples = (needsToggle ? field.examples.slice(0, PREVIEW_LIMIT) : field.examples)
      .map((ex) => renderExample(ex, needsToggle ? TRUNCATE_LENGTH : undefined))
      .join('')
      || '<div class="field-example-empty">예시 없음 (다른 전공에도 데이터가 없습니다)</div>'

    const fullExamples = needsToggle
      ? field.examples.map((ex) => renderExample(ex)).join('')
      : ''

    const exampleToggleButton = needsToggle
      ? `
        <button type="button" class="example-toggle" data-example-toggle="${pathKey}" data-expanded="false">
          <span class="example-toggle-text">예시 더보기</span>
          <span class="example-toggle-count">${field.examples.length}개</span>
          <i class="fas fa-chevron-down example-toggle-icon" aria-hidden="true"></i>
        </button>
      `
      : ''

    return `
      <div class="field-item" 
           draggable="true"
           data-path="${pathKey}"
           data-source="${field.source}"
           style="background:${colors.bg}; border-color:${colors.border};">
        <div class="field-item-header">
          <div class="field-item-title" style="color:${colors.text};">
            ${field.description}
          </div>
          <button type="button" class="field-toggle-btn" data-field-disable="${field.source}.${field.path}" data-state="active">
            사용 안함
          </button>
        </div>
        <div style="font-size:11px; color:#666; font-family:monospace;">
          ${field.source}.${field.path}
        </div>
        <div style="font-size:10px; color:#999; margin-top:4px;">
          타입: ${field.type} | 예시: ${field.examples.length}개
        </div>
        <div class="field-examples-wrapper">
          <div class="field-examples field-examples-preview" data-example-preview="${pathKey}">
            ${previewExamples}
          </div>
          ${
            needsToggle
              ? `<div class="field-examples field-examples-full" data-example-full="${pathKey}" style="display:none;">
                  ${fullExamples}
                </div>`
              : ''
          }
          ${exampleToggleButton}
        </div>
      </div>
    `
  }

  // 소스별 필드 목록 HTML
  const sourceGroupsHtml = Object.entries(fieldsBySource).map(([source, fields]) => {
    const colors = sourceColors[source]
    return `
      <div class="source-group" data-source="${source}">
        <h3 style="background:${colors.bg}; color:${colors.text}; border-left:4px solid ${colors.border};">
          ${sourceLabels[source]} 
          <span style="font-size:12px; font-weight:normal;">(${fields.length}개 필드)</span>
        </h3>
        <div class="field-list">
          ${fields.map(renderFieldItem).join('')}
        </div>
      </div>
    `
  }).join('')

  const fieldToggleStorageKey = `major-merge-designer:disable:${majorSlug || majorName || 'global'}`

  return `
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>${majorName ? `${majorName} - ` : ''}전공 템플릿 구조 설계</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body { 
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
      background: #f5f5f5;
      overflow: hidden;
    }
    
    .container { display: flex; height: 100vh; }
    
    .fields-panel {
      width: 35%;
      background: white;
      border-right: 1px solid #e0e0e0;
      overflow-y: auto;
      padding: 20px;
    }
    
    .fields-panel h2 {
      font-size: 18px;
      margin-bottom: 16px;
      color: #333;
      position: sticky;
      top: 0;
      background: white;
      padding: 8px 0;
      z-index: 10;
    }
    
    .search-box {
      width: 100%;
      padding: 8px 12px;
      border: 1px solid #ddd;
      border-radius: 4px;
      margin-bottom: 16px;
    }
    
    .source-group { margin-bottom: 24px; }
    
    .source-group h3 {
      font-size: 14px;
      padding: 10px 12px;
      border-radius: 4px;
      cursor: pointer;
      display: flex;
      justify-content: space-between;
      margin-bottom: 8px;
    }
    
    .source-group h3:hover { opacity: 0.8; }
    .source-group h3::after { content: '▼'; font-size: 10px; }
    .source-group.collapsed h3::after { transform: rotate(-90deg); display: inline-block; }
    .source-group.collapsed .field-list { display: none; }
    
    .field-item {
      padding: 10px;
      margin: 6px 0;
      border: 2px solid;
      border-radius: 6px;
      cursor: grab;
      transition: all 0.2s;
    }
    
    .field-item:hover {
      transform: translateX(4px);
      box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    }
    
    .field-item.dragging { opacity: 0.5; }
    
    .structure-panel {
      width: 65%;
      background: #fafafa;
      overflow-y: auto;
      padding: 20px;
    }
    
    .major-header {
      padding: 16px;
      background: linear-gradient(135deg, #1e3a5f 0%, #2d5a87 100%);
      border-radius: 12px;
      margin-bottom: 20px;
      color: white;
    }
    
    .major-header h1 {
      font-size: 24px;
      margin-bottom: 8px;
    }
    
    .major-header a {
      color: #93c5fd;
      text-decoration: none;
      font-size: 14px;
    }
    
    .major-header a:hover {
      text-decoration: underline;
    }
    
    .section {
      background: white;
      border: 2px solid #e0e0e0;
      border-radius: 12px;
      padding: 20px;
      margin-bottom: 20px;
    }
    
    .section-header {
      font-size: 18px;
      font-weight: 700;
      color: #1e3a5f;
      margin-bottom: 16px;
      padding-bottom: 12px;
      border-bottom: 2px solid #e0e0e0;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }
    
    .section-header i {
      margin-right: 8px;
      color: #3b82f6;
    }
    
    .subsections-container {
      display: flex;
      flex-direction: column;
      gap: 16px;
    }
    
    .subsection {
      background: #f9fafb;
      border: 1px solid #e5e7eb;
      border-radius: 8px;
      padding: 16px;
      transition: transform 0.2s, box-shadow 0.2s, opacity 0.2s;
    }
    
    .subsection.dragging {
      opacity: 0.5;
      transform: scale(0.98);
    }
    
    .subsection.drag-over {
      border: 2px dashed #3b82f6;
      background: #eff6ff;
    }
    
    .subsection-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 12px;
      gap: 8px;
    }
    
    .subsection-drag-handle {
      cursor: grab;
      padding: 4px 8px;
      color: #9ca3af;
      font-size: 16px;
      border-radius: 4px;
      transition: color 0.2s, background 0.2s;
    }
    
    .subsection-drag-handle:hover {
      color: #374151;
      background: #e5e7eb;
    }
    
    .subsection-drag-handle:active {
      cursor: grabbing;
    }
    
    .subsection-title-input {
      font-size: 14px;
      font-weight: 600;
      color: #374151;
      border: 1px solid #d1d5db;
      border-radius: 6px;
      padding: 6px 10px;
      background: white;
      flex: 1;
    }
    
    .subsection-title-input:focus {
      outline: none;
      border-color: #3b82f6;
      box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
    }
    
    .delete-subsection-btn {
      background: #fee2e2;
      border: 1px solid #fca5a5;
      color: #dc2626;
      font-size: 11px;
      padding: 6px 10px;
      border-radius: 6px;
      cursor: pointer;
      white-space: nowrap;
    }
    
    .delete-subsection-btn:hover {
      background: #fecaca;
    }
    
    .subsection-rule {
      width: 100%;
      min-height: 50px;
      padding: 10px;
      margin-top: 12px;
      border: 1px solid #fcd34d;
      border-radius: 6px;
      font-size: 12px;
      font-family: inherit;
      resize: vertical;
      background: #fefce8;
    }
    
    .subsection-rule::placeholder {
      color: #a1a1aa;
    }
    
    .add-subsection-btn {
      width: 100%;
      padding: 14px;
      margin-top: 12px;
      background: #f0fdf4;
      border: 2px dashed #86efac;
      border-radius: 8px;
      color: #16a34a;
      font-weight: 600;
      cursor: pointer;
      transition: all 0.2s;
    }
    
    .add-subsection-btn:hover {
      background: #dcfce7;
      border-color: #4ade80;
    }
    
    .drop-zone {
      min-height: 60px;
      border: 2px dashed #d1d5db;
      border-radius: 6px;
      padding: 10px;
      background: white;
      transition: all 0.2s;
    }
    
    .drop-zone.drag-over {
      border-color: #3b82f6;
      background: #eff6ff;
    }
    
    .drop-zone-placeholder {
      color: #9ca3af;
      font-size: 12px;
      text-align: center;
      padding: 10px;
    }
    
    .dropped-field {
      display: inline-flex;
      align-items: center;
      gap: 6px;
      padding: 6px 12px;
      margin: 4px;
      border-radius: 6px;
      font-size: 12px;
      font-weight: 500;
      border: 2px solid;
      cursor: pointer;
      position: relative;
    }
    
    .remove-field {
      width: 18px;
      height: 18px;
      background: #ef4444;
      color: white;
      border-radius: 50%;
      border: none;
      cursor: pointer;
      font-size: 12px;
      line-height: 18px;
      text-align: center;
      margin-left: 4px;
    }
    
    .remove-field:hover {
      background: #dc2626;
    }
    
    .export-section {
      background: white;
      border: 2px solid #e0e0e0;
      border-radius: 12px;
      padding: 20px;
      margin-top: 20px;
    }
    
    .export-button {
      width: 100%;
      padding: 14px;
      background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
      color: white;
      border: none;
      border-radius: 8px;
      font-weight: 600;
      cursor: pointer;
      font-size: 14px;
      transition: all 0.2s;
    }
    
    .export-button:hover {
      transform: translateY(-1px);
      box-shadow: 0 4px 12px rgba(245, 158, 11, 0.3);
    }
    
    .field-item-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      gap: 8px;
      margin-bottom: 4px;
    }

    .field-item-title {
      font-size: 13px;
      font-weight: 600;
    }

    .field-toggle-btn {
      border: 1px solid #d4d4d8;
      background: #fff;
      color: #4b5563;
      font-size: 11px;
      border-radius: 4px;
      padding: 3px 8px;
      cursor: pointer;
    }

    .field-item.disabled {
      opacity: 0.45;
      border-style: dashed;
      background: #f5f5f5 !important;
    }

    .field-examples-wrapper { margin-top: 6px; }

    .field-examples {
      display: flex;
      flex-direction: column;
      gap: 4px;
      margin-top: 4px;
    }

    .field-example {
      font-size: 11px;
      color: #444;
      padding: 4px 6px;
      background: #f9f9f9;
      border-radius: 4px;
      border-left: 2px solid #e5e7eb;
      word-break: break-all;
    }

    .field-example strong {
      color: #111827;
      font-weight: 600;
      margin-right: 4px;
    }

    .field-example-empty {
      font-size: 11px;
      color: #9ca3af;
      padding: 6px;
      background: #f3f4f6;
      border-radius: 4px;
      text-align: center;
    }

    .example-toggle {
      margin-top: 6px;
      display: inline-flex;
      align-items: center;
      gap: 6px;
      font-size: 11px;
      color: #2563eb;
      border: 1px solid #bfdbfe;
      background: #eff6ff;
      border-radius: 999px;
      padding: 4px 10px;
      cursor: pointer;
    }

    .example-toggle-icon { transition: transform 0.2s ease; }
    .example-toggle-icon.rotated { transform: rotate(180deg); }
    
    .bulk-toggle-container {
      display: flex;
      gap: 8px;
      margin-bottom: 12px;
      padding-bottom: 12px;
      border-bottom: 1px solid #e5e7eb;
    }
    
    .bulk-toggle-btn {
      font-size: 11px;
      padding: 4px 10px;
      border: 1px solid #d1d5db;
      background: white;
      color: #4b5563;
      border-radius: 4px;
      cursor: pointer;
    }
    
    .bulk-toggle-btn.active {
      background: #3b82f6;
      color: white;
      border-color: #3b82f6;
    }
    
    .tab-badges {
      display: flex;
      gap: 8px;
      margin-bottom: 16px;
    }
    
    .tab-badge {
      display: inline-flex;
      align-items: center;
      gap: 6px;
      padding: 8px 16px;
      border-radius: 999px;
      font-size: 13px;
      font-weight: 600;
      cursor: pointer;
      transition: all 0.2s;
    }
    
    .tab-badge.overview {
      background: #dbeafe;
      color: #1d4ed8;
      border: 2px solid #93c5fd;
    }
    
    .tab-badge.details {
      background: #fae8ff;
      color: #a21caf;
      border: 2px solid #e879f9;
    }
    
    .tab-badge.universities {
      background: #d1fae5;
      color: #047857;
      border: 2px solid #6ee7b7;
    }
    
    .stats-panel {
      background: #f8fafc;
      border: 1px solid #e2e8f0;
      border-radius: 8px;
      padding: 16px;
      margin-bottom: 20px;
    }
    
    .stats-row {
      display: flex;
      gap: 16px;
    }
    
    .stat-item {
      flex: 1;
      text-align: center;
      padding: 12px;
      background: white;
      border-radius: 8px;
      border: 1px solid #e2e8f0;
    }
    
    .stat-number {
      font-size: 24px;
      font-weight: 700;
      color: #1e3a5f;
    }
    
    .stat-label {
      font-size: 11px;
      color: #64748b;
      margin-top: 4px;
    }
  </style>
</head>
<body>
  <div class="container">
    <div class="fields-panel">
      <h2>📦 사용 가능한 필드 
        <span style="font-size:12px; color:#999;">
          (총 ${allFields.length}개)
        </span>
      </h2>
      <input type="text" class="search-box" id="searchBox" placeholder="필드 검색...">
      
      <div class="bulk-toggle-container">
        <button class="bulk-toggle-btn active" onclick="toggleAllFields(true)" id="enableAllBtn">전체 사용</button>
        <button class="bulk-toggle-btn" onclick="toggleAllFields(false)" id="disableAllBtn">전체 사용 안함</button>
      </div>
      
      ${sourceGroupsHtml}
    </div>
    
    <div class="structure-panel">
      ${majorName ? `
        <div class="major-header">
          <h1><i class="fas fa-graduation-cap"></i> ${escapeHtml(majorName)}</h1>
          <a href="/major/${majorSlug ? encodeURIComponent(majorSlug) : encodeURIComponent(majorName)}" target="_blank">
            <i class="fas fa-external-link-alt"></i> 실제 전공 페이지 보기
          </a>
        </div>
      ` : ''}
      
      <div class="stats-panel">
        <div class="stats-row">
          <div class="stat-item">
            <div class="stat-number" id="stat-careernet">0</div>
            <div class="stat-label">커리어넷 필드</div>
          </div>
          <div class="stat-item">
            <div class="stat-number" id="stat-work24major">0</div>
            <div class="stat-label">고용24 필드</div>
          </div>
          <div class="stat-item">
            <div class="stat-number" id="stat-total">0</div>
            <div class="stat-label">전체 사용 필드</div>
          </div>
        </div>
      </div>
      
      <!-- 1. 히어로 섹션 -->
      <div class="section" data-section-type="hero">
        <div class="section-header">
          <span><i class="fas fa-star"></i> 1. 히어로 섹션</span>
        </div>
        <div class="subsections-container" data-section="hero">
          <div class="subsection" data-subsection-id="hero-category">
            <div class="subsection-header">
              <input type="text" class="subsection-title-input" value="1.1 계열 배지" data-title-for="hero-category">
              <button class="delete-subsection-btn" onclick="deleteSubsection(this)"><i class="fas fa-trash"></i> 삭제</button>
            </div>
            <div class="drop-zone" data-section="hero-category">
              <div class="drop-zone-placeholder">필드를 여기에 드래그하세요</div>
            </div>
            <textarea class="subsection-rule" placeholder="규칙: 예) WORK24_MAJOR.categoryName 우선 사용, 없으면 CAREERNET.department에서 추출" data-rule-for="hero-category"></textarea>
          </div>
          
          <div class="subsection" data-subsection-id="hero-name">
            <div class="subsection-header">
              <input type="text" class="subsection-title-input" value="1.2 전공명" data-title-for="hero-name">
              <button class="delete-subsection-btn" onclick="deleteSubsection(this)"><i class="fas fa-trash"></i> 삭제</button>
            </div>
            <div class="drop-zone" data-section="hero-name">
              <div class="drop-zone-placeholder">필드를 여기에 드래그하세요</div>
            </div>
            <textarea class="subsection-rule" placeholder="규칙: 예) WORK24_MAJOR.majorName 또는 CAREERNET.major" data-rule-for="hero-name"></textarea>
          </div>
          
          <div class="subsection" data-subsection-id="hero-summary">
            <div class="subsection-header">
              <input type="text" class="subsection-title-input" value="1.3 학과 소개 (히어로 설명)" data-title-for="hero-summary">
              <button class="delete-subsection-btn" onclick="deleteSubsection(this)"><i class="fas fa-trash"></i> 삭제</button>
            </div>
            <div class="drop-zone" data-section="hero-summary">
              <div class="drop-zone-placeholder">필드를 여기에 드래그하세요</div>
            </div>
            <textarea class="subsection-rule" placeholder="규칙: 예) summary 첫 번째 줄만 사용" data-rule-for="hero-summary"></textarea>
          </div>
          
          <div class="subsection" data-subsection-id="hero-image">
            <div class="subsection-header">
              <input type="text" class="subsection-title-input" value="1.4 히어로 이미지" data-title-for="hero-image">
              <button class="delete-subsection-btn" onclick="deleteSubsection(this)"><i class="fas fa-trash"></i> 삭제</button>
            </div>
            <div class="drop-zone" data-section="hero-image">
              <div class="drop-zone-placeholder">필드를 여기에 드래그하세요</div>
            </div>
            <textarea class="subsection-rule" placeholder="규칙: 예) 전공명으로 이미지 생성 (추후 구현)" data-rule-for="hero-image"></textarea>
          </div>
          
          <div class="subsection" data-subsection-id="hero-tags">
            <div class="subsection-header">
              <input type="text" class="subsection-title-input" value="1.5 태그 영역 (유사 전공)" data-title-for="hero-tags">
              <button class="delete-subsection-btn" onclick="deleteSubsection(this)"><i class="fas fa-trash"></i> 삭제</button>
            </div>
            <div class="drop-zone" data-section="hero-tags">
              <div class="drop-zone-placeholder">필드를 여기에 드래그하세요</div>
            </div>
            <textarea class="subsection-rule" placeholder="규칙: 예) relatedMajors + universities.department 병합, 최대 10개" data-rule-for="hero-tags"></textarea>
          </div>
          
          <button class="add-subsection-btn" onclick="addSubsection('hero')">
            <i class="fas fa-plus"></i> 서브섹션 추가
          </button>
        </div>
      </div>
      
      <!-- 2. 탭 영역 -->
      <div class="tab-badges">
        <span class="tab-badge overview"><i class="fas fa-circle-info"></i> 개요</span>
        <span class="tab-badge details"><i class="fas fa-layer-group"></i> 상세정보</span>
        <span class="tab-badge universities"><i class="fas fa-building-columns"></i> 대학정보</span>
      </div>
      
      <!-- 2.1 개요 탭 -->
      <div class="section" data-section-type="overview">
        <div class="section-header">
          <span><i class="fas fa-circle-info"></i> 2.1 개요 탭</span>
        </div>
        <div class="subsections-container" data-section="overview">
          <div class="subsection" data-subsection-id="overview-summary">
            <div class="subsection-header">
              <input type="text" class="subsection-title-input" value="2.1.1 전공 개요" data-title-for="overview-summary">
              <button class="delete-subsection-btn" onclick="deleteSubsection(this)"><i class="fas fa-trash"></i> 삭제</button>
            </div>
            <div class="drop-zone" data-section="overview-summary">
              <div class="drop-zone-placeholder">필드를 여기에 드래그하세요</div>
            </div>
            <textarea class="subsection-rule" placeholder="규칙: 예) CAREERNET.summary 우선, 없으면 WORK24_MAJOR.summary" data-rule-for="overview-summary"></textarea>
          </div>
          
          <div class="subsection" data-subsection-id="overview-property">
            <div class="subsection-header">
              <input type="text" class="subsection-title-input" value="2.1.2 전공 특성" data-title-for="overview-property">
              <button class="delete-subsection-btn" onclick="deleteSubsection(this)"><i class="fas fa-trash"></i> 삭제</button>
            </div>
            <div class="drop-zone" data-section="overview-property">
              <div class="drop-zone-placeholder">필드를 여기에 드래그하세요</div>
            </div>
            <textarea class="subsection-rule" placeholder="규칙: 예) CAREERNET.property" data-rule-for="overview-property"></textarea>
          </div>
          
          <div class="subsection" data-subsection-id="overview-aptitude">
            <div class="subsection-header">
              <input type="text" class="subsection-title-input" value="2.1.3 이 전공에 어울리는 사람" data-title-for="overview-aptitude">
              <button class="delete-subsection-btn" onclick="deleteSubsection(this)"><i class="fas fa-trash"></i> 삭제</button>
            </div>
            <div class="drop-zone" data-section="overview-aptitude">
              <div class="drop-zone-placeholder">필드를 여기에 드래그하세요</div>
            </div>
            <textarea class="subsection-rule" placeholder="규칙: 예) CAREERNET.aptitude 또는 WORK24_MAJOR.aptitude" data-rule-for="overview-aptitude"></textarea>
          </div>
          
          <div class="subsection" data-subsection-id="overview-enterField">
            <div class="subsection-header">
              <input type="text" class="subsection-title-input" value="2.1.4 졸업 후 진출 분야" data-title-for="overview-enterField">
              <button class="delete-subsection-btn" onclick="deleteSubsection(this)"><i class="fas fa-trash"></i> 삭제</button>
            </div>
            <div class="drop-zone" data-section="overview-enterField">
              <div class="drop-zone-placeholder">필드를 여기에 드래그하세요</div>
            </div>
            <textarea class="subsection-rule" placeholder="규칙: 예) CAREERNET.enter_field" data-rule-for="overview-enterField"></textarea>
          </div>
          
          <div class="subsection" data-subsection-id="overview-metrics">
            <div class="subsection-header">
              <input type="text" class="subsection-title-input" value="2.1.5 핵심 지표" data-title-for="overview-metrics">
              <button class="delete-subsection-btn" onclick="deleteSubsection(this)"><i class="fas fa-trash"></i> 삭제</button>
            </div>
            <div class="drop-zone" data-section="overview-metrics">
              <div class="drop-zone-placeholder">필드를 여기에 드래그하세요</div>
            </div>
            <textarea class="subsection-rule" placeholder="규칙: 예) salary, employmentRate, categoryName 등" data-rule-for="overview-metrics"></textarea>
          </div>
          
          <button class="add-subsection-btn" onclick="addSubsection('overview')">
            <i class="fas fa-plus"></i> 서브섹션 추가
          </button>
        </div>
      </div>
      
      <!-- 2.2 상세정보 탭 -->
      <div class="section" data-section-type="details">
        <div class="section-header">
          <span><i class="fas fa-layer-group"></i> 2.2 상세정보 탭</span>
        </div>
        <div class="subsections-container" data-section="details">
          <div class="subsection" data-subsection-id="details-whatStudy">
            <div class="subsection-header">
              <input type="text" class="subsection-title-input" value="2.2.1 하는 공부" data-title-for="details-whatStudy">
              <button class="delete-subsection-btn" onclick="deleteSubsection(this)"><i class="fas fa-trash"></i> 삭제</button>
            </div>
            <div class="drop-zone" data-section="details-whatStudy">
              <div class="drop-zone-placeholder">필드를 여기에 드래그하세요</div>
            </div>
            <textarea class="subsection-rule" placeholder="규칙: 예) WORK24_MAJOR.whatStudy" data-rule-for="details-whatStudy"></textarea>
          </div>
          
          <div class="subsection" data-subsection-id="details-howPrepare">
            <div class="subsection-header">
              <input type="text" class="subsection-title-input" value="2.2.2 준비 방법" data-title-for="details-howPrepare">
              <button class="delete-subsection-btn" onclick="deleteSubsection(this)"><i class="fas fa-trash"></i> 삭제</button>
            </div>
            <div class="drop-zone" data-section="details-howPrepare">
              <div class="drop-zone-placeholder">필드를 여기에 드래그하세요</div>
            </div>
            <textarea class="subsection-rule" placeholder="규칙: 예) WORK24_MAJOR.howPrepare" data-rule-for="details-howPrepare"></textarea>
          </div>
          
          <div class="subsection" data-subsection-id="details-mainSubjects">
            <div class="subsection-header">
              <input type="text" class="subsection-title-input" value="2.2.3 주요 교과목" data-title-for="details-mainSubjects">
              <button class="delete-subsection-btn" onclick="deleteSubsection(this)"><i class="fas fa-trash"></i> 삭제</button>
            </div>
            <div class="drop-zone" data-section="details-mainSubjects">
              <div class="drop-zone-placeholder">필드를 여기에 드래그하세요</div>
            </div>
            <textarea class="subsection-rule" placeholder="규칙: 예) mainSubjects(기초/심화 구분), main_subject(대학 교과목), relate_subject(고교 추천)" data-rule-for="details-mainSubjects"></textarea>
          </div>
          
          <div class="subsection" data-subsection-id="details-jobProspect">
            <div class="subsection-header">
              <input type="text" class="subsection-title-input" value="2.2.4 진로 전망" data-title-for="details-jobProspect">
              <button class="delete-subsection-btn" onclick="deleteSubsection(this)"><i class="fas fa-trash"></i> 삭제</button>
            </div>
            <div class="drop-zone" data-section="details-jobProspect">
              <div class="drop-zone-placeholder">필드를 여기에 드래그하세요</div>
            </div>
            <textarea class="subsection-rule" placeholder="규칙: 예) WORK24_MAJOR.jobProspect" data-rule-for="details-jobProspect"></textarea>
          </div>
          
          <div class="subsection" data-subsection-id="details-careerAct">
            <div class="subsection-header">
              <input type="text" class="subsection-title-input" value="2.2.5 진로 탐색 활동" data-title-for="details-careerAct">
              <button class="delete-subsection-btn" onclick="deleteSubsection(this)"><i class="fas fa-trash"></i> 삭제</button>
            </div>
            <div class="drop-zone" data-section="details-careerAct">
              <div class="drop-zone-placeholder">필드를 여기에 드래그하세요</div>
            </div>
            <textarea class="subsection-rule" placeholder="규칙: 예) CAREERNET.career_act" data-rule-for="details-careerAct"></textarea>
          </div>
          
          <button class="add-subsection-btn" onclick="addSubsection('details')">
            <i class="fas fa-plus"></i> 서브섹션 추가
          </button>
        </div>
      </div>
      
      <!-- 2.3 대학정보 탭 -->
      <div class="section" data-section-type="universities">
        <div class="section-header">
          <span><i class="fas fa-building-columns"></i> 2.3 대학정보 탭</span>
        </div>
        <div class="subsections-container" data-section="universities">
          <div class="subsection" data-subsection-id="universities-list">
            <div class="subsection-header">
              <input type="text" class="subsection-title-input" value="2.3.1 개설 대학" data-title-for="universities-list">
              <button class="delete-subsection-btn" onclick="deleteSubsection(this)"><i class="fas fa-trash"></i> 삭제</button>
            </div>
            <div class="drop-zone" data-section="universities-list">
              <div class="drop-zone-placeholder">필드를 여기에 드래그하세요</div>
            </div>
            <textarea class="subsection-rule" placeholder="규칙: 예) universities 배열, 지역별 분포 지도 표시" data-rule-for="universities-list"></textarea>
          </div>
          
          <div class="subsection" data-subsection-id="universities-recruitment">
            <div class="subsection-header">
              <input type="text" class="subsection-title-input" value="2.3.2 모집현황 & 지원 현황" data-title-for="universities-recruitment">
              <button class="delete-subsection-btn" onclick="deleteSubsection(this)"><i class="fas fa-trash"></i> 삭제</button>
            </div>
            <div class="drop-zone" data-section="universities-recruitment">
              <div class="drop-zone-placeholder">필드를 여기에 드래그하세요</div>
            </div>
            <textarea class="subsection-rule" placeholder="규칙: 예) recruitmentStatus 테이블로 표시" data-rule-for="universities-recruitment"></textarea>
          </div>
          
          <button class="add-subsection-btn" onclick="addSubsection('universities')">
            <i class="fas fa-plus"></i> 서브섹션 추가
          </button>
        </div>
      </div>
      
      <!-- 3. 사이드바 -->
      <div class="section" data-section-type="sidebar">
        <div class="section-header">
          <span><i class="fas fa-bars"></i> 3. 사이드바</span>
        </div>
        <div class="subsections-container" data-section="sidebar">
          <div class="subsection" data-subsection-id="sidebar-relatedJobs">
            <div class="subsection-header">
              <input type="text" class="subsection-title-input" value="3.1 관련 직업" data-title-for="sidebar-relatedJobs">
              <button class="delete-subsection-btn" onclick="deleteSubsection(this)"><i class="fas fa-trash"></i> 삭제</button>
            </div>
            <div class="drop-zone" data-section="sidebar-relatedJobs">
              <div class="drop-zone-placeholder">필드를 여기에 드래그하세요</div>
            </div>
            <textarea class="subsection-rule" placeholder="규칙: 예) relatedJobs 배열, 5개 이상이면 더보기" data-rule-for="sidebar-relatedJobs"></textarea>
          </div>
          
          <div class="subsection" data-subsection-id="sidebar-licenses">
            <div class="subsection-header">
              <input type="text" class="subsection-title-input" value="3.2 추천 자격증" data-title-for="sidebar-licenses">
              <button class="delete-subsection-btn" onclick="deleteSubsection(this)"><i class="fas fa-trash"></i> 삭제</button>
            </div>
            <div class="drop-zone" data-section="sidebar-licenses">
              <div class="drop-zone-placeholder">필드를 여기에 드래그하세요</div>
            </div>
            <textarea class="subsection-rule" placeholder="규칙: 예) licenses + qualifications 병합, 계층 구조 표시" data-rule-for="sidebar-licenses"></textarea>
          </div>
          
          <button class="add-subsection-btn" onclick="addSubsection('sidebar')">
            <i class="fas fa-plus"></i> 서브섹션 추가
          </button>
        </div>
      </div>
      
      <!-- Export -->
      <div class="export-section">
        <button class="export-button" onclick="exportConfig()">
          <i class="fas fa-copy"></i> JSON 구성 복사하기
        </button>
      </div>
    </div>
  </div>
  
  <script>
    const sourceColors = ${JSON.stringify(sourceColors)};
    const sectionData = new Map();
    const subsectionRules = new Map();
    const subsectionTitles = new Map();
    const FIELD_TOGGLE_KEY = ${JSON.stringify(fieldToggleStorageKey)};
    const disabledFieldSet = new Set();
    let subsectionCounter = 100;
    
    // 현재 unifiedMajorDetail.ts에서 실제로 사용하는 필드들 (기본값)
    // 분석 기준: src/templates/unifiedMajorDetail.ts
    // 소스: CAREERNET, WORK24_MAJOR
    const defaultSectionData = {
      // 히어로 섹션
      'hero-category': ['WORK24_MAJOR.categoryName', 'WORK24_MAJOR.departmentName'],
      'hero-name': ['CAREERNET.name', 'WORK24_MAJOR.name', 'WORK24_MAJOR.majorName'],
      'hero-summary': ['WORK24_MAJOR.summary', 'CAREERNET.summary'],
      'hero-image': [],  // renderHeroImage(profile.name) - 자동 생성
      'hero-tags': ['CAREERNET.department', 'WORK24_MAJOR.relatedMajors'],
      
      // 개요 탭
      'overview-summary': ['WORK24_MAJOR.summary', 'CAREERNET.summary'],
      'overview-property': ['CAREERNET.property'],
      'overview-aptitude': ['WORK24_MAJOR.aptitude', 'CAREERNET.aptitude', 'CAREERNET.interest'],
      'overview-enterField': ['CAREERNET.enter_field'],
      'overview-metrics': ['CAREERNET.salary', 'CAREERNET.employment', 'CAREERNET.employmentRate', 'CAREERNET.salaryAfterGraduation'],
      
      // 상세정보 탭
      'details-whatStudy': ['WORK24_MAJOR.whatStudy'],
      'details-howPrepare': ['WORK24_MAJOR.howPrepare'],
      'details-mainSubjects': ['WORK24_MAJOR.mainSubjects', 'CAREERNET.main_subject', 'CAREERNET.relate_subject'],
      'details-jobProspect': ['WORK24_MAJOR.jobProspect'],
      'details-careerAct': ['CAREERNET.career_act'],
      
      // 대학정보 탭
      'universities-list': ['WORK24_MAJOR.universities', 'CAREERNET.universityList', 'CAREERNET.university'],
      'universities-recruitment': ['WORK24_MAJOR.recruitmentStatus'],
      'universities-chartData': ['CAREERNET.chartData'],
      
      // 사이드바
      'sidebar-relatedJobs': ['WORK24_MAJOR.relatedJobs', 'CAREERNET.relatedJob', 'CAREERNET.job'],
      'sidebar-licenses': ['WORK24_MAJOR.licenses', 'CAREERNET.qualifications']
    };
    
    // 기본 규칙 (unifiedMajorDetail.ts 분석 기반)
    const defaultRules = {
      'hero-category': 'categoryName 사용. 쉼표 2개 이상이면 관련 학과 리스트로 판단하여 미표시',
      'hero-name': 'name 사용 (필수 필드) 둘 중 더 길거나 복잡한 것 사용',
      'hero-summary': '고용24 summary 우선, 없으면 CAREERNET summary 사용. 첫 문장만(마침표 기준)',
      'hero-image': 'renderHeroImage(name)으로 자동 생성 (차후 구현)',
      'hero-tags': 'relatedMajors + department 병합, 중복 제거',
      'overview-summary': '고용24/커리어넷 둘 다 있으면 히어로에서 안쓴 데이터 사용, 하나만 있으면 전체 사용',
      'overview-property': 'property 사용 (전공 특성)',
      'overview-aptitude': '커리어넷 우선. aptitude와 interest 같으면 하나만, 다르면 더 긴 쪽 사용',
      'overview-enterField': 'enterField 배열. gradeuate(진출분야명) + description(설명) 구조',
      'overview-metrics': 'salary/salaryAfterGraduation, employment/employmentRate. 동일 값 중복 제거',
      'details-whatStudy': 'whatStudy (이색학과 전용 필드, 일반학과는 없을 수 있음)',
      'details-howPrepare': 'howPrepare (이색학과 전용 필드)',
      'details-mainSubjects': 'mainSubjects(고용24) + mainSubject/relateSubject(커리어넷) 병합. 교과목 중복 제거',
      'details-jobProspect': 'jobProspect 사용 (고용24)',
      'details-careerAct': 'career_act 사용 (커리어넷)',
      'universities-list': 'universities(고용24) + universityList/university(커리어넷) 병합',
      'universities-recruitment': 'recruitmentStatus 사용 (고용24)',
      'universities-chartData': 'chartData 사용 (커리어넷)',
      'sidebar-relatedJobs': 'relatedJobs + CAREERNET relatedJob/job 병합, 중복 제거',
      'sidebar-licenses': 'licenses(고용24) + qualifications(커리어넷) 병합'
    };
    
    function applyFieldState(path, disabled) {
      const fieldEl = document.querySelector(\`.field-item[data-path="\${path}"]\`);
      if (!fieldEl) return;
      const toggleBtn = fieldEl.querySelector(\`[data-field-disable="\${path}"]\`);
      if (disabled) {
        fieldEl.classList.add('disabled');
        fieldEl.setAttribute('draggable', 'false');
        if (toggleBtn) toggleBtn.textContent = '사용 중으로 전환';
      } else {
        fieldEl.classList.remove('disabled');
        fieldEl.setAttribute('draggable', 'true');
        if (toggleBtn) toggleBtn.textContent = '사용 안함';
      }
    }
    
    function toggleAllFields(enable) {
      document.querySelectorAll('.field-item').forEach(item => {
        const path = item.dataset.path;
        if (!path) return;
        if (enable) {
          disabledFieldSet.delete(path);
          applyFieldState(path, false);
        } else {
          disabledFieldSet.add(path);
          applyFieldState(path, true);
        }
      });
      localStorage.setItem(FIELD_TOGGLE_KEY, JSON.stringify(Array.from(disabledFieldSet)));
    }

    function initializeFieldToggles() {
      let saved;
      try {
        saved = JSON.parse(localStorage.getItem(FIELD_TOGGLE_KEY) || '[]');
      } catch {
        saved = [];
      }
      saved.forEach(path => {
        disabledFieldSet.add(path);
        applyFieldState(path, true);
      });

      document.querySelectorAll('[data-field-disable]').forEach(button => {
        button.addEventListener('click', (event) => {
          event.stopPropagation();
          const path = button.dataset.fieldDisable;
          const isDisabled = disabledFieldSet.has(path);
          if (isDisabled) {
            disabledFieldSet.delete(path);
          } else {
            disabledFieldSet.add(path);
          }
          applyFieldState(path, !isDisabled);
          localStorage.setItem(FIELD_TOGGLE_KEY, JSON.stringify(Array.from(disabledFieldSet)));
        });
      });
    }

    function initializeExampleToggles() {
      document.querySelectorAll('[data-example-toggle]').forEach(button => {
        button.addEventListener('click', () => {
          const path = button.getAttribute('data-example-toggle');
          if (!path) return;
          const preview = document.querySelector('[data-example-preview="' + path + '"]');
          const full = document.querySelector('[data-example-full="' + path + '"]');
          if (!preview || !full) return;
          const isExpanded = button.getAttribute('data-expanded') === 'true';
          if (isExpanded) {
            preview.style.display = '';
            full.style.display = 'none';
            button.setAttribute('data-expanded', 'false');
            const text = button.querySelector('.example-toggle-text');
            const icon = button.querySelector('.example-toggle-icon');
            if (text) text.textContent = '예시 더보기';
            if (icon) icon.classList.remove('rotated');
          } else {
            preview.style.display = 'none';
            full.style.display = 'flex';
            button.setAttribute('data-expanded', 'true');
            const text = button.querySelector('.example-toggle-text');
            const icon = button.querySelector('.example-toggle-icon');
            if (text) text.textContent = '예시 접기';
            if (icon) icon.classList.add('rotated');
          }
        });
      });
    }
    
    function addSubsection(parentSection) {
      const container = document.querySelector(\`[data-section="\${parentSection}"]\`);
      if (!container) return;
      
      const addBtn = container.querySelector('.add-subsection-btn');
      const subsectionId = \`\${parentSection}-custom-\${subsectionCounter++}\`;
      
      const subsection = document.createElement('div');
      subsection.className = 'subsection';
      subsection.dataset.subsectionId = subsectionId;
      subsection.innerHTML = \`
        <div class="subsection-header">
          <input type="text" class="subsection-title-input" value="새 서브섹션" data-title-for="\${subsectionId}">
          <button class="delete-subsection-btn" onclick="deleteSubsection(this)"><i class="fas fa-trash"></i> 삭제</button>
        </div>
        <div class="drop-zone" data-section="\${subsectionId}">
          <div class="drop-zone-placeholder">필드를 여기에 드래그하세요</div>
        </div>
        <textarea class="subsection-rule" placeholder="규칙을 입력하세요..." data-rule-for="\${subsectionId}"></textarea>
      \`;
      
      container.insertBefore(subsection, addBtn);
      initializeDropZone(subsection.querySelector('.drop-zone'));
    }
    
    function deleteSubsection(btn) {
      const subsection = btn.closest('.subsection');
      if (subsection) {
        const subsectionId = subsection.dataset.subsectionId;
        sectionData.delete(subsectionId);
        subsection.remove();
        updateStats();
      }
    }
    
    function initializeDropZone(zone) {
      zone.addEventListener('dragover', (e) => {
        e.preventDefault();
        zone.classList.add('drag-over');
      });
      zone.addEventListener('dragleave', () => zone.classList.remove('drag-over'));
      zone.addEventListener('drop', handleDrop);
    }
    
    function handleDrop(e) {
      e.preventDefault();
      const zone = e.currentTarget;
      zone.classList.remove('drag-over');
      
      const fieldPath = e.dataTransfer.getData('text/plain');
      const source = fieldPath.split('.')[0];
      const colors = sourceColors[source];
      
      const sectionId = zone.dataset.section;
      if (!sectionData.has(sectionId)) {
        sectionData.set(sectionId, []);
      }
      
      // 중복 체크
      if (sectionData.get(sectionId).includes(fieldPath)) {
        return;
      }
      
      sectionData.get(sectionId).push(fieldPath);
      
      // placeholder 제거
      const placeholder = zone.querySelector('.drop-zone-placeholder');
      if (placeholder) placeholder.remove();
      
      const fieldEl = document.createElement('div');
      fieldEl.className = 'dropped-field';
      fieldEl.style.background = colors.bg;
      fieldEl.style.borderColor = colors.border;
      fieldEl.style.color = colors.text;
      
      const fieldText = document.createElement('span');
      fieldText.textContent = fieldPath;
      fieldEl.appendChild(fieldText);
      
      const removeBtn = document.createElement('button');
      removeBtn.className = 'remove-field';
      removeBtn.textContent = '×';
      removeBtn.onclick = () => {
        fieldEl.remove();
        const fields = sectionData.get(sectionId);
        const idx = fields.indexOf(fieldPath);
        if (idx > -1) fields.splice(idx, 1);
        
        // placeholder 복원
        if (fields.length === 0) {
          const newPlaceholder = document.createElement('div');
          newPlaceholder.className = 'drop-zone-placeholder';
          newPlaceholder.textContent = '필드를 여기에 드래그하세요';
          zone.appendChild(newPlaceholder);
        }
        
        updateStats();
      };
      
      fieldEl.appendChild(removeBtn);
      zone.appendChild(fieldEl);
      updateStats();
    }

    document.addEventListener('DOMContentLoaded', () => {
      initializeFieldToggles();
      initializeExampleToggles();
      
      // 드롭 영역 초기화
      document.querySelectorAll('.drop-zone').forEach(initializeDropZone);
      
      // 서브섹션 드래그 앤 드롭 초기화
      initializeSubsectionDrag();
      
      // 기본값 채우기
      loadDefaultValues();
    });
    
    // 서브섹션 드래그 앤 드롭 기능
    let draggedSubsection = null;
    
    function initializeSubsectionDrag() {
      // 모든 서브섹션에 드래그 핸들 추가
      document.querySelectorAll('.subsection').forEach(subsection => {
        // 이미 핸들이 있으면 스킵
        if (subsection.querySelector('.subsection-drag-handle')) return;
        
        // draggable 속성 추가
        subsection.setAttribute('draggable', 'true');
        
        // 드래그 핸들 추가
        const header = subsection.querySelector('.subsection-header');
        if (header) {
          const handle = document.createElement('span');
          handle.className = 'subsection-drag-handle';
          handle.title = '드래그하여 순서 변경';
          handle.innerHTML = '<i class="fas fa-grip-vertical"></i>';
          header.insertBefore(handle, header.firstChild);
        }
        
        // 드래그 이벤트 등록
        subsection.addEventListener('dragstart', handleSubsectionDragStart);
        subsection.addEventListener('dragend', handleSubsectionDragEnd);
        subsection.addEventListener('dragover', handleSubsectionDragOver);
        subsection.addEventListener('dragleave', handleSubsectionDragLeave);
        subsection.addEventListener('drop', handleSubsectionDrop);
      });
    }
    
    function handleSubsectionDragStart(e) {
      // 드래그 핸들에서만 드래그 시작 허용
      if (!e.target.closest('.subsection-drag-handle') && e.target.className !== 'subsection') {
        // 핸들이 아닌 곳에서 드래그 시작하면 취소
        if (!e.target.classList.contains('subsection')) {
          e.preventDefault();
          return;
        }
      }
      
      draggedSubsection = e.target.closest('.subsection');
      if (draggedSubsection) {
        draggedSubsection.classList.add('dragging');
        e.dataTransfer.effectAllowed = 'move';
        e.dataTransfer.setData('text/plain', draggedSubsection.dataset.subsectionId);
      }
    }
    
    function handleSubsectionDragEnd(e) {
      if (draggedSubsection) {
        draggedSubsection.classList.remove('dragging');
      }
      document.querySelectorAll('.subsection.drag-over').forEach(el => {
        el.classList.remove('drag-over');
      });
      draggedSubsection = null;
    }
    
    function handleSubsectionDragOver(e) {
      e.preventDefault();
      const subsection = e.target.closest('.subsection');
      if (subsection && subsection !== draggedSubsection) {
        // 같은 컨테이너 안에서만 허용
        if (draggedSubsection && subsection.parentElement === draggedSubsection.parentElement) {
          subsection.classList.add('drag-over');
          e.dataTransfer.dropEffect = 'move';
        }
      }
    }
    
    function handleSubsectionDragLeave(e) {
      const subsection = e.target.closest('.subsection');
      if (subsection) {
        subsection.classList.remove('drag-over');
      }
    }
    
    function handleSubsectionDrop(e) {
      e.preventDefault();
      const targetSubsection = e.target.closest('.subsection');
      
      if (targetSubsection && draggedSubsection && targetSubsection !== draggedSubsection) {
        // 같은 컨테이너 안에서만 이동
        if (targetSubsection.parentElement === draggedSubsection.parentElement) {
          const container = targetSubsection.parentElement;
          const allSubsections = Array.from(container.querySelectorAll('.subsection'));
          const draggedIndex = allSubsections.indexOf(draggedSubsection);
          const targetIndex = allSubsections.indexOf(targetSubsection);
          
          if (draggedIndex < targetIndex) {
            // 아래로 이동
            targetSubsection.after(draggedSubsection);
          } else {
            // 위로 이동
            targetSubsection.before(draggedSubsection);
          }
          
          // 번호 재정렬
          renumberSubsections(container);
        }
      }
      
      targetSubsection?.classList.remove('drag-over');
    }
    
    function renumberSubsections(container) {
      const sectionType = container.dataset.section;
      const subsections = container.querySelectorAll('.subsection');
      
      // 섹션 타입에 따른 접두사 결정
      const prefixMap = {
        'hero': '1',
        'overview': '2.1',
        'details': '2.2',
        'universities': '2.3',
        'sidebar': '3'
      };
      
      const prefix = prefixMap[sectionType] || '0';
      
      subsections.forEach((subsection, index) => {
        const input = subsection.querySelector('.subsection-title-input');
        if (input) {
          const currentTitle = input.value;
          // 기존 번호 패턴 제거하고 새 번호 추가
          const titleWithoutNumber = currentTitle.replace(/^[\\d.]+\\s*/, '');
          input.value = \`\${prefix}.\${index + 1} \${titleWithoutNumber}\`;
        }
      });
    }
    
    function loadDefaultValues() {
      // 각 섹션에 기본 필드 채우기
      Object.entries(defaultSectionData).forEach(([sectionId, fields]) => {
        const zone = document.querySelector(\`[data-section="\${sectionId}"]\`);
        if (!zone) return;
        
        fields.forEach(fieldPath => {
          const source = fieldPath.split('.')[0];
          const colors = sourceColors[source];
          if (!colors) return;
          
          if (!sectionData.has(sectionId)) {
            sectionData.set(sectionId, []);
          }
          
          // 중복 체크
          if (sectionData.get(sectionId).includes(fieldPath)) return;
          
          sectionData.get(sectionId).push(fieldPath);
          
          // placeholder 제거
          const placeholder = zone.querySelector('.drop-zone-placeholder');
          if (placeholder) placeholder.remove();
          
          const fieldEl = document.createElement('div');
          fieldEl.className = 'dropped-field';
          fieldEl.style.background = colors.bg;
          fieldEl.style.borderColor = colors.border;
          fieldEl.style.color = colors.text;
          
          const fieldText = document.createElement('span');
          fieldText.textContent = fieldPath;
          fieldEl.appendChild(fieldText);
          
          const removeBtn = document.createElement('button');
          removeBtn.className = 'remove-field';
          removeBtn.textContent = '×';
          removeBtn.onclick = () => {
            fieldEl.remove();
            const fieldsArr = sectionData.get(sectionId);
            const idx = fieldsArr.indexOf(fieldPath);
            if (idx > -1) fieldsArr.splice(idx, 1);
            
            // placeholder 복원
            if (fieldsArr.length === 0) {
              const newPlaceholder = document.createElement('div');
              newPlaceholder.className = 'drop-zone-placeholder';
              newPlaceholder.textContent = '필드를 여기에 드래그하세요';
              zone.appendChild(newPlaceholder);
            }
            
            updateStats();
          };
          
          fieldEl.appendChild(removeBtn);
          zone.appendChild(fieldEl);
        });
      });
      
      // 기본 규칙 채우기
      Object.entries(defaultRules).forEach(([ruleFor, rule]) => {
        const textarea = document.querySelector(\`[data-rule-for="\${ruleFor}"]\`);
        if (textarea && !textarea.value.trim()) {
          textarea.value = rule;
        }
      });
      
      updateStats();
    }
    
    // 드래그 앤 드롭
    document.querySelectorAll('.field-item').forEach(item => {
      item.addEventListener('dragstart', (e) => {
        if (item.classList.contains('disabled')) {
          e.preventDefault();
          return;
        }
        e.dataTransfer.setData('text/plain', item.dataset.path);
        item.classList.add('dragging');
      });
      item.addEventListener('dragend', () => item.classList.remove('dragging'));
    });
    
    // 검색
    document.getElementById('searchBox').addEventListener('input', (e) => {
      const query = e.target.value.toLowerCase();
      document.querySelectorAll('.field-item').forEach(item => {
        const text = item.textContent.toLowerCase();
        item.style.display = text.includes(query) ? 'block' : 'none';
      });
    });
    
    // 소스 그룹 접기/펼치기
    document.querySelectorAll('.source-group h3').forEach(header => {
      header.addEventListener('click', () => {
        header.parentElement.classList.toggle('collapsed');
      });
    });
    
    function updateStats() {
      const stats = { CAREERNET: new Set(), WORK24_MAJOR: new Set() };
      sectionData.forEach((fields) => {
        fields.forEach(path => {
          const source = path.split('.')[0];
          stats[source]?.add(path);
        });
      });
      document.getElementById('stat-careernet').textContent = stats.CAREERNET.size;
      document.getElementById('stat-work24major').textContent = stats.WORK24_MAJOR.size;
      document.getElementById('stat-total').textContent = stats.CAREERNET.size + stats.WORK24_MAJOR.size;
    }
    
    function exportConfig() {
      const config = {
        majorName: ${majorName ? `"${escapeHtml(majorName)}"` : 'null'},
        majorSlug: ${majorSlug ? `"${escapeHtml(majorSlug)}"` : 'null'},
        sections: {},
        rules: {},
        titles: {},
        disabledFields: Array.from(disabledFieldSet)
      };
      
      // 필드 데이터 수집
      sectionData.forEach((fields, sectionId) => {
        config.sections[sectionId] = fields;
      });
      
      // 규칙 수집
      document.querySelectorAll('.subsection-rule').forEach(textarea => {
        const ruleFor = textarea.dataset.ruleFor;
        if (ruleFor && textarea.value.trim()) {
          config.rules[ruleFor] = textarea.value.trim();
        }
      });
      
      // 타이틀 수집
      document.querySelectorAll('.subsection-title-input').forEach(input => {
        const titleFor = input.dataset.titleFor;
        if (titleFor) {
          config.titles[titleFor] = input.value.trim();
        }
      });
      
      navigator.clipboard.writeText(JSON.stringify(config, null, 2)).then(() => {
        alert('✅ JSON 구성이 클립보드에 복사되었습니다!');
      });
    }
  </script>
</body>
</html>
  `
}

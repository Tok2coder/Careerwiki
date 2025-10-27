import type { DataSource, UnifiedJobDetail } from '../types/unifiedProfiles'
import type { SourceStatusRecord } from '../services/profileDataService'
import { escapeHtml } from './detailTemplateUtils'

export interface DataDebugTemplateParams {
  profile: UnifiedJobDetail | null
  partials?: Partial<Record<DataSource, UnifiedJobDetail | null>>
  sources?: SourceStatusRecord
  rawApiData?: {
    careernet?: any
    goyong24?: any
  }
}

const renderEncyclopediaTable = (data: any): string => {
  if (!data) {
    return ''
  }

  const renderNestedObject = (obj: any, depth: number = 0): string => {
    if (!obj || typeof obj !== 'object') {
      return `<span class="text-gray-600 text-sm">${escapeHtml(String(obj || '-'))}</span>`
    }

    if (Array.isArray(obj)) {
      if (obj.length === 0) {
        return `<span class="text-gray-400 text-sm italic">빈 배열</span>`
      }

      return `
        <div class="ml-${depth * 4} space-y-2">
          ${obj.map((item, index) => `
            <div class="border-l-2 border-indigo-200 pl-3 py-2 bg-indigo-50/30">
              <div class="text-xs font-bold text-indigo-600 mb-1">[${index}]</div>
              ${renderNestedObject(item, depth + 1)}
            </div>
          `).join('')}
        </div>
      `
    }

    const entries = Object.entries(obj)
    if (entries.length === 0) {
      return `<span class="text-gray-400 text-sm italic">빈 객체</span>`
    }

    return `
      <table class="w-full border-collapse">
        <tbody>
          ${entries.map(([key, value]) => {
            const isObject = value && typeof value === 'object'
            const isArray = Array.isArray(value)
            
            return `
              <tr class="border-b border-gray-100 hover:bg-gray-50">
                <td class="py-3 px-4 align-top font-semibold text-sm ${
                  isObject ? 'bg-indigo-50 text-indigo-900' : 'bg-gray-50 text-gray-800'
                }" style="min-width: 200px; width: 30%;">
                  ${escapeHtml(key)}
                  ${isArray ? ` <span class="text-xs text-indigo-600">[${(value as any[]).length}개]</span>` : ''}
                </td>
                <td class="py-3 px-4 align-top">
                  ${isObject ? renderNestedObject(value, depth + 1) : 
                    `<span class="text-gray-700">${escapeHtml(String(value || '-'))}</span>`}
                </td>
              </tr>
            `
          }).join('')}
        </tbody>
      </table>
    `
  }

  return `
    <div class="card-hover">
      <div class="bg-white rounded-lg shadow-md overflow-hidden">
        <div class="bg-gradient-to-r from-indigo-600 to-indigo-700 px-6 py-4">
          <h3 class="text-xl font-bold text-white flex items-center">
            <svg class="w-6 h-6 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"></path>
            </svg>
            커리어넷 직업백과 (jobs.json)
          </h3>
          <p class="text-indigo-100 text-sm mt-1">교육부 커리어넷 - 직업백과 API 전체 데이터</p>
        </div>
        <div class="p-6 max-h-[1000px] overflow-auto">
          ${renderNestedObject(data)}
        </div>
      </div>
    </div>
  `
}

const renderCareerNetTable = (data: any): string => {
  if (!data) {
    return `
      <div class="bg-amber-50 border-l-4 border-amber-500 p-4 rounded">
        <p class="text-amber-700 font-medium">❌ CareerNet API 응답 없음</p>
      </div>
    `
  }

  const renderNestedObject = (obj: any, depth: number = 0): string => {
    if (!obj || typeof obj !== 'object') {
      return `<span class="text-gray-600 text-sm">${escapeHtml(String(obj || '-'))}</span>`
    }

    if (Array.isArray(obj)) {
      if (obj.length === 0) {
        return `<span class="text-gray-400 text-sm italic">빈 배열</span>`
      }

      return `
        <div class="ml-${depth * 4} space-y-2">
          ${obj.map((item, index) => `
            <div class="border-l-2 border-blue-200 pl-3 py-2 bg-blue-50/30">
              <div class="text-xs font-bold text-blue-600 mb-1">[${index}]</div>
              ${renderNestedObject(item, depth + 1)}
            </div>
          `).join('')}
        </div>
      `
    }

    const entries = Object.entries(obj)
    if (entries.length === 0) {
      return `<span class="text-gray-400 text-sm italic">빈 객체</span>`
    }

    return `
      <table class="w-full border-collapse">
        <tbody>
          ${entries.map(([key, value]) => {
            const isObject = value && typeof value === 'object'
            const isArray = Array.isArray(value)
            
            return `
              <tr class="border-b border-gray-100 hover:bg-gray-50">
                <td class="py-3 px-4 align-top font-semibold text-sm ${
                  isObject ? 'bg-indigo-50 text-indigo-900' : 'bg-gray-50 text-gray-800'
                }" style="min-width: 200px; width: 30%;">
                  ${escapeHtml(key)}
                  ${isArray ? ` <span class="text-xs text-blue-600">[${(value as any[]).length}개]</span>` : ''}
                </td>
                <td class="py-3 px-4 align-top">
                  ${isObject ? renderNestedObject(value, depth + 1) : 
                    `<span class="text-gray-700">${escapeHtml(String(value || '-'))}</span>`}
                </td>
              </tr>
            `
          }).join('')}
        </tbody>
      </table>
    `
  }

  return `
    <div class="bg-white rounded-lg shadow-md overflow-hidden">
      <div class="bg-gradient-to-r from-blue-600 to-blue-700 px-6 py-4">
        <h3 class="text-xl font-bold text-white flex items-center">
          <svg class="w-6 h-6 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
          </svg>
          커리어넷 (CareerNet) 원본 API 응답
        </h3>
        <p class="text-blue-100 text-sm mt-1">교육부 커리어넷 - 전체 필드 및 하위 노드</p>
      </div>
      <div class="p-6 max-h-[1000px] overflow-auto">
        ${renderNestedObject(data)}
      </div>
    </div>
  `
}

const renderGoyong24Table = (data: any): string => {
  if (!data) {
    return `
      <div class="bg-amber-50 border-l-4 border-amber-500 p-4 rounded">
        <p class="text-amber-700 font-medium">❌ Goyong24 API 응답 없음</p>
      </div>
    `
  }

  const renderNestedObject = (obj: any, depth: number = 0): string => {
    if (!obj || typeof obj !== 'object') {
      return `<span class="text-gray-600 text-sm">${escapeHtml(String(obj || '-'))}</span>`
    }

    if (Array.isArray(obj)) {
      if (obj.length === 0) {
        return `<span class="text-gray-400 text-sm italic">빈 배열</span>`
      }

      return `
        <div class="ml-${depth * 4} space-y-2">
          ${obj.map((item, index) => `
            <div class="border-l-2 border-green-200 pl-3 py-2 bg-green-50/30">
              <div class="text-xs font-bold text-green-600 mb-1">[${index}]</div>
              ${renderNestedObject(item, depth + 1)}
            </div>
          `).join('')}
        </div>
      `
    }

    const entries = Object.entries(obj)
    if (entries.length === 0) {
      return `<span class="text-gray-400 text-sm italic">빈 객체</span>`
    }

    return `
      <table class="w-full border-collapse">
        <tbody>
          ${entries.map(([key, value]) => {
            const isObject = value && typeof value === 'object'
            const isArray = Array.isArray(value)
            
            return `
              <tr class="border-b border-gray-100 hover:bg-gray-50">
                <td class="py-3 px-4 align-top font-semibold text-sm ${
                  isObject ? 'bg-emerald-50 text-emerald-900' : 'bg-gray-50 text-gray-800'
                }" style="min-width: 200px; width: 30%;">
                  ${escapeHtml(key)}
                  ${isArray ? ` <span class="text-xs text-green-600">[${(value as any[]).length}개]</span>` : ''}
                </td>
                <td class="py-3 px-4 align-top">
                  ${isObject ? renderNestedObject(value, depth + 1) : 
                    `<span class="text-gray-700">${escapeHtml(String(value || '-'))}</span>`}
                </td>
              </tr>
            `
          }).join('')}
        </tbody>
      </table>
    `
  }

  return `
    <div class="bg-white rounded-lg shadow-md overflow-hidden">
      <div class="bg-gradient-to-r from-green-600 to-green-700 px-6 py-4">
        <h3 class="text-xl font-bold text-white flex items-center">
          <svg class="w-6 h-6 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4"></path>
          </svg>
          고용24 (Goyong24) 원본 API 응답
        </h3>
        <p class="text-green-100 text-sm mt-1">고용노동부 고용24 - 전체 필드 및 항목</p>
      </div>
      <div class="p-6 max-h-[1000px] overflow-auto">
        ${renderNestedObject(data)}
      </div>
    </div>
  `
}

const renderFieldComparisonTable = (partials?: Partial<Record<DataSource, UnifiedJobDetail | null>>): string => {
  if (!partials) {
    return '<p class="text-gray-500">데이터 없음</p>'
  }

  const careernet = partials.CAREERNET
  const goyong24 = partials.GOYONG24

  const allFields = new Set<string>()
  if (careernet) Object.keys(careernet).forEach(key => allFields.add(key))
  if (goyong24) Object.keys(goyong24).forEach(key => allFields.add(key))

  const fields = Array.from(allFields).sort()

  const formatValue = (value: any): string => {
    if (value === null || value === undefined) {
      return '<span class="text-gray-300 text-xs italic">없음</span>'
    }
    
    if (Array.isArray(value)) {
      if (value.length === 0) {
        return '<span class="text-gray-400 text-xs italic">빈 배열</span>'
      }
      return `<span class="inline-block bg-blue-100 text-blue-800 text-xs font-semibold px-2 py-1 rounded">${value.length}개 항목</span>`
    }
    
    if (typeof value === 'object') {
      const keys = Object.keys(value)
      return `<span class="inline-block bg-purple-100 text-purple-800 text-xs font-semibold px-2 py-1 rounded">객체 (${keys.length}개 키)</span>`
    }
    
    const str = String(value)
    if (str.length > 150) {
      return `<span class="text-gray-700 text-sm">${escapeHtml(str.substring(0, 150))}<span class="text-gray-400">...</span></span>`
    }
    
    return `<span class="text-gray-700 text-sm">${escapeHtml(str)}</span>`
  }

  const rows = fields.map(field => {
    const careernetValue = careernet ? (careernet as any)[field] : undefined
    const goyong24Value = goyong24 ? (goyong24 as any)[field] : undefined
    
    const hasCareernetData = careernetValue !== null && careernetValue !== undefined
    const hasGoyong24Data = goyong24Value !== null && goyong24Value !== undefined

    return `
      <tr class="border-b border-gray-200 hover:bg-gray-50 transition-colors">
        <td class="px-4 py-3 font-semibold text-sm text-gray-800 bg-gray-50 sticky left-0" style="min-width: 180px;">
          ${escapeHtml(field)}
        </td>
        <td class="px-4 py-3 text-sm ${hasCareernetData ? 'bg-blue-50/50' : ''}">
          ${formatValue(careernetValue)}
        </td>
        <td class="px-4 py-3 text-sm ${hasGoyong24Data ? 'bg-green-50/50' : ''}">
          ${formatValue(goyong24Value)}
        </td>
      </tr>
    `
  }).join('')

  return `
    <div class="overflow-x-auto rounded-lg shadow-md">
      <table class="w-full border border-gray-200 bg-white">
        <thead class="sticky top-0 z-10">
          <tr class="bg-gradient-to-r from-gray-700 to-gray-800 text-white">
            <th class="px-4 py-4 text-left text-sm font-bold sticky left-0 bg-gray-800" style="min-width: 180px;">
              <svg class="w-4 h-4 inline mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 7h.01M7 3h5c.512 0 1.024.195 1.414.586l7 7a2 2 0 010 2.828l-7 7a2 2 0 01-2.828 0l-7-7A1.994 1.994 0 013 12V7a4 4 0 014-4z"></path>
              </svg>
              필드명
            </th>
            <th class="px-4 py-4 text-left text-sm font-bold bg-blue-700" style="min-width: 300px;">
              <svg class="w-4 h-4 inline mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
              </svg>
              커리어넷 (CareerNet)
            </th>
            <th class="px-4 py-4 text-left text-sm font-bold bg-green-700" style="min-width: 300px;">
              <svg class="w-4 h-4 inline mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4"></path>
              </svg>
              고용24 (Goyong24)
            </th>
          </tr>
        </thead>
        <tbody>
          ${rows}
        </tbody>
      </table>
    </div>
  `
}

export const renderDataDebugPage = (params: DataDebugTemplateParams): string => {
  const { profile, partials, sources, rawApiData } = params

  const jobTitle = profile?.name || '직업 정보'
  const careernetId = profile?.sourceIds?.careernet || 'N/A'
  const goyong24Id = profile?.sourceIds?.goyong24 || 'N/A'

  const styles = `
    <style>
      @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap');
      
      body {
        font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      }
      
      .debug-container {
        animation: fadeIn 0.5s ease-in;
      }
      
      @keyframes fadeIn {
        from { opacity: 0; transform: translateY(20px); }
        to { opacity: 1; transform: translateY(0); }
      }
      
      .card-hover {
        transition: all 0.3s ease;
      }
      
      .card-hover:hover {
        transform: translateY(-2px);
        box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
      }
      
      .gradient-text {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
      }
      
      table {
        font-size: 0.875rem;
      }
      
      th {
        text-transform: uppercase;
        letter-spacing: 0.05em;
      }
    </style>
  `

  return `
    <!DOCTYPE html>
    <html lang="ko">
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>API 데이터 디버그 - ${escapeHtml(jobTitle)}</title>
      <script src="https://cdn.tailwindcss.com"></script>
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
      ${styles}
    </head>
    <body class="min-h-screen py-8 px-4">
      <div class="max-w-[1600px] mx-auto debug-container space-y-6">
        
        <!-- Header -->
        <div class="bg-white rounded-2xl shadow-2xl p-8 card-hover">
          <div class="flex items-center justify-between mb-6">
            <div>
              <h1 class="text-4xl font-bold gradient-text mb-2">
                <i class="fas fa-database mr-3"></i>
                API 데이터 디버그
              </h1>
              <p class="text-2xl font-semibold text-gray-800">${escapeHtml(jobTitle)}</p>
            </div>
            <a href="/job/lawyer" class="inline-flex items-center px-6 py-3 bg-gradient-to-r from-blue-600 to-blue-700 text-white font-semibold rounded-lg hover:from-blue-700 hover:to-blue-800 transition-all shadow-lg">
              <i class="fas fa-arrow-left mr-2"></i>
              일반 페이지로
            </a>
          </div>
          
          <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div class="bg-gradient-to-br from-blue-50 to-blue-100 border-2 border-blue-300 rounded-xl p-5">
              <div class="flex items-center mb-3">
                <svg class="w-6 h-6 text-blue-600 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                </svg>
                <h3 class="text-sm font-bold text-blue-900 uppercase tracking-wide">커리어넷 ID</h3>
              </div>
              <p class="text-2xl font-bold text-blue-700 mb-2">${escapeHtml(careernetId)}</p>
              <p class="text-xs text-gray-600 font-mono bg-white/50 p-2 rounded">
                JOB_VIEW?jobdicSeq=${escapeHtml(careernetId)}
              </p>
            </div>
            
            <div class="bg-gradient-to-br from-green-50 to-green-100 border-2 border-green-300 rounded-xl p-5">
              <div class="flex items-center mb-3">
                <svg class="w-6 h-6 text-green-600 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4"></path>
                </svg>
                <h3 class="text-sm font-bold text-green-900 uppercase tracking-wide">고용24 ID</h3>
              </div>
              <p class="text-2xl font-bold text-green-700 mb-2">${escapeHtml(goyong24Id)}</p>
              <p class="text-xs text-gray-600 font-mono bg-white/50 p-2 rounded">
                callOpenApiSvcInfo212D*?jobCd=${escapeHtml(goyong24Id)}
              </p>
            </div>
          </div>
        </div>

        <!-- API Status -->
        ${sources ? `
          <div class="bg-white rounded-2xl shadow-xl p-8 card-hover">
            <h2 class="text-2xl font-bold text-gray-800 mb-6 flex items-center">
              <svg class="w-7 h-7 text-green-600 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
              </svg>
              API 호출 상태
            </h2>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
              ${Object.entries(sources).map(([source, status]) => `
                <div class="border-2 rounded-xl p-5 ${
                  status.attempted 
                    ? (status.error ? 'bg-red-50 border-red-300' : 'bg-green-50 border-green-300')
                    : 'bg-gray-50 border-gray-300'
                }">
                  <h3 class="font-bold text-lg mb-3 flex items-center">
                    <span class="text-2xl mr-2">${status.attempted ? (status.error ? '❌' : '✅') : '⏸️'}</span>
                    ${source}
                  </h3>
                  <div class="space-y-2 text-sm">
                    <div class="flex items-center">
                      <span class="text-gray-600 w-20">시도:</span>
                      <span class="font-mono font-semibold">${status.attempted ? 'YES' : 'NO'}</span>
                    </div>
                    ${status.count !== undefined ? `
                      <div class="flex items-center">
                        <span class="text-gray-600 w-20">결과:</span>
                        <span class="font-mono font-semibold text-green-700">${status.count}개</span>
                      </div>
                    ` : ''}
                    ${status.error ? `
                      <div class="flex items-start">
                        <span class="text-gray-600 w-20">에러:</span>
                        <span class="text-red-600 flex-1">${escapeHtml(status.error)}</span>
                      </div>
                    ` : ''}
                    ${status.skippedReason ? `
                      <div class="flex items-center">
                        <span class="text-gray-600 w-20">건너뜀:</span>
                        <span class="text-gray-500">${escapeHtml(status.skippedReason)}</span>
                      </div>
                    ` : ''}
                  </div>
                </div>
              `).join('')}
            </div>
          </div>
        ` : ''}

        <!-- Field Comparison -->
        <div class="bg-white rounded-2xl shadow-xl p-8 card-hover">
          <h2 class="text-2xl font-bold text-gray-800 mb-6 flex items-center">
            <svg class="w-7 h-7 text-purple-600 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 17V7m0 10a2 2 0 01-2 2H5a2 2 0 01-2-2V7a2 2 0 012-2h2a2 2 0 012 2m0 10a2 2 0 002 2h2a2 2 0 002-2M9 7a2 2 0 012-2h2a2 2 0 012 2m0 10V7m0 10a2 2 0 002 2h2a2 2 0 002-2V7a2 2 0 00-2-2h-2a2 2 0 00-2 2"></path>
            </svg>
            병합 후 필드 비교
          </h2>
          ${renderFieldComparisonTable(partials)}
        </div>

        <!-- CareerNet Encyclopedia (jobs.json) -->
        ${rawApiData?.careernet?.encyclopedia ? renderEncyclopediaTable(rawApiData.careernet.encyclopedia) : ''}

        <!-- CareerNet Job Info (getOpenApi) -->
        <div class="card-hover">
          ${renderCareerNetTable(rawApiData?.careernet)}
        </div>

        <!-- Goyong24 Raw Data -->
        <div class="card-hover">
          ${renderGoyong24Table(rawApiData?.goyong24)}
        </div>

        <!-- Footer -->
        <div class="text-center py-8">
          <a href="/job/lawyer" class="inline-flex items-center px-8 py-4 bg-white text-gray-800 font-bold rounded-xl shadow-lg hover:shadow-xl transition-all">
            <i class="fas fa-arrow-left mr-3"></i>
            일반 페이지로 돌아가기
          </a>
        </div>
        
      </div>
    </body>
    </html>
  `
}

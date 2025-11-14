/**
 * 한국 지도 컴포넌트
 * 실제 이미지 위에 클릭 가능한 지역 버튼 배치
 */

export interface RegionData {
  id: string
  name: string
  count: number
}

export interface KoreaMapOptions {
  regions: RegionData[]
}

// 17개 광역시도의 버튼 위치 (고용24 실제 좌표 기반)
const REGION_POSITIONS: Record<string, { style: string }> = {
  '서울': { style: 'left:121px; top:9px' },
  '부산': { style: 'right:36px; bottom:92px' },
  '대구': { style: 'right:73px; top:227px' },
  '인천': { style: 'left:31px; top:9px' },
  '광주': { style: 'left:69px; bottom:111px' },
  '대전': { style: 'left:141px; top:204px' },
  '울산': { style: 'right:-11px; top:217px' },
  '세종': { style: 'left:104px; top:138px' },
  '경기': { style: 'left:68px; top:74px' },
  '강원': { style: 'left:265px; top:17px' },
  '충북': { style: 'left:178px; top:113px' },
  '충남': { style: 'left:30px; top:138px' },
  '전북': { style: 'left:57px; bottom:185px' },
  '전남': { style: 'left:-1px; bottom:66px' },
  '경북': { style: 'left:252px; bottom:278px' },
  '경남': { style: 'left:178px; bottom:127px' },
  '제주': { style: 'left:129px; bottom:10px' }
}

/**
 * 한국 지도 렌더링 (고용24 스타일)
 */
export const renderKoreaMap = (options: KoreaMapOptions): string => {
  const { regions } = options
  
  const countMap = new Map<string, number>()
  regions.forEach(region => countMap.set(region.id, region.count))
  
  // 전체 대학 수
  const totalCount = regions.reduce((sum, r) => sum + r.count, 0)

  const regionItems = Object.entries(REGION_POSITIONS)
    .map(([regionId, { style }]) => {
      const count = countMap.get(regionId) || 0
      // 카운트가 0이어도 버튼은 표시 (디버깅용)
      
      return `
        <li style="${style}">
          <a href="javascript:void(0);" data-region="${regionId}" class="${count === 0 ? 'no-data' : ''}">
            <strong>${regionId}</strong>
            <em>${count}</em>
          </a>
        </li>
      `
    })
    .join('')

  return `
    <div class="openUni-wrp" data-korea-map style="display: block; position: relative; width: 357px; height: 485px; margin: 0 auto; background: url(/static/korea-map.png) no-repeat center center; background-size: contain;">
      <ul class="region">
        <!-- 전체 버튼 (오른쪽 위) -->
        <li class="all-region-btn" style="right:-260px; top:19px">
          <a href="javascript:void(0);" data-region="ALL">
            <strong>전체</strong>
            <em>${totalCount}</em>
          </a>
        </li>
        ${regionItems}
      </ul>
    </div>
    
    <style>
      .openUni-wrp {
        position: relative;
        width: 357px;
        height: 485px;
        margin: 0 auto;
      }
      
      .openUni-wrp .region {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        list-style: none;
        margin: 0;
        padding: 0;
        z-index: 10;
      }
      
      .openUni-wrp .region li {
        position: absolute;
        z-index: 10;
      }
      
      .openUni-wrp .region li a {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        min-width: 48px;
        padding: 6px 10px;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        border: 2px solid rgba(255, 255, 255, 0.3);
        border-radius: 8px;
        box-shadow: 0 3px 10px rgba(102, 126, 234, 0.4);
        cursor: pointer;
        text-decoration: none;
        transition: all 0.2s ease;
      }
      
      .openUni-wrp .region li a.no-data {
        background: linear-gradient(135deg, #64748b 0%, #475569 100%);
        opacity: 0.5;
        cursor: not-allowed;
      }
      
      .openUni-wrp .region li a:hover {
        transform: scale(1.1);
        box-shadow: 0 5px 15px rgba(102, 126, 234, 0.6);
        border-color: rgba(255, 255, 255, 0.6);
      }
      
      .openUni-wrp .region li a.active {
        background: linear-gradient(135deg, #a78bfa 0%, #8b5cf6 100%);
        border-color: #fff;
        box-shadow: 0 0 0 3px rgba(139, 92, 246, 0.5), 0 5px 15px rgba(139, 92, 246, 0.6);
      }
      
      .openUni-wrp .region li a strong {
        display: block;
        font-size: 11px;
        font-weight: 700;
        color: #fff;
        line-height: 1.2;
        margin-bottom: 2px;
        text-shadow: 0 1px 3px rgba(0, 0, 0, 0.3);
      }
      
      .openUni-wrp .region li a em {
        display: block;
        font-size: 16px;
        font-weight: 800;
        font-style: normal;
        color: #fff;
        line-height: 1;
        text-shadow: 0 2px 4px rgba(0, 0, 0, 0.4);
      }
      
      @media (max-width: 1024px) {
        /* 태블릿/모바일: 전체 버튼을 오른쪽 밑에 배치 */
        .openUni-wrp .region li.all-region-btn {
          right: 10px !important;
          top: auto !important;
          bottom: 10px !important;
        }
      }
      
      @media (max-width: 640px) {
        .openUni-wrp {
          transform: scale(0.8);
          transform-origin: top center;
        }
        
        /* 모바일: 전체 버튼을 오른쪽 밑에 배치 */
        .openUni-wrp .region li.all-region-btn {
          right: 10px !important;
          top: auto !important;
          bottom: 10px !important;
        }
      }
    </style>
  `
}

/**
 * 지역명 정규화 함수
 * "서울특별시" → "서울", "경기도" → "경기", "충청북도" → "충북"
 */
export const normalizeRegionName = (area?: string): string => {
  if (!area) return ''
  
  const trimmed = area.trim()
  
  // 특별한 매핑
  const mapping: Record<string, string> = {
    '서울특별시': '서울',
    '부산광역시': '부산',
    '대구광역시': '대구',
    '인천광역시': '인천',
    '광주광역시': '광주',
    '대전광역시': '대전',
    '울산광역시': '울산',
    '세종특별자치시': '세종',
    '경기도': '경기',
    '강원도': '강원',
    '강원특별자치도': '강원',
    '충청북도': '충북',
    '충청남도': '충남',
    '전라북도': '전북',
    '전북특별자치도': '전북',
    '전라남도': '전남',
    '경상북도': '경북',
    '경상남도': '경남',
    '제주특별자치도': '제주'
  }
  
  // 정확한 매핑이 있으면 사용
  if (mapping[trimmed]) {
    return mapping[trimmed]
  }
  
  // 매핑이 없으면 접미사 제거
  return trimmed
    .replace('특별시', '')
    .replace('광역시', '')
    .replace('특별자치시', '')
    .replace('특별자치도', '')
    .replace('도', '')
}

/**
 * 17개 광역시도 목록
 */
export const REGIONS = [
  '서울', '부산', '대구', '인천', '광주', '대전', '울산', '세종',
  '경기', '강원', '충북', '충남', '전북', '전남', '경북', '경남', '제주'
] as const

export type RegionId = typeof REGIONS[number]


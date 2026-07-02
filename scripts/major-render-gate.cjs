#!/usr/bin/env node
// 전공 페이지 렌더 게이트 (M0 각주 렌더 사고 후속, 2026-07-02)
// 검사: ①본문 각주 sup 렌더 존재 ②raw "[N]" 잔존 패턴 0 ③출처 패널 [필드명] prefix 0 ④필드 그룹 헤더 존재
// 사용: node scripts/major-render-gate.cjs <slug1> <slug2> ...
const slugs = process.argv.slice(2)
if (!slugs.length) { console.error('사용: node scripts/major-render-gate.cjs <slug...>'); process.exit(2) }

;(async () => {
  let fail = 0
  for (const slug of slugs) {
    const r = await fetch('https://careerwiki.org/major/' + encodeURIComponent(slug))
    const html = await r.text()
    // <script> 블록 제거 (임베디드 JSON의 raw 마커 false positive 방지)
    let vis = html.replace(/<script[\s\S]*?<\/script>/gi, '')
    const supCountPre = (vis.match(/user-footnote-ref/g) || []).length
    // 정상 각주 sup 블록 제거 — sup 내부 표시 텍스트가 [N] 형태라 raw 검출에서 제외해야 함
    vis = vis.replace(/<sup[^>]*user-footnote-ref[\s\S]*?<\/sup>/gi, ' ')
    const problems = []
    if (r.status !== 200) problems.push(`HTTP ${r.status}`)
    const supCount = supCountPre
    if (supCount < 1) problems.push('본문 각주 sup 0개')
    // raw 잔존: 문장부호/한글 뒤 공백 + [숫자] 텍스트 (스크린샷 사고 형태). 태그 제거 후 검사
    const text = vis.replace(/<[^>]+>/g, ' ')
    const raw = text.match(/[가-힣.)"”\]]\s*\[\d{1,2}\]/g) || []
    if (raw.length) problems.push(`raw [N] 잔존 ${raw.length}건: ${raw.slice(0, 3).join(' | ')}`)
    // 패널 prefix: "[배우는 내용]" 류 대괄호 필드라벨
    const prefix = text.match(/\[(배우는 내용|준비 방법|진로 전망|주요 교과목|진출 분야|자격증|여담)\]/g) || []
    if (prefix.length) problems.push(`패널 [필드명] prefix ${prefix.length}건`)
    // 그룹 헤더: 사용자 추가 출처 패널 존재 시 필드 그룹(fa-tag) 최소 1개
    if (vis.includes('사용자 추가 출처') && !(vis.match(/fa-tag/g) || []).length) problems.push('출처 패널 필드 그룹 헤더 없음')
    const ok = problems.length === 0
    if (!ok) fail++
    console.log(`${ok ? 'PASS' : 'FAIL'} ${slug} | sup=${supCount}${problems.length ? ' | ' + problems.join(' / ') : ''}`)
  }
  console.log(`=== render-gate: ${slugs.length - fail}/${slugs.length} PASS ===`)
  process.exitCode = fail ? 1 : 0
})()

/**
 * 간호사 ETL 재구축 스크립트 v2
 * XML 파싱 로직은 src/api/goyong24API.ts의 실제 parse 함수를 정확히 복제
 */
const fs = require('fs')

// --- XML 파서 헬퍼 (goyong24API.ts에서 복제) ---
function getFirstValue(xml, tag) {
  const regex = new RegExp(`<${tag}>([\\s\\S]*?)</${tag}>`)
  const m = xml.match(regex)
  return m ? decodeXmlEntities(m[1].trim()) : null
}

function extractNodes(xml, tag) {
  const regex = new RegExp(`<${tag}>([\\s\\S]*?)</${tag}>`, 'g')
  const results = []
  let m
  while ((m = regex.exec(xml)) !== null) {
    results.push(m[0])
  }
  return results
}

function decodeXmlEntities(str) {
  return str.replace(/&amp;/g, '&').replace(/&lt;/g, '<').replace(/&gt;/g, '>').replace(/&quot;/g, '"').replace(/&apos;/g, "'").replace(/&#(\d+);/g, (_, n) => String.fromCharCode(parseInt(n)))
}

// --- D01-D07 Parse (goyong24API.ts 구조 그대로) ---
function parseSummarySection(xml) {
  const block = extractNodes(xml, 'jobSum')[0] || xml
  return {
    jobCd: getFirstValue(block, 'jobCd'), jobNm: getFirstValue(block, 'jobNm'),
    jobLrclNm: getFirstValue(block, 'jobLrclNm'), jobMdclNm: getFirstValue(block, 'jobMdclNm'), jobSmclNm: getFirstValue(block, 'jobSmclNm'),
    jobSum: getFirstValue(block, 'jobSum'), way: getFirstValue(block, 'way'),
    sal: getFirstValue(block, 'sal'), jobProspect: getFirstValue(block, 'jobProspect'), jobSatis: getFirstValue(block, 'jobSatis')
  }
}

function parseDutySection(xml) {
  const block = extractNodes(xml, 'jobsDo')[0] || xml
  return { execJob: getFirstValue(block, 'execJob'), relJob: getFirstValue(block, 'relJob') }
}

function parsePathSection(xml) {
  const block = extractNodes(xml, 'way')[0] || xml
  const eduMap = { '중졸이하': 'middleSchoolOrLess', '고졸': 'highSchool', '전문대졸': 'college', '대졸': 'university', '대학원졸': 'graduate', '박사졸': 'doctor' }
  const majorMap = { '인문계열': 'humanities', '사회계열': 'social', '교육계열': 'education', '공학계열': 'engineering', '자연계열': 'natural', '의학계열': 'medical', '의약계열': 'medical', '예체능계열': 'artsSports' }
  const educationDistribution = {}
  extractNodes(block, 'educationDistributionChart').forEach(e => {
    const nm = getFirstValue(e, 'educationDistributionChartNm'), val = getFirstValue(e, 'educationDistributionChartVal')
    const key = eduMap[nm]; if (key && val && val !== '0') educationDistribution[key] = val.includes('%') ? val : `${val}%`
  })
  const majorDistribution = {}
  extractNodes(block, 'majorDistributionChart').forEach(e => {
    const nm = getFirstValue(e, 'majorDistributionChartNm'), val = getFirstValue(e, 'majorDistributionChartVal')
    const key = majorMap[nm]; if (key && val && val !== '0') majorDistribution[key] = val.includes('%') ? val : `${val}%`
  })
  const relMajorList = extractNodes(block, 'relMajor').map(n => ({ majorNm: getFirstValue(n, 'majorNm'), majorCd: getFirstValue(n, 'majorCd') })).filter(m => m.majorNm)
  const relCertList = extractNodes(block, 'relCert').map(n => ({ certNm: getFirstValue(n, 'certNm') })).filter(c => c.certNm)
  const relOrgList = extractNodes(block, 'relOrg').map(n => ({ orgNm: getFirstValue(n, 'orgNm'), orgSiteUrl: getFirstValue(n, 'orgSiteUrl') })).filter(o => o.orgNm)
  const kecoList = extractNodes(block, 'kecoJob').map(n => ({ kecoNm: getFirstValue(n, 'kecoNm'), kecoCd: getFirstValue(n, 'kecoCd') })).filter(k => k.kecoNm)
  return {
    technKnow: getFirstValue(block, 'technKnow'),
    educationDistribution: Object.keys(educationDistribution).length > 0 ? educationDistribution : null,
    majorDistribution: Object.keys(majorDistribution).length > 0 ? majorDistribution : null,
    relMajorList: relMajorList.length > 0 ? relMajorList : null, relCertList: relCertList.length > 0 ? relCertList : null,
    relOrgList: relOrgList.length > 0 ? relOrgList : null, kecoList: kecoList.length > 0 ? kecoList : null
  }
}

function parseSalProspectSection(xml) {
  const block = extractNodes(xml, 'salProspect')[0] || xml
  return { sal: getFirstValue(block, 'sal'), jobProspect: getFirstValue(block, 'jobProspect'), jobSatis: getFirstValue(block, 'jobSatis'), jobSumProspect: getFirstValue(block, 'jobSumProspect') }
}

function parseAblKnwEnvSection(xml) {
  const block = extractNodes(xml, 'ablKnwEnv')[0] || xml
  return {
    jobAbilCmpr: extractNodes(block, 'jobAbilCmpr').map(e => ({ jobAblStatusCmpr: getFirstValue(e, 'jobAblStatusCmpr'), jobAblNmCmpr: getFirstValue(e, 'jobAblNmCmpr'), jobAblContCmpr: getFirstValue(e, 'jobAblContCmpr') })),
    jobAbil: extractNodes(block, 'jobAbil').map(e => ({ jobAblStatus: getFirstValue(e, 'jobAblStatus'), jobAblNm: getFirstValue(e, 'jobAblNm'), jobAblCont: getFirstValue(e, 'jobAblCont') })),
    jobAbilLvlCmpr: extractNodes(block, 'jobAbilLvlCmpr').map(e => ({ jobAblLvlStatusCmpr: getFirstValue(e, 'jobAblLvlStatusCmpr'), jobAblLvlNmCmpr: getFirstValue(e, 'jobAblLvlNmCmpr'), jobAblLvlContCmpr: getFirstValue(e, 'jobAblLvlContCmpr') })),
    jobAbilLvl: extractNodes(block, 'jobAbilLvl').map(e => ({ jobAblLvlStatus: getFirstValue(e, 'jobAblLvlStatus'), jobAblLvlNm: getFirstValue(e, 'jobAblLvlNm'), jobAblLvlCont: getFirstValue(e, 'jobAblLvlCont') })),
    KnwldgCmpr: extractNodes(block, 'KnwldgCmpr').map(e => ({ knwldgStatusCmpr: getFirstValue(e, 'knwldgStatusCmpr'), knwldgNmCmpr: getFirstValue(e, 'knwldgNmCmpr'), knwldgContCmpr: getFirstValue(e, 'knwldgContCmpr') })),
    Knwldg: extractNodes(block, 'Knwldg').map(e => ({ knwldgStatus: getFirstValue(e, 'knwldgStatus'), knwldgNm: getFirstValue(e, 'knwldgNm'), knwldgCont: getFirstValue(e, 'knwldgCont') })),
    KnwldgLvlCmpr: extractNodes(block, 'KnwldgLvlCmpr').map(e => ({ knwldgLvlStatusCmpr: getFirstValue(e, 'knwldgLvlStatusCmpr'), knwldgLvlNmCmpr: getFirstValue(e, 'knwldgLvlNmCmpr'), knwldgLvlContCmpr: getFirstValue(e, 'knwldgLvlContCmpr') })),
    KnwldgLvl: extractNodes(block, 'KnwldgLvl').map(e => ({ knwldgLvlStatus: getFirstValue(e, 'knwldgLvlStatus'), knwldgLvlNm: getFirstValue(e, 'knwldgLvlNm'), knwldgLvlCont: getFirstValue(e, 'knwldgLvlCont') })),
    jobsEnvCmpr: extractNodes(block, 'jobsEnvCmpr').map(e => ({ jobEnvStatusCmpr: getFirstValue(e, 'jobEnvStatusCmpr'), jobEnvNmCmpr: getFirstValue(e, 'jobEnvNmCmpr'), jobEnvContCmpr: getFirstValue(e, 'jobEnvContCmpr') })),
    jobsEnv: extractNodes(block, 'jobsEnv').map(e => ({ jobEnvStatus: getFirstValue(e, 'jobEnvStatus'), jobEnvNm: getFirstValue(e, 'jobEnvNm'), jobEnvCont: getFirstValue(e, 'jobEnvCont') }))
  }
}

function parseChrIntrValsSection(xml) {
  const block = extractNodes(xml, 'chrIntrVals')[0] || xml
  return {
    jobChrCmpr: extractNodes(block, 'jobChrCmpr').map(e => ({ chrStatusCmpr: getFirstValue(e, 'jobChrStatusCmpr'), chrNmCmpr: getFirstValue(e, 'jobChrNmCmpr'), chrContCmpr: getFirstValue(e, 'jobChrContCmpr') })),
    jobChr: extractNodes(block, 'jobChr').map(e => ({ chrStatus: getFirstValue(e, 'jobChrStatus'), chrNm: getFirstValue(e, 'jobChrNm'), chrCont: getFirstValue(e, 'jobChrCont') })),
    jobIntrstCmpr: extractNodes(block, 'jobIntrstCmpr').map(e => ({ intrstStatusCmpr: getFirstValue(e, 'jobIntrstStatusCmpr'), intrstNmCmpr: getFirstValue(e, 'jobIntrstNmCmpr'), intrstContCmpr: getFirstValue(e, 'jobIntrstContCmpr') })),
    jobIntrst: extractNodes(block, 'jobIntrst').map(e => ({ intrstStatus: getFirstValue(e, 'jobIntrstStatus'), intrstNm: getFirstValue(e, 'jobIntrstNm'), intrstCont: getFirstValue(e, 'jobIntrstCont') })),
    jobValsCmpr: extractNodes(block, 'jobValsCmpr').map(e => ({ valsStatusCmpr: getFirstValue(e, 'jobValsStatusCmpr'), valsNmCmpr: getFirstValue(e, 'jobValsNmCmpr'), valsContCmpr: getFirstValue(e, 'jobValsContCmpr') })),
    jobVals: extractNodes(block, 'jobVals').map(e => ({ valsStatus: getFirstValue(e, 'jobValsStatus'), valsNm: getFirstValue(e, 'jobValsNm'), valsCont: getFirstValue(e, 'jobValsCont') }))
  }
}

function parseActvSection(xml) {
  const block = extractNodes(xml, 'jobActv')[0] || xml
  return {
    jobActvImprtncCmpr: extractNodes(block, 'jobActvImprtncCmpr').map(e => ({ jobActvImprtncStatusCmpr: getFirstValue(e, 'jobActvImprtncStatusCmpr'), jobActvImprtncNmCmpr: getFirstValue(e, 'jobActvImprtncNmCmpr'), jobActvImprtncContCmpr: getFirstValue(e, 'jobActvImprtncContCmpr') })),
    jobActvImprtnc: extractNodes(block, 'jobActvImprtnc').map(e => ({ jobActvImprtncStatus: getFirstValue(e, 'jobActvImprtncStatus'), jobActvImprtncNm: getFirstValue(e, 'jobActvImprtncNm'), jobActvImprtncCont: getFirstValue(e, 'jobActvImprtncCont') })),
    jobActvLvlCmpr: extractNodes(block, 'jobActvLvlCmpr').map(e => ({ jobActvLvlStatusCmpr: getFirstValue(e, 'jobActvLvlStatusCmpr'), jobActvLvlNmCmpr: getFirstValue(e, 'jobActvLvlNmCmpr'), jobActvLvlContCmpr: getFirstValue(e, 'jobActvLvlContCmpr') })),
    jobActvLvl: extractNodes(block, 'jobActvLvl').map(e => ({ jobActvLvlStatus: getFirstValue(e, 'jobActvLvlStatus'), jobActvLvlNm: getFirstValue(e, 'jobActvLvlNm'), jobActvLvlCont: getFirstValue(e, 'jobActvLvlCont') }))
  }
}

function parseDictSection(xml) {
  return {
    dJobNm: getFirstValue(xml, 'dJobNm'), workSum: getFirstValue(xml, 'workSum'), doWork: getFirstValue(xml, 'doWork'),
    needKnowlgCont: getFirstValue(xml, 'needKnowlgCont'), needAbilCont: getFirstValue(xml, 'needAbilCont'),
    jobIntrstCont: getFirstValue(xml, 'jobIntrstCont'), jobAptdCont: getFirstValue(xml, 'jobAptdCont'),
    jobChrCont: getFirstValue(xml, 'jobChrCont'), jobValCont: getFirstValue(xml, 'jobValCont'),
    relJobNmCont: getFirstValue(xml, 'relJobNmCont'), relCertNmCont: getFirstValue(xml, 'relCertNmCont'),
    jobWorkEnvCont: getFirstValue(xml, 'jobWorkEnvCont'), reprDutyCont: getFirstValue(xml, 'reprDutyCont'),
    jobDefiSumryCont: getFirstValue(xml, 'jobDefiSumryCont'), prepEdursbjNm: getFirstValue(xml, 'prepEdursbjNm')
  }
}

function convertEduChart(eduChart) {
  if (!eduChart?.[0]) return null
  const item = eduChart[0], namesStr = item?.chart_name || '', dataStr = item?.chart_data || ''
  if (!namesStr || !dataStr) return null
  const names = namesStr.split(',').map(s => s.trim()), values = dataStr.split(',').map(s => s.trim())
  if (names.length !== values.length) return null
  const map = { '중졸이하': 'middleSchoolOrLess', '고졸': 'highSchool', '전문대졸': 'college', '대졸': 'university', '대학원졸': 'graduate', '박사졸': 'doctor' }
  const r = {}; for (let i = 0; i < names.length; i++) { const k = map[names[i]]; if (k && values[i] && values[i] !== '0') r[k] = values[i].includes('%') ? values[i] : `${values[i]}%` }
  return Object.keys(r).length > 0 ? r : null
}

function convertMajorChart(majorChart) {
  if (!majorChart?.[0]) return null
  const item = majorChart[0], namesStr = item?.major || '', dataStr = item?.major_data || ''
  if (!namesStr || !dataStr) return null
  const names = namesStr.split(',').map(s => s.trim()), values = dataStr.split(',').map(s => s.trim())
  if (names.length !== values.length) return null
  const map = { '인문계열': 'humanities', '사회계열': 'social', '교육계열': 'education', '공학계열': 'engineering', '자연계열': 'natural', '의학계열': 'medical', '의약계열': 'medical', '예체능계열': 'artsSports' }
  const r = {}; for (let i = 0; i < names.length; i++) { const k = map[names[i]]; if (k && values[i] && values[i] !== '0') r[k] = values[i].includes('%') ? values[i] : `${values[i]}%` }
  return Object.keys(r).length > 0 ? r : null
}

// ==========================================
async function main() {
  console.log('=== 간호사 ETL v2 ===')
  const xmlData = JSON.parse(fs.readFileSync('tmp_nurse_api_data.json', 'utf-8'))
  const careernetRaw = JSON.parse(fs.readFileSync('tmp_nurse_careernet.json', 'utf-8'))
  const enc = careernetRaw.careernet?.encyclopedia || careernetRaw.encyclopedia || careernetRaw

  const g = { summary: parseSummarySection(xmlData.D01), duty: parseDutySection(xmlData.D02), path: parsePathSection(xmlData.D03), salProspect: parseSalProspectSection(xmlData.D04), ablKnwEnv: parseAblKnwEnvSection(xmlData.D05), chrIntrVals: parseChrIntrValsSection(xmlData.D06), actv: parseActvSection(xmlData.D07) }
  const d = parseDictSection(xmlData.DICT)

  console.log('D05:', g.ablKnwEnv.jobAbilCmpr.length, 'abilities,', g.ablKnwEnv.Knwldg.length, 'knowledge,', g.ablKnwEnv.KnwldgCmpr.length, 'knwCmpr,', g.ablKnwEnv.jobsEnv.length, 'env,', g.ablKnwEnv.jobsEnvCmpr.length, 'envCmpr')
  console.log('D06:', g.chrIntrVals.jobChrCmpr.length, 'chr,', g.chrIntrVals.jobIntrstCmpr.length, 'intrst,', g.chrIntrVals.jobValsCmpr.length, 'vals')
  console.log('D07:', g.actv.jobActvImprtncCmpr.length, 'imprtnc,', g.actv.jobActvLvlCmpr.length, 'lvl')
  console.log('Dict:', d.dJobNm)

  const baseInfo = enc?.baseInfo || {}, workList = enc?.workList || [], summary = workList.map(w => w.work).join('\n\n')
  const heroCategory = (g.summary.jobLrclNm && g.summary.jobMdclNm && g.summary.jobSmclNm) ? { type: 'breadcrumb', large: g.summary.jobLrclNm, medium: g.summary.jobMdclNm, small: g.summary.jobSmclNm } : (baseInfo?.aptit_name ? { type: 'single', value: baseInfo.aptit_name } : null)
  const tagSet = new Set()
  ;[baseInfo?.tag, enc?.tagList].forEach(src => { if (!src) return; const tags = typeof src === 'string' ? src.split(/[,，\s]+/).map(t => t.trim()) : Array.isArray(src) ? src.map(t => typeof t === 'string' ? t.trim() : (t?.tag || '').trim()) : []; tags.forEach(tag => { if (tag && tag.length > 1) tagSet.add(tag) }) })
  const gSal = g.salProspect?.sal || g.summary?.sal, cWage = baseInfo?.wage
  const overviewSalary = gSal ? { sal: gSal, source: 'WORK24_JOB' } : (cWage ? { wage: cWage, wageSource: baseInfo?.wage_source, source: 'CAREERNET' } : null)
  const gSatis = g.salProspect?.jobSatis, cSatis = baseInfo?.satisfication
  const satisfaction = gSatis ? { value: gSatis, source: 'WORK24_JOB' } : (cSatis ? { value: cSatis, source: baseInfo?.satisfi_source || 'CAREERNET' } : null)

  // Sidebars
  const sidebarJobs = [], jobSeen = new Set()
  if (d.relJobNmCont) d.relJobNmCont.split(',').map(s => s.trim()).forEach(n => { if (n && !jobSeen.has(n)) { jobSeen.add(n); sidebarJobs.push({ name: n }) } })
  ;(enc?.relSolList || []).forEach(j => { const n = j?.rel_sol || j?.name; if (n && !jobSeen.has(n)) { jobSeen.add(n); sidebarJobs.push(j) } })

  const sidebarMajors = [], majorSeen = new Set()
  if (g.path?.relMajorList) g.path.relMajorList.forEach(m => { if (m.majorNm && !majorSeen.has(m.majorNm)) { majorSeen.add(m.majorNm); sidebarMajors.push(m) } })
  ;(enc?.departList || []).forEach(m => { const k = m?.depart_name || m?.name; if (k && !majorSeen.has(k)) { majorSeen.add(k); sidebarMajors.push(m) } })

  const sidebarOrgs = [], orgSeen = new Set()
  if (g.path?.relOrgList) g.path.relOrgList.forEach(o => { if (o.orgNm && !orgSeen.has(o.orgNm)) { orgSeen.add(o.orgNm); sidebarOrgs.push({ name: o.orgNm, url: o.orgSiteUrl || null }) } })
  ;(enc?.jobRelOrgList || []).forEach(o => { const k = o?.rel_org || o?.name; if (k && !orgSeen.has(k)) { orgSeen.add(k); sidebarOrgs.push({ name: k, url: o?.rel_org_url || null }) } })

  const sidebarCerts = [], certSeen = new Set()
  if (g.path?.relCertList) g.path.relCertList.forEach(ct => { if (ct.certNm && !certSeen.has(ct.certNm)) { certSeen.add(ct.certNm); sidebarCerts.push({ name: ct.certNm }) } })
  if (d.relCertNmCont) d.relCertNmCont.split(',').map(s => s.trim()).forEach(n => { if (n && !certSeen.has(n)) { certSeen.add(n); sidebarCerts.push({ name: n }) } })
  ;(enc?.certiList || []).forEach(ct => { const k = ct?.certi || ct?.name; if (k && !certSeen.has(k)) { certSeen.add(k); sidebarCerts.push({ name: k }) } })

  const merged = {
    name: '간호사', heroCategory, heroTitle: '간호사',
    heroIntro: d.workSum || (summary ? summary.split('.')[0] + '.' : ''),
    heroTags: Array.from(tagSet),
    overviewWork: { main: summary || d.reprDutyCont || null, workStrong: null, workPlace: null, physicalAct: null, workEnv: d.jobWorkEnvCont || null },
    overviewProspect: { main: enc?.forecastList || g.salProspect?.jobProspect || null, forecastList: enc?.forecastList || null, jobProspect: g.salProspect?.jobProspect || g.summary?.jobProspect || null, jobSumProspect: g.salProspect?.jobSumProspect || null },
    overviewAbilities: { abilityList: enc?.abilityList || null, technKnow: g.path?.technKnow || null, eduLevel: null, skillYear: null, knowledge: d.needKnowlgCont || null, abilities: d.needAbilCont || null },
    overviewAptitude: { aptitudeList: enc?.aptitudeList || null, interestList: enc?.interestList || null, satisfaction, aptitude: d.jobAptdCont || null, interests: d.jobIntrstCont || null, personality: d.jobChrCont || null, values: d.jobValCont || null },
    overviewSalary,
    detailEducation: { majorDistribution: g.path?.majorDistribution || convertMajorChart(enc?.majorChart), educationDistribution: g.path?.educationDistribution || convertEduChart(enc?.eduChart) },
    detailReady: { recruit: enc?.jobReadyList?.recruit || null, certificate: enc?.jobReadyList?.certificate || null, training: enc?.jobReadyList?.training || null, curriculum: enc?.jobReadyList?.curriculum || null, researchList: enc?.researchList || null },
    detailClassification: { kecoList: g.path?.kecoList || null, empJobNm: baseInfo?.emp_job_nm || null, stdJobNm: baseInfo?.std_job_nm || null },
    detailWlb: { wlb: baseInfo?.wlb || null, social: baseInfo?.social || null },
    detailIndicators: enc?.indicatorChart || null,
    charKnowledge: (g.ablKnwEnv.Knwldg.length > 0 || g.ablKnwEnv.KnwldgCmpr.length > 0) ? { Knwldg: g.ablKnwEnv.Knwldg, KnwldgCmpr: g.ablKnwEnv.KnwldgCmpr, KnwldgLvl: g.ablKnwEnv.KnwldgLvl, KnwldgLvlCmpr: g.ablKnwEnv.KnwldgLvlCmpr, source: 'WORK24_JOB' } : (enc?.performList?.knowledge ? { knowledge: enc.performList.knowledge, source: 'CAREERNET' } : null),
    charStatus: (g.actv.jobActvImprtnc.length > 0 || g.actv.jobActvImprtncCmpr.length > 0) ? { jobActvImprtnc: g.actv.jobActvImprtnc, jobActvImprtncCmpr: g.actv.jobActvImprtncCmpr, jobActvLvl: g.actv.jobActvLvl, jobActvLvlCmpr: g.actv.jobActvLvlCmpr } : null,
    charEnvironment: (g.ablKnwEnv.jobsEnv.length > 0 || g.ablKnwEnv.jobsEnvCmpr.length > 0) ? { jobsEnv: g.ablKnwEnv.jobsEnv, jobsEnvCmpr: g.ablKnwEnv.jobsEnvCmpr } : null,
    charPerformance: (g.ablKnwEnv.jobAbil.length > 0 || g.ablKnwEnv.jobAbilCmpr.length > 0) ? { jobAbil: g.ablKnwEnv.jobAbil, jobAbilCmpr: g.ablKnwEnv.jobAbilCmpr, jobAbilLvl: g.ablKnwEnv.jobAbilLvl, jobAbilLvlCmpr: g.ablKnwEnv.jobAbilLvlCmpr, source: 'WORK24_JOB' } : (enc?.performList?.perform ? { perform: enc.performList.perform, source: 'CAREERNET' } : null),
    charInterest: (g.chrIntrVals.jobIntrst.length > 0 || g.chrIntrVals.jobIntrstCmpr.length > 0) ? { jobIntrst: g.chrIntrVals.jobIntrst, jobIntrstCmpr: g.chrIntrVals.jobIntrstCmpr } : null,
    charValues: (g.chrIntrVals.jobVals.length > 0 || g.chrIntrVals.jobValsCmpr.length > 0) ? { jobVals: g.chrIntrVals.jobVals, jobValsCmpr: g.chrIntrVals.jobValsCmpr } : null,
    summary, duties: summary || d.reprDutyCont || null,
    salary: gSal || cWage || null, satisfaction: gSatis || cSatis || null,
    prospect: g.salProspect?.jobProspect || g.summary?.jobProspect || null,
    workList: enc?.workList || null, performList: enc?.performList || null, abilityList: enc?.abilityList || null,
    aptitudeList: enc?.aptitudeList || null, interestList: enc?.interestList || null, forecastList: enc?.forecastList || null,
    indicatorChart: enc?.indicatorChart || null, relVideoList: enc?.relVideoList || null, relSolList: enc?.relSolList || null,
    relJinsolList: enc?.relJinsolList || null, researchList: enc?.researchList || null,
    wlb: baseInfo?.wlb || null, social: baseInfo?.social || null,
    workSum: d.workSum || null, doWork: d.doWork || null, knowledge: d.needKnowlgCont || null,
    abilities: d.needAbilCont || null, personality: d.jobChrCont || null, values: d.jobValCont || null,
    environment: d.jobWorkEnvCont || null, aptitude: d.jobAptdCont || null,
    sidebarJobs: sidebarJobs.length > 0 ? sidebarJobs : null, sidebarMajors: sidebarMajors.length > 0 ? sidebarMajors : null,
    sidebarOrgs: sidebarOrgs.length > 0 ? sidebarOrgs : null, sidebarCerts: sidebarCerts.length > 0 ? sidebarCerts : null,
    relatedJobs: sidebarJobs, relatedMajors: sidebarMajors, relatedCertificates: [...certSeen], relatedOrganizations: sidebarOrgs,
    sources: ['CAREERNET', 'WORK24_JOB', 'WORK24_DJOB']
  }

  const mergedJson = JSON.stringify(merged)
  fs.writeFileSync('tmp_nurse_merged.json', mergedJson)

  console.log('\n=== 결과 ===')
  console.log('크기:', mergedJson.length, 'bytes')
  console.log('hero:', JSON.stringify(merged.heroCategory))
  console.log('sidebar:', sidebarJobs.length, 'jobs,', sidebarMajors.length, 'majors,', sidebarOrgs.length, 'orgs,', sidebarCerts.length, 'certs')
  console.log('char: K=' + !!merged.charKnowledge, 'S=' + !!merged.charStatus, 'E=' + !!merged.charEnvironment, 'P=' + !!merged.charPerformance, 'I=' + !!merged.charInterest, 'V=' + !!merged.charValues)
}
main().catch(console.error)

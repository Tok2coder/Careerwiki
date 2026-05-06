#!/usr/bin/env node
// scripts/skill-cache/fix-detailready-broken.cjs
//
// 사고 직업 surgical fix:
//   - detailReady.{curriculum,recruit,training} 배열 항목 본문 [N] (글로벌 idx) →
//     field-local 1..N 변환
//   - _sources["detailReady.X"]에 본문 [N] 첫 등장 순서대로 글로벌 출처 복제
//   - _sources 전체 글로벌 id 1..N 재정렬 (idxGap 사고 차단)
//   - 산문 본문 / careerTree / sal / overview / sidebar 등 다른 필드 절대 수정 X
//
// 사용:
//   node scripts/skill-cache/fix-detailready-broken.cjs --slug=국무총리 --dry-run
//   node scripts/skill-cache/fix-detailready-broken.cjs --slug=국무총리 --apply
//
// 환경:
//   ADMIN_SECRET (또는 --admin-secret=...)

'use strict';

const path = require('path');
const fs = require('fs');
const REPO_ROOT = path.resolve(__dirname, '..', '..');

const args = process.argv.slice(2).reduce((acc, a) => {
  const m = a.match(/^--([^=]+)(?:=(.+))?$/);
  if (m) acc[m[1]] = m[2] ?? true;
  return acc;
}, {});

const ADMIN_SECRET = args['admin-secret'] || process.env.ADMIN_SECRET || 'careerwiki-admin-2026';
const DRY_RUN = !!args['dry-run'];
const APPLY = !!args.apply;

if (!args.slug) { console.error('--slug=직업슬러그 필수'); process.exit(1); }
if (!DRY_RUN && !APPLY) { console.error('--dry-run 또는 --apply 필수'); process.exit(1); }

const ARRAY_SUBS = ['curriculum', 'recruit', 'training'];

// 2026-05-06 후속 사고 차단: sidebar 영역 _sources 등록 시 orphan 발생.
// 새 _sources 빌드 시 이 영역은 항상 제거.
const SIDEBAR_DROP = ['sidebarCerts', 'sidebarOrgs', 'sidebarMajors', 'sidebarJobs'];

// 페이지 _sources 등록 순서대로 글로벌 id 1..N 재부여 시 _sources의 fieldKey 순서가
// 페이지 표시 순서와 비슷해야 자연스럽다. enhance가 작성한 순서를 그대로 쓰되,
// 새로 추가한 detailReady.X 항목은 끝에 추가.
function flattenSources(sources) {
  const flat = [];
  for (const [fk, arr] of Object.entries(sources)) {
    if (!Array.isArray(arr)) continue;
    arr.forEach((s, idx) => flat.push({ fieldKey: fk, idx, src: s }));
  }
  return flat;
}

// 본문 → 글로벌 [N] 첫 등장 순서로 추출
function firstAppearMarkers(text) {
  if (typeof text !== 'string') return [];
  const matches = [...text.matchAll(/\[(\d+)\]/g)].map(m => Number(m[1]));
  const seen = new Set();
  const fa = [];
  for (const n of matches) if (!seen.has(n)) { seen.add(n); fa.push(n); }
  return fa;
}

// 본문 마커 [global] → [local] 치환 (mapping 객체 받아서)
function rewriteMarkers(text, mapping) {
  if (typeof text !== 'string') return text;
  return text.replace(/\[(\d+)\]/g, (m, n) => {
    const k = Number(n);
    if (mapping[k] !== undefined) return `[${mapping[k]}]`;
    return m;
  });
}

async function fetchEditData(slug) {
  const url = `https://careerwiki.org/api/job/${encodeURIComponent(slug)}/edit-data`;
  const r = await fetch(url, { headers: { 'Cache-Control': 'no-cache' } });
  if (r.status !== 200) throw new Error(`edit-data HTTP ${r.status}`);
  const j = await r.json();
  if (!j.success) throw new Error(`edit-data error: ${j.error}`);
  return j;
}

async function fetchJobIdAndUcj(slug) {
  // edit-data는 entityId 포함
  const j = await fetchEditData(slug);
  return { id: j.entityId, data: j.data };
}

async function postEdit(jobId, payload) {
  const url = `https://careerwiki.org/api/job/${jobId}/edit`;
  const r = await fetch(url, {
    method: 'POST',
    headers: {
      'X-Admin-Secret': ADMIN_SECRET,
      'Content-Type': 'application/json; charset=utf-8',
    },
    body: JSON.stringify(payload),
  });
  const txt = await r.text();
  if (r.status >= 400) throw new Error(`POST edit ${r.status}: ${txt.slice(0, 500)}`);
  return { status: r.status, body: txt };
}

(async () => {
  const slug = args.slug;
  console.log(`[fix-detailready-broken] ${slug} ${DRY_RUN ? '(DRY-RUN)' : '(APPLY)'}`);

  const { id: jobId, data } = await fetchJobIdAndUcj(slug);
  const sources = data._sources || {};
  const dr = data.detailReady || {};

  // 1) 글로벌 id → 출처 dict (기존 _sources에서 추출)
  const globalIdToSrc = {};
  for (const [fk, arr] of Object.entries(sources)) {
    if (!Array.isArray(arr)) continue;
    for (const s of arr) {
      if (s && typeof s === 'object' && typeof s.id === 'number') {
        globalIdToSrc[s.id] = { ...s, _origField: fk };
      }
    }
  }

  // 2) 각 detailReady.X 처리
  const newDrFields = {};      // sub → 새 본문 array
  const newDrSources = {};     // sub → 새 _sources["detailReady.X"] array (id 미포함, 나중에 부여)
  const drMappings = {};       // sub → {global: local}
  const fixSummary = [];

  for (const sub of ARRAY_SUBS) {
    const items = dr[sub];
    if (!Array.isArray(items) || items.length === 0) {
      // 그대로 보존 (수정 X)
      if (items !== undefined) newDrFields[sub] = items;
      if (Array.isArray(sources[`detailReady.${sub}`])) {
        newDrSources[sub] = sources[`detailReady.${sub}`].map(s => ({ ...s }));
      }
      continue;
    }

    // 본문 합본
    const allText = items.map(it => typeof it === 'string' ? it : (it && (it.text || it.title)) || '').join('\n');
    const fa = firstAppearMarkers(allText);
    const oldSrcArr = sources[`detailReady.${sub}`] || [];
    const oldSrcLen = oldSrcArr.length;

    // 모든 본문 [N]이 1..oldSrcLen 안 — field-local 깔끔. 손대지 마.
    if (fa.every(n => n >= 1 && n <= oldSrcLen)) {
      newDrFields[sub] = items;
      newDrSources[sub] = oldSrcArr.map(s => ({ ...s }));
      continue;
    }

    // 일부 본문 [N]이 srcLen 초과 — 기존 출처 보존하고 끝에만 추가
    const newSrcArrNoId = oldSrcArr.map(s => ({ ...s, id: undefined }));
    const mapping = {}; // 글로벌 [N] → 새 field-local idx
    const addedFromGlobal = [];
    for (const n of fa) {
      if (n >= 1 && n <= oldSrcLen) {
        // field-local 안 — identity (mapping[n] = n)
        mapping[n] = n;
      } else {
        // srcLen 초과 — 글로벌 cross-reference. 글로벌 _sources에서 복제 후 끝에 추가
        const original = globalIdToSrc[n];
        if (original) {
          newSrcArrNoId.push({ text: original.text, url: original.url });
          addedFromGlobal.push({ globalId: n, originField: original._origField });
        } else {
          // 글로벌 _sources에도 없음 — 진짜 broken (placeholder)
          newSrcArrNoId.push({
            text: `(누락된 출처 — 글로벌 id ${n} 미등록. 검토 필요)`,
            url: '',
          });
          addedFromGlobal.push({ globalId: n, originField: null });
          console.warn(`  ⚠️ ${slug} detailReady.${sub} 본문 [${n}]이 글로벌 _sources에 없음 — placeholder 등록`);
        }
        mapping[n] = newSrcArrNoId.length;
      }
    }

    // 본문 마커 변환: identity는 변경 X, srcLen 초과한 것만 새 local idx로
    const needRewrite = Object.entries(mapping).some(([g, l]) => Number(g) !== l);
    const newItems = needRewrite
      ? items.map(it => {
          if (typeof it === 'string') return rewriteMarkers(it, mapping);
          if (it && typeof it === 'object') {
            return {
              ...it,
              text: typeof it.text === 'string' ? rewriteMarkers(it.text, mapping) : it.text,
              title: typeof it.title === 'string' ? rewriteMarkers(it.title, mapping) : it.title,
            };
          }
          return it;
        })
      : items;

    drMappings[sub] = mapping;
    newDrFields[sub] = newItems;
    newDrSources[sub] = newSrcArrNoId;
    fixSummary.push({
      sub,
      oldSrcLen,
      newSrcLen: newSrcArrNoId.length,
      added: addedFromGlobal.map(a => `globalId=${a.globalId} (${a.originField || 'MISSING'})`).join(', '),
      mapping: Object.entries(mapping).map(([g, l]) => `${g}→${l}`).join(', '),
    });
  }

  // 3) _sources 재구성: 산문 sub-field는 그대로 + detailReady.X는 newDrSources로 교체
  //    글로벌 id 1..N 재부여 (등록 순서 = 산문 fields 먼저, detailReady fields 나중)
  //    sidebar 영역(sidebarCerts/Orgs/Majors/Jobs)은 항상 제거 (orphan 차단)
  const newSources = {};
  let nextId = 1;
  const droppedSidebar = [];

  // 산문 + 기타 (detailReady.X / sidebar 제외)
  for (const [fk, arr] of Object.entries(sources)) {
    if (fk.startsWith('detailReady.')) continue;
    if (SIDEBAR_DROP.includes(fk)) {
      // 2026-05-06: sidebar 영역은 _sources에 등록 X. 자체 {name, url} 사용.
      if (Array.isArray(arr) && arr.length > 0) {
        droppedSidebar.push({ field: fk, count: arr.length, ids: arr.map(s => s && s.id).filter(x => x != null) });
      }
      continue; // 새 _sources에 추가 X
    }
    if (!Array.isArray(arr)) { newSources[fk] = arr; continue; }
    newSources[fk] = arr.map(s => ({ ...s, id: nextId++ }));
  }

  // detailReady.X — newDrSources에 있는 것으로 교체
  for (const sub of ARRAY_SUBS) {
    if (newDrSources[sub] && newDrSources[sub].length > 0) {
      newSources[`detailReady.${sub}`] = newDrSources[sub].map(s => ({ ...s, id: nextId++ }));
    } else if (Array.isArray(sources[`detailReady.${sub}`])) {
      // 원래 있었는데 fix 안 된 경우 — 그대로 (재 id 부여만)
      newSources[`detailReady.${sub}`] = sources[`detailReady.${sub}`].map(s => ({ ...s, id: nextId++ }));
    }
  }

  // 산문 영역의 _sources id가 바뀌었을 수 있다 (idxGap fix). 산문 본문은 손대지 말라
  // 명시했지만, 글로벌 id 변경은 시스템이 footnoteMap으로 변환하므로 본문 [N]은
  // field-local 1..localLen이고 그것은 변경 X. 따라서 산문 본문은 안전.
  //
  // 단 enhance가 산문 본문에도 글로벌 idx를 박았다면 (사고) 산문 본문이 깨질 위험.
  // 안전을 위해 idxGap이 있으면 fix하되, 산문 본문 _sources 길이만큼 [N] 사용
  // 가정. 본문은 손대지 마.

  // 4) 새 페이로드 빌드 (detailReady + _sources만 변경, 다른 필드는 절대 X)
  const newDr = { ...dr };
  for (const sub of ARRAY_SUBS) {
    if (newDrFields[sub] !== undefined) newDr[sub] = newDrFields[sub];
  }

  // researchList / pathExplore 등은 그대로 (수정 X — already preserved by spread)

  // sidebar 영역은 server-side merge 정책상 명시적 delete 필요
  // (sources 객체에 fieldKey 없으면 기존 값 유지됨 — job-editor.ts:543-564)
  const sourcesWithDeletes = { ...newSources };
  for (const sf of SIDEBAR_DROP) {
    if (sources[sf]) sourcesWithDeletes[sf] = { delete: true };
  }

  const payload = {
    fields: {
      detailReady: newDr,
    },
    sources: sourcesWithDeletes,
    changeSummary: '[job-data-enhance][post-fix-detailready] detailReady 배열 본문 [N] 글로벌→field-local 재번호 + _sources idx 재정렬 + sidebar _sources 제거 (2026-05-06 사고 차단)',
  };

  // 5) 출력
  console.log(`\n--- fix summary ---`);
  if (fixSummary.length === 0 && droppedSidebar.length === 0) {
    console.log(`  변경 없음 (이미 field-local 또는 detailReady 배열 없음, sidebar _sources도 없음)`);
  } else {
    fixSummary.forEach(s => {
      console.log(`  detailReady.${s.sub}: srcLen ${s.oldSrcLen} → ${s.newSrcLen}`);
      console.log(`     mapping: ${s.mapping}`);
      if (s.added) console.log(`     added (cross-ref): ${s.added}`);
    });
    droppedSidebar.forEach(d => {
      console.log(`  🚨 ${d.field}: ${d.count}건 _sources 제거 (orphan 차단, ids=[${d.ids.join(',')}])`);
    });
  }
  console.log(`\n새 _sources 글로벌 id 분포:`);
  for (const [fk, arr] of Object.entries(newSources)) {
    if (Array.isArray(arr)) {
      const ids = arr.map(s => s.id).join(',');
      console.log(`  ${fk} (${arr.length}): id=[${ids}]`);
    }
  }

  // 6) DRY-RUN: 끝
  if (DRY_RUN) {
    const outPath = path.join(REPO_ROOT, 'scripts', 'skill-cache', `_fix-${slug}.json`);
    fs.writeFileSync(outPath, JSON.stringify(payload, null, 2), 'utf8');
    console.log(`\n[DRY-RUN] payload 저장: ${outPath}`);
    return;
  }

  // 7) APPLY: POST
  console.log(`\n[APPLY] POST /api/job/${jobId}/edit ...`);
  const res = await postEdit(jobId, payload);
  console.log(`[APPLY] HTTP ${res.status}: ${res.body.slice(0, 300)}`);

  // 8) Verify (재 fetch 후 audit-via-api와 같은 검사)
  console.log(`\n[VERIFY] re-fetch ...`);
  await new Promise(r => setTimeout(r, 1000)); // cache 안전 대기
  const after = await fetchEditData(slug);
  const afterSources = after.data._sources || {};
  const afterDr = after.data.detailReady || {};
  let stillBroken = false;
  for (const sub of ARRAY_SUBS) {
    const items = afterDr[sub];
    if (!Array.isArray(items)) continue;
    const allText = items.map(it => typeof it === 'string' ? it : (it && (it.text || it.title)) || '').join('\n');
    const arr = afterSources[`detailReady.${sub}`] || [];
    const ms = (allText.match(/\[(\d+)\]/g) || []).map(m => Number(m.slice(1, -1)));
    const broken = [...new Set(ms.filter(n => n < 1 || n > arr.length))];
    if (broken.length > 0) {
      console.error(`  ❌ detailReady.${sub} 여전히 broken=[${broken.join(',')}] srcLen=${arr.length}`);
      stillBroken = true;
    } else {
      console.log(`  ✅ detailReady.${sub} OK (srcLen=${arr.length}, body markers=${ms.length})`);
    }
  }
  // sidebar _sources 잔존 검사
  for (const sf of SIDEBAR_DROP) {
    const arr = afterSources[sf];
    if (Array.isArray(arr) && arr.length > 0) {
      console.error(`  ❌ ${sf} _sources 여전히 ${arr.length}건 등록됨 (제거 실패)`);
      stillBroken = true;
    } else {
      console.log(`  ✅ ${sf} _sources 0건 (정상)`);
    }
  }
  if (stillBroken) process.exit(2);
})().catch(e => { console.error(e); process.exit(1); });

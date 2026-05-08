#!/usr/bin/env node
// Phase A 검증 전용 read-only 스크립트.
// 방사선사 + 게임-프로그래머 prod /edit-data fetch → 본문 [N] 마커 vs _sources 매칭.
// POST 0회. sal/wage 미접촉.

'use strict';

const SLUGS = ['방사선사', '게임-프로그래머'];

const BODY_FIELDS = [
  'summary',
  'way',
  'trivia',
  'overviewProspect.main',
  'overviewSalary.sal',
  'overviewWork.main',
  'detailWlb.wlbDetail',
  'detailWlb.socialDetail',
  'detailWlb.workLifeBalance',
  'detailWlb.socialContribution',
  'detailWlb.workLifeDetail',
  'detailReady.curriculum',
  'detailReady.recruit',
  'detailReady.training',
  'detailReady.research',
  'detailWork.main',
  'detailWork.detail',
  'detailGrowth.main',
  'detailGrowth.detail',
  'overviewAbilities.technKnow',
];

function getNested(obj, p) {
  if (!obj) return undefined;
  if (obj[p] !== undefined) return obj[p];
  let cur = obj;
  for (const part of p.split('.')) { if (cur == null) return undefined; cur = cur[part]; }
  return cur;
}

function extractMarkers(value) {
  if (value == null) return null;
  if (typeof value === 'string') {
    const m = [...value.matchAll(/\[(\d+)\]/g)].map(x => Number(x[1]));
    return { kind: 'string', markers: m, length: value.length };
  }
  if (Array.isArray(value)) {
    const items = [];
    for (let i = 0; i < value.length; i++) {
      const v = value[i];
      let text = '';
      if (typeof v === 'string') text = v;
      else if (v && typeof v === 'object') {
        text = v.text || v.curriculum || v.recruit || v.training || v.research || v.value || v.name || '';
      }
      const m = [...String(text).matchAll(/\[(\d+)\]/g)].map(x => Number(x[1]));
      items.push({ idx: i, markers: m, preview: String(text).slice(0, 60) });
    }
    return { kind: 'array', items };
  }
  return null;
}

function summarizeSources(sources, fieldKey) {
  const arr = sources?.[fieldKey];
  if (!arr) return { exists: false, length: 0, ids: [] };
  if (!Array.isArray(arr)) return { exists: true, length: 'NOT_ARRAY', ids: [] };
  return {
    exists: true,
    length: arr.length,
    ids: arr.map((s, i) => (s && typeof s === 'object' && typeof s.id === 'number') ? s.id : (i + 1)),
    urls: arr.map(s => (s && typeof s === 'object') ? (s.url || s.text || '') : String(s)).map(u => String(u).slice(0, 80)),
  };
}

(async () => {
  for (const slug of SLUGS) {
    const url = `https://careerwiki.org/api/job/${encodeURIComponent(slug)}/edit-data`;
    process.stdout.write(`\n========== ${slug} ==========\n`);
    process.stdout.write(`URL: ${url}\n`);
    let res;
    try {
      res = await fetch(url, { headers: { 'Cache-Control': 'no-cache' } });
    } catch (e) {
      console.error('FETCH FAIL', e.message);
      continue;
    }
    if (res.status !== 200) {
      console.error('HTTP', res.status);
      continue;
    }
    const j = await res.json();
    if (!j.success) { console.error('API failure', j.error); continue; }
    const data = j.data;
    const sources = data._sources || {};

    process.stdout.write(`\n_sources keys (${Object.keys(sources).length}): ${JSON.stringify(Object.keys(sources))}\n`);

    process.stdout.write('\n[Body 마커 vs _sources 매칭]\n');
    for (const field of BODY_FIELDS) {
      const v = getNested(data, field);
      const ext = extractMarkers(v);
      if (!ext) continue;
      const srcSummary = summarizeSources(sources, field);

      if (ext.kind === 'string') {
        if (ext.markers.length === 0 && !srcSummary.exists) continue; // 둘 다 없음 — skip
        const maxM = ext.markers.length ? Math.max(...ext.markers) : 0;
        const issue =
          (ext.markers.length > 0 && !srcSummary.exists) ? '❌ ORPHAN(no _sources)' :
          (ext.markers.length === 0 && srcSummary.exists && srcSummary.length > 0) ? '⚠️ SOURCES-NO-MARKERS' :
          (maxM > srcSummary.length) ? `❌ BROKEN-REF (max marker [${maxM}] > srcLen ${srcSummary.length})` :
          '✓';
        process.stdout.write(`  ${field}: markers=[${ext.markers.join(',')}] (${ext.markers.length}) | srcLen=${srcSummary.length} ids=[${(srcSummary.ids||[]).join(',')}]  ${issue}\n`);
      } else if (ext.kind === 'array') {
        // detailReady 배열은 field-local idx — 항목별 마커 분포 보여주고, sources length와 비교
        const totalMarkers = ext.items.reduce((acc, it) => acc + it.markers.length, 0);
        if (totalMarkers === 0 && !srcSummary.exists) continue;
        const allMarkers = [];
        for (const it of ext.items) for (const m of it.markers) allMarkers.push(m);
        const maxM = allMarkers.length ? Math.max(...allMarkers) : 0;
        const issue =
          (totalMarkers > 0 && !srcSummary.exists) ? '❌ ORPHAN(no _sources)' :
          (totalMarkers === 0 && srcSummary.exists && srcSummary.length > 0) ? '⚠️ SOURCES-NO-MARKERS' :
          (maxM > srcSummary.length) ? `❌ BROKEN-REF (max marker [${maxM}] > srcLen ${srcSummary.length})` :
          '✓';
        process.stdout.write(`  ${field}[]: items=${ext.items.length} markers=[${allMarkers.join(',')}] (${totalMarkers}) | srcLen=${srcSummary.length} ids=[${(srcSummary.ids||[]).join(',')}]  ${issue}\n`);
        // 각 item per-line
        for (const it of ext.items) {
          if (it.markers.length === 0) continue;
          process.stdout.write(`     [${it.idx}] markers=[${it.markers.join(',')}] "${it.preview}..."\n`);
        }
      }
    }

    process.stdout.write('\n[_sources에는 있는데 위 BODY_FIELDS에 매핑 못 한 키]\n');
    for (const k of Object.keys(sources)) {
      if (BODY_FIELDS.includes(k)) continue;
      const arr = sources[k];
      const len = Array.isArray(arr) ? arr.length : 'NOT_ARRAY';
      process.stdout.write(`  ${k}: srcLen=${len}\n`);
    }
  }
})();

#!/usr/bin/env node
const fs = require('fs');

const stdin = fs.readFileSync(0, 'utf8');
let input;
try { input = JSON.parse(stdin); } catch { process.exit(0); }

const cmd = input?.tool_input?.command || '';
if (!/\bcurl\b/.test(cmd)) process.exit(0);

const inlineDataMatch = cmd.match(/(?:--data(?:-raw|-binary)?|-d)\s+(?!@)('([^']*)'|"([^"]*)"|([^\s]+))/);
if (!inlineDataMatch) process.exit(0);
const payload = inlineDataMatch[2] ?? inlineDataMatch[3] ?? inlineDataMatch[4] ?? '';
if (!payload) process.exit(0);

if (!/[가-힣ᄀ-ᇿ㄰-㆏]/.test(payload)) process.exit(0);

console.error('🛑 BLOCKED: curl -d 인라인 페이로드에 한글 포함');
console.error('이유: Windows bash + curl 조합에서 mojibake (한글 깨짐) 빈발. prod에 깨진 한글 저장됨.');
console.error('조치:');
console.error('  1. 페이로드를 .json 파일로 저장 (UTF-8, BOM 없이)');
console.error('  2. curl -d @file.json 사용');
console.error('  3. 헤더 -H "Content-Type: application/json; charset=utf-8" 명시');
process.exit(2);

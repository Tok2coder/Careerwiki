#!/usr/bin/env node
// 2026-05-25 사고 재발 방지 — PowerShell tool 호출 차단.
// Windows 환경에서 sub-agent가 default shell (PowerShell) 자체 선택 → 사용자 prompt deny 사고.
// 강제: Bash (Git Bash, WSL) 만 사용. PowerShell / pwsh / Invoke-RestMethod 모두 차단.

const fs = require('fs');

const stdin = fs.readFileSync(0, 'utf8');
let input;
try { input = JSON.parse(stdin); } catch { process.exit(0); }

const toolName = input?.tool_name || '';
if (toolName !== 'PowerShell' && toolName !== 'powershell' && toolName !== 'pwsh') process.exit(0);

const msg = `[powershell-block] PowerShell tool 호출 차단 — Bash 만 사용.\n` +
  `사고 컨텍스트: 2026-05-25 sub-agent가 Windows default shell (PowerShell) 자체 선택 → 사용자 prompt deny 사고.\n` +
  `강제: 모든 shell 호출 = Bash tool (Git Bash / WSL). PowerShell / pwsh / Invoke-RestMethod 절대 X.`;
console.error(msg);
process.exit(2);

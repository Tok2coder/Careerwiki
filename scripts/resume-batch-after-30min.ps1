#!/usr/bin/env pwsh
# GPU 드라이버 안정화 대기용 일회성 스크립트.
# 30분 Start-Sleep 후 배치를 Hidden 모드로 재기동.
# 외부에서 powershell.exe -WindowStyle Hidden -File 로 띄워지면
# 부모 Claude 세션 / 터미널과 독립적으로 동작한다.

$ResumeLogPath = 'C:\Users\user\Careerwiki\scripts\resume-batch.log'
$WaitSec = 1800  # 30분

function Write-ResumeLog([string]$msg) {
  $ts = (Get-Date).ToString('yyyy-MM-dd HH:mm:ss')
  "[$ts] $msg" | Out-File -FilePath $ResumeLogPath -Append -Encoding UTF8
}

Write-ResumeLog "30분 대기 시작 (GPU 드라이버 휴식)"
Write-ResumeLog ("wake target: " + (Get-Date).AddSeconds($WaitSec).ToString('yyyy-MM-dd HH:mm:ss'))

Start-Sleep -Seconds $WaitSec

# GPU 상태 기록
try {
  $smi = & nvidia-smi --query-gpu=memory.used,pstate,clocks.current.graphics,clocks.current.memory --format=csv,noheader 2>$null
  Write-ResumeLog "GPU 상태 (재개 직전): $smi"
} catch {}

# 배치 재기동 (Hidden, 분리된 프로세스)
try {
  $proc = Start-Process -FilePath 'C:\Program Files\nodejs\node.exe' `
    -ArgumentList 'scripts/batch-regenerate-all-images.cjs' `
    -WorkingDirectory 'C:\Users\user\Careerwiki' `
    -WindowStyle Hidden `
    -PassThru
  Write-ResumeLog ("배치 재기동 완료 PID=" + $proc.Id)
} catch {
  Write-ResumeLog ("배치 재기동 실패: " + $_.Exception.Message)
}

$log = 'C:\Users\user\Careerwiki\.tmp-cfsvc-ls.txt'
Set-Content -Path $log -Value "NUKE_START $(Get-Date -Format o)"
try {
  Stop-Service cloudflared -Force -ErrorAction SilentlyContinue
  Add-Content $log "stop-service done"
} catch { Add-Content $log "stop-service err: $_" }
Start-Sleep -Seconds 1
try {
  Get-Process cloudflared -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
  Add-Content $log "stop-process done"
} catch { Add-Content $log "stop-process err: $_" }
try {
  Set-Service cloudflared -StartupType Disabled -ErrorAction SilentlyContinue
  Add-Content $log "disabled done"
} catch { Add-Content $log "disable err: $_" }
# Uninstall service entirely so it cannot auto-start again
try {
  & 'C:\Program Files (x86)\cloudflared\cloudflared.exe' service uninstall 2>&1 | Out-File -Append -Encoding utf8 $log
  Add-Content $log "uninstall attempted"
} catch { Add-Content $log "uninstall err: $_" }
Start-Sleep -Seconds 2
$svc = Get-Service cloudflared -ErrorAction SilentlyContinue
if ($svc) { Add-Content $log "svc-still-present status=$($svc.Status) start=$($svc.StartType)" } else { Add-Content $log "svc-removed" }
$procs = Get-Process cloudflared -ErrorAction SilentlyContinue
if ($procs) { Add-Content $log "procs-remaining: $($procs.Id -join ',')" } else { Add-Content $log "procs-none" }
Add-Content $log "NUKE_END $(Get-Date -Format o)"

$log = 'C:\Users\user\Careerwiki\.tmp-cfsvc-ls.txt'
Set-Content -Path $log -Value "START $(Get-Date -Format o)"

# 1. Prepare log dir
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.cloudflared\logs" | Out-Null
Add-Content $log "log-dir ready"

# 2. Write wrapper cmd (absolute cloudflared path — not on PATH)
$cfExe = 'C:\Program Files (x86)\cloudflared\cloudflared.exe'
$wrapperPath = "$env:USERPROFILE\.cloudflared\run-tunnel.cmd"
$wrapperContent = @"
@echo off
"$cfExe" --config "%USERPROFILE%\.cloudflared\config.yml" tunnel run cw-bridge >> "%USERPROFILE%\.cloudflared\logs\tunnel.log" 2>&1
"@
Set-Content -Path $wrapperPath -Encoding ASCII -Value $wrapperContent
Add-Content $log "wrapper written: $wrapperPath"

# 3. Remove old task if exists, register new
Unregister-ScheduledTask -TaskName "CWBridgeTunnel" -Confirm:$false -ErrorAction SilentlyContinue

$action = New-ScheduledTaskAction -Execute $wrapperPath
$trigger = New-ScheduledTaskTrigger -AtLogOn -User "$env:USERNAME"
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -RestartCount 3 -RestartInterval (New-TimeSpan -Minutes 1) -StartWhenAvailable -ExecutionTimeLimit ([TimeSpan]::Zero) -Hidden
$principal = New-ScheduledTaskPrincipal -UserId "$env:USERNAME" -LogonType Interactive -RunLevel Limited

Register-ScheduledTask -TaskName "CWBridgeTunnel" -Action $action -Trigger $trigger -Settings $settings -Principal $principal -Description "Cloudflare Tunnel for CareerWiki bridge" -Force | Out-Null
Add-Content $log "scheduled-task registered"

# 4. Start immediately
Start-ScheduledTask -TaskName "CWBridgeTunnel"
Add-Content $log "task started at $(Get-Date -Format o)"

# 5. Wait for cloudflared to come up
for ($i = 0; $i -lt 20; $i++) {
  Start-Sleep -Seconds 1
  $p = Get-Process cloudflared -ErrorAction SilentlyContinue
  if ($p) { Add-Content $log "cloudflared pid=$($p.Id -join ',') after ${i}s"; break }
}
if (-not $p) { Add-Content $log "cloudflared NOT STARTED after 20s" }

# 6. Give tunnel time to establish connection
Start-Sleep -Seconds 10

# 7. Read latest log tail
if (Test-Path "$env:USERPROFILE\.cloudflared\logs\tunnel.log") {
  Add-Content $log "---TUNNEL.LOG TAIL---"
  Get-Content "$env:USERPROFILE\.cloudflared\logs\tunnel.log" -Tail 40 | ForEach-Object { Add-Content $log $_ }
} else {
  Add-Content $log "tunnel.log does not exist yet"
}

Add-Content $log "DONE $(Get-Date -Format o)"

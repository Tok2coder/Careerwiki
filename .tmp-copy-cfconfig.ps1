$dst = 'C:\Windows\System32\config\systemprofile\.cloudflared'
if (-not (Test-Path $dst)) { New-Item -ItemType Directory -Force -Path $dst | Out-Null }
Copy-Item -Force "$env:USERPROFILE\.cloudflared\cert.pem" "$dst\cert.pem"
Copy-Item -Force "$env:USERPROFILE\.cloudflared\config.yml" "$dst\config.yml"
Copy-Item -Force "$env:USERPROFILE\.cloudflared\9f62ef69-0fbf-4e24-8073-6e0443048af5.json" "$dst\9f62ef69-0fbf-4e24-8073-6e0443048af5.json"
Restart-Service cloudflared -Force
Start-Sleep -Seconds 3
Get-ChildItem $dst | Select-Object Name,Length | Format-Table | Out-File -Encoding utf8 C:\Users\user\Careerwiki\.tmp-cfsvc-ls.txt
Get-Service cloudflared | Select-Object Name,Status | Format-List | Out-File -Append -Encoding utf8 C:\Users\user\Careerwiki\.tmp-cfsvc-ls.txt

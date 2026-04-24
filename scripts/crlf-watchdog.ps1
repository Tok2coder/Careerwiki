$f = 'C:\Users\user\Careerwiki\scripts\start-local-image-bridge-watchdog.cmd'
$t = [System.IO.File]::ReadAllText($f) -replace "(?<!\r)\n", "`r`n"
[System.IO.File]::WriteAllText($f, $t, [System.Text.Encoding]::Default)
Write-Host "CRLF done"

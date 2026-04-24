$startupDir = [Environment]::GetFolderPath('Startup')
$shortcutPath = Join-Path $startupDir 'CareerWiki Local Image Bridge.lnk'
$targetPath = 'C:\Windows\System32\cmd.exe'
$arguments = '/c "C:\Users\user\Careerwiki\scripts\start-local-image-bridge.cmd"'
$workingDirectory = 'C:\Users\user\Careerwiki'

$shell = New-Object -ComObject WScript.Shell
$shortcut = $shell.CreateShortcut($shortcutPath)
$shortcut.TargetPath = $targetPath
$shortcut.Arguments = $arguments
$shortcut.WorkingDirectory = $workingDirectory
$shortcut.WindowStyle = 7
$shortcut.Description = 'Start the CareerWiki local image bridge'
$shortcut.Save()

Write-Output "Created startup shortcut: $shortcutPath"

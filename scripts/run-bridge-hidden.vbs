Set WshShell = CreateObject("WScript.Shell")
WshShell.Run "cmd.exe /c ""C:\Users\user\Careerwiki\scripts\start-local-image-bridge-watchdog.cmd""", 0, True
Set WshShell = Nothing

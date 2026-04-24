@echo off
setlocal
cd /d C:\Users\user\Careerwiki
set CW_COMFY_IDLE_MINUTES=9999

:LOOP
echo [%DATE% %TIME%] [CW-WATCHDOG] Starting local-image-bridge... >> scripts\watchdog.log 2>&1
"C:\Program Files\nodejs\node.exe" scripts\local-image-bridge.cjs
echo [%DATE% %TIME%] [CW-WATCHDOG] Bridge exited (code %ERRORLEVEL%^), restarting in 10s... >> scripts\watchdog.log 2>&1
timeout /t 10 /nobreak > nul
goto LOOP

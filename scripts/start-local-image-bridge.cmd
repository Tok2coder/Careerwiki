@echo off
setlocal
cd /d C:\Users\user\Careerwiki
REM stdout/stderr -> bridge.log (append)
"C:\Program Files\nodejs\node.exe" scripts\local-image-bridge.cjs >> scripts\bridge.log 2>&1

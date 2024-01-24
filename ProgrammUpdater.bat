@echo off
setlocal enabledelayedexpansion

set "sourceFolder=update"

set "customKeyPath=%scriptDir%CustomKey.exe"

taskkill /F /IM CustomKey.exe 2>nul
ping -n 2 127.0.0.1 >nul
xcopy /s /y "%sourceFolder%\*" "%CD%"
ping -n 2 127.0.0.1 >nul
rd /s /q "%sourceFolder%"
ping -n 2 127.0.0.1 >nul
start "" "%customKeyPath%"
ping -n 2 127.0.0.1 >nul
exit
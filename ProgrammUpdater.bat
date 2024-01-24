@echo off
setlocal enabledelayedexpansion

set "sourceFolder=update"

set "customKeyPath=%scriptDir%CustomKey.exe"

timeout /t 2 /nobreak > nul
taskkill /F /IM CustomKey.exe 3>nul
timeout /t 2 /nobreak > nul
xcopy /s /y "%sourceFolder%\*" "%CD%"
timeout /t 2 /nobreak > nul
rd /s /q "%sourceFolder%"
timeout /t 2 /nobreak > nul
start "" "%customKeyPath%"
timeout /t 2 /nobreak > nul
exit
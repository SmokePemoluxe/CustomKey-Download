@echo off
setlocal enabledelayedexpansion

set "scriptDir=%~dp0"

set "customKeyPath=%scriptDir%CustomKey.exe"

set "uCustomKeyPath=%scriptDir%UCustomKey.exe"

taskkill /F /IM CustomKey.exe 2>nul
timeout /t 1 >nul
del "%customKeyPath%" 2>nul
timeout /t 1 >nul
ren "%uCustomKeyPath%" "CustomKey.exe"
timeout /t 1 >nul
start "" "%customKeyPath%"
timeout /t 1 >nul
exit
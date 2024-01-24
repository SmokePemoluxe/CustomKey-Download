@echo off
setlocal enabledelayedexpansion

rem Устанавливаем путь к папке update
set "sourceFolder=update"

set "customKeyPath=%scriptDir%CustomKey.exe"

taskkill /F /IM CustomKey.exe 2>nul
timeout /t 1 >nul
rem Копируем все файлы из папки update в текущую директорию с заменой
xcopy /s /y "%sourceFolder%\*" "%CD%"
timeout /t 1 >nul
rem Удаляем папку update
rd /s /q "%sourceFolder%"
timeout /t 1 >nul
start "" "%customKeyPath%"
timeout /t 1 >nul
exit
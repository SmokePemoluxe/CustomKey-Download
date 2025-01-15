@echo off
setlocal enabledelayedexpansion

:: Задаем путь к папке, откуда нужно перемещать файлы
set "sourceFolder=update"

:: Задаем путь к программе CustomKey.exe
set "customKeyPath=%~dp0CustomKey.exe"

:: Функция для проверки и завершения процесса
:kill_process
tasklist /FI "IMAGENAME eq CustomKey.exe" 2>NUL | find /I /N "CustomKey.exe">NUL
if "%ERRORLEVEL%"=="0" (
    taskkill /F /IM CustomKey.exe >nul
    timeout /t 1 /nobreak >nul
    goto kill_process
)

tasklist /FI "IMAGENAME eq CKinfo_sender.exe" 2>NUL | find /I /N "CKinfo_sender.exe">NUL
if "%ERRORLEVEL%"=="0" (
    taskkill /F /IM CKinfo_sender.exe >nul
    timeout /t 1 /nobreak >nul
    goto kill_process
)

:: Перемещаем файлы с сохранением директорий
xcopy /s /y "%sourceFolder%\*" "%CD%" >nul

:: Удаляем папку update
rd /s /q "%sourceFolder%" >nul

:: Запуск CustomKey.exe
start "" "%customKeyPath%"

:: Завершаем выполнение скрипта
exit

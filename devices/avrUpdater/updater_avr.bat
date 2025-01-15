@echo off
setlocal enabledelayedexpansion

:: Отладочный вывод: путь к текущему скрипту
echo Script Directory: %~dp0

set "scriptDir=%~dp0"
set "hexFilePath=%scriptDir%MyHexFileID.hex"

:: Отладочный вывод: путь к HEX-файлу
echo HEX File Path: %hexFilePath%

:: Задержка 1 секунда
timeout /t 1 /nobreak >nul

:: Поиск COM-портов
echo Searching for COM ports...
for /f "tokens=2 delims==" %%a in ('wmic path Win32_SerialPort get DeviceID^,PNPDeviceID /format:list ^| find "COM"') do (
    set "comPorts=!comPorts!%%a;"
)

:: Отладочный вывод: найденные COM-порты до задержки
echo COM ports before delay: !comPorts!

:: Установка режима для порта
mode MyCOMport BAUD=1200

:: Задержка 1 секунда
timeout /t 1 /nobreak >nul

set "comPortsAfterDelay="
:: Повторный поиск COM-портов после задержки
echo Searching for COM ports after delay...
for /f "tokens=2 delims==" %%a in ('wmic path Win32_SerialPort get DeviceID^,PNPDeviceID /format:list ^| find "COM"') do (
    set "comPortsAfterDelay=!comPortsAfterDelay!%%a;"
)

:: Отладочный вывод: найденные COM-порты после задержки
echo COM ports after delay: !comPortsAfterDelay!

:: Поиск нового COM-порта (разница между начальным и текущим состоянием)
for %%a in (!comPorts!) do (
    set "comPortsAfterDelay=!comPortsAfterDelay:%%a=!"
)

set "comPortsAfterDelay=!comPortsAfterDelay:;=!"

:: Отладочный вывод: COM-порт для использования
echo Selected COM port for use: !comPortsAfterDelay!

:: Отладочный вывод перед вызовом avrdude
echo Calling avrdude with parameters:
echo avrdude.exe -p m32u4 -c avr109 -P !comPortsAfterDelay! -b 57600 -U flash:w:"%hexFilePath:~2%"

:: Вызов avrdude для прошивки
call "%scriptDir%avrdude.exe" -p m32u4 -c avr109 -P !comPortsAfterDelay! -b 57600 -U flash:w:"%hexFilePath:~2%"

:: Проверка завершения
if errorlevel 1 (
    echo Error: avrdude encountered an issue.
) else (
    echo avrdude executed successfully.
)

exit
endlocal

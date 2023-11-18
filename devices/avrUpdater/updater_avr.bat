@echo off
setlocal enabledelayedexpansion

set "scriptDir=%~dp0"

set "hexFilePath=%scriptDir%MyHexFileID.hex"


for /f "tokens=2 delims==" %%a in ('wmic path Win32_SerialPort get DeviceID^,PNPDeviceID /format:list ^| find "COM"') do (
    set "comPorts=!comPorts!%%a;"
)

echo COM's before delay: !comPorts!

"%scriptDir%avrdude.exe" -p m32u4 -c avr109 -P MyCOMport -b 1200

timeout /t 2 >nul

set "comPortsAfterDelay="
for /f "tokens=2 delims==" %%a in ('wmic path Win32_SerialPort get DeviceID^,PNPDeviceID /format:list ^| find "COM"') do (
    set "comPortsAfterDelay=!comPortsAfterDelay!%%a;"
)

for %%a in (!comPorts!) do (
    set "comPortsAfterDelay=!comPortsAfterDelay:%%a=!"
)

set "comPortsAfterDelay=!comPortsAfterDelay:;=!"

echo COM's after delay: !comPortsAfterDelay!

call "%scriptDir%avrdude.exe" -p m32u4 -c avr109 -P !comPortsAfterDelay! -b 57600 -U flash:w:"%hexFilePath:~2%"

::pause
exit
endlocal

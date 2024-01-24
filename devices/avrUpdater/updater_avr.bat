@echo off
setlocal enabledelayedexpansion

set "scriptDir=%~dp0"

set "hexFilePath=%scriptDir%MyHexFileID.hex"

ping -n 2 127.0.0.1 >nul

for /f "tokens=2 delims==" %%a in ('wmic path Win32_SerialPort get DeviceID^,PNPDeviceID /format:list ^| find "COM"') do (
    set "comPorts=!comPorts!%%a;"
)

mode MyCOMport BAUD=1200

ping -n 2 127.0.0.1 >nul

set "comPortsAfterDelay="
for /f "tokens=2 delims==" %%a in ('wmic path Win32_SerialPort get DeviceID^,PNPDeviceID /format:list ^| find "COM"') do (
    set "comPortsAfterDelay=!comPortsAfterDelay!%%a;"
)

for %%a in (!comPorts!) do (
    set "comPortsAfterDelay=!comPortsAfterDelay:%%a=!"
)

set "comPortsAfterDelay=!comPortsAfterDelay:;=!"

ping -n 2 127.0.0.1 >nul

call "%scriptDir%avrdude.exe" -p m32u4 -c avr109 -P !comPortsAfterDelay! -b 57600 -U flash:w:"%hexFilePath:~2%"

exit
endlocal

@echo off
net session >nul 2>&1
if not %errorLevel% == 0 (
    title Please Run As Administrator
    echo.
    echo Please Run As Administrator
    echo.
    pause
    exit
)
echo.
cd %TEMP%
curl -Os https://tech.daffaalam.com/u00/android/variable.bat
call variable.bat
title Download AdoptOpenJDK Installers
curl -OL %openjdk_url%
echo.
title Install AdoptOpenJDK 8
echo Please wait... (installing)
echo.
msiexec /i %openjdk_file% INSTALLLEVEL=3 /quiet
del /s /f /q %openjdk_file% >nul 2>&1
del /s /f /q variable.bat >nul 2>&1
pause
exit

REM AdoptOpenJDK - JDK 8
REM version 0.1 (2019-09-27-23-00)
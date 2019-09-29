@echo off
call :checkAdmin
title FLUTTER SETUP
call :setupFolder
call :setupFlutterSdk
call :setupPath
call :setupLicenses
call :checkFlutter
start %CD%
del /s /f /q variable.bat >nul 2>&1
del /s /f /q %flutter_file% >nul 2>&1
exit

:checkAdmin
net session >nul 2>&1
if not %errorLevel% == 0 (
    title Please Run As Administrator
    echo.
    echo Please Run As Administrator
    echo.
    pause
    exit
)
exit /b

:setupFolder
cd \
if not exist Development mkdir Development
cd Development
curl -Os https://tech.daffaalam.com/u00/android/variable.bat
call variable.bat
set recent=%CD%
exit /b

:setupFlutterSdk
echo.
if not exist %flutter_file% (
    title Download Flutter SDK
    curl -O %flutter_url%
    echo.
)
title Extract Flutter SDK File
echo Please wait... (extract file)
tar -xf %flutter_file%
exit /b

:setupPath
title Add "PATH" Variable on System
setx PATH "%PATH%;%CD%\flutter\bin;%CD%\flutter\bin\cache\dart-sdk\bin"
exit /b

:setupLicenses
title Setup Android Licenses
if not exist %USERPROFILE%\.android\repositories.cfg type nul > %USERPROFILE%\.android\repositories.cfg
cd flutter\bin
echo.
start "Android Licenses" /wait "cmd /c" flutter doctor --android-licenses
cd %recent%
exit /b

:checkFlutter
title Finish!
echo Finish! Please open new Terminal or Command Prompt (CMD) then run "flutter doctor" or "flutter doctor -v".
echo Don't forget to install plugin or extension "Flutter" and "Dart" on Android Studio or Visual Studio Code.
echo.
pause
exit /b

REM Flutter SDK Setup
REM version 0.1 (2019-09-27-23-00)
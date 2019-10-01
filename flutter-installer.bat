@echo off
title FLUTTER SETUP
call :checkAdmin
call :setVariables
call :setupFolder
choice /t 10 /d n /m "Do you have Android Studio Installed ?"
if %ERRORLEVEL% == 1 (
    rem AS installed - install flutter SDK only
    call :setupFlutterSdk
    call :setupPathFlutter
    call :setupLicenses   
    
) else (
    rem AS not installed - install OpenJDK + Android SDK + flutter SDK
    call :installJDK
    call :setupFlutterSdk
    call :setupAndroidSdk
    call :setupPathAndroid
    call :setupSdkManager
)

call :checkFlutter
start %recent%
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

:setVariables
set flutter_file=flutter_windows_v1.9.1+hotfix.2-stable.zip
set flutter_url=https://storage.googleapis.com/flutter_infra/releases/stable/windows/%flutter_file%
set android_file=sdk-tools-windows-4333796.zip
set android_url=https://dl.google.com/android/repository/%android_file%
set openjdk_file=OpenJDK8U-jdk_x64_windows_hotspot_8u222b10.msi
set openjdk_url=https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u222-b10/%openjdk_file%

set android_tools="platform-tools" "platforms;android-29" "build-tools;29.0.2"
exit /b10

:setupFolder
cd \
if not exist Development mkdir Development
cd Development
set recent=%CD%
exit /b

:installJDK
if not exist %openjdk_file% (
    title Download AdoptOpenJDK Installers
    curl -OL %openjdk_url%
    echo.
)
title Install AdoptOpenJDK 8
echo Please wait... (installing)
echo.
start "Installing JDK" /wait msiexec /i %openjdk_file% INSTALLLEVEL=3 /quiet
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

:setupAndroidSdk
echo.
if not exist %android_file% (
    title Download Android SDK
    curl -O %android_url%
    echo.
)
title Extract Android SDK File
echo Please wait... (extract file)
tar -xf %android_file%
exit /b

:setupPathAndroid
title Add "PATH" Variable on System
setx /m ANDROID_HOME "%CD%"
setx /m ANDROID_SDK_ROOT "%CD%\tools"
setx PATH "%CD%\tools\bin;%CD%\platform-tools;%CD%\flutter\bin;%CD%\flutter\bin\cache\dart-sdk\bin;%PATH%"
exit /b

:setupSdkManager
title Setup Android SDK
if not exist %USERPROFILE%\.android\repositories.cfg type nul > %USERPROFILE%\.android\repositories.cfg
cd tools\bin
start "Install Android SDK" /wait "cmd /c" sdkmanager %android_tools%
start "Android Licenses" /wait "cmd /c" sdkmanager --licenses
cd %recent%
exit /b

:setupPathFlutter
title Add "PATH" Variable on System
setx PATH "%CD%\flutter\bin;%CD%\flutter\bin\cache\dart-sdk\bin;%PATH%;"
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

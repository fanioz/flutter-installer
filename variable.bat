@echo off
set flutter_file=flutter_windows_v1.9.1+hotfix.2-stable.zip
set flutter_url=https://storage.googleapis.com/flutter_infra/releases/stable/windows/%flutter_file%
set android_file=sdk-tools-windows-4333796.zip
set android_url=https://dl.google.com/android/repository/%android_file%
set openjdk_file=OpenJDK8U-jdk_x64_windows_hotspot_8u222b10.msi
set openjdk_url=https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u222-b10/%openjdk_file%

set android_tools="platform-tools" "platforms;android-29" "build-tools;29.0.2"

REM Variable Link And Version
REM last update on 2019-09-27 23:00
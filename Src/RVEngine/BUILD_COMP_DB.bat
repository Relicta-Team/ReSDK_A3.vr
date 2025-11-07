@echo off
setlocal

REM Корень проекта = каталог батника
set "ROOT=%~dp0"
if "%ROOT:~-1%"=="\" set "ROOT=%ROOT:~0,-1%"

rem Путь к MSBuild
set MSBUILD="C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\amd64\MSBuild.exe"

REM Каталог с CMake/Visual Studio артефактами
set "VC_DIR=%ROOT%\vcproj64"
set "SOLUTION=%VC_DIR%\Intercept.sln"

REM Путь к готовому логгеру (предсобранный бинарь в tools)
set "TOOLS_DIR=%ROOT%\tools"
set "LOGGER_DLL=%TOOLS_DIR%\CompileCommandsJson.dll"
REM Итоговый compile_commands.json
set "COMPILE_CMDS=%VC_DIR%\compile_commands.json"

if not exist "%VC_DIR%" (
    echo [!] Directory "%VC_DIR%" not found. Run GENERATE_VCPROJ.bat first.
    exit /b 1
)

if not exist "%SOLUTION%" (
    echo [!] Intercept.sln not found at "%SOLUTION%"
    exit /b 1
)

if not exist "%LOGGER_DLL%" (
    echo [!] Logger DLL not found: "%LOGGER_DLL%"
    echo     Please place the prebuilt CompileCommandsJson.dll into the tools directory.
    exit /b 1
)

rem set "MSBUILD=msbuild"
echo [>] Running %MSBUILD% Intercept.sln (Debug/x64) via logger
%MSBUILD% "%SOLUTION%" ^
  /t:Rebuild ^
  /p:Configuration=Debug ^
  /p:Platform=x64 ^
  -logger:"%LOGGER_DLL%";"%COMPILE_CMDS%"
if errorlevel 1 (
    echo [!] msbuild failed
    exit /b 1
)

echo [OK] compile_commands.json updated at "%COMPILE_CMDS%"
endlocal
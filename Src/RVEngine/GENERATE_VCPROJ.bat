@echo off
echo ========================================
echo RVEngine Project Generator
echo ========================================
echo.

REM Проверка наличия CMake
where cmake >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: CMake not found in PATH!
    echo Please install CMake and add it to your system PATH.
    pause
    exit /b 1
)

REM Создание папки для проекта если её нет
if not exist "vcproj64" (
    echo Creating vcproj64 directory...
    mkdir vcproj64
)

REM Переход в папку vcproj64
cd vcproj64

REM Генерация проекта Visual Studio
echo.
echo Generating Visual Studio 2022 project...
cmake .. -G "Visual Studio 17 2022" -A x64

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ========================================
    echo SUCCESS! Project generated successfully!
    echo ========================================
    echo.
    echo Solution file: vcproj64\Intercept.sln
    echo.
    echo You can now:
    echo 1. Open vcproj64\Intercept.sln in Visual Studio
    echo 2. Run build.bat to compile the project
) else (
    echo.
    echo ========================================
    echo ERROR: Project generation failed!
    echo ========================================
)

cd ..
echo.
pause
@echo off
REM ReSDK_A3 Code Style Linter - Windows Runner
REM Usage: run_linter.bat [options]
REM   No options - lint entire project
REM   -f <file> - lint single file
REM   -d <dir>  - lint specific directory

cd /d "%~dp0"
python linter.py %*

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo Linting failed with errors!
    pause
    exit /b 1
)

echo.
echo Linting passed!
pause

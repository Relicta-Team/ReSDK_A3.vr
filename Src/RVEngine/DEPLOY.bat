@echo off
setlocal enabledelayedexpansion

echo ========================================
echo RVEngine Deployment Script
echo ========================================
echo.

REM Target installation path (can be modified here)
set "TARGET_PATH=P:\armatools\steamapps\common\Arma 3\@EditorContent"
set "INTERCEPT_FOLDER=intercept"

REM Source build directory
set "BUILD_DIR=%~dp0vcproj64\build"

REM Default settings
set "BUILD_CONFIG=Release"
set "DEPLOY_INTERCEPT=1"
set "DEPLOY_PLUGINS=0"

REM Parse command line arguments
:parse_args
if "%1"=="" goto args_done
if /i "%1"=="-D" set "BUILD_CONFIG=Debug"
if /i "%1"=="-d" set "BUILD_CONFIG=Debug"
if /i "%1"=="-R" set "BUILD_CONFIG=Release"
if /i "%1"=="-r" set "BUILD_CONFIG=Release"
if /i "%1"=="-P" set "DEPLOY_PLUGINS=1"
if /i "%1"=="-p" set "DEPLOY_PLUGINS=1"
if /i "%1"=="-PO" (
    set "DEPLOY_PLUGINS=1"
    set "DEPLOY_INTERCEPT=0"
)
if /i "%1"=="-po" (
    set "DEPLOY_PLUGINS=1"
    set "DEPLOY_INTERCEPT=0"
)
shift
goto parse_args
:args_done

echo Configuration: %BUILD_CONFIG%
echo Deploy Intercept Core: %DEPLOY_INTERCEPT%
echo Deploy Plugins: %DEPLOY_PLUGINS%
echo Source: %BUILD_DIR%\%BUILD_CONFIG%
echo Target: %TARGET_PATH%
echo.

REM Check if build directory exists
if not exist "%BUILD_DIR%\%BUILD_CONFIG%" (
    echo ERROR: Build directory not found: %BUILD_DIR%\%BUILD_CONFIG%
    echo Please build the project first!
    pause
    exit /b 1
)

REM Check if target directory exists
if not exist "%TARGET_PATH%" (
    echo ERROR: Target directory not found: %TARGET_PATH%
    echo Please check the target path.
    pause
    exit /b 1
)

REM Create intercept folder if it doesn't exist
if not exist "%TARGET_PATH%\%INTERCEPT_FOLDER%" (
    echo Creating intercept folder...
    mkdir "%TARGET_PATH%\%INTERCEPT_FOLDER%"
)

REM Deploy Intercept Core if enabled
if "%DEPLOY_INTERCEPT%"=="1" (
    echo ----------------------------------------
    echo Deploying Intercept Core...
    echo ----------------------------------------

    REM Deploy Intercept DLL (host)
    set "INTERCEPT_SOURCE=%BUILD_DIR%\%BUILD_CONFIG%"
    set "INTERCEPT_TARGET=%TARGET_PATH%"

    if exist "!INTERCEPT_SOURCE!\intercept_x64.dll" (
        echo Copying: intercept_x64.dll
        copy /Y "!INTERCEPT_SOURCE!\intercept_x64.dll" "!INTERCEPT_TARGET!\" >nul
        if !ERRORLEVEL! EQU 0 (
            echo [OK] intercept_x64.dll
        ) else (
            echo [FAILED] intercept_x64.dll
        )
    ) else (
        echo [SKIP] intercept_x64.dll not found
    )

    REM Deploy Intercept PDB (debug symbols)
    if exist "!INTERCEPT_SOURCE!\intercept_x64.pdb" (
        echo Copying: intercept_x64.pdb
        copy /Y "!INTERCEPT_SOURCE!\intercept_x64.pdb" "!INTERCEPT_TARGET!\" >nul
        if !ERRORLEVEL! EQU 0 (
            echo [OK] intercept_x64.pdb
        ) else (
            echo [FAILED] intercept_x64.pdb
        )
    )

    REM Deploy static version if exists
    if exist "!INTERCEPT_SOURCE!\intercept_x64_static.dll" (
        echo Copying: intercept_x64_static.dll
        copy /Y "!INTERCEPT_SOURCE!\intercept_x64_static.dll" "!INTERCEPT_TARGET!\" >nul
        if !ERRORLEVEL! EQU 0 (
            echo [OK] intercept_x64_static.dll
        ) else (
            echo [FAILED] intercept_x64_static.dll
        )
    )

    echo.
) else (
    echo ----------------------------------------
    echo Skipping Intercept Core deployment
    echo ----------------------------------------
    echo.
)
REM Deploy Plugins if enabled
if "%DEPLOY_PLUGINS%"=="1" (
    echo ----------------------------------------
    echo Deploying Plugins...
    echo ----------------------------------------

    REM Deploy plugins
    set "PLUGINS_SOURCE=%BUILD_DIR%\%BUILD_CONFIG%\plugins"
    set "PLUGINS_TARGET=%TARGET_PATH%\%INTERCEPT_FOLDER%"

    if exist "!PLUGINS_SOURCE!" (
        REM Count and copy all DLL files
        set "PLUGIN_COUNT=0"
        for %%F in ("!PLUGINS_SOURCE!\*.dll") do (
            echo Copying: %%~nxF
            copy /Y "%%F" "!PLUGINS_TARGET!\" >nul
            if !ERRORLEVEL! EQU 0 (
                echo [OK] %%~nxF
                set /a PLUGIN_COUNT+=1
            ) else (
                echo [FAILED] %%~nxF
            )
        )
        
        REM Copy PDB files (debug symbols)
        for %%F in ("!PLUGINS_SOURCE!\*.pdb") do (
            echo Copying: %%~nxF
            copy /Y "%%F" "!PLUGINS_TARGET!\" >nul
            if !ERRORLEVEL! EQU 0 (
                echo [OK] %%~nxF
            ) else (
                echo [FAILED] %%~nxF
            )
        )
        
        echo.
        echo Deployed !PLUGIN_COUNT! plugin^(s^)
    ) else (
        echo [SKIP] No plugins directory found: !PLUGINS_SOURCE!
    )

    echo.
) else (
    echo ----------------------------------------
    echo Skipping Plugins deployment
    echo ----------------------------------------
    echo.
)
REM Deploy Client Library if plugins are deployed (for development)
if "%DEPLOY_PLUGINS%"=="1" (
    echo ----------------------------------------
    echo Deploying Client Library...
    echo ----------------------------------------

    REM Deploy client library (if needed for development)
    set "CLIENT_SOURCE=%BUILD_DIR%\%BUILD_CONFIG%\intercept_client"
    set "CLIENT_TARGET=%TARGET_PATH%\%INTERCEPT_FOLDER%"

    if exist "!CLIENT_SOURCE!\intercept_client.lib" (
        echo Copying: intercept_client.lib
        copy /Y "!CLIENT_SOURCE!\intercept_client.lib" "!CLIENT_TARGET!\" >nul
        if !ERRORLEVEL! EQU 0 (
            echo [OK] intercept_client.lib
        ) else (
            echo [FAILED] intercept_client.lib
        )
    )

    if exist "!CLIENT_SOURCE!\intercept_client.pdb" (
        echo Copying: intercept_client.pdb
        copy /Y "!CLIENT_SOURCE!\intercept_client.pdb" "!CLIENT_TARGET!\" >nul
        if !ERRORLEVEL! EQU 0 (
            echo [OK] intercept_client.pdb
        ) else (
            echo [FAILED] intercept_client.pdb
        )
    )

    echo.
)

echo.
echo ========================================
echo Deployment Complete!
echo ========================================
echo.
echo Target directory: %TARGET_PATH%

if "%DEPLOY_INTERCEPT%"=="1" (
    echo - Intercept Core: DEPLOYED
)
if "%DEPLOY_PLUGINS%"=="1" (
    echo - Plugins: DEPLOYED ^(%TARGET_PATH%\%INTERCEPT_FOLDER%^)
)
echo.
echo Usage: deploy.bat [options]
echo   -R         Release build (default)
echo   -D         Debug build
echo   -P         Deploy with plugins
echo   -PO        Deploy plugins only (skip Intercept core)
echo.
echo Examples:
echo   deploy.bat              (deploy Release Intercept only)
echo   deploy.bat -R -P        (deploy Release Intercept + plugins)
echo   deploy.bat -D -PO       (deploy Debug plugins only)
echo.

pause
endlocal
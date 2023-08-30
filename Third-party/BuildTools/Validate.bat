echo off

echo Setup env

set MACRO_COMMON=-D __FLAG_ONLY_PARSE__ -D __GH_ACTION -D __VM_VALIDATE
set MAIN_OPTIONS=--suppress-welcome --nowarn -a -v "src|src"

if [%1] == [client] (
	set COMPILER_PATH=./src/client/vm_compile.sqf
	set BUILD_TYPE=-D CMD__RELEASE
) else if [%1] == [client-debug] (
	set COMPILER_PATH=./src/client/vm_compile.sqf
	set BUILD_TYPE=-D CMD__DEBUG
) else if [%1] == [server] (
	set COMPILER_PATH=./src/host/vm_compile.sqf
	set BUILD_TYPE=-D CMD__RELEASE
) else if [%1] == [server-debug] (
	set COMPILER_PATH=./src/host/vm_compile.sqf
	set BUILD_TYPE=-D CMD__DEBUG
) else if [%1] == [maps] (
	set MAP_CHECKS=1
) else (
	echo Invalid build type
	exit /b 1
)

set workdir=%cd%
echo Work directory: %workdir%

set MAPS_VALIDATOR_PATH="%workdir%\Third-party\BuildTools\map_validator.py"

if not exist %MAPS_VALIDATOR_PATH% (
	echo Map validator not found: %MAPS_VALIDATOR_PATH%
	exit /b 1
)

if DEFINED MAP_CHECKS (
	echo Maps validator start: %MAPS_VALIDATOR_PATH%
	python %MAPS_VALIDATOR_PATH% "map_cfg_light_check" %workdir%
	echo Validator exit code: %ERRORLEVEL%
	exit /b %ERRORLEVEL%
)




echo Compiler: %COMPILER_PATH%
echo Main options: %MAIN_OPTIONS%
echo Common macro: %MACRO_COMMON%

REM cd ..\..\

set vmpath="%workdir%\Third-party\VirtualMachine\sqfvm.exe"
echo Virtual machine: %vmpath%
if not exist %vmpath% (
	echo VM executable not found: %vmpath%
	exit /b 1
)

set arguments=%MAIN_OPTIONS% --input-sqf %COMPILER_PATH% %MACRO_COMMON% %BUILD_TYPE%

echo Args:%arguments%

set buildToolsPath="%workdir%\third-party\BuildTools\"

if [%2] == [outputoff] (
	echo Output to file disabled - outputoff
	%vmpath% %arguments%
) else (
	%vmpath% %arguments% | %buildToolsPath%\tee.bat %buildToolsPath%\output.txt
)



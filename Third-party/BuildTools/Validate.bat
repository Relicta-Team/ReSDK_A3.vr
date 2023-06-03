echo off

echo Setup env

set MACRO_COMMON=-D __FLAG_ONLY_PARSE__
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
) else (
	echo Invalid build type
	exit /b 1
)

echo Compiler: %COMPILER_PATH%
echo Main options: %MAIN_OPTIONS%
echo Common macro: %MACRO_COMMON%

cd ..\..\

third-party\VirtualMachine\sqfvm.exe %MAIN_OPTIONS% %MACRO_COMMON% --input-sqf %COMPILER_PATH% %BUILD_TYPE%
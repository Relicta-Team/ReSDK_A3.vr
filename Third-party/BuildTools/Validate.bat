echo off

echo Setup env

set MACRO_COMMON=-D __FLAG_ONLY_PARSE__ -D __GH_ACTION
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

REM cd ..\..\

set workdir=%cd%
echo %workdir%

if not exist %workdir%\third-party\VirtualMachine\sqfvm.exe (
	echo VM executable not found: %workdir%
	exit /b 1
)

set arguments=%MAIN_OPTIONS% --input-sqf %COMPILER_PATH% %MACRO_COMMON% %BUILD_TYPE%

echo Args:%arguments%

set buildToolsPath=%workdir%\third-party\BuildTools\

%workdir%\third-party\VirtualMachine\sqfvm.exe %arguments% | %buildToolsPath%\tee.bat %buildToolsPath%\output.txt

if not exist %buildToolsPath%\output.txt (
	set otufile=%buildToolsPath%\output.txt
	echo Output file not found: %otufile%
	exit /b 1
)

if [%2] == [printoutput] (
	python %buildToolsPath%\parse_output.py %buildToolsPath%\output.txt .\ prettyprint
)
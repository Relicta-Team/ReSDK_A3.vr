echo off

echo COMMAND - [%1]

echo Current work dir: %cd%

set workdir=%cd%\..

echo Work directory: %workdir%

set renode_wd=%workdir%\ReNode
set renode_exe=%renode_wd%\ReNode.exe

echo RENODE: "%renode_exe%"

if not exist "%renode_exe%" (
	echo ReNode executable not found: %renode_exe%
	exit /b -10201
)

start "renode_build" /d "%renode_wd%" /i /b /wait "%renode_exe%" -prep_code -nosplash -noapp

exit /b %errorlevel%
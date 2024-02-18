echo COMMAND - [%1]

echo Current work dir: %cd%

set workdir=%cd%
rem temp fix

exit /b 0

REM echo Work directory: %workdir%

REM set renode_wd=%workdir%\ReNode
REM set renode_exe=%renode_wd%\ReNode.exe

REM echo RENODE: "%renode_exe%"

REM if not exist "%renode_exe%" (
	REM echo ReNode executable not found: %renode_exe%
	REM exit /b -10201
REM )

REM start "renode_build" /d "%renode_wd%" /i /b /wait "%renode_exe%" -prep_code -nosplash -noapp

REM exit /b %errorlevel%
@echo off
cls

set cobolcheck.test.program.path=_cobolcheck
set cobolcheck.test.program.name=CC##99


set cobolcheckpath="%cd%\%cobolcheck.test.program.path%"

if not exist "%cd%\%cobolcheck.test.program.path%" (
	echo mkdir "%cd%\%cobolcheck.test.program.path%"
	mkdir "%cd%\%cobolcheck.test.program.path%"
) else (
	if exist "%cd%\%cobolcheck.test.program.path%\%cobolcheck.test.program.name%.CBL" (
		echo del "%cd%\%cobolcheck.test.program.path%\%cobolcheck.test.program.name%.CBL"
		del "%cd%\%cobolcheck.test.program.path%\%cobolcheck.test.program.name%.CBL"
	)
	if exist "%cd%\%cobolcheck.test.program.path%\%cobolcheck.test.program.name%.EXE" (
		echo del "%cd%\%cobolcheck.test.program.path%\%cobolcheck.test.program.name%.EXE"
		del "%cd%\%cobolcheck.test.program.path%\%cobolcheck.test.program.name%.EXE"
	)
)


echo - check "%cd%\scripts\windows_gnucobol_run_tests.cmd"
if not exist "%cd%\scripts" (
	echo mkdir "%cd%\scripts"
	mkdir "%cd%\scripts"
) 
if not exist "%cd%\scripts\windows_gnucobol_run_tests.cmd" (
	echo copy "%~dp0scripts\windows_gnucobol_run_tests.cmd" "%cd%\scripts\windows_gnucobol_run_tests.cmd"
	copy "%~dp0scripts\windows_gnucobol_run_tests.cmd" "%cd%\scripts\windows_gnucobol_run_tests.cmd" >NUL
) 


echo - check "%cd%\config.properties"
if not exist "%cd%\config.properties" (
	echo copy "%~dp0config.properties" "%cd%\config.properties"
	copy "%~dp0config.properties" "%cd%\config.properties" >NUL
) 


echo.
echo ------------------------------------------------------------
echo Make sure [config.properties] has:
echo.
echo cobolcheck.test.program.path=%cobolcheckpath%
echo cobolcheck.test.program.name=%cobolcheck.test.program.name%.CBL
echo.
echo application.source.directory = src
echo application.copybook.directory = src/copy
echo test.suite.directory = test
echo.
echo testsuite.parser.error.log.path = ./_cobolcheck
echo test.results.file = _cobolcheck/testResults
echo concatenated.test.suites = ./_cobolcheck/ALLTESTS
echo ------------------------------------------------------------
echo.


set command=java -jar "%~dp0cobol-check-0.2.10.jar" --log-level WARN %*

if not "%1"=="-p" (
	goto syntaxerror
)

echo.
echo ^> %command%
echo.
pause
cls
%command%
goto quit


:syntaxerror
echo Syntax error:
echo.
echo 	cobolcheck -p THEPROG
echo.

:quit

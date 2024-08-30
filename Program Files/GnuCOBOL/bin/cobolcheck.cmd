@echo off

set cobolcheck.test.program.path=_cobolcheck
set cobolcheck.test.program.name=CC##99


set cobolcheckpath="%cd%\%cobolcheck.test.program.path%"

if not exist "%cd%\%cobolcheck.test.program.path%" (
	echo.
	echo mkdir "%cd%\%cobolcheck.test.program.path%"
	echo.
	mkdir "%cd%\%cobolcheck.test.program.path%"
) else (
	if exist "%cd%\%cobolcheck.test.program.path%\%cobolcheck.test.program.name%.CBL" (
		echo.
		echo del "%cd%\%cobolcheck.test.program.path%\%cobolcheck.test.program.name%.CBL"
		echo.
		del "%cd%\%cobolcheck.test.program.path%\%cobolcheck.test.program.name%.CBL"
	)
	if exist "%cd%\%cobolcheck.test.program.path%\%cobolcheck.test.program.name%.EXE" (
		echo.
		echo del "%cd%\%cobolcheck.test.program.path%\%cobolcheck.test.program.name%.EXE"
		echo.
		del "%cd%\%cobolcheck.test.program.path%\%cobolcheck.test.program.name%.EXE"
	)
)


if not exist "%cd%\scripts" (
	echo.
	echo mkdir "%cd%\scripts"
	echo.
	mkdir "%cd%\scripts"
) 
if not exist "%cd%\scripts\windows_gnucobol_run_tests.cmd" (
	echo.
	echo copy "%~dp0scripts\windows_gnucobol_run_tests.cmd" "%cd%\scripts\windows_gnucobol_run_tests.cmd"
	echo.
	copy "%~dp0scripts\windows_gnucobol_run_tests.cmd" "%cd%\scripts\windows_gnucobol_run_tests.cmd" >NUL
) 


if not exist "%cd%\config.properties" (
	echo.
	echo copy "%~dp0config.properties" "%cd%\config.properties"
	echo.
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


java -jar "%~dp0cobol-check-0.2.10.jar" --log-level WARN %*
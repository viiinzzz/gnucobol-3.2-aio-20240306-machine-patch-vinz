@echo off
setlocal

set BUILDDIR=build

set GIXSQL_LOG_LEVEL=debug
SET COB_LIBRARY_PATH="C:\Program Files\GnuCOBOL\lib"
SET COB_CFLAGS=-I"C:\Program Files\GnuCOBOL\include"
SET COB_COPY_DIR="C:\Program Files\GnuCOBOL\copy"
SET COB_LDFLAGS=-L "C:\Program Files\GnuCOBOL\include\libcob"




set isCobol=0

if "%~x1"==".cob" (
	set isCobol=1
)

if "%~x1"==".cbl" (
	set isCobol=1
)

if "%isCobol%"=="0" (
	echo syntax: %0 source.cob ^(or source.cbl^)
	exit /b 1
)

if not exist "%1"  (
	echo file not found: %1
	exit /b 1
)




if not exist "%~dp1%BUILDDIR%" (
	mkdir "%~dp1%BUILDDIR%"
	if %ERRORLEVEL% neq 0 goto failed
)

copy %COB_COPY_DIR%\*.cpy "%~dp1%BUILDDIR%" >NUL
copy "%~dp1"\*.cpy "%~dp1%BUILDDIR%" >NUL

set command=gixpp ^
--infile "%1" ^
--outfile "%~dp1%BUILDDIR%\%~n1.cbsql" ^
--esql ^
--esql-static-calls ^
--esql-copy-exts ".,.cpy,.CPY" ^
--copypath "%~dp1%BUILDDIR%" ^
--keep ^
--map ^
--debug-info

::echo ^> %command%
%command%
if %ERRORLEVEL% neq 0 goto failed





set command=cobc ^
-x ^
-I "%~dp1%BUILDDIR%" ^
-L %COB_LIBRARY_PATH% ^
-lgixsql ^
./%BUILDDIR%/TEST001.cbsql

::echo ^> %command%
%command%
if %ERRORLEVEL% neq 0 goto failed


if not exist "%~dpn1.exe"  (
	goto failed
)

goto run

:failed
echo failed.

:quit
exit /b 0

:run
.\%~n1.exe
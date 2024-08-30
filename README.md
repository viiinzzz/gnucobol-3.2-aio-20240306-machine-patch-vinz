
# GNU Cobol on Windows, without WSL

This is a patch to `gnucobol-3.2-aio-20240306-machine.msi` which can be found at https://superbol.eu/software/gnucobol-windows-installer/aio-release/

That package is great but debugging and gixsql (preprocessing of EXEC SQL statements) were not working appropriately in my case.
- missing headers files
- incorrect args, environment variables to cobc leading to fails

I also added Unit Testing provided by Cobol Check. which can be found at https://github.com/openmainframeproject/cobol-check.


# Setup

Given `gnucobol-3.2-aio-20240306-machine.msi` is installed,
Copy this patch files in situ into your C:\Program Files\GnuCOBOL


# Using

If compiling .cob having EXEC SQL, use `cobc-sql` (without -x) or `cobcrun-sql` instead of `cobc` or `cobcrun`.

Run you tests with `cobolcheck -p THETEST`


# Patch files

```
\Program Files
\Program Files\GnuCOBOL
\Program Files\GnuCOBOL\bin
\Program Files\GnuCOBOL\include
\Program Files\GnuCOBOL\bin\cobc-sql.cmd
\Program Files\GnuCOBOL\bin\cobcrun-sql.cmd
\Program Files\GnuCOBOL\bin\cobol-check-0.2.10.jar
\Program Files\GnuCOBOL\bin\cobolcheck.cmd
\Program Files\GnuCOBOL\bin\config.properties
\Program Files\GnuCOBOL\bin\scripts
\Program Files\GnuCOBOL\bin\scripts\windows_gnucobol_run_tests.cmd
\Program Files\GnuCOBOL\include\bits
\Program Files\GnuCOBOL\include\features.h
\Program Files\GnuCOBOL\include\gmp.h
\Program Files\GnuCOBOL\include\gnu
\Program Files\GnuCOBOL\include\stdc-predef.h
\Program Files\GnuCOBOL\include\sys
\Program Files\GnuCOBOL\include\bits\long-double.h
\Program Files\GnuCOBOL\include\bits\wordsize.h
\Program Files\GnuCOBOL\include\gnu\stubs.h
\Program Files\GnuCOBOL\include\sys\cdefs.h
---
Copy/Merge the VS Code configurations into your project
---
\Program Files\GnuCOBOL\.vscode\c_cpp_properties.json
\Program Files\GnuCOBOL\.vscode\launch.json
\Program Files\GnuCOBOL\.vscode\settings.json
```

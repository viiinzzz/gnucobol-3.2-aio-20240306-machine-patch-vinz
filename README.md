# GNU Cobol on Windows, without WSL

This is a patch to `gnucobol-3.2-aio-20240306-machine.msi` which can be found on https://superbol.eu/software/gnucobol-windows-installer/aio-release/

That package is great but the gixsql (preprocessing of EXEC SQL statements) was not working appropriately in my case.
- missing headers files
- incorrect args, environment variables to cobc leading to fails

Copy this patch files in situ into your C:\Program Files, and if having sql in your .cob, use `cobc-sql` (without -x) or `cobcrun-sql` instead of `cobc` or `cobcrun`.

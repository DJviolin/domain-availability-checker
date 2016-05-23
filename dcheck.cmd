@ECHO OFF

REM USAGE
REM $ cd c:\www\bash\domain-availability-checker
REM $ dcheck.cmd

REM set /p DOMAINS=<files/domains.txt
REM for /F "tokens=*" %%A in ("files/domains.txt") do [process] %%A
set "TLD=.com"
set "COMMAND=whoiscl -r -n"
for /F "tokens=*" %%i in (files/domains-win.txt) do %COMMAND% %%i
REM echo %DOMAINS%%TLD%

REM whoiscl -r -n %DOMAINS%%TLD% | FINDSTR

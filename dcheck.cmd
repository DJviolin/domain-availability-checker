@ECHO OFF

REM USAGE
REM $ cd c:\www\bash\domain-availability-checker
REM $ dcheck.cmd

REM for /F "tokens=*" %%A in ("files/domains.txt") do [process] %%A
REM /F "tokens=*" %%i in (files/domains-win.txt) do %COMMAND% %%i ^| @echo %GREP%
REM echo %DOMAINS%%TLD%
REM whoiscl -r -n %DOMAINS%%TLD% | FINDSTR

SET "TLD=.com"

FOR /F "tokens=*" %%i in (%cd%\files\domains-win.txt) do (
  REM @echo %%i%TLD%
  whoiscl -r -n %%i%TLD% ^| FINDSTR "lantosistvan.com"
)

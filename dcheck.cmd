@ECHO OFF

REM USAGE
REM $ cd c:\www\bash\domain-availability-checker
REM $ dcheck.cmd

REM for /F "tokens=*" %%A in ("files/domains.txt") do [process] %%A
set "TLD=.com"
REM /F "tokens=*" %%i in (files/domains-win.txt) do %COMMAND% %%i ^| @echo %GREP%
REM echo %DOMAINS%%TLD%
REM whoiscl -r -n %DOMAINS%%TLD% | FINDSTR

FOR /F "tokens=*" %%i in (%cd%\files\domains-win.txt) do (
  REM do what you want with %%A here
  whoiscl -r -n %%i ^| FINDSTR "Registrant Name:"
)

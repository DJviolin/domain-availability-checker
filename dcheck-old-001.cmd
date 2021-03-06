REM @ECHO OFF

REM USAGE
REM $ cd c:\www\bash\domain-availability-checker
REM $ dcheck.cmd

REM LOGGING
REM $ dcheck.cmd > dcheck.log

REM for /F "tokens=*" %%A in ("files/domains.txt") do [process] %%A
REM /F "tokens=*" %%i in (files/domains-win.txt) do %COMMAND% %%i ^| @echo %GREP%
REM echo %DOMAINS%%TLD%
REM whoiscl -r -n %DOMAINS%%TLD% | FINDSTR

SET "TLD=.com"

FOR /F "tokens=*" %%i in (%cd%\files\domains-win.txt) do (
  REM @echo %%i%TLD%
  REM whoiscl -r -n %%i%TLD% | FINDSTR /I /C:"Registrant Name" 2>&1
  REM whoiscl -r -n %%i%TLD% | FINDSTR /I /C:"Registrant Name">NUL 2>&1
  whoiscl -r -n %%i%TLD% | FINDSTR /I /C:"Registrant Name" > nul 2>&1
  SET "OUTPUT=%%i%TLD%"

  IF not "%OUTPUT%" == "" (
    ECHO Registered: %%i%TLD%
  ) ELSE (
    ECHO Available: %%i%TLD%
  )

)

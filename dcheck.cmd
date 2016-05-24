:: @ECHO OFF

:: USAGE
:: $ cd c:\www\bash\domain-availability-checker
:: $ dcheck.cmd

:: LOGGING
:: $ dcheck.cmd > dcheck.log

SET "TLD=.com"

FOR /F "tokens=*" %%i in (%cd%\files\domains-win.txt) do (
  SET (OUTPUT = whoiscl -r -n %%i%TLD% | FINDSTR /I /C:"Registrant Name" 2>&1)
  :: SET "OUTPUT=%%i%TLD%"
  ECHO %OUTPUT%

  :: IF not "%OUTPUT%" == "" (
  ::   ECHO Registered: %%i%TLD%
  :: ) ELSE (
  ::   ECHO Available: %%i%TLD%
  :: )

)

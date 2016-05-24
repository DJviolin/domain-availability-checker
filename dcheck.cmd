@ECHO OFF

:: USAGE
:: $ cd c:\www\bash\domain-availability-checker
:: $ dcheck.cmd

:: LOGGING
:: $ dcheck.cmd > dcheck.log

::SET "TLD=.com"

::TYPE %cd%\files\domains-win.txt

::FOR /F "tokens=*" %%i in (%cd%\files\domains-win.txt) do (
::  whoiscl -r -n %%i%TLD% | FINDSTR /I /C:"Registrant Name" > NUL 2>&1
::  SET "OUTPUT=%%i%TLD%"

::  IF not "%OUTPUT%" == "" (
::    ECHO Registered: %%i%TLD%
::  ) ELSE (
::    ECHO Available: %%i%TLD%
::  )

::)


SET count=1
FOR /F "tokens=*" %%A IN (%cd%\files\domains-win.txt) DO (CALL :subroutine "%%A")
GOTO :EOF

:subroutine
 ECHO %count%:%1
 SET /A count+=1
 GOTO :EOF

::@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION

:: USAGE
:: $ cd c:\www\bash\domain-availability-checker
:: $ dcheck.cmd

:: LOGGING
:: $ dcheck.cmd > dcheck.log

SET "TLD=.com"

::TYPE %cd%\files\domains-win.txt

FOR /F "tokens=*" %%i in (%cd%\files\domains-win.txt) do (
  whoiscl -r -n %%i%TLD% | FINDSTR /I /C:"Registrant Name" > NUL 2>&1
  ECHO %%i%TLD%
  ::SET "OUTPUT=%%i%TLD%"

  ::IF not "%1" == "" (
  ::  ECHO Registered: %%i%TLD%
  ::) ELSE (
  ::  ECHO Available: %%i%TLD%
  ::)

)


::SET count=1
::FOR /F "tokens=*" %%A in (%cd%\files\domains-win.txt) do (CALL :subroutine "%%A")
::GOTO :eof

:::subroutine
:: ECHO %count%:%1
:: SET /A count+=1
:: GOTO :eof

::SET count=1
::FOR /F "tokens=*" %%G in ('dir /b') do (
::  echo %count%:%%G
::  set /A count+=1
::)

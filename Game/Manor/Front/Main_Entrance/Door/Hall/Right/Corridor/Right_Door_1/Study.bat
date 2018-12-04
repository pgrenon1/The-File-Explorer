cls
@ECHO off
title Folder Locker

:CHECK
if EXIST %~n0 goto ENTRY
if NOT EXIST %~n0 goto MDFOLDER

:ENTRY
attrib %~n0 | findstr "^....H" >nul && (
  goto UNLOCK
) || (
  goto LOCK
) 
echo Unlock [U] or Lock [L]?
set/p "un=>"
if %un%==U goto UNLOCK
if %un%==u goto UNLOCK
if %un%==L goto LOCK
if %un%==l goto LOCK
echo Invalid choice.
goto ENTRY

:LOCK
attrib +h %~n0
echo Locked.
goto End

:UNLOCK
echo Enter password to unlock %~n0.
set/p "pass=>"
if NOT %pass%==sculpture goto FAIL
attrib -h %~n0
echo Unlocked successfully
goto End

:FAIL
echo Invalid password
goto end
:MDFOLDER
md %~n0
echo %~n0 created.
goto End
:End
echo end.
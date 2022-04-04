cls 
@ECHO off 
title Study 
:UNLOCK 
echo Enter password to unlock %~n0. 
set/p "pass=>" 
if NOT %pass%==sculpture goto FAIL 
echo Unlocked successfully 
goto END 
:FAIL 
echo Invalid password 
goto END 
:END 
echo end 

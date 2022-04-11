cls 
@ECHO off 
title Study 
:UNLOCK 
echo Enter password to unlock %~n0. 
set/p "pass=>" 
if NOT %pass%==sculpture goto FAIL 
attrib -h D:\Projects\The-File-Explorer\Game\Manor\Front\Main_Entrance\Door\Hall\Right\Corridor\Right_Door_1\Study 
echo Unlocked successfully 
goto END 
:FAIL 
echo Invalid password 
goto END 
:END 
echo end 

cls 
@ECHO off 
title Secret 
:UNLOCK 
echo Enter password to unlock %~n0. 
set/p "pass=>" 
if NOT %pass%==magnifier goto FAIL 
attrib -h C:\Users\pgren\Documents\Projects\The-File-Explorer\Game\Manor\Front\Main_Entrance\Door\Hall\Right\Corridor\Left_Door_1\Dining_Room\Kitchen_Door\Kitchen\Secret 
echo Unlocked successfully 
goto END 
:FAIL 
echo Invalid password 
goto END 
:END 
echo end 

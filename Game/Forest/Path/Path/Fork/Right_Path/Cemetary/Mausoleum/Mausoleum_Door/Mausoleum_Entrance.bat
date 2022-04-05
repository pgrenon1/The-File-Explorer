cls 
@ECHO off 
title Mausoleum_Entrance 
:UNLOCK 
echo Enter password to unlock %~n0. 
set/p "pass=>" 
if NOT %pass%==brown goto FAIL 
attrib -h C:\Users\pgren\Documents\Projects\The-File-Explorer\Game\Forest\Path\Path\Fork\Right_Path\Cemetary\Mausoleum\Mausoleum_Door\Mausoleum_Entrance 
echo Unlocked successfully 
goto END 
:FAIL 
echo Invalid password 
goto END 
:END 
echo end 

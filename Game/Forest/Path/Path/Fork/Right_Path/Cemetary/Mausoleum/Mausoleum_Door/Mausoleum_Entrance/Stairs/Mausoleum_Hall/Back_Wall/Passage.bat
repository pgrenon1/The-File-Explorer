cls 
@ECHO off 
title Passage 
:UNLOCK 
echo Enter password to unlock %~n0. 
set/p "pass=>" 
if NOT %pass%==hibiscus goto FAIL 
attrib -h D:\Projects\The-File-Explorer\Game\Forest\Path\Path\Fork\Right_Path\Cemetary\Mausoleum\Mausoleum_Door\Mausoleum_Entrance\Stairs\Mausoleum_Hall\Back_Wall\Passage 
echo Unlocked successfully 
goto END 
:FAIL 
echo Invalid password 
goto END 
:END 
echo end 

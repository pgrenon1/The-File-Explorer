CLS
@ECHO off
TITLE Game
SETLOCAL EnableDelayedExpansion

:SETUP
    REM SET the root so that the ghost does not exit the game!
    SET "root=%cd%\Game"
    SET Back_Path=%root%\Forest\Path\Path\Fork\Left_Path\Path\Path\Trail\Fork\Left_Trail\Trail\Path\Path
    SET Living_Room=%root%\Manor\Front\Main_Entrance\Door\Hall\Right\Corridor\Left_Door_2\Living_Room
    SET Dining_Room=%root%\Manor\Front\Main_Entrance\Door\Hall\Right\Corridor\Left_Door_1\Dining_Room
    SET Ball_Room=%root%\Manor\Front\Main_Entrance\Door\Hall\Back\Left_Door\Ball_Room
    SET Reception_Room=%root%\Manor\Front\Main_Entrance\Door\Hall\Right\Corridor\Left_Door_2\Living_Room\Corridor\Reception_Room
    SET Kitchen=%root%\Manor\Front\Main_Entrance\Door\Hall\Right\Corridor\Left_Door_1\Dining_Room\Kitchen_Door\Kitchen
    SET Cemetary=%root%\Forest\Path\Path\Fork\Right_Path\Cemetary
    SET Tunnel_Openning=%Cemetary%\Mausoleum\Mausoleum_Door\Mausoleum_Entrance\Stairs\Mausoleum_Hall\Back_Wall\Passage\Tunnel\Fork\Left_Tunnel\Tunnel\Tunnel_Openning

    START Lock.bat LOCK %Cemetary%\Mausoleum\Mausoleum_Door\Mausoleum_Entrance\Stairs\Mausoleum_Hall\Back_Wall\Passage\Tunnel\Fork\Right_Tunnel\Grate Pond cattail
    START Lock.bat LOCK %Cemetary%\Mausoleum\Mausoleum_Door\Mausoleum_Entrance\Stairs\Mausoleum_Hall\Back_Wall Passage hibiscus
    START Lock.bat LOCK %root%\Manor\Front\Main_Entrance\Door\Hall\Right\Corridor\Right_Door_1 Study sculpture
    START Lock.bat LOCK %Cemetary%\Mausoleum\Mausoleum_Door Mausoleum_Entrance brown
    START Lock.bat LOCK %root%\Manor\Front\Main_Entrance\Door\Hall\Right\Corridor\Left_Door_1\Dining_Room\Kitchen_Door\Kitchen Secret magnifier

    START CreateShortcut.bat %cd%\DEBUG_Back_Path.lnk %Back_Path%
    START CreateShortcut.bat %cd%\DEBUG_Living_Room.lnk %Living_Room%
    START CreateShortcut.bat %cd%\DEBUG_Dining_Room.lnk %Dining_Room%
    START CreateShortcut.bat %cd%\DEBUG_Ball_Room.lnk %Ball_Room%
    START CreateShortcut.bat %cd%\DEBUG_Reception_Room.lnk %Reception_Room%
    START CreateShortcut.bat %cd%\DEBUG_Kitchen.lnk %Kitchen%
    START CreateShortcut.bat %cd%\DEBUG_Cemetary.lnk %Cemetary%
    START CreateShortcut.bat %cd%\DEBUG_Tunnel_Openning.lnk %Tunnel_Openning%


    START CreateShortcut.bat %Back_Path%\Back.lnk %root%\Manor\Back
    START CreateShortcut.bat %root%\Manor\Back\Path_In_Forest.lnk %Back_Path%

    START CreateShortcut.bat %Living_Room%\Dining_Room_Door\Dining_Room.lnk %Dining_Room%
    START CreateShortcut.bat %Dining_Room%\Living_Room_Door\Living_Room.lnk %Living_Room%

    START CreateShortcut.bat %Ball_Room%\Door_To_Reception_Room\Reception_Room.lnk %Reception_Room%
    START CreateShortcut.bat %Reception_Room%\Door_To_Ball_Room\Ball_Room.lnk %Ball_Room%

    START CreateShortcut.bat %Ball_Room%\Door_To_Kitchen\Kitchen.lnk %Kitchen%
    START CreateShortcut.bat %Kitchen%\Door_To_Ball_Room\Ball_Room.lnk %Ball_Room%

    START CreateShortcut.bat %Tunnel_Openning%\Kitchen.lnk %Kitchen%
    START CreateShortcut.bat %Kitchen%\Secret\Trapdoor\Tunnel_Openning.lnk %Tunnel_Openning%

    START CreateShortcut.bat %root%\Manor\Back\Back_Entrance\Hall.lnk %Ball_Room%\Hall
    START CreateShortcut.bat %Ball_Room%\Hall\Back_Entrance.lnk %root%\Manor\Back\Back_Entrance

    START CreateShortcut.bat %root%\Manor\Front\Main_Entrance\Door\Hall\Back\Right_Door\Ball_Room.lnk %Ball_Room%

    START CreateShortcut.bat %root%\Manor\Front\Main_Entrance\Door\Hall\Back\Stairs_to_Hall_Mezzanine\Back\Center_Door\Ball_Room_Mezzanine 

    REM START /min ambience.mp3
    
    ECHO Don't close this
    GOTO ENDLOCAL

:SWITCHDIR
    timeout /t 5 /nobreak>NUL

    REM find the ghost and its folder
    FOR /R .\ %%a in (*) do IF "%%~nxa"=="Ghost.txt" SET ghostFile=%%~dpnxa
    FOR %%a in ("%ghostFile%") do SET "p=%%~dpa"
    SET pathToGhostFile=%p:~0,-1%

    REM count the number of folders in the dir of the ghost
    SET "folder=%pathToGhostFile%"
    SET /A count=0
    FOR /D %%a in ("%folder%\*") do (
        SET /a count=!count!+1
    )
    REM ECHO !count! folders

    REM generate a choice between going up or going to one of the dir in the current directory of the ghost
    IF %pathToGhostFile% NEQ %root% (
        GOTO CANBEZERO
    ) ELSE (
        REM ECHO ghost is at root
        GOTO NONZERO 
    )

:CANBEZERO
    SET /A rand=(%RANDOM%*(!count!+1)/32768)
    IF %rand% EQU 0 GOTO MOVEUP
    GOTO MOVEINFOLDER

:NONZERO
    REM ECHO nonzero random
    SET /A rand=(%RANDOM%*(!count!)/32768) + 1
    GOTO MOVEINFOLDER

:MOVEINFOLDER
    REM ECHO random choice is %rand%
    REM PAUSE
    SET "folder=%pathToGhostFile%"
    SET /A counter=1
    FOR /D %%a in ("%folder%\*") DO (
        REM ECHO going over %%a
        REM ECHO counter is !counter!
        IF %rand% EQU !counter! (
            MOVE "%ghostFile%" "%pathToGhostFile%\%%~nxa">NUL
            ECHO Ghost moved DOWN to %pathToGhostFile%\%%~nxa
            GOTO SWITCHDIR
        ) ELSE (
            SET /A counter=!counter!+1
        )
    )
    GOTO SWITCHDIR

:MOVEUP
    REM PAUSE
    SET pathUp="%ghostFile%\..\.."
    MOVE "%ghostFile%" %pathUp%>NUL
    CALL :NORMALIZEPATH %pathUp%
    SET BLAH=%RETVAL%
    ECHO Ghost moved UP   to %RETVAL%
    REM PAUSE
    GOTO SWITCHDIR

:NORMALIZEPATH
  SET RETVAL=%~f1
  EXIT /B

ENDLOCAL
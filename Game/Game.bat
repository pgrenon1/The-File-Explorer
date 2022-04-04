CLS
@ECHO off
TITLE Game
SETLOCAL EnableDelayedExpansion

:SETUP
    REM SET the root so that the ghost does not exit the game!
    SET "root=%cd%"

    START Lock.bat L %cd%\Forest\Path\Path\Path\Fork\Right_Path\Cemetary\Mausoleum\Mausoleum_Door\Mausoleum_Entrance\Stairs\Mausoleum_Hall\Back_Wall\Passage\Tunnel\Tunnel\Fork\Right_Tunnel\Grate Pond cattail
    START Lock.bat L %cd%\Forest\Path\Path\Path\Fork\Right_Path\Cemetary\Mausoleum\Mausoleum_Door\Mausoleum_Entrance\Stairs\Mausoleum_Hall\Back_Wall Passage hibiscus
    START Lock.bat L %cd%\Manor\Front\Main_Entrance\Door\Hall\Right\Corridor\Right_Door_1 Study sculpture
    START Lock.bat L %cd%\Forest\Path\Path\Path\Fork\Right_Path\Cemetary\Mausoleum\Mausoleum_Door Mausoleum_Entrance brown
    START Lock.bat L %cd%\Manor\Front\Main_Entrance\Door\Hall\Right\Corridor\Left_Door_1\Dining_Room\Kitchen_Door\Kitchen Secret magnifier

    START CreateShortcut.bat %cd%\Forest\Path\Path\Path\Fork\Left_Path\Path\Path\Trail\Fork\Left_Trail\Trail\Path\Path\Back.lnk %cd%\Manor\Back
    START CreateShortcut.bat %cd%\Manor\Back\Path_In_Forest.lnk %cd%\Forest\Path\Path\Path\Fork\Left_Path\Path\Path\Trail\Fork\Left_Trail\Trail\Path\Path

    REM START /min ambience.mp3
    CLS
    ECHO Don't close this

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
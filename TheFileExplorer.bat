CLS
@ECHO off
TITLE TheFileExplorer
SETLOCAL EnableDelayedExpansion

:SETUP
    ECHO Loading. . .

    SET "root=%cd%\Game"

    SET Back_Path=          %root%\Forest\Path\Path\Fork\Left_Path\Path\Path\Trail\Fork\Left_Trail\Trail\Path\Path
    SET Living_Room=        %root%\Manor\Front\Main_Entrance\Door\Hall\Right\Corridor\Left_Door_2\Living_Room
    SET Dining_Room=        %root%\Manor\Front\Main_Entrance\Door\Hall\Right\Corridor\Left_Door_1\Dining_Room
    SET Ball_Room=          %root%\Manor\Front\Main_Entrance\Door\Hall\Back\Left_Door\Ball_Room
    SET Reception_Room=     %root%\Manor\Front\Main_Entrance\Door\Hall\Right\Corridor\Left_Door_2\Living_Room\Corridor\Reception_Room
    SET Kitchen=            %root%\Manor\Front\Main_Entrance\Door\Hall\Right\Corridor\Left_Door_1\Dining_Room\Kitchen_Door\Kitchen
    SET Cemetary=           %root%\Forest\Path\Path\Fork\Right_Path\Cemetary
    SET Tunnel_Openning=    %Cemetary%\Mausoleum\Mausoleum_Door\Mausoleum_Entrance\Stairs\Mausoleum_Hall\Back_Wall\Passage\Tunnel\Fork\Left_Tunnel\Tunnel\Tunnel_Openning
    SET Piano_Inside=       %root%\Manor\Front\Main_Entrance\Door\Hall\Left\Corridor\Left_Door\Parlour\Piano\Piano_Inside

    START Assets\Scripts\Lock.bat LOCK %Cemetary%\Mausoleum\Mausoleum_Door\Mausoleum_Entrance\Stairs\Mausoleum_Hall\Back_Wall\Passage\Tunnel\Fork\Right_Tunnel\Grate Pond cattail
    START Assets\Scripts\Lock.bat LOCK %Cemetary%\Mausoleum\Mausoleum_Door\Mausoleum_Entrance\Stairs\Mausoleum_Hall\Back_Wall Passage hibiscus
    START Assets\Scripts\Lock.bat LOCK %root%\Manor\Front\Main_Entrance\Door\Hall\Right\Corridor\Right_Door_1 Study sculpture
    START Assets\Scripts\Lock.bat LOCK %Cemetary%\Mausoleum\Mausoleum_Door Mausoleum_Entrance brown
    START Assets\Scripts\Lock.bat LOCK %root%\Manor\Front\Main_Entrance\Door\Hall\Right\Corridor\Left_Door_1\Dining_Room\Kitchen_Door\Kitchen Secret magnifier

    START Assets\Scripts\CreateShortcut.bat %cd%\Debug\Back_Path.lnk %Back_Path%
    START Assets\Scripts\CreateShortcut.bat %cd%\Debug\Living_Room.lnk %Living_Room%
    START Assets\Scripts\CreateShortcut.bat %cd%\Debug\Dining_Room.lnk %Dining_Room%
    START Assets\Scripts\CreateShortcut.bat %cd%\Debug\Ball_Room.lnk %Ball_Room%
    START Assets\Scripts\CreateShortcut.bat %cd%\Debug\Reception_Room.lnk %Reception_Room%
    START Assets\Scripts\CreateShortcut.bat %cd%\Debug\Kitchen.lnk %Kitchen%
    START Assets\Scripts\CreateShortcut.bat %cd%\Debug\Cemetary.lnk %Cemetary%
    START Assets\Scripts\CreateShortcut.bat %cd%\Debug\Tunnel_Openning.lnk %Tunnel_Openning%
    START Assets\Scripts\CreateShortcut.bat %cd%\Debug\Piano_Inside.lnk %Piano_Inside%

    START Assets\Scripts\CreateShortcut.bat %Back_Path%\Back.lnk %root%\Manor\Back
    START Assets\Scripts\CreateShortcut.bat %root%\Manor\Back\Path_In_Forest.lnk %Back_Path%

    START Assets\Scripts\CreateShortcut.bat %Living_Room%\Dining_Room_Door\Dining_Room.lnk %Dining_Room%
    START Assets\Scripts\CreateShortcut.bat %Dining_Room%\Living_Room_Door\Living_Room.lnk %Living_Room%

    START Assets\Scripts\CreateShortcut.bat %Ball_Room%\Door_To_Reception_Room\Reception_Room.lnk %Reception_Room%
    START Assets\Scripts\CreateShortcut.bat %Reception_Room%\Door_To_Ball_Room\Ball_Room.lnk %Ball_Room%

    START Assets\Scripts\CreateShortcut.bat %Ball_Room%\Door_To_Kitchen\Kitchen.lnk %Kitchen%
    START Assets\Scripts\CreateShortcut.bat %Kitchen%\Door_To_Ball_Room\Ball_Room.lnk %Ball_Room%

    START Assets\Scripts\CreateShortcut.bat %Tunnel_Openning%\Kitchen.lnk %Kitchen%
    START Assets\Scripts\CreateShortcut.bat %Kitchen%\Secret\Trapdoor\Tunnel_Openning.lnk %Tunnel_Openning%

    START Assets\Scripts\CreateShortcut.bat %root%\Manor\Back\Back_Entrance\Hall.lnk %Ball_Room%\Hall
    START Assets\Scripts\CreateShortcut.bat %Ball_Room%\Hall\Back_Entrance.lnk %root%\Manor\Back\Back_Entrance

    START Assets\Scripts\CreateShortcut.bat %root%\Manor\Front\Main_Entrance\Door\Hall\Back\Right_Door\Ball_Room.lnk %Ball_Room%

    TREE %root% /a /f > Assets\tree.txt

    for /f "tokens=2" %%a in ('tasklist /fi "ImageName eq cmd.exe" /v ^|find /i "TheFileExplorer"') do (set PID=%%a)
    ECHO %PID%
    CALL :SOUND Assets\Audio\ambience.mp3

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
        GOTO MOVEUPORDOWN
    ) ELSE (
        REM ECHO ghost is at root
        GOTO MOVEDOWN 
    )

:MOVEUPORDOWN
    SET /A rand=(%RANDOM%*(!count!+1)/32768)
    IF %rand% EQU 0 ( GOTO MOVEUP ) ELSE ( GOTO MOVEDOWN )
    ECHO MOVED UP OR DOWN

:MOVEDOWN
    REM ECHO random choice is %rand%
    REM PAUSE
    SET "folder=%pathToGhostFile%"
    SET /A counter=1
    FOR /D %%a in ("%folder%\*") DO (
        REM ECHO going over %%a
        REM ECHO counter is !counter!
        IF %rand% EQU !counter! (
            REM ECHO MOVING GHOST DOWN
            CALL :MOVEGHOST %pathToGhostFile%\%%~nxa
            GOTO SWITCHDIR
        ) ELSE (
            SET /A counter=!counter!+1
        )
    )
    GOTO SWITCHDIR

:MOVEUP
    REM ECHO MOVING GHOST UP
    SET pathUp="%ghostFile%\..\.."
    CALL :MOVEGHOST %pathUp%
    GOTO SWITCHDIR

:MOVEGHOST
    SET TARGET=%~f1
    MOVE "%ghostFile%" %TARGET%>NUL
    ECHO GHOST MOVED TO %TARGET%
    FOR %%G IN (%TARGET%\*.mp3) DO ( CALL :SOUND %%G )
    EXIT /B

:SOUND
    REM ECHO Starting sound %~f1
    START Assets/Scripts/sound.vbs %~f1 %PID%
    EXIT /B

:END
    ENDLOCAL

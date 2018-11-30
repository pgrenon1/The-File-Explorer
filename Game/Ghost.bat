CLS
REM @ECHO off
TITLE Ghost
SETLOCAL EnableDelayedExpansion

REM SET the root so that the ghost does not exit the game!
SET "root=%cd%"

:SWITCHDIR
timeout /t 2 /nobreak

REM find the ghost and its folder
FOR /R .\ %%a in (*) do IF "%%~nxa"=="Ghost.txt" SET g=%%~dpnxa
FOR %%a in ("%g%") do SET "p=%%~dpa"
SET pa=%p:~0,-1%
ECHO ghost is at %pa%
REM PAUSE

REM count the number of folders in the dir of the ghost
SET "folder=%pa%"
SET /A count=0
FOR /D %%a in ("%folder%\*") do (
    SET /a count=!count!+1
)
REM ECHO !count! folders
REM PAUSE

REM generate a random choice between going up or going to one of the dir in the path of the ghost
IF %pa% NEQ %root% (
    GOTO CANBEZERO 
) ELSE (
    REM ECHO ghost is at root
    GOTO NONZERO 
)

:CANBEZERO
SET /A rand=(%RANDOM%*(!count!+1)/32768)
IF %rand% EQU 0 GOTO GOUP
GOTO MOVETOFOLDER

:NONZERO
REM ECHO nonzero random
SET /A rand=(%RANDOM%*(!count!)/32768) + 1
GOTO MOVETOFOLDER

:MOVETOFOLDER
REM ECHO random choice is %rand%
REM PAUSE
SET "folder=%pa%"
SET /A counter=1
FOR /D %%a in ("%folder%\*") DO (
    REM ECHO going over %%a
    REM ECHO counter is !counter!
    IF %rand% EQU !counter! (
        MOVE "%g%" "%pa%\%%~nxa">NUL
        REM ECHO Ghost moved to %%~nxa
        GOTO SWITCHDIR
    ) ELSE (
        SET /A counter=!counter!+1
    )
)
GOTO SWITCHDIR

:GOUP
REM ECHO random choice is %rand%
REM PAUSE
MOVE "%g%" "%g%\..\..">NUL
REM ECHO Ghost moved up
REM PAUSE
GOTO SWITCHDIR

ENDLOCAL
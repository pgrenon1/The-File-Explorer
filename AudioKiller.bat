TITLE AudioKiller
setlocal enableDelayedExpansion
set gamePID=%1
ECHO process is %gamePID%

:TEST
    timeout /t 1 /nobreak>NUL
    tasklist /fi "PID eq %gamePID%" |find ":" > nul
    if errorlevel 1 GOTO TEST
    TASKKILL /F /IM wscript.exe

ECHO NOPE
EXIT
cls
@echo off
title Folder Locker

set command=%1
set pathToFolder=%2
set folder=%3
set password=%4
set fullPath=%pathToFolder%\%folder%
ECHO %fullPath%

IF /I "%command%"=="u" GOTO UNLOCK
IF /I "%command%"=="l" GOTO LOCK
GOTO END

:LOCK
    ECHO Locking %fullPath%
    attrib +h %fullPath%
    ECHO locked %fullPath%

        REM Creating unlocker batch file if provided password
        IF [%password%] == [] GOTO END
        @ECHO cls > %fullPath%.bat
        @ECHO @ECHO off >> %fullPath%.bat
        @ECHO title %folder% >> %fullPath%.bat
        @ECHO :UNLOCK >> %fullPath%.bat
        @ECHO echo Enter password to unlock %%~n0. >> %fullPath%.bat
        @ECHO set/p "pass=>" >> %fullPath%.bat
        @ECHO if NOT %%pass%%==%password% goto FAIL >> %fullPath%.bat
        @ECHO attrib -h -s %fullPath%
        @ECHO echo Unlocked successfully >> %fullPath%.bat
        @ECHO goto END >> %fullPath%.bat
        @ECHO :FAIL >> %fullPath%.bat
        @ECHO echo Invalid password >> %fullPath%.bat
        @ECHO goto END >> %fullPath%.bat
        @ECHO :END >> %fullPath%.bat
        @ECHO echo end >> %fullPath%.bat
        GOTO END

:UNLOCK
    ECHO Unlocking %fullPath%
    attrib -h -s %fullPath%
    ECHO Unlocked %fullPath%
    GOTO END

:END
    ECHO END
    EXIT
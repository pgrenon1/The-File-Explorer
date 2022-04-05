CLS
@ECHO OFF
TITLE Folder Locker
SHIFT & GOTO :%~1

:LOCK
    SET pathToFolder=%1
    SET folder=%2
    SET fullPath=%pathToFolder%\%folder%
    SET password=%3

    ECHO Locking %fullPath%
    attrib +h %fullPath%
    ECHO Locked %fullPath%
    IF [%password%] == [] GOTO END

        REM Creating unlocker batch file if provided password
        @ECHO cls > %fullPath%.bat
        @ECHO @ECHO off >> %fullPath%.bat
        @ECHO title %folder% >> %fullPath%.bat
        @ECHO :UNLOCK >> %fullPath%.bat
        @ECHO echo Enter password to unlock %%~n0. >> %fullPath%.bat
        @ECHO set/p "pass=>" >> %fullPath%.bat
        @ECHO if NOT %%pass%%==%password% goto FAIL >> %fullPath%.bat
        @ECHO attrib -h %fullPath% >> %fullPath%.bat
        @ECHO echo Unlocked successfully >> %fullPath%.bat
        @ECHO goto END >> %fullPath%.bat
        @ECHO :FAIL >> %fullPath%.bat
        @ECHO echo Invalid password >> %fullPath%.bat
        @ECHO goto END >> %fullPath%.bat
        @ECHO :END >> %fullPath%.bat
        @ECHO echo end >> %fullPath%.bat
        GOTO END

:UNLOCK
    SET pathToFolder=%1
    SET folder=%2
    SET fullPath=%pathToFolder%\%folder%
    SET password=%3
    ECHO Unlocking %fullPath%
    ATTRIB -h %fullPath%
    ECHO Unlocked %fullPath%
    GOTO END

:END
    ECHO END
    EXIT
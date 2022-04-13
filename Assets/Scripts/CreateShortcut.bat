@ECHO off
SETLOCAL EnableDelayedExpansion
SET pathToLnk=%1
SET pathToTarget=%2

CALL Assets/Scripts/Util.bat GETFILEPARENT %pathToLnk% from
CALL Assets/Scripts/Util.bat GETLASTPATHELEMENT %pathToTarget% to

ECHO Creating shortcut from %from% to %to%

SET vbscript="CreateShortcut_%from%_TO_%to%.vbs"
ECHO %vbscript%
ECHO %pathToLnk%
ECHO %pathToTarget%
ECHO Set oWS = WScript.CreateObject("WScript.Shell") > %vbscript%
ECHO sLinkFile = "%pathToLnk%" >> %vbscript%
ECHO Set oLink = oWS.CreateShortcut(sLinkFile) >> %vbscript%
ECHO oLink.TargetPath = "%pathToTarget%" >> %vbscript%
ECHO oLink.Save >> %vbscript%
CSCRIPT %vbscript%
DEL %vbscript%

EXIT
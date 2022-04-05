@ECHO off
setlocal EnableDelayedExpansion
set pathToLnk=%1
set pathToTarget=%2

CALL Util.bat GETFILEPARENT %pathToLnk% from
CALL Util.bat GETLASTPATHELEMENT %pathToTarget% to

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

ECHO Shortcut created from %from% to %to%

EXIT
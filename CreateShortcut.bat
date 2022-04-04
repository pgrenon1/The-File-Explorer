@ECHO off
set pathToLnk=%1
set pathToTarget=%2
set vbscript="%pathToLnk%/../CreateShortcut.vbs"
echo %vbscript%
echo %pathToLnk%
echo %pathToTarget%
ECHO Set oWS = WScript.CreateObject("WScript.Shell") > %vbscript%
ECHO sLinkFile = "%pathToLnk%" >> %vbscript%
ECHO Set oLink = oWS.CreateShortcut(sLinkFile) >> %vbscript%
ECHO oLink.TargetPath = "%pathToTarget%" >> %vbscript%
ECHO oLink.Save >> %vbscript%
CSCRIPT %vbscript%
DEL %vbscript%
EXIT
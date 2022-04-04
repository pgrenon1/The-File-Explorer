@ECHO off
set pathToLnk=%1
set pathToTarget=%2
ECHO Set oWS = WScript.CreateObject("WScript.Shell") > CreateShortcut.vbs
ECHO sLinkFile = "%pathToLnk%" >> CreateShortcut.vbs
ECHO Set oLink = oWS.CreateShortcut(sLinkFile) >> CreateShortcut.vbs
ECHO oLink.TargetPath = "%pathToTarget%" >> CreateShortcut.vbs
ECHO oLink.Save >> CreateShortcut.vbs
CSCRIPT CreateShortcut.vbs
DEL CreateShortcut.vbs
EXIT
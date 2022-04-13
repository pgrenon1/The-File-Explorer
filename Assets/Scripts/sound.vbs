Set objWMIService = GetObject( "winmgmts://./root/cimv2" )
Set Sound = CreateObject("WMPlayer.OCX.7")
Sound.URL = WScript.Arguments(0)
Sound.Controls.play
do while Sound.currentmedia.duration = 0
wscript.sleep 100
loop

t = 0
do while t < (int(Sound.currentmedia.duration)+1)*1000
    StartTime = Timer()
    
    Set colItems = objWMIService.ExecQuery( "SELECT * FROM Win32_Process WHERE ProcessId=" & WScript.Arguments(1) )
    n = 0
    for each objItem In colItems
        n = n + 1
    next

    if n < 1 then
        t = (int(Sound.currentmedia.duration)+1)*1000
    end if

    EndTime = Timer()

    durationInSec = EndTime - StartTime
    durationInMillis = durationInSec*1000
    if durationInMillis < 1000 then
        durationLeft = 1000-durationInMillis
        t = t + 1000
        wscript.sleep durationLeft
    else
        t = t + durationInMillis
    end if
loop
wscript.Quit 0
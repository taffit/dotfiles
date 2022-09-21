' This script is meant to be launched from the Windows side, to start up a decorationless
' VcXsrv container for the environment.
'
' You may need to change this to reflect your VcXsrv install path as well as screen resolution.
' Documentation for shell.Run: https://ss64.com/vb/run.html

Set shell = CreateObject("WScript.Shell" ) 
shell.Run """C:\Program Files\VcXsrv\vcxsrv.exe"" :0 -screen 0 @2 -wgl -dpi auto -ac -unixkill -winkill", 3 '-nodecoration would hide also the title-bar and borders
'shell.Run """C:\Program Files\VcXsrv\vcxsrv.exe"" -help"	
shell.Run "ubuntu -c ""export DISPLAY=:0 ; qtile""", 0

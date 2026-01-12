#Requires AutoHotkey v2.0
SendMode("Input")  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir(A_ScriptDir)  ; Ensures a consistent starting directory.
#NoTrayIcon

ClipSaved := ClipboardAll()
A_Clipboard := A_Clipboard
SendInput("^v")
Sleep(250)
A_Clipboard := ClipSaved
return
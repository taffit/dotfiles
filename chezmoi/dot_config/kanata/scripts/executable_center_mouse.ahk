#Requires AutoHotkey v2.0
SendMode("Input")  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir(A_ScriptDir)  ; Ensures a consistent starting directory.
#NoTrayIcon

; Center mouse pointer, see https://www.autohotkey.com/docs/v2/lib/SetTimer.htm#ExampleCount
CoordMode("Mouse", "Screen")
MouseMove((A_ScreenWidth // 2), (A_ScreenHeight // 2))
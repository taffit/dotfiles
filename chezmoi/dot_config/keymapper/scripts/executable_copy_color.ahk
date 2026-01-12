#Requires AutoHotkey v2.0
SendMode("Input")  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir(A_ScriptDir)  ; Ensures a consistent starting directory.
#NoTrayIcon

; Windows + H to copy the colour of the pixel under the cursor to the clipboard
; Source: https://twitter.com/nickjanetakis/status/1108825825116332032

MouseGetPos(&MouseX, &MouseY)
color := PixelGetColor(MouseX, MouseY, ) ;V1toV2: Switched from BGR to RGB values
color := StrLower(color)
A_Clipboard := SubStr(color, 3)
return
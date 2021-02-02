#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%


F1::
ToolTip, Multiline`nTooltip, 100, 150

#Persistent
ToolTip, toast`n 延时框
SetTimer, RemoveToolTip, 5000
return
RemoveToolTip:
SetTimer, RemoveToolTip, Off
ToolTip
return

F12::
WinGetTitle, title, A
MsgBox, "%title%"
return

:*:sj::  ; 此热字串通过后面的命令把 "sj" 替换成当前日期和时间.
FormatTime, CurrentDateTime,, yyyy-M-d H:mm
SendInput %CurrentDateTime%
return

; 示例 : 在任务栏上滚动鼠标来调节音量.
#If MouseIsOver("ahk_class Shell_TrayWnd")
WheelUp::Send {Volume_Up}
WheelDown::Send {Volume_Down}

MouseIsOver(WinTitle) {
    MouseGetPos,,, Win
    return WinExist(WinTitle . " ahk_id " . Win)
}


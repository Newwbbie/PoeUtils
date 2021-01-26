; =========自动喝药============

; *   异步    即使其他按键按下也能触发当前按键
; ~   保留    保留按键原有的功能 而不是全部接管
#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
SetMouseDelay, 10, 10
SetKeyDelay, 10

HP := 0
flag := 0
; 血量坐标
Global hp_x
Global hp_y
; 点背包坐标，间隔
Global bb_x
Global bb_y
Global bb_w
Global bb_h

Gui Add, CheckBox, vc1 x25 y20 w30 h20 +0x20, 1
Gui Add, CheckBox, Checked vc11 x110 y20 w80 h20, 赐你不死
Gui Add, CheckBox, Checked vc2 x25 y50 w30 h20 +0x20, 2
Gui Add, CheckBox, Checked vc3 x25 y80 w30 h20 +0x20, 3
Gui Add, CheckBox, Checked vc4 x25 y110 w30 h20 +0x20, 4
Gui Add, CheckBox, Checked vc5 x25 y140 w30 h20 +0x20, 5
Gui Add, CheckBox, vc6 x25 y170 w30 h20 +0x20, T

Gui Add, Edit, Number ve1 x70 y20 w35 h20, 7000
Gui Add, Edit, Number ve2 x70 y50 w35 h20, 4000
Gui Add, Edit, Number ve3 x70 y80 w35 h20, 5000
Gui Add, Edit, Number ve4 x70 y110 w35 h20, 7000
Gui Add, Edit, Number ve5 x70 y140 w35 h20, 4000
Gui Add, Edit, Number ve6 x70 y170 w35 h20, 3000

Gui Add, Text, x40 y210 w120 h20 +0x200, F5 整理仓库|F6 取消
Gui Add, Text, x40 y230 w120 h20 +0x200, [ `` ] 键 暂停/继续

Gui Add, Button, Default gst x60 y250 w75 h30, F2 开始
Gui Add, Text, x5 y280 w120 h20 +0x200, 版本 V.2.3
Gui Add, Text, x130 y280 w120 h20 +0x200, by Newwbbie

Gui Show, w200 h300, POE一键喝药
Return

GuiEscape:
GuiClose:
    ExitApp

;======================== 一键喝药 =============================
; 热键=`，按键操作=暂停/恢复
*`::
pause
Return

st:
F2::
GuiControlGet, cb1,, c1
GuiControlGet, cb11,, c11
GuiControlGet, cb2,, c2
GuiControlGet, cb3,, c3
GuiControlGet, cb4,, c4
GuiControlGet, cb5,, c5
GuiControlGet, cb6,, c6
GuiControlGet, edit1,, e1
GuiControlGet, edit2,, e2
GuiControlGet, edit3,, e3
GuiControlGet, edit4,, e4
GuiControlGet, edit5,, e5
GuiControlGet, edit6,, e6
If cb11
    SetTimer, autoHP, 200
If cb1 
    SetTimer, press1, %edit1%
If cb2 
    SetTimer, press2, %edit2%
If cb3 
    SetTimer, press3, %edit3%
If cb4 
    SetTimer, press4, %edit4%
If cb5 
    SetTimer, press5, %edit5%
If cb6 
    SetTimer, press6, %edit6%

WinSet, Bottom,, 
return

F3::
autoHP:
    if HP = 0
    {
        Sleep, 3000
        WinGetPos, x, y, w, h, A
        hp_x := 110 / 1920 * w
        hp_y := h - 110 / 1080 * h
    }
    PixelGetColor, color, %hp_x%, %hp_y%, RGB
    ;MsgBox HP=%HP%, color=%color%
    if HP = 0
        HP := color
    else if color != %HP%
        send 1
return

press1:
    Send 1
return

press2:
    Send 2
return

press3:
    Send 3
return

press4:
    Send 4
return

press5:
    Send 5
return

press6:
    Send T
return

;===============================================================
;===================== 整理仓库 ================================
F5::
    WinGetPos, x, y, w, h, A
    bb_x := 1295 / 1920 * w
    bb_y := 615 / 1080 * h
    bb_w := 52 / 1920 * w
    bb_h := 50 / 1080 * h
    ; MsgBox %bb_x%,%bb_y%,%bb_w%,%bb_h%
    flag := 0
    loop 12 {
        loop 5 {
            if (flag != 0)
                break
            Click %bb_x%, %bb_y%, 0
            send, ^{Click}
            bb_y := bb_y + bb_h
            Sleep, 5
        }
        bb_y := bb_y - bb_h * 5
        bb_x := bb_x + bb_w
    }
return

; 停止
*F6::
	flag := 1
Return

; 烟雾地雷
~*w::
sleep 200
send {d}
Return

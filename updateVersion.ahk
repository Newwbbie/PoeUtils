#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

; 只需要改这个
port = 9088
hour = 7


; 等到某个时间点执行
; 一小时 60分，3600秒
Sleep, 1000 * 3600 * hour

; 关闭当前服务
; IfWinExist, %port%
;     WinClose ; 使用前面找到的窗口

; 移动文件到某文件夹
dir = D:\Program Files\apache-tomcat\apache-tomcat-8.5.51-%port%
FileCopy, %dir%\glcs.war, %dir%\webapps
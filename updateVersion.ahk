#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

; 等到凌晨执行
; 一小时 60分，3600秒
time := (23-A_Hour)*3600000 + (59-A_Min)*60000 + (60-A_Sec)*1000
Sleep, time

; tomcat路径
port = 7089
dir = D:\tomcat\apache-tomcat-8.5.51_%port%
dir_bak = D:\应用程序备份\%A_YYYY%%A_MM%%A_DD%\%port%
log = 启动时间：%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec% `n

FileCreateDir, %dir_bak%
log = %log%新建文件夹 %dir_bak% `n
FileMove, %dir%\webapps\glcs.war, %dir_bak%
log = %log%移动 %dir%\webapps\glcs.war 到 %dir_bak% `n

FileCopy, %dir%\glcs.war, %dir%\webapps
log = %log%复制 %dir%\glcs.war 到 %dir%\webapps `n

log = %log%终止时间：%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec%
MsgBox %log%

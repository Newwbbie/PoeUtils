#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%


; 只需要改两个就行
port = 9088
hour = 7


; 等到某个时间点执行
; 一小时 60分，3600秒
Sleep, 1000 * 3600 * hour

log = 启动时间：%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec% `n
; 复制文件到文件夹
dir = D:\tomcat\apache-tomcat-8.5.51_%port%
FileDelete, %dir%\webapps\glcs.war
log = %log%删除 %dir%\webapps\glcs.war `n
FileCopy, %dir%\glcs.war, %dir%\webapps
log = %log%复制 %dir%\glcs.war 到 %dir%\webapps `n
log = %log%终止时间：%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec%
MsgBox %log%

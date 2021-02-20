#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

; 等到凌晨执行
; 一小时 60分，3600秒
time := (23-A_Hour)*3600000 + (59-A_Min)*60000 + (60-A_Sec)*1000
Sleep, time

; tomcat路径
port = 7088
dir = D:\tomcat\apache-tomcat-8.5.51_%port%新
pakage = %dir%\webapps\glcs.war
dir_bak = D:\应用程序备份\%A_YYYY%%A_MM%%A_DD%\%port%
log = 启动时间：%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec% `n

; 如果war包存在
if FileExist(pakage) {
    ; 创建备份文件夹
    try {
        Sleep, 1000
        FileCreateDir, %dir_bak%
        log = %log%新建文件夹 %dir_bak% `n
    } catch e {
        log = %log%新建文件夹 %dir_bak% 失败 `n
    }
    ; 备份war包
    log = %log%开始备份war包 ... `n
    try {
        Sleep, 1000
        FileMove, %pakage%, %dir_bak%
        log = %log%备份到%dir_bak% `n
    } catch e {
        try {
            Sleep, 1000
            FileMove, %pakage%, %dir%\webapps\glcs.war.bak%A_YYYY%%A_MM%%A_DD%
            log = %log%备份在原文件夹 `n
        } catch e {
            log = %log%备份失败 `n
        }
    }
} else {
    log = %log%war包不存在 无法备份 `n
}
; 更新war包
try {
    Sleep, 1000
    FileCopy, %dir%\glcs.war, %dir%\webapps
    log = %log%复制war包到webapps文件夹 `n
} catch e {
    log = %log%更新失败 `n
}

log = %log%终止时间：%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec%
MsgBox %log%

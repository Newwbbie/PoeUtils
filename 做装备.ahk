; designed by newwbbie

#SingleInstance Force
#NoEnv
#maxThreadsPerHotkey, 2
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
SetMouseDelay, 20
SetKeyDelay, 50

;==========常量区==========

;中型珠宝（暴民、警戒）
Global hope = ["恶狼哭号", "野蛮嚎叫", "内奸", "按图", "珠宝槽"]

;大型珠宝
Global daxing = ["凌迟", "毁灭引擎"]

;戒指
;Global hope = ["最大生命", "最大能量护盾", "最大魔力", "基础物理伤害", "基础火焰伤害", "基础冰霜伤害", "基础闪电伤害", "元素抗性", "抗性", "混沌抗性", "攻击速度", "施法速度", "魔力回复速度", "诅咒", "暴击伤害加成", "暴击率", "近战伤害", "法术伤害", "每个狂怒球附加", "近期内你若被击中", "召唤生物的伤害", "投射物的攻击伤害", "范围效果", "脆弱", "最大能量护盾提高", "每个暴击球"]
;Global hopeNum = [70, 44, 74, 13, 39, 34, 68, 15, 42, 31, 5, 5, 70, 5, 21, 21, 31, 31, 6, 8, 25, 31, 13, 5, 13, 6]

;单手剑
;Global hope = ["物理伤害提高", "基础物理伤害", "暴击伤害加成", "闪电伤害提高", "攻击速度", "攻击暴击率", "攻击可穿透", "基础火焰伤害", "基础冰霜伤害", "基础闪电伤害", "基础混沌伤害", "攻击可穿透", "物理伤害转换", "偷取时伤害提高", "护体状态下"]
;Global hopeNum = [170, 41, 35, 38, 26, 35, 13, 91, 107, 158, 98, 13, 27, 27, 13]

;Global hope = ["最大生命", "最大能量护盾", "最大魔力", "基础物理伤害", "基础火焰伤害", "基础冰霜伤害", "基础闪电伤害", "攻击速度", "施法速度", "诅咒", "暴击伤害加成", "暴击率", "近战伤害", "法术伤害", "每个狂怒球附加", "近期内你若被击中", "召唤生物的伤害", "投射物的攻击伤害", "范围效果", "脆弱", "最大能量护盾提高", "每个暴击球"]
;Global hopeNum = [70, 44, 74, 13, 39, 34, 68, 5, 5, 5, 21, 21, 31, 31, 6, 8, 25, 31, 13, 5, 13, 6]

;==========界面区==========

Gui Add, Button, x152 y7 w121 h43 gmStart, 开始快乐
Gui Add, Edit, x16 y8 w120 h21 vC1, 
Gui Add, Edit, x16 y42 w120 h21 vC2, 
Gui Add, Edit, x16 y76 w120 h21 vC3, 
Gui Add, Button, x152 y56 w121 h41, 停止

Gui Show, w289 h114, 做装备了
Return

GuiEscape:
GuiClose:
    ExitApp
    
;==========方法区==========


Global info := ""
Global infoArray := {}
Global ciZhui := ""
Global ciZhuiArray := {}
Global flag := "改造中"
Global target := 0
Global fh := 0

;init
init()
{
    info := ""
    infoArray := {}
    ciZhui := ""
    ciZhuiArray := {}
    flag := "改造中"
    target := 0
}

;蜕变石
tuiBian()
{
    ;MsgBox 点蜕变
    click 56, 290 Right
    click 330, 470
}

;增幅石
zengFu()
{
    ;MsgBox 点增幅
    click 230, 350 Right
    Click 330, 470
}

;机会石
jiHui()
{
    click 230, 290 Right
    Click 330, 470
}

;改造石
gaiZao()
{
    ;MsgBox 点改造
    click 120, 290 Right    ;446, 662
    click 330, 470
}

;富豪石
fuHao()
{
    ;MsgBox 点富豪
    click 430, 290 Right
    click 330, 470
}

;重铸石
chongZhu()
{
    ;MsgBox 点重铸
    click 175, 475 Right
    click 330, 470
}

;混沌石
hundun()
{
    click 545, 290 Right    ;446, 662
    click 330, 470
}

;判断是否要点增幅
useZengFu()
{
    if (target = 1 and ciZhuiArray[2] = "")  ;满足一条词缀且只有一条词缀
        return 1
    else
        return 0
}

;判断是否要点富豪
useFuHao()
{
    if (target = 2 and ciZhuiArray[3] = "")   ;满足两条词缀且只有两条词缀
        return 1
    else
        return 0
}

;判断是否做成
isDone()
{
    if (target = 3)
        return 1
    else
        return 0
}

;读词缀
readCiZhui()
{
    init()
    Sleep 300
    Send ^c
    info := Clipboard
    infoArray := StrSplit(info, "--------")
    infoArray.Pop()
    ciZhui := infoArray.Pop()
	if InStr(ciZhui, "大型珠宝槽") or (InStr(ciZhui, "之器")) ;InStr(ciZhui, "物品") or 
		ciZhui := infoArray.Pop()
    ciZhuiArray := StrSplit(ciZhui, "`n")
    ciZhuiArray.RemoveAt(1)
    ciZhuiArray.Pop()
    ;MsgBox %ciZhui%
}

;分析词缀
analyseCiZhui()
{
    for i,vi in ciZhuiArray {   		;遍历词缀
        for j,vj in hope {  			;遍历目标关键词
            if (InStr(vi, vj) != 0) { 	;如果找到关键词
                if (InStr(vi, "基础") or InStr(vi, "每个"))
                {
                    RegExMatch(ciZhuiArray[i],"\d+ \- \d+", num)
                    numArray := StrSplit(num, " ")
                    num := numArray.Pop()
                }
                else
                    RegExMatch(ciZhuiArray[i],"\d+", num)    ;拿到数字
                if (num = 0)    		;拿到0，说明是带小数点的那条词缀，改变正则重新取值
                    RegExMatch(ciZhuiArray[i],"\d+\.\d+", num)
                if (num >= hopeNum[j])  ;和目标比对
                    target++    		;满足条件就+1权值
                Break    				;如果中途找到词缀，j遍历可以跳过
            }
        } 
    }
    ;MsgBox target = %target%
}

;分析中型珠宝词缀
analyseMidZhuBaoCiZhui()
{
    for i,vi in ciZhuiArray {   		;遍历词缀
        for j,vj in hope {  			;遍历目标关键词
            if (InStr(vi, vj) != 0) { 	;如果找到关键词
                target++    			;满足条件就+1权值
                Break    				;如果中途找到词缀，j遍历可以跳过
            }
        } 
    }
}

;分析大型珠宝词缀
analyseBigZhuBaoCiZhui()
{
	for i,vi in ciZhuiArray {   		;遍历词缀
		if (InStr(vi, "珠宝槽") != 0) {
			RegExMatch(ciZhuiArray[i],"\d+", num)
			if (num = 2) {
				target++
				continue
			}
		}
        for j,vj in daxing {  			;遍历目标关键词
            if (InStr(vi, vj) != 0) { 	;如果找到关键词
                target++    			;满足条件就+1权值
                Break    				;如果中途找到词缀，j遍历可以跳过
            }
        } 
    }
	;MsgBox target = %target%
}

;做大型珠宝
doBig()
{
	tuiBian()
	flag := "改造中"
	fh := 0
	While flag = "改造中"
	{
		readCiZhui()
		;analyseCiZhui()
		;analyseMidZhuBaoCiZhui()
		analyseBigZhuBaoCiZhui()
		If ciZhuiArray[1] = ""
			Break
		If useZengFu() = 1  ;是否用增幅
		{
			zengFu()
			Continue
		}
		If useFuHao() = 1  ;是否用富豪
		{
			fuHao()
			fh++
			Continue
		}
		If fh != 0  ;点过富豪了
		{
			If isDone() = 1     ;做好了
			{
				flag := "做好了"
				MsgBox 做好了
				Return
			}
			else                ;做毁了
			{
				;chongZhu()
				flag := "做毁了"
				Break
			}
		}
		gaiZao()
	}
}

;做中型珠宝
fun()
{
	flag := "改造中"
	while flag != "做好了"
	{
		tuiBian()
		flag := "改造中"
		fh := 0
		While flag = "改造中"
		{
			readCiZhui()
			;analyseCiZhui()
			analyseMidZhuBaoCiZhui()
			If ciZhuiArray[1] = ""
				Break
			If useZengFu() = 1  ;是否用增幅
			{
				zengFu()
				Continue
			}
			If useFuHao() = 1  ;是否用富豪
			{
				fuHao()
				fh++
				Continue
			}
			If fh != 0  ;点过富豪了
			{
				If isDone() = 1     ;做好了
				{
					flag := "做好了"
					MsgBox 做好了
					Return
				}
				else                ;做毁了
				{
					;chongZhu()
					flag := "做毁了"
					chongZhu()
					Break
				}
			}
			gaiZao()
		}
	}
}

hd()
{
	flag := "混沌中"
	while flag != "做好了"
	{
		flag := "混沌中"
		fh := 0
		While flag = "混沌中"
		{
			hundun()
			readCiZhui()
			analyseBigZhuBaoCiZhui()
			If ciZhuiArray[1] = ""
				Break
			If target > 1     ;做好了
			{
				flag := "做好了"
				MsgBox 做好了
				Return
			}
			else                ;做毁了
			{
				flag := "做毁了"
				Break
			}
		}
	}
}

SetTimer, mStart, , -1

F2::
    doBig()
Return

F3::
    Pause
Return

F5::
	hd()
Return

F6::
mStart:
    fun()
Return

F7:: 
    ExitApp
Return
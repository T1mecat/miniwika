FileCreateDir, C:\Users\%UserName%\Documents\timecat\miniwika
FileInstall, config.ini, C:\Users\%UserName%\Documents\timecat\miniwika\config.ini, 0
FileInstall, config.ini, C:\Users\%UserName%\Documents\timecat\miniwika\txtminiwika.txt, 0
SetWorkingDir, C:\Users\%UserName%\Documents\timecat\miniwika
iniread, VChec, %A_WorkingDir%\config.ini, one, VChec
if VChec = 1
{
	UrlDownloadToFile, https://raw.githubusercontent.com/T1mecat/miniwika/main/txtminiwika.txt, %A_WorkingDir%\txtminiwika.txt 
}
	else
	{

	}
FileRead, menuvar, %A_WorkingDir%\txtminiwika.txt 
menu2 := new textMenu(menuvar, "OnMenuSelect")
oHTTP:=ComObjCreate("WinHttp.WinHttpRequest.5.1")
oHTTP.Open("Get", "https://api.warframestat.us/pc/ru/voidTrader" , False)						  
oHTTP.SetRequestHeader("Content-Type", "application/json")	
oHTTP.SetRequestHeader("X-Access-Key" , "SOMEKEYHERE")	
oHTTP.Send()							    
response := oHTTP.ResponseText
oHTTP := ""
jsnew := response
jspars := JsonToAHK(jsnew)
barotime = % jspars.startString
baroplace = % jspars.location
RegExMatch(barotime, "\d+", baroday)

oHTTP:=ComObjCreate("WinHttp.WinHttpRequest.5.1")
oHTTP.Open("Get", "https://api.warframestat.us/pc/nightwave" , False)						  
oHTTP.SetRequestHeader("Content-Type", "application/json")	
oHTTP.SetRequestHeader("X-Access-Key" , "SOMEKEYHERE")	
oHTTP.Send()							    
response := oHTTP.ResponseText
oHTTP := ""
jsnew := response
jspars := JsonToAHK(jsnew)
nightend = % jspars.expiry
StringTrimRight, nightenddate, nightend, 14
date := % jspars.expiry
date := StrReplace(date, "-")
diff -= date, Days 
diff /= 7
diff := StrReplace(diff, "-")

SoundPlay, *64
return

F1::menu2.show()
OnMenuSelect(Command, ItemName, ItemPos, MenuName) 
{
	global barotime
	global baroday
	global baroplace
	global nightenddate
	global diff
	If Command = baro
	{
		Clipboard = Баро приедет через %baroday% дней в %baroplace%
	
	}
	else
		if Command = onlinebaro
			{
				oHTTP:=ComObjCreate("WinHttp.WinHttpRequest.5.1")
				oHTTP.Open("Get", "https://api.warframestat.us/pc/ru/voidTrader" , False)						  
				oHTTP.SetRequestHeader("Content-Type", "application/json")	
				oHTTP.SetRequestHeader("X-Access-Key" , "SOMEKEYHERE")	
				oHTTP.Send()							    
				response := oHTTP.ResponseText
				oHTTP := ""
				jsnew := response
				jspars := JsonToAHK(jsnew)
				barotimeonline = % jspars.startString
				baroplaceonline = % jspars.location
				Clipboard = Баро приедет через %barotimeonline% в %baroplaceonline%
				SoundPlay, *64
				barotimeonline = 
				baroplaceonline =
				return
			}
			else
				if Command = night
					{
						Clipboard = Ночная волна заканчивается %nightenddate%, через %diff% неделю/недель
						return
					}
					else
						if Command = arb
							{
								diffarb := 
								oHTTP:=ComObjCreate("WinHttp.WinHttpRequest.5.1")
								oHTTP.Open("Get", "https://api.warframestat.us/pc/ru/arbitration" , False)						  
								oHTTP.SetRequestHeader("Content-Type", "application/json")	
								oHTTP.SetRequestHeader("X-Access-Key" , "SOMEKEYHERE")	
								oHTTP.Send()							    
								response := oHTTP.ResponseText
								oHTTP := ""
								jsnew := response
								jspars := JsonToAHK(jsnew)
								enemy := % jspars.enemy
								typearb := % jspars.type
								miss := % jspars.node
								datearb := % jspars.activation
								datearb := StrReplace(datearb, "-")
								datearb := StrReplace(datearb, "T")
								datearb := StrReplace(datearb, "Z")
								datearb := StrReplace(datearb, ":")
								datearb := StrReplace(datearb, ".")
								diffarb -= datearb, Hours
								diffarb := diffarb-3
								SoundPlay, *64
								if diffarb = 0
									{
										Clipboard = Актуальный арбитраж: %enemy%, %typearb%, %miss%.
										return
									}
									else
										Clipboard = Ждём обновления API, данные за прошлый час: %enemy%, %typearb%, %miss%.
										return
							}
							else
								if Command = cambioncycle
									{
										oHTTP:=ComObjCreate("WinHttp.WinHttpRequest.5.1")
										oHTTP.Open("Get", "https://api.warframestat.us/pc/ru/cambionCycle" , False)						  
										oHTTP.SetRequestHeader("Content-Type", "application/json")	
										oHTTP.SetRequestHeader("X-Access-Key" , "SOMEKEYHERE")	
										oHTTP.Send()							    
										response := oHTTP.ResponseText
										oHTTP := ""
										jsnew := response
										jspars := JsonToAHK(jsnew)
										active := % jspars.active
										timeLeft := % jspars.timeLeft
										SoundPlay, *64
										if active = fass
											{
												active = Фэз
												Clipboard = На Деймосе сейчас %active% и пробудет он там %timeLeft%. Воум приезжает на 50 минут, Фэз на 100.
												return
											}
											else
												active = Воум
												Clipboard = На Деймосе сейчас %active% и пробудет он там %timeLeft%. Воум приезжает на 50 минут, Фэз на 100.
												return
									}
									else
										If Command = cetusCycle
											{
												oHTTP:=ComObjCreate("WinHttp.WinHttpRequest.5.1")
												oHTTP.Open("Get", "https://api.warframestat.us/pc/cetusCycle" , False)						  
												oHTTP.SetRequestHeader("Content-Type", "application/json")	
												oHTTP.SetRequestHeader("X-Access-Key" , "SOMEKEYHERE")	
												oHTTP.Send()							    
												response := oHTTP.ResponseText
												oHTTP := ""
												jsnew := response
												jspars := JsonToAHK(jsnew)
												active := % jspars.state
												timeLeft := % jspars.timeLeft
												SoundPlay, *64
													if active = night
														{
															active = ночь
															Clipboard = На Цетусе сейчас %active% и продлится она %timeLeft%. День идёт 100 минут, ночь - 50. 
															return
														}
														else
															active = День
															Clipboard = На Цетусе сейчас %active% и продлится он %timeLeft%. День идёт 100 минут, ночь - 50. 
															return
												}
												else
													If Command = earthCycle
														{
															oHTTP:=ComObjCreate("WinHttp.WinHttpRequest.5.1")
															oHTTP.Open("Get", "https://api.warframestat.us/pc/earthCycle" , False)						  
															oHTTP.SetRequestHeader("Content-Type", "application/json")	
															oHTTP.SetRequestHeader("X-Access-Key" , "SOMEKEYHERE")	
															oHTTP.Send()							    
															response := oHTTP.ResponseText
															oHTTP := ""
															jsnew := response
															jspars := JsonToAHK(jsnew)
															active := % jspars.state
															timeLeft := % jspars.timeLeft
															SoundPlay, *64
																if active = night
																	{
																		active = ночь
																		Clipboard = На МИССИЯХ земли сейчас %active% и продлится она %timeLeft%. Время суток изменяется каждые 4 часа. 
																		return
																	}
																	else
																		active = День
																		Clipboard = На МИССИЯХ земли сейчас %active% и продлится он %timeLeft%. Время суток изменяется каждые 4 часа.
																		return	
														}
														else
															if Command = vallisCycle
																{
																	oHTTP:=ComObjCreate("WinHttp.WinHttpRequest.5.1")
																	oHTTP.Open("Get", "https://api.warframestat.us/pc/vallisCycle" , False)						  
																	oHTTP.SetRequestHeader("Content-Type", "application/json")	
																	oHTTP.SetRequestHeader("X-Access-Key" , "SOMEKEYHERE")	
																	oHTTP.Send()							    
																	response := oHTTP.ResponseText
																	oHTTP := ""
																	jsnew := response
																	jspars := JsonToAHK(jsnew)
																	active := % jspars.state
																	timeLeft := % jspars.timeLeft
																	SoundPlay, *64
																		if active = cold
																			{
																				active = Холодно
																				Clipboard = В Долине Сфер сейчас %active% и потеплеет через %timeLeft%. Тепло 6 минут 40 секунд, Холодно 20 минут.
																				return
																			}
																			else
																				active = Тепло
																				Clipboard = В Долине Сфер сейчас %active% и похолодает через %timeLeft%. Тепло 6 минут 40 секунд, Холодно 20 минут.
																				return		
																}
																else												
    																Clipboard = %Command%
																	return
}

class textMenu
{
	__New(ByRef VariableOrFileName, FunctionName := "") {
		if !IsFunc(FunctionName)
			throw FunctionName " is not a valid function name"

		this.dat := this.dataToArray(VariableOrFileName)
		this.fn := FunctionName
		this.menuName := &this

		for i, line in this.dat
		{
			if tabCount := this.isSubMenu(i)
				this.begin_subMenu(i, tabCount)
			else
			{
				line := LTrim(line, "`t")

				this.addMenu(line)

				if (SubStr(line, 1, 1) = ".")
					Menu, % this.menuName, Disable, % SubStr(line, 2)

				if this.isEndOfSubMenu(i)
					this.add_subMenu()
			}
		}

		this.dat := this.fn := this.subMenu := ""
	}

	__Delete() {
		Menu, % this.menuName, Delete
	}

	addMenu(ByRef line) {
		if (line ~= "^-{3,}")
			Menu, % this.menuName, Add
		else
		{
			if !RegExMatch(line, "^(.*?)\s*=\s*(.*)$", m) {
				m1 := line
			}
			m1 := LTrim(m1, ".")
			fn := Func(this.fn).Bind(m2)
			Menu, % this.menuName, Add, % m1, % fn
		}
	}

	nextLineTabCount(i) {
		if ( i+1 <= this.dat.MaxIndex() )
		&& ( RegExMatch(this.dat[i+1], "P)^\t+", tabCount) )
			return tabCount
	}

	isEndOfSubMenu(i) {
		return this.nextLineTabCount(i) < this.subMenu.tabCount
	}

	isSubMenu(i) {
		tabs := this.nextLineTabCount(i)
		return (tabs > this.subMenu.tabCount) ? tabs : 0
	}

	begin_subMenu(i, tabCount) {
		this.subMenu := { name: this.menuName
		                 , text: LTrim(this.dat[i], "`t")
		                 , tabCount: tabCount
		                 , pre_subMenu: this.subMenu }
		this.menuName := &this "_" i
	}

	add_subMenu() {
		Menu, % this.subMenu.name, Add, % this.subMenu.text, % ":" this.menuName
		this.menuName := this.subMenu.name
		this.subMenu := this.subMenu.pre_subMenu
	}

	dataToArray(ByRef VariableOrFileName) {
		if FileExist(VariableOrFileName)
			content := FileOpen(VariableOrFileName, "r").Read()
		else
			content := VariableOrFileName
		
		content := Trim(content, "`r`n")
		content := RegExReplace(content, "\R+", "`n")
		return StrSplit(content, "`n", "`r")
	}

	show() {
		Menu, % this.menuName, Show
	}
}

JsonToAHK(json, rec := false) { 
   static doc := ComObjCreate("htmlfile") 
         , __ := doc.write("<meta http-equiv=""X-UA-Compatible"" content=""IE=9"">") 
         , JS := doc.parentWindow 
   if !rec 
      obj := %A_ThisFunc%(JS.eval("(" . json . ")"), true) 
   else if !IsObject(json) 
      obj := json 
   else if JS.Object.prototype.toString.call(json) == "[object Array]" { 
      obj := [] 
      Loop % json.length 
         obj.Push( %A_ThisFunc%(json[A_Index - 1], true) ) 
   } 
   else { 
      obj := {} 
      keys := JS.Object.keys(json) 
      Loop % keys.length { 
         k := keys[A_Index - 1] 
         obj[k] := %A_ThisFunc%(json[k], true) 
      } 
   } 
   Return obj 
} 
return 

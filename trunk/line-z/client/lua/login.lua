--[[ LOGIN.LUA		drline 2012

	keepin it modular

--]]

--vars
local usrName,confFile
local loginWnd,loginBtn,loginLab,loginEdt,loginTry =
													 {},
													 {},
													 {},
													 {},
													 0
--funcs
 --util
function centerWindow(center_window)
    local screenW,screenH=guiGetScreenSize()
    local windowW,windowH=guiGetSize(center_window,false)
    local x,y = (screenW-windowW)/2,(screenH-windowH)/2
    guiSetPosition(center_window,x,y,false)
end
 --login gui
function createLoginWindow()
	confFile = xmlLoadFile("@usr.xml")
	if (confFile) then
		usrName = xmlNodeGetAttribute(confFile,"name")
	else
		confFile = xmlCreateFile("@usr.xml","user")
		xmlNodeSetAttribute(confFile,"name","")
		usrName = getPlayerName(localPlayer)
	end
	loginWnd[1] = guiCreateWindow(0.393,0.3815,0.2169,0.1992,"WELCOME",true)
	centerWindow(loginWnd[1])
	guiSetAlpha(loginWnd[1],1)
	
	loginLab[1] = guiCreateLabel(0.0913,0.2484,0.1032,0.1111,"User",true,loginWnd[1])
	loginLab[2] = guiCreateLabel(0.0913,0.4641,0.1032,0.1111,"Pass",true,loginWnd[1])
	
	loginEdt[1] = guiCreateEdit(0.2143,0.2353,0.6508,0.1373,usrName,true,loginWnd[1])
	guiEditSetMaxLength(loginEdt[1], 32)
	
	loginEdt[2] = guiCreateEdit(0.2143,0.4444,0.6508,0.1373,"",true,loginWnd[1])
	guiEditSetMaxLength(loginEdt[2], 64)
	guiEditSetMasked(loginEdt[2],true)
	addEventHandler("onClientGUIAccepted", loginEdt[2], loginSubmit, false)
	
	loginBtn[1] = guiCreateButton(0.3214,0.6863,0.3849,0.1895,"LOGIN",true,loginWnd[1])
	addEventHandler("onClientGUIClick", loginBtn[1], loginSubmit, false)
	
	guiSetVisible(loginWnd[1], false)
end	
function loginSubmit(btn,pos)
	if ((btn == "left") and (pos == "up")) or ((btn == loginEdt[2] or btn == loginEdt[1]) and (not pos))  then
		local one,two = guiGetText(loginEdt[1]),
						guiGetText(loginEdt[2])
		if (one == "") or (two == "") then
			return
		else
			if (not confFile) then
				confFile = xmlLoadFile("usr.xml")
			end
			xmlNodeSetAttribute(confFile,"name",guiGetText(loginEdt[1]))
			xmlSaveFile(confFile)
			xmlUnloadFile(confFile)
			triggerServerEvent("onLoginTry", getRootElement(), one, two, loginTry)
			guiSetProperty(loginEdt[2], "Text", "")
			loginTry = loginTry + math.random(52,64)
		end
	end
end

--EVs
function showLogin(bVis)
	guiSetVisible(loginWnd[1], bVis)
	showCursor(bVis)
	guiSetInputEnabled(bVis)
end
addEvent("showLoginEv", true)
addEventHandler("showLoginEv", root, showLogin)
function showInval()
	guiSetText(loginWnd[1], "INVALID PASSWORD")
	guiLabelSetColor(loginLab[2],255,0,0)
end
addEvent("showInvalEv", true)
addEventHandler("showInvalEv", root, showInval)
function loginInitHandler()
	createLoginWindow()
	if (loginWnd == nil) then
		outputChatBox("GUI ERROR")
		return
	else
		showChat(false)
		showLogin(true)
	end
end
addEventHandler("onClientResourceStart", resourceRoot, loginInitHandler)

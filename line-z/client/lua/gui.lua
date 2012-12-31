--[[ GUI.LUA		drline 2012
	THIS IS ALL GUI STUFF
	todo: fix / update

--]]


--VARIABLES
 --share
local screenWidth,screenHeight = guiGetScreenSize()
 --dmon
local statsLabel = {}
 --icons
local fading = 0
local fading2 = "up"
 --flash
local whiteWindow,wwAlpha,wwControlState
 --sboard
local playerRankingTable = {}
local yA = 0


--FUNCTIONS
 --util
function math.round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
    else return tonumber(("%."..decimals.."f"):format(number)) end
end


--GUI ELEMENTS
 --debug monitor
function createDebugMonitor()
	statsWindows = guiCreateStaticImage(0.775,0.2,0.225,0.22,"client/image/scrollmenu_1.png",true)
	guiSetAlpha(statsWindows,0.8)
	--Zombies  Killed
	statsLabel["zombieskilled"] = guiCreateLabel(0,0.05,1,0.15,"Zombies Killed: 0",true,statsWindows)
	guiLabelSetHorizontalAlign (statsLabel["zombieskilled"],"center")
	guiSetFont (statsLabel["zombieskilled"], "default-bold-small" )
	setElementData(statsLabel["zombieskilled"],"identifikation","zombieskilled")
	--Headshots
	statsLabel["headshots"] = guiCreateLabel(0,0.15,1,0.15,"Headshots: 0",true,statsWindows)
	guiLabelSetHorizontalAlign (statsLabel["headshots"],"center")
	guiSetFont (statsLabel["headshots"], "default-bold-small" )
	setElementData(statsLabel["headshots"],"identifikation","headshots")
	--Murders
	statsLabel["murders"] = guiCreateLabel(0,0.25,1,0.15,"Murders: 0",true,statsWindows)
	guiLabelSetHorizontalAlign (statsLabel["murders"],"center")
	guiSetFont (statsLabel["murders"], "default-bold-small" )
	setElementData(statsLabel["murders"],"identifikation","murders")
	--Bandits Killed
		statsLabel["banditskilled"] = guiCreateLabel(0,0.35,1,0.15,"Bandits Killed: 0",true,statsWindows)
	guiLabelSetHorizontalAlign (statsLabel["banditskilled"],"center")
	guiSetFont (statsLabel["banditskilled"], "default-bold-small" )
	setElementData(statsLabel["banditskilled"],"identifikation","banditskilled")
	--Blood
		statsLabel["blood"] = guiCreateLabel(0,0.45,1,0.15,"Blood: 12000",true,statsWindows)
	guiLabelSetHorizontalAlign (statsLabel["blood"],"center")
	guiSetFont (statsLabel["blood"], "default-bold-small" )
	setElementData(statsLabel["blood"],"identifikation","blood")
	--Zombies
	statsLabel["zombies"] = guiCreateLabel(0,0.55,1,0.15,"Zombies (Alive/Total): 0/0",true,statsWindows)
	guiLabelSetHorizontalAlign (statsLabel["zombies"],"center")
	guiSetFont (statsLabel["zombies"], "default-bold-small" )
	setElementData(statsLabel["zombies"],"identifikation","zombies")
	--Temperature
	statsLabel["temperature"] = guiCreateLabel(0,0.65,1,0.15,"Temperature: 37°C",true,statsWindows)
	guiLabelSetHorizontalAlign (statsLabel["temperature"],"center")
	guiSetFont (statsLabel["temperature"], "default-bold-small" )
	setElementData(statsLabel["temperature"],"identifikation","temperature")
	--Humanity
	statsLabel["humanity"] = guiCreateLabel(0,0.75,1,0.15,"Humanity: 2500",true,statsWindows)
	guiLabelSetHorizontalAlign (statsLabel["humanity"],"center")
	guiSetFont (statsLabel["humanity"], "default-bold-small" )
	setElementData(statsLabel["humanity"],"identifikation","humanity")
	--Name
	statsLabel["name"] = guiCreateLabel(0,0.85,1,0.15,"Name: "..getPlayerName(localPlayer),true,statsWindows)
	guiLabelSetHorizontalAlign (statsLabel["name"],"center")
	guiSetFont (statsLabel["name"], "default-bold-small" )
	setElementData(statsLabel["name"],"identifikation","name")
	guiSetVisible(statsWindows,false)
	return statsWindows
end
function refreshDebugMonitor()
	if getElementData(localPlayer,"auth") then
		local value = getElementData(localPlayer,getElementData(statsLabel["zombieskilled"],"identifikation"))
		guiSetText(statsLabel["zombieskilled"],"Zombies Killed: "..value)
		local value = getElementData(localPlayer,getElementData(statsLabel["headshots"],"identifikation"))
		guiSetText(statsLabel["headshots"],"Headshots: "..value)
		local value = getElementData(localPlayer,getElementData(statsLabel["banditskilled"],"identifikation"))
		guiSetText(statsLabel["banditskilled"],"Bandits Killed: "..value)
		local value = getElementData(localPlayer,getElementData(statsLabel["murders"],"identifikation"))
		guiSetText(statsLabel["murders"],"Murders: "..value)
		local value = getElementData(localPlayer,getElementData(statsLabel["blood"],"identifikation"))
		guiSetText(statsLabel["blood"],"Blood: "..value)
		local value = getElementData(getRootElement(),"zombiesalive") or 0
		local value2 = getElementData(getRootElement(),"zombiestotal") or 0
		guiSetText(statsLabel["zombies"],"Zombies (Alive/Total): "..value.."/"..value2)
		local value = getElementData(localPlayer,getElementData(statsLabel["temperature"],"identifikation"))
		guiSetText(statsLabel["temperature"],"Temperature: "..math.round(value,2).." C")
		local value = getElementData(localPlayer,getElementData(statsLabel["humanity"],"identifikation"))
		guiSetText(statsLabel["humanity"],"Humanity: "..math.round(value,2))
		guiSetText(statsLabel["name"],"Name: "..getPlayerName(localPlayer))
	end			
end
setTimer(refreshDebugMonitor,2000,0)
function showDebugMonitor ()
	local visible = guiGetVisible(statsWindows)
	guiSetVisible(statsWindows,not visible)
end
addCommandHandler("debugMon", showDebugMonitor, false) --remove this bind eventually
bindKey("F5", "down", "debugMon", "")

 --icons
function updateIcons () --MAGIC MAGIC MAGIC MAGIC MAGIC
if getElementData(localPlayer,"auth") then
	--fading
	if fading >= 0 and fading2 == "up" then
		fading = fading + 5
	elseif fading <= 255 and fading2 == "down" then
		fading = fading - 5
	end
	--fading math.
	if fading == 0 then
		fading2 = "up"
	elseif fading == 255 then
		fading2 = "down"
	end
	--sound
	dxDrawImage ( screenWidth*0.9325 , screenHeight*0.41, screenHeight*0.075, screenHeight*0.075, "client/image/icons/sound.png",0,0,0,tocolor(0,255,0))
	local sound = getElementData(localPlayer,"volume")/20
	if sound > 1 then
		dxDrawImage ( screenWidth*0.9075 , screenHeight*0.41, screenHeight*0.075, screenHeight*0.075, "client/image/icons/level_"..sound..".png",0,0,0,tocolor(0,255,0))
	end
	--visibly
	dxDrawImage ( screenWidth*0.9325 , screenHeight*0.475, screenHeight*0.075, screenHeight*0.075, "client/image/icons/eye.png",0,0,0,tocolor(0,255,0))
	local sound = getElementData(localPlayer,"visibly")/20
	if sound > 1 then
		dxDrawImage ( screenWidth*0.9075 , screenHeight*0.475, screenHeight*0.075, screenHeight*0.075, "client/image/icons/level_"..sound..".png",0,0,0,tocolor(0,255,0))
	end
	--brokenbone
	if getElementData(localPlayer,"brokenbone") then
		dxDrawImage ( screenWidth*0.9375 , screenHeight*0.55, screenHeight*0.065, screenHeight*0.065, "client/image/icons/brokenbone.png",0,0,0,tocolor(255,255,255))
	end
	--bandit	
	local humanity =  getElementData(localPlayer,"humanity")
	if (humanity) and (humanity > 0) then
		local humanity =  getElementData(localPlayer,"humanity")/9.8
		r,g,b = 255-humanity,humanity,0
	else	
		r,g,b = 255,0,0
	end
		dxDrawImage ( screenWidth*0.925 , screenHeight*0.6, screenHeight*0.1, screenHeight*0.1, "client/image/icons/bandit.png",0,0,0,tocolor(r,g,b))
	--temperature
	local temperature = math.round(getElementData(localPlayer,"temperature"),2)
	r,g,b = 0,255,0
	if temperature <= 37 then
		value = (37-temperature)*42.5
		r,g,b = 0,255-value,value
	elseif temperature > 37 and temperature < 41 then
		r,g,b = 0,255,0
	elseif temperature == 41 then
		r,g,b = 255,0,0
	end
	if value > 215 then
		dxDrawImage ( screenWidth*0.94 , screenHeight*0.7, screenHeight*0.065, screenHeight*0.065, "client/image/icons/temperature.png",0,0,0,tocolor(r,g,b,fading))
	else
		dxDrawImage ( screenWidth*0.94 , screenHeight*0.7, screenHeight*0.065, screenHeight*0.065, "client/image/icons/temperature.png",0,0,0,tocolor(r,g,b))
	end
	--thirsty
	r,g,b = 0,255,0
	local thirst = getElementData(localPlayer,"thirst")*2.55
	r,g,b = 255-thirst,thirst,0
	if thirst < 15 then
		dxDrawImage ( screenWidth*0.94 , screenHeight*0.775, screenHeight*0.065, screenHeight*0.065, "client/image/icons/thirsty.png",0,0,0,tocolor(r,g,b,fading))
	else
		dxDrawImage ( screenWidth*0.94 , screenHeight*0.775, screenHeight*0.065, screenHeight*0.065, "client/image/icons/thirsty.png",0,0,0,tocolor(r,g,b))
	end	
	--blood
	r,g,b = 0,255,0
	local blood = getElementData(localPlayer,"blood")/47.2
	r,g,b = 255-blood,blood,0
	dxDrawImage ( screenWidth*0.94 , screenHeight*0.85, screenHeight*0.065, screenHeight*0.065, "client/image/icons/blood.png",0,0,0,tocolor(r,g,b))
	if getElementData(localPlayer,"bleeding") > 0 then
		dxDrawImage ( screenWidth*0.94 , screenHeight*0.85, screenHeight*0.065, screenHeight*0.065, "client/image/icons/medic.png",0,0,0,tocolor(255,255,255,fading))
	end
	--food
	r,g,b = 0,255,0
	local food = getElementData(localPlayer,"food")*2.55
	r,g,b = 255-food,food,0
	if food < 15 then
		dxDrawImage ( screenWidth*0.94 , screenHeight*0.925, screenHeight*0.065, screenHeight*0.065, "client/image/icons/food.png",0,0,0,tocolor(r,g,b,fading))
	else
		dxDrawImage ( screenWidth*0.94 , screenHeight*0.925, screenHeight*0.065, screenHeight*0.065, "client/image/icons/food.png",0,0,0,tocolor(r,g,b))
	end	
	--Nametags
	local x,y,z = getElementPosition(localPlayer)
	for i,player in ipairs(getElementsByType("player")) do
		setPlayerNametagShowing ( player, false )
		if player ~= localPlayer then
		local vehicle = getPedOccupiedVehicle(player)
                local px,py,pz = getElementPosition (player)
                local pdistance = getDistanceBetweenPoints3D ( x,y,z,px,py,pz )
                if pdistance <= 2.5 then
                    --Get screenposition
                    local sx,sy = getScreenFromWorldPosition ( px, py, pz+0.95, 0.06 )
					if sx and sy then
					--Draw Name
					if getElementData(player,"bandit") then
						text = string.gsub(getPlayerName(player), '#%x%x%x%x%x%x', '' ).." (Bandit)"
					else
						text = string.gsub(getPlayerName(player), '#%x%x%x%x%x%x', '' )
					end
					local w = dxGetTextWidth(text,1.02,"default-bold")
					dxDrawText (text, sx-(w/2), sy, sx-(w/2), sy, tocolor ( 100, 255, 100, 200 ), 1.02, "default-bold" )
					end
				end
		end		
	end
	--Vehicletags
	local x,y,z = getElementPosition(localPlayer)
	for i,veh in ipairs(getElementsByType("vehicle")) do
				local px,py,pz = getElementPosition (veh)
				local vehID = getElementModel(veh)
				local vehicle = getPedOccupiedVehicle(localPlayer)
				if veh ~= vehicle then
				if vehID ~= 548 then
                local pdistance = getDistanceBetweenPoints3D ( x,y,z,px,py,pz )
                if pdistance <= 6 then
                    --Get screenposition
                    local sx,sy = getScreenFromWorldPosition ( px, py, pz+0.95, 0.06 )
					if sx and sy then
					--Draw Vehicle
					local w = dxGetTextWidth(getVehicleName(veh),1.02,"default-bold")
					dxDrawText ( getVehicleName(veh), sx-(w/2), sy, sx-(w/2), sy, tocolor ( 100, 255, 100, 200 ), 1.02, "default-bold" )	
					end
				end
				end
				end
	end
	--Vehicle Infos
	local veh = getPedOccupiedVehicle (localPlayer)
	if veh then
		local maxfuel = getElementData(veh,"maxfuel")
		local fuel = getElementData(getElementData(veh,"Ext"),"fuel")
		local needengine = getElementData(veh,"needengines")
		local needtires = getElementData(veh,"needtires")
		local engine = getElementData(getElementData(veh,"Ext"),"Engine_inVehicle") or 0
		local tires = getElementData(getElementData(veh,"Ext"),"Tire_inVehicle") or 0
		local offset = dxGetFontHeight(1.02,"default-bold")
		local w = dxGetTextWidth(engine.."/"..needengine.." Engine(s)",1.02,"default-bold")
		if engine == needengine then
			r,g,b = 0,255,0
		else
			r,g,b = 255,0,0
		end
		dxDrawText (engine.."/"..needengine.." Engine(s)" ,screenWidth*0.5-w/2 , screenHeight*0,screenWidth*0.5-w/2 , screenHeight*0,tocolor ( r,g,b, 220 ), 1.02, "default-bold" )
		local w = dxGetTextWidth(tires.."/"..needtires.." Tires",1.02,"default-bold")
		if tires == needtires then
			r,g,b = 0,255,0
		else
			r,g,b = 255,0,0
		end
		dxDrawText (tires.."/"..needtires.." Tires",screenWidth*0.5-w/2 , screenHeight*0+offset,screenWidth*0.5-w/2 , screenHeight*0+offset,tocolor ( r,g,b, 220 ), 1.02, "default-bold" )
		local w = dxGetTextWidth("Fuel:"..math.floor(fuel).."/"..maxfuel,1.02,"default-bold")
		if fuel == maxfuel then
			r,g,b = 0,255,0
		elseif fuel < (maxfuel/10) then
			r,g,b = 255,0,0	
		elseif fuel < (maxfuel/4) then
			r,g,b = 255,50,0	
		elseif fuel < (maxfuel/3) then
			r,g,b = 200,100,0
		elseif fuel < (maxfuel/2) then
			r,g,b = 125,200,0		
		elseif fuel < (maxfuel/1.5) then
			r,g,b = 50,200,0
		end
		dxDrawText ("Fuel:"..math.floor(fuel).."/"..maxfuel,screenWidth*0.5-w/2 , screenHeight*0+offset*2,screenWidth*0.5-w/2 , screenHeight*0+offset*2,tocolor ( r,g,b, 220 ), 1.02, "default-bold" )
	end
end	
end
addEventHandler ( "onClientRender", getRootElement(), updateIcons )

 --death screen
function dayZDeathInfo ()
	fadeCamera (false, 1.0, 0, 0, 0 ) 
	setTimer(showDayZDeathScreen,2000,1)
end
addEvent("onClientPlayerDeathInfo",true)
addEventHandler("onClientPlayerDeathInfo",getRootElement(),dayZDeathInfo)
function showDayZDeathScreen()
	setTimer ( fadeCamera, 1000, 1, true, 1.5 )
	deadBackground = guiCreateStaticImage(0,0,1,1,"client/image/dead.jpg",true)
	deathText = guiCreateLabel(0,0.8,1,0.2,"You died, \n you will respawn in 5 seconds.",true)
	guiLabelSetHorizontalAlign (deathText,"center")
	setTimer(guiSetVisible,5000,1,deathText,false)
	setTimer(guiSetVisible,5000,1,deadBackground,false)	
	setTimer(destroyElement,5010,1,deathText)
	setTimer(destroyElement,5010,1,deadBackground)
end

 --whiteflash
function createFlashWnd()
	whiteWindow = guiCreateStaticImage(0,0,1,1,"client/image/white.png",true)
	guiSetVisible(whiteWindow,false)
	return whiteWindow
end
function showPlayerDamageScreen (wwAlpha2,wwControlState2)
	guiSetVisible(whiteWindow,true)
	wwAlpha = wwAlpha2 or wwAlpha	
	wwControlState = wwControlState2 or wwControlState
	if wwAlpha >= 10*0.075 and wwControlState == "up" then
		wwControlState = "down"
	end
	if wwAlpha < 0 then
		guiSetVisible(whiteWindow,false)
		return
	end
	if wwControlState == "up" then
		wwAlpha = wwAlpha + 0.075
	elseif wwControlState == "down" then
		wwAlpha = wwAlpha - 0.075
	end
	guiSetAlpha(whiteWindow,wwAlpha)
	setTimer(showPlayerDamageScreen,50,1)
end
function showWhiteScreen ( attacker, weapon, bodypart )
	--if weapon then
		showPlayerDamageScreen (0,"up")
	--end
end
addEventHandler ( "onClientPlayerDamage", localPlayer, showWhiteScreen )

--gps blips???
--[[function showBlipGps()
function showBlipGPS ()
local blips = getElementsByType("player")
if getElementData(localPlayer,"Thermal GPS") >= 1 then
	for index, blip in ipairs(blips) do
		local player = getElementData(blip,"player")
		setBlipVisibleDistance(blip,0)
		if getElementData(player,"temperature") >= 40 then
			if getElementData(player,"GPS Jammer") >= 1 then
				setBlipVisibleDistance(blip,0)
			else
				setBlipVisibleDistance(blip,180)
			end
		end	
	end
end	
end	--]]
--setTimer(showBlipGPS,500,0)
--addEventHandler ( "onClientHUDRender", getRootElement(), showBlipGPS ) 
--[[function destroyBlipGPS () --why this is commented out ill never know; maybe i should FIGURE IT OUT
function destroyBlipGPS ()
local blips = getElementsByType("blip")
	for index, blip in ipairs(blips) do
		destroyElement(blip)
	end
local players = getElementsByType("player")
	for index, player in ipairs(players) do
		local blip = createBlipAttachedTo(player,0,2,255,255,255,180)
		setElementData(blip,"player",player)
		setBlipVisibleDistance(blip,0)
	end	
end --]]
--setTimer(destroyBlipGPS,5000,0) 

--Support Chat (no support for now)
--[[ clean me up please
supportWindow = guiCreateStaticImage(0.05,0.25,0.9,0.5,"client/image/scrollmenu_1.png",true)
guiSetVisible(supportWindow,false)
supportGridlist = guiCreateGridList ( 0.05,0.1,0.9,0.7,true,supportWindow)
nameColumn = guiGridListAddColumn( supportGridlist, "Name", 0.2 )
messageColumn = guiGridListAddColumn( supportGridlist, "Message", 0.8 )
messageInput = guiCreateEdit( 0.05, 0.825, 0.9, 0.075, "", true,supportWindow )
closeButton = guiCreateButton( 0.9, 0.015, 0.09, 0.05, "Close!", true, supportWindow )

function openSupportChat ()
	local showing = guiGetVisible(supportWindow)
	guiSetVisible(supportWindow,not showing)
	showCursor(not showing)
	toggleControl ("chatbox",showing)
	if showing == false then
		unbindKey("o","down",openSupportChat)
		unbindKey("j","down",showInventory)
	else
		bindKey("o","down",openSupportChat)
		bindKey ("j","down",showInventory)
	end
end
bindKey("o","down",openSupportChat)

function outputEditBox ()
      local showing = guiGetVisible(supportWindow)
	guiSetVisible(supportWindow,false)
	showCursor(false)
	toggleControl ("chatbox",true) 
	bindKey("o","down",openSupportChat)
	bindKey ("j","down",showInventory)
end
addEventHandler ( "onClientGUIClick", closeButton, outputEditBox, false )

addEventHandler( "onClientGUIAccepted", messageInput,
    function( theElement ) 
		if not isSpamTimer() then
			local text = guiGetText( theElement )
			triggerServerEvent ( "onServerSupportChatMessage", localPlayer,localPlayer,text)
		end
		setAntiSpamActive()
		guiSetText(messageInput,"")
    end
)

function outputSupportChat(sourcePlayer,text)
		local row = guiGridListAddRow ( supportGridlist )
		if sourcePlayer == "Sandra" or sourcePlayer == "James" or sourcePlayer == "Paul" then
			name =  sourcePlayer.." (Bot)"
		elseif not getElementData(sourcePlayer,"auth") then
			name = string.gsub(getPlayerName ( sourcePlayer ), '#%x%x%x%x%x%x', '').." (Guest)"
		else
			if getElementData(sourcePlayer,"admin") then
				name = string.gsub(getPlayerName ( sourcePlayer ), '#%x%x%x%x%x%x', '').." (Admin)"
			elseif getElementData(sourcePlayer,"supporter") then
				name = string.gsub(getPlayerName ( sourcePlayer ), '#%x%x%x%x%x%x', '').." (Supporter)"
			else
				name = string.gsub(getPlayerName ( sourcePlayer ), '#%x%x%x%x%x%x', '').." (Player)"
			end
		end
		guiGridListSetItemText ( supportGridlist, row, nameColumn, name, false, false )
		guiGridListSetItemText ( supportGridlist, row, messageColumn,text , false, false )
		if sourcePlayer == "Sandra" then 
			r,g,b = 255,30,120
		elseif sourcePlayer == "James" or sourcePlayer == "Paul" then
			r,g,b = 255,255,22
		elseif getElementData(sourcePlayer,"admin") then
			r,g,b = 255,22,0
		elseif getElementData(sourcePlayer,"supporter") then
			r,g,b = 22,255,0
		else
			r,g,b = 255,255,255
		end
		guiGridListSetItemColor ( supportGridlist, row, nameColumn, r, g, b )
end
addEvent("onSupportChatMessage",true)
addEventHandler("onSupportChatMessage", getRootElement(),outputSupportChat,true)

--antispam
local antiSpamTimer = {}
function setAntiSpamActive()
	if not isTimer(antiSpamTimer) then
		antiSpamTimer = setTimer(killAntiSpamTimer,1000,1)
	else
		killTimer(antiSpamTimer)
		antiSpamTimer = setTimer(killAntiSpamTimer,2500,1)
	end
end

function isSpamTimer()
	if isTimer(antiSpamTimer) then 
		outputChatBox("Dont Spam the Support Chat", 255, 255, 0,true)
		return true
	else
		return false
	end
end

function killAntiSpamTimer ()
killTimer(antiSpamTimer)
end
--]]

--scoreboard
function getRankingPlayer (place)
return playerRankingTable[place]["Player"]
end
function getElementDataPosition(key,value)
	if key and value then
		local result = 1
		for i,player in pairs(getElementsByType("player")) do
			local data = tonumber(getElementData(player,key))
			if data then
				if data > value then 
					result = result+1
				end
			end
		end
		return result
	end
end
function positionGetElementData(key, positions)
	if key and positions then
		local Position = {}
		for index,player in pairs(getElementsByType("player")) do
			local data = tonumber(getElementData(player,key))
			if data then
				for i1=1, positions, 1 do
					if Position[tonumber(i1)] then
						if Position[tonumber(i1)]["Wert"] < tonumber(data) then
							local Position_Cache1 = Position[tonumber(i1)]["Player"]
							local Position_Cache2 = Position[tonumber(i1)]["Wert"]
							local Position_Cache3
							local Position_Cache4
							for i2=i1, positions, 1 do
								if Position[tonumber(i2)] then
									Position_Cache3 = Position[tonumber(i2)]["Player"]
									Position_Cache4 = Position[tonumber(i2)]["Wert"]
									Position[tonumber(i2)]["Player"] = Position_Cache1
									Position[tonumber(i2)]["Wert"] = Position_Cache2
									Position_Cache1 = Position_Cache3
									Position_Cache2 = Position_Cache4
								else
									Position[tonumber(i2)] = {}
									Position[tonumber(i2)]["Player"] = Position_Cache1
									Position[tonumber(i2)]["Wert"] = Position_Cache2
									break
								end
							end
							Position[tonumber(i1)] = {}
							Position[tonumber(i1)]["Player"] = player
							Position[tonumber(i1)]["Wert"] = data
							break
						end
					else
						Position[tonumber(i1)] = {}
						Position[tonumber(i1)]["Player"] = player
						Position[tonumber(i1)]["Wert"] = data
						break
					end
				end
			end
		end
		return Position
	end
end
function roundTime(value)
	if value then
		local theTime = getRealTime(value*60)
		local yearday = theTime.yearday
		local hours = theTime.hour
		local minutes = theTime.minute
		return hours+((yearday*24)-1)..":"..minutes
	end
	return false
end

function onQuitGame( reason )
    checkTopPlayer()
end
addEventHandler( "onClientPlayerQuit", getRootElement(), onQuitGame )
function scoreBoard () --MORE MAGIC 
if getKeyState( "tab" ) == false then return end
if getElementData(localPlayer,"auth") then
local offset = dxGetFontHeight(1.55,"default-bold")
--Background
dxDrawImage ( screenWidth*0.15 , screenHeight*0.2, screenWidth*0.7, screenHeight*0.2+yA, "client/image/window_bg.png",0,0,0,tocolor(255,255,255))

--Table Form
dxDrawRectangle ( screenWidth*0.15, screenHeight*0.2+offset*2, screenWidth*0.7, screenHeight*0.0025, tocolor ( 255, 255, 255, 220 ) )

--Table Spalten
	--Name
	dxDrawText ("Name", screenWidth*0.175 , screenHeight*0.2+offset, screenWidth*0.175 , screenHeight*0.2+offset, tocolor ( 50, 255, 50, 200 ), 1.5, "default-bold" )
	w1 = dxGetTextWidth("Name",1.5,"default-bold")
	--Murders
	dxDrawText ("Murders", screenWidth*0.3+w1*1.6, screenHeight*0.2+offset, screenWidth*0.3+w1*1.6 , screenHeight*0.2+offset, tocolor ( 50, 255, 50, 200 ), 1.5, "default-bold" )
	w2 = dxGetTextWidth("Murders",1.5,"default-bold")
	dxDrawRectangle ( screenWidth*0.3+w1*1.6-w2*0.1-(screenWidth*0.0025/2), screenHeight*0.2, screenWidth*0.0025, screenHeight*0.2+yA, tocolor ( 255, 255, 255, 220 ) )
	dxDrawRectangle ( screenWidth*0.3+w1*1.6+w2*1.1-(screenWidth*0.0025/2), screenHeight*0.2, screenWidth*0.0025, screenHeight*0.2+yA, tocolor ( 255, 255, 255, 220 ) )
	
	--Zombies Killed
	dxDrawText ("Zombies Killed", screenWidth*0.3+w1*1.6+w2*1.1-(screenWidth*0.0025/2)+w2*0.1, screenHeight*0.2+offset, screenWidth*0.3+w1*1.6 , screenHeight*0.2+offset, tocolor ( 50, 255, 50, 200 ), 1.5, "default-bold" )
	w3 = dxGetTextWidth("Zombies Killed",1.5,"default-bold")
	dxDrawRectangle ( screenWidth*0.3+w1*1.6+w2*1.1+w3+w2*0.1+(screenWidth*0.0025/2), screenHeight*0.2, screenWidth*0.0025, screenHeight*0.2+yA, tocolor ( 255, 255, 255, 220 ) )
	
	--Zombies Killed
	dxDrawText ("Alive Time", screenWidth*0.3+w1*1.6+w2*1.1+w3+w2*0.1+(screenWidth*0.0025/2)+w2*0.1, screenHeight*0.2+offset, screenWidth*0.3+w1*1.6 , screenHeight*0.2+offset, tocolor ( 50, 255, 50, 200 ), 1.5, "default-bold" )
	w4 = dxGetTextWidth("Alive Time",1.5,"default-bold")
	dxDrawRectangle ( screenWidth*0.3+w1*1.6+w2*1.1+w3+w2*0.1+(screenWidth*0.0025/2)+w2*0.1+w4+w2*0.1, screenHeight*0.2, screenWidth*0.0025, screenHeight*0.2+yA, tocolor ( 255, 255, 255, 220 ) )
	
	--Player Amount
		dxDrawText ("Players:"..#getElementsByType("player"), screenWidth*0.3+w1*1.6+w2*1.1+w3+w2*0.1+(screenWidth*0.0025/2)+w2*0.1+w4+w2*0.1+w4/3, screenHeight*0.2+offset, screenWidth*0.8 , screenHeight*0.2+offset, tocolor ( 50, 255, 50, 200 ), 1.5, "default-bold" )

--Player
playerInList = false
local playerAmount = #getElementsByType("player")
if playerAmount > 10 then
	playerAmount = 10
end
for i = 1, playerAmount do
	yA = i*offset
	local offset2 = dxGetFontHeight(1.5,"default-bold")
	--Spiler Getten
	local player = getRankingPlayer(i) or false
	if not player then break end
	--Abfragen ob spieler == local Player
	r,g,b = 255,255,255
	if getPlayerName(player) == getPlayerName(localPlayer) then
	r,g,b = 50, 255, 50
	playerInList = true
	end
	--dxDrawImage(screenWidth*0.175 , screenHeight*0.2+offset*2+yA-offset2*0.1, screenWidth*0.65, offset2+offset2*0.1,"client/image/background_scoreboard.png", 0,0,0,tocolor(255,255,255,200), false)
	--Position
	dxDrawText (i, screenWidth*0.155 , screenHeight*0.2+offset*2+yA, screenWidth*0.175, screenHeight*0.2+offset+yA, tocolor ( r,g,b, 200 ), 1.5, "default-bold" )
	--Name
	dxDrawText (string.gsub(getPlayerName(player), '#%x%x%x%x%x%x', '' ), screenWidth*0.175 , screenHeight*0.2+offset*2+yA, screenWidth*0.175, screenHeight*0.2+offset+yA, tocolor ( r,g,b, 200 ), 1.5, "default-bold" )
	--Murders
	local murders = getElementData(player,"murders")
	dxDrawText (murders, screenWidth*0.3+w1*1.6 , screenHeight*0.2+offset*2+yA, screenHeight*0.2+offset*2+yA, screenHeight*0.2+offset+yA, tocolor ( r,g,b, 200 ), 1.5, "default-bold" )
	--Bandit
	--local bandit = getElementData(player,"bandit") 
	--if bandit then
	--	r1,g1,b1 = 255,0,0
	--else
	--	r1,g1,b1 = 0,255,0
	--end
	--dxDrawText ("???", screenWidth*0.3+w1*1.6+w2*1.1-(screenWidth*0.0025/2)-w2/2,  screenHeight*0.2+offset*2+yA, screenWidth*0.3+w1*1.6+w2*1.1-(screenWidth*0.0025/2)-w2/2,  screenHeight*0.2+offset*2+yA, tocolor ( r1,g1,b1, 200 ), 1.5, "default-bold" )
	--Zombies Killed
	local zombieskilled = getElementData(player,"zombieskilled")
	dxDrawText (zombieskilled, screenWidth*0.3+w1*1.6+w2*1.1-(screenWidth*0.0025/2)+w2*0.1 , screenHeight*0.2+offset*2+yA, screenWidth*0.175, screenHeight*0.2+offset+yA, tocolor ( r,g,b, 200 ), 1.5, "default-bold" )
	--Alive Time
	local alivetime = getElementData(player,"alivetime") or 0
	dxDrawText (roundTime(alivetime), screenWidth*0.3+w1*1.6+w2*1.1+w3+w2*0.1+(screenWidth*0.0025/2)+w2*0.1 , screenHeight*0.2+offset*2+yA, screenWidth*0.175, screenHeight*0.2+offset+yA, tocolor ( r,g,b, 200 ), 1.5, "default-bold" )
end
	playerLocalAdd = 0
	if not playerInList then
		playerLocalAdd = offset
		r,g,b = 50, 255, 50
		dxDrawRectangle ( screenWidth*0.15, screenHeight*0.2+offset*2+((playerAmount+2)*offset)-offset/2, screenWidth*0.7, screenHeight*0.0025, tocolor ( 255, 255, 255, 220 ) )
		--Position
		local rank = getElementDataPosition("alivetime",getElementData(localPlayer,"alivetime"))
		dxDrawText (rank, screenWidth*0.155 , screenHeight*0.2+offset*2+((playerAmount+2)*offset), screenWidth*0.175, screenHeight*0.2+offset*2+((playerAmount+2)*offset), tocolor ( r,g,b, 200 ), 1.5, "default-bold" )
		--Name
		dxDrawText (string.gsub(getPlayerName(localPlayer), '#%x%x%x%x%x%x', '' ), screenWidth*0.175 , screenHeight*0.2+offset*2+((playerAmount+2)*offset), screenWidth*0.175, screenHeight*0.2+offset+((playerAmount+2)*offset), tocolor ( r,g,b, 200 ), 1.5, "default-bold" )
		--Murders
		local murders = getElementData(localPlayer,"murders")
		dxDrawText (murders, screenWidth*0.3+w1*1.6 , screenHeight*0.2+offset*2+((playerAmount+2)*offset), screenWidth*0.175, screenHeight*0.2+offset+((playerAmount+2)*offset), tocolor ( r,g,b, 200 ), 1.5, "default-bold" )
		--Zombies Killed
		local zombieskilled = getElementData(localPlayer,"zombieskilled")
		dxDrawText (zombieskilled, screenWidth*0.3+w1*1.6+w2*1.1-(screenWidth*0.0025/2)+w2*0.1 , screenHeight*0.2+offset*2+((playerAmount+2)*offset), screenWidth*0.175, screenHeight*0.2+offset+((playerAmount+2)*offset), tocolor ( r,g,b, 200 ), 1.5, "default-bold" )
		--Alive Time
		local alivetime = getElementData(localPlayer,"alivetime") or 0
		dxDrawText (roundTime(alivetime), screenWidth*0.3+w1*1.6+w2*1.1+w3+w2*0.1+(screenWidth*0.0025/2)+w2*0.1 , screenHeight*0.2+offset*2+((playerAmount+2)*offset), screenWidth*0.175, screenHeight*0.2+offset+((playerAmount+2)*offset), tocolor ( r,g,b, 200 ), 1.5, "default-bold" )
	end
	yA = playerAmount*offset+playerLocalAdd
end	
end
addEventHandler ( "onClientRender", getRootElement(), scoreBoard )

function checkTopPlayer()
playerRankingTable = positionGetElementData("alivetime", #getElementsByType("player"))
end
checkTopPlayer()
setTimer(checkTopPlayer,10000,0)
function updatePlayTime()
	if getElementData(localPlayer,"auth") then
		local playtime = getElementData(localPlayer,"alivetime")
		setElementData(localPlayer,"alivetime",playtime+1)	
	end	
end
setTimer(updatePlayTime, 60000, 0)



--INIT
function guiInitHandler()
	local wnd = createDebugMonitor()
	if wnd then 
		outputDebugString("debugMon created")
	else
		outputDebugString("debugMon fault")
	end
	
	wnd = createFlashWnd()
	if wnd then 
		outputDebugString("whiteflash created")
	else
		outputDebugString("whiteflash fault")
	end

end
addEventHandler("onClientResourceStart", resourceRoot, guiInitHandler)
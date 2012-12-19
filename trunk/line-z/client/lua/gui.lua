--[[ GUI.LUA		drline 2012

	keep on movin

--]]

--VARIABLES
local statsLabel = {}
local fading = 0
local fading2 = "up"
local screenWidth,screenHeight = guiGetScreenSize()
local whiteWindow

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
		guiSetText(statsLabel["temperature"],"Temperature: "..math.round(value,2).."°C")
		local value = getElementData(localPlayer,getElementData(statsLabel["humanity"],"identifikation"))
		guiSetText(statsLabel["humanity"],"Humanity: "..math.round(value,2))
		guiSetText(statsLabel["name"],"Name: "..getPlayerName(localPlayer))
	end			
end
setTimer(refreshDebugMonitor,2000,0)
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
	setTimer(guiSetVisible,5000,1,false)
	setTimer(guiSetVisible,5000,1,false)
	setTimer(destroyElement,5000,1,deathText)
	setTimer(destroyElement,5000,1,deadBackground)
end
 --whiteflash
function createFlashWnd()
	whiteWindow = guiCreateStaticImage(0,0,1,1,"client/image/white.png",true)
	guiSetVisible(whiteWindow,false)
	return whiteWindow
end
function showPlayerDamageScreen (visibly2,stateControle2)
	guiSetVisible(whiteWindow,true)
	local visibly = visibly2 or visibly	
	stateControle = stateControle2 or stateControle
	if visibly >= 10*0.075 and stateControle == "up" then
		stateControle = "down"
	end
	if visibly < 0 then
		guiSetVisible(whiteWindow,false)
		return
	end
	if stateControle == "up" then
		visibly = visibly + 0.075
	elseif stateControle == "down" then
		visibly = visibly - 0.075
	end
	guiSetAlpha(whiteWindow,visibly)
	setTimer(showPlayerDamageScreen,50,1)
end
function showWhiteScreen ( attacker, weapon, bodypart )
	--if weapon then
		showPlayerDamageScreen (0,"up")
	--end
end
addEventHandler ( "onClientPlayerDamage", localPlayer, showWhiteScreen )

--init
function guiInitHandler()
	local err,wnd = nil,nil
	
	wnd = createDebugMonitor()
	if (wnd == nil) then err = true end
	wnd = createFlashWnd()
	if (wnd == nil) then err = true end
	
	if err then
		outputChatBox("GUI ERROR")
		return
	end
end
addEventHandler("onClientResourceStart", resRoot, guiInitHandler)
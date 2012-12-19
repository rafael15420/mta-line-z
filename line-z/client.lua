--[[

GTA-DAYz / WASTELAND MOD
COPYRIGHT DRLINE 2012 DO NOT STEAL LOL

uses these fine resources: 
	marwin survivor system gui
	bone_attach resource
	glue resource
	zday resource
	betterWeather resource
]]--

--[[
#---------------------------------------------------------------#
----*			DayZ MTA Script client.lua					*----
----* HACKED												*----
----* BY													*----
----* CHINESE		--TODO: redo everything			 		*----
----*						organize this fucking shit		*----
----*						split into seperate files		*----
----*						keep gui shit in one place		*----
----*						keep logic shit in another		*----
#---------------------------------------------------------------#
]]

--VARIABLES
weaponAmmoTable = { --going into master
	["Pistol Ammo"] = {
		{"Pistol",22},
		{"Silenced Pistol",23},
		{"Desert Eagle",24},
	},
	["Smg Ammo"] = {
		{"Uzi",28},
		{"TEC-9",32},
		{"MP5",29},
	},
	["Assault Ammo"] = {
		{"AK-47",30},
		{"M4",31},
	},
	["Shotgun Ammo"] = {
		{"Shotgun",25},
		{"Sawn-Off Shotgun",26},
		{"SPAZ-12 Combat Shotgun",27},
	},
	["Sniper Ammo"] = {
		{"Country Rifle",33},
		{"Sniper Rifle",34},
	},
	["Rocket Ammo"] = {
		{"Heat-Seeking RPG",36},
		{"Rocket Launcher",35},
	},
	["others"] = {
		{"Parachute",46},
		{"Satchel",39},
		{"Tear Gas",17},
		{"Grenade",16},
		{"Knife",4},
		{"Katana",8},
	},
}
damageTable = { --to: master
{"M4",6722},
{"Sniper Rifle",11552},
{"Shotgun",2024},
{"MP5",1169},
{"SPAZ-12 Combat Shotgun",4582},
{"AK-47",3555},
{"Heat-Seeking RPG",37552},
{"Rocket Launcher",37552},
{"Country Rifle",6722},
{"Knife",1500},
{"Katana",2100},
{"Pistol",889},
{"Silenced Pistol",889},
{"Uzi",889},
{"TEC-9",889},
{"Sawn-Off Shotgun",2894},
{"Desert Eagle",2489},
{"Grenade",18000},
}
weaponNoiseTable = { --god everything is everywhere (re)MOVE ME
--0 none
--20 low
--40 moderate
--60 high
{22,20},
{23,0},
{24,60},
{28,40},
{32,40},
{29,40},
{30,60},
{31,60},
{25,40},
{26,60},
{27,60},
{33,40},
{34,60},
{36,60},
{35,60},
}

--FUNCTIONS
 --util
function math.round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
    else return tonumber(("%."..decimals.."f"):format(number)) end
end
 --etc
function getGroundMaterial(x, y, z) 
	local hit, hitX, hitY, hitZ, hitElement, normalX, normalY, normalZ, material = processLineOfSight(x, y, z, x, y, z-10, true, false, false, true, false, false, false, false, nil)
	return material
end
function isInBuilding(x, y, z) 
	local hit, hitX, hitY, hitZ, hitElement, normalX, normalY, normalZ, material = processLineOfSight(x, y, z, x, y, z+10, true, false, false, true, false, false, false, false, nil)
	if hit then return true end
	return false
end
function isObjectAroundPlayer2 ( thePlayer, distance, height ) 
material_value = 0
 local x, y, z = getElementPosition( thePlayer )
 for i = math.random(0,360), 360, 1 do
  local nx, ny = getPointFromDistanceRotation( x, y, distance, i )
 local hit, hitX, hitY, hitZ, hitElement, normalX, normalY, normalZ, material = processLineOfSight ( x, y, z + height, nx, ny, z + height,true,false,false,false,false,false,false,false )
	if material == 0 then
		material_value = material_value+1
	end
	if material_value > 40 then
		return 0,hitX, hitY, hitZ
	end
 end
 return false
end
function isObjectAroundPlayer ( thePlayer, distance, height )
 local x, y, z = getElementPosition( thePlayer )
 for i = math.random(0,360), 360, 1 do
  local nx, ny = getPointFromDistanceRotation( x, y, distance, i )
 local hit, hitX, hitY, hitZ, hitElement, normalX, normalY, normalZ, material = processLineOfSight ( x, y, z + height, nx, ny, z + height)
  if material == 0 then
   return material,hitX, hitY, hitZ
  end
 end
 return false
end
function getPointFromDistanceRotation ( x, y, dist, angle )
    local a = math.rad( 90 - angle )
    local dx = math.cos( a ) * dist
    local dy = math.sin( a ) * dist
    return x + dx, y + dy
end
function getWeaponAmmoType (weaponName) --FUTR: rewrite for master
	for i,weaponData in ipairs(weaponAmmoTable["others"]) do
		if weaponName == weaponData[1] then
			return weaponData[1],weaponData[2]
		end
	end
	for i,weaponData in ipairs(weaponAmmoTable["Pistol Ammo"]) do
		if weaponName == weaponData[1] then
			return "Pistol Ammo",weaponData[2]
		end
	end
	for i,weaponData in ipairs(weaponAmmoTable["Smg Ammo"]) do
		if weaponName == weaponData[1] then
			return "Smg Ammo",weaponData[2]
		end
	end
	for i,weaponData in ipairs(weaponAmmoTable["Assault Ammo"]) do
		if weaponName == weaponData[1] then
			return "Assault Ammo",weaponData[2]
		end
	end
	for i,weaponData in ipairs(weaponAmmoTable["Shotgun Ammo"]) do
		if weaponName == weaponData[1] then
			return "Shotgun Ammo",weaponData[2]
		end
	end
	for i,weaponData in ipairs(weaponAmmoTable["Sniper Ammo"]) do
		if weaponName == weaponData[1] then
			return "Sniper Ammo",weaponData[2]
		end
	end
	for i,weaponData in ipairs(weaponAmmoTable["Rocket Ammo"]) do
		if weaponName == weaponData[1] then
			return "Rocket Ammo",weaponData[2]
		end
	end
end
function getWeaponDamage (weapon) --FUTR: fix for master
	for i,weapon2 in ipairs(damageTable) do
		local t,weapon1 = getWeaponAmmoType(weapon2[1])
		if weapon1 == weapon then
			return weapon2[2]
		end
	end
end
function getWeaponNoise(weapon)
	for i,weapon2 in ipairs(weaponNoiseTable) do
		if weapon == weapon2[1] then
			return weapon2[2]
		end
	end
	return 0
end

--EVENTS
function playerGetDamageDayZ ( attacker, weapon, bodypart, loss ) --THIS IS A BIG ONE
	cancelEvent()
	damage = 100
	headshot = false
	if weapon == 37 then
		return
	end
	if getElementData(attacker,"zombie") then
		setElementData(localPlayer,"blood",getElementData(localPlayer,"blood")-math.random(100,600))
		local number = math.random(1,7)
		if number == 4 then
			setElementData(localPlayer,"bleeding",getElementData(localPlayer,"bleeding") + math.floor(loss*10))
		end
	end
	if weapon == 49 then
		if loss > 30 then
			setElementData(localPlayer,"brokenbone",true)
			setControlState ("jump",true)
			setElementData(localPlayer,"blood",getElementData(localPlayer,"blood")-math.floor(loss*10))
		end
		setElementData(localPlayer,"blood",getElementData(localPlayer,"blood")-math.floor(loss*5))
	elseif weapon == 63 or weapon == 19 then
		setElementData(localPlayer,"blood",0)
		if not getElementData(localPlayer,"isDead") then
			triggerServerEvent("kilLDayZPlayer",localPlayer,attacker,headshot) --fix this (i dunno what to fix?)
		end
	elseif weapon and weapon > 1 and attacker and getElementType(attacker) == "player" then
		local number = math.random(1,8)
		if number >= 6 and number <= 8 then
			setElementData(localPlayer,"bleeding",getElementData(localPlayer,"bleeding") + math.floor(loss*10))
		end
		local number = math.random(1,7)
		if number == 2 then
			setElementData(localPlayer,"pain",true)
		end
		damage = getWeaponDamage(weapon)
		if bodypart == 9 then
			damage = damage*1.5
			headshot = true
		end
		if bodypart == 7 or bodypart == 8 then
			setElementData(localPlayer,"brokenbone",true)
		end
		setElementData(localPlayer,"blood",getElementData(localPlayer,"blood")-math.random(damage*0.75,damage*1.25))
		setElementData(attacker,"humanity",getElementData(attacker,"humanity")-math.random(40,200))
		if getElementData(attacker,"humanity") < 0 then
			setElementData(attacker,"bandit",true)
		end
	elseif weapon == 54 or weapon == 51 then
			setElementData(localPlayer,"blood",getElementData(localPlayer,"blood")-math.random(100,1000))
			setElementData(localPlayer,"bleeding",getElementData(localPlayer,"bleeding") + math.floor(loss*10))
		local number = math.random(1,5)
		if loss > 30 then
			setElementData(localPlayer,"brokenbone",true)
			setControlState ("jump",true)
		end
		if loss >= 100 then
			setElementData(localPlayer,"blood",getElementData(localPlayer,"blood")-12002)
		end
		local number = math.random(1,11)
		if number == 3 then
			setElementData(localPlayer,"pain",true)
		end
	end
	if getElementData(localPlayer,"blood") <= 0 then
		if not getElementData(localPlayer,"isDead") then
			triggerServerEvent("kilLDayZPlayer",localPlayer,attacker,headshot,getWeaponNameFromID (weapon))
		end
	end
end
addEventHandler ( "onClientPlayerDamage", getLocalPlayer (), playerGetDamageDayZ )
function pedGetDamageDayZ ( attacker, weapon, bodypart, loss )
cancelEvent()
if attacker and attacker == localPlayer then
	damage = 100
	if weapon == 37 then
		return
	end
	if weapon == 63 or weapon == 51 or weapon == 19 then
		setElementData(source,"blood",0)
		if getElementData(source,"blood") <= 0 then
			triggerServerEvent("onZombieGetsKilled",source,attacker)
		end
	elseif weapon and weapon > 1 and attacker and getElementType(attacker) == "player" then
		damage = getWeaponDamage (weapon)
		if bodypart == 9 then
			damage = damage*1.5
			headshot = true
		end
		setElementData(source,"blood",getElementData(source,"blood")-math.random(damage*0.75,damage*1.25))
		if getElementData(source,"blood") <= 0 then
			triggerServerEvent("onZombieGetsKilled",source,attacker,headshot)
		end
	end
end	
end
addEventHandler ( "onClientPedDamage", getRootElement(), pedGetDamageDayZ )

--BINDS
function showDebugMonitor ()
	local visible = guiGetVisible(statsWindows)
	guiSetVisible(statsWindows,not visible)
end
addCommandHandler("debugMon", showDebugMonitor, false) --remove this bind eventually
bindKey("F5", "down", "debugMon", "")
function playerZoom (key)
	if key == "n" then
		if getElementData(localPlayer,"Night Vision Goggles") > 0 then
			if nightvision then
				nightvision = false
				setCameraGoggleEffect("normal")
			else 
				nightvision = true
				setCameraGoggleEffect("nightvision")
			end
		end
	elseif key == "i" then
		if getElementData(localPlayer,"Infrared Goggles") > 0 then
			if infaredvision then
				infaredvision = false
				setCameraGoggleEffect("normal")
			else 
				 infaredvision = true
				setCameraGoggleEffect("thermalvision")
			end
		end
	end
end
addCommandHandler("goggleUse", playerZoom, false)
bindKey("n", "down", "playerZoom", "n")
bindKey("i", "down", "playerZoom", "i")

--TIMERS
function playerStatsCS()
	if getElementData(localPlayer,"auth") then
		toggleControl ("radar",false)
		showPlayerHudComponent ("clock",false) 
		showPlayerHudComponent ("radar",false)
		showPlayerHudComponent ("money",false) 
		showPlayerHudComponent ("health",false) 
		--showPlayerHudComponent ("weapon",false) --ok we'll let them have their weapons
		--showPlayerHudComponent ("ammo",false) --AND AMMO on screen (fucking casuals)
		showPlayerHudComponent ("breath",false) 
		if getElementData(localPlayer,"Map") >= 1  then
			toggleControl ("radar",true)
		end
		if getElementData(localPlayer,"GPS") >= 1  then
			showPlayerHudComponent ("radar",true) 
		end
		if getElementData(localPlayer,"Watch") >= 1 then
			showPlayerHudComponent ("clock",true) 
		end
	end
end
setTimer(playerStatsCS,1000,0) --we do this EVERY SECOND (why)
function zombieSpawning()
	local x, y, z = getElementPosition(localPlayer)
	local material,hitX, hitY, hitZ = isObjectAroundPlayer2 ( localPlayer, 30, 3 )
	if material == 0 and not isInBuilding(x,y,z) then
		triggerServerEvent("createZomieForPlayer",localPlayer,hitX, hitY, hitZ)
	end
end
--setTimer(zombieSpawning,3000,0)
function stopZombieSound()
	local zombies = getElementsByType ( "ped" )
	for theKey,theZomb in ipairs(zombies) do
		setPedVoice(theZomb, "PED_TYPE_DISABLED")
	end
end
setTimer(stopZombieSound,5000,0)
function checkStats()
if getElementData(localPlayer,"auth") then
	local bleed = getElementData(localPlayer,"bleeding")
	local blood = getElementData(localPlayer,"blood")
	if bleed > 20 then
		setElementData(localPlayer,"blood",blood-bleed)
	else
		setElementData(localPlayer,"bleeding",0)
	end
	if blood <= 0 then
		if not getElementData(localPlayer,"isDead") then
			triggerServerEvent("kilLDayZPlayer",localPlayer,false,false)
		end
	end
end	
end
setTimer(checkStats,3000,0)
function createBloodForBleedingPlayers() --this is obv stolen code who marwin stole it from i dunno
if getElementData(localPlayer,"auth") then
local x,y,z = getElementPosition(localPlayer)
	for i,player in ipairs(getElementsByType("player")) do
		local bleeding = getElementData(player,"bleeding")
		if bleeding > 0 then
			local px,py,pz = getPedBonePosition (player,3)
			local pdistance = getDistanceBetweenPoints3D ( x,y,z,px,py,pz )
			if bleeding > 600 then
				number = 5
			elseif bleeding > 300 then
				number = 3
			elseif bleeding > 100 then
				number = 1
			else
				number = 0
			end
			if pdistance <= 120 then
				fxAddBlood ( px,py,pz,0,0,0,number, 1 )
			end
		end	
	end
end	
end
setTimer(createBloodForBleedingPlayers,300,0)
function checkBrokenbone()
if getElementData(localPlayer,"auth") then
	if getElementData(localPlayer,"brokenbone") then
		if not isPedDucked(localPlayer) then
			--setControlState ("walk",false) --oh god forced crouch for broken bones
			--setControlState ("crouch",true) --please never enable this
		end
		toggleControl ( "jump", false )
		toggleControl ( "sprint", false )
	else
		toggleControl ( "jump", true )
		toggleControl ( "sprint", true )
	end
end	
end
setTimer(checkBrokenbone,1500,0)
function setPain() --camera effect
if getElementData(localPlayer,"auth") then
	if getElementData(localPlayer,"pain") then --this is horrible fix this so its not so GAY
		local x,y,z = getElementPosition(localPlayer)
		createExplosion (x,y,z+15,8,false,1.0,false)
		local x, y, z, lx, ly, lz = getCameraMatrix() -- Get the current location and lookat of camera
		x, lx = x + 1, lx + 1 -- What will be the new x and x lookat values
		setCameraMatrix(x,y,z,lx,ly,lz) -- Set camera to new position
		setCameraTarget (localPlayer)
	end
end	
end
setTimer(setPain,1500,0)
function checkCold()
if getElementData(localPlayer,"auth") then
	if getElementData(localPlayer,"temperature") <= 31 then
		setElementData(localPlayer,"cold",true)
	end
end	
end
setTimer(checkCold,3000,0)
function setCold() --camera effect
	if getElementData(localPlayer,"auth") then --again deGAY this shit
		if getElementData(localPlayer,"cold") then
			local x,y,z = getElementPosition(localPlayer)
			createExplosion (x,y,z+15,8,false,0.5,false)
			local x, y, z, lx, ly, lz = getCameraMatrix() -- Get the current location and lookat of camera
		end	
	end	
end
setTimer(setCold,1500,0)
function setVolume() --PLEASE FIX
	value = 0
	if getPedMoveState (localPlayer) == "stand" then
		value = 0
	elseif getPedMoveState (localPlayer) == "walk" then
		value = 40
	elseif getPedMoveState (localPlayer) == "powerwalk" then
		value = 20
	elseif getPedMoveState (localPlayer) == "jog" then
		value = 80
	elseif getPedMoveState (localPlayer) == "sprint" then	
		value = 100
	elseif getPedMoveState (localPlayer) == "crouch" then	
		value = 0
	elseif not getPedMoveState (localPlayer) then
		value = 20
	end
	if getElementData(localPlayer,"shooting") and getElementData(localPlayer,"shooting") > 0 then
		value = value+getElementData(localPlayer,"shooting")
	end
	if isPedInVehicle (localPlayer) then
		value = 100
	end	
	if value > 100 then
		value = 100
	end
	setElementData(localPlayer,"volume",value) --setElementData IS SYNCED FUCKING FUCK DO NOT DO THIS EVERY 100ms
end
setTimer(setVolume,100,0)
function setVisibility() --PLEASE FIX
	value = 0
	if getPedMoveState (localPlayer) == "stand" then
		value = 60
	elseif getPedMoveState (localPlayer) == "walk" then
		value = 80
	elseif getPedMoveState (localPlayer) == "powerwalk" then
		value = 20
	elseif getPedMoveState (localPlayer) == "jog" then
		value = 80
	elseif getPedMoveState (localPlayer) == "sprint" then	
		value = 80
	elseif getPedMoveState (localPlayer) == "crouch" then	
		value = 20
	elseif not getPedMoveState (localPlayer) then	
		value = 40
	end
	if getElementData(localPlayer,"jumping") then
		value = 100
	end
	if isObjectAroundPlayer (localPlayer,2, 4 ) then
		value = 0
	end
	if isPedInVehicle (localPlayer) then
		value = 100
	end	
	setElementData(localPlayer,"visibly",value) --setElementData IS SYNCED FUCKING FUCK DO NOT DO THIS EVERY 100ms
end
setTimer(setVisibility,100,0) 
function debugJump2() --why2
	setElementData(localPlayer,"jumping",false)
end
function debugJump() --why
	if getControlState("jump") then
		setElementData(localPlayer,"jumping",true)
		setTimer(debugJump2,650,1)
	end
end
setTimer(debugJump,100,0)
function debugShooting2() --more why2
	setElementData(localPlayer,"shooting",0)
	shootTimer = false
end
function debugShooting() --more why
if getControlState("fire") then
	local weapon = getPedWeapon(localPlayer)
	local noise = getWeaponNoise(weapon) or 0
	setElementData(localPlayer,"shooting",noise)
	if shootTimer then
		killTimer(shootTimer)
	end
	shootTimer = setTimer(debugShooting2,100,1)
end
end
setTimer(debugShooting,100,0)
function checkZombies()
zombiesalive = 0
zombiestotal = 0
for i,ped in ipairs(getElementsByType("ped")) do
	if getElementData(ped,"zombie") then
		zombiesalive = zombiesalive + 1
	end
	if getElementData(ped,"deadzombie") then
		zombiestotal = zombiestotal + 1
	end
end
setElementData(getRootElement(),"zombiesalive",zombiesalive)
setElementData(getRootElement(),"zombiestotal",zombiestotal+zombiesalive)
end
setTimer(checkZombies,5000,0)
function checkZombies3()
local x,y,z = getElementPosition(localPlayer)
for i,ped in ipairs(getElementsByType("ped")) do
	if getElementData(ped,"zombie") then
		local sound = getElementData(localPlayer,"volume")/5
		local visibly = getElementData(localPlayer,"visibly")/5
		local xZ,yZ,zZ = getElementPosition(ped)
		if getDistanceBetweenPoints3D (x,y,z,xZ,yZ,zZ) < sound+visibly then
			if getElementData ( ped, "leader" ) == nil then
				triggerServerEvent("botAttack",localPlayer,ped)
			end
		else
			if getElementData ( ped, "target" ) == localPlayer then
				setElementData(ped,"target",nil)
			end
			if getElementData ( ped, "leader" ) == localPlayer then
				triggerServerEvent("botStopFollow",localPlayer,ped)
			end
		end
	end
end
end
setTimer(checkZombies3,500,0)


	
--------------------------------------------------------
--GUI + STATS			TODO: offload gui elements to gui.lua --
--------------------------------------------------------



--keep on moooovin



--[[ why this is commented out ill never know; maybe i should FIGURE IT OUT
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
end		
setTimer(destroyBlipGPS,5000,0)

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
end		
setTimer(showBlipGPS,500,0)
--addEventHandler ( "onClientHUDRender", getRootElement(), showBlipGPS )
]]

--[[Support Chat (no support for now)
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
--]]

--[[
--------------------------------------------------------------------
--Create the AntiSpam Support Chat
--------------------------------------------------------------------
]]

--[[
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

--[[
--------------------------------------------------------------------
--Create Scoreboard
--------------------------------------------------------------------
]]

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

playerRankingTable = {}

function checkTopPlayer()
playerRankingTable = positionGetElementData("alivetime", #getElementsByType("player"))
end
checkTopPlayer()
setTimer(checkTopPlayer,10000,0)

function onQuitGame( reason )
    checkTopPlayer()
end
addEventHandler( "onClientPlayerQuit", getRootElement(), onQuitGame )

yA = 0
local screenWidth,screenHeight = guiGetScreenSize()
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
	--dxDrawText ("☻◘☺", screenWidth*0.3+w1*1.6+w2*1.1-(screenWidth*0.0025/2)-w2/2,  screenHeight*0.2+offset*2+yA, screenWidth*0.3+w1*1.6+w2*1.1-(screenWidth*0.0025/2)-w2/2,  screenHeight*0.2+offset*2+yA, tocolor ( r1,g1,b1, 200 ), 1.5, "default-bold" )
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




--Vehicles In Water (i dunno)
function checkVehicleInWaterClient ()
vehiclesInWater = {}
	for i,veh in ipairs(getElementsByType("vehicle")) do
		if isElementInWater(veh) then
				table.insert(vehiclesInWater,veh)
		end
	end
	triggerServerEvent("respawnVehiclesInWater",localPlayer,vehiclesInWater)
end
addEvent("checkVehicleInWaterClient",true)
addEventHandler("checkVehicleInWaterClient",getRootElement(),checkVehicleInWaterClient)


function updatePlayTime()
	if getElementData(localPlayer,"auth") then
		local playtime = getElementData(localPlayer,"alivetime")
		setElementData(localPlayer,"alivetime",playtime+1)	
	end	
end
setTimer(updatePlayTime, 60000, 0)

bindKey("z", "down", "chatbox", "radiochat" ) --TODO: handle radio chat on server


local pingFails = 0
function playerPingCheck ()
	if getPlayerPing(localPlayer) > 600 then
		pingFails = pingFails +1
		if pingFails == 5 then
			triggerServerEvent("kickPlayerOnHighPing",localPlayer)
			return
		end
			displayClientInfo("Ping", "Your Ping is over 600! ("..pingFails.."/3)", 255, 22, 0 )
		if isTimer(pingTimer) then return end
		pingTimer = setTimer(function()
			pingFails = 0
		end,30000,1)
	end
end	
setTimer(playerPingCheck,4000,0)

--debug stuff
setDevelopmentMode(true) --eventually remove me

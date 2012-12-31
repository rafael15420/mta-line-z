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
----*			 client.lua - logic and etc					*----
----* HACKED												*----
----* BY													*----
----* CHINESE		--TODO: keep at it				 		*----
----*														*----
#---------------------------------------------------------------#
]]

--VARIABLES
local invMaster = {}
function cInvMasterRecvHandler(invTab)
	invMaster = invTab
	local num = math.random(101,109)
	outputDebugString("invmaster recieved: '"..tostring(invMaster[num][1]).."' does "..tostring(invMaster[num][3]).." damage and weighs "..tostring(invMaster[num][2]).."kg")
end
addEvent("cInvMasterRecv",true)
addEventHandler("cInvMasterRecv",localPlayer,cInvMasterRecvHandler,false)


local weaponAmmoTable = { --going into master
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
local damageTable = { --to: master
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
local weaponNoiseTable = { --god everything is everywhere (re)MOVE ME
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
local pingFails = 0


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


--HOOKS
function playerGetDamageDayZ ( attacker, weapon, bodypart, loss ) --THIS IS A BIG ONE
	cancelEvent()
	local damage,headshot = 100,false
	local bloodloss,bleedvalue = getElementData(localPlayer,"blood"),
								 getElementData(localPlayer,"bleeding")
	if weapon == 37 then --fire
		return
	end
	if attacker and getElementData(attacker,"zombie") then --zombies
			bloodloss = bloodloss - math.random(100,600)
			local number = math.random(1,7)
			if number == 4 then
				bleedvalue = bleedvalue + math.floor(loss*10)
			end
		end
	if weapon == 49 then --cars
		if loss > 30 then
			setElementData(localPlayer,"brokenbone",true)
			setControlState ("jump",true)
			bloodloss = bloodloss-math.floor(loss*10)
		end
		bloodloss = bloodloss-math.floor(loss*5)
	elseif weapon == 63 or weapon == 19 then --inside a car explosion / rocket direct hit
		bloodloss = bloodloss - 12002		
	elseif weapon and weapon > 1 and attacker and getElementType(attacker) == "player" then --players
		local number = math.random(1,8)
		if number >= 6 and number <= 8 then
			bleedvalue = bleedvalue + math.floor(loss*10)
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
		bloodloss = bloodloss - math.random(damage*0.75,damage*1.25)
		local humanityValue = getElementData(attacker,"humanity") - math.random(40,200)
		if humanityValue < 0 then
			setElementData(attacker,"bandit",true)
		end
		setElementData(attacker,"humanity",humanityValue)
	elseif weapon == 54 or weapon == 51 then --falls and explosions
		bloodloss = bloodloss-math.random(100,1000)
		if weapon == 51 then bleedvalue = bleedvalue + math.floor(loss*10) end 
		if loss > 30 then
			setElementData(localPlayer,"brokenbone",true)
			setControlState ("jump",true)
			bleedvalue = bleedvalue + math.floor(loss*10)
		end
		if loss >= 100 then
			bloodloss = bloodloss-12002
		end
		local number = math.random(1,11)
		if number == 3 then
			setElementData(localPlayer,"pain",true)
		end
	end
	
	--SYNC UP
	setElementData(localPlayer,"blood",bloodloss)
	setElementData(localPlayer,"bleeding",bleedvalue)
		
	if bloodloss <= 0 then --DIE
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
 --goggles
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
 --radio
bindKey("z", "down", "chatbox", "radiochat" ) --TODO: handle radio chat on server


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

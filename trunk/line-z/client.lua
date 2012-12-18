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
----* CHINESE				--TODO: redo everything 		*----
----*														*----
#---------------------------------------------------------------#
]]



--Survivor Skins
--Sniper
snipertxd = engineLoadTXD ("client/player/sniper.txd");
engineImportTXD (snipertxd, 285);
sniperdff = engineLoadDFF ("client/player/sniper.dff", 285);
engineReplaceModel (sniperdff, 285);
--Civilian
snipertxd = engineLoadTXD ("client/player/civilian.txd");
engineImportTXD (snipertxd, 179);
sniperdff = engineLoadDFF ("client/player/civilian.dff", 179);
engineReplaceModel (sniperdff, 179);
--Bandit1
snipertxd = engineLoadTXD ("client/player/bandit3.txd");
engineImportTXD (snipertxd, 180);
sniperdff = engineLoadDFF ("client/player/bandit3.dff", 180);
engineReplaceModel (sniperdff, 180);
--Bandit2
snipertxd = engineLoadTXD ("client/player/bandit2.txd");
engineImportTXD (snipertxd, 288);
sniperdff = engineLoadDFF ("client/player/bandit2.dff", 288);
engineReplaceModel (sniperdff, 288);
--[[Standart
snipertxd = engineLoadTXD ("client/player/standart.txd");
engineImportTXD (snipertxd, 73);
sniperdff = engineLoadDFF ("client/player/standart.dff", 73);
engineReplaceModel (sniperdff, 73);
]]--

--Items

itemTXD = engineLoadTXD ("client/item/army_clothes.txd");
engineImportTXD (itemTXD, 1247);
itemDFF = engineLoadDFF ("client/item/army_clothes.dff", 1247);
engineReplaceModel (itemDFF, 1247);

itemTXD = engineLoadTXD ("client/item/sniper_clothes.txd");
engineImportTXD (itemTXD, 1213);
itemDFF = engineLoadDFF ("client/item/sniper_clothes.dff", 1213);
engineReplaceModel (itemDFF, 1213);

itemTXD = engineLoadTXD ("client/item/civilian_clothes.txd");
engineImportTXD (itemTXD, 1241);
itemDFF = engineLoadDFF ("client/item/civilian_clothes.dff", 1241);
engineReplaceModel (itemDFF, 1241);

itemTXD = engineLoadTXD ("client/item/standard_clothes.txd");
engineImportTXD (itemTXD, 1577);
itemDFF = engineLoadDFF ("client/item/standard_clothes.dff", 1577);
engineReplaceModel (itemDFF, 1577);

itemTXD = engineLoadTXD ("client/item/beans_can.txd");
engineImportTXD (itemTXD, 2601);
itemDFF = engineLoadDFF ("client/item/beans_can.dff", 2601);
engineReplaceModel (itemDFF, 2601);

itemTXD = engineLoadTXD ("client/item/first_aid_kit.txd");
engineImportTXD (itemTXD, 2891);
itemDFF = engineLoadDFF ("client/item/first_aid_kit.dff", 2891);
engineReplaceModel (itemDFF, 2891);

itemTXD = engineLoadTXD ("client/item/heat_pack.txd");
engineImportTXD (itemTXD, 1576);
itemDFF = engineLoadDFF ("client/item/heat_pack.dff", 1576);
engineReplaceModel (itemDFF, 1576);

itemTXD = engineLoadTXD ("client/item/pain_killers.txd");
engineImportTXD (itemTXD, 2709);
itemDFF = engineLoadDFF ("client/item/pain_killers.dff", 2709);
engineReplaceModel (itemDFF, 2709);

itemTXD = engineLoadTXD ("client/item/pasta_can.txd");
engineImportTXD (itemTXD, 2770);
itemDFF = engineLoadDFF ("client/item/pasta_can.dff", 2770);
engineReplaceModel (itemDFF, 2770);

itemTXD = engineLoadTXD ("client/item/pistol_ammo.txd");
engineImportTXD (itemTXD, 3013);
itemDFF = engineLoadDFF ("client/item/pistol_ammo.dff", 3013);
engineReplaceModel (itemDFF, 3013);

itemTXD = engineLoadTXD ("client/item/shotgun_ammo.txd");
engineImportTXD (itemTXD, 2358);
itemDFF = engineLoadDFF ("client/item/shotgun_ammo.dff", 2358);
engineReplaceModel (itemDFF, 2358);

itemTXD = engineLoadTXD ("client/item/backpack_small.txd");
engineImportTXD (itemTXD, 3026);
itemDFF = engineLoadDFF ("client/item/backpack_small.dff", 3026);
engineReplaceModel (itemDFF, 3026);

itemTXD = engineLoadTXD ("client/item/smg_ammo.txd");
engineImportTXD (itemTXD, 2041);
itemDFF = engineLoadDFF ("client/item/smg_ammo.dff", 2041);
engineReplaceModel (itemDFF, 2041);

itemTXD = engineLoadTXD ("client/item/sniper_ammo.txd");
engineImportTXD (itemTXD, 2358);
itemDFF = engineLoadDFF ("client/item/sniper_ammo.dff", 2358);
engineReplaceModel (itemDFF, 2358);

itemTXD = engineLoadTXD ("client/item/soda_can.txd");
engineImportTXD (itemTXD, 2647);
itemDFF = engineLoadDFF ("client/item/soda_can.dff", 2647);
engineReplaceModel (itemDFF, 2647);

itemTXD = engineLoadTXD ("client/item/water_bottle.txd");
engineImportTXD (itemTXD, 2683);
itemDFF = engineLoadDFF ("client/item/water_bottle.dff", 2683);
engineReplaceModel (itemDFF, 2683);

itemTXD = engineLoadTXD ("client/item/assault_ammo.txd");
engineImportTXD (itemTXD, 1271);
itemDFF = engineLoadDFF ("client/item/assault_ammo.dff", 1271);
engineReplaceModel (itemDFF, 1271);

itemTXD = engineLoadTXD ("client/item/backpack_alice.txd");
engineImportTXD (itemTXD, 1248);
itemDFF = engineLoadDFF ("client/item/backpack_alice.dff", 1248);
engineReplaceModel (itemDFF, 1248);

itemTXD = engineLoadTXD ("client/item/backpack_coyote.txd");
engineImportTXD (itemTXD, 1252);
itemDFF = engineLoadDFF ("client/item/backpack_coyote.dff", 1252);
engineReplaceModel (itemDFF, 1252);

itemTXD = engineLoadTXD ("client/item/tent.txd");
engineImportTXD (itemTXD, 3243);
itemDFF = engineLoadDFF ("client/item/tent.dff", 3243);
engineReplaceModel (itemDFF, 3243);

itemTXD = engineLoadTXD ("client/item/wirefence.txd");
engineImportTXD (itemTXD, 983);
itemDFF = engineLoadDFF ("client/item/wirefence.dff", 983);
engineReplaceModel (itemDFF, 983);

function playerStatsCS()
	if getElementData(localPlayer,"auth") then
		toggleControl ("radar",false)
		showPlayerHudComponent ("clock",false) 
		showPlayerHudComponent ("radar",false)
		showPlayerHudComponent ("money",false) 
		showPlayerHudComponent ("health",false) 
		--showPlayerHudComponent ("weapon",false) 
		--showPlayerHudComponent ("ammo",false) 
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
setTimer(playerStatsCS,1000,0)

function playerZoom (key,keyState)
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
addEvent("onPlayerGoggleUse",false)
addEventHandler("onPlayerGoggleUse",localPlayer,playerZoom)
bindKey("n","down",playerZoom)
bindKey("i","down",playerZoom)


--------------------------------------------------------
--Player Stats										  --
--------------------------------------------------------
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


function zombieSpawning()
 local x, y, z = getElementPosition(localPlayer)
local material,hitX, hitY, hitZ = isObjectAroundPlayer2 ( localPlayer, 30, 3 )
if material == 0 and not isInBuilding(x,y,z) then
	triggerServerEvent("createZomieForPlayer",localPlayer,hitX, hitY, hitZ)
end
end
--setTimer(zombieSpawning,3000,0)

--ALL ZOMBIES STFU
function stopZombieSound()
local zombies = getElementsByType ( "ped" )
for theKey,theZomb in ipairs(zombies) do
	setPedVoice(theZomb, "PED_TYPE_DISABLED")
end
end
setTimer(stopZombieSound,5000,0)

--SKIN REPLACEMENTS
	local skin = engineLoadTXD ( "client/ped/22.txd" ) -- slashed 12 by Wall-E
	engineImportTXD ( skin, 22 )	
	local skin = engineLoadTXD ( "client/ped/56.txd" ) --young and blue by Slothman
	engineImportTXD ( skin, 56 )
	local skin = engineLoadTXD ( "client/ped/67.txd" ) -- slit r* employee
	engineImportTXD ( skin, 67 )
	local skin = engineLoadTXD ( "client/ped/68.txd" ) -- shredded preist by Deixell
	engineImportTXD ( skin, 68 )
	local skin = engineLoadTXD ( "client/ped/69.txd" ) --bleedin eyes in denim by Capitanazop
	engineImportTXD ( skin, 69 )
	local skin = engineLoadTXD ( "client/ped/70.txd" ) --ultra gory scientist by 50p
	engineImportTXD ( skin, 70 )
	local skin = engineLoadTXD ( "client/ped/84.txd" ) --guitar wolf (nonzombie) by Slothman
	engineImportTXD ( skin, 84 )
	local skin = engineLoadTXD ( "client/ped/92.txd" ) -- peeled flesh by xbost
	engineImportTXD ( skin, 92 )
	local skin = engineLoadTXD ( "client/ped/97.txd" ) -- easterboy by Slothman
	engineImportTXD ( skin, 97 )
	local skin = engineLoadTXD ( "client/ped/105.txd" ) --Scarred Grove Gangster by Wall-E
	engineImportTXD ( skin, 105 )
	local skin = engineLoadTXD ( "client/ped/107.txd" ) --ripped and slashed grove by Wall-E
	engineImportTXD ( skin, 107 )
	local skin = engineLoadTXD ( "client/ped/108.txd" ) -- skeleton thug by Deixell
	engineImportTXD ( skin, 108 )
	local skin = engineLoadTXD ( "client/ped/111.txd" ) --Frank West from dead rising (nonzombie) by Slothman
	engineImportTXD ( skin, 111 )
	local skin = engineLoadTXD ( "client/ped/126.txd" ) -- bullet ridden wiseguy by Slothman
	engineImportTXD ( skin, 126 )
	local skin = engineLoadTXD ( "client/ped/127.txd" ) --flyboy from dawn of the dead by Slothman
	engineImportTXD ( skin, 127 )
	local skin = engineLoadTXD ( "client/ped/128.txd" ) --holy native by Slothman
	engineImportTXD ( skin, 128 )
	local skin = engineLoadTXD ( "client/ped/152.txd" ) --bitten schoolgirl by Slothman
	engineImportTXD ( skin, 152 )
	local skin = engineLoadTXD ( "client/ped/162.txd" ) --shirtless redneck by Slothman
	engineImportTXD ( skin, 162 )
	local skin = engineLoadTXD ( "client/ped/167.txd" ) --dead chickenman by 50p
	engineImportTXD ( skin, 167 )
	local skin = engineLoadTXD ( "client/ped/188.txd" ) --burnt greenshirt by Slothman
	engineImportTXD ( skin, 188 )
	local skin = engineLoadTXD ( "client/ped/192.txd" ) --Alice from resident evil (nonzombie) by Slothman
	engineImportTXD ( skin, 192 )
	local skin = engineLoadTXD ( "client/ped/195.txd" ) --bloody ex by Slothman
	engineImportTXD ( skin, 195 )
	local skin = engineLoadTXD ( "client/ped/206.txd" ) -- faceless zombie by Slothman
	engineImportTXD ( skin, 206 )
	local skin = engineLoadTXD ( "client/ped/209.txd" ) --Noodle vendor by 50p
	engineImportTXD ( skin, 209 )
	local skin = engineLoadTXD ( "client/ped/212.txd" ) --brainy hobo by Slothman
	engineImportTXD ( skin, 212 )
	local skin = engineLoadTXD ( "client/ped/229.txd" ) --infected tourist by Slothman
	engineImportTXD ( skin, 229 )
	local skin = engineLoadTXD ( "client/ped/230.txd" ) --will work for brains hobo by Slothman
	engineImportTXD ( skin, 230 )
	local skin = engineLoadTXD ( "client/ped/258.txd" ) --bloody sided suburbanite by Slothman
	engineImportTXD ( skin, 258 )
	local skin = engineLoadTXD ( "client/ped/264.txd" ) --scary clown by 50p
	engineImportTXD ( skin, 264 )
	local skin = engineLoadTXD ( "client/ped/274.txd" ) --Ash Williams (nonzombie) by Slothman
	engineImportTXD ( skin, 274 )
	local skin = engineLoadTXD ( "client/ped/277.txd" ) -- gutted firefighter by Wall-E
	engineImportTXD ( skin, 277 )
	local skin = engineLoadTXD ( "client/ped/280.txd" ) --infected cop by Lordy
	engineImportTXD ( skin, 280 )

--play zombie sounds
--local Zx,Zy,Zz = getElementPosition( ped )
--local sound = playSound3D("sounds/mgroan"..randnum..".ogg", Zx, Zy, Zz, false)
--setSoundMaxDistance(sound, 20)
	
--------------------------------------------------------
--GUI + STATS			TODO: offload gui elements to gui.lua --
--------------------------------------------------------

function math.round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
    else return tonumber(("%."..decimals.."f"):format(number)) end
end

statsLabel = {}

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

function showDebugMonitor ()
	local visible = guiGetVisible(statsWindows)
	guiSetVisible(statsWindows,not visible)
end
addCommandHandler("debugMon", showDebugMonitor, false)
bindKey("F5", "down", "debugMon", "")

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

weaponAmmoTable = { --concat this maybe
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

function getWeaponAmmoType (weaponName) --rewrite this, eventually
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

damageTable = {
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

function getWeaponDamage (weapon)
	for i,weapon2 in ipairs(damageTable) do
		local t,weapon1 = getWeaponAmmoType(weapon2[1])
		if weapon1 == weapon then
			return weapon2[2]
		end
	end
end

--
function playerGetDamageDayZ ( attacker, weapon, bodypart, loss )
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
			triggerServerEvent("kilLDayZPlayer",localPlayer,attacker,headshot) --fix this
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

function createBloodForBleedingPlayers ()
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
			--setControlState ("walk",false)
			--setControlState ("crouch",true)
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

function setPain()
if getElementData(localPlayer,"auth") then
	if getElementData(localPlayer,"pain") then
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

function setCold()
	if getElementData(localPlayer,"auth") then
		if getElementData(localPlayer,"cold") then
			local x,y,z = getElementPosition(localPlayer)
			createExplosion (x,y,z+15,8,false,0.5,false)
			local x, y, z, lx, ly, lz = getCameraMatrix() -- Get the current location and lookat of camera
		end	
	end	
end
setTimer(setCold,1500,0)

function setVolume()
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
	setElementData(localPlayer,"volume",value)
end
setTimer(setVolume,100,0)

function setVisibility()
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
	setElementData(localPlayer,"visibly",value)
end
setTimer(setVisibility,100,0)

function debugJump()
	if getControlState("jump") then
		setElementData(localPlayer,"jumping",true)
		setTimer(debugJump2,650,1)
	end
end
setTimer(debugJump,100,0)

function debugJump2()
	setElementData(localPlayer,"jumping",false)
end

weaponNoiseTable = {
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
--0 none
--20 low
--40 moderate
--60 high

function getWeaponNoise(weapon)
	for i,weapon2 in ipairs(weaponNoiseTable) do
		if weapon == weapon2[1] then
			return weapon2[2]
		end
	end
	return 0
end

function debugShooting()
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

function debugShooting2()
	setElementData(localPlayer,"shooting",0)
	shootTimer = false
end

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

fading = 0
fading2 = "up"
local screenWidth,screenHeight = guiGetScreenSize()
function updateIcons ()
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

--OnClientPlayerHit
whiteWindow = guiCreateStaticImage(0,0,1,1,"client/image/white.png",true)
guiSetVisible(whiteWindow,false)

function showPlayerDamageScreen (visibly2,stateControle2)
	guiSetVisible(whiteWindow,true)
	visibly = visibly2 or visibly
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

--[[
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

--[[Support Chat
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
function scoreBoard ()
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




--Vehicles In Water
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

bindKey("z", "down", "chatbox", "radiochat" )


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
setDevelopmentMode(true)

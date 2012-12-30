--[[

GTA-DAYz / WASTELAND MOD
COPYRIGHT DRLINE 2012 DO NOT STEAL LOL

uses these fine resources: 
	marwin survivor system gui
	bone_attach resource
	glue resource
	zday resource (maybe)
	betterWeather resource

TODO: 	finish item funcs (0%; still needs to be done [STEALSTEALSTEAL])
		finish loot funcs (working on it)
		write item spawning code (pull spawns from map data [generic spawns? or specific] [also:STEALSTEALSTEAL])
		backpacks (more STEALING [laziness])
			bone-attach (just have to integrate)
		zombies (lol @ this being the last thing)
]]--

--VARIABLES YO
					-- 1,   2,   3,     4,  5,    6
local invMaster = { --id,init,name,weight,dmg,gtaID 
	--THE PLAN: both client and server have a master inventory list of all values for inventory items.
	--that way simple standardized calls to this list can be made. item 37 will always be item 37 etc.
	--NAMES AND VALUES WILL BE ABLE TO BE CHANGED WITHOUT FUCKING EVERYTHING UP. THIS IS GOOD. 
	--hell i may just make the client download the table at join (THAT WAY THERES ONLY 1 COPY. NO DESYNCS)
	--i may even nest / alter the list protocol a bit. right now its managable(ish)
	--THIS IS ALL WAITING ON CLIENT.LUA STANDARDIZATION / UPDATE  G E T  T O  W O R K
	--prim weps
	{1,0,"M4",3,6722,31}, 
	{2,0,"Sniper Rifle",3,7522,34},
	{3,0,"Shotgun",3,2024,25},
	{4,0,"SPAZ-12 Combat Shotgun",3,4582,27},
	{5,0,"Sawn-Off Shotgun",3,2894,26},
	{6,0,"AK-47",3,3555,30},
	{7,0,"Heat-Seeking RPG",5,37552,36},
	{8,0,"Rocket Launcher",5,37552,35},
	{9,0,"Country Rifle",3,6722,33},
	--sec weps	
	{10,0,"Pistol",2,889,22},
	{11,0,"Silenced Pistol",2,889,23},
	{12,0,"Uzi",2,889,28},
	{13,0,"TEC-9",2,889,32},
	{14,0,"MP5",3,1196,29},
	{15,0,"Desert Eagle",2,2489,24},
	{16,0,"Knife",1,1500,4},
	{17,0,"Katana",2,2100,8},
	--spec	
	{18,0,"Parachute",1,0,46},
	{19,0,"Tear Gas",1,0,17},
	{20,0,"Grenade",1,18000,16},	
	--ammo
	{21,0,"Rocket Ammo",2},
	{22,0,"Sniper Ammo",0.1},
	{23,0,"Smg Ammo",0.025},
	{24,0,"Assault Ammo",0.035},
	{25,0,"Pistol Ammo",0.085},
	{26,0,"Shotgun Ammo",0.067},
	--food
	{27,0,"Water Bottle",1,50},
	{28,0,"Pasta Can",1,200},
	{29,0,"Beans Can",1,200},
	{30,1,"Burger",1,300},
	{31,0,"Pizza",1,500},
	{32,0,"Soda Bottle",1,100},
	{33,0,"Milk",1,250},
	{34,0,"Cooked Meat",1,800},
	--misc
	{35,0,"Wood",2},
	{36,2,"Bandage",1},
	{37,0,"Roadflare",1},
	{38,0,"Empty Patrol Canister",2},
	{39,0,"Full Patrol Canister",2},
	{40,0,"Medic Kit",2},
	{41,0,"Heat Pack",1},
	{42,1,"Painkiller",1},
	{43,0,"Morphine",1},
	{44,0,"Blood Bag",1},
	{45,0,"Wire Fence",1},
	{46,0,"Raw Meat",1},
	{47,0,"Tire",2},
	{48,0,"Engine",5},
	{49,0,"Tent",3},
	{50,0,"Army Skin",1},
	{51,0,"Civilian Skin",1},
	{52,0,"Standart Skin",1},
	{53,0,"Sniper Skin",1},
	{54,0,"Empty Bottle",1},
	{55,0,"Tin Can",1},
	{56,0,"Scruffy Burgers",1},
	{57,0,"Alice Backpack",1},
	{58,0,"Small Backpack",1},
	{59,0,"Coyote Backpack",1},
	--tools
	{60,0,"Night Vision Goggles",1},
	{61,0,"Infrared Goggles",1},
	{62,0,"Map",1},
	{63,0,"Lighter",1},
	{64,0,"Watch",1},
	{65,0,"GPS",1},
	{66,0,"Toolbox",1},
	{67,0,"Binocular",1},
	{68,0,"Radio Device",1},
}
local initInvTab = { --THIS IS GONNA GO (already in master)
	["M4"] = 0,
	["Sniper Rifle"] = 0,
	["Shotgun"] = 0,
	["SPAZ-12 Combat Shotgun"] = 0,
	["Sawn-Off Shotgun"] = 0,
	["AK-47"] = 0,
	["Heat-Seeking RPG"] = 0,
	["Rocket Launcher"] = 0,
	["Country Rifle"] = 0,
	["Pistol"] = 0,
	["Silenced Pistol"] = 0,
	["Uzi"] = 0,
	["TEC-9"] = 0,
	["MP5"] = 0,
	["Desert Eagle"] = 0,
	["Knife"] = 0,
	["Katana"] = 0,
	["Parachute"] = 0,
	["Tear Gas"] = 0,
	["Grenade"] = 0,
	["Rocket Ammo"] = 0,
	["Sniper Ammo"] = 0,
	["Smg Ammo"] = 0,
	["Assault Ammo"] = 0,
	["Pistol Ammo"] = 0,
	["Shotgun Ammo"] = 0,
	["Water Bottle"] = 1,
	["Pasta Can"] = 0,
	["Beans Can"] = 0,
	["Burger"] = 0,
	["Pizza"] = 3,
	["Soda Bottle"] = 0,
	["Milk"] = 0,
	["Cooked Meat"] = 0,
	["Wood"] = 1,
	["Bandage"] = 0,
	["Roadflare"] = 5,
	["Empty Patrol Canister"] = 0,
	["Full Patrol Canister"] = 1,
	["Medic Kit"] = 0,
	["Heat Pack"] = 0,
	["Painkiller"] = 0,
	["Morphine"] = 0,
	["Blood Bag"] = 0,
	["Wire Fence"] = 0,
	["Raw Meat"] = 0,
	["Tire"] = 0,
	["Engine"] = 0,
	["Tent"] = 0,
	["Army Skin"] = 0,
	["Civilian Skin"] = 1,
	["Standart Skin"] = 0,
	["Sniper Skin"] = 0,
	["Empty Bottle"] = 0,
	["Tin Can"] = 0,
	["Scruffy Burgers"] = 0,
	["Alice Backpack"] = 0,
	["Small Backpack"] = 0,
	["Coyote Backpack"] = 0,
	["Night Vision Goggles"] = 1,
	["Infrared Goggles"] = 0,
	["Map"] = 1,
	["Lighter"] = 1,
	["Watch"] = 1,
	["GPS"] = 1,
	["Toolbox"] = 0,
	["Binocular"] = 1,
	["Radio Device"] = 1,
}
local initPlrTab = { --extra settings for players --going into master
	["volume"] = 0,
	["visibly"] = 0,
	["brokenbone"] = false,
	["humanity"] = 2500,
	["temperature"] = 37.7,
	["thirst"] = 100,
	["blood"] = 12000,
	["food"] = 100,
	["bleeding"] = 0,
	["zombieskilled"] = 0,
	["headshots"] = 0,
	["murders"] = 0,
	["banditskilled"] = 0,
	["zombies"] = 0,
	["MAX_Slots"] = 10,
	["alivetime"] = 0,
	["loot"] = false,
	["isDead"] = false,
	["pain"] = false
}
local skinTable = { --skinTable[itemName][#] = { skinID, banditskinID } --going into master
	["Army Skin"] = {287,288},
	["Civilian Skin"] = {179,180},
	["Standart Skin"] = {73,288},
	["Sniper Skin"] = {285,285}
}
local weaponAmmoTable = { --this will go into master aswell
	["Pistol Ammo"] = {
		{"Pistol", 22}, 
		{"Silenced Pistol", 23}, 
		{"Desert Eagle", 24}
	}, 
	["Smg Ammo"] = {
		{"Uzi", 28}, 
		{"TEC-9", 32}, 
		{"MP5", 29}
	}, 
	["Assault Ammo"] = {
		{"AK-47", 30}, 
		{"M4", 31}
	}, 
	["Shotgun Ammo"] = {
		{"Shotgun", 25}, 
		{"Sawn-Off Shotgun", 26}, 
		{"SPAZ-12 Combat Shotgun", 27}
	}, 
	["Sniper Ammo"] = {
		{"Country Rifle", 33}, 
		{"Sniper Rifle", 34}}, 
		["Rocket Ammo"] = {
		{"Heat-Seeking RPG", 36}, 
		{"Rocket Launcher", 35}
	}, 
	others = {
		{"Parachute", 46}, 
		{"Satchel", 39}, 
		{"Tear Gas", 17}, 
		{"Grenade", 16}, 
		{"Knife", 4}, 
		{"Katana", 8}
	}
}


--FUNctions TODO: organize this
function getWeaponAmmoType(weaponName, notOthers) --FUTR: update to work with invMaster
  if not notOthers then
    for i,weaponData in ipairs(weaponAmmoTable.others) do
      if weaponName == weaponData[1] then
        return weaponData[1], weaponData[2]
      end
    end
  end
  for i,weaponData in ipairs(weaponAmmoTable["Pistol Ammo"]) do
    if weaponName == weaponData[1] then
      return "Pistol Ammo", weaponData[2]
    end
  end
  for i,weaponData in ipairs(weaponAmmoTable["Smg Ammo"]) do
    if weaponName == weaponData[1] then
      return "Smg Ammo", weaponData[2]
    end
  end
  for i,weaponData in ipairs(weaponAmmoTable["Assault Ammo"]) do
    if weaponName == weaponData[1] then
      return "Assault Ammo", weaponData[2]
    end
  end
  for i,weaponData in ipairs(weaponAmmoTable["Shotgun Ammo"]) do
    if weaponName == weaponData[1] then
      return "Shotgun Ammo", weaponData[2]
    end
  end
  for i,weaponData in ipairs(weaponAmmoTable["Sniper Ammo"]) do
    if weaponName == weaponData[1] then
      return "Sniper Ammo", weaponData[2]
    end
  end
  for i,weaponData in ipairs(weaponAmmoTable["Rocket Ammo"]) do
    if weaponName == weaponData[1] then
      return "Rocket Ammo", weaponData[2]
    end
  end
  return false
end
function getAttachOffsets(e1,e2) 
	--thank you based glue resource
	local px, py, pz = getElementPosition(e1)
	local vx, vy, vz = getElementPosition(e2)
	local sx = px - vx
	local sy = py - vy
	local sz = pz - vz		
	local rotpX,rotpY,rotpZ = getElementRotation(e1)
	local rotvX,rotvY,rotvZ = getElementRotation(e2)	
	local t = math.rad(rotvX)
	local p = math.rad(rotvY)
	local f = math.rad(rotvZ)	
	local ct = math.cos(t)
	local st = math.sin(t)
	local cp = math.cos(p)
	local sp = math.sin(p)
	local cf = math.cos(f)
	local sf = math.sin(f)	
	local offZ = ct*cp*sz + (sf*st*cp + cf*sp)*sx + (-cf*st*cp + sf*sp)*sy
	local offX = -ct*sp*sz + (-sf*st*sp + cf*cp)*sx + (cf*st*sp + sf*cp)*sy
	local offY = st*sz - sf*ct*sx + cf*ct*sy	
	local rotX = rotpX - rotvX
	local rotY = rotpY - rotvY
	local rotZ = rotpZ - rotvZ	
	return offX,offY,offZ,rotX,rotY,rotZ
end
function initVeh(eVeh) --TODO(80%): NEW PLANS:
	--[[THESE ARE THE NEW PLANS
		oh baby		
		call me

		i will lootzone a vehicle
		
		i will set up OLDINV for that vehicle on that zone (OLDINV is my newname for the old inventory system isnt that clever)
		
		thats it (remember to make way for NEWINV aka invMaster)
			
		function is STILL designed to be called on individual vehicles
		
		maximum values are pulled from .map data (table these, custom vehicle ent is fucking up editor)
	--]]
	
	--[[ this is how the spawn logic works:
		2/5 chance to spawn vehicle with only one zero'd out part (either fuel/tires/or engine)
			the other parts would have random amounts, but atleast 1.
			
		1/5 chance to spawn vehicle with all zero'd out parts
		
		the other 2/5 chance will spawn vehicles with random part amounts
		
		CHANCES OF A FULLY LOADED VEHICLE ARE VERY SLIM		
	--]]
	
	
	--todo: dig max values from table, setElementData
	local eVehExt,e,t,f,x = getElementData(eVeh, "Ext"),
							getElementData(eVeh, "needengines"), 
							getElementData(eVeh, "needtires"),
							getElementData(eVeh, "maxfuel"),
							math.random(0,4) --set up how loaded the vehicle will be
	if (not eVehExt) then
		eVehExt = createElement("vehExt", getElementID(eVeh).."_ex")
		setElementData(eVeh, "Ext", eVehExt)
	end
	--vehicle spawn logic (maybe increase thresholds a bit; i dunno it seems random enough)
	if (x <= 1) then --partially loaded vehicles
		x = math.random(0,2)
		if (x == 0) then --no fuel
			setElementData(eVehExt, "fuel", 0)
			setElementData(eVehExt, "Engine_inVehicle", math.random(0,e)) --there will always be a chance of having no engine
			setElementData(eVehExt, "Tire_inVehicle", math.random(1,t)) --less of a tire chance since they burned up all the gas
		elseif (x == 1) then --YOU GET AN ENGINE; low fuel / but tires
			setElementData(eVehExt, "fuel", math.random(1,15))
			setElementData(eVehExt, "Engine_inVehicle", 1)
			setElementData(eVehExt, "Tire_inVehicle", math.random(2,t))
		elseif (x == 2) then --no fucking tires / guaranteed some fuel
			setElementData(eVehExt, "fuel", math.random(10,30))
			setElementData(eVehExt, "Engine_inVehicle", math.random(0,e))
			setElementData(eVehExt, "Tire_inVehicle", 0)
		end
	elseif (x == 2) then --YOU GET NOTHING YOU LOSE or well you get to have a vehicle with no parts
		setElementData(eVehExt, "fuel", 0)
		setElementData(eVehExt, "Engine_inVehicle", 0)
		setElementData(eVehExt, "Tire_inVehicle", 0)
	else --and all the rest
		setElementData(eVehExt, "fuel", math.random(0,f))
		setElementData(eVehExt, "Engine_inVehicle", math.random(0,e))
		setElementData(eVehExt, "Tire_inVehicle", math.random(0,t))
	end
	toggleVehicleRespawn(eVeh, false)
	initInv(eVeh)
end
function initAllVehicles() 
	local vehs = getElementsByType("vehicle", mapRoot)
	for k,v in pairs(vehs) do
		initVeh(v)
	end
end
function initInv(e,tab) --FUTR: update to work with invMaster
	if not tab then
		tab = initInvTab
	end
	for k,v in pairs(tab) do
		setElementData(e,k,v)
	end	
end
function initPlayer(ePlr) --FUTR: update to work with invMaster
	initInv(ePlr)
	initInv(ePlr,initPlrTab)
end
function loadPlrInv(ePlr) --FUTR: update to work with invMaster
	local tempTab = {}
	local usrAcct = getPlayerAccount(ePlr)
	local sav = getAccountData(usrAcct, "line-z.sav") --lets access the db AGAIN
	if sav == 1 then --so wait if they have no save dont try and load? BRILLIANT
		for k,_ in pairs(initInvTab) do
			tempTab[k] = getAccountData(usrAcct, "line-z.inv_"..k)
		end
		for k,_ in pairs(initPlrTab) do
			tempTab[k] = getAccountData(usrAcct, "line-z.inv_"..k)
		end
	initInv(ePlr, tempTab)
	end
end
function savePlrInv(ePlr) --FUTR: update to work with invMaster | maybe make a seperate inventory.db
	local usrAcct = getPlayerAccount(ePlr)
	for k,_ in pairs(initInvTab) do --each inventory item gets a db entry, why? because it wouldnt let me store a whole table of items RIP
		local edata = getElementData(ePlr,k) --todo: figure out how to store a big table of items
		setAccountData(usrAcct, "line-z.inv_"..k, edata) --todo: figure out sqlite and DO MY OWN DATABASE QUERIES
	end
	for k,_ in pairs(initPlrTab) do
		local edata = getElementData(ePlr,k)
		setAccountData(usrAcct, "line-z.inv_"..k, edata)
	end
end
function savePlrSpn(ePlr) 
	local x,y,z = getElementPosition(ePlr)
	local _,_,r = getElementRotation(ePlr)
	local spawn = {
		x,y,z,r,
		getElementModel(ePlr),
		getElementInterior(ePlr),
		getElementDimension(ePlr)
	}
	setAccountData(getPlayerAccount(ePlr), "line-z.spawn", toJSON(spawn))
end
function randomSpawn() --FUTR: add spawngroups (for randomization purposes)
	local spawntab = getElementsByType("spawnpoint", mapRoot)
	local spawn = spawntab[math.random(1,table.maxn(spawntab))]
	local x,y,z,r,m,i,d = getElementData(spawn,"posX"),
						  getElementData(spawn,"posY"),
						  getElementData(spawn,"posZ"),
						  getElementData(spawn,"rotZ"),
						  getElementData(spawn,"model"),
						  getElementData(spawn,"interior"),
						  getElementData(spawn,"dimension")
	spawn = {x,y,z,r,m,i,d}
	return spawn
end
function spawnPlr(ePlr) 
	if not isElement(ePlr) then return end
	local usrAcct = getPlayerAccount(ePlr)
	local jason = fromJSON(getAccountData(usrAcct,"line-z.spawn"))
	if not (type(jason) == "table") then
		jason = { randomSpawn() }
		outputServerLog("Error: bugged user reset (failed table load)")
	end
	local x,y,z,r,m,i,d = unpack(jason)
	spawnPlayer(ePlr,x,y,z,r,m,i,d)
	setElementFrozen(ePlr,false)
	setCameraTarget(ePlr)
	fadeCamera(ePlr,true,3.0)	
	showChat(ePlr, true)	
end
function itemCheck(ePlr, item) --FUTR: update to work with invMaster
	local data = getElementData(ePlr, item)
	if (data > 0) then
		return data
	end
end
function skinIDtoName(sID) 
	for k,v in pairs(skinTable) do
		if (sID == v[1]) or (sID == v[2]) then
			return k
		end
	end
end
function deathHelper(ePlr) --this is incredibly stupid i dont know why i moved all this here
	local x,y,z = getElementPosition(ePlr) 
	local _,_,r = getElementRotation(ePlr)
	local m,i,d,eCon = getElementModel(ePlr),
					   getElementInterior(ePlr),
					   getElementDimension(ePlr),
					   getPedContactElement(ePlr)				  
	local corpse = createPed(m,0,0,0,r,false)
	setElementInterior(corpse,i)
	setElementDimension(corpse,d)
	killPed(corpse)
	--done setting up the corpse now:
	setTimer(function() --after 2 seconds swap dead player with dead corpseped (just like magic noone will EVER KNOW)
				spawnPlayer(ePlr,0,0,0,0,73,0,1)
				setElementFrozen(ePlr,true)
				setElementPosition(corpse,x,y,z)
				if eCon then
					attachElements(corpse,eCon,getAttachOffsets(corpse,eCon)) 
					setElementParent(corpse,eCon)
				end
				local lz = createLootZone(corpse,"deadman",true) --create "deadman" zone
				setElementData(lz,"playername",getPlayerName(ePlr))
				local hr,mt = getTime()
				setElementData(lz,"deadreason","It looks like they died at around "..hr..":"..math.random(mt-3,mt+3)) --APPROX TIME
				initPlayer(ePlr)
				savePlrInv(ePlr)
				setTimer(destroyElement,1800000,1,corpse) --30 minutes
			end,2000,1)
end
function createThing(ePlr,thingType) --TODO(33%): tents and fences --LOTS OF "MAGIC" HAPPENS HERE --it has to happen somewhere
	---[[debug stuff
	outputChatBox("creating '"..tostring(thingType).."'") --]]
	local x,y,z = getElementPosition(ePlr)
			  z = z-0.77
	local _,_,r = getElementRotation(ePlr)
	local i,d,eCon,msLifetime,bLoot,tObj = getElementInterior(ePlr), --interior of player
										   getElementDimension(ePlr), --dimension of player
										   getPedContactElement(ePlr), --we standin on anything?
										   900000, --15 minutes
										   false, --default shit wont have an interact zone (which is what i should call them instead of lootzones but w/e)
										   {} --table of new objects
	if thingType == "fireplace" then --todo: register fireplaces to players; make sure they can only have ONE (or two? who knows ill do this later)
		bLoot = true
		tObj[1] = createObject(1463,x,y,z,0,0,r) --todo: createObject wrapper that does interiors and dimensions 
			setElementInterior(tObj[1],i)
			setElementDimension(tObj[1],d)
			setElementFrozen(tObj[1],true)
			--setElementCollisionsEnabled(tObj[1],false) --maybe figure out a way to stop the dynamic wood from busting apart WITHOUT REMOVING COLLISIONS
			setObjectScale(tObj[1],0.5)
		tObj[2] = createObject(3525,x,y,z-0.77,0,0,r)
			setElementInterior(tObj[2],i)
			setElementDimension(tObj[2],d)
			setElementFrozen(tObj[2],true)
			setObjectScale(tObj[1],0.5)
			setElementCollisionsEnabled(tObj[2],false)
			setElementAlpha(tObj[2],0)
			setElementParent(tObj[2],tObj[1])
	elseif thingType == "tent" then --todo: register tents to players; maybe give them a locator blip (again max tents = 3? we'll see)
		msLifetime,bLoot = false,true --TENTS LIVE FOREVER AHAHAHAHAH
		tObj[1] = createObject(3243,x,y,z,0,0,r)
			setElementInterior(tObj[1],i)
			setElementDimension(tObj[1],d)
			setObjectScale(tObj[1],0.5)
			setElementFrozen(tObj[1],true)
	elseif thingType == "fence" then --todo: register fences to players; im spotting a trend here (maybe secure fences in the future)
		msLifetime,bLoot = false,true --FENCES ALSO LIVE FOREVER (atleast until the server goes down RIP)
		tObj[1] = createObject(983,x,y,z,0,0,r)
			setElementInterior(tObj[1],i)
			setElementDimension(tObj[1],d)
			--setObjectScale(tObj[1],1) --kept for posterity
			setElementFrozen(tObj[1],true)
	elseif thingType == "flare" then --flares will not register to players (i doubt flare spam will be a problem)
		msLifetime = 150000 --2.5 minutes
		tObj[1] = createObject(354,x,y,z,0,0,r)
			setElementInterior(tObj[1],i)
			setElementDimension(tObj[1],d)
			setObjectScale(tObj[1],0.5)
			setElementFrozen(tObj[1],true)
	end
	if eCon then --this is awesome code but its probably going to break stuff if we let people do it on anything; update for futr
		local px,py,pz,rx,ry,rz = getAttachOffsets(tObj[1],eCon)
		attachElements(tObj[1],eCon,px,py,pz,rx,ry,rz)
		if thingType == "fireplace" then attachElements(tObj[2],eCon,px,py,pz-0.77,rx,ry,rz) end --anything made up of 2 objects or more will need a case down here FOR ALIGNMENT REASONS
		setElementParent(tObj[1],eCon) --we family now
		if bLoot then createLootZone(tObj[1],thingType,true) end --ATTACHED LOOT ZONES WHY
	elseif bLoot then
		createLootZone(tObj[1],thingType)
	end
	if msLifetime then setTimer(destroyElement,msLifetime,1,tObj[1]) end
end
function createLootZone(e,zType,bAttach) --TODO(75%): pull/link/init OLDINV (deadman) / make it work with vehicles(NEW PLANS) / item loot zones(TBA)
	local x,y,z = getElementPosition(e)
	local eType = getElementType(e)
	local zOff = -0.77
	if (eType == "player") or (zType == "deadman") then --fixes coltube being in a weird place
		z = z + zOff
	end
	local col = createColTube(x,y,z,1.75,2)
	setElementParent(col,e)
	if (eType == "player") or (zType == "deadman") then --fixes coltube being in a weird place
		attachElements(col,e,0,0,zOff)
	elseif bAttach then
		attachElements(col,e)
	end
	setElementData(col,zType,true)
	return col
end
function addPlayerStats(player, data, value) --todo: figure me out
  if data == "food" then
    local current = getElementData(player, data)
    if current + value > 100 then
      setElementData(player, data, 100)
    elseif current + value < 1 then
      setElementData(player, data, 0)
      setElementData(player, "blood", getElementData(player, "blood") - math.random(50, 120))
    else
      setElementData(player, data, current + value)
    end
  elseif data == "thirst" then
    local current = getElementData(player, data)
    if current + value > 100 then
      setElementData(player, data, 100)
    elseif current + value < 1 then
      setElementData(player, data, 0)
      setElementData(player, "blood", getElementData(player, "blood") - math.random(50, 120))
    else
      setElementData(player, data, current + value)
    end
  elseif data == "blood" then
    local current = getElementData(player, data)
    if current + value > 12000 then
      setElementData(player, data, 12000)
    elseif current + value < 1 then
      setElementData(player, data, 0)
    else
      setElementData(player, data, current + value)
    end
  elseif data == "temperature" then
    local current = getElementData(player, data)
    if current + value > 41 then
      setElementData(player, data, 41)
    elseif current + value <= 31 then
      setElementData(player, data, 31)
    else
      setElementData(player, data, current + value)
    end
  elseif data == "humanity" then
    local current = getElementData(player, data)
    if current + value > 5000 then
      setElementData(player, data, 5000)
    end
  else
    setElementData(player, data, current + value)
  end
end

--NEW EVENTS | FUTR: combine thing stuff into thingHandler
function loginHandler(u,p,t) --DONE(99%) EVENTUALLY SS THE TRY CHECKS (far future)
	if (not u) or (not p) or (not t) then --for safety
		outputServerLog("blank login/try")
		outputServerLog("THIS SHOULD NOT HAPPEN")
		cancelEvent()
		return
	end
	u = string.lower(u) --all usernames will be lowercased to prevent stupid duplicates
	if (t >=300) then --THIS WILL BE MADE SERVERSIDE WHEN I CARE ENOUGH TO DO IT
		kickPlayer(client, "failed to login")
		cancelEvent()
		return
	end
	if (not client) then --again this is for safety i want this to NEVER BREAK EVER
		outputServerLog("non client caller?! WHATS UP WITH THAT") 
		cancelEvent()
		return
	end
	local usrAcct = getAccount(u) --ARE THEY REGISTERED?
	if (not usrAcct) then --register them
		outputServerLog("NEW USER: " .. tostring(u))
		usrAcct = addAccount(u,p)
		if (not usrAcct) then --CAUTIOUS DOUBLE CHECKING WON THE WAR
			outputServerLog("IF YOU SEE THIS MESSAGE SOMETHING WENT TERRIBLY WRONG")
			outputChatBox("IF YOU SEE THIS MESSAGE SOMETHING WENT TERRIBLY WRONG", root, 255, 0, 0)
			cancelEvent()
			return
		end
		local spawn = toJSON(randomSpawn())
		setAccountData(usrAcct, "line-z.spawn", spawn)
	end
	usrAcct = getAccount(u,p) --DID THEY TYPE THE CORRECT PASS?
	if (not usrAcct) then --haha no.
		outputServerLog("INCORRECT PASS: " .. tostring(u))
		triggerClientEvent(client, "showInvalEv", root) --send em the message
		--eventually have a serverside tick of login tries; having the client do it is stupid
		cancelEvent() 
		return
	end
	triggerClientEvent(client, "showLoginEv", root, false) --ok let them in
	logIn(client,usrAcct,p)
	setElementData(client, "auth", 1) --they are now authorized to play the game
	local sav = getAccountData(usrAcct, "line-z.sav") --database checking: HAS THEIR INFO BEEN PREVIOUSLY SAVED
	if sav == 0 or not sav then -- no 
		local spawn = toJSON(randomSpawn()) --make them a new spawn
		setAccountData(usrAcct, "line-z.spawn", spawn) --save the spawn
		outputServerLog("what the fuck is going on") --figure out whats going on later
	end
	initPlayer(client) --initialize OLDINV (this is getting removed/updated)
	loadPlrInv(client) --load saved inv (todo: NEW PLAYERS WOULD GET *random* ITEMS HERE)
	setAccountData(usrAcct, "line-z.sav", 0) --PLAYER INVENTORY IS NOW UNSAFE; SERVER GOES DOWN THEYRE FUCKED (unless the db doesnt save)
	spawnPlr(client) --WELCOME TO THE WASTELAND
	outputChatBox("Welcome to DIE", client) --PREPARE TO DIE (and stop wasting time making stupid useless comments)
end
addEvent("onLoginTry", true)
addEventHandler("onLoginTry", root, loginHandler)
function rcsHandler(item,prop) --DONE(99%) FUTR: update to work with invMaster | stays
	local amt = itemCheck(source, item)
	if amt then
		if item == invMaster[27][3] or item == invMaster[32][3] then
			local item2 = invMaster[54][3]
			local amt2 = getElementData(source, item2)
			if (not amt2) then
				amt2 = 0
			end
			setElementData(source, item2, amt2+1)
		elseif item == invMaster[28][3] or item == invMaster[29][3] then
			local item2 = invMaster[55][3]
			local amt2 = getElementData(source, item2)
			if (not amt2) then
				amt2 = 0
			end
			setElementData(source, item2, amt2+1)
		end
		setElementData(source, item, amt-1)
		local bloodAdd
		for i=27,34 do
			if invMaster[i][3] == item then
				bloodAdd = invMaster[i][5]
			end
		end
		bloodAdd = bloodAdd + getElementData(source, "blood")
		if (bloodAdd) > 12000 then
			bloodAdd = 12000
		end		
		setElementData(source, prop, 100) --update stats
		setElementData(source, "blood", bloodAdd)
		triggerClientEvent(source,"hideInventoryManual",root)
		setPedAnimation(source, "FOOD", "EAT_Burger",-1,false,false,false,false)
	end
end
addEvent("onPlayerRequestChangingStats",true)
addEventHandler("onPlayerRequestChangingStats", root, rcsHandler)
function skinHandler(item) --DONE(99%) FUTR: update to work with invMaster | stays
	local amt = itemCheck(source, item)
	if amt then 
		local oldName,newID = skinIDtoName(getElementModel(source)),
							  skinTable[item][1]
		local amt2 = getElementData(source,oldName)
		if (not amt2) then
			amt2 = 0
		end
		triggerClientEvent(source,"hideInventoryManual",root)
		setElementModel(source, newID)
		setElementData(source, item, amt-1)
		setElementData(source, oldName, amt2+1)
	end
end
addEvent("onPlayerChangeSkin",true)
addEventHandler("onPlayerChangeSkin", root, skinHandler)
function refillHandler(item) --DONE(99%) FUTR: update to work with invMaster | stays
	local amt = itemCheck(source, item)
	if amt then 
		local item2 = invMaster[27][3]
		local amt2 = getElementData(source, item2)
		if (not amt2) then
			amt2 = 0
		end
		setElementData(source, item, amt-1)
		setElementData(source, item2, amt2+1)
		triggerClientEvent(source,"hideInventoryManual",root)
	end
end
addEvent("onPlayerRefillWaterBottle",true)
addEventHandler("onPlayerRefillWaterBottle", root, refillHandler)
function tentHandler(item) --DONE(99%) FUTR: update to work with invMaster | goes
	local amt = itemCheck(source, item)
	if amt then 
		setElementData(source, item, amt-1)
		createThing(source,"tent")
		triggerClientEvent(source,"hideInventoryManual",root)
	end
end
addEvent("onPlayerPitchATent",true)
addEventHandler("onPlayerPitchATent", root, tentHandler)
function fenceHandler(item) --DONE(99%) FUTR: update to work with invMaster | goes
	local amt = itemCheck(source, item)
	if amt then 
		setElementData(source, item, amt-1)
		createThing(source,"fence")
		triggerClientEvent(source,"hideInventoryManual",root)
	end
end
addEvent("onPlayerBuildAWireFence",true)
addEventHandler("onPlayerBuildAWireFence", root, fenceHandler)
function flareHandler(item) --DONE(99%) FUTR: update to work with invMaster | goes
	local amt = itemCheck(source, item)
	if amt then 
		setElementData(source, item, amt-1)
		createThing(source,"flare")
		triggerClientEvent(source,"hideInventoryManual",root)
	end
end
addEvent("onPlayerPlaceRoadflare",true)
addEventHandler("onPlayerPlaceRoadflare", root, flareHandler)
function fireHandler(item) --DONE(99%) FUTR: update to work with invMaster | goes
	local amt = itemCheck(source, item) 
	if amt then 
		local item2 = "Wood"
		local amt2 = itemCheck(source, item2)
		if amt2 then
			setElementData(source, item2, amt-1)
			createThing(source,"fireplace")
			triggerClientEvent(source,"hideInventoryManual",root)
		end
	end
end
addEvent("onPlayerMakeAFire",true)
addEventHandler("onPlayerMakeAFire", root, fireHandler)
function medicHandler(item,target) --writeme(10%) | stays
	local amt = itemCheck(source, item)
	if amt then 
		if not target then
			target = localPlayer
		end
	--if bandage
	--elif medkit
	--elif heatpack
	--elif morphine
	--elif painkiller
	--elif bloodbag
	--update stats accordingly
	end
end
addEvent("onPlayerUseMedicObject",true)
addEventHandler("onPlayerUseMedicObject", root, medicHandler)
function rearmHandler(item,slot) --testme(??%) FUTR: update to work with invMaster | stays | NEEDS BONE ATTACH
	if itemCheck(source, item) then 
		takeAllWeapons(source) 
		local ammoData, weapID = getWeaponAmmoType(item) 
		if getElementData(source, ammoData) <= 0 then
			triggerClientEvent(source, "displayClientInfo", source, "Rearm", "You got no magazine for this weapon", 255, 22, 0)
			return 
		end
		setElementData(source, "currentweapon_" .. slot, item)
		local weapon = getElementData(source, "currentweapon_1")
		if weapon then
			local ammoData, weapID = getWeaponAmmoType(weapon)
			giveWeapon(source, weapID, getElementData(source, ammoData), true)
		end
		local weapon = getElementData(source, "currentweapon_2")
			if weapon then
			local ammoData, weapID = getWeaponAmmoType(weapon)
			giveWeapon(source, weapID, getElementData(source, ammoData), false)
		end
		local weapon = getElementData(source, "currentweapon_3")
		if weapon then
			local ammoData, weapID = getWeaponAmmoType(weapon)
			giveWeapon(source, weapID, getElementData(source, ammoData), false)
		end
		if elementWeaponBack[source] then
			detachElementFromBone(elementWeaponBack[source])
			destroyElement(elementWeaponBack[source])
			elementWeaponBack[source] = false
		end
		setPedSkin(getElementData(source, "skin"))
	end
end
addEvent("onPlayerRearmWeapon",true)
addEventHandler("onPlayerRearmWeapon", root, medicHandler)
function killHandler(attacker,headshot,wpnName) --DONE(100%) | stays
	if not attacker then
		attacker = source
	end
	if wpnName then
		wpnID = getWeaponIDFromName(wpnName)
	end
	if headshot then
		bpart = 9
	end
	killPed(source,attacker,wpnID,bpart)
end
addEvent("kilLDayZPlayer",true)
addEventHandler("kilLDayZPlayer", root, killHandler)


--HOOKS
function loadMap(startedMap) --RELEASE: remove the train what the fuck are you doing stop getting distracted
	mapRoot = getResourceRootElement(startedMap)
	initAllVehicles()
		--wait why is there a train here WHAT ARE YOU DOING
		local myTrain = createVehicle(537,1718,-1954.3,15)  -- This will make a freight train at the LS train station
		setTrainDerailable(myTrain, false) -- myTrain can not be derailed now WATCH OUT
	outputServerLog("map loaded")
end
addEventHandler("onGamemodeMapStart", root, loadMap)
function joinHandler()
	if table.maxn(getElementsByType("player")) == 1 then --when the server has 0 people in it, all sim stops; this resets clock settings when someone joins
		setMinuteDuration(15000)
	end	
end
addEventHandler("onPlayerJoin", root, joinHandler)
function quitHandler() 
	local usrAcct = getPlayerAccount(source)
	if isGuestAccount(usrAcct) then --they joined; they quit before logging in; RIP
		outputServerLog("POO")
		return
	end
	savePlrSpn(source)
	savePlrInv(source)	
	setAccountData(usrAcct, "line-z.sav", 1) --PLAYER INVENTORY IS NOW SAFE
	logOut(source) --GOODBYE
end
addEventHandler("onPlayerQuit", root, quitHandler)
function deathHandler(tot,atk,wpn,bp,bStealth) --this handles ALL DEATHS EVEN STEALTH KILLS NO MORE BUGS
	local usrAcct,wpnID,spawn,bpart = 
			getPlayerAccount(source),
			0,
			toJSON(randomSpawn()),
			4
	setElementData(source,"isDead",true)
	triggerClientEvent(source,"onClientPlayerDeathInfo",root)
	setAccountData(usrAcct, "line-z.spawn", spawn)
	deathHelper(source)
	setTimer(spawnPlr,7050,1,source) --arbitrary numbers
end
addEventHandler("onPlayerWasted", root, deathHandler)
function exitHandler() --maybe fix this later
	--kicking all players isnt a problem because it calls quithandler on all of them NOICE
	local players = getElementsByType("player")
	for k,v in ipairs(players) do
		kickPlayer (v, "server shutting down.")
	end
end
addEventHandler ("onResourceStop", resourceRoot, exitHandler)

--TIMERS
function handleTrafficLightsOutOfOrder() --i really like this thank you mtawiki
    -- See if the lights are currently off
    local lightsOff = getTrafficLightState() == 9
    if lightsOff then
        -- If they're off, turn them on
        setTrafficLightState(6) 
    else
        -- If they're on, turn them off
        setTrafficLightState(9)
    end
end
setTimer(handleTrafficLightsOutOfOrder,3000,0)
  --BEGIN: ALTERED marwin code
function checkTemperature() --TODO: ADD MORE WEATHERS
  for i,player in ipairs(getElementsByType("player")) do
    if getElementData(player, "auth") then
      local value = 0
      if getWeather == 7 then --
        value = -0.1
      elseif getWeather == 12 then --
        value = 0
      elseif getWeather == 16 then --
        value = -0.4
      elseif getWeather == 4 then --
        value = -0.1
      end
      local hour, minutes = getTime()
      if hour >= 21 and hour <= 8 then
        value = value - 0.05
      end
      addPlayerStats(player, "temperature", value)
    end
  end
end
setTimer(checkTemperature, 60000, 0)
function checkTemperature2()
  for i,player in ipairs(getElementsByType("player")) do
    if getElementData(player, "auth") then
      local value = 0
	  if isElementInWater(player) then
		value = -0.1
      end
      if getControlState(player, "sprint") then
        value = value + 0.005
      end
      addPlayerStats(player, "temperature", value)
    end
  end
end
setTimer(checkTemperature2, 10000, 0)
function setHunger() --TODO: MAKE ME BETTER (how?)
  for i,player in ipairs(getElementsByType("player")) do
    if getElementData(player, "auth") then
      local value = -1.5
      addPlayerStats(player, "food", value)
    end
  end
end
setTimer(setHunger, 61258, 0)
function setThirsty() --ME TOO (how?)
  for i,player in ipairs(getElementsByType("player")) do
    if getElementData(player, "auth") then
      local value = -2
      addPlayerStats(player, "thirst", value)
    end
  end
end
setTimer(setThirsty, 59379, 0)
function checkThirsty()
  for i,player in ipairs(getElementsByType("player")) do
    if getElementData(player, "auth") then
      local value = 0
      if getControlState(player, "sprint") then
        value = -0.1
      end
      addPlayerStats(player, "thirst", value)
    end
  end
end
setTimer(checkThirsty, 9892, 0)
function checkHumanity()
  for i,player in ipairs(getElementsByType("player")) do
    if getElementData(player, "auth") and getElementData(player, "humanity") < 2500 then
      addPlayerStats(player, "humanity", 30)
    end
    if getElementData(player, "humanity") > 2000 then
      setElementData(player, "bandit", false)
    end
  end
end
setTimer(checkHumanity, 65084, 0)
  --END
  
--[[debug stuff
	--nothing for now 
--]]
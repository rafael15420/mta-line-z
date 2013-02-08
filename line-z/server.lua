--[[

GTA-DAYz / WASTELAND MOD
COPYRIGHT DRLINE 2012 DO NOT STEAL LOL

uses these fine resources: 
	marwin survivor system gui
	bone_attach resource
	glue resource
	zday resource (maybe)
	betterWeather resource

TODO: 	/!\ NEW SYSTEM /!\ implemented(ish)
		remove refrences to invMaster
		inventory stuff:
			finish item funcs (0%; still needs to be done [STEALSTEALSTEAL])
			finish loot funcs (working on it)
		item manipulation funcs (give item, take item etc)
			test backpacks
			test guns
			test everything
		gamemode admin menu (needs a gui)
		
		item spawning code (pull spawns from map data [generic spawns? or specific] [also:STEALSTEALSTEAL])
		
		zombies (lol @ this being the last thing)
]]--


--VARIABLES YO		
local invDefaults = {
	[1] = { name = "Primary Equipment",
		[1] = { name = "M4",
			weight = 3,
			dmg = 6722,
			model = 31,
			worldModel = 356,
			ammo = 4 },
		[2] = { name = "Sniper Rifle",
			weight = 3,
			dmg = 6722,
			model = 34,
			worldModel = 358,
			ammo = 2 },
		[3] = { name = "Shotgun",
			weight = 3,
			dmg = 6722,
			model = 25,
			worldModel = 349,
			ammo = 6 },
		[4] = { name = "SPAZ-12 Combat Shotgun",
			weight = 3,
			dmg = 6722,
			model = 27,
			worldModel = 351,
			ammo = 6 },
		[5] = { name = "Sawn-Off Shotgun",
			weight = 3,
			dmg = 6722,
			model = 26,
			worldModel = 350,
			ammo = 6 },
		[6] = { name = "AK-47",
			weight = 3,
			dmg = 6722,
			model = 30,
			worldModel = 355,
			ammo = 4 },
		[7] = { name = "Heat-Seeking RPG",
			weight = 5,
			dmg = 6722,
			model = 36,
			worldModel = 360,
			ammo = 1 },
		[8] = { name = "Rocket Launcher",
			weight = 5,
			dmg = 6722,
			model = 35,
			worldModel = 359,
			ammo = 1 },
		[9] = { name = "Country Rifle",
			weight = 3,
			dmg = 6722,
			model = 33,
			worldModel = 357,
			ammo = 2 },
	},
	[2] = { name = "Secondary Equipment",
		[1] = { name = "Pistol",
			weight = 2,
			dmg = 889,
			model = 22,
			worldModel = 346,
			ammo = 5 },
		[2] = { name = "Silenced Pistol",
			weight = 2,
			dmg = 889,
			model = 23,
			worldModel = 347,
			ammo = 5 },
		[3] = { name = "Uzi",
			weight = 2,
			dmg = 889,
			model = 28,
			worldModel = 352,
			ammo = 3 },
		[4] = { name = "TEC-9",
			weight = 2,
			dmg = 889,
			model = 32,
			worldModel = 372,
			ammo = 3 },
		[5] = { name = "MP5",
			weight = 3,
			dmg = 1196,
			model = 29,
			worldModel = 353,
			ammo = 3 },
		[6] = { name = "Desert Eagle",
			weight = 2,
			dmg = 2489,
			model = 24,
			worldModel = 348,
			ammo = 5 },
		[7] = { name = "Knife",
			weight = 1,
			dmg = 1500,
			model = 4,
			worldModel = 335 },
		[8] = { name = "Katana",
			weight = 2,
			dmg = 2100,
			model = 8,
			worldModel = 339 },
	},
	[3] = { name = "Special Equipment",
		[1] = { name = "Parachute",
			weight = 1,
			model = 46,
			worldModel = 342 },
		[2] = { name = "Tear Gas",
			weight = 1,
			model = 17,
			worldModel = 17 },
		[3] = { name = "Grenade",
			weight = 1,
			dmg = 18000,
			model = 16,
			worldModel = 342 },
	},
	[4] = { name = "Ammunition",
		[1] = { name = "Rocket Ammo",
			weight = 2,
			worldModel = 3082 },
		[2] = { name = "Sniper Ammo",
			weight = 0.1,
			worldModel = 2358 },
		[3] = { name = "Smg Ammo",
			weight = 0.025,
			worldModel = 2041 },
		[4] = { name = "Assault Ammo",
			weight = 0.035,
			worldModel = 1271 },
		[5] = { name = "Pistol Ammo",
			weight = 0.085,
			worldModel = 3013 },
		[6] = { name = "Shotgun Ammo",
			weight = 0.067,
			worldModel = 2358 },
	},
	[5] = { name = "Food and Drink",
		[1] = { name = "Water Bottle",
			weight = 1,
			modValue = 50,
			worldModel = 2683 },
		[2] = { name = "Pasta Can",
			weight = 1,
			modValue = 200,
			worldModel = 2770 },
		[3] = { name = "Beans Can",
			weight = 1,
			modValue = 200,
			worldModel = 2601 },
		[4] = { name = "Burger",
			weight = 1,
			modValue = 300,
			worldModel = 2768 },
		[5] = { name = "Pizza",
			weight = 1,
			modValue = 500,
			worldModel = 1582 },
		[6] = { name = "Soda Bottle",
			weight = 1,
			modValue = 100,
			worldModel = 2647 },
		[7] = { name = "Milk",
			weight = 1,
			modValue = 250,
			worldModel = 2856 },
		[8] = { name = "Cooked Meat",
			weight = 1,
			modValue = 800,
			worldModel = 2806 },
	},
	[6] = { name = "Healing Items",
		[1] = { name = "Bandage",
			weight = 1,
			worldModel = 1578 },
		[2] = { name = "Medic Kit",
			weight = 2,
			worldModel = 2891 },
		[3] = { name = "Heat Pack",
			weight = 1,
			worldModel = 1576 },
		[4] = { name = "Painkiller",
			weight = 1,
			worldModel = 2709 },
		[5] = { name = "Morphine",
			weight = 1,
			worldModel = 1579 },
		[6] = { name = "Blood Bag",
			weight = 1,
			worldModel = 1580 },
	},
	[7] = { name = "Skins",
		[1] = { name = "Army Skin",
			weight = 1,
			model = 287,
			worldModel = 1247,
			banditModel = 288 },
		[2] = { name = "Civilian Skin",
			weight = 1,
			model = 179,
			worldModel = 1241,
			banditModel = 180 },
		[3] = { name = "Standard Skin",
			weight = 1,
			model = 73,
			worldModel = 1577,
			banditModel = 288 },
		[4] = { name = "Sniper Skin",
			weight = 1,
			model = 285,
			worldModel = 1213 },
	},
	[8] = { name = "Backpack",
		[1] = { name = "Alice Backpack",
			weight = 1,
			worldModel = 1248 },
		[2] = { name = "Small Backpack",
			weight = 1,
			worldModel = 3026 },
		[3] = { name = "Coyote Backpack",
			weight = 1,
			worldModel = 1252 },
	},
	[9] = { name = "Deployables",
		[1] = { name = "Roadflare",
			weight = 1,
			worldModel = 324 },
		[2] = { name = "Wire Fence",
			weight = 1,
			worldModel = 933 },
		[3] = { name = "Tent",
			weight = 3,
			worldModel = 1279 },
	},
	[10] = { name = "Resources",
		[1] = { name = "Wood",
			weight = 2,
			worldModel = 1463 },
		[2] = { name = "Raw Meat",
			weight = 1,
			worldModel = 2804 },
		[3] = { name = "Empty Bottle",
			weight = 1,
			worldModel = 2683 },
		[4] = { name = "Tin Can",
			weight = 1,
			worldModel = 2673 },
		[5] = { name = "Scruffy Burgers",
			weight = 1,
			worldModel = 2675 },
	},
	[11] = { name = "Parts",
		[1] = { name = "Tire",
			weight = 2,
			worldModel = 1073 },
		[2] = { name = "Engine",
			weight = 5,
			worldModel = 929 },
		[3] = { name = "Empty Petrol Canister",
			weight = 2,
			worldModel = 1650 },
		[4] = { name = "Full Petrol Canister",
			weight = 2,
			worldModel = 1650 },
	},
	[12] = { name = "Tools",
		[1] = { name = "Night Vision Goggles",
			weight = 1,
			worldModel = 368 },
		[2] = { name = "Infrared Goggles",
			weight = 1,
			worldModel = 369 },
		[3] = { name = "Map",
			weight = 1,
			worldModel = 1277 },
		[4] = { name = "Lighter",
			weight = 1,
			worldModel = 328 },
		[5] = { name = "Watch",
			weight = 1,
			worldModel = 2710 },
		[6] = { name = "GPS",
			weight = 1,
			worldModel = 2976 },
		[7] = { name = "Toolbox",
			weight = 1,
			worldModel = 2969 },
		[8] = { name = "Binocular",
			weight = 1,
			worldModel = nil },
		[9] = { name = "Radio Device",
			weight = 1,
			worldModel = 330 },
	},
	[13] = { name = "Status Variables", --some are OLD
		volume = 0,
		visibly = 0,
		brokenbone = false,
		humanity = 2500,
		temperature = 37.7,
		thirst = 100,
		blood = 12000,
		food = 100,
		bleeding = 0,
		zombieskilled = 0,
		headshots = 0,
		murders = 0,
		banditskilled = 0,
		zombies = 0,
		MAX_Slots = 10,
		alivetime = 0,
		loot = false,
		isDead = false,
		pain = false,
		skin = 73
	},
}

local invMaster = { }

local writeInvXML = function()

end

--[[local plrTab = { --this is what the player table should look like completely initialized + having collected some shit

} 
--]]


--EVERYTHING GOES
local initInvTabOLD = { --in master
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
	["Roadflare"] = 0,
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
	["Toolbox"] = 1,
	["Binocular"] = 0,
	["Radio Device"] = 1,
}
local initPlrTabOLD = { --extra settings for players --in master
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
	["pain"] = false,
	["skin"] = 73
}
local skinTableOLD = { --skinTableOLD[itemName][#] = { skinID, banditskinID } --in master
	["Army Skin"] = {287,288},
	["Civilian Skin"] = {179,180},
	["Standart Skin"] = {73,288},
	["Sniper Skin"] = {285,285}
}
local weaponAmmoTableOLD = { --in master
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
local weaponIDtoObjectIDOLD = { --in master
	{30, 355}, 
	{31, 356}, 
	{25, 349}, 
	{26, 350}, 
	{27, 351}, 
	{33, 357}, 
	{34, 358}, 
	{36, 360}, 
	{35, 359}
}
--END EVERYTHING GOES
--borrow
local elementBackpack = {}
local elementWeaponBack = {}
local chatRadius = 15
local chatEadioRadius = 250


--FUNctions TODO: organize this
---utility functions
local createObjectEx = function(model,px,py,pz,rx,ry,rz,i,d,bIsLowLOD)
	--this is a custom wrapper for createObject
	--it allows you to choose interior and dimension
	--why? because i wanted it dealwithit
	local objTemp = createObject(model,px,py,pz,rx,ry,rz,bIsLowLOD)
	if not objTemp then return false end
	if i then setElementInterior(objTemp,i) end
	if d then setElementDimension(objTemp,d) end
	return objTemp
end
local getAttachOffsets = function(e1,e2) 
	--thank you based glue resource
	--this determines the attach offsets 
	--for two objects that are touching
	--yeah whatever its a horrible explaination
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
local getWeaponAmmoType = function(weaponName, notOthers) --this is an OLD iterator			--FUTR: update to work with invMaster
  if not notOthers then
    for i,weaponData in ipairs(weaponAmmoTableOLD.others) do
      if weaponName == weaponData[1] then
        return weaponData[1], weaponData[2]
      end
    end
  end
  for i,weaponData in ipairs(weaponAmmoTableOLD["Pistol Ammo"]) do
    if weaponName == weaponData[1] then
      return "Pistol Ammo", weaponData[2]
    end
  end
  for i,weaponData in ipairs(weaponAmmoTableOLD["Smg Ammo"]) do
    if weaponName == weaponData[1] then
      return "Smg Ammo", weaponData[2]
    end
  end
  for i,weaponData in ipairs(weaponAmmoTableOLD["Assault Ammo"]) do
    if weaponName == weaponData[1] then
      return "Assault Ammo", weaponData[2]
    end
  end
  for i,weaponData in ipairs(weaponAmmoTableOLD["Shotgun Ammo"]) do
    if weaponName == weaponData[1] then
      return "Shotgun Ammo", weaponData[2]
    end
  end
  for i,weaponData in ipairs(weaponAmmoTableOLD["Sniper Ammo"]) do
    if weaponName == weaponData[1] then
      return "Sniper Ammo", weaponData[2]
    end
  end
  for i,weaponData in ipairs(weaponAmmoTableOLD["Rocket Ammo"]) do
    if weaponName == weaponData[1] then
      return "Rocket Ammo", weaponData[2]
    end
  end
  return false
end

--init funcs
function initVehOLD(eVeh) --TODO(80%): NEW PLANS:
	--[[THESE ARE THE NEW PLANS
		oh baby		
		call me

		i will interactZone a vehicle
		
		(for now) i will set up OLDINV for that vehicle on that zone (OLDINV is my newname for the old inventory system isnt that clever)
		
		thats it (remember to make way for NEWINV aka invMaster)
			
		function is STILL designed to be called on individual vehicles
		
		(for now) maximum values are pulled from .map data (eventually table these, custom vehicle ent is fucking up editor)
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
		initVehOLD(v)
	end
end
function initInv(e,tab) --FUTR: update to work with invMaster
	if not tab then
		tab = initInvTabOLD
	end
	for k,v in pairs(tab) do
		setElementData(e,k,v)
	end	
end
function initPlayer(ePlr) --FUTR: update to work with invMaster
	initInv(ePlr)
	initInv(ePlr,initPlrTabOLD)
end
function loadPlrInv(ePlr) --FUTR: update to work with invMaster
	local tempTab = {}
	local usrAcct = getPlayerAccount(ePlr)
	local sav = getAccountData(usrAcct, "line-z.sav") --lets access the db AGAIN
	if sav == 1 then --so wait if they have no save dont try and load? BRILLIANT
		for k,_ in pairs(initInvTabOLD) do
			tempTab[k] = getAccountData(usrAcct, "line-z.inv_"..k)
		end
		for k,_ in pairs(initPlrTabOLD) do
			tempTab[k] = getAccountData(usrAcct, "line-z.inv_"..k)
		end
	initInv(ePlr, tempTab)
	end
end
function savePlrInv(ePlr) --FUTR: update to work with invMaster | maybe make a seperate inventory.db
	local usrAcct = getPlayerAccount(ePlr)
	for k,_ in pairs(initInvTabOLD) do --each inventory item gets a db entry, why? because it wouldnt let me store a whole table of items RIP
		local edata = getElementData(ePlr,k) --todo: figure out how to store a big table of items
		setAccountData(usrAcct, "line-z.inv_"..k, edata) --todo: figure out sqlite and DO MY OWN DATABASE QUERIES
	end
	for k,_ in pairs(initPlrTabOLD) do
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

--helper funcs
function randomSpawn() 																			--FUTR: add spawngroups (for randomization purposes)
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
	for k,v in pairs(skinTableOLD) do
		if (sID == v[1]) or (sID == v[2]) then
			return k
		end
	end
end
function deathHelper(ePlr) 																		--this is incredibly stupid i dont know why i moved all this here
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

--big ones
function createThing(ePlr,thingType) --TODO(33%): tents and fences --LOTS OF "MAGIC" HAPPENS HERE --it has to happen somewhere
---[[debug stuff
	outputChatBox("creating '"..tostring(thingType).."'") --]]
	local x,y,z = getElementPosition(ePlr)
			  z = z-0.77 --this should be the floor
	local _,_,r = getElementRotation(ePlr)
	local i,d,eCon,msLifetime,bInteract,tObj = getElementInterior(ePlr), --interior of player
										   getElementDimension(ePlr), --dimension of player
										   getPedContactElement(ePlr), --we standin on anything?
										   900000, --15 minutes
										   false, --default shit wont have an interact zone 
										   {} --table of new objects
	if thingType == "fireplace" then --todo: register fireplaces to players; make sure they can only have ONE (or two? who knows ill do this later)
		bInteract = true
		tObj[1] = createObjectEx(1463,x,y,z,0,0,r,i,d)
			setElementFrozen(tObj[1],true)
			--setElementCollisionsEnabled(tObj[1],false) --maybe figure out a way to stop the dynamic wood from busting apart WITHOUT REMOVING COLLISIONS
			setObjectScale(tObj[1],0.5)
		tObj[2] = createObjectEx(3525,x,y,z-0.77,0,0,r,i,d)
			setElementFrozen(tObj[2],true)
			setObjectScale(tObj[1],0.5)
			setElementCollisionsEnabled(tObj[2],false)
			setElementAlpha(tObj[2],0)
			setElementParent(tObj[2],tObj[1])
	elseif thingType == "tent" then --todo: register tents to players; maybe give them a locator blip (again max tents = 3? we'll see)
		msLifetime,bInteract = false,true --TENTS LIVE FOREVER AHAHAHAHAH
		tObj[1] = createObjectEx(3243,x,y,z,0,0,r,i,d)
			setObjectScale(tObj[1],0.5)
			setElementFrozen(tObj[1],true)
	elseif thingType == "fence" then --todo: register fences to players; im spotting a trend here (maybe secure fences in the future)
		msLifetime,bInteract = false,true --FENCES ALSO LIVE FOREVER (atleast until the server goes down RIP)
		tObj[1] = createObjectEx(983,x,y,z,0,0,r,i,d)
			--setObjectScale(tObj[1],1) --kept for posterity
			setElementFrozen(tObj[1],true)
	elseif thingType == "flare" then --flares will not register to players (i doubt flare spam will be a problem)
		msLifetime = 150000 --2.5 minutes
		tObj[1] = createObjectEx(354,x,y,z,0,0,r,i,d)
			setObjectScale(tObj[1],0.5)
			setElementFrozen(tObj[1],true)
	end
	if eCon then --this is awesome code but its probably going to break stuff if we let people do it on anything; update for futr
		local px,py,pz,rx,ry,rz = getAttachOffsets(tObj[1],eCon)
		attachElements(tObj[1],eCon,px,py,pz,rx,ry,rz)
		if thingType == "fireplace" then attachElements(tObj[2],eCon,px,py,pz-0.77,rx,ry,rz) end --anything made up of 2 objects or more will need a case down here FOR ALIGNMENT REASONS
		setElementParent(tObj[1],eCon) --we family now
		if bInteract then createLootZone(tObj[1],thingType,true) end --ATTACHED LOOT ZONES WHY
	elseif bInteract then
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

-- ? mysteries ? 
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
function getWeaponObjectID(weaponID)
  for i,weaponData in ipairs(weaponIDtoObjectIDOLD) do
    if weaponID == weaponData[1] then
      return weaponData[2]
    end
  end
end
function removeAttachedOnDeath(ePlr)
	if elementBackpack[ePlr] then
		detachElementFromBone(elementBackpack[ePlr])
		destroyElement(elementBackpack[ePlr])
	end
	if elementWeaponBack[ePlr] then
		detachElementFromBone(elementWeaponBack[ePlr])
		destroyElement(elementWeaponBack[ePlr])
		elementWeaponBack[ePlr] = false
	end
end
function backpackRemoveQuit(ePlr) 
	if elementBackpack[ePlr] then
		detachElementFromBone(elementBackpack[ePlr])
		destroyElement(elementBackpack[ePlr])
	end
	if elementWeaponBack[ePlr] then
		detachElementFromBone(elementWeaponBack[ePlr])
		destroyElement(elementWeaponBack[ePlr])
		elementWeaponBack[ePlr] = false
	end
end


--debug/admin funcs
function giveItemOLD(ePlr,...) --100% me
	local arge = {...}
	if not ePlr then return "usage: giveitem playername itemname [value]" end --begin insanity
	if not arge[1] then return "error: no item" end
	if not arge[2] then arge[2] = 1 end 
	local item,value = arge[1],arge[2]
	if arge[1]:sub(1,1) == "'" or arge[1]:sub(1,1) == "\"" then
		for k,v in ipairs(arge) do 
			if not (item == v) then item = item.." "..v end
			if v:sub(-1) == "'" or v:sub(-1) == "\"" then item = item:sub(2,-2); break end
		end		
	end
	if type(value) ~= "number" then value = 1 end
	local result = false
	for k,_ in pairs(initInvTabOLD) do if k == item then result = true; break end end 
	if not result then return "error: invalid item \""..tostring(item).."\"" end	
	value = math.floor(math.abs(value))	--no fractions, no subtractions
	setElementData(ePlr,item,getElementData(ePlr,item)+value) --ok we're good, give em the item
	return "gave "..value.." of \""..item.."\" to \""..getPlayerName(ePlr).."\" ("..tostring(ePlr)..")"
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
	triggerClientEvent(client,"cInvMasterRecv",client,invMaster) --send em invMaster
	spawnPlr(client) --WELCOME TO THE WASTELAND
	outputChatBox("Welcome to DIE", client) --PREPARE TO DIE
end
addEvent("onLoginTry", true)
addEventHandler("onLoginTry", root, loginHandler)

function rcsHandler(item,prop) --DONE(99%) FUTR: update to work with invMaster | stays
	local amt = itemCheck(source, item)
	if amt then
		if item == invMaster[501][1] or item == invMaster[506][1] then --water bottle || soda bottle
			local item2 = invMaster[620][1] --empty bottle
			local amt2 = getElementData(source, item2)
			if (not amt2) then
				amt2 = 0
			end
			setElementData(source, item2, amt2+1)
		elseif item == invMaster[502][1] or item == invMaster[503][1] then --beans can || pasta can
			local item2 = invMaster[621][1] --emtpy can
			local amt2 = getElementData(source, item2)
			if (not amt2) then
				amt2 = 0
			end
			setElementData(source, item2, amt2+1)
		end
		setElementData(source, item, amt-1)
		local bloodAdd
		for i=501,508 do --all food/drink
			if invMaster[i][1] == item then
				bloodAdd = invMaster[i][3]
			end
		end
		bloodAdd = bloodAdd + getElementData(source, "blood")
		if (bloodAdd) > 12000 then
			bloodAdd = 12000
		end		
		setElementData(source, prop, 100) --update stats (all food/drink brings you to 100% atm)
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
							  skinTableOLD[item][1]
		local amt2 = getElementData(source,oldName)
		if (not amt2) then
			amt2 = 0
		end
		triggerClientEvent(source,"hideInventoryManual",root)
		setElementModel(source, newID)
		setElementData(source, "skin", newID)
		setElementData(source, item, amt-1)
		setElementData(source, oldName, amt2+1)
	end
end
addEvent("onPlayerChangeSkin",true)
addEventHandler("onPlayerChangeSkin", root, skinHandler)

function refillHandler(item) --DONE(99%) FUTR: update to work with invMaster | stays
	local amt = itemCheck(source, item)
	if amt then 
		local item2 = invMaster[501][1] --water bottle 
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

function rearmHandler(item,slot) --testme(??%) FUTR: update to work with invMaster | stays 
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
	removeAttachedOnDeath(source)
end
addEvent("kilLDayZPlayer",true)
addEventHandler("kilLDayZPlayer", root, killHandler)


--COMMANDS
function playerRadioChat(playersource, cmd, ...)
  if cmd == "radiochat" then --superfluous
    local msg2 = table.concat({...}, " ")
    if getElementData(playersource, "Radio Device") or 0 <= 0 then
      outputChatBox("You got no Radio Device.", playersource)
      return 
    end
    local posX, posY, posZ = getElementPosition(playersource)
    local chatSphere = createColSphere(posX, posY, posZ, chatEadioRadius)
    local nearbyPlayers = getElementsWithinColShape(chatSphere, "player")
    destroyElement(chatSphere)
    for index,nearbyPlayer in ipairs(nearbyPlayers) do
      if getElementData(nearbyPlayer, "Radio Device") > 0 then
        outputChatBox("[RADIO DEVICE]" .. string.gsub(getPlayerName(playersource) .. " : " .. msg2, "#%x%x%x%x%x%x", ""), nearbyPlayer, 60, 200, 40, true)
      end
    end
  end
end
addCommandHandler("radiochat", playerRadioChat)
  --debug/admin stuff

addCommandHandler("giveitem", function(pSource,_,plrName,...) outputChatBox("giveitem "..giveItemOLD(getPlayerFromName(plrName or ""),...), pSource, 200, 60, 40) end, true) --items with spaces in their name are fucked i guess RIB
--addCommandHandler("spawnveh", spawnVehCommand,true)


--HOOKS
local function initHandler()
	local thisResource = getThisResource()
	if hasObjectPermissionTo(thisResource,"function.aclCreate") and 
	   hasObjectPermissionTo(thisResource,"function.aclSetRight") and
	   hasObjectPermissionTo(thisResource,"function.aclGroupAddObject") and
	   hasObjectPermissionTo(thisResource,"function.aclGroupAddACL") and
	   hasObjectPermissionTo(thisResource,"function.aclGroupRemoveObject") then
		if aclGet("line-z") and aclGetGroup("line-z admin") then
			outputServerLog("***acls loaded***")
			return true
		else
			outputServerLog("***creating acls***")
			local aclName, aclGroup = aclCreate("line-z"), aclCreateGroup("line-z admin")
			aclGroupAddACL(aclGroup, aclName)
			aclSetRight(aclName, "general.adminpanel", false)
			aclSetRight(aclName, "resource.line-z.adminpanel", true)
			aclSetRight(aclName, "command.giveitem", true)
			aclName = aclGet("Moderator") --this is all temp until i figure out what funcs i need
			if not aclName then outputDebugString("no general moderator acl") else
				aclGroupAddACL(aclGroup, aclName)
			end
			aclName = aclGet("SuperModerator")
			if not aclName then outputDebugString("no general supermoderator acl") else
				aclGroupAddACL(aclGroup, aclName)
			end
			aclName = aclGet("Admin")
			if not aclName then outputDebugString("no general admin acl") else
				aclGroupAddACL(aclGroup, aclName)
			end
			aclName = aclGet("RPC")
			if not aclName then outputDebugString("no general rpc acl") else
				aclGroupAddACL(aclGroup, aclName)
			end
			outputServerLog("***acls created***")
			aclSave()
			setTimer(function() exports.mapmanager:changeGamemode(exports.mapmanager:getRunningGamemode()) end, 650, 1)
			setTimer(function() outputServerLog("***acl initialization complete. add your username to \"line-z admins\" in acl.xml for admin access***") end, 1500, 1)
		end
	else
		outputServerLog("error: resource needs console level access in ACL to initialize")
		outputServerLog("add '<object name=\"resource.line-z\"></object>' to your acl.xml under 'console'")
		cancelEvent()
	end
end
addEventHandler("onResourceStart", resourceRoot, initHandler)

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
	backpackRemoveQuit(source)
	savePlrSpn(source)
	savePlrInv(source)	
	setAccountData(usrAcct, "line-z.sav", 1) --PLAYER INVENTORY IS NOW SAFE
	logOut(source) --GOODBYE
end
addEventHandler("onPlayerQuit", root, quitHandler)

function deathHandler(tot,atk,wpn,bp,bStealth) 
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

function exitHandler() 
	--kicking all players isnt a problem because it calls quithandler on all of them NOICE
	local players = getElementsByType("player")
	for k,v in ipairs(players) do
		kickPlayer (v, "server shutting down.")
	end
end
addEventHandler ("onResourceStop", resourceRoot, exitHandler)

function sendMessageToNearbyPlayers(message, messageType)
  cancelEvent()
	if messageType == 1 then
		return
	elseif messageType == 0 then
		local posX, posY, posZ = getElementPosition(source)
		local chatSphere = createColSphere(posX, posY, posZ, chatRadius)
		local nearbyPlayers = getElementsWithinColShape(chatSphere, "player")
		destroyElement(chatSphere)
		for index,nearbyPlayer in ipairs(nearbyPlayers) do
			outputChatBox("[LOCAL]" .. string.gsub(getPlayerName(source) .. " : " .. message, "#%x%x%x%x%x%x", ""), nearbyPlayer, 60, 200, 40, true)
		end
	end
end
addEventHandler("onPlayerChat", getRootElement(), sendMessageToNearbyPlayers)


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
  --BEGIN: borrow
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

function checkBandit()
	for i,player in ipairs(getElementsByType("player")) do --get all players
		if getElementData(player, "auth") then --check if player is auth
			local current = getElementData(player, "skin") --get current skin
			if getElementData(player, "bandit") then --if they are a bandit
				if current == 179 or current == 287 then --and arent the correct skin
					setElementModel(player, 288) --skin them
				elseif current == 73 then --but if theyre standard skin
					setElementModel(player, 180) --make em a different bandit
				end
			else --if they are not a bandit
				if getElementData(player, "humanity") == 5000 and (current == 73 or current == 179 or current == 287) then --check if they are a hero
					setElementModel(player, 210) --and make them look the part
				end --otherwise
				setElementModel(player, current) --reset them back to their normal skin
			end
		end
    end
end
setTimer(checkBandit, 20000, 0)
  --END
  
---[[unsorted borrow begin
function backPackBack(dataName, oldValue)
    if getElementType(source) == "player" and dataName == "MAX_Slots" then
    local newValue = getElementData(source, dataName)
    if elementBackpack[source] then
      detachElementFromBone(elementBackpack[source])
      destroyElement(elementBackpack[source])
      elementBackpack[source] = false
    end
    local x, y, z = getElementPosition(source)
    local rx, ry, rz = getElementRotation(source)
    if newValue == 16 then
      elementBackpack[source] = createObject(3026, x, y, z)
    elseif newValue == 28 then
      elementBackpack[source] = createObject(1248, x, y, z)
    elseif newValue == 36 then
      elementBackpack[source] = createObject(1252, x, y, z)
    elseif newValue == 10 then
      return 
    end
    attachElementToBone(elementBackpack[source], source, 3, 0, -0.225, 0.05, 90, 0, 0)
  end
end
function weaponDelete(dataName, oldValue)
	if getElementType(source) == "player" then
		local weapon1 = getElementData(source, "currentweapon_1")
		local weapon2 = getElementData(source, "currentweapon_2")
		local weapon3 = getElementData(source, "currentweapon_3")
		if (dataName == weapon1 or dataName == weapon2 or dataName == weapon3) and getElementData(source, dataName) == 0 then
			local ammoData, weapID = getWeaponAmmoType(dataName)
			takeWeapon(source, weapID)
		end
		local weapon1 = getElementData(source, "currentweapon_1")
		local weapon2 = getElementData(source, "currentweapon_2")
		local weapon3 = getElementData(source, "currentweapon_3")
		local ammoData1, weapID1 = getWeaponAmmoType(weapon1)
		local ammoData2, weapID2 = getWeaponAmmoType(weapon2)
		local ammoData3, weapID3 = getWeaponAmmoType(weapon3)
		if dataName == ammoData1 then
			local newammo = oldValue - getElementData(source, dataName)
			if newammo == 1 then
				return 
			end
			if getElementData(source, dataName) < oldValue then
				takeWeapon(source, weapID1, newammo)
			end
			if elementWeaponBack[source] then
				detachElementFromBone(elementWeaponBack[source])
				destroyElement(elementWeaponBack[source])
				elementWeaponBack[source] = false
			end
		else
			if oldValue < getElementData(source, dataName) then
				giveWeapon(source, weapID1, getElementData(source, dataName) - oldValue, true)
			end
		end
		if dataName == ammoData2 then
			local newammo = oldValue - getElementData(source, dataName)
			if newammo == 1 then
				return 
			end
			if getElementData(source, dataName) < oldValue then
				takeWeapon(source, weapID2, newammo)
			end
		else
			if oldValue < getElementData(source, dataName) then
				giveWeapon(source, weapID2, getElementData(source, dataName) - oldValue, false)
			end
		end
	end
	if dataName == ammoData3 then
		local newammo = oldValue - getElementData(source, dataName)
		if newammo == 1 then
			return 
		end
		if getElementData(source, dataName) < oldValue then
			takeWeapon(source, weapID3, newammo)
		end
	else
		if oldValue < getElementData(source, dataName) then
			giveWeapon(source, weapID3, getElementData(source, dataName) - oldValue, false)
		end
	end
end
--addEventHandler("onElementDataChange", getRootElement(), backPackBack) --this is horrible
--addEventHandler("onElementDataChange", getRootElement(), weaponDelete) --this is also horrible

function weaponSwitchBack(previousWeaponID, currentWeaponID)
	local weapon1 = getElementData(source, "currentweapon_1")
	if not weapon1 then
		return 
	end
	local ammoData1, weapID1 = getWeaponAmmoType(weapon1)
	local x, y, z = getElementPosition(source)
	local rx, ry, rz = getElementRotation(source)
	if previousWeaponID == weapID1 then
		if elementWeaponBack[source] then
			detachElementFromBone(elementWeaponBack[source])
			destroyElement(elementWeaponBack[source])
			elementWeaponBack[source] = false
		end
		elementWeaponBack[source] = createObject(getWeaponObjectID(weapID1), x, y, z)
		setObjectScale(elementWeaponBack[source], 0.875)
		if elementBackpack[source] then
			attachElementToBone(elementWeaponBack[source], source, 3, 0.19, -0.31, -0.1, 0, 270, -90)
		else
			attachElementToBone(elementWeaponBack[source], source, 3, 0.19, -0.11, -0.1, 0, 270, 10)
		end
	elseif currentWeaponID == weapID1 then
		detachElementFromBone(elementWeaponBack[source])
		destroyElement(elementWeaponBack[source])
		elementWeaponBack[source] = false
	end
end
addEventHandler("onPlayerWeaponSwitch", getRootElement(), weaponSwitchBack)

function removeBackWeaponOnDrop()
	if elementWeaponBack[source] then
		detachElementFromBone(elementWeaponBack[source])
		destroyElement(elementWeaponBack[source])
		elementWeaponBack[source] = false
	end
end
addEvent("removeBackWeaponOnDrop", true)
addEventHandler("removeBackWeaponOnDrop", getRootElement(), removeBackWeaponOnDrop)


--[[
function blockChatMessage(m, mt)
  if mt == 1 then
    cancelEvent()
  end
end
--]]
--addEventHandler("onPlayerChat", getRootElement(), blockChatMessage)

--]]


--[[debug stuff
	--nothing for now 
--]]
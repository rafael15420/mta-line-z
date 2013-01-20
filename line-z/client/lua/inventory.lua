--[[
#---------------------------------------------------------------#
----*			DayZ MTA Script inventory.lua			*----
----* 
----* i couldnt think of anything funny to say here
----*  todo: make me graphical and to spec
----*				also iterators							*----
#---------------------------------------------------------------#
]]

inventoryItems = {
	["Weapons"] = {
		["Primary Weapon"] = {
			{"M4",3}, --name,slot count
			{"Sniper Rifle",3},
			{"Shotgun",3},
			{"SPAZ-12 Combat Shotgun",3},
			{"Sawn-Off Shotgun",3},
			{"AK-47",3},
			{"Heat-Seeking RPG",5},
			{"Rocket Launcher",5},
			{"Country Rifle",3},
		},
		["Secondary Weapon"] = {
			{"Pistol",2},
			{"Silenced Pistol",2},
			{"Uzi",2},
			{"TEC-9",2},
			{"MP5",3},
			{"Desert Eagle",2},
			{"Knife",1},
			{"Katana",2},
		},
		["Specially Weapon"] = {
			{"Parachute",1},
			{"Tear Gas",1},
			{"Grenade",1},
		},
	},
	["Ammo"] = {
		{"Rocket Ammo",2},
		{"Sniper Ammo",0.1},
		{"Smg Ammo",0.025},
		{"Assault Ammo",0.035},
		{"Pistol Ammo",0.085},
		{"Shotgun Ammo",0.067},
	},
	["Food"] = {
		{"Water Bottle",1},
		{"Pasta Can",1},
		{"Beans Can",1},
		{"Burger",1},
		{"Pizza",1},
		{"Soda Bottle",1},
		{"Milk",1},
		{"Cooked Meat",1},
	},
	["Items"] = {
		{"Wood",2},
		{"Bandage",1,"Bandage myself"},
		{"Roadflare",1,"Place"},
		{"Empty Patrol Canister",2},
		{"Full Patrol Canister",2},
		{"Medic Kit",2,"Use"},
		{"Heat Pack",1,"Use"},
		{"Painkiller",1,"Use"},
		{"Morphine",1,"Use"},
		{"Blood Bag",1,"Use"},
		{"Wire Fence",1,"Build a wire fence"},
		{"Raw Meat",1},
		{"Tire",2},
		{"Engine",5},
		{"Tent",3,"Pitch a tent"},
		{"Army Skin",1,"Use Skin"},
		{"Civilian Skin",1,"Use Skin"},
		{"Standart Skin",1,"Use Skin"},
		{"Sniper Skin",1,"Use Skin"},
		{"Empty Bottle",1,"Fill Water"},
		{"Tin Can",1},
		{"Scruffy Burgers",1},
		{"Alice Backpack",1},
		{"Small Backpack",1},
		{"Coyote Backpack",1},
	},
	["Toolbelt"] = {
		{"Night Vision Goggles",1},
		{"Infrared Goggles",1},
		{"Map",1},
		{"Lighter",1,"Make a Fire"},
		{"Watch",1},
		{"GPS",1},
		{"Toolbox",1},
		{"Binocular",1},
		{"Radio Device",1},
	},
}


------------------------------------------------------------------------------
--INVENTORY this is a gui element
local headline = {}
local gridlistItems = {}
local buttonItems = {}



	inventoryWindows = guiCreateStaticImage(0.25,0.25,0.5,0.5,"client/image/scrollmenu_1.png",true)

	headline["loot"] = guiCreateLabel(0,0.05,0.4,0.1,"Empty",true,inventoryWindows)
	guiLabelSetHorizontalAlign (headline["loot"],"center")
	guiSetFont (headline["loot"], "default-bold-small" )

	headline["inventory"] = guiCreateLabel(0.6,0.05,0.4,0.1,"Inventory",true,inventoryWindows)
	guiLabelSetHorizontalAlign (headline["inventory"],"center")
	guiSetFont (headline["inventory"], "default-bold-small" )

	gridlistItems["loot"] = guiCreateGridList (0.05,0.1,0.35,0.8,true,inventoryWindows)
	gridlistItems["loot_colum"] = guiGridListAddColumn( gridlistItems["loot"], "Items", 0.7 )
	gridlistItems["loot_colum_amount"] = guiGridListAddColumn( gridlistItems["loot"], "", 0.2 )

	gridlistItems["inventory"] = guiCreateGridList (0.6,0.1,0.35,0.8,true,inventoryWindows)
	gridlistItems["inventory_colum"] = guiGridListAddColumn( gridlistItems["inventory"], "Items", 0.7 )
	gridlistItems["inventory_colum_amount"] = guiGridListAddColumn( gridlistItems["inventory"], "", 0.2 )

	buttonItems["loot"] = guiCreateButton(0.4,0.1,0.05,0.8, ">", true,inventoryWindows)
	buttonItems["inventory"] = guiCreateButton(0.55,0.1,0.05,0.8, "<", true,inventoryWindows)

	headline["slots"] = guiCreateLabel(0.6,0.95,0.35,0.05,"Used Slots:",true,inventoryWindows)
	guiLabelSetHorizontalAlign (headline["slots"],"center")
	guiLabelSetVerticalAlign (headline["slots"],"center")
	guiSetFont (headline["slots"], "default-bold-small" )

	headline["slots_loot"] = guiCreateLabel(0.05,0.95,0.35,0.05,"Used Slots:",true,inventoryWindows)
	guiLabelSetHorizontalAlign (headline["slots_loot"],"center")
	guiLabelSetVerticalAlign (headline["slots_loot"],"center")
	guiSetFont (headline["slots_loot"], "default-bold-small" )

	guiSetVisible(inventoryWindows,false)



function showInventory ()
	if getElementData(localPlayer,"auth") then
		guiSetVisible(inventoryWindows,not guiGetVisible(inventoryWindows))
		showCursor(not isCursorShowing())
		refreshInventory()
		if guiGetVisible(inventoryWindows) == true then
			onClientOpenInventoryStopMenu ()
		else
			hideRightClickInventoryMenu ()
		end
		if isPlayerInLoot() then
			local col = getElementData(localPlayer,"currentCol")
			local gearName = getElementData(localPlayer,"lootname")
			refreshLoot(col,gearName)
		end
	end	
end
addCommandHandler("invShow", showInventory, false)
bindKey ("j", "down", "invShow","")







function showInventoryManual ()
		guiSetVisible(inventoryWindows,not guiGetVisible(inventoryWindows))
		showCursor(not isCursorShowing())
		refreshInventory()
		if guiGetVisible(inventoryWindows) == true then
			onClientOpenInventoryStopMenu ()
		end
end

function hideInventoryManual ()
		guiSetVisible(inventoryWindows,false)
		showCursor(false)
		hideRightClickInventoryMenu ()
end
addEvent("hideInventoryManual",true)
addEventHandler("hideInventoryManual",localPlayer,hideInventoryManual)

function refreshInventoryManual ()
		refreshInventory()
end
addEvent("refreshInventoryManual",true)
addEventHandler("refreshInventoryManual",localPlayer,refreshInventoryManual)

function refreshLootManual (loot)
		refreshLoot(loot)
end
addEvent("refreshLootManual",true)
addEventHandler("refreshLootManual",localPlayer,refreshLootManual)

function refreshInventory() 
	if ( gridlistItems["inventory_colum"] ) then --If the column has been created, fill it with players
		row1,column1 = guiGridListGetSelectedItem ( gridlistItems["inventory"] )
		guiGridListClear(gridlistItems["inventory"])
		local row = guiGridListAddRow ( gridlistItems["inventory"] )
		guiGridListSetItemText ( gridlistItems["inventory"], row, gridlistItems["inventory_colum"],"Weapons", true, false )
		local row = guiGridListAddRow ( gridlistItems["inventory"] )
		guiGridListSetItemText ( gridlistItems["inventory"], row, gridlistItems["inventory_colum"],"- Primary Weapon", true, false )
		for id, item in ipairs(inventoryItems["Weapons"]["Primary Weapon"]) do
			if getElementData(localPlayer,item[1]) and getElementData(localPlayer,item[1]) >= 1 then
				local row = guiGridListAddRow ( gridlistItems["inventory"] )
				guiGridListSetItemText ( gridlistItems["inventory"], row, gridlistItems["inventory_colum"],item[1], false, false )
				guiGridListSetItemText ( gridlistItems["inventory"], row, gridlistItems["inventory_colum_amount"],getElementData(localPlayer,item[1]), false, false )
			end
		end
		local row = guiGridListAddRow ( gridlistItems["inventory"] )
		guiGridListSetItemText ( gridlistItems["inventory"], row, gridlistItems["inventory_colum"],"- Secondary Weapon", true, false )
		for id, item in ipairs(inventoryItems["Weapons"]["Secondary Weapon"]) do
			if getElementData(localPlayer,item[1]) and getElementData(localPlayer,item[1]) >= 1 then
				local row = guiGridListAddRow ( gridlistItems["inventory"] )
				guiGridListSetItemText ( gridlistItems["inventory"], row, gridlistItems["inventory_colum"],item[1], false, false )
				guiGridListSetItemText ( gridlistItems["inventory"], row, gridlistItems["inventory_colum_amount"],getElementData(localPlayer,item[1]), false, false )
			end
		end
		local row = guiGridListAddRow ( gridlistItems["inventory"] )
		guiGridListSetItemText ( gridlistItems["inventory"], row, gridlistItems["inventory_colum"],"- Specially Weapon", true, false )
		for id, item in ipairs(inventoryItems["Weapons"]["Specially Weapon"]) do
			if getElementData(localPlayer,item[1]) and getElementData(localPlayer,item[1]) >= 1 then
				local row = guiGridListAddRow ( gridlistItems["inventory"] )
				guiGridListSetItemText ( gridlistItems["inventory"], row, gridlistItems["inventory_colum"],item[1], false, false )
				guiGridListSetItemText ( gridlistItems["inventory"], row, gridlistItems["inventory_colum_amount"],getElementData(localPlayer,item[1]), false, false )
			end
		end
		local row = guiGridListAddRow ( gridlistItems["inventory"] )
		guiGridListSetItemText ( gridlistItems["inventory"], row, gridlistItems["inventory_colum"],"Ammo", true, false )
		for id, item in ipairs(inventoryItems["Ammo"]) do
			if getElementData(localPlayer,item[1]) and getElementData(localPlayer,item[1]) >= 1 then
				local row = guiGridListAddRow ( gridlistItems["inventory"] )
				guiGridListSetItemText ( gridlistItems["inventory"], row, gridlistItems["inventory_colum"],item[1], false, false )
				guiGridListSetItemText ( gridlistItems["inventory"], row, gridlistItems["inventory_colum_amount"],getElementData(localPlayer,item[1]), false, false )
			end
		end
		local row = guiGridListAddRow ( gridlistItems["inventory"] )
		guiGridListSetItemText ( gridlistItems["inventory"], row, gridlistItems["inventory_colum"],"Food", true, false )
		for id, item in ipairs(inventoryItems["Food"]) do
			if getElementData(localPlayer,item[1]) and getElementData(localPlayer,item[1]) >= 1 then
				local row = guiGridListAddRow ( gridlistItems["inventory"] )
				guiGridListSetItemText ( gridlistItems["inventory"], row, gridlistItems["inventory_colum"],item[1], false, false )
				guiGridListSetItemText ( gridlistItems["inventory"], row, gridlistItems["inventory_colum_amount"],getElementData(localPlayer,item[1]), false, false )
			end
		end
		local row = guiGridListAddRow ( gridlistItems["inventory"] )
		guiGridListSetItemText ( gridlistItems["inventory"], row, gridlistItems["inventory_colum"],"Items", true, false )
		for id, item in ipairs(inventoryItems["Items"]) do
			if getElementData(localPlayer,item[1]) and getElementData(localPlayer,item[1]) >= 1 then
				local row = guiGridListAddRow ( gridlistItems["inventory"] )
				guiGridListSetItemText ( gridlistItems["inventory"], row, gridlistItems["inventory_colum"],item[1], false, false )
				guiGridListSetItemText ( gridlistItems["inventory"], row, gridlistItems["inventory_colum_amount"],getElementData(localPlayer,item[1]), false, false )
			end
		end
		local row = guiGridListAddRow ( gridlistItems["inventory"] )
		guiGridListSetItemText ( gridlistItems["inventory"], row, gridlistItems["inventory_colum"],"Toolbelt", true, false )
		for id, item in ipairs(inventoryItems["Toolbelt"]) do
			if getElementData(localPlayer,item[1]) and getElementData(localPlayer,item[1]) >= 1 then
				local row = guiGridListAddRow ( gridlistItems["inventory"] )
				guiGridListSetItemText ( gridlistItems["inventory"], row, gridlistItems["inventory_colum"],item[1], false, false )
				guiGridListSetItemText ( gridlistItems["inventory"], row, gridlistItems["inventory_colum_amount"],getElementData(localPlayer,item[1]), false, false )
			end
		end
		if row1 and column1 then
			guiGridListSetSelectedItem ( gridlistItems["inventory"], row1,column1)
		end
		guiSetText(headline["slots"],"Used Slots: "..getPlayerCurrentSlots().."/"..getPlayerMaxAviableSlots())
	end
end

function refreshLoot(loot,gearName)
if loot == false then
	guiGridListClear(gridlistItems["loot"])
	guiSetText(headline["loot"],"Empty")
	return
end
if ( gridlistItems["loot_colum"] ) then
	row2,column2 = guiGridListGetSelectedItem ( gridlistItems["inventory"] )
	guiGridListClear(gridlistItems["loot"])
	if gearName then
		guiSetText(headline["loot"],gearName)
	end	
			local row = guiGridListAddRow ( gridlistItems["loot"] )
			guiGridListSetItemText ( gridlistItems["loot"], row, gridlistItems["loot_colum"],"Weapons", true, false )
			local row = guiGridListAddRow ( gridlistItems["loot"] )
			guiGridListSetItemText ( gridlistItems["loot"], row, gridlistItems["loot_colum"],"- Primary Weapon", true, false )
		for id, item in ipairs(inventoryItems["Weapons"]["Primary Weapon"]) do
			if getElementData(loot,item[1]) and getElementData(loot,item[1]) >= 1 then
				local row = guiGridListAddRow ( gridlistItems["loot"] )
				guiGridListSetItemText ( gridlistItems["loot"], row, gridlistItems["loot_colum"],item[1], false, false )
				guiGridListSetItemText ( gridlistItems["loot"], row, gridlistItems["loot_colum_amount"],getElementData(loot,item[1]), false, false )
			end
		end
				local row = guiGridListAddRow ( gridlistItems["loot"] )
			guiGridListSetItemText ( gridlistItems["loot"], row, gridlistItems["loot_colum"],"- Secondary Weapon", true, false )
		for id, item in ipairs(inventoryItems["Weapons"]["Secondary Weapon"]) do
			if getElementData(loot,item[1]) and getElementData(loot,item[1]) >= 1 then
				local row = guiGridListAddRow ( gridlistItems["loot"] )
				guiGridListSetItemText ( gridlistItems["loot"], row, gridlistItems["loot_colum"],item[1], false, false )
				guiGridListSetItemText ( gridlistItems["loot"], row, gridlistItems["loot_colum_amount"],getElementData(loot,item[1]), false, false )
			end
		end
			local row = guiGridListAddRow ( gridlistItems["loot"] )
			guiGridListSetItemText ( gridlistItems["loot"], row, gridlistItems["loot_colum"],"- Specially Weapon", true, false )
		for id, item in ipairs(inventoryItems["Weapons"]["Specially Weapon"]) do
			if getElementData(loot,item[1]) and getElementData(loot,item[1]) >= 1 then
				local row = guiGridListAddRow ( gridlistItems["loot"] )
				guiGridListSetItemText ( gridlistItems["loot"], row, gridlistItems["loot_colum"],item[1], false, false )
				guiGridListSetItemText ( gridlistItems["loot"], row, gridlistItems["loot_colum_amount"],getElementData(loot,item[1]), false, false )
			end
		end
			local row = guiGridListAddRow ( gridlistItems["loot"] )
			guiGridListSetItemText ( gridlistItems["loot"], row, gridlistItems["loot_colum"],"Ammo", true, false )
		for id, item in ipairs(inventoryItems["Ammo"]) do
			if getElementData(loot,item[1]) and getElementData(loot,item[1]) >= 1 then
				local row = guiGridListAddRow ( gridlistItems["loot"] )
				guiGridListSetItemText ( gridlistItems["loot"], row, gridlistItems["loot_colum"],item[1], false, false )
				guiGridListSetItemText ( gridlistItems["loot"], row, gridlistItems["loot_colum_amount"],getElementData(loot,item[1]), false, false )
			end
		end
			local row = guiGridListAddRow ( gridlistItems["loot"] )
			guiGridListSetItemText ( gridlistItems["loot"], row, gridlistItems["loot_colum"],"Food", true, false )
		for id, item in ipairs(inventoryItems["Food"]) do
			if getElementData(loot,item[1]) and getElementData(loot,item[1]) >= 1 then
				local row = guiGridListAddRow ( gridlistItems["loot"] )
				guiGridListSetItemText ( gridlistItems["loot"], row, gridlistItems["loot_colum"],item[1], false, false )
				guiGridListSetItemText ( gridlistItems["loot"], row, gridlistItems["loot_colum_amount"],getElementData(loot,item[1]), false, false )
			end
		end
			local row = guiGridListAddRow ( gridlistItems["loot"] )
			guiGridListSetItemText ( gridlistItems["loot"], row, gridlistItems["loot_colum"],"Toolbelt", true, false )
		for id, item in ipairs(inventoryItems["Toolbelt"]) do
			if getElementData(loot,item[1]) and getElementData(loot,item[1]) >= 1 then
				local row = guiGridListAddRow ( gridlistItems["loot"] )
				guiGridListSetItemText ( gridlistItems["loot"], row, gridlistItems["loot_colum"],item[1], false, false )
				guiGridListSetItemText ( gridlistItems["loot"], row, gridlistItems["loot_colum_amount"],getElementData(loot,item[1]), false, false )
			end
		end
			local row = guiGridListAddRow ( gridlistItems["loot"] )
			guiGridListSetItemText ( gridlistItems["loot"], row, gridlistItems["loot_colum"],"Items", true, false )
		for id, item in ipairs(inventoryItems["Items"]) do
			if getElementData(loot,item[1]) and getElementData(loot,item[1]) >= 1 then
				local row = guiGridListAddRow ( gridlistItems["loot"] )
				guiGridListSetItemText ( gridlistItems["loot"], row, gridlistItems["loot_colum"],item[1], false, false )
				guiGridListSetItemText ( gridlistItems["loot"], row, gridlistItems["loot_colum_amount"],getElementData(loot,item[1]), false, false )
			end
		end
		if row2 and column2 then
			--guiGridListSetSelectedItem ( gridlistItems["loot"], row2,column2)
		end
		guiSetText(headline["slots_loot"],"Used Slots: "..getLootCurrentSlots(loot).."/"..(getLootMaxAviableSlots(loot)or 0))
	end
end


function getPlayerMaxAviableSlots()
return getElementData(localPlayer,"MAX_Slots")
end

function getLootMaxAviableSlots(loot)
return getElementData(loot,"MAX_Slots")
end

function getPlayerCurrentSlots()
local current_SLOTS = 0
	for id, item in ipairs(inventoryItems["Weapons"]["Primary Weapon"]) do
		if getElementData(localPlayer,item[1]) and getElementData(localPlayer,item[1]) >= 1 then
			current_SLOTS = current_SLOTS + item[2]*getElementData(localPlayer,item[1])
		end
	end
	for id, item in ipairs(inventoryItems["Weapons"]["Secondary Weapon"]) do
		if getElementData(localPlayer,item[1]) and getElementData(localPlayer,item[1]) >= 1 then
			current_SLOTS = current_SLOTS + item[2]*getElementData(localPlayer,item[1])
		end
	end
	for id, item in ipairs(inventoryItems["Weapons"]["Specially Weapon"]) do
		if getElementData(localPlayer,item[1]) and getElementData(localPlayer,item[1]) >= 1 then
			current_SLOTS = current_SLOTS + item[2]*getElementData(localPlayer,item[1])
		end
	end
	for id, item in ipairs(inventoryItems["Ammo"]) do
		if getElementData(localPlayer,item[1]) and getElementData(localPlayer,item[1]) >= 1 then
			current_SLOTS = current_SLOTS + item[2]*getElementData(localPlayer,item[1])
		end
	end
	for id, item in ipairs(inventoryItems["Food"]) do
		if getElementData(localPlayer,item[1]) and getElementData(localPlayer,item[1]) >= 1 then
			current_SLOTS = current_SLOTS + item[2]*getElementData(localPlayer,item[1])
		end
	end
	for id, item in ipairs(inventoryItems["Items"]) do
		if getElementData(localPlayer,item[1]) and getElementData(localPlayer,item[1]) >= 1 then
			current_SLOTS = current_SLOTS + item[2]*getElementData(localPlayer,item[1])
		end
	end
	return math.floor(current_SLOTS)
end


function getLootCurrentSlots(loot)
local current_SLOTS = 0
	for id, item in ipairs(inventoryItems["Weapons"]["Primary Weapon"]) do
		if getElementData(loot,item[1]) and getElementData(loot,item[1]) >= 1 then
			current_SLOTS = current_SLOTS + item[2]*getElementData(loot,item[1])
		end
	end
	for id, item in ipairs(inventoryItems["Weapons"]["Secondary Weapon"]) do
		if getElementData(loot,item[1]) and getElementData(loot,item[1]) >= 1 then
			current_SLOTS = current_SLOTS + item[2]*getElementData(loot,item[1])
		end
	end
	for id, item in ipairs(inventoryItems["Weapons"]["Specially Weapon"]) do
		if getElementData(loot,item[1]) and getElementData(loot,item[1]) >= 1 then
			current_SLOTS = current_SLOTS + item[2]*getElementData(loot,item[1])
		end
	end
	for id, item in ipairs(inventoryItems["Ammo"]) do
		if getElementData(loot,item[1]) and getElementData(loot,item[1]) >= 1 then
			current_SLOTS = current_SLOTS + item[2]*getElementData(loot,item[1])
		end
	end
	for id, item in ipairs(inventoryItems["Food"]) do
		if getElementData(loot,item[1]) and getElementData(loot,item[1]) >= 1 then
			current_SLOTS = current_SLOTS + item[2]*getElementData(loot,item[1])
		end
	end
	for id, item in ipairs(inventoryItems["Items"]) do
		if getElementData(loot,item[1]) and getElementData(loot,item[1]) >= 1 then
			current_SLOTS = current_SLOTS + item[2]*getElementData(loot,item[1])
		end
	end
	return math.floor(current_SLOTS)
end

function getItemSlots(itema)
local current_SLOTS = 0
	for id, item in ipairs(inventoryItems["Weapons"]["Primary Weapon"]) do
		if itema == item[1] then 
			return item[2]
		end
	end	
	for id, item in ipairs(inventoryItems["Weapons"]["Secondary Weapon"]) do
		if itema == item[1] then 
			return item[2]
		end
	end	
	for id, item in ipairs(inventoryItems["Weapons"]["Specially Weapon"]) do
		if itema == item[1] then 
			return item[2]
		end
	end	
	for id, item in ipairs(inventoryItems["Ammo"]) do
		if itema == item[1] then 
			return item[2]
		end
	end
	for id, item in ipairs(inventoryItems["Food"]) do
		if itema == item[1] then 
			return item[2]
		end
	end
	for id, item in ipairs(inventoryItems["Items"]) do
		if itema == item[1] then 
			return item[2]
		end
	end
	return false
end

function isToolbeltItem(itema)
local current_SLOTS = 0
	for id, item in ipairs(inventoryItems["Toolbelt"]) do
		if itema == item[1] then 
			return true
		end
	end	
	return false
end

vehicleAddonsInfo = { --this is a table of { vehicle Model ID, # of tires, # of engines }
--MAYBE: centralized table on server, clients download table info on join (prob. not)
--WHY: is this here?
{422,4,1}, --Bobcat
{470,4,1}, --Patriot
{468,2,1}, --Sanchez
{433,6,1}, --Barracks
{437,6,1}, --Coach
{509,0,0}, --Bike
{487,0,1}, --Maverick (h)
{497,0,1}, --Police Maverick (h)
{453,0,1}, --Reefer
}

function getVehicleAddonInfos (id)
	for i,veh in ipairs(vehicleAddonsInfo) do
		if veh[1] == id then
			return veh[2],veh[3]
		end
	end
end

function onPlayerMoveItemOutOfInventory (btn,pos)
	if ((btn == "left") and (pos == "up")) then
		if playerMovedInInventory then displayClientInfo("Inventory", "Abuser will get banned.", 255, 22, 0 ) return end
		local itemName = guiGridListGetItemText ( gridlistItems["inventory"], guiGridListGetSelectedItem ( gridlistItems["inventory"] ), 1 )
		if getElementData(localPlayer,itemName) and getElementData(localPlayer,itemName) >= 1 then
			if isPlayerInLoot() then
				local isVehicle = getElementData(isPlayerInLoot(),"vehicle")
				local isTent = getElementData(isPlayerInLoot(),"tent")
				if isVehicle and not isTent then
					local veh = getElementData(isPlayerInLoot(),"parent")
					local tires,engine = getVehicleAddonInfos (getElementModel(veh))
					if itemName == "Tire" and (getElementData(isPlayerInLoot(),"Tire_inVehicle") or 0) < tires  or itemName == "Engine" and (getElementData(isPlayerInLoot(),"Engine_inVehicle") or 0)  < engine then
						triggerServerEvent("onPlayerMoveItemOutOFInventory",localPlayer,itemName.."_inVehicle",isPlayerInLoot())
						playerMovedInInventory = true
						setTimer(function()
							playerMovedInInventory = false
						end,700,1)
					elseif isToolbeltItem(itemName) then
						triggerServerEvent("onPlayerMoveItemOutOFInventory",localPlayer,itemName,isPlayerInLoot())
						playerMovedInInventory = true
						setTimer(function()
							playerMovedInInventory = false
						end,700,1)
					elseif getLootCurrentSlots(getElementData(localPlayer,"currentCol")) + getItemSlots(itemName) <= getLootMaxAviableSlots(isPlayerInLoot()) then
						triggerServerEvent("onPlayerMoveItemOutOFInventory",localPlayer,itemName,isPlayerInLoot())
						playerMovedInInventory = true
						setTimer(function()
							playerMovedInInventory = false
						end,700,1)
					else
						displayClientInfo("Inventory", "The Gear is to full", 255, 22, 0 )
						return
					end
				elseif isToolbeltItem(itemName) then
					triggerServerEvent("onPlayerMoveItemOutOFInventory",localPlayer,itemName,isPlayerInLoot())	
					playerMovedInInventory = true
					setTimer(function()
						playerMovedInInventory = false
					end,700,1)
				elseif getLootCurrentSlots(getElementData(localPlayer,"currentCol")) + getItemSlots(itemName) <= getLootMaxAviableSlots(isPlayerInLoot()) then
					triggerServerEvent("onPlayerMoveItemOutOFInventory",localPlayer,itemName,isPlayerInLoot())
					playerMovedInInventory = true
					setTimer(function()
						playerMovedInInventory = false
					end,700,1)
				else
					displayClientInfo("Inventory", "The Gear is to full", 255, 22, 0 )
					return
				end	
			else
				triggerServerEvent("onPlayerMoveItemOutOFInventory",localPlayer,itemName,isPlayerInLoot())
				playerMovedInInventory = true
				setTimer(function()
					playerMovedInInventory = false
				end,700,1)
			end	
		end
		local gearName = guiGetText(headline["loot"])
		local col = getElementData(localPlayer,"currentCol")
		setTimer(refreshInventory,200,2)
		if isPlayerInLoot() then
			setTimer(refreshLoot,200,2,col,gearName)
		end
	end
end
addEventHandler ( "onClientGUIClick", buttonItems["inventory"], onPlayerMoveItemOutOfInventory )

function onPlayerMoveItemInInventory (btn,pos)
	if ((btn == "left") and (pos == "up")) then
		local itemName = guiGridListGetItemText ( gridlistItems["loot"], guiGridListGetSelectedItem ( gridlistItems["loot"] ), 1 )
		if isPlayerInLoot() then
			if getElementData(isPlayerInLoot(),itemName) and getElementData(isPlayerInLoot(),itemName) >= 1 then
				if not isToolbeltItem(itemName) then
					if getPlayerCurrentSlots() + getItemSlots(itemName) <= getPlayerMaxAviableSlots() then
						if not playerMovedInInventory then
							triggerServerEvent("onPlayerMoveItemInInventory",localPlayer,itemName,isPlayerInLoot())
							playerMovedInInventory = true
							setTimer(function()
								playerMovedInInventory = false
							end,700,1)
						else
							displayClientInfo("Inventory", "Abuser will get banned.", 255, 22, 0 )
							return
						end	
					else
						displayClientInfo("Inventory", "Your Inventory is to full", 255, 22, 0 )
						return
					end
				else
					playerMovedInInventory = true
					setTimer(function()
						playerMovedInInventory = false
					end,700,1)
					triggerServerEvent("onPlayerMoveItemInInventory",localPlayer,itemName,isPlayerInLoot())
				end
			end
			if isPlayerInLoot() then
				local gearName = guiGetText(headline["loot"])
				local col = getElementData(localPlayer,"currentCol")
				setTimer(refreshInventory,200,2)
				setTimer(refreshLoot,200,2,col,gearName)
			end
		end	
	end
end
addEventHandler ( "onClientGUIClick", buttonItems["loot"], onPlayerMoveItemInInventory )

function onClientOpenInventoryStopMenu ()
	triggerEvent("disableMenu",localPlayer)
end

function isPlayerInLoot()
if getElementData(localPlayer,"loot") then
	return getElementData(localPlayer,"currentCol")
end
return false
end


------------------------------------------------------------------------------
--right-click menu
function onPlayerPressRightKeyInInventory ()
local plr = localPlayer
local itemName = guiGridListGetItemText ( gridlistItems["inventory"], guiGridListGetSelectedItem ( gridlistItems["inventory"] ), 1 )
local itemName,itemInfo = getInventoryInfosForRightClickMenu(itemName)
	if isCursorShowing() and guiGetVisible(inventoryWindows) and itemInfo then
		if itemName == "Lighter" then
			if getElementData(plr,"Wood") == 0 then
				return
			end
		end
		if itemName == "Bandage" then
			if getElementData(plr,"bleeding") == 0 then
				return
			end
		end	
		if itemName == "Medic Kit" then
			if getElementData(plr,"blood") > 10500 then
				return
			end
		end	
		if itemName == "Heat Pack" then
			if getElementData(plr,"temperature") > 35 then
				return
			end
		end	
		if itemName == "Painkiller" then
			if not getElementData(plr,"pain") then
				return
			end
		end	
		if itemName == "Morphine" then
			if not getElementData(plr,"brokenbone") then
				return
			end
		end	
		if itemName == "Blood Bag" then
			--if getElementData(plr,"blood") < 1150 then
				return
			--end
		end	
		if itemName == "Empty Bottle" then
			if (not isElementInWater(plr)) then
				return
			end
		end
		showRightClickInventoryMenu (itemName,itemInfo)		
	end
end
bindKey("mouse2","down",onPlayerPressRightKeyInInventory)

function getInventoryInfosForRightClickMenu(itemName)
for i,itemInfo in ipairs(inventoryItems["Weapons"]["Primary Weapon"]) do
	if itemName == itemInfo[1] then
		return itemName,"Rearm Primary Weapon"
	end	
end
for i,itemInfo in ipairs(inventoryItems["Weapons"]["Secondary Weapon"]) do
	if itemName == itemInfo[1] then
		return itemName,"Rearm Secondary Weapon"
	end	
end
for i,itemInfo in ipairs(inventoryItems["Weapons"]["Specially Weapon"]) do
	if itemName == itemInfo[1] then
		return itemName,"Rearm Specially Weapon"
	end	
end
for i,itemInfo in ipairs(inventoryItems["Ammo"]) do
	if itemName == itemInfo[1] then
		return itemName,false
	end	
end
for i,itemInfo in ipairs(inventoryItems["Food"]) do
	if itemName == itemInfo[1] then
		if itemInfo[1] == "Water Bottle" or itemInfo[1] == "Milk" or itemInfo[1] == "Soda Bottle" then --so much hard coding it hurts
			info = "Drink"
		else
			info = "Eat"
		end
		return itemName,info
	end	
end
for i,itemInfo in ipairs(inventoryItems["Items"]) do
	if itemName == itemInfo[1] then
		return itemName,itemInfo[3] or false
	end	
end
for i,itemInfo in ipairs(inventoryItems["Toolbelt"]) do
	if itemName == itemInfo[1] then
		return itemName,itemInfo[3] or false
	end
end
end

rightclickWindow = guiCreateStaticImage(0,0,0.05,0.0215,"client/image/scrollmenu_1.png",true)
headline["rightclickmenu"] = guiCreateLabel(0,0,1,1,"",true,rightclickWindow)
guiLabelSetHorizontalAlign (headline["rightclickmenu"],"center")
guiLabelSetVerticalAlign (headline["rightclickmenu"],"center")
guiSetFont (headline["rightclickmenu"], "default-bold-small" )
guiSetVisible(rightclickWindow,false)

function showRightClickInventoryMenu (itemName,itemInfo)
	if itemInfo then
		local screenx, screeny, worldx, worldy, worldz = getCursorPosition()
		guiSetVisible(rightclickWindow,true)
		guiSetText(headline["rightclickmenu"],itemInfo)
		local whith = guiLabelGetTextExtent (headline["rightclickmenu"])
		guiSetPosition(rightclickWindow,screenx,screeny,true)
		local x,y = guiGetSize(rightclickWindow,false)
		guiSetSize(rightclickWindow,whith,y,false)
		guiBringToFront(rightclickWindow)
		setElementData(rightclickWindow,"iteminfo",{itemName,itemInfo})
	end
end

function hideRightClickInventoryMenu ()
	guiSetVisible(rightclickWindow,false)
end


function onPlayerClickOnRightClickMenu (button,state)
    if button == "left" then
        local itemName,itemInfo = getElementData(rightclickWindow,"iteminfo")[1],getElementData(rightclickWindow,"iteminfo")[2]
		hideRightClickInventoryMenu ()
		playerUseItem(itemName,itemInfo)
    end
end
addEventHandler("onClientGUIClick",headline["rightclickmenu"],onPlayerClickOnRightClickMenu,false)

local playerFire = {}
local fireCounter = 0
function playerUseItem(itemName,itemInfo) --fuck this function i swear marwin is an idiot
	if itemInfo == "Drink" then
		triggerServerEvent("onPlayerRequestChangingStats",localPlayer,itemName,"thirst")
	elseif itemInfo == "Eat" then
		triggerServerEvent("onPlayerRequestChangingStats",localPlayer,itemName,"food")		
	elseif itemInfo == "Use Skin" then
		triggerServerEvent("onPlayerChangeSkin",localPlayer,itemName)
	elseif itemName == "Empty Bottle" then
		triggerServerEvent("onPlayerRefillWaterBottle",localPlayer,itemName)	
	elseif itemName == "Tent" then
		triggerServerEvent("onPlayerPitchATent",localPlayer,itemName)
	elseif itemInfo == "Build a wire fence"	then
		triggerServerEvent("onPlayerBuildAWireFence",localPlayer,itemName)
	elseif itemName == "Roadflare" then
		triggerServerEvent("onPlayerPlaceRoadflare",localPlayer,itemName)	
	elseif itemInfo == "Make a Fire" then
		triggerServerEvent("onPlayerMakeAFire",localPlayer,itemName)	
	elseif itemInfo == "Use"then
		triggerServerEvent("onPlayerUseMedicObject",localPlayer,itemName)
	elseif itemName == "Bandage"then
		triggerServerEvent("onPlayerUseMedicObject",localPlayer,itemName)	
	elseif itemInfo == "Use Googles" then
		triggerEvent("onPlayerGoggleUse", localPlayer, itemName)
	elseif itemInfo == "Rearm Primary Weapon" then
		triggerServerEvent("onPlayerRearmWeapon",localPlayer,itemName,1)
	elseif itemInfo == "Rearm Secondary Weapon" then
		triggerServerEvent("onPlayerRearmWeapon",localPlayer,itemName,2)
	elseif itemInfo == "Rearm Specially Weapon" then
		triggerServerEvent("onPlayerRearmWeapon",localPlayer,itemName,3)
	end
end


weaponAmmoTable = {--table[category][#][#] = weapn name, weapn id
["Pistol Ammo"] = {
{"Pistol",22},
{"Silenced Pistol",23},
{"Desert Eagle",24},
},
["Smg Ammo"] = {
{"Uzi",28},
{"TEC-9",32},
},
["Assault Ammo"] = {
{"AK-47",30},
{"M4",31},
{"MP5",29},
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
{"Tear Gas",17},
{"Grenade",16},
{"Knife",4},
{"Katana",8},
},
}
function getWeaponAmmoType3 (weapon)
end
function getWeaponAmmoType2 (weaponName) --for now: IF IT AINT BROKE
	for i,weaponData in ipairs(weaponAmmoTable["others"]) do
		if weaponName == weaponData[2] then
			return weaponData[1],weaponData[2]
		end
	end
	for i,weaponData in ipairs(weaponAmmoTable["Pistol Ammo"]) do
		if weaponName == weaponData[2] then
			return "Pistol Ammo",weaponData[2]
		end
	end
	for i,weaponData in ipairs(weaponAmmoTable["Smg Ammo"]) do
		if weaponName == weaponData[2] then
			return "Smg Ammo",weaponData[2]
		end
	end
	for i,weaponData in ipairs(weaponAmmoTable["Assault Ammo"]) do
		if weaponName == weaponData[2] then
			return "Assault Ammo",weaponData[2]
		end
	end
	for i,weaponData in ipairs(weaponAmmoTable["Shotgun Ammo"]) do
		if weaponName == weaponData[2] then
			return "Shotgun Ammo",weaponData[2]
		end
	end
	for i,weaponData in ipairs(weaponAmmoTable["Sniper Ammo"]) do
		if weaponName == weaponData[2] then
			return "Sniper Ammo",weaponData[2]
		end
	end
	for i,weaponData in ipairs(weaponAmmoTable["Rocket Ammo"]) do
		if weaponName == weaponData[2] then
			return "Rocket Ammo",weaponData[2]
		end
	end
end


function weaponSwitch (weapon) --this decreases the ammo in your inventory when you fire
	if source == localPlayer then
		local ammoName,_ = getWeaponAmmoType2 (weapon)
		if getElementData(localPlayer,ammoName) > 0 then
			setElementData(localPlayer,ammoName,getElementData(localPlayer,ammoName)-1)
		end
	end
end
addEventHandler ( "onClientPlayerWeaponFire", localPlayer, weaponSwitch )

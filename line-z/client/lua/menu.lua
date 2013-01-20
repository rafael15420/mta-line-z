--[[
#---------------------------------------------------------------#
----*			DayZ MTA Script menu_client.lua			*----
----* 
----* welp
----*  todo: unify/standardize; maybe add graphics
----*														*----
#---------------------------------------------------------------#
]]


--Create Scroll Menü
local spalten = {}
local spalteGuiImage = {}
local spalteGuiText = {}

local optionsTable = {
["player"] = {
{"Give Painkillers"},
{"Give Bandage"},
{"Give Morphine"},
},
}

spalten[1] = ""
spalten[2] = ""
spalten[3] = ""
spalten[4] = ""

spalteGuiImage[1] = guiCreateStaticImage(0,0.45,0.1,0.025,"client/image/scrollmenu_1.png",true)
spalteGuiImage[2] = guiCreateStaticImage(0,0.475,0.1,0.025,"client/image/scrollmenu_1.png",true)
spalteGuiImage[3] = guiCreateStaticImage(0,0.5,0.1,0.025,"client/image/scrollmenu_1.png",true)
spalteGuiImage[4] = guiCreateStaticImage(0,0.525,0.1,0.025,"client/image/scrollmenu_1.png",true)

spalteGuiText[1] = guiCreateLabel(0.05,0.05,0.995,0.95,spalten[1],true,spalteGuiImage[1])
spalteGuiText[2] = guiCreateLabel(0.05,0.05,0.995,0.95,spalten[2],true,spalteGuiImage[2])
spalteGuiText[3] = guiCreateLabel(0.05,0.05,0.995,0.95,spalten[3],true,spalteGuiImage[3])
spalteGuiText[4] = guiCreateLabel(0.05,0.05,0.995,0.95,spalten[4],true,spalteGuiImage[4])

--guiLabelSetColor (spalteGuiText[1],50,255,50)

guiSetVisible(spalteGuiImage[1],false)
guiSetVisible(spalteGuiImage[2],false)
guiSetVisible(spalteGuiImage[3],false)
guiSetVisible(spalteGuiImage[4],false)


------------------------------------------------------------------------------
--MENU
function showClientMenuItem(arg1,arg2,arg3,arg4)
local number = 0
if arg1 == "Take" then
	number = number+1
	guiSetVisible(spalteGuiImage[number],true)
	guiSetText(spalteGuiText[number],"Take "..arg2)
	if number == 1 then
		guiLabelSetColor (spalteGuiText[number],50,255,50)
		setElementData(spalteGuiText[number],"markedMenuItem",true)
	end
	setElementData(spalteGuiText[number],"usedItem",arg2)
end
if arg1 == "stop" then
	disableMenu()
	refreshLoot(false)
end
if arg1 == "Helicrashsite" then
	number = number+1
	guiSetVisible(spalteGuiImage[number],true)
	guiSetText(spalteGuiText[number],"Gear (Helicrash)")
	if number == 1 then
		guiLabelSetColor (spalteGuiText[number],50,255,50)
		setElementData(spalteGuiText[number],"markedMenuItem",true)
	end
	setElementData(spalteGuiText[number],"usedItem","helicrashsite")
end
if arg1 == "Hospitalbox" then
	number = number+1
	guiSetVisible(spalteGuiImage[number],true)
	guiSetText(spalteGuiText[number],"Gear (Hospitalbox)")
	if number == 1 then
		guiLabelSetColor (spalteGuiText[number],50,255,50)
		setElementData(spalteGuiText[number],"markedMenuItem",true)
	end
	setElementData(spalteGuiText[number],"usedItem","hospitalbox")
end
if arg1 == "Vehicle" then
	number = number+1
	guiSetVisible(spalteGuiImage[number],true)
	guiSetText(spalteGuiText[number],"Gear ("..arg2..")")
	guiLabelSetColor (spalteGuiText[number],50,255,50)
	setElementData(spalteGuiText[number],"markedMenuItem",true)
	setElementData(spalteGuiText[number],"usedItem","vehicle")
	if getElementData(getElementData(arg3,"parent"),"tent") then
		number = number+1
		guiSetVisible(spalteGuiImage[number],true)
		guiSetText(spalteGuiText[number],"Remove Tent")
		if number == 1 then
			guiLabelSetColor (spalteGuiText[number],50,255,50)
			setElementData(spalteGuiText[number],"markedMenuItem",true)
		end
			setElementData(spalteGuiText[number],"usedItem","tent")
		return
	end
	--2
	if getElementHealth(arg3) < 1000 and getElementHealth(arg3) >= 50 and getElementData(localPlayer,"Toolbox") >= 1 then
		number = number+1
		guiSetVisible(spalteGuiImage[number],true)
		guiSetText(spalteGuiText[number],"Repair ("..arg2..")")
		setElementData(spalteGuiText[number],"usedItem","repairvehicle")
	end
end
if arg1 == "Player" then
	--1
	if getElementData(arg2,"bleeding") > 0 and getElementData(localPlayer,"Bandage") >= 1 then
		number = number+1
		guiSetVisible(spalteGuiImage[number],true)
		guiSetText(spalteGuiText[number],"Give Bandage")
		guiLabelSetColor (spalteGuiText[1],50,255,50)
		setElementData(spalteGuiText[1],"markedMenuItem",true)
		setElementData(spalteGuiText[number],"usedItem","bandage")
	end	
	if getElementData(arg2,"blood") < 11900 and getElementData(localPlayer,"Blood Bag") >= 1 then
		number = number+1
		guiSetVisible(spalteGuiImage[number],true)
		guiSetText(spalteGuiText[number],"Give Blood Pack")	
		setElementData(spalteGuiText[number],"usedItem","giveblood")
		if number == 1 then
			guiLabelSetColor (spalteGuiText[number],50,255,50)
			setElementData(spalteGuiText[number],"markedMenuItem",true)
		end
	end
end
if arg1 == "Dead" then
	number = number+1
	guiSetVisible(spalteGuiImage[number],true)
	guiSetText(spalteGuiText[number],"Gear ("..arg2..")")
	if number == 1 then
		guiLabelSetColor (spalteGuiText[number],50,255,50)
		setElementData(spalteGuiText[number],"markedMenuItem",true)
	end
	setElementData(spalteGuiText[number],"usedItem","dead")
	number = number+1
	setElementData(spalteGuiText[number],"usedItem","deadreason")
	guiSetVisible(spalteGuiImage[number],true)
	guiSetText(spalteGuiText[number],"Check Body")
end
if arg1 == "Fireplace" then
	if getElementData(localPlayer,"Raw Meat") >= 1 then
	number = number+1
	guiSetVisible(spalteGuiImage[number],true)
	guiSetText(spalteGuiText[number],"Cook Meat")
	guiLabelSetColor (spalteGuiText[number],50,255,50)
	setElementData(spalteGuiText[number],"markedMenuItem",true)
	setElementData(spalteGuiText[number],"usedItem","fireplace")
	end
end
if arg1 == "Patrol" then
	if getElementData(localPlayer,"Empty Patrol Canister") >= 1 then
		number = number+1
		guiSetVisible(spalteGuiImage[number],true)
		guiSetText(spalteGuiText[number],"Refill (Empty Patrol Canister)")
		if number == 1 then
			guiLabelSetColor (spalteGuiText[number],50,255,50)
			setElementData(spalteGuiText[number],"markedMenuItem",true)
		end
			setElementData(spalteGuiText[number],"usedItem","patrolstation")
	end	
end
if arg1 == "Wirefence" then
	if getElementData(localPlayer,"Toolbox") >= 1 then
		number = number+1
		guiSetVisible(spalteGuiImage[number],true)
		guiSetText(spalteGuiText[number],"Remove Wirefence")
		if number == 1 then
			guiLabelSetColor (spalteGuiText[number],50,255,50)
			setElementData(spalteGuiText[number],"markedMenuItem",true)
		end
			setElementData(spalteGuiText[number],"usedItem","wirefence")
	end	
end
if arg1 == "Gear" then
	number = number+1
	guiSetVisible(spalteGuiImage[number],true)
	guiSetText(spalteGuiText[number],"Gear")
	if number == 1 then
		guiLabelSetColor (spalteGuiText[number],50,255,50)
		setElementData(spalteGuiText[number],"markedMenuItem",true)
	end
	setElementData(spalteGuiText[number],"usedItem","itemloot")
end
end
addEvent("showClientMenuItem",true)
addEventHandler("showClientMenuItem",localPlayer,showClientMenuItem)

function PlayerScrollMenu (key,keyState,arg)
if ( keyState == "down" ) then
if not guiGetVisible(spalteGuiImage[2]) then
	return
end
if arg == "up" then
	if getElementData(spalteGuiText[1],"markedMenuItem") then
		setElementData(spalteGuiText[1],"markedMenuItem",false)
		setElementData(spalteGuiText[2],"markedMenuItem",true)
		guiLabelSetColor (spalteGuiText[2],50,255,50)
		guiLabelSetColor (spalteGuiText[1],255,255,255)
	elseif getElementData(spalteGuiText[2],"markedMenuItem") then
		setElementData(spalteGuiText[2],"markedMenuItem",false)
		setElementData(spalteGuiText[1],"markedMenuItem",true)
		guiLabelSetColor (spalteGuiText[1],50,255,50)
		guiLabelSetColor (spalteGuiText[2],255,255,255)
	end
elseif arg == "down" then
	if getElementData(spalteGuiText[1],"markedMenuItem") then
		setElementData(spalteGuiText[1],"markedMenuItem",false)
		setElementData(spalteGuiText[2],"markedMenuItem",true)
		guiLabelSetColor (spalteGuiText[2],50,255,50)
		guiLabelSetColor (spalteGuiText[1],255,255,255)
	elseif getElementData(spalteGuiText[2],"markedMenuItem") then
		setElementData(spalteGuiText[2],"markedMenuItem",false)
		setElementData(spalteGuiText[1],"markedMenuItem",true)
		guiLabelSetColor (spalteGuiText[1],50,255,50)
		guiLabelSetColor (spalteGuiText[2],255,255,255)
	end
end
end
end
bindKey ( "mouse_wheel_up", "down", PlayerScrollMenu, "up" )
bindKey ( "mouse_wheel_down", "down", PlayerScrollMenu, "down" )

function disableMenu()
guiSetVisible(spalteGuiImage[1],false)
guiSetVisible(spalteGuiImage[2],false)
guiSetVisible(spalteGuiImage[3],false)
guiSetVisible(spalteGuiImage[4],false)
setElementData(spalteGuiText[1],"markedMenuItem",false)
setElementData(spalteGuiText[2],"markedMenuItem",false)
setElementData(spalteGuiText[3],"markedMenuItem",false)
setElementData(spalteGuiText[4],"markedMenuItem",false)
--setNewbieInfo (false,"","")
end
addEvent("disableMenu",true)
addEventHandler("disableMenu",localPlayer,disableMenu)


------------------------------------------------------------------------------

------------------------------------------------------------------------------
--TAKE OBJECT FUNCTIONS

function getPlayerInCol(tab)
	for theKey,thePlayer in ipairs(tab) do
		if thePlayer ~= localPlayer then
			return true
		end
	end
	return false
end

isInFirePlace = false
function onPlayerTargetPickup (theElement)
if theElement == localPlayer then
if getElementParent(source) == localPlayer then return end
		isInFirePlace = false
		setElementData(spalteGuiText[2],"markedMenuItem",false)
		setElementData(spalteGuiText[1],"markedMenuItem",true)
		guiLabelSetColor (spalteGuiText[1],50,255,50)
		guiLabelSetColor (spalteGuiText[2],255,255,255)
		local player = getPlayerInCol(getElementsWithinColShape ( source, "player" ))
		if getElementData(source,"player") then
			showClientMenuItem("Player",getElementParent(source))
			setElementData(localPlayer,"currentCol",source)
			setElementData(localPlayer,"loot",false)
			return
		end
		if getElementData(source,"patrolstation") then
			showClientMenuItem("Patrol")
			setElementData(localPlayer,"currentCol",source)
			setElementData(localPlayer,"loot",false)
			return
		end
		if getElementData(source,"wirefence") then
			showClientMenuItem("Wirefence")
			setElementData(localPlayer,"currentCol",source)
			setElementData(localPlayer,"loot",false)
			return
		end
		if getElementData(source,"fireplace") then
			showClientMenuItem("Fireplace")
			setElementData(localPlayer,"currentCol",source)
			setElementData(localPlayer,"loot",false)
			return
		end
		if player then
			--return
		end
		if getElementData(source,"deadman") then
			showClientMenuItem("Dead",getElementData(source,"playername"))
			setElementData(localPlayer,"currentCol",source)
			setElementData(localPlayer,"loot",true)
			setElementData(localPlayer,"lootname","Gear ("..getElementData(source,"playername")..")")
			return
		end
		if getElementData(source,"item") then
			showClientMenuItem("Take",getElementData(source,"item"))
			setElementData(localPlayer,"currentCol",source)
			setElementData(localPlayer,"loot",false)
			return
		end
		if getElementData(source,"helicrash") then
			showClientMenuItem("Helicrashsite","helicrash")
			setElementData(localPlayer,"currentCol",source)
			setElementData(localPlayer,"loot",true)
			setElementData(localPlayer,"lootname","Gear (Helicrash)")
			return
		end
		if getElementData(source,"hospitalbox") then
			showClientMenuItem("Hospitalbox","hospitalbox")
			setElementData(localPlayer,"currentCol",source)
			setElementData(localPlayer,"loot",true)
			setElementData(localPlayer,"lootname","Gear (Hospitalbox)")
			return
		end
		if getElementData(source,"vehicle") then
			if not getElementData(source,"deadVehicle") then
			showClientMenuItem("Vehicle",(getVehicleName(getElementParent(source)) or "Tent"),getElementParent(source))
			setElementData(localPlayer,"currentCol",source)
			setElementData(localPlayer,"loot",true)
			setElementData(localPlayer,"lootname","Gear ("..(getVehicleName(getElementParent(source)) or "Tent")..")")
			return
			end
		end
		if getElementData(source,"itemloot") then
			showClientMenuItem("Gear")
			setElementData(localPlayer,"loot",true)
			setElementData(localPlayer,"lootname","Gear")
			setElementData(localPlayer,"currentCol",source)
			return
		end
	showClientMenuItem("stop")
end	
end
addEventHandler("onClientColShapeHit",getRootElement(),onPlayerTargetPickup)

function onPlayerTargetPickup (theElement)
if theElement == localPlayer then
	local players = getElementsWithinColShape ( source, "player" )
	if players == localPlayer then --[[return ]]end
	showClientMenuItem("stop")
	setElementData(localPlayer,"loot",false)
	setElementData(localPlayer,"currentCol",false)
end
end
addEventHandler("onClientColShapeLeave",getRootElement(),onPlayerTargetPickup)

------------------------------------------------------------------------------

unbindKey("mouse3","both")
function onPlayerPressMiddleMouse (key,keyState)
if ( keyState == "down" ) then
	if not guiGetVisible(spalteGuiText[1]) then return end
		local itemName = getMenuMarkedItem()
		if itemName == "helicrashsite" then
			local col = getElementData(localPlayer,"currentCol")
			local gearName = "Gear (Helicrash)"
			refreshLoot(col,gearName)
			showInventoryManual()
			return
		end
		if itemName == "itemloot" then
			local col = getElementData(localPlayer,"currentCol")
			local gearName = "Gear"
			refreshLoot(col,gearName)
			showInventoryManual()
			return
		end
		if itemName == "wirefence" then
			local col = getElementData(localPlayer,"currentCol")
			local gearName = "Remove Wirefence"
			triggerServerEvent("removeWirefence",localPlayer,getElementData(col,"parent"))
			disableMenu()
			return
		end
		if itemName == "hospitalbox" then
			local col = getElementData(localPlayer,"currentCol")
			local gearName = "Gear (Hospitalbox)"
			refreshLoot(col,gearName)
			showInventoryManual()
			return
		end
		if itemName == "vehicle" then
			local col = getElementData(localPlayer,"currentCol")
			local gearName = "Gear ("..(getVehicleName(getElementData(col,"parent")) or "Tent")..")"
			refreshLoot(col,gearName)
			showInventoryManual()
			return
		end
		if itemName == "repairvehicle" then
			local col = getElementData(localPlayer,"currentCol")
			triggerServerEvent("repairVehicle",localPlayer,getElementData(col,"parent"))
			disableMenu()
			return
		end
		if itemName == "tent" then
			local col = getElementData(localPlayer,"currentCol")
			triggerServerEvent("removeTent",localPlayer,getElementData(col,"parent"))
			disableMenu()
			return
		end
		if itemName == "fireplace" then
			local col = getElementData(localPlayer,"currentCol")
			triggerServerEvent("addPlayerCookMeat",localPlayer)
			disableMenu()
			return
		end
		if itemName == "bandage" then
			local col = getElementData(localPlayer,"currentCol")
				triggerServerEvent("onPlayerGiveMedicObject",localPlayer,itemName,getElementData(col,"parent"))
				disableMenu()
			return
		end
		if itemName == "giveblood" then
			local col = getElementData(localPlayer,"currentCol")
				triggerServerEvent("onPlayerGiveMedicObject",localPlayer,itemName,getElementData(col,"parent"))
				disableMenu()
			return
		end
		if itemName == "dead" then
			local col = getElementData(localPlayer,"currentCol")
			local gearName = "Gear ("..getElementData(col,"playername")..")"
			refreshLoot(col,gearName)
			showInventoryManual()
			return
		end
		if itemName == "deadreason" then
			local col = getElementData(localPlayer,"currentCol")
			outputChatBox(getElementData(col,"deadreason"),255,255,255,true)
			return
		end
		if itemName == "patrolstation" then
			local col = getElementData(localPlayer,"currentCol")
				triggerServerEvent("fillPatrolCanister",localPlayer)
				disableMenu()
			return
		end
			if isToolbeltItem(itemName) then
				local col = getElementData(localPlayer,"currentCol")
				triggerServerEvent("onPlayerTakeItemFromGround",localPlayer,itemName,col)
				disableMenu()
				return
			end	
			if itemName == "Small Backpack" or itemName == "Alice Backpack" or itemName == "Coyote Backpack" then
				local col = getElementData(localPlayer,"currentCol")
				triggerServerEvent("onPlayerTakeItemFromGround",localPlayer,itemName,col)
				disableMenu()
				return
			end	
			if getPlayerCurrentSlots() + getItemSlots(itemName) <= getPlayerMaxAviableSlots() then	
				local col = getElementData(localPlayer,"currentCol")
				triggerServerEvent("onPlayerTakeItemFromGround",localPlayer,itemName,col)
				disableMenu()
			else
				displayClientInfo("Inventory", "Your Inventory is to full", 255, 22, 0 )
			end
	end
end
bindKey ( "mouse3", "down", onPlayerPressMiddleMouse )
bindKey ( "-", "down", onPlayerPressMiddleMouse )

function getMenuMarkedItem() 
	for i,guiItem in ipairs(spalteGuiText) do
		if getElementData(guiItem,"markedMenuItem") then
			return getElementData(guiItem,"usedItem") 
		end
	end
end


function playerPressedKey(button, press)
    if (press) then
		if button == "w" or button == "a" or button == "s" or button == "d" then
			local anim,anim2 = getPedAnimation (localPlayer)
			if anim and anim == "SCRATCHING" and anim2 == "sclng_r" then
				triggerServerEvent("onClientMovesWhileAnimation",localPlayer)
			end	
		end
    end
end
addEventHandler("onClientKey", root, playerPressedKey)
























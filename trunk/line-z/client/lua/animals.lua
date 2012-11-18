--[[
#---------------------------------------------------------------#
----*			DayZ MTA Script animals_client.lua			*----
----* This Script is really fucking gay
----* 
----* fuck all 14 year old kids
----*														*----
#---------------------------------------------------------------#
]]

local temptxd,tempdff
temptxd = engineLoadTXD ("client/animal/bear.txd");
engineImportTXD (temptxd, 12);
tempdff = engineLoadDFF ("client/animal/bear.dff", 12);
engineReplaceModel (tempdff, 12);

temptxd = engineLoadTXD ("client/animal/fox.txd");
engineImportTXD (temptxd, 13);
tempdff = engineLoadDFF ("client/animal/fox.dff", 13);
engineReplaceModel (tempdff, 13);

temptxd = engineLoadTXD ("client/animal/wolf.txd");
engineImportTXD (temptxd, 14);
tempdff = engineLoadDFF ("client/animal/wolf.dff", 14);
engineReplaceModel (tempdff, 14);

function animalDamage(attacker,weapon)
	if attacker == getLocalPlayer() then
		if getElementData(source,"animal") then
			if weapon and weapon > 1 then
				triggerServerEvent("createDeadAnimal",source)
			end
		end
	end	
end
addEventHandler ( "onClientPedDamage",getRootElement(),animalDamage)

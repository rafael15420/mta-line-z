--[[ OVERRIDES.LUA 		drline 2012

	all texture / model overrides go here

--]]

--Survivor Skins
--Sniper
local snipertxd = engineLoadTXD ("client/player/sniper.txd");
engineImportTXD (snipertxd, 285);
local sniperdff = engineLoadDFF ("client/player/sniper.dff", 285);
engineReplaceModel (sniperdff, 285);
--Civilian
local snipertxd = engineLoadTXD ("client/player/civilian.txd");
engineImportTXD (snipertxd, 179);
local sniperdff = engineLoadDFF ("client/player/civilian.dff", 179);
engineReplaceModel (sniperdff, 179);
--Bandit1
local snipertxd = engineLoadTXD ("client/player/bandit3.txd");
engineImportTXD (snipertxd, 180);
local sniperdff = engineLoadDFF ("client/player/bandit3.dff", 180);
engineReplaceModel (sniperdff, 180);
--Bandit2
local snipertxd = engineLoadTXD ("client/player/bandit2.txd");
engineImportTXD (snipertxd, 288);
local sniperdff = engineLoadDFF ("client/player/bandit2.dff", 288);
engineReplaceModel (sniperdff, 288);
--[[Standart
local snipertxd = engineLoadTXD ("client/player/standart.txd");
engineImportTXD (snipertxd, 73);
local sniperdff = engineLoadDFF ("client/player/standart.dff", 73);
engineReplaceModel (sniperdff, 73);
]]--

--Items
local itemTXD = engineLoadTXD ("client/item/army_clothes.txd");
engineImportTXD (itemTXD, 1247);
local itemDFF = engineLoadDFF ("client/item/army_clothes.dff", 1247);
engineReplaceModel (itemDFF, 1247);
local itemTXD = engineLoadTXD ("client/item/sniper_clothes.txd");
engineImportTXD (itemTXD, 1213);
local itemDFF = engineLoadDFF ("client/item/sniper_clothes.dff", 1213);
engineReplaceModel (itemDFF, 1213);
local itemTXD = engineLoadTXD ("client/item/civilian_clothes.txd");
engineImportTXD (itemTXD, 1241);
local itemDFF = engineLoadDFF ("client/item/civilian_clothes.dff", 1241);
engineReplaceModel (itemDFF, 1241);
local itemTXD = engineLoadTXD ("client/item/standard_clothes.txd");
engineImportTXD (itemTXD, 1577);
local itemDFF = engineLoadDFF ("client/item/standard_clothes.dff", 1577);
engineReplaceModel (itemDFF, 1577);
local itemTXD = engineLoadTXD ("client/item/beans_can.txd");
engineImportTXD (itemTXD, 2601);
local itemDFF = engineLoadDFF ("client/item/beans_can.dff", 2601);
engineReplaceModel (itemDFF, 2601);
local itemTXD = engineLoadTXD ("client/item/first_aid_kit.txd");
engineImportTXD (itemTXD, 2891);
local itemDFF = engineLoadDFF ("client/item/first_aid_kit.dff", 2891);
engineReplaceModel (itemDFF, 2891);
local itemTXD = engineLoadTXD ("client/item/heat_pack.txd");
engineImportTXD (itemTXD, 1576);
local itemDFF = engineLoadDFF ("client/item/heat_pack.dff", 1576);
engineReplaceModel (itemDFF, 1576);
local itemTXD = engineLoadTXD ("client/item/pain_killers.txd");
engineImportTXD (itemTXD, 2709);
local itemDFF = engineLoadDFF ("client/item/pain_killers.dff", 2709);
engineReplaceModel (itemDFF, 2709);
local itemTXD = engineLoadTXD ("client/item/pasta_can.txd");
engineImportTXD (itemTXD, 2770);
local itemDFF = engineLoadDFF ("client/item/pasta_can.dff", 2770);
engineReplaceModel (itemDFF, 2770);
local itemTXD = engineLoadTXD ("client/item/pistol_ammo.txd");
engineImportTXD (itemTXD, 3013);
local itemDFF = engineLoadDFF ("client/item/pistol_ammo.dff", 3013);
engineReplaceModel (itemDFF, 3013);
local itemTXD = engineLoadTXD ("client/item/shotgun_ammo.txd");
engineImportTXD (itemTXD, 2358);
local itemDFF = engineLoadDFF ("client/item/shotgun_ammo.dff", 2358);
engineReplaceModel (itemDFF, 2358);
local itemTXD = engineLoadTXD ("client/item/backpack_small.txd");
engineImportTXD (itemTXD, 3026);
local itemDFF = engineLoadDFF ("client/item/backpack_small.dff", 3026);
engineReplaceModel (itemDFF, 3026);
local itemTXD = engineLoadTXD ("client/item/smg_ammo.txd");
engineImportTXD (itemTXD, 2041);
local itemDFF = engineLoadDFF ("client/item/smg_ammo.dff", 2041);
engineReplaceModel (itemDFF, 2041);
local itemTXD = engineLoadTXD ("client/item/sniper_ammo.txd");
engineImportTXD (itemTXD, 2358);
local itemDFF = engineLoadDFF ("client/item/sniper_ammo.dff", 2358);
engineReplaceModel (itemDFF, 2358);
local itemTXD = engineLoadTXD ("client/item/soda_can.txd");
engineImportTXD (itemTXD, 2647);
local itemDFF = engineLoadDFF ("client/item/soda_can.dff", 2647);
engineReplaceModel (itemDFF, 2647);
local itemTXD = engineLoadTXD ("client/item/water_bottle.txd");
engineImportTXD (itemTXD, 2683);
local itemDFF = engineLoadDFF ("client/item/water_bottle.dff", 2683);
engineReplaceModel (itemDFF, 2683);
local itemTXD = engineLoadTXD ("client/item/assault_ammo.txd");
engineImportTXD (itemTXD, 1271);
local itemDFF = engineLoadDFF ("client/item/assault_ammo.dff", 1271);
engineReplaceModel (itemDFF, 1271);
local itemTXD = engineLoadTXD ("client/item/backpack_alice.txd");
engineImportTXD (itemTXD, 1248);
local itemDFF = engineLoadDFF ("client/item/backpack_alice.dff", 1248);
engineReplaceModel (itemDFF, 1248);
local itemTXD = engineLoadTXD ("client/item/backpack_coyote.txd");
engineImportTXD (itemTXD, 1252);
local itemDFF = engineLoadDFF ("client/item/backpack_coyote.dff", 1252);
engineReplaceModel (itemDFF, 1252);
local itemTXD = engineLoadTXD ("client/item/tent.txd");
engineImportTXD (itemTXD, 3243);
local itemDFF = engineLoadDFF ("client/item/tent.dff", 3243);
engineReplaceModel (itemDFF, 3243);
local itemTXD = engineLoadTXD ("client/item/wirefence.txd");
engineImportTXD (itemTXD, 983);
local itemDFF = engineLoadDFF ("client/item/wirefence.dff", 983);
engineReplaceModel (itemDFF, 983);

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

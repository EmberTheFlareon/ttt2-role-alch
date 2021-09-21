
--Another shout out to the team behind TTT2 for making this idea actually doable in the first place.
-- Thank you to everyone at GFL Clan that helps run the Anarchy servers for countless hours of fun.
-- Finally, thank you to eveyone on the Neoxult Discord for being so helphful and patient!


if SERVER then
	resource.AddFile("materials/vgui/ttt/dynamic/roles/icon_surv.vmt")
	AddCSLuaFile()

	util.AddNetworkString("TTT2AlchemistDefaultBrewMode")
end

function ROLE:PreInitialize()
	self.color = Color(13, 208, 209, 255)
	self.abbr = "alch"

	self.score.killsMultiplier = 1
	self.score.teamKillsMultiplier = -8

	self.unknownTeam = true

	self.defaultTeam = TEAM_INNOCENT
	self.defaultEquipment = INNO_EQUIPMENT

	self.conVarData = {
		pct = 0.15,  --necessary: percentage of getting this role selected (per player)
		maximum = 1,  --maximum amount of roles in a round
		minPlayers = 5, --minimum amount of players until this role is able to get selected
		togglable = true, --Makes it so players can toggle getting this role from their own F1 menu.
	}
end

function ROLE:Initialize()
	roles.SetBaseRole(self, ROLE_INNOCENT)
end

if SERVER then
	-- Displays the role for all to see.
	hook.Add("TTT2ModifyRadarRole", "AlchemistModifyRadarRole", function(ply, target)
		if ply:GetSubRole() ~= ROLE_ALCHEMISt and target:GetSubRole() == ROLE_ALCHEMIST then
			return ROLE_ALCHEMIST, TEAM_INNOCENT
		end
	end)
	
	--This activates when the timer set up below it finishes.
	--When that happens, it gfives the user a potion.
	-- Currently, as only one potion has been coded, the random selection code is not present.
	local function GiveMeAPotion(ply)
		ply:GiveEquipmentWeapon("weapon_ttt_healpotion")
	end
	
	--This tells the game that after a certain amount of time has passed, it should give the player a potion.
	local function CreatePotionTimer(ply)	
		--Create a timer that is unique to the player.
		timer.Create("AlchemistBrewTimer" .. ply:SteamID64(), 20, 3, function()
			GiveMeAPotion(ply)
		end)
	end
	
	--Testing purposes only! This is only here to quickly give a potion so that it may be tested.
	function ROLE:GiveRoleLoadout(ply, isRoleChange)
		GiveMeAPotion(ply)
	end
end

--This will eventually be a table for the random potion selection to use.
potions = { "weapon_ttt_healpotion" }

if CLIENT then

end

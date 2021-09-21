
--BIG NOTE: A huge shoutout to blackmagicfine and Smuggles for Imposter. 
--I learned how to do the cycle-able menu and cooldown timers by reading their code. Without it, this'd look terrible.

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

	--This section and the one after ensure the Alchemist appears as Alchemist correctly
	--It also helps me quickly modify things to use for the accompanying role, Witch
	--How does the Alchemist appear to other Innocents?
	hook.Add("TTT2ModifyRadarRole", "TTT2ModifyRadarRoleAlchemist", function(ply, target)
		if ply:HasTeam(TEAM_INNOCENT) and target:GetSubRole() == ROLE_ALCHEMIST then
			return ROLE_ALCHEMIST, TEAM_INNOCENT
		end
	end)

	--How does the Alchemist appear to Tratiors?
	hook.Add("TTT2ModifyRadarRole", "TTT2ModifyRadarRoleAlchemist", function(ply, target)
		if ply:HasTeam(TEAM_Traitor) and target:GetSubRole() == ROLE_ALCHEMIST then
			return ROLE_ALCHEMIST, TEAM_INNOCENT
		end
	end)
	
	local function GiveMeAPotion(ply)
		ply:GiveEquipmentWeapon("weapon_ttt_healpotion")
	end

	local function CreatePotionTimer(ply)	
		--Create a timer that is unique to the player.
		timer.Create("AlchemistBrewTimer" .. ply:SteamID64(), 20, 3, function()
			GiveMeAPotion(ply)
		end)
	end

	function ROLE:GiveRoleLoadout(ply, isRoleChange)
		GiveMeAPotion(ply)
	end
end

potions = { "weapon_ttt_healpotion" }

if CLIENT then

end
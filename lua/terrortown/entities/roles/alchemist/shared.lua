
-- Shout out to the team behind TTT2 for making this idea actually doable in the first place.
-- Thank you to everyone at GFL Clan that helps run the Anarchy servers for countless hours of fun.
-- Finally, thank you to eveyone on the Neoxult Discord for being so helphful and patient!


if SERVER then
	resource.AddFile("materials/vgui/ttt/dynamic/roles/icon_alch.vmt")
	AddCSLuaFile()

end

function ROLE:PreInitialize()
	self.color = Color(192, 229, 1, 255)
	self.abbr = "alch"

	self.unknownTeam = true

	self.score.killsMultiplier = 2
	self.score.teamKillsMultiplier = -8
	self.defaultTeam = TEAM_INNOCENT
	self.defaultEquipment = INNO_EQUIPMENT

	self.conVarData = {
		pct = 0.15,  --necessary: percentage of getting this role selected (per player)
		maximum = 1,  --maximum amount of roles in a round
		minPlayers = 6, --minimum amount of players until this role is able to get selected
		togglable = true, --Makes it so players can toggle getting this role from their own F1 menu.
	}
end

function ROLE:Initialize()
	roles.SetBaseRole(self, ROLE_DETECTIVE)
end

if SERVER then
	-- Displays the role for all to see.
	hook.Add("TTT2ModifyRadarRole", "AlchemistModifyRadarRole", function(ply, target)
		if ply:GetSubRole() ~= ROLE_ALCHEMISt and target:GetSubRole() == ROLE_ALCHEMIST then
			return ROLE_ALCHEMIST, TEAM_INNOCENT
		end
	end)
	
	--This sets up the timer needed to supply a potion after a certain time
	local function GiveMeAPotion(ply)
		timer.Create( "MakePotion", 30, 5,  function() ply:GiveEquipmentWeapon("weapon_ttt_healpotion") end)
	end
	hook.Add( "Initialize", "Timer Example", "MakePotion" )

	--All this really does is set the timer's function to the player.
	function ROLE:GiveRoleLoadout(ply, isRoleChange)
			GiveMeAPotion(ply)
	end
end


--This will eventually be a table for the random potion selection to use.
potions = { "weapon_ttt_healpotion" }

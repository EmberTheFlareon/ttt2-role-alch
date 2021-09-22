
-- Shout out to the team behind TTT2 for making this idea actually doable in the first place.
-- Thank you to everyone at GFL Clan that helps run the Anarchy servers for countless hours of fun.
-- Finally, thank you to eveyone on the Neoxult Discord for being so helphful and patient!


if SERVER then
	resource.AddFile("materials/vgui/ttt/dynamic/roles/icon_alch.vmt")
	AddCSLuaFile()

	util.AddNetworkString("FakeTimer")
end

function ROLE:PreInitialize()
	self.color = Color(1, 229, 134, 161)
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
	roles.SetBaseRole(self, ROLE_INNOCENT)
end

if SERVER then


	--This sets up the timer needed to supply a potion after a certain time
	local function GiveMeAPotion(ply)
		timer.Create( "MakePotion", 35, 5,  function() ply:GiveEquipmentWeapon( potions[math.random(1, #potions)] ) end)
	end
	hook.Add( "Initialize", "Timer Example", "MakePotion" )

	--All this really does is set the timer's function to the player.
	function ROLE:GiveRoleLoadout(ply, isRoleChange)
			GiveMeAPotion(ply)
			net.Start("FakeTimer")
			net.Send(ply)
	end
end


if CLIENT then

	net.Receive("FakeTimer", function()
			timer.Create( "Name", 35, 5, function() end )
	end)
	hook.Add( "Initialize", "Timer Example", CreateFakeTimer )
end

--This is a table for the random potion selection to use.
potions = { "weapon_ttt_healpotion", "weapon_ttt_speedpotion", "weapon_ttt_armorpotion", "weapon_ttt_jumppotion"}

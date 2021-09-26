
-- Shout out to the team behind TTT2 for making this idea actually doable in the first place.
-- Thank you to everyone at GFL Clan that helps run the Anarchy servers for countless hours of fun.
-- Finally, thank you to eveyone on the Neoxult Discord for being so helphful and patient!


if SERVER then
	resource.AddFile("materials/vgui/ttt/dynamic/roles/icon_alch.vmt")
	AddCSLuaFile()

	util.AddNetworkString("FakeTimer")
	util.AddNetworkString("Stop")
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
		local timetomake = GetConVar("ttt2_alch_time_until_potion"):GetInt()
		local howmanytimes = GetConVar("ttt2_alch_potion_timer_repeat"):GetInt()
		timer.Create( "MakePotion", timetomake, howmanytimes,  function() ply:GiveEquipmentWeapon( potions[math.random(1, #potions)] ) end)
	end
	hook.Add( "Initialize", "Timer Example", "MakePotion" )

	--This calls for the timer above to start and attach to the player.
	--It also starts a fake timer on the client's side at the same time. 
	--The fake timer only serves as an easy way for the HUD to correctly display the right time
	function ROLE:GiveRoleLoadout(ply, isRoleChange)
			GiveMeAPotion(ply)
			net.Start("FakeTimer")
			net.Send(ply)

	end

	--Ensures the timer ends correctly if the role changes, like when the round ends.
	function ROLE:RemoveRoleLoadout(ply, isRoleChange)
		timer.Remove("MakePotion")
	end

	--This makes sure the timer stops if the player dies.
	if not IsValid() or not ply:IsPlayer() or not ply:Alive() or ply:IsSpec() then
		timer.Remove("MakePotion")
	end

	--Makes the fake timer that the hud uses also stop if the actual timer stops as well.
	if not timer.Exists("MakePotion") then
		net.Start("Stop")
		net.Send(ply)
	end
end


if CLIENT then
	--Simply sets those two words up as numbers to use in the timer below.
	local time = GetConVar("ttt2_alch_time_until_potion"):GetInt()
	local howmany = GetConVar("ttt2_alch_potion_timer_repeat"):GetInt()

	--Recieves a call from the server-side code to start a fake timer.
	--I call it a fake timer as it's only purpose is to make the HUD element display correctly.
	net.Receive("FakeTimer", function()
			timer.Create( "Name", time, howmany, function() end )
	end)

	--Recieves the call to stop the fake timer if the real timer has stopped.
	net.Receive("Stop", function()
		timer.Remove("Name")
	end)
end

--This is a table for the random potion selection to use.
potions = { "weapon_ttt_healpotion", "weapon_ttt_speedpotion", "weapon_ttt_armorpotion", "weapon_ttt_jumppotion"}

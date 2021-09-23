if SERVER then
	AddCSLuaFile()
end

ENT.Type = "anim"
ENT.Base = "ttt_basegrenade_proj"
ENT.Model = Model("models/sohald_spike/props/potion_3.mdl")

function ENT:Initialize()

   self:SetModel(self.Model)

   self:PhysicsInit(SOLID_VPHYSICS)
   self:SetMoveType(MOVETYPE_VPHYSICS)
   self:SetSolid(SOLID_BBOX)
   self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)

   if SERVER then
      self:SetExplodeTime(0)
   end
end

local function JumpRadius(pos, thrower, ply)
	local radius	= 250

	for k, target in pairs(ents.FindInSphere(pos, radius)) do
		if IsValid(target) and target:IsPlayer() and (not target:IsFrozen()) and (not target:IsSpec()) then
			target:SetJumpPower(GetConVar("ttt2_alch_jump_potion_jump"):GetInt())
			timer.Create("Jumpies", GetConVar("ttt2_alch_jump_potion_time"):GetInt(), 1, function() target:SetJumpPower(200) end)
			if not IsValid(target) or not target:IsPlayer() or not target:Alive() or target:IsSpec() then
				target:SetJumpPower(200)
			end
		end
	end


end

local splashsound = Sound("physics/glass/glass_bottle_break2.wav")
function ENT:Explode(tr)
	if SERVER then
		self:SetNoDraw(true)
		self:SetSolid(SOLID_NONE)

		-- pull out of the surface
		if tr.Fraction != 1.0 then
			self:SetPos(tr.HitPos + tr.HitNormal * 0.6)
		end

		local pos = self:GetPos()

		-- make sure we are removed, even if errors occur later
		self:Remove()

		-- do your thing
		JumpRadius(pos, self:GetThrower())

		-- flashly
		local effect = EffectData()
		effect:SetStart(pos)
		effect:SetOrigin(pos)

		if tr.Fraction != 1.0 then
			effect:SetNormal(tr.HitNormal)
		end

		util.Effect("AntlionGib", effect, true, true)

		-- and LOUD
		sound.Play(splashsound, pos, 100, 100)
	else
		local spos = self:GetPos()
		local trs = util.TraceLine({start=spos + Vector(0,0,64), endpos=spos + Vector(0,0,-128), filter=self})
		util.Decal("YellowBlood", trs.HitPos + trs.HitNormal, trs.HitPos - trs.HitNormal)      

		self:SetDetonateExact(0)
	end
end


function ENT:PhysicsCollide(data,phys)
	self:SetDetonateExact(0.1)
end

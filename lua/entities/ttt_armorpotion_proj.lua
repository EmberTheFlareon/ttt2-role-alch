if SERVER then
	AddCSLuaFile()
end

ENT.Type = "anim"
ENT.Base = "ttt_basegrenade_proj"
ENT.Model = Model("models/sohald_spike/props/potion_1.mdl")

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

local function HealRadius(pos, thrower, ply)
	local radius	= 250
	local duration	= 20

	for k, target in pairs(ents.FindInSphere(pos, radius)) do
		if IsValid(target) and target:IsPlayer() and (not target:IsFrozen()) and (not target:IsSpec()) then
			target:GiveArmor(15)
		end
	end
end

local splashsound = Sound("physics/glass/glass_bottle_break2.wav")
function ENT:Explode(tr)
	if SERVER then
		self:SetNoDraw(true)
		self:SetSolid(SOLID_NONE)
		if tr.Fraction != 1.0 then
			self:SetPos(tr.HitPos + tr.HitNormal * 0.6)
		end

		local pos = self:GetPos()
		HealRadius(pos, self:GetThrower())
		self:Remove()
		sound.Play(splashsound, pos, 100, 100)
	else
		self:SetDetonateExact(0)
	end
end

function ENT:PhysicsCollide(data,phys)
	self:SetDetonateExact(0.1)
end

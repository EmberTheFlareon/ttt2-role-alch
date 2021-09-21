local base = "pure_skin_element"

DEFINE_BASECLASS(base)

HUDELEMENT.Base = base

--Most code here is taken from Imposter HUD logic.
if CLIENT then
	local pad = 7
	
	local const_defaults = {
		basepos = {x = 0, y = 0},
		size = {w = 365, h = 32},
		minsize = {w = 225, h = 32}
	}

	function HUDELEMENT:PreInitialize()
		BaseClass.PreInitialize(self)

		local hud = huds.GetStored("pure_skin")
		if not hud then return end

		hud:ForceElement(self.id)
	end

	function HUDELEMENT:Initialize()
		self.scale = 1.0
		self.basecolor = self:GetHUDBasecolor()
		self.pad = pad

		BaseClass.Initialize(self)
	end

	-- parameter overwrites
	function HUDELEMENT:IsResizable()
		return true, false
	end
	-- parameter overwrites end

	function HUDELEMENT:GetDefaults()
		const_defaults["basepos"] = {
			x = 10 * self.scale,
			y = ScrH() - self.size.h - 146 * self.scale - self.pad - 10 * self.scale
		}

		return const_defaults
	end

	function HUDELEMENT:PerformLayout()
		self.scale = self:GetHUDScale()
		self.basecolor = self:GetHUDBasecolor()
		self.iconSize = iconSize * self.scale
		self.pad = pad * self.scale

		BaseClass.PerformLayout(self)
	end

	function HUDELEMENT:ShouldDraw()
		local client = LocalPlayer()
		
		return HUDEditor.IsEditing or (client:Alive() and client:GetSubRole() == ROLE_IMPOSTOR)
	end
	
	local function IsInSpecDM(ply)
		if SpecDM and (ply.IsGhost and ply:IsGhost()) then
			return true
		end
		
		return false
	end
	
	function HUDELEMENT:DrawComponent(text, bg_color, icon_color, icon, first_bar)
		local pos = self:GetPos()
		local size = self:GetSize()
		local x, y = pos.x, pos.y
		local w, h = size.w, size.h
		if not first_bar then
			y = y - (self.size.h + self.pad + 10 * self.scale)
		end
		
		self:DrawBg(x, y, w, h, bg_color)
		draw.AdvancedText(text, "PureSkinBar", x + self.iconSize + self.pad, y + h * 0.5, util.GetDefaultColor(bg_color), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, true, self.scale)
		self:DrawLines(x, y, w, h, self.basecolor.a)
		
		local nSize = self.iconSize - 16
		
		draw.FilteredShadowedTexture(x, y - 2 - (nSize - h), nSize, nSize, icon, 255, icon_color, self.scale)
	end
	
	local function TimeLeftToString(time_left)
		return " (" .. math.ceil(math.abs(time_left)) .. ")"
	end
	
	function HUDELEMENT:DrawBrewTimerComponent()
		local client = LocalPlayer()
		local brew_str = LANG.GetTranslation("BREW_" .. ALCHEMIST.name)
		local bg_color = COLOR_OLIVE
		
		--Display time left if possible.
		if timer.Exists("ALchemistBrewTimer" .. client:SteamID64()) then
			local time_left = timer.TimeLeft("AlchemistBrewTimer" .. client:SteamID64())
			brew_str = brew_str .. TimeLeftToString(time_left)
		end
		
		self:DrawComponent(kill_str, bg_color, true)
	end
	
	function HUDELEMENT:Draw()
		local client = LocalPlayer()
		
		if IsInSpecDM(client) then
			return
		end
		
		self:DrawBrewtimerComponent()
	end
end
include( "sh_ammotypes.lua" )
include( "shared.lua" )

SWEP.DrawCrosshair		= false
SWEP.ViewModelFOV		= 82
SWEP.ViewModelFlip		= true
SWEP.CSMuzzleFlashes	= true
SWEP.DrawAmmo			= true
SWEP.DrawWeaponInfoBox	= true


local sights_opacity = CreateConVar("ttt_ironsights_crosshair_opacity", "0.8", FCVAR_ARCHIVE)
local crosshair_brightness = CreateConVar("ttt_crosshair_brightness", "1.0", FCVAR_ARCHIVE)
local crosshair_size = CreateConVar("ttt_crosshair_size", "1.0", FCVAR_ARCHIVE)
local disable_crosshair = CreateConVar("ttt_disable_crosshair", "0", FCVAR_ARCHIVE)

function SWEP:DrawHUD()
   -- if self.HUDHelp then
   --    self:DrawHelp()
   -- end

   local client = LocalPlayer()
   if disable_crosshair:GetBool() or (not IsValid(client)) then return end

   local sights = (not self.NoSights) and self:GetIronsights()

   local x = math.floor(ScrW() / 2.0)
   local y = math.floor(ScrH() / 2.0)
   local scale = math.max(0.2,  10 * self:GetPrimaryCone())

   local LastShootTime = self:LastShootTime()
   scale = scale * (2 - math.Clamp( (CurTime() - LastShootTime) * 5, 0.0, 1.0 ))

   local alpha = sights and sights_opacity:GetFloat() or 1
   local bright = crosshair_brightness:GetFloat() or 1


   surface.SetDrawColor(0,
                        255 * bright,
                        0,
                        255 * alpha)

   local gap = math.floor(20 * scale * (sights and 0.8 or 1))
   local length = math.floor(gap + (25 * crosshair_size:GetFloat()) * scale)
   surface.DrawLine( x - length, y, x - gap, y )
   surface.DrawLine( x + length, y, x + gap, y )
   surface.DrawLine( x, y - length, x, y - gap )
   surface.DrawLine( x, y + length, x, y + gap )
end

--   local GetPTranslation = LANG.GetParamTranslation

-- Many non-gun weapons benefit from some help
local help_spec = {text = "", font = "TabLarge", xalign = TEXT_ALIGN_CENTER}
function SWEP:DrawHelp()
   local data = self.HUDHelp

   local translate = data.translatable
   local primary   = data.primary
   local secondary = data.secondary

   if translate then
      primary   = primary   and GetPTranslation(primary,   data.translate_params)
      secondary = secondary and GetPTranslation(secondary, data.translate_params)
   end

   help_spec.pos  = {ScrW() / 2.0, ScrH() - 40}
   help_spec.text = secondary or primary
   draw.TextShadow(help_spec, 2)

   -- if no secondary exists, primary is drawn at the bottom and no top line
   -- is drawn
   if secondary then
      help_spec.pos[2] = ScrH() - 60
      help_spec.text = primary
      draw.TextShadow(help_spec, 2)
   end
end

-- mousebuttons are enough for most weapons
-- local default_key_params = {
--    primaryfire   = Key("+attack",  "LEFT MOUSE"),
--    secondaryfire = Key("+attack2", "RIGHT MOUSE"),
--    usekey        = Key("+use",     "USE")
-- };

-- function SWEP:AddHUDHelp(primary_text, secondary_text, translate, extra_params)
--    extra_params = extra_params or {}
-- 
--    self.HUDHelp = {
--       primary = primary_text,
--       secondary = secondary_text,
--       translatable = translate,
--       translate_params = table.Merge(extra_params, default_key_params)
--    };
-- end

function SWEP:PrintWeaponInfo( x, y, alpha )

	if ( self.DrawWeaponInfoBox == false ) then return end

	if (self.InfoMarkup == nil ) then
		local str
		local title_color = "<color=230,230,230,255>"
		local text_color = "<color=150,150,150,255>"

		str = "<font=HudSelectionText>"
		if ( self.Author != "" ) then str = str .. title_color .. "Author:</color>\t" .. text_color .. self.Author .. "</color>\n" end
		if ( self.Contact != "" ) then str = str .. title_color .. "Contact:</color>\t" .. text_color .. self.Contact .. "</color>\n\n" end
		if ( self.Purpose != "" ) then str = str .. title_color .. "Purpose:</color>\n" .. text_color .. self.Purpose .. "</color>\n\n" end
		if ( self.Instructions != "" ) then str = str .. title_color .. "Instructions:</color>\n" .. text_color .. self.Instructions .. "</color>\n" end
		str = str .. "</font>"

		self.InfoMarkup = markup.Parse( str, 250 )
	end

	surface.SetDrawColor( 60, 60, 60, alpha )
	surface.SetTexture( self.SpeechBubbleLid )

	surface.DrawTexturedRect( x, y - 64 - 5, 128, 64 )
	draw.RoundedBox( 8, x - 5, y - 6, 260, self.InfoMarkup:GetHeight() + 18, Color( 60, 60, 60, alpha ) )

	self.InfoMarkup:Draw( x + 5, y + 5, nil, nil, alpha )
end
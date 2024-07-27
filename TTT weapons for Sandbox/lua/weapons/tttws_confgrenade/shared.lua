
AddCSLuaFile()

SWEP.HoldType           = "grenade"

if CLIENT then
   SWEP.PrintName       = "#tttwfs_confgrenade_name"
   SWEP.Slot            = 4
   SWEP.SlotPos         = 5

   SWEP.ViewModelFlip   = false
   SWEP.ViewModelFOV    = 54
   SWEP.DrawWeaponInfoBox  = false

   SWEP.IconOverride       = "vgui/entities/tttws_confgrenade.png"
end

function SWEP:DrawWeaponSelection( x, y, wide, tall, alpha )
   local char = "h"
   local textWidth, textHeight = surface.GetTextSize(char)
   local xPos = x + (wide - textWidth) * 0.5
   local yPos = y + (tall - textHeight) * 0.15
   draw.SimpleText( "h", "TTTSelectIcons", xPos, yPos, Color( 255, 250, 0, 255 ), TEXT_ALIGN_CENTER )
   draw.SimpleText( "h", "TTTSelectIcons2", xPos, yPos, Color( 255, 250, 0, 255 ), TEXT_ALIGN_CENTER )
end

SWEP.Base               = "tttws_basegrenade"

SWEP.WeaponID           = AMMO_DISCOMB
SWEP.Kind               = WEAPON_NADE

SWEP.Spawnable          = true
SWEP.Category           = "TTT weapons for Sandbox"

SWEP.UseHands           = true
SWEP.ViewModel          = "models/weapons/cstrike/c_eq_fraggrenade.mdl"
SWEP.WorldModel         = "models/weapons/w_eq_fraggrenade.mdl"

SWEP.Weight             = 5

-- really the only difference between grenade weapons: the model and the thrown
-- ent.

function SWEP:GetGrenadeName()
   return "tttws_confgrenade_proj"
end

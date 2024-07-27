AddCSLuaFile()

SWEP.HoldType           = "grenade"

if CLIENT then
   SWEP.PrintName       = "#tttwfs_grenade_fire"
   SWEP.Instructions    = "Burn."
   SWEP.Slot            = 4
   SWEP.SlotPos         = 5

   SWEP.ViewModelFlip   = false
   SWEP.ViewModelFOV    = 54

   SWEP.IconOverride    = "vgui/entities/tttws_molotov.png"
end

function SWEP:DrawWeaponSelection( x, y, wide, tall, alpha )
   local char = "g"
   local textWidth, textHeight = surface.GetTextSize(char)
   local xPos = x + (wide - textWidth) * 0.5
   local yPos = y + (tall - textHeight) * 0.15
   draw.SimpleText( "g", "TTTSelectIcons", xPos, yPos, Color( 255, 250, 0, 255 ), TEXT_ALIGN_CENTER )
   draw.SimpleText( "g", "TTTSelectIcons2", xPos, yPos, Color( 255, 250, 0, 255 ), TEXT_ALIGN_CENTER )
   self:PrintWeaponInfo( x + wide + 20, y + tall * 0.95, alpha )
end

SWEP.Base               = "tttws_basegrenade"

SWEP.Kind               = WEAPON_NADE
SWEP.WeaponID           = AMMO_MOLOTOV

SWEP.UseHands           = true
SWEP.ViewModel          = "models/weapons/cstrike/c_eq_flashbang.mdl"
SWEP.WorldModel         = "models/weapons/w_eq_flashbang.mdl"

SWEP.Weight             = 5
SWEP.Spawnable          = true
SWEP.Category           = "TTT weapons for Sandbox"

-- really the only difference between grenade weapons: the model and the thrown
-- ent.

function SWEP:GetGrenadeName()
   return "tttws_firegrenade_proj"
end
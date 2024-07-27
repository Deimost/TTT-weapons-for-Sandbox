AddCSLuaFile()

SWEP.HoldType              = "pistol"
SWEP.NormalHoldType        = "pistol"

if CLIENT then
   SWEP.PrintName          = "Deagle"
   SWEP.Slot               = 1
   SWEP.SlotPos            = 5

   SWEP.ViewModelFlip      = false
   SWEP.ViewModelFOV       = 54
   SWEP.DrawWeaponInfoBox  = false

   SWEP.IconOverride       = "vgui/entities/tttws_deagle.png"
end

function SWEP:DrawWeaponSelection( x, y, wide, tall, alpha )
   local char = "f"
   local textWidth, textHeight = surface.GetTextSize(char)
   local xPos = x + (wide - textWidth) * 0.5
   local yPos = y + (tall - textHeight) * 0.15
   draw.SimpleText( "f", "TTTSelectIcons", xPos, yPos, Color( 255, 250, 0, 255 ), TEXT_ALIGN_CENTER )
   draw.SimpleText( "f", "TTTSelectIcons2", xPos, yPos, Color( 255, 250, 0, 255 ), TEXT_ALIGN_CENTER )
end

SWEP.Base                  = "tttws_base"
SWEP.Category              = "TTT weapons for Sandbox"

SWEP.Primary.Ammo          = "tttws_deagle" -- hijack an ammo type we don't use otherwise
SWEP.Primary.Recoil        = 6
SWEP.Primary.Damage        = 37
SWEP.Primary.Delay         = 0.6
SWEP.Primary.Cone          = 0.02
SWEP.Primary.ClipSize      = 8
SWEP.Primary.ClipMax       = 36
SWEP.Primary.DefaultClip   = 8
SWEP.Primary.Automatic     = true
SWEP.Primary.Sound         = Sound( "Weapon_Deagle.Single" )

SWEP.HeadshotMultiplier    = 4

SWEP.Spawnable             = true
SWEP.AmmoEnt               = "tttws_item_ammo_deagle"

SWEP.UseHands              = true
SWEP.ViewModel             = "models/weapons/cstrike/c_pist_deagle.mdl"
SWEP.WorldModel            = "models/weapons/w_pist_deagle.mdl"

SWEP.IronSightsPos         = Vector(-6.361, -3.701, 2.15)
SWEP.IronSightsAng         = Vector(0, 0, 0)

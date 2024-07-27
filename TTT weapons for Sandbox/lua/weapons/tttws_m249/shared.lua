AddCSLuaFile()

SWEP.HoldType              = "crossbow"

if CLIENT then
   SWEP.PrintName          = "H.U.G.E-249"
   SWEP.Slot               = 2

   SWEP.ViewModelFlip      = false
   SWEP.ViewModelFOV       = 54
   SWEP.DrawWeaponInfoBox  = false

   SWEP.IconOverride       = "vgui/entities/tttws_m249.png"
end

function SWEP:DrawWeaponSelection( x, y, wide, tall, alpha )
   local char = "z"
   local textWidth, textHeight = surface.GetTextSize(char)
   local xPos = x + (wide - textWidth) * 0.5
   local yPos = y + (tall - textHeight) * 0.15
   draw.SimpleText( "z", "TTTSelectIcons", xPos, yPos, Color( 255, 250, 0, 255 ), TEXT_ALIGN_CENTER )
   draw.SimpleText( "z", "TTTSelectIcons2", xPos, yPos, Color( 255, 250, 0, 255 ), TEXT_ALIGN_CENTER )
end

SWEP.Base                  = "tttws_base"
SWEP.Category              = "TTT weapons for Sandbox"

SWEP.Spawnable             = true

SWEP.Primary.Damage        = 7
SWEP.Primary.Delay         = 0.06
SWEP.Primary.Cone          = 0.09
SWEP.Primary.ClipSize      = 150
SWEP.Primary.ClipMax       = 150
SWEP.Primary.DefaultClip   = 150
SWEP.Primary.Automatic     = true
SWEP.Primary.Ammo          = "AirboatGun"
SWEP.Primary.Recoil        = 1.9
SWEP.Primary.Sound         = Sound("Weapon_m249.Single")

SWEP.UseHands              = true
SWEP.ViewModel             = "models/weapons/cstrike/c_mach_m249para.mdl"
SWEP.WorldModel            = "models/weapons/w_mach_m249para.mdl"

SWEP.HeadshotMultiplier    = 2.2

SWEP.IronSightsPos         = Vector(-5.96, -5.119, 2.349)
SWEP.IronSightsAng         = Vector(0, 0, 0)
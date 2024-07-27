AddCSLuaFile()

SWEP.HoldType              = "pistol"
SWEP.NormalHoldType        = "pistol"

if CLIENT then
   SWEP.PrintName          = "Glock"
   SWEP.Slot               = 1
   SWEP.SlotPos            = 5

   SWEP.ViewModelFlip      = false
   SWEP.ViewModelFOV       = 54
   SWEP.DrawWeaponInfoBox  = false

   SWEP.IconOverride       = "vgui/entities/tttws_glock.png"
end

function SWEP:DrawWeaponSelection( x, y, wide, tall, alpha )
   local char = "c"
   local textWidth, textHeight = surface.GetTextSize(char)
   local xPos = x + (wide - textWidth) * 0.5
   local yPos = y + (tall - textHeight) * 0.15
   draw.SimpleText( "c", "TTTSelectIcons", xPos, yPos, Color( 255, 250, 0, 255 ), TEXT_ALIGN_CENTER )
   draw.SimpleText( "c", "TTTSelectIcons2", xPos, yPos, Color( 255, 250, 0, 255 ), TEXT_ALIGN_CENTER )
end

SWEP.Base                  = "tttws_base"
SWEP.Category              = "TTT weapons for Sandbox"
SWEP.Spawnable             = true

SWEP.Primary.Recoil        = 0.9
SWEP.Primary.Damage        = 12
SWEP.Primary.Delay         = 0.10
SWEP.Primary.Cone          = 0.028
SWEP.Primary.ClipSize      = 20
SWEP.Primary.Automatic     = true
SWEP.Primary.DefaultClip   = 20
SWEP.Primary.ClipMax       = 60
SWEP.Primary.Ammo          = "tttws_9mm"
SWEP.Primary.Sound         = Sound( "Weapon_Glock.Single" )

SWEP.AmmoEnt               = "tttws_item_ammo_9mm"

SWEP.HeadshotMultiplier    = 1.75

SWEP.UseHands              = true
SWEP.ViewModel             = "models/weapons/cstrike/c_pist_glock18.mdl"
SWEP.WorldModel            = "models/weapons/w_pist_glock18.mdl"

SWEP.IronSightsPos         = Vector( -5.79, -3.9982, 2.8289 )
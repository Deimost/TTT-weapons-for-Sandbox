AddCSLuaFile()

SWEP.HoldType              = "pistol"
SWEP.NormalHoldType        = "pistol"

if CLIENT then
   SWEP.PrintName          = "#tttwfs_pistol_name"
   SWEP.Slot               = 1
   SWEP.SlotPos            = 5

   SWEP.ViewModelFlip      = false
   SWEP.ViewModelFOV       = 54
   SWEP.DrawWeaponInfoBox  = false

   SWEP.IconOverride       = "vgui/entities/tttws_pistol.png"
end

function SWEP:DrawWeaponSelection( x, y, wide, tall, alpha )
   local char = "u"
   local textWidth, textHeight = surface.GetTextSize(char)
   local xPos = x + (wide - textWidth) * 0.5
   local yPos = y + (tall - textHeight) * 0.15
   draw.SimpleText( "u", "TTTSelectIcons", xPos, yPos, Color( 255, 250, 0, 255 ), TEXT_ALIGN_CENTER )
   draw.SimpleText( "u", "TTTSelectIcons2", xPos, yPos, Color( 255, 250, 0, 255 ), TEXT_ALIGN_CENTER )
end

SWEP.Base                  = "tttws_base"
SWEP.Category              = "TTT weapons for Sandbox"
SWEP.Spawnable             = true

SWEP.Primary.Recoil        = 1.5
SWEP.Primary.Damage        = 25
SWEP.Primary.Delay         = 0.38
SWEP.Primary.Cone          = 0.02
SWEP.Primary.ClipSize      = 20
SWEP.Primary.Automatic     = true
SWEP.Primary.DefaultClip   = 20
SWEP.Primary.ClipMax       = 60
SWEP.Primary.Ammo          = "tttws_9mm"
SWEP.Primary.Sound         = Sound( "Weapon_FiveSeven.Single" )

SWEP.AmmoEnt               = "tttws_item_ammo_9mm"

SWEP.UseHands              = true
SWEP.ViewModel             = "models/weapons/cstrike/c_pist_fiveseven.mdl"
SWEP.WorldModel            = "models/weapons/w_pist_fiveseven.mdl"

SWEP.IronSightsPos         = Vector(-5.95, -4, 2.799)
SWEP.IronSightsAng         = Vector(0, 0, 0)

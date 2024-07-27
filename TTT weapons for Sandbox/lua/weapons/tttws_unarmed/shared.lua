AddCSLuaFile()

SWEP.HoldType               = "normal"

if CLIENT then
   SWEP.PrintName           = "#tttwfs_unarmed_name"
   SWEP.Slot                = 0
   SWEP.SlotPos             = 5

   SWEP.DrawWeaponInfoBox  = false

   SWEP.ViewModelFOV        = 10
   SWEP.IconOverride       = "vgui/entities/tttws_unarmed.png"
end

function SWEP:DrawWeaponSelection( x, y, wide, tall, alpha )
   local char = "U"
   local textWidth, textHeight = surface.GetTextSize(char)
   local xPos = x + (wide - textWidth) * 0.5
   local yPos = y + (tall - textHeight) * 0.15
   draw.SimpleText( "U", "TTTSelectIcons", xPos, yPos, Color( 255, 250, 0, 255 ), TEXT_ALIGN_CENTER )
   draw.SimpleText( "U", "TTTSelectIcons2", xPos, yPos, Color( 255, 250, 0, 255 ), TEXT_ALIGN_CENTER )
end

SWEP.Base                   = "tttws_base"

SWEP.ViewModel              = "models/weapons/v_crowbar.mdl"
SWEP.WorldModel             = "models/weapons/w_crowbar.mdl"

SWEP.Primary.ClipSize       = -1
SWEP.Primary.DefaultClip    = -1
SWEP.Primary.Automatic      = false
SWEP.Primary.Ammo           = "none"

SWEP.Secondary.ClipSize     = -1
SWEP.Secondary.DefaultClip  = -1
SWEP.Secondary.Automatic    = false
SWEP.Secondary.Ammo         = "none"

SWEP.AllowDelete            = false
SWEP.AllowDrop              = false
SWEP.NoSights               = true
SWEP.Spawnable              = true
SWEP.Category               = "TTT weapons for Sandbox"

function SWEP:GetClass()
   return "tttws_unarmed"
end

function SWEP:OnDrop()
   self:Remove()
end

function SWEP:ShouldDropOnDie()
   return false
end

function SWEP:PrimaryAttack()
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end

function SWEP:Deploy()
   if SERVER and IsValid(self:GetOwner()) then
      self:GetOwner():DrawViewModel(false)
   end

   self:DrawShadow(false)

   return true
end

function SWEP:Holster()
   return true
end

function SWEP:DrawWorldModel()
end

function SWEP:DrawWorldModelTranslucent()
end

AddCSLuaFile()

SWEP.HoldType              = "pistol"

if CLIENT then
   SWEP.PrintName          = "#tttwfs_sipistol_name"
   SWEP.Instructions       = "#tttwfs_sipistol_desc0\n#tttwfs_sipistol_desc1\n#tttwfs_sipistol_desc2"
   SWEP.Slot               = 1
   SWEP.SlotPos            = 5

   SWEP.ViewModelFlip      = false
   SWEP.ViewModelFOV       = 54

   -- SWEP.EquipMenuData = {
   --    type = "item_weapon",
   --    desc = "#tttwfs_sipistol_desc"
   -- };

   SWEP.IconOverride       = "vgui/entities/tttws_sipistol.png"
end

function SWEP:DrawWeaponSelection( x, y, wide, tall, alpha )
   local char = "a"
   local textWidth, textHeight = surface.GetTextSize(char)
   local xPos = x + (wide - textWidth) * 0.5
   local yPos = y + (tall - textHeight) * 0.15
   draw.SimpleText( "a", "TTTSelectIcons", xPos, yPos, Color( 255, 250, 0, 255 ), TEXT_ALIGN_CENTER )
   draw.SimpleText( "a", "TTTSelectIcons2", xPos, yPos, Color( 255, 250, 0, 255 ), TEXT_ALIGN_CENTER )

   self:PrintWeaponInfo( x + wide + 20, y + tall * 0.95, alpha )
end

SWEP.Base                  = "tttws_base"
SWEP.Category              = "TTT weapons for Sandbox"
SWEP.Spawnable             = true

SWEP.Primary.Recoil        = 1.35
SWEP.Primary.Damage        = 28
SWEP.Primary.Delay         = 0.38
SWEP.Primary.Cone          = 0.02
SWEP.Primary.ClipSize      = 20
SWEP.Primary.Automatic     = true
SWEP.Primary.DefaultClip   = 20
SWEP.Primary.ClipMax       = 60
SWEP.Primary.Ammo          = "tttws_9mm"
SWEP.Primary.Sound         = Sound( "Weapon_USP.SilencedShot" )
SWEP.Primary.SoundLevel    = 50

SWEP.AmmoEnt               = "tttws_item_ammo_9mm"
SWEP.IsSilent              = true

SWEP.UseHands              = true
SWEP.ViewModel             = "models/weapons/cstrike/c_pist_usp.mdl"
SWEP.WorldModel            = "models/weapons/w_pist_usp_silencer.mdl"

SWEP.IronSightsPos         = Vector( -5.91, -4, 2.84 )
SWEP.IronSightsAng         = Vector(-0.5, 0, 0)

SWEP.PrimaryAnim           = ACT_VM_PRIMARYATTACK_SILENCED
SWEP.ReloadAnim            = ACT_VM_RELOAD_SILENCED

function SWEP:Deploy()
   self:SendWeaponAnim(ACT_VM_DRAW_SILENCED)
   return self.BaseClass.Deploy(self)
end

-- We were bought as special equipment, and we have an extra to give
function SWEP:WasBought(buyer)
   if IsValid(buyer) then -- probably already self:GetOwner()
      buyer:GiveAmmo( 20, "Pistol" )
   end
end

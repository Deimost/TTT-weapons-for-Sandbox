AddCSLuaFile()

SWEP.HoldType            = "ar2"
SWEP.NormalHoldType      = "ar2"

if CLIENT then
   SWEP.PrintName        = "MAC10"
   SWEP.Slot             = 2
   SWEP.SlotPos          = 5

   SWEP.ViewModelFlip    = false
   SWEP.ViewModelFOV     = 54
   SWEP.DrawWeaponInfoBox  = false

   SWEP.IconOverride       = "vgui/entities/tttws_mac10.png"
end

function SWEP:DrawWeaponSelection( x, y, wide, tall, alpha )
   local char = "l"
   local textWidth, textHeight = surface.GetTextSize(char)
   local xPos = x + (wide - textWidth) * 0.5
   local yPos = y + (tall - textHeight) * 0.15
   draw.SimpleText( "l", "TTTSelectIcons", xPos, yPos, Color( 255, 250, 0, 255 ), TEXT_ALIGN_CENTER )
   draw.SimpleText( "l", "TTTSelectIcons2", xPos, yPos, Color( 255, 250, 0, 255 ), TEXT_ALIGN_CENTER )
end

SWEP.Base                  = "tttws_base"
SWEP.Category              = "TTT weapons for Sandbox"
SWEP.Spawnable             = true

SWEP.Primary.Damage      = 12
SWEP.Primary.Delay       = 0.065
SWEP.Primary.Cone        = 0.03
SWEP.Primary.ClipSize    = 30
SWEP.Primary.ClipMax     = 60
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Automatic   = true
SWEP.Primary.Ammo        = "tttws_smg"
SWEP.Primary.Recoil      = 1.15
SWEP.Primary.Sound       = Sound( "Weapon_mac10.Single" )

SWEP.AmmoEnt             = "tttws_item_ammo_smg"

SWEP.UseHands            = true
SWEP.ViewModel           = "models/weapons/cstrike/c_smg_mac10.mdl"
SWEP.WorldModel          = "models/weapons/w_smg_mac10.mdl"

SWEP.IronSightsPos       = Vector(-8.921, -9.528, 2.9)
SWEP.IronSightsAng       = Vector(0.699, -5.301, -7)

SWEP.DeploySpeed         = 3

function SWEP:GetHeadshotMultiplier(victim, dmginfo)
   local att = dmginfo:GetAttacker()
   if not IsValid(att) then return 2 end

   local dist = victim:GetPos():Distance(att:GetPos())
   local d = math.max(0, dist - 150)

   -- decay from 3.2 to 1.7
   return 1.7 + math.max(0, (1.5 - 0.002 * (d ^ 1.25)))
end

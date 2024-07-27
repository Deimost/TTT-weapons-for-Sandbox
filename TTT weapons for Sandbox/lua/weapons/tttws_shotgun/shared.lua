AddCSLuaFile()

-- DEFINE_BASECLASS "weapon_tttbase"

SWEP.HoldType              = "shotgun"
SWEP.NormalHoldType        = "shotgun"

if CLIENT then
   SWEP.PrintName          = "#tttwfs_shotgun_name"
   SWEP.Slot               = 3
   SWEP.SlotPos            = 5

   SWEP.ViewModelFlip      = false
   SWEP.ViewModelFOV       = 54
   SWEP.DrawWeaponInfoBox  = false

   SWEP.IconOverride       = "vgui/entities/tttws_shotgun.png"
end

function SWEP:DrawWeaponSelection( x, y, wide, tall, alpha )
   local char = "B"
   local textWidth, textHeight = surface.GetTextSize(char)
   local xPos = x + (wide - textWidth) * 0.5
   local yPos = y + (tall - textHeight) * 0.15
   draw.SimpleText( "B", "TTTSelectIcons", xPos, yPos, Color( 255, 250, 0, 255 ), TEXT_ALIGN_CENTER )
   draw.SimpleText( "B", "TTTSelectIcons2", xPos, yPos, Color( 255, 250, 0, 255 ), TEXT_ALIGN_CENTER )

end

SWEP.Base                  = "tttws_base"
SWEP.Category              = "TTT weapons for Sandbox"

SWEP.Primary.Ammo          = "tttws_shotgun"
SWEP.Primary.Damage        = 11
SWEP.Primary.Cone          = 0.082
SWEP.Primary.Delay         = 0.8
SWEP.Primary.ClipSize      = 8
SWEP.Primary.ClipMax       = 24
SWEP.Primary.DefaultClip   = 8
SWEP.Primary.Automatic     = true
SWEP.Primary.NumShots      = 8
SWEP.Primary.Sound         = Sound( "Weapon_XM1014.Single" )
SWEP.Primary.Recoil        = 7

SWEP.Spawnable             = true
SWEP.AmmoEnt               = "tttws_item_box_shotgun"

SWEP.UseHands              = true
SWEP.ViewModel             = "models/weapons/cstrike/c_shot_xm1014.mdl"
SWEP.WorldModel            = "models/weapons/w_shot_xm1014.mdl"

SWEP.IronSightsPos         = Vector(-6.881, -9.214, 2.66)
SWEP.IronSightsAng         = Vector(-0.101, -0.7, -0.201)

SWEP.reloadtimer = 0
 
function SWEP:SetupDataTables()
   self:DTVar("Bool", 0, "reloading")
 
   return self.BaseClass.SetupDataTables(self)
end

if game.SinglePlayer() then
   function SWEP:Reload()
      self:SetIronsights( false )
   
      --if self.Weapon:GetNetworkedBool( "reloading", false ) then return end
      if self.dt.reloading then return end
   
      if not IsFirstTimePredicted() then return end
   
      if self.Weapon:Clip1() < self.Primary.ClipSize and self.Owner:GetAmmoCount( self.Primary.Ammo ) > 0 then
      
         if self:StartReload() then
            if self.Owner:GetAmmoCount(self.Primary.Ammo) <= 0 then
               self:FinishReload()
            elseif self.Weapon:Clip1() < self.Primary.ClipSize then
               hook.Add("Think", "TTTWShotgunStopReload", function()
                  if self.dt.reloading and IsFirstTimePredicted() then
                     if self.Owner:KeyDown(IN_ATTACK) then
                        self:FinishReload()
                        hook.Remove("Think", "TTTWShotgunStopReload")
                        timer.Remove("Reload")
                        return
                     end
                  end
               end)
               timer.Create("Reload", self.Weapon:SequenceDuration(), self.Primary.ClipSize - self.Weapon:Clip1(),
                  function() 
                     self:PerformReload()
                     if self.Weapon:Clip1() == self.Primary.ClipSize then
                        timer.Create("Reload", self.Weapon:SequenceDuration(), 1, 
                        function() 
                           self:FinishReload() 
                           hook.Remove("Think", "TTTWShotgunStopReload")
                        end)
                     end
                  end)
            else
               self:FinishReload()
            end
            return
         end
      end
   end
else
   function SWEP:Reload()
      self:SetIronsights( false )
   
      --if self.Weapon:GetNetworkedBool( "reloading", false ) then return end
      if self.dt.reloading then return end
   
      if not IsFirstTimePredicted() then return end
   
      if self.Weapon:Clip1() < self.Primary.ClipSize and self.Owner:GetAmmoCount( self.Primary.Ammo ) > 0 then
      
         if self:StartReload() then
            return
         end
      end
   end
 
   function SWEP:Think()
      if self.dt.reloading and IsFirstTimePredicted() then
         if self.Owner:KeyDown(IN_ATTACK) then
            self:FinishReload()
            return
         end
      
         if self.reloadtimer <= CurTime() then
         
            if self.Owner:GetAmmoCount(self.Primary.Ammo) <= 0 then
               self:FinishReload()
            elseif self.Weapon:Clip1() < self.Primary.ClipSize then
               self:PerformReload()
            else
               self:FinishReload()
            end
            return            
         end
      end
   end
end
 
function SWEP:StartReload()
   --if self.Weapon:GetNWBool( "reloading", false ) then
   if self.dt.reloading then
      return false
   end
 
   if not IsFirstTimePredicted() then return false end
 
   self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
 
   local ply = self.Owner
 
   if not ply or ply:GetAmmoCount(self.Primary.Ammo) <= 0 then 
      return false
   end
 
   local wep = self.Weapon
 
   if wep:Clip1() >= self.Primary.ClipSize then 
      return false 
   end
 
   wep:SendWeaponAnim(ACT_SHOTGUN_RELOAD_START)
 
   self.reloadtimer =  CurTime() + wep:SequenceDuration()
 
   --wep:SetNWBool("reloading", true)
   self.dt.reloading = true
 
   return true
end
 
function SWEP:PerformReload()
   local ply = self.Owner
 
   -- prevent normal shooting in between reloads
   self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
 
   if not ply or ply:GetAmmoCount(self.Primary.Ammo) <= 0 then return end
 
   local wep = self.Weapon
 
   if wep:Clip1() >= self.Primary.ClipSize then return end
 
   self.Owner:RemoveAmmo( 1, self.Primary.Ammo, false )
   self.Weapon:SetClip1( self.Weapon:Clip1() + 1 )
 
   wep:SendWeaponAnim(ACT_VM_RELOAD)
 
   self.reloadtimer = CurTime() + wep:SequenceDuration()
end
 
function SWEP:FinishReload()
   self.dt.reloading = false
   self.Weapon:SendWeaponAnim(ACT_SHOTGUN_RELOAD_FINISH)
 
   self.reloadtimer = CurTime() + self.Weapon:SequenceDuration()
end
 
function SWEP:CanPrimaryAttack()
   if self.Weapon:Clip1() <= 0 then
      self:EmitSound( "Weapon_Shotgun.Empty" )
      self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
      return false
   end
   return true
end

function SWEP:Deploy()
   self.dt.reloading = false
   self.reloadtimer = 0
   -- return BaseClass.Deploy(self)
end

-- The shotgun's headshot damage multiplier is based on distance. The closer it
-- is, the more damage it does. This reinforces the shotgun's role as short
-- range weapon by reducing effectiveness at mid-range, where one could score
-- lucky headshots relatively easily due to the spread.
function SWEP:GetHeadshotMultiplier(victim, dmginfo)
   local att = dmginfo:GetAttacker()
   if not IsValid(att) then return 3 end

   local dist = victim:GetPos():Distance(att:GetPos())
   local d = math.max(0, dist - 140)

   -- Decay from 2 to 1 slowly as distance increases. Note that this used to be
   -- 3+, but at that time shotgun bullets were treated like in HL2 where half
   -- of them were hull traces that could not headshot.
   return 1 + math.max(0, (1.0 - 0.002 * (d ^ 1.25)))
end

function SWEP:SetZoom(state)
   if not (IsValid(self:GetOwner()) and self:GetOwner():IsPlayer()) then return end
   if state then
      self:GetOwner():SetFOV(35, 0.5)
   else
      self:GetOwner():SetFOV(0, 0.2)
   end
end

function SWEP:SecondaryAttack()
   if self.NoSights or (not self.IronSightsPos) or (self.dt.reloading == true) then return end

   self:SetIronsights(not self:GetIronsights())

   self:SetNextSecondaryFire(CurTime() + 0.3)

end
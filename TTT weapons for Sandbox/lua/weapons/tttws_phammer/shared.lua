AddCSLuaFile()

DEFINE_BASECLASS "tttws_base"

SWEP.HoldType              = "ar2"

if CLIENT then
   SWEP.PrintName          = "#tttwfs_polter_name"
   SWEP.Instructions       = "#tttwfs_polter_desc0\n#tttwfs_polter_desc1\n\n#tttwfs_polter_desc2\n#tttwfs_polter_desc3"
   SWEP.Slot               = 4
   SWEP.SlotPos            = 4

   SWEP.ViewModelFlip      = false
   SWEP.ViewModelFOV       = 54

   -- SWEP.EquipMenuData = {
   --    type = "item_weapon",
   --    desc = "polter_desc"
   -- };

   SWEP.IconOverride       = "vgui/entities/tttws_phammer.png"
end

function SWEP:DrawWeaponSelection( x, y, wide, tall, alpha )
   local char = "l"
   local textWidth, textHeight = surface.GetTextSize(char)
   local xPos = x + (wide - textWidth) * 0.5
   local yPos = y + (tall - textHeight) * 0.15
   draw.SimpleText("l", "HL2SelectIcons", xPos, yPos, Color( 255, 250, 0, 255 ), TEXT_ALIGN_CENTER )
   draw.SimpleText("l", "HL2SelectIcons2", xPos, yPos, Color( 255, 250, 0, 255 ), TEXT_ALIGN_CENTER )
   self:PrintWeaponInfo( x + wide + 20, y + tall * 0.95, alpha )
end

SWEP.Base                  = "tttws_base"
SWEP.Category              = "TTT weapons for Sandbox"
SWEP.Spawnable             = true

SWEP.Primary.Recoil        = 0.1
SWEP.Primary.Delay         = 12.0
SWEP.Primary.Cone          = 0.02
SWEP.Primary.ClipSize      = 6
SWEP.Primary.DefaultClip   = 6
SWEP.Primary.ClipMax       = 6
SWEP.Primary.Ammo          = "Gravity"
SWEP.Primary.Automatic     = false
SWEP.Primary.Sound         = Sound( "weapons/airboat/airboat_gun_energy1.wav" )

SWEP.Secondary.Automatic   = false

SWEP.UseHands              = true
SWEP.ViewModel             = "models/weapons/c_irifle.mdl"
SWEP.WorldModel            = "models/weapons/w_IRifle.mdl"

SWEP.NoSights              = true

SWEP.IsCharging            = false
SWEP.NextCharge            = 0
SWEP.MaxRange              = 800

function AccessorFuncDT(tbl, varname, name)
   tbl["Get" .. name] = function(s) return s.dt and s.dt[varname] end
   tbl["Set" .. name] = function(s, v) if s.dt then s.dt[varname] = v end end
end

AccessorFuncDT(SWEP, "charge", "Charge")

local math = math

-- Returns if an entity is a valid physhammer punching target. Does not take
-- distance into account.
local function ValidTarget(ent)
   return IsValid(ent) and ent:GetMoveType() == MOVETYPE_VPHYSICS and ent:GetPhysicsObject() and (not ent:IsWeapon()) and (not ent:GetNWBool("punched", false)) and (not ent:IsPlayer())
   -- NOTE: cannot check for motion disabled on client
end

function SWEP:SetupDataTables()
   self:DTVar("Float", 0, "charge")
end

local ghostmdl = Model("models/Items/combine_rifle_ammo01.mdl")
function SWEP:Initialize()
   if CLIENT then
      -- create ghosted indicator
      local ghost = ents.CreateClientProp(ghostmdl)
      if IsValid(ghost) then
         ghost:SetPos(self:GetPos())
         ghost:Spawn()

         -- PhysPropClientside whines here about not being able to parse the
         -- physmodel. This is not important as we won't use that anyway, and it
         -- happens in sandbox as well for the ghosted ents used there.

         ghost:SetSolid(SOLID_NONE)
         ghost:SetMoveType(MOVETYPE_NONE)
         ghost:SetNotSolid(true)
         ghost:SetRenderMode(RENDERMODE_TRANSCOLOR)
         ghost:AddEffects(EF_NOSHADOW)
         ghost:SetNoDraw(true)

         self.Ghost = ghost
      end
   end

   self.IsCharging = false
   self:SetCharge(0)

   return self.BaseClass.Initialize(self)
end

function SWEP:PreDrop()
   self.IsCharging = false
   self:SetCharge(0)

   -- OnDrop does not happen on client
   self:CallOnClient("HideGhost", "")
end

function SWEP:HideGhost()
   if IsValid(self.Ghost) then
      self.Ghost:SetNoDraw(true)
   end
end

function SWEP:PrimaryAttack()
   self:SetNextPrimaryFire(CurTime() + 0.1)
   if not self:CanPrimaryAttack() then return end
   if IsValid(self.hammer) then return end
   if SERVER then
      if self.IsCharging then return end

      local ply = self:GetOwner()
      if not IsValid(ply) then return end

      local tr = util.TraceLine({start=ply:GetShootPos(), endpos=ply:GetShootPos() + ply:GetAimVector() * self.MaxRange, filter={ply, self.Entity}, mask=MASK_SOLID})

      if tr.HitNonWorld and ValidTarget(tr.Entity) and tr.Entity:GetPhysicsObject():IsMoveable() then

         self:CreateHammer(tr.Entity, tr.HitPos)

         self:EmitSound(self.Primary.Sound)

         self:TakePrimaryAmmo(1)

         self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
      end
   end
end

function SWEP:SecondaryAttack()
   if self.IsCharging then return end

   self:SetNextSecondaryFire( CurTime() + 0.1 )

   if not (self:CanPrimaryAttack() and (self:GetNextPrimaryFire() - CurTime()) <= 0) then return end
   if IsValid(self.hammer) then return end
   if SERVER then
      local ply = self:GetOwner()
      if not IsValid(ply) then return end

      local range = 30000

      local tr = util.TraceLine({start=ply:GetShootPos(), endpos=ply:GetShootPos() + ply:GetAimVector() * range, filter={ply, self.Entity}, mask=MASK_SOLID})

      if tr.HitNonWorld and ValidTarget(tr.Entity) and tr.Entity:GetPhysicsObject():IsMoveable() then

         if self.IsCharging and self:GetCharge() >= 1 then
            return
         elseif tr.Fraction * range > self.MaxRange then
            self.IsCharging = true
         end
      end
   end
end

function SWEP:CreateHammer(tgt, pos)
   local hammer = ents.Create("tttws_physhammer")
   if IsValid(hammer) then
      local ang = self:GetOwner():GetAimVector():Angle()
      ang:RotateAroundAxis(ang:Right(), 90)

      hammer:SetPos(pos)
      hammer:SetAngles(ang)

      hammer:Spawn()

      hammer:SetOwner(self:GetOwner())

      local stuck = hammer:StickTo(tgt)

      if not stuck then hammer:Remove() end
      self.hammer = hammer
   end
end

function SWEP:OnRemove()
   if CLIENT and IsValid(self.Ghost) then
      self.Ghost:Remove()
   end

   self.IsCharging = false
   self:SetCharge(0)
end

function SWEP:Holster()
   if CLIENT and IsValid(self.Ghost) then
      self.Ghost:SetNoDraw(true)
   end

   self.IsCharging = false
   self:SetCharge(0)

   return self.BaseClass.Holster(self)
end


if SERVER then

   local CHARGE_AMOUNT = 0.015
   local CHARGE_DELAY = 0.025

   function SWEP:Think()
      BaseClass.Think(self)
      if not IsValid(self:GetOwner()) then return end

      if self.IsCharging and self:GetOwner():KeyDown(IN_ATTACK2) then
         local tr = self:GetOwner():GetEyeTrace(MASK_SOLID)
         if tr.HitNonWorld and ValidTarget(tr.Entity) then

            if self:GetCharge() >= 1 then
               self:CreateHammer(tr.Entity, tr.HitPos)

               self:EmitSound(self.Primary.Sound)

               self:TakePrimaryAmmo(1)

               self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

               self.IsCharging = false
               self:SetCharge(0)
               return true
            elseif self.NextCharge < CurTime() then
               local d = tr.Entity:GetPos():Distance(self:GetOwner():GetPos())
               local f = math.max(1, math.floor(d / self.MaxRange))

               self:SetCharge(math.min(1, self:GetCharge() + (CHARGE_AMOUNT / f)))

               self.NextCharge = CurTime() + CHARGE_DELAY
            end
         else
            self.IsCharging = false
            self:SetCharge(0)
         end

      elseif self:GetCharge() > 0 then
         -- owner let go of rmouse
         self:SetCharge(0)
         self.IsCharging = false
      end
   end
end

local function around( val )
   return math.Round( val * (10 ^ 3) ) / (10 ^ 3);
end

if CLIENT then
   local surface = surface

   function SWEP:UpdateGhost(pos, c, a)
      if IsValid(self.Ghost) then
         if self.Ghost:GetPos() != pos then
            self.Ghost:SetPos(pos)
            local ang = LocalPlayer():GetAimVector():Angle()
            ang:RotateAroundAxis(ang:Right(), 90)

            self.Ghost:SetAngles(ang)

            -- self.Ghost:SetColor(Color(c.r, c.g, c.b, a))

            self.Ghost:SetNoDraw(false)
         end
      end
   end

   local linex = 0
   local liney = 0
   local laser = Material("trails/laser")
   function SWEP:ViewModelDrawn()
      local client = LocalPlayer()
      local vm = client:GetViewModel()
      if not IsValid(vm) then return end

      local plytr = client:GetEyeTrace(MASK_SHOT)

      local muzzle_angpos = vm:GetAttachment(1)
      local spos = muzzle_angpos.Pos + muzzle_angpos.Ang:Forward() * 10
      local epos = client:GetShootPos() + client:GetAimVector() * self.MaxRange

      -- Painting beam
      local tr = util.TraceLine({start=spos, endpos=epos, filter=client, mask=MASK_ALL})

      local c = COLOR_RED
      local a = 150
      local d = (plytr.StartPos - plytr.HitPos):Length()
      if plytr.HitNonWorld then
         if ValidTarget(plytr.Entity) then
            if d < self.MaxRange then
               c = COLOR_GREEN
               a = 255
            else
               c = COLOR_YELLOW
            end
         end
      end

      self:UpdateGhost(plytr.HitPos, c, a)

      render.SetMaterial(laser)
      render.DrawBeam(spos, tr.HitPos, 5, 0, 0, c)

      -- Charge indicator
      local vm_ang = muzzle_angpos.Ang
      local cpos = muzzle_angpos.Pos + (vm_ang:Up() * -9) + (vm_ang:Forward() * -7) + (vm_ang:Right() * 1.5)
      local cang = vm:GetAngles()
      cang:RotateAroundAxis(cang:Forward(), 90)
      cang:RotateAroundAxis(cang:Right(), 90)
      cang:RotateAroundAxis(cang:Up(), 90)

      cam.Start3D2D(cpos, cang, 0.05)

      surface.SetDrawColor(255, 55, 55, 50)
      surface.DrawOutlinedRect(0, 0, 50, 15)

      local sz = 48
      local next = self:GetNextPrimaryFire()
      local ready = (next - CurTime()) <= 0
      local frac = 1.0
      if not ready then
         frac = 1 - ((next - CurTime()) / self.Primary.Delay)
         sz = sz * math.max(0, frac)
      end

      surface.SetDrawColor(255, 10, 10, 170)
      surface.DrawRect(1, 1, sz, 13)

      surface.SetTextColor(255,255,255,15)
      surface.SetFont("Default")
      surface.SetTextPos(2,0)
      surface.DrawText(string.format("%.3f", around(frac)))

      surface.SetDrawColor(0,0,0, 80)
      surface.DrawRect(linex, 1, 3, 13)

      surface.DrawLine(1, liney, 48, liney)

      linex = linex + 3 > 48 and 0 or linex + 1
      liney = liney > 13 and 0 or liney + 1

      cam.End3D2D()

   end

   local draw = draw
   function SWEP:DrawHUD()
      local x = ScrW() / 2.0
      local y = ScrH() / 2.0


      local charge = self.dt.charge

      if charge > 0 then
         y = y + (y / 3)

         local w, h = 100, 20

         surface.DrawOutlinedRect(x - w/2, y - h, w, h)

         if LocalPlayer():IsTraitor() then
            surface.SetDrawColor(255, 0, 0, 155)
         else
            surface.SetDrawColor(0, 255, 0, 155)
         end

         surface.DrawRect(x - w/2, y - h, w * charge, h)

         surface.SetFont("TabLarge")
         surface.SetTextColor(255, 255, 255, 180)
         surface.SetTextPos( (x - w / 2) + 3, y - h - 15)
         surface.DrawText("CHARGE")
      end
   end
end
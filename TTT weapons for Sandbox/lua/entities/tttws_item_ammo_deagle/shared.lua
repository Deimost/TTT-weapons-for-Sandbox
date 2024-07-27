-- Deagle ammo override

AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "tttws_base_ammo"
ENT.AmmoType = "tttws_deagle"
ENT.PrintName = "#tttwfs_ammo_deagle"
ENT.AmmoAmount = 12
ENT.AmmoMax = 36
ENT.Model = Model("models/items/357ammo.mdl")
ENT.AutoSpawnable = true
ENT.Spawnable = true
ENT.AdminSpawnable = true 
ENT.Category = "TTT weapons for Sandbox"
ENT.IconOverride = "vgui/entities/tttws_item_ammo_deagle.png"

function ENT:Initialize()
   -- Differentiate from rifle ammo
   self:SetColor(Color(255, 100, 100, 255))

   return self.BaseClass.Initialize(self)
end

-- Rifle ammo override

AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "tttws_base_ammo"
ENT.AmmoType = "tttws_rifle"
ENT.PrintName = "#tttwfs_ammo_rifle"
ENT.AmmoAmount = 10
ENT.AmmoMax = 20
ENT.Model = Model("models/items/357ammo.mdl")
ENT.AutoSpawnable = true
ENT.Spawnable = true
ENT.AdminSpawnable = true 
ENT.Category = "TTT weapons for Sandbox"
ENT.IconOverride = "vgui/entities/tttws_item_ammo_rifle.png"
-- MAC10 ammo override

AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "tttws_base_ammo"
ENT.AmmoType = "tttws_smg"
ENT.PrintName = "#tttwfs_ammo_smg"
ENT.AmmoAmount = 30
ENT.AmmoMax = 60
ENT.Model = Model("models/items/boxmrounds.mdl")
ENT.AutoSpawnable = true
ENT.Spawnable = true
ENT.AdminSpawnable = true 
ENT.Category = "TTT weapons for Sandbox"
ENT.IconOverride = "vgui/entities/tttws_item_ammo_smg.png"
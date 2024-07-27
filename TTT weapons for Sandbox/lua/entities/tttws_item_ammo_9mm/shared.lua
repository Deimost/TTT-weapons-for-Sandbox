-- Pistol ammo override

AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "tttws_base_ammo"
ENT.PrintName = "#tttwfs_ammo_pistol"
ENT.Author = "Deimost"

ENT.CaliberSpecific = true
ENT.Caliber = "tttws_9mm"
ENT.AmmoAmount = 20
ENT.AmmoMax = 60

ENT.Spawnable = true
ENT.AdminSpawnable = true 
ENT.Category = "TTT weapons for Sandbox"
ENT.Model = Model("models/Items/BoxSRounds.mdl")
ENT.IconOverride = "vgui/entities/tttws_item_ammo_9mm.png"
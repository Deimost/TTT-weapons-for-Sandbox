-- Shottie ammo override

AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "tttws_base_ammo"
ENT.AmmoType = "tttws_shotgun"
ENT.PrintName = "#tttwfs_ammo_shotgun"
ENT.AmmoAmount = 8
ENT.AmmoMax = 24
ENT.Model = "models/items/boxbuckshot.mdl"
ENT.AutoSpawnable = true
ENT.Spawnable = true
ENT.AdminSpawnable = true 
ENT.Category = "TTT weapons for Sandbox"
ENT.IconOverride = "vgui/entities/tttws_item_box_shotgun.png"
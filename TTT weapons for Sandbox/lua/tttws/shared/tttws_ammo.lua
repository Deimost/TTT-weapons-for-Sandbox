AddCSLuaFile()

TTTwfS.ammoTypes = TTTwfS.ammoTypes or {}

-- base ammo registration function
function TTTwfS:registerAmmo(name, text, bulletDiameter, caseLength)
	TTTwfS.ammoTypes[name] = {bulletDiameter = bulletDiameter, caseLength = caseLength}
	
	game.AddAmmoType({name = name,
	dmgtype = DMG_BULLET})
	
	if CLIENT then
		language.Add(name .. "_ammo", text)
	end
end

-- aliases
TTTwfS.registerAmmoType = TTTwfS.registerAmmo
TTTwfS.registerNewAmmo = TTTwfS.registerAmmo

TTTwfS:registerAmmo("tttws_9mm", "9MM AMMO", 9, 19)
TTTwfS:registerAmmo("tttws_smg", "SMG AMMO", 11.5, 22.8)
TTTwfS:registerAmmo("tttws_deagle", "DEAGLE AMMO", 12.7, 32.6)
TTTwfS:registerAmmo("tttws_rifle", "RIFLE AMMO", 9, 32)
TTTwfS:registerAmmo("tttws_shotgun", "SHOTGUN AMMO", 12, 76)
-- TTTwfS:registerAmmo("5.56x45MM", "5.56x45MM Rounds", 5.56, 45)
-- TTTwfS:registerAmmo("5.7x28MM", "5.7x28MM Rounds", 5.7, 28)
-- TTTwfS:registerAmmo(".44 Magnum", ".44 Magnum Rounds", 10.9, 32.6)
-- TTTwfS:registerAmmo(".45 ACP", "SMG A", 11.5, 22.8)
-- TTTwfS:registerAmmo("9x19MM", "9x19MM Rounds", 9, 19)
-- TTTwfS:registerAmmo("12 Gauge", "12 Gauge Rounds", 5, 10)
-- TTTwfS:registerAmmo("40MM", "40MM Grenades", 0, 0)
-- TTTwfS:registerAmmo("Frag Grenades", "Frag Grenades", 0, 0)
-- TTTwfS:registerAmmo("Smoke Grenades", "Smoke Grenades", 0, 0)
-- TTTwfS:registerAmmo("Flash Grenades", "Flash Grenades", 0, 0)
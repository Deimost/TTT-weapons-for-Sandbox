-- function TTTwfS.InitPostEntity()
-- 	local ply = LocalPlayer()
-- 
-- 	TTTwfS.initTTTwfSVariables(ply)
-- end

hook.Add("InitPostEntity", "TTTwfS.InitPostEntity", TTTwfS.InitPostEntity)
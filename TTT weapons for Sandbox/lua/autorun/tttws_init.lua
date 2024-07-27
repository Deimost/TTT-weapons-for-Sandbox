AddCSLuaFile()

-- convenience function which calls AddCSLuaFile and include on the specified file
function loadFile(path)
	AddCSLuaFile(path)
	include(path)
end

-- load client files
-- AddCSLuaFile("autorun/client/cw_cl_init.lua")

-- main table
TTTwfS = {}
TTTwfS.baseFolder = "TTT weapons for Sandbox"

-- load all necessary files
-- do not change the load order
if game.SinglePlayer() then
	include("tttws/server/util.lua")
	include("tttws/server/weaponry_shd.lua")
end

include("tttws/shared/tttws_ammo.lua")

if SERVER then
	-- load server files
	util.AddNetworkString("TTT_FlareScorch")
	include("tttws/server/util.lua")
	include("tttws/server/weaponry_shd.lua")
end

-- OH LOOK AT THAT, I AM GOING TO STORE ATTACHMENT PRESETS IN THE 'DATA' FOLDER
-- ACCORDING TO MAGENTA, DELETING THE 'DATA' FOLDER ON COMPUTERS OF SOME PEOPLE IS NOT A BIG DEAL, SINCE, YOU KNOW, THERE IS NOTHING IMPORTANT IN THERE
-- fuck off cunt
file.CreateDir("TTT weapons for Sandbox")

list.Set( "ContentCategoryIcons", "TTT weapons for Sandbox", "vgui/entities/TTTwSbox.png" )
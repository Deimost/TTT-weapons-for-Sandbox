AddCSLuaFile()

-- convenience function which calls AddCSLuaFile and include on the specified file
function loadFile(path)
	AddCSLuaFile(path)
	include(path)
end

resource.AddSingleFile( "resource/fonts/tttwfsselect.ttf" )
resource.AddSingleFile( "resource/fonts/tttwfskill.ttf" )
resource.AddSingleFile( "resource/halflife2.ttf" )

surface.CreateFont( "TTTSelectIcons", {
	font		= "tttwfsselect",
	size		= 128,
	blursize	= 12,
	scanlines	= 4,
	additive	= true,
	custom		= true,
	opaque		= false,
	outline		= false
} )

surface.CreateFont( "TTTSelectIcons2", {
	font		= "tttwfsselect",
	size		= 128,
	additive	= true,
	custom		= true,
	opaque		= false,
	outline		= false
} )

surface.CreateFont( "HL2SelectIcons", {
	font		= "HalfLife2",
	size		= 128,
	blursize	= 12,
	scanlines	= 4,
	additive	= true,
	custom		= true,
	opaque		= false,
	outline		= false
} )

surface.CreateFont( "HL2SelectIcons2", {
	font		= "HalfLife2",
	size		= 128,
	additive	= true,
	custom		= true,
	opaque		= false,
	outline		= false
} )

surface.CreateFont( "TTTKillIcons", {
	font		= "tttwfskill",
	size		= 65,
	additive	= true,
	custom		= true,
	opaque		= false,
	outline		= false
} )

surface.CreateFont( "HL2KillIcons", {
	font		= "HalfLife2",
	size		= 65,
	additive	= true,
	custom		= true,
	opaque		= false,
	outline		= false
} )

include("autorun/tttws_init.lua")

MODE_HL2WEAPONSELECT = 1
MODE_HL2KILLICON = 2

killicon.AddFont( "tttws_deagle", "TTTKillIcons", "f", Color( 255, 80, 0, 255 ) )
killicon.AddFont( "tttws_glock", "TTTKillIcons", "c", Color( 255, 80, 0, 255 ) )
killicon.AddFont( "tttws_knife", "TTTKillIcons", "j", Color( 255, 80, 0, 255 ) )
killicon.AddFont( "tttws_m16", "TTTKillIcons", "w", Color( 255, 80, 0, 255 ) )
killicon.AddFont( "tttws_m249", "TTTKillIcons", "z", Color( 255, 80, 0, 255 ) )
killicon.AddFont( "tttws_mac10", "TTTKillIcons", "l", Color( 255, 80, 0, 255 ) )
killicon.AddFont( "tttws_pistol", "TTTKillIcons", "u", Color( 255, 80, 0, 255 ) )
killicon.AddFont( "tttws_rifle", "TTTKillIcons", "n", Color( 255, 80, 0, 255 ) )
killicon.AddFont( "tttws_shotgun", "TTTKillIcons", "B", Color( 255, 80, 0, 255 ) )
killicon.AddFont( "tttws_stungun", "TTTKillIcons", "q", Color( 255, 80, 0, 255 ) )

killicon.AddFont( "tttws_flaregun", "TTTKillIcons", "G", Color( 255, 80, 0, 255 ) )
killicon.AddFont( "tttws_improvised", "HL2KillIcons", "^", Color( 255, 80, 0, 255 ) )
killicon.AddFont( "tttws_phammer", "HL2KillIcons", ":", Color( 255, 80, 0, 255 ) )
killicon.AddFont( "tttws_push", "HL2KillIcons", "!", Color( 255, 80, 0, 255 ) )
killicon.AddFont( "tttws_sipistol", "TTTKillIcons", "a", Color( 255, 80, 0, 255 ) )
killicon.AddFont( "tttws_teleport", "TTTKillIcons", "T", Color( 255, 80, 0, 255 ) )
killicon.AddFont( "tttws_physhammer", "HL2KillIcons", ":", Color( 255, 80, 0, 255 ) )
killicon.AddFont( "entityflame", "TTTKillIcons", "F", Color( 255, 80, 0, 255 ) )
killicon.AddFont( "env_fire", "TTTKillIcons", "F", Color( 255, 80, 0, 255 ) )

killicon.AddFont( "tttws_knife_proj", "TTTKillIcons", "j", Color( 255, 80, 0, 255 ) )
killicon.AddFont( "tttws_firegrenade_proj", "TTTKillIcons", "P", Color( 255, 80, 0, 255 ) )
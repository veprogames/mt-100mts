Blacksmith = dofile(minetest.get_modpath("mts_pickcrafting").."/Blacksmith.lua")

dofile(minetest.get_modpath("mts_pickcrafting").."/items.lua")
dofile(minetest.get_modpath("mts_pickcrafting").."/commands.lua")
dofile(minetest.get_modpath("mts_pickcrafting").."/blocks.lua")

Blacksmith.load()
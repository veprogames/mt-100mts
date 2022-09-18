Minerals = dofile(minetest.get_modpath("mts_default").."/Minerals.lua")
Pickaxes = dofile(minetest.get_modpath("mts_default").."/Pickaxes.lua")
MineralDefinition = dofile(minetest.get_modpath("mts_default").."/MineralDefinition.lua")

for i = 1, 100 do
    local def = MineralDefinition.get_definition(i)
    Minerals.register_mineral(def)
    Pickaxes.register_pickaxe(def)
end

for i = 1, 100 do
    Minerals.register_stone(i)
end
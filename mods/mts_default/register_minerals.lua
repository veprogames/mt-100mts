Minerals = dofile(minetest.get_modpath("mts_default").."/Minerals.lua")
MineralDefinition = dofile(minetest.get_modpath("mts_default").."/MineralDefinition.lua")

for i = 1, 100 do
    Minerals.register_mineral(MineralDefinition.get_definition(i))
end

for i = 1, 100 do
    Minerals.register_stone(i)
end
Minerals = dofile(minetest.get_modpath("default").."/Minerals.lua")
MineralDefinition = dofile(minetest.get_modpath("default").."/MineralDefinition.lua")

for i = 1, 100 do
    Minerals.register_mineral(MineralDefinition.generate_definition(i))
end
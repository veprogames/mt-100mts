Minerals = dofile(minetest.get_modpath("default").."/Minerals.lua")

for i = 1, 100 do
    Minerals.register_mineral(i)
end
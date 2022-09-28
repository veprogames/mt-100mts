PickaxeGenerator = dofile(minetest.get_modpath("mts_pickcrafting").."/PickaxeGenerator.lua")
minetest.register_on_joinplayer(function(player, last_login)
    local inv = player:get_inventory()
    local main = inv:get_list("main")
    for k, item in pairs(main) do
        inv:set_stack("main", k, PickaxeGenerator.refresh_pickaxe(item))
    end
end)
PickaxeGenerator = dofile(minetest.get_modpath("mts_pickcrafting").."/PickaxeGenerator.lua")
Blacksmith = dofile(minetest.get_modpath("mts_pickcrafting").."/Blacksmith.lua")

minetest.register_on_joinplayer(function(player, last_login)
    local inv = player:get_inventory()
    local main = inv:get_list("main")
    for k, item in pairs(main) do
        inv:set_stack("main", k, PickaxeGenerator.refresh_pickaxe(item))
    end
end)

minetest.register_on_player_receive_fields(function (player, formname, fields)
    if formname == "mts_pickcrafting:blacksmith" then
        if fields.absorb then
            Blacksmith.absorb_inventory(player:get_player_name())
            Blacksmith.show_formspec(player:get_player_name())
        elseif fields.craft then
            Blacksmith.craft_pickaxe(player)
        end
    end
end)
PickaxeGenerator = dofile(minetest.get_modpath("mts_pickcrafting").."/PickaxeGenerator.lua")

minetest.register_node("mts_pickcrafting:blacksmith", {
    description = "Blacksmith",
    tiles = {"mts_pickcrafting_pickaxe.png"},
    on_rightclick = function (pos, node, clicker, itemstack, pointed_thing)
        local damage = Big:new(10 + 10 * math.random())
        local item = PickaxeGenerator.generate(damage)
        clicker:get_inventory():add_item("main", item)
    end
})
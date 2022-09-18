PickaxeGenerator = dofile(minetest.get_modpath("mts_pickcrafting").."/PickaxeGenerator.lua")

minetest.register_chatcommand("mts_givepickaxe", {
    privs = {give = true},
    func = function (name, damage_as_str)
        local player = minetest.get_player_by_name(name)
        if player ~= nil then
            local damage = Big.parse(damage_as_str)
            local item = PickaxeGenerator.generate(damage)
            player:get_inventory():add_item("main", item)
            return true, "Pickaxe added"
        end
        return false, "Player not found"
    end
})
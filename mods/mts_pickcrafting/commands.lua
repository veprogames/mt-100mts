PickaxeGenerator = dofile(minetest.get_modpath("mts_pickcrafting").."/PickaxeGenerator.lua")
Blacksmith = dofile(minetest.get_modpath("mts_pickcrafting").."/Blacksmith.lua")

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

minetest.register_chatcommand("mts_blacksmith_test", {
    privs = {give = true},
    func = function (name, damage_as_str)
        local m = math.random() * 123
        Blacksmith.data.multipliers.minerals[1] = m
        return true, "Multiplier <1> set to x"..m
    end
})
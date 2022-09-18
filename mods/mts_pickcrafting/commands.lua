minetest.register_chatcommand("mts_givepickaxe", {
    privs = {give = true},
    func = function (name, params)
        local player = minetest.get_player_by_name(name)
        if player ~= nil then
            local item = ItemStack("mts_pickcrafting:pickaxe")
            item:get_meta():set_string("description", minetest.colorize("#8000c0", "Unique Pickaxe"))
            item:get_meta():set_tool_capabilities({
                full_punch_interval = 0.9,
                max_drop_level = 0,
                groupcaps = {
                    cracky = {uses = 0, times = {[10] = 3}}
                }
            })
            player:get_inventory():add_item("main", item)
            return true, "Pickaxe added"
        end
        return false, "Player not found"
    end
})
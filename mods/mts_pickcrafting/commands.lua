Big = dofile(minetest.get_modpath("mts_bignumber").."/bignumber.lua")
Pickaxes = dofile(minetest.get_modpath("mts_default").."/Pickaxes.lua")

local function get_description(damage)
    return minetest.colorize("#00c000", "Unique Pickaxe").."\n\n"..
        minetest.colorize("#00ff00", damage).." DPS"
end

minetest.register_chatcommand("mts_givepickaxe", {
    privs = {give = true},
    func = function (name, params)
        local player = minetest.get_player_by_name(name)
        if player ~= nil then
            local item = ItemStack("mts_pickcrafting:pickaxe")
            local damage = Big:new(10 + 10 * math.random())
            item:get_meta():set_string("description", get_description(damage))
            item:get_meta():set_tool_capabilities(Pickaxes.get_tool_capabilities(damage))
            player:get_inventory():add_item("main", item)
            return true, "Pickaxe added"
        end
        return false, "Player not found"
    end
})
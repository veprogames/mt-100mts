Formatter = dofile(minetest.get_modpath("mts_pickcrafting").."/Formatter.lua")

Pickaxes = dofile(minetest.get_modpath("mts_default").."/Pickaxes.lua")
PickaxeGenerator = {}

local function get_description(damage)
    return minetest.colorize("#00c000", "Unique Pickaxe").."\n\n"..
        minetest.colorize("#00ff00", Formatter.format(damage, 2)).." DPS"
end

function PickaxeGenerator.generate(damage)
    local item = ItemStack("mts_pickcrafting:pickaxe")
    item:get_meta():set_string("description", get_description(damage))
    item:get_meta():set_tool_capabilities(Pickaxes.get_tool_capabilities(damage))
    return item
end

return PickaxeGenerator

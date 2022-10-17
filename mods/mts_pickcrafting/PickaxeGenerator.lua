Big = dofile(minetest.get_modpath("mts_bignumber").."/bignumber.lua")
Formatter = dofile(minetest.get_modpath("mts_formatter").."/Formatter.lua")

Pickaxes = dofile(minetest.get_modpath("mts_default").."/Pickaxes.lua")
PickaxeGenerator = {}

local rarities = {
    {name = "Common", color = "#c0c0c0"},
    {name = "Uncommon", color = "#00ff00"},
    {name = "Rare", color = "#0080ff"},
    {name = "Epic", color = "#ff8080"},
    {name = "Legendary", color = "#ff8000"},
    {name = "Cosmic", color = "#004080"}
}

local function generate_stats(base_damage)
    local rarity = 1

    for i = rarity, #rarities - 1 do
        if math.random() < 0.3 then
            rarity = rarity + 1
        else
            break
        end
    end

    local r = rarity - 1
    local final_damage = base_damage * Big:new(1.0 + math.random()) * Big:new(1.6) ^ r
    final_damage = final_damage ^ (1 + 0.002 * r)
    if final_damage < Big:new(7) then
        final_damage = Big:new(7)
    end
    final_damage = final_damage:floor()

    return {rarity = rarities[rarity], damage = final_damage}
end

local function get_description(rarity, damage)
    local speed_multi = Pickaxes.get_speed_multi(damage)
    return minetest.colorize(rarity.color, rarity.name .. " Pickaxe").."\n"..
        minetest.colorize("#00ff00", Formatter.format(damage, 2)).." DPS" .."\n"..
        minetest.colorize("#00ffb0", string.format("x%.2f", speed_multi)).." Mining Speed on:\nLights and Wood"
end

function PickaxeGenerator.generate(base_damage)
    local stats = generate_stats(base_damage)
    local damage = stats.damage
    local rarity = stats.rarity

    local item = ItemStack("mts_pickcrafting:pickaxe")
    item:get_meta():set_string("description", get_description(rarity, damage))
    item:get_meta():set_tool_capabilities(Pickaxes.get_tool_capabilities(damage))
    item:get_meta():set_string("color", rarity.color)
    item:get_meta():set_string("pickaxe_dps", damage:to_string())
    return item
end

function PickaxeGenerator.refresh_pickaxe(item)
    local meta = item:get_meta()
    if item:get_name() == "mts_pickcrafting:pickaxe" and meta:contains("pickaxe_dps") then
        local damage = Big.parse(meta:get_string("pickaxe_dps"))
        if damage ~= nil then
            meta:set_tool_capabilities(Pickaxes.get_tool_capabilities(damage))
        end
    end
    return item
end

return PickaxeGenerator

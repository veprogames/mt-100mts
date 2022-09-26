Big = dofile(minetest.get_modpath("mts_bignumber").."/bignumber.lua")
Formatter = dofile(minetest.get_modpath("mts_pickcrafting").."/Formatter.lua")

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

local function rgb_to_hex(r, g, b)
    return string.format("#%02X%02X%02X", r, g, b)
end

local function random_color()
    return rgb_to_hex(math.random(50, 255), math.random(50, 255), math.random(50, 255))
end

local function generate_stats(base_damage)
    local rarity = 1

    for i = rarity, #rarities do
        if math.random() < 0.3 then
            rarity = rarity + 1
        else
            break
        end
    end

    local r = rarity - 1
    local final_damage = base_damage * Big:new(0.5 + math.random() * 1.5) * Big:new(1.6) ^ r
    final_damage = final_damage ^ (1 + 0.002 * r)
    if final_damage < Big:new(7) then
        final_damage = Big:new(7)
    end
    final_damage = final_damage:floor()

    return {rarity = rarities[rarity], damage = final_damage}
end

local function get_description(rarity, damage)
    return minetest.colorize(rarity.color, rarity.name .. " Pickaxe").."\n\n"..
        minetest.colorize("#00ff00", Formatter.format(damage, 2)).." DPS"
end

function PickaxeGenerator.generate(base_damage)
    local stats = generate_stats(base_damage)
    local damage = stats.damage
    local rarity = stats.rarity

    local item = ItemStack("mts_pickcrafting:pickaxe")
    item:get_meta():set_string("description", get_description(rarity, damage))
    item:get_meta():set_tool_capabilities(Pickaxes.get_tool_capabilities(damage))
    item:get_meta():set_string("color", rarity.color)
    return item
end

return PickaxeGenerator

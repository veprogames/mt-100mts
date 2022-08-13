MineralList = dofile(minetest.get_modpath("default").."/MineralList.lua")

MineralDefinition = {}

local function get_color(tier)
    math.randomseed(tier)
    return string.format("#%02X%02X%02X", math.random(0, 255), math.random(0, 255), math.random(0, 255))
end

local function generate_definition(tier)
    local color = get_color(tier)
    
    return {
        tier = tier,
        name = "Mineral"..tier,
        drop_name = "Lump",
        item_name = "Ingot",
        pickaxe_color = color,
        block_image = "default_stone.png^(default_ore.png^[multiply:"..color..")",
        drop_image = "default_lump.png^[multiply:"..color,
        item_image = "default_ingot.png^[multiply:"..color
    }
end

function MineralDefinition.get_definition(tier)
    if MineralList[tier] ~= nil then
        local mineral = MineralList[tier]
        mineral.tier = tier
        return mineral
    end
    return generate_definition(tier)
end

return MineralDefinition
MineralDefinition = {}

local function get_color(tier)
    math.randomseed(tier)
    return string.format("#%02X%02X%02X", math.random(0, 255), math.random(0, 255), math.random(0, 255))
end

function MineralDefinition.generate_definition(tier)
    local color = get_color(tier)
    
    return {
        tier = tier,
        name = "Mineral"..tier,
        drop_name = "Lump",
        item_name = "Ingot",
        color = color,
        block_image = "default_stone.png^(default_ore.png^[multiply:"..color..")",
        drop_image = "default_lump.png^[multiply:"..color,
        item_image = "default_ingot.png^[multiply:"..color
    }
end

return MineralDefinition
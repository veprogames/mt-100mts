MineralGenerator = {}

local function random_name(length)
    local vowels = "aeiou"
    local consonants = "bcdfghjklmnpqrstvwxyz"
    local endings = {"ium", "lite", "tite"}
    local result = ""
    for i = 0, length do
        if i % 2 == 0 then
            local idx = math.random(1, #vowels)
            result = result .. vowels:sub(idx, idx)
        else
            local idx = math.random(1, #consonants)
            result = result .. consonants:sub(idx, idx)
        end
    end
    result = result .. endings[math.random(1, #endings)];
    result = result:sub(1, 1):upper() .. result:sub(2, #result)
    return result
end

local function random_color()
    return string.format("#%02X%02X%02X", math.random(0, 255), math.random(0, 255), math.random(0, 255))
end

-- shortcut methods for creating definitions

MineralGenerator.create_metal_definition = function(name, color)
    return {
        name = name,
        item_name = "Ingot",
        block_image = "mts_default_stone.png^(mts_default_ore.png^[multiply:"..color..")",
        item_image = "mts_default_ingot.png^[multiply:"..color
    }
end

MineralGenerator.create_gem_definition = function(name, color)
    return {
        name = name,
        item_name = "Gem",
        block_image = "mts_default_stone.png^(mts_default_ore_gem.png^[multiply:"..color..")",
        item_image = "mts_default_gem.png^[multiply:"..color
    }
end

MineralGenerator.create_elemental_definition = function(name, color)
    return {
        name = name,
        item_name = "Elemental",
        block_image = "mts_default_stone.png^(mts_default_elemental.png^[multiply:"..color..")",
        item_image = "mts_default_elemental.png^[multiply:"..color
    }
end

MineralGenerator.create_essence_definition = function(name, color, color2)
    return {
        name = name,
        item_name = "Essence",
        block_image = "mts_default_stone.png^(mts_default_essence_base.png^[multiply:"..color..")^(mts_default_ore.png^[multiply:"..color2..")",
        item_image = "(mts_default_essence_base.png^[multiply:"..color..")^(mts_default_ingot.png^[multiply:"..color2..")"
    }
end

MineralGenerator.generate_for_tier = function(tier)
    math.randomseed(tier)
    local name = random_name(math.random(5, 8))
    local color = random_color()
    local type = math.random(1, 4)
    local definition
    if type == 1 then
        definition = MineralGenerator.create_metal_definition(name, color)
    elseif type == 2 then
        definition = MineralGenerator.create_gem_definition(name, color)
    elseif type == 3 then
        definition = MineralGenerator.create_essence_definition(name, random_color(), color)
    else
        definition = MineralGenerator.create_elemental_definition(name, color)
    end
    definition.tier = tier
    return definition
end

return MineralGenerator
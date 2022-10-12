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

-- shortcut for creating metals that drop lumps that craft to ingots
MineralGenerator.create_metal_definition = function(name, color)
    return {
        name = name,
        item_name = "Ingot",
        block_image = "mts_default_stone.png^(mts_default_ore.png^[multiply:"..color..")",
        drop_image = "mts_default_lump.png^[multiply:"..color,
        item_image = "mts_default_ingot.png^[multiply:"..color,
        pickaxe_color = color
    }
end

-- shortcut for creating gems that drop shards that craft to gems
MineralGenerator.create_gem_definition = function(name, color)
    return {
        name = name,
        item_name = "Gem",
        block_image = "mts_default_stone.png^(mts_default_ore_gem.png^[multiply:"..color..")",
        drop_image = "mts_default_gem_shard.png^[multiply:"..color,
        item_image = "mts_default_gem.png^[multiply:"..color,
        pickaxe_color = color
    }
end

MineralGenerator.generate_for_tier = function(tier)
    math.randomseed(tier)
    local name = random_name(math.random(5, 8))
    local color = random_color()
    local type = math.random(1, 2)
    local definition
    if type == 1 then
        definition = MineralGenerator.create_metal_definition(name, color)
    else
        definition = MineralGenerator.create_gem_definition(name, color)
    end
    definition.tier = tier
    return definition
end

return MineralGenerator
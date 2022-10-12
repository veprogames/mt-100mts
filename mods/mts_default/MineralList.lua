MineralGenerator = dofile(minetest.get_modpath("mts_default").."/MineralGenerator.lua")

local function metal(name, color)
    return MineralGenerator.create_metal_definition(name, color)
end

local function gem(name, color)
    return MineralGenerator.create_gem_definition(name, color)
end

local function elemental(name, color)
    return MineralGenerator.create_elemental_definition(name, color)
end

MineralList = {
    [1] = metal("Tin", "#8f5e1e"),
    [2] = metal("Copper", "#fc8c03"),
    [3] = {
        name = "Bone",
        item_name = "Bone",
        block_image = "mts_default_stone.png^(mts_default_ore_bone.png)",
        item_image = "mts_default_ore_bone.png",
        concat_names = false
    },
    [4] = {
        name = "Iron",
        item_name = "Ingot",
        block_image = "mts_default_stone.png^(mts_default_ore.png^[multiply:#cca992)",
        item_image = "mts_default_ingot.png"
    },
    [5] = metal("Lead", "#292630"),
    [6] = metal("Tungsten", "#8baf8c"),
    [7] = metal("Silver", "#b0b0b0"),
    [8] = {
        name = "Amber",
        item_name = "Rock",
        block_image = "mts_default_stone.png^(mts_default_ore_2.png^[multiply:#fc4503)",
        item_image = "mts_default_rock.png^[multiply:#fc4503"
    },
    [9] = gem("Citrine", "#b3a727"),
    [10] = metal("Gold", "#ffff00"),
    [11] = metal("Platinum", "#1cc7bb"),
    [12] = gem("Topaz", "#b39727"),
    [13] = gem("Amethyst", "#c73dcc"),
    [14] = gem("Emerald", "#2bb01c"),
    [15] = gem("Ruby", "#f01707"),
    [16] = gem("Sapphire", "#1a09d9"),
    [17] = metal("Mithril", "#0c6948"),
    [18] = gem("Diamond", "#ffffff"),
    [19] = metal("Orichalcum", "#931e80"),
    [20] = gem("Onyx", "#202020"),
    [21] = elemental("Avium", "#f0f0ff"),
    [22] = metal("Adamantium", "#7a4211"),
    [23] = gem("Radiantum", "#22c437"),
    [24] = {
        name = "Hybridium",
        item_name = "Bunch",
        block_image = "mts_default_stone.png^(mts_default_ore.png^[multiply:#0080ff)^(mts_default_ore_gem.png^[multiply:#00ffff)",
        item_image = "(mts_default_ingot.png^[multiply:#0080ff)^(mts_default_gem.png^[multiply:#00ffff)"
    }
}

return MineralList
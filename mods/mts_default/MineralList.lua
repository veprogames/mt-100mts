MineralGenerator = dofile(minetest.get_modpath("mts_default").."/MineralGenerator.lua")

local function metal(name, color)
    return MineralGenerator.create_metal_definition(name, color)
end

local function gem(name, color)
    return MineralGenerator.create_gem_definition(name, color)
end

MineralList = {
    [1] = metal("Tin", "#8f5e1e"),
    [2] = metal("Copper", "#fc8c03"),
    [3] = {
        name = "Bone",
        item_name = "Bone",
        block_image = "mts_default_stone.png^(mts_default_ore_bone.png)",
        item_image = "mts_default_ore_bone.png",
        pickaxe_color = "#ffffd0",
        concat_names = false
    },
    [4] = {
        name = "Iron",
        item_name = "Ingot",
        block_image = "mts_default_stone.png^(mts_default_ore.png^[multiply:#cca992)",
        item_image = "mts_default_ingot.png",
        pickaxe_color = "#ffffff"
    },
    [5] = metal("Tungsten", "#8baf8c"),
    [6] = metal("Silver", "#b0b0b0"),
    [7] = {
        name = "Amber",
        item_name = "Rock",
        block_image = "mts_default_stone.png^(mts_default_ore_2.png^[multiply:#fc4503)",
        item_image = "mts_default_rock.png^[multiply:#fc4503",
        pickaxe_color = "#fc4503"
    },
    [8] = gem("Citrine", "#b3a727"),
    [9] = metal("Gold", "#ffff00"),
    [10] = metal("Platinum", "#1cc7bb"),
    [11] = gem("Topaz", "#b39727"),
    [12] = gem("Amethyst", "#c73dcc"),
    [13] = gem("Emerald", "#2bb01c"),
    [14] = gem("Ruby", "#f01707"),
    [15] = gem("Sapphire", "#1a09d9"),
    [16] = metal("Mithril", "#0c6948"),
    [17] = gem("Diamond", "#ffffff")
}

return MineralList
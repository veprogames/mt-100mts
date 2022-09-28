-- shortcut for creating metals that drop lumps that craft to ingots
local function create_metal_definition(name, color)
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
local function create_gem_definition(name, color)
    return {
        name = name,
        item_name = "Gem",
        block_image = "mts_default_stone.png^(mts_default_ore_gem.png^[multiply:"..color..")",
        drop_image = "mts_default_gem_shard.png^[multiply:"..color,
        item_image = "mts_default_gem.png^[multiply:"..color,
        pickaxe_color = color
    }
end

MineralList = {
    [1] = create_metal_definition("Tin", "#8f5e1e"),
    [2] = create_metal_definition("Copper", "#fc8c03"),
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
    [5] = create_metal_definition("Tungsten", "#8baf8c"),
    [6] = create_metal_definition("Silver", "#b0b0b0"),
    [7] = {
        name = "Amber",
        item_name = "Rock",
        block_image = "mts_default_stone.png^(mts_default_ore_2.png^[multiply:#fc4503)",
        item_image = "mts_default_rock.png^[multiply:#fc4503",
        pickaxe_color = "#fc4503"
    },
    [8] = create_gem_definition("Citrine", "#b3a727"),
    [9] = create_metal_definition("Gold", "#ffff00"),
    [10] = create_metal_definition("Platinum", "#1cc7bb"),
    [11] = create_gem_definition("Topaz", "#b39727"),
    [12] = create_gem_definition("Amethyst", "#c73dcc"),
    [13] = create_gem_definition("Emerald", "#2bb01c"),
    [14] = create_gem_definition("Ruby", "#f01707"),
    [15] = create_gem_definition("Sapphire", "#1a09d9"),
    [16] = create_metal_definition("Mithril", "#0c6948"),
    [17] = create_gem_definition("Diamond", "#ffffff")
}

return MineralList
-- shortcut for creating metals that drop lumps that craft to ingots
local function create_metal_definition(name, color)
    return {
        name = name,
        drop_name = "Lump",
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
        drop_name = "Shard",
        item_name = "Gem",
        block_image = "mts_default_stone.png^(mts_default_ore_gem.png^[multiply:"..color..")",
        drop_image = "mts_default_gem_shard.png^[multiply:"..color,
        item_image = "mts_default_gem.png^[multiply:"..color,
        pickaxe_color = color
    }
end

MineralList = {
    [1] = {
        name = "Stone",
        drop_name = "Pebble",
        item_name = "Rock",
        block_image = "mts_default_stone.png",
        drop_image = "mts_default_lump.png^[multiply:#707070",
        item_image = "mts_default_rock.png^[multiply:#707070",
        pickaxe_color = "#707070",
        concat_names = false
    },
    [2] = create_metal_definition("Tin", "#8f5e1e"),
    [3] = create_metal_definition("Copper", "#fc8c03"),
    [4] = {
        name = "Bone",
        drop_name = "Bone Shard",
        item_name = "Bone",
        block_image = "mts_default_stone.png^(mts_default_ore_bone.png)",
        drop_image = "mts_default_bone_shard.png",
        item_image = "mts_default_ore_bone.png",
        pickaxe_color = "#ffffd0",
        concat_names = false
    },
    [5] = {
        name = "Iron",
        drop_name = "Lump",
        item_name = "Ingot",
        block_image = "mts_default_stone.png^(mts_default_ore.png^[multiply:#cca992)",
        drop_image = "mts_default_lump.png^[multiply:#cca992",
        item_image = "mts_default_ingot.png",
        pickaxe_color = "#ffffff"
    },
    [6] = create_metal_definition("Tungsten", "#8baf8c"),
    [7] = create_metal_definition("Silver", "#b0b0b0"),
    [8] = {
        name = "Amber",
        drop_name = "Shard",
        item_name = "Rock",
        block_image = "mts_default_stone.png^(mts_default_ore_2.png^[multiply:#fc4503)",
        drop_image = "mts_default_fragment.png^[multiply:#fc4503",
        item_image = "mts_default_rock.png^[multiply:#fc4503",
        pickaxe_color = "#fc4503"
    },
    [9] = create_gem_definition("Citrine", "#b3a727"),
    [10] = create_metal_definition("Gold", "#ffff00"),
    [11] = create_metal_definition("Platinum", "#1cc7bb"),
    [12] = create_gem_definition("Topaz", "#b39727"),
    [13] = create_gem_definition("Amethyst", "#c73dcc"),
    [14] = create_gem_definition("Emerald", "#2bb01c"),
    [15] = create_gem_definition("Ruby", "#f01707"),
    [16] = create_gem_definition("Sapphire", "#1a09d9"),
    [17] = create_metal_definition("Mithril", "#0c6948"),
    [18] = create_gem_definition("Diamond", "#ffffff")
}

return MineralList
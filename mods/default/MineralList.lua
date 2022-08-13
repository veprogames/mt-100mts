-- shortcut for creating metals that drop lumps that craft to ingots
local function create_metal_definition(name, color)
    return {
        name = name,
        drop_name = "Lump",
        item_name = "Ingot",
        block_image = "default_stone.png^(default_ore.png^[multiply:"..color..")",
        drop_image = "default_lump.png^[multiply:"..color,
        item_image = "default_ingot.png^[multiply:"..color,
        pickaxe_color = color
    }
end

MineralList = {
    [1] = {
        name = "Stone",
        drop_name = "Pebble",
        item_name = "Rock",
        block_image = "default_stone.png",
        drop_image = "default_lump.png^[multiply:#707070",
        item_image = "default_rock.png^[multiply:#707070",
        pickaxe_color = "#707070"
    },
    [2] = create_metal_definition("Tin", "#8f5e1e"),
    [3] = create_metal_definition("Copper", "#fc8c03"),
    [4] = {
        name = "Bone",
        drop_name = "Shard",
        item_name = "",
        block_image = "default_stone.png^(default_ore_bone.png)",
        drop_image = "default_bone_shard.png",
        item_image = "default_ore_bone.png",
        pickaxe_color = "#ffffd0"
    },
    [5] = {
        name = "Iron",
        drop_name = "Lump",
        item_name = "Ingot",
        block_image = "default_stone.png^(default_ore.png^[multiply:#cca992)",
        drop_image = "default_lump.png^[multiply:#cca992",
        item_image = "default_ingot.png",
        pickaxe_color = "#ffffff"
    },
    [6] = create_metal_definition("Tungsten", "#8baf8c"),
    [7] = create_metal_definition("Silver", "#b0b0b0"),
    [8] = {
        name = "Amber",
        drop_name = "Shard",
        item_name = "Rock",
        block_image = "default_stone.png^(default_ore_2.png^[multiply:#fc4503)",
        drop_image = "default_fragment.png^[multiply:#fc4503",
        item_image = "default_rock.png^[multiply:#fc4503",
        pickaxe_color = "#fc4503"
    },
}

return MineralList
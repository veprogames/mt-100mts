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
        item_image = "default_ingot.png^[multiply:#707070",
        pickaxe_color = "#707070"
    },
    [2] = create_metal_definition("Tin", "#8f5e1e"),
    [3] = create_metal_definition("Copper", "#fc8c03")
}

return MineralList
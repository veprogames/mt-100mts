minetest.register_craft({
    type = "shapeless",
    output = "mts_default:rock",
    recipe = {"mts_default:pebble", "mts_default:pebble", "mts_default:pebble", "mts_default:pebble", "mts_default:pebble"},
})

minetest.register_craft({
    type = "shaped",
    output = "mts_default:stone_pickaxe",
    recipe = {
        {"mts_default:rock", "mts_default:rock", "mts_default:rock"},
        {"", "mts_default:stick", ""},
        {"", "mts_default:stick", ""}
    }
})
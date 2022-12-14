minetest.register_node("mts_default:grass", {
    description = "Grass",
    tiles = {
        "mts_default_grass.png",
        "mts_default_dirt.png",
        "mts_default_dirt.png^mts_default_grass_side.png",
        "mts_default_dirt.png^mts_default_grass_side.png",
        "mts_default_dirt.png^mts_default_grass_side.png",
        "mts_default_dirt.png^mts_default_grass_side.png"
    },
    groups = {crumbly = 1},
    sounds = {
        dig = {name = "dirt", pitch = 1.2}
    },
    drop = {}
})

minetest.register_node("mts_default:dirt", {
    description = "Dirt",
    tiles = {"mts_default_dirt.png"},
    groups = {crumbly = 1},
    sounds = {
        dig = "dirt"
    },
    drop = {}
})

minetest.register_node("mts_default:wood", {
    description = "Wood Block",
    tiles = {"mts_default_wood.png"},
    groups = {choppy = 1},
    sounds = {
        dig = "wood"
    },
    drop = {
        items = {
            {items = {"mts_default:stick"}}
        }
    }
})
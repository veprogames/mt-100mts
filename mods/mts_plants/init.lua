minetest.register_node("mts_plants:grass", {
    description = "Grass Plant",
    drawtype = "plantlike",
    tiles = {"mts_plants_grass.png"},
    walkable = false,
    paramtype = "light",
    sunlight_propagates = true,
    groups = {dig_immediate = 1, attached_node = 1},
    drop = {}
})

minetest.register_node("mts_plants:sunflower", {
    description = "Sunflower Plant",
    drawtype = "plantlike",
    visual_scale = 2,
    tiles = {"mts_plants_sunflower.png"},
    walkable = false,
    paramtype = "light",
    sunlight_propagates = true,
    groups = {dig_immediate = 1, attached_node = 1},
    drop = {}
})
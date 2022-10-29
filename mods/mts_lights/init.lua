local sound_def = {
    dig = "stone"
}

minetest.register_node("mts_lights:active_coal", {
    description="Active Coal",
    tiles={"mts_lights_active_coal.png"},
    sounds = sound_def,
    groups={lighty=1},
    light_source = 7
})

minetest.register_node("mts_lights:glowstone", {
    description="Glowstone",
    tiles={"mts_lights_glowstone.png"},
    sounds = sound_def,
    groups={lighty=2},
    light_source = 10
})

minetest.register_node("mts_lights:pocket_sun", {
    description="Pocket Sun",
    tiles={"mts_lights_pocket_sun.png"},
    sounds = sound_def,
    groups={lighty=3},
    light_source = 14
})
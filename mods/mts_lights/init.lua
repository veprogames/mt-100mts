minetest.register_node("mts_lights:active_coal", {
    description="Active Coal",
    tiles={"mts_lights_active_coal.png"},
    groups={lighty=1},
    light_source = 8
})

minetest.register_node("mts_lights:glowstone", {
    description="Glowstone",
    tiles={"mts_lights_glowstone.png"},
    groups={lighty=2},
    light_source = 11
})

minetest.register_node("mts_lights:pocket_sun", {
    description="Pocket Sun",
    tiles={"mts_lights_pocket_sun.png"},
    groups={lighty=3},
    light_source = 14
})
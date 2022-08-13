minetest.register_node("mts_lights:active_coal", {
    description="Active Coal",
    tiles={"mts_lights_active_coal.png"},
    groups={cracky=2},
    light_source = 5
})

minetest.register_node("mts_lights:glowstone", {
    description="Glowstone",
    tiles={"mts_lights_glowstone.png"},
    groups={cracky=20},
    light_source = 9
})

minetest.register_node("mts_lights:pocket_sun", {
    description="Pocket Sun",
    tiles={"mts_lights_pocket_sun.png"},
    groups={cracky=80},
    light_source = 14
})
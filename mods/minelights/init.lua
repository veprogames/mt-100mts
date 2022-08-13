minetest.register_node("minelights:active_coal", {
    description="Active Coal",
    tiles={"minelights_active_coal.png"},
    groups={cracky=2},
    light_source = 5
})

minetest.register_node("minelights:glowstone", {
    description="Glowstone",
    tiles={"minelights_glowstone.png"},
    groups={cracky=20},
    light_source = 9
})

minetest.register_node("minelights:pocket_sun", {
    description="Pocket Sun",
    tiles={"minelights_pocket_sun.png"},
    groups={cracky=80},
    light_source = 14
})
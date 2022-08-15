minetest.register_item(":", {
    type="none",
    wield_image = "hand.png",
    wield_scale = {x = 0.55, y = 0.95, z = 5},
    range = 4,
    tool_capabilities = {
        full_punch_interval = 0.9,
        max_drop_level = 0,
        groupcaps = {
            choppy = {
                uses = 0,
                times = {[1] = 6}
            },
            crumbly = {
                uses = 0,
                times = {[1] = 0.7}
            },
            cracky = {
                uses = 0,
                times = {[1] = 1.4, [2] = 4, [3] = 16}
            }
        }
    }
})

minetest.register_craftitem("mts_default:stick", {
    description = "Stick",
    wield_image = "mts_default_stick.png",
    inventory_image = "mts_default_stick.png",
    stack_max = 9999
})
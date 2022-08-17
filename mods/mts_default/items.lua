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
                times = {[1] = 1.5}
            },
            dig_immediate = {
                uses = 0,
                times = {[1] = 0}
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

minetest.register_craftitem("mts_default:pebble", {
    description = "Pebble",
    wield_image = "mts_default_lump.png^[multiply:#707070",
    inventory_image = "mts_default_lump.png^[multiply:#707070",
    stack_max = 9999
})

minetest.register_craftitem("mts_default:rock", {
    description = "Rock",
    wield_image = "mts_default_rock.png^[multiply:#707070",
    inventory_image = "mts_default_rock.png^[multiply:#707070",
    stack_max = 9999
})

local pickaxe_image = "mts_default_pickaxe_base.png^(mts_default_pickaxe_head.png^[multiply:#707070)"
minetest.register_craftitem("mts_default:stone_pickaxe", {
    description = "Stone Pickaxe\n\n"..minetest.colorize("#c0c0c0", "A Simple Pickaxe that can be used to break the first Ores"),
    wield_image = pickaxe_image,
    inventory_image = pickaxe_image,
    wield_scale = {x=1.4, y=1.4, z=1.4},
    tool_capabilities = {
        groupcaps = {
            cracky = {
                uses = 0,
                times = {[1] = 1.2, [2] = 3, [3] = 7}
            }
        }
    }
})
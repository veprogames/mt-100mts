minetest.register_node("mts_powercrystals:crystal_block", {
    description = minetest.colorize("#ff0000", "Power Crystal Block"),
    tiles = {"power_crystal_block.png"},
    drop = "mts_powercrystals:crystal",
    light_source = 3,
    sounds = {
        dig = "crystal"
    },
    groups = {
        powercrystalline = 1
    }
})

minetest.register_craftitem("mts_powercrystals:crystal", {
    description = minetest.colorize("#ff0000", "Power Crystal").."\n\n"..
        "Absorb into the Vortex Blacksmith to\npermanently increase the power of Pickaxes by ^+0.001",
    wield_image = "power_crystal.png",
    inventory_image = "power_crystal.png",
    stack_max = 1,
    _blacksmith_power_id = 1
})
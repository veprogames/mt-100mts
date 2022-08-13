local function register_liquid(id, definition)
    local id_still = id.."_still"
    local id_flowing = id.."_flowing"

    minetest.register_node(id_still, {
        description = definition.description,
        drawtype = "liquid",
        tiles = {definition.image},
        paramtype = "light",
        liquidtype = "source",
        post_effect_color = definition.post_effect_color,
        liquid_range = definition.liquid_range,
        liquid_viscosity = definition.liquid_viscosity,
        liquid_alternative_flowing = id_flowing,
        liquid_alternative_source = id_still,
        pointable = false,
        diggable = false,
        buildable_to = true,
        walkable = false,
        is_ground_content = false,
        light_source = definition.light_source,
        damage_per_second = definition.damage_per_second
    })
    
    minetest.register_node(id_flowing, {
        description = definition.description.." (Flowing)",
        drawtype = "flowingliquid",
        tiles = {definition.image},
        special_tiles = {
            {name = definition.image, backface_culling = false},
            {name = definition.image, backface_culling = false},
        },
        use_texture_alpha = "blend",
        paramtype = "light",
        paramtype2 = "flowingliquid",
        liquidtype = "flowing",
        post_effect_color = definition.post_effect_color,
        liquid_range = definition.liquid_range,
        liquid_viscosity = definition.liquid_viscosity,
        liquid_alternative_flowing = id_flowing,
        liquid_alternative_source = id_still,
        pointable = false,
        diggable = false,
        buildable_to = true,
        walkable = false,
        is_ground_content = false,
        light_source = definition.light_source,
        damage_per_second = definition.damage_per_second
    })
end

register_liquid("liquids:magma", {
    description = "Magma",
    image = "liquids_magma.png",
    post_effect_color = {r = 192, g = 0, b = 0, a = 192},
    liquid_range = 3,
    liquid_viscosity = 6,
    light_source = 4,
    damage_per_second = 2
})

register_liquid("liquids:lava", {
    description = "Lava",
    image = "liquids_lava.png",
    post_effect_color = {r = 255, g = 0, b = 0, a = 192},
    liquid_range = 5,
    liquid_viscosity = 3,
    light_source = 8,
    damage_per_second = 3
})

register_liquid("liquids:plasmatic", {
    description = "Plasmatic Liquid",
    image = "liquids_plasma.png",
    post_effect_color = {r = 0, g = 255, b = 255, a = 224},
    liquid_range = 7,
    liquid_viscosity = 1,
    light_source = 13,
    damage_per_second = 4
})
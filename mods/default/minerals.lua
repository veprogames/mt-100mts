Minerals = {}

local function get_tool_capabilities(tier)
    local times = {}

    for i = 1, tier + 2 do
        local time = 2 ^ (i - tier)
        time = math.max(time, 0.2)
        times[i] = time
    end
    
    return {
        full_punch_interval = 0.9,
        max_drop_level = 0,
        groupcaps = {
            cracky = {
                uses = 1000,
                times = times
            },
            choppy = {
                uses = 1000,
                times = {[1] = math.max(0.25, 5 * 0.9 ^ tier)}
            }
        }
    }
end

function Minerals.register_mineral(definition)
    local tier = definition.tier

    local mineral_drop = "default:mineral_drop"..tier
    local mineral_item = "default:mineral_item"..tier

    -- Pickaxe
    local image = "default_pickaxe_base.png^(default_pickaxe_head.png^[multiply:"..definition.color..")"
    minetest.register_craftitem("default:pickaxe"..tier, {
        description = definition.name.." Pickaxe",
        wield_scale = {x=1.4, y=1.4, z=1.4},
        wield_image=image,
        inventory_image=image,
        tool_capabilities = get_tool_capabilities(tier)
    })

    -- Drop (like Lumps, Nuggets or Shards)
    image = definition.drop_image
    minetest.register_craftitem("default:mineral_drop"..tier, {
        description = definition.name.." "..definition.drop_name,
        wield_image = image,
        inventory_image = image,
        stack_max = 9999
    })

    -- Item used to craft Pickaxes
    image = definition.item_image
    minetest.register_craftitem("default:mineral_item"..tier, {
        description = definition.name.." "..definition.item_name,
        wield_image = image,
        inventory_image = image,
        stack_max = 9999
    })

    -- Mineral Item (Ingot etc.) Recipe
    minetest.register_craft({
        type = "shapeless",
        output = "default:mineral_item"..tier,
        recipe = {mineral_drop, mineral_drop, mineral_drop, mineral_drop, mineral_drop}
    })

    -- Pickaxe Recipe
    minetest.register_craft({
        type = "shaped",
        output = "default:pickaxe"..tier,
        recipe = {
            {mineral_item, mineral_item, mineral_item},
            {"", "default:stick", ""},
            {"", "default:stick", ""}
        }
    })
    
    -- Mineral Block
    minetest.register_node("default:mineral"..tier, {
        description = definition.name,
        tiles = {definition.block_image},
        groups = {cracky=tier},
        drop = {
            items = {
                {items = {"default:mineral_drop"..tier}}
            }
        }
    })
end

return Minerals
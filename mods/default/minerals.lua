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

function Minerals.get_color(tier)
    math.randomseed(tier)
    return string.format("#%02X%02X%02X", math.random(0, 255), math.random(0, 255), math.random(0, 255))
end

function Minerals.register_mineral(tier)
    local col = Minerals.get_color(tier)

    

    -- Pickaxe
    local image = "default_pickaxe_base.png^(default_pickaxe_head.png^[multiply:"..col..")"
    minetest.register_craftitem("default:pickaxe"..tier, {
        description="Pickaxe "..tier,
        wield_scale = {x=1.4, y=1.4, z=1.4},
        wield_image=image,
        inventory_image=image,
        tool_capabilities = get_tool_capabilities(tier)
    })

    -- Drop (like Lumps, Nuggets or Shards)
    image = "default_lump.png^[multiply:"..col
    minetest.register_craftitem("default:mineral_drop"..tier, {
        description="Drop "..tier,
        wield_image=image,
        inventory_image=image,
        stack_max = 9999
    })

    -- Item used to craft Pickaxes
    image = "default_ingot.png^[multiply:"..col
    local mineral_drop = "default:mineral_drop"..tier
    minetest.register_craftitem("default:mineral_item"..tier, {
        description="Ingot "..tier,
        wield_image=image,
        inventory_image=image,
        stack_max = 9999
    })
    minetest.register_craft({
        type = "shapeless",
        output = "default:mineral_item"..tier,
        recipe = {mineral_drop, mineral_drop, mineral_drop, mineral_drop, mineral_drop}
    })

    -- Pickaxe Recipe
    local mineral_item = "default:mineral_item"..tier
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
        description="Mineral "..tier,
        tiles={"default_stone.png^(default_ore.png^[multiply:"..col..")"},
        groups={cracky=tier},
        drop={
            items = {
                {items = {"default:mineral_drop"..tier}}
            }
        }
    })
end

return Minerals
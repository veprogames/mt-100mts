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
            }
        }
    }
end

minetest.register_item(":", {
    type="none",
    wield_image = "hand.png",
    wield_scale = {x = 0.65, y = 1, z = 1},
    range = 4,
    tool_capabilities = {
        full_punch_interval = 0.9,
        max_drop_level = 0,
        groupcaps = {
            cracky = {
                uses = 0,
                times = {[0] = 0.7, [1] = 1.4, [2] = 4, [3] = 16}
            }
        }
    }
})

for i=1,100 do
    local col = string.format("#%02X%02X%02X", math.random(0, 255), math.random(0, 255), math.random(0, 255))
    local image = "pickaxe_base.png^(pickaxe_head.png^[multiply:"..col..")"
    minetest.register_craftitem("default:pickaxe"..i, {
        description="Pickaxe "..i,
        wield_scale = {x=1.4, y=1.4, z=1.4},
        wield_image=image,
        inventory_image=image,
        tool_capabilities = get_tool_capabilities(i)
    })
end
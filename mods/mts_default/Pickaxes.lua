Minerals = dofile(minetest.get_modpath("mts_default").."/Minerals.lua")
Pickaxes = {}

function Pickaxes.get_damage_at_tier(tier)
    return Big:new(2) ^ tier
end

function Pickaxes.get_tool_capabilities(damage)
    local times = {}

    for i = 1, 100 do
        local time = (Minerals.get_hp_at_tier(i) / damage):to_number()
        time = math.max(time, 0.2)
        if time > 600 then
            break
        end
        times[i] = time
    end

    local speed_multi = 1 + (damage + Big:new(1)):log10() / 4

    return {
        full_punch_interval = 0.9,
        max_drop_level = 0,
        groupcaps = {
            cracky = {
                uses = 0,
                times = times
            },
            choppy = {
                uses = 0,
                times = {[1] = math.max(0.25, 5 / speed_multi)}
            },
            lighty = {
                uses = 0,
                times = {
                    [1] = 3 / speed_multi,
                    [2] = 6 / speed_multi,
                    [3] = 12 / speed_multi
                }
            },
            teleportey = {
              times = {[1] = 1, [2] = 3}
            }
        }
    }
end

function Pickaxes.register_pickaxe(definition)
    local tier = definition.tier
    local tier_text = minetest.colorize("#cccccc", "Lv.").." "..minetest.colorize("#00ff00", tier)

    local image = "mts_default_pickaxe_base.png^(mts_default_pickaxe_head.png^[multiply:"..definition.pickaxe_color..")"
    minetest.register_craftitem("mts_default:pickaxe"..tier, {
        description = definition.name.." Pickaxe\n" .. tier_text .. "\n" .. minetest.colorize("#00ff00", Pickaxes.get_damage_at_tier(tier)).." DPS",
        wield_scale = {x=1.4, y=1.4, z=1.4},
        wield_image=image,
        inventory_image=image,
        tool_capabilities = Pickaxes.get_tool_capabilities(Pickaxes.get_damage_at_tier(tier))
    })
end

return Pickaxes
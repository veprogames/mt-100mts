Minerals = dofile(minetest.get_modpath("mts_default").."/Minerals.lua")
Pickaxes = {}

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

return Pickaxes
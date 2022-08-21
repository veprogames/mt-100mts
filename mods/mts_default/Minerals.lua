Minerals = {}

local function get_tool_capabilities(tier)
    local times = {}

    for i = 1, tier + 2 do
        local time = 2 ^ (i - tier) * (0.8 + 0.005 * tier)
        time = math.max(time, 0.2)
        times[i] = time
    end

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
                times = {[1] = math.max(0.25, 5 * 0.9 ^ tier)}
            },
            lighty = {
                uses = 0,
                times = {
                    [1] = 3 / (1 + 0.1 * tier),
                    [2] = 6 / (1 + 0.1 * tier),
                    [3] = 12 / (1 + 0.1 * tier)
                }
            },
            teleportey = {
              times = {[1] = 1, [2] = 3}
            }
        }
    }
end

function Minerals.register_stone(tier)
    minetest.register_node("mts_default:stone"..tier, {
        description = "Stone Lv. "..tier,
        tiles = {"mts_default_stone.png"},
        groups = {cracky = tier},
        drop = {
            items = {
                {items = {"mts_default:pebble"}}
            }
        }
    })
end

function Minerals.register_mineral(definition)
    local tier = definition.tier

    local mineral_drop_id = "mts_default:mineral_drop"..tier
    local mineral_item_id = "mts_default:mineral_item"..tier

    local drop_name = definition.name.." "..definition.drop_name
    local item_name = definition.name.." "..definition.item_name
    if definition.concat_names == false then
        drop_name = definition.drop_name
        item_name = definition.item_name
    end

    -- Pickaxe
    local image = "mts_default_pickaxe_base.png^(mts_default_pickaxe_head.png^[multiply:"..definition.pickaxe_color..")"
    minetest.register_craftitem("mts_default:pickaxe"..tier, {
        description = definition.name.." Pickaxe\n" .. minetest.colorize("#cccccc", "Tier: " .. tier),
        wield_scale = {x=1.4, y=1.4, z=1.4},
        wield_image=image,
        inventory_image=image,
        tool_capabilities = get_tool_capabilities(tier)
    })

    -- Drop (like Lumps, Nuggets or Shards)
    image = definition.drop_image
    minetest.register_craftitem(mineral_drop_id, {
        description = drop_name,
        wield_image = image,
        inventory_image = image,
        stack_max = 9999
    })

    -- Item used to craft Pickaxes
    image = definition.item_image
    minetest.register_craftitem(mineral_item_id, {
        description = item_name,
        wield_image = image,
        inventory_image = image,
        stack_max = 9999
    })

    -- Mineral Item (Ingot etc.) Recipe
    minetest.register_craft({
        type = "shapeless",
        output = mineral_item_id,
        recipe = {mineral_drop_id, mineral_drop_id, mineral_drop_id, mineral_drop_id, mineral_drop_id}
    })

    -- Pickaxe Recipe
    minetest.register_craft({
        type = "shaped",
        output = "mts_default:pickaxe"..tier,
        recipe = {
            {mineral_item_id, mineral_item_id, mineral_item_id},
            {"", "mts_default:stick", ""},
            {"", "mts_default:stick", ""}
        }
    })

    -- Mineral Block
    minetest.register_node("mts_default:mineral"..tier, {
        description = definition.name,
        tiles = {definition.block_image},
        groups = {cracky=tier},
        drop = {
            items = {
                {items = {mineral_drop_id}}
            }
        },
        after_dig_node = function (pos, oldnode, oldmeta, digger)
            local name = digger:get_player_name()
            local meta = digger:get_meta()
            local highest_lvl = meta:get_int("highest_mineral_level")

            if highest_lvl < tier then
                minetest.chat_send_all(minetest.colorize("#00ff30", name).." reached Mineral Lv. "..minetest.colorize("#00ff00", tier).."!")
                if tier >= 100 then
                    minetest.chat_send_player(name, "Congratulations on reaching the last Mineral!\n"..
                    "Now you can craft the best Pickaxe!\n"..
                    "Thanks for playing "..minetest.colorize("#00ff00", "100 Minerals to success").."!")
                end
                meta:set_int("highest_mineral_level", tier)
            end

            return true
        end
    })
end

return Minerals

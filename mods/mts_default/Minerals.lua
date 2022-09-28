Big = dofile(minetest.get_modpath("mts_bignumber").."/bignumber.lua")
Formatter = dofile(minetest.get_modpath("mts_formatter").."/Formatter.lua")
Minerals = {}

function Minerals.get_hp_at_tier(tier)
    local t = tier - 1
    return Big:new(1.2 + 0.05 * t) ^ t * Big:new(10 + 7 * t)
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

    local mineral_item_id = "mts_default:mineral_item"..tier

    local tier_text = minetest.colorize("#cccccc", "Lv.").." "..minetest.colorize("#00ff00", tier)

    local hp = Minerals.get_hp_at_tier(tier)

    local item_name = definition.name.." "..definition.item_name
    if definition.concat_names == false then
        item_name = definition.item_name
    end

    -- Item used to craft Pickaxes
    local hp_text = minetest.colorize("#cccccc", "HP") .. " " .. minetest.colorize("#00ffb0", Formatter.format(hp))
    local item_description = table.concat({item_name, tier_text, hp_text}, "\n")
    minetest.register_craftitem(mineral_item_id, {
        description = item_description,
        wield_image = definition.item_image,
        inventory_image = definition.item_image,
        stack_max = 9999,
        _blacksmith_multiplier_id = tier
    })

    -- Mineral Block
    minetest.register_node("mts_default:mineral"..tier, {
        description = definition.name,
        tiles = {definition.block_image},
        groups = {cracky=tier},
        drop = mineral_item_id,
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

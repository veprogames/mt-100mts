Big = dofile(minetest.get_modpath("mts_bignumber").."/bignumber.lua")
PickaxeGenerator = dofile(minetest.get_modpath("mts_pickcrafting").."/PickaxeGenerator.lua")
Formatter = dofile(minetest.get_modpath("mts_formatter").."/Formatter.lua")

Blacksmith = {
    data = {}
}

Blacksmith.storage = Blacksmith.storage or minetest.get_mod_storage() -- make sure storage is only registered once

function Blacksmith.register_blacksmith()
    minetest.register_node("mts_pickcrafting:blacksmith", {
        description = "Vortex Blacksmith",
        drawtype = "mesh",
        mesh = "vortex_anvil.obj",
        tiles = {"mts_pickcrafting_anvil.png"},
        paramtype = "light",
        sunlight_propagates = true,
        on_rightclick = function (pos, node, clicker, itemstack, pointed_thing)
            Blacksmith.show_formspec(clicker:get_player_name())
        end
    })

    minetest.register_craft({
        type = "shaped",
        output = "mts_pickcrafting:blacksmith",
        recipe = {
            {"mts_default:rock", "mts_default:rock", "mts_default:rock"},
            {"", "mts_default:pebble", ""},
            {"mts_default:pebble", "mts_default:pebble", "mts_default:pebble"}
        }
    })
end

function Blacksmith.create_formspec()
    local text_mults = ""

    local mult_keys = {}
    for k in pairs(Blacksmith.data.multipliers) do
        if type(k) == "number" then
            table.insert(mult_keys, k)
        end
    end
    table.sort(mult_keys)

    local x = 0
    local y = 0
    for k, v in pairs(mult_keys) do
        local mult = Blacksmith.data.multipliers[v]
        local mineral_name = (minetest.registered_nodes["mts_default:mineral"..v] or {description = "Unknown"}).description
        text_mults = text_mults ..
            string.format("item_image[%d,%d;1,1;mts_default:mineral_item%d]", x, y, v)..
            string.format("tooltip[%d,%d;1,1;%s]", x, y, mineral_name)..
            string.format("label[%f,%f;x%.2f]", x + 1.25, y + 0.5, mult)
        x = x + 4
        if x > 4 then
            x = 0
            y = y + 1
        end
    end

    local crystal_power = ""
    if Blacksmith.get_total_pow() > 1 then 
        crystal_power = "container[1,7.8;4,1]"..
            "item_image[0,0;1,1;mts_powercrystals:crystal]"..
            string.format("label[1.2,0.5;^%.3f]", Blacksmith.get_total_pow())..
        "container_end[]"
    end

    local description = [[The Vortex Blacksmith will absorb the Minerals you have mined to get stronger.
The boosts of the Minerals multiply with each other!

Punch the Blacksmith to craft a Pickaxe for 1 Stick. Pickaxes will deal at least 7 DPS.

Every Mineral Drop adds +0.01 to their Multiplier.]]

    local scroll_height = math.max(0, 6 * #mult_keys - 60)

    return "formspec_version[6]"..
        "size[16,9]"..
        string.format("textarea[11,1;4.8,5;;;%s]", description)..
        string.format("scrollbaroptions[max=%d;arrows=hide]", scroll_height)..
        "scrollbar[10,1;0.4,7;vertical;scroll_mult;]"..
        "scroll_container[1,1;9,6.7;scroll_mult;vertical;]"..
            "style_type[label;font_size=*1.7;textcolor=#e0ffe0]"..
            text_mults..
        "scroll_container_end[]"..
        crystal_power..
        "button[11,6;2,0.8;absorb;Absorb!]"..
        "button[13.5,6;2,0.8;craft;Craft!\n(1 Stick)]"..
        "container[11,7.5;5,2]"..
            "style_type[label;font_size=*1.2;textcolor=#ffffff]"..
            "label[0,0;Base DPS]"..
            "style_type[label;font_size=*1.8;textcolor=#00ff00]"..
            string.format("label[0,0.5;%s]", Formatter.format(Blacksmith.get_base_dps(), 2, 2))..
        "container_end[]"
end

function Blacksmith.show_formspec(name)
    minetest.show_formspec(name, "mts_pickcrafting:blacksmith", Blacksmith.create_formspec())
end

function Blacksmith.craft_pickaxe(player)
    local inv = player:get_inventory()

    local taken = inv:remove_item("main", ItemStack("mts_default:stick"))

    -- require a stick for crafting
    if taken:get_count() >= 1 then
        local base_damage = Blacksmith.get_base_dps()
        local item = PickaxeGenerator.generate(base_damage)
        inv:add_item("main", item)
        minetest.sound_play("craft", {pitch = 0.8 + 0.4 * math.random()})
    else
        minetest.chat_send_all(minetest.colorize("red", "Not enough Sticks!"))
    end
end

function Blacksmith.absorb_inventory(player_name)
    local inv = minetest.get_inventory({type = "player", name = player_name})
    local did_absorb_something = false
    if inv ~= nil then
        local items = inv:get_list("main")
        for k, item in pairs(items) do
            local definition = item:get_definition()
            if definition._blacksmith_multiplier_id ~= nil then
                local idx = definition._blacksmith_multiplier_id
                Blacksmith.data.multipliers[idx] = (Blacksmith.data.multipliers[idx] or 1) + item:get_count() * 0.01
                inv:remove_item("main", item)
                did_absorb_something = true
            elseif definition._blacksmith_power_id ~= nil then
                local idx = definition._blacksmith_power_id
                Blacksmith.data.powers[idx] = (Blacksmith.data.powers[idx] or 1) + item:get_count() * 0.001
                inv:remove_item("main", item)
                did_absorb_something = true
            end
        end
        if did_absorb_something then
            minetest.sound_play("absorb")
        end
        Blacksmith.save()
    end
end

function Blacksmith.init_storage()
    return {
        multipliers = {},
        powers = {}
    }
end

function Blacksmith.get_total_mult()
    local mult = Big:new(1)
    for k, m in pairs(Blacksmith.data.multipliers) do
        mult = mult * Big:new(m)
    end
    return mult
end

function Blacksmith.get_total_pow()
    local pow = 1
    for k, p in pairs(Blacksmith.data.powers) do
        pow = pow * p
    end
    return pow
end

function Blacksmith.get_base_dps()
    return (Big:new(5) * Blacksmith.get_total_mult()) ^ Blacksmith.get_total_pow()
end

function Blacksmith.load()
    Blacksmith.data = minetest.deserialize(Blacksmith.storage:get_string("mts_blacksmith"), true) or Blacksmith.init_storage()
end

function Blacksmith.save()
    Blacksmith.storage:set_string("mts_blacksmith", minetest.serialize(Blacksmith.data))
end

Blacksmith.data = Blacksmith.init_storage()

return Blacksmith
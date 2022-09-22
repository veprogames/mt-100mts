Big = dofile(minetest.get_modpath("mts_bignumber").."/bignumber.lua")
PickaxeGenerator = dofile(minetest.get_modpath("mts_pickcrafting").."/PickaxeGenerator.lua")
Formatter = dofile(minetest.get_modpath("mts_pickcrafting").."/Formatter.lua")

local storage = minetest.get_mod_storage()

Blacksmith = {
    data = {}
}

function Blacksmith.register_blacksmith()
    minetest.register_node("mts_pickcrafting:blacksmith", {
        description = "Vortex Blacksmith",
        tiles = {"mts_pickcrafting_pickaxe.png"},
        on_punch = function (pos, node, puncher, pointed_thing)
            Blacksmith.craft_pickaxe(puncher)
        end,
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
        text_mults = text_mults ..
            string.format("item_image[%d,%d;1,1;mts_default:mineral_item%d]", x, y, v)..
            string.format("label[%f,%f;x%.2f]", x + 1.25, y + 0.5, mult)
        x = x + 4
        if x > 4 then
            x = 0
            y = y + 1
        end
    end

    local description = [[The Vortex Blacksmith will absorb the Minerals you have mined to get stronger.
The boosts of the Minerals multiply with each other!

Punch the Blacksmith to craft a Pickaxe for 1 Stick. Pickaxes will deal at least 7 DPS.

Every Mineral Drop adds +0.01 to their Multiplier.]]

    local scroll_height = math.max(0, 6 * #mult_keys - 80)

    return "formspec_version[6]"..
        "size[16,9]"..
        string.format("textarea[11,1;4.8,5;;;%s]", description)..
        string.format("scrollbaroptions[max=%d;arrows=hide]", scroll_height)..
        "scrollbar[10,1;0.4,7;vertical;scroll_mult;]"..
        "scroll_container[1,1;9,9;scroll_mult;vertical;]"..
            "style_type[label;font_size=*1.7;textcolor=#e0ffe0]"..
            text_mults..
        "scroll_container_end[]"..
        "button[11,6.5;2,0.5;absorb;Absorb!]"..
        "container[11,7.5;5,2]"..
            "style_type[label;font_size=*1.2;textcolor=#ffffff]"..
            "label[0,0;Total Multiplier]"..
            "style_type[label;font_size=*1.8;textcolor=#00ff00]"..
            string.format("label[0,0.5;x%s]", Formatter.format(Blacksmith.get_total_mult(), 2, 2))..
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
        local damage = (Blacksmith.get_base_dps() * Big:new(math.random() * 2)):floor()
        if damage < Big:new(7) then
            damage = Big:new(7)
        end
        local item = PickaxeGenerator.generate(damage)
        inv:add_item("main", item)
    else
        minetest.chat_send_all(minetest.colorize("red", "Not enough Sticks!"))
    end
end

function Blacksmith.absorb_inventory(player_name)
    local inv = minetest.get_inventory({type = "player", name = player_name})
    if inv ~= nil then
        local items = inv:get_list("main")
        for k, item in pairs(items) do
            local definition = item:get_definition()
            if definition._blacksmith_multiplier_id ~= nil then
                local idx = definition._blacksmith_multiplier_id
                Blacksmith.data.multipliers[idx] = (Blacksmith.data.multipliers[idx] or 1) + item:get_count() * 0.01
                inv:remove_item("main", item)
            end
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
    Blacksmith.data = minetest.deserialize(storage:get_string("mts_blacksmith"), true) or Blacksmith.init_storage()
end

function Blacksmith.save()
    storage:set_string("mts_blacksmith", minetest.serialize(Blacksmith.data))
end

minetest.register_on_player_receive_fields(function (player, formname, fields)
    if formname == "mts_pickcrafting:blacksmith" then
        if fields.absorb then
            Blacksmith.absorb_inventory(player:get_player_name())
            Blacksmith.show_formspec(player:get_player_name())
        end
    end
end)

Blacksmith.data = Blacksmith.init_storage()
--Blacksmith.load()

return Blacksmith
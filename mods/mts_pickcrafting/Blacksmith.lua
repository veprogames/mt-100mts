Big = dofile(minetest.get_modpath("mts_bignumber").."/bignumber.lua")
PickaxeGenerator = dofile(minetest.get_modpath("mts_pickcrafting").."/PickaxeGenerator.lua")

local storage = minetest.get_mod_storage()

Blacksmith = {
    data = {}
}

function Blacksmith.register_blacksmith()
    minetest.register_node("mts_pickcrafting:blacksmith", {
        description = "Vortex Blacksmith",
        tiles = {"mts_pickcrafting_pickaxe.png"},
        on_punch = function (pos, node, puncher, pointed_thing)
            local damage = (Blacksmith.get_base_dps() * Big:new(math.random() * 2)):floor()
            local item = PickaxeGenerator.generate(damage)
            puncher:get_inventory():add_item("main", item)
            Blacksmith.save()
        end,
        on_rightclick = function (pos, node, clicker, itemstack, pointed_thing)
            minetest.show_formspec(clicker:get_player_name(), "mts_fs_blacksmith", Blacksmith.create_formspec())
        end
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

    return "formspec_version[6]"..
        "size[16,9]"..
        "textarea[11,1;4.8,6;;;The Vortex Blacksmith will absorb the Minerals you have mined to get stronger. The boosts of the Minerals multiply with each other!]"..
        "scrollbaroptions[max=200;arrows=hide]"..
        "scrollbar[10,1;0.4,7;vertical;scroll_mult;]"..
        "scroll_container[1,1;9,9;scroll_mult;vertical;]"..
            "style_type[label;font_size=*1.7;textcolor=#e0ffe0]"..
            text_mults..
        "scroll_container_end[]"..
        "container[11,7.5;5,2]"..
            "style_type[label;font_size=*1.2;textcolor=#ffffff]"..
            "label[0,0;Total Multiplier]"..
            "style_type[label;font_size=*1.8;textcolor=#00ff00]"..
            string.format("label[0,0.5;x%s]", Blacksmith.get_total_mult():to_string())..
        "container_end[]"
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

Blacksmith.data = Blacksmith.init_storage()
--Blacksmith.load()

return Blacksmith
Big = dofile(minetest.get_modpath("mts_bignumber").."/bignumber.lua")
PickaxeGenerator = dofile(minetest.get_modpath("mts_pickcrafting").."/PickaxeGenerator.lua")

local storage = minetest.get_mod_storage()

Blacksmith = {
    data = {}
}

function Blacksmith.register_blacksmith()
    minetest.register_node("mts_pickcrafting:blacksmith", {
        description = "Blacksmith",
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
    return string.format("formspec_version[6]"..
        "size[16,9]"..
        "label[1,1;%s]", "x" .. (Blacksmith.data.multipliers[1] or 1))..
        "label[11,1;This is a description]"
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
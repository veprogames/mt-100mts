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
        on_rightclick = function (pos, node, clicker, itemstack, pointed_thing)
            local damage = (Blacksmith.get_base_dps() * Big:new(math.random() * 2)):floor()
            local item = PickaxeGenerator.generate(damage)
            clicker:get_inventory():add_item("main", item)
            Blacksmith.save()
        end
    })
end

function Blacksmith.init_storage()
    return {
        multipliers = {
            minerals = {} --sequential
        },
        powers = {
            simple = {} -- sequential
        }
    }
end

function Blacksmith.get_total_mult()
    local mult = Big:new(1)
    for k, m in pairs(Blacksmith.data.multipliers.minerals) do
        mult = mult * Big:new(m)
    end
    return mult
end

function Blacksmith.get_total_pow()
    local pow = 1
    for k, p in pairs(Blacksmith.data.powers.simple) do
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

Blacksmith.load()

return Blacksmith
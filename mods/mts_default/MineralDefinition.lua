MineralList = dofile(minetest.get_modpath("mts_default").."/MineralList.lua")
MineralGenerator = dofile(minetest.get_modpath("mts_default").."/MineralGenerator.lua")

MineralDefinition = {}

local function generate_definition(tier)
    return MineralGenerator.generate_for_tier(tier)
end

function MineralDefinition.get_definition(tier)
    if MineralList[tier] ~= nil then
        local mineral = MineralList[tier]
        mineral.tier = tier
        return mineral
    end
    return generate_definition(tier)
end

return MineralDefinition
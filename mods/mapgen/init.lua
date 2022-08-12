local c_dirt = minetest.get_content_id("default:dirt")
local c_active_coal = minetest.get_content_id("minelights:active_coal")
local c_bedrock = minetest.get_content_id("bedrock:bedrock")
local c_wood = minetest.get_content_id("default:wood")
local c_magma = minetest.get_content_id("liquids:magma_still")

local chances = {
    {content = c_active_coal, ymax = -5, ymin = -2000, chance = 0.015},
    {content = c_wood, ymax = -1, ymin = -100, chance = 0.015},

    {content = c_bedrock, ymax = -50, ymin = -250, chance = 0.02},
    {content = c_bedrock, ymax = -250, ymin = -1000, chance = 0.04},
    {content = c_bedrock, ymax = -1000, ymin = -1500, chance = 0.08},
    {content = c_bedrock, ymax = -1500, ymin = -2000, chance = 0.2},

    {content = c_magma, ymax = -250, ymin = -400, chance = 0.003},
    {content = c_magma, ymax = -401, ymin = -800, chance = 0.008},
    {content = c_magma, ymax = -801, ymin = -1600, chance = 0.02},
    {content = c_magma, ymax = -1601, ymin = -2022, chance = 0.04}
}

local function get_content_from_chances(y)
    for i, chance in ipairs(chances) do
        if y <= chance.ymax and y >= chance.ymin and math.random() < chance.chance then
            return chance.content
        end
    end
    return nil
end

local function get_content_mineral(y)
    local tier = math.floor(1 - y / 20 + math.random() * 0.9)
    if math.random() < 0.045 then
        tier = tier + math.random(2, 4)
    end
    tier = math.min(100, tier)
    return minetest.get_content_id("default:mineral"..tier)
end

minetest.register_on_generated(function(minp, maxp, blockseed)
    local voxelmanip, emin, emax = minetest.get_mapgen_object("voxelmanip")
    local area = VoxelArea:new({MinEdge = emin, MaxEdge = emax})
    local data = voxelmanip:get_data()

    for x = minp.x, maxp.x do
        for y = minp.y, maxp.y do
            for z = minp.z, maxp.z do
                if y < 0 then
                    local idx = area:index(x, y, z)
                    local cont
                    if y >= -1 then
                        cont = c_dirt
                    elseif y < -2022 then
                        cont = c_bedrock
                    else
                        cont = get_content_from_chances(y)
                        if cont == nil then
                            cont = get_content_mineral(y)
                        end
                    end
                    data[idx] = cont
                end
            end
        end
    end

    voxelmanip:set_data(data)
    voxelmanip:calc_lighting()
    voxelmanip:write_to_map(data)
end)
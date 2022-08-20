local c_grass = minetest.get_content_id("mts_default:grass")
local c_dirt = minetest.get_content_id("mts_default:dirt")
local c_bedrock = minetest.get_content_id("mts_bedrock:bedrock")
local c_end_of_map = minetest.get_content_id("mts_bedrock:end_of_map")
local c_wood = minetest.get_content_id("mts_default:wood")

local c_active_coal = minetest.get_content_id("mts_lights:active_coal")
local c_glowstone = minetest.get_content_id("mts_lights:glowstone")
local c_pocket_sun = minetest.get_content_id("mts_lights:pocket_sun")

local c_magma = minetest.get_content_id("mts_liquids:magma_still")
local c_lava = minetest.get_content_id("mts_liquids:lava_still")
local c_plasmatic_fluid = minetest.get_content_id("mts_liquids:plasmatic_still")

local c_grass_plant = minetest.get_content_id("mts_plants:grass")
local c_sunflower_plant = minetest.get_content_id("mts_plants:sunflower")

local c_teleporter = minetest.get_content_id("mts_teleporters:inactive")

local perlin_config = {seed = 42, octaves = 4, persist = 0.7, spread = {x = 40, y = 40, z = 40}}

local chances = {
    {content = c_teleporter, ymax = -10, ymin = -2000, chance = 0.001},

    {content = c_wood, ymax = -1, ymin = -100, chance = 0.015},

    {content = c_bedrock, ymax = -25, ymin = -250, chance = 0.02},
    {content = c_bedrock, ymax = -250, ymin = -1000, chance = 0.04},
    {content = c_bedrock, ymax = -1000, ymin = -1500, chance = 0.08},
    {content = c_bedrock, ymax = -1500, ymin = -2000, chance = 0.2},

    -- lights
    {content = c_active_coal, ymax = -5, ymin = -400, chance = 0.015},
    {content = c_glowstone, ymax = -300, ymin = -1600, chance = 0.012},
    {content = c_pocket_sun, ymax = -1501, ymin = -2022, chance = 0.01},

    -- liquids
    {content = c_magma, ymax = -60, ymin = -250, chance = 0.0015},
    {content = c_magma, ymax = -251, ymin = -400, chance = 0.003},
    {content = c_magma, ymax = -401, ymin = -800, chance = 0.008},

    {content = c_lava, ymax = -801, ymin = -1200, chance = 0.01},
    {content = c_lava, ymax = -1201, ymin = -1600, chance = 0.015},

    {content = c_plasmatic_fluid, ymax = -1601, ymin = -1800, chance = 0.015},
    {content = c_plasmatic_fluid, ymax = -1801, ymin = -2022, chance = 0.025}
}

local function get_content_from_chances(y)
    for i, chance in ipairs(chances) do
        if y <= chance.ymax and y >= chance.ymin and math.random() < chance.chance then
            return chance.content
        end
    end
    return nil
end

local function get_block_tier(y)
    local tier = math.floor(1 - y / 20 + math.random() * 0.4)
    return math.min(100, math.max(1, tier))
end

local function get_content_mineral(y)
    local tier_bonus = math.floor(4 - math.log(1 + math.random() * 2 ^ 4, 2)) -- 0.5x as likely for each better mineral
    local tier = get_block_tier(y) + tier_bonus
    tier = math.max(1, math.min(100, tier))
    return minetest.get_content_id("mts_default:mineral"..tier)
end

local function get_content_stone(y)
    local tier = get_block_tier(y)
    return minetest.get_content_id("mts_default:stone"..tier)
end

local function get_random_plant()
    if math.random() < 0.2 then
        return c_grass_plant
    elseif math.random() < 0.004 then
        return c_sunflower_plant
    end
    return nil
end

local function get_world_height(perlin_obj, x, z)
    return perlin_obj:get_2d({x = x, y = z}) * 3.5
end

minetest.register_on_generated(function(minp, maxp, blockseed)
    local voxelmanip, emin, emax = minetest.get_mapgen_object("voxelmanip")
    local area = VoxelArea:new({MinEdge = emin, MaxEdge = emax})
    local data = voxelmanip:get_data()

    local perlin = minetest.get_perlin(perlin_config)

    for x = minp.x, maxp.x do
        for z = minp.z, maxp.z do
            for y = minp.y, maxp.y do
                local h = get_world_height(perlin, x, z)
                local idx = area:index(x, y, z)
                if math.floor(y) == math.floor(h + 1) then
                    local plant = get_random_plant()
                    if plant ~= nil then
                        data[idx] = plant
                    end
                end
                if y <= h then
                    local cont
                    if y >= h - 1 then
                        cont = c_grass
                    elseif y >= h - 3 then
                        cont = c_dirt
                    elseif y < -2022 then
                        cont = c_end_of_map
                    else
                        cont = get_content_from_chances(y)
                        if cont == nil then
                            if math.random() < 0.05 then
                                cont = get_content_mineral(y)
                            else
                                cont = get_content_stone(y)
                            end
                        end
                    end
                    data[idx] = cont
                end
				-- if x > 0 then data[idx] = minetest.CONTENT_AIR end -- uncomment to see ore distribution
            end
        end
    end

    voxelmanip:set_data(data)
    voxelmanip:calc_lighting()
    voxelmanip:write_to_map(data)
end)

minetest.register_on_newplayer(function(player)
    local perlin = minetest.get_perlin(perlin_config)
    local pos = player:get_pos()
    local h = get_world_height(perlin, pos.x, pos.z)
    player:set_pos({x = pos.x, y = h + 1, z = pos.z})
end)

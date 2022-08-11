local c_dirt = minetest.get_content_id("default:dirt")
local c_active_coal = minetest.get_content_id("minelights:active_coal")
local c_wood = minetest.get_content_id("default:wood")

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
                    elseif y < -5 and math.random() < 0.015 then
                        cont = c_active_coal
                    elseif y > -100 and math.random() < 0.03 * (1 - y / 100.0) then
                        cont = c_wood
                    else
                        local tier = math.floor(1 - y / 20 + math.random() * 0.7)
                        if math.random() < 0.04 then
                            tier = tier + math.random(2, 4)
                        end
                        tier = math.min(100, tier)
                        cont = minetest.get_content_id("default:mineral"..tier)
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
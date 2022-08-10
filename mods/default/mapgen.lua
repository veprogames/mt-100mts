local c_dirt = minetest.get_content_id("default:dirt")

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
                    else
                        cont = minetest.get_content_id("default:mineral"..math.random(1, 99))
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
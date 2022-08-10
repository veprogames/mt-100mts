minetest.register_node("default:dirt", {
    description="Dirt",
    tiles={"dirt.png"},
    groups={cracky=0}
})

minetest.register_node("default:stone", {
    description="Stone",
    tiles={"stone.png"}
})

for i=1,100 do
    local col = string.format("#%02X%02X%02X", math.random(0, 255), math.random(0, 255), math.random(0, 255))
    minetest.register_node("default:mineral"..i, {
        description="Mineral "..i,
        tiles={"stone.png^[multiply:"..col},
        groups={cracky=i}
    })
end
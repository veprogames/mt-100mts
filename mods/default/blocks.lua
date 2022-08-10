minetest.register_node("default:dirt", {
    description="Dirt",
    tiles={"default_dirt.png"},
    groups={cracky=0},
    drop={}
})

for i=1,100 do
    local col = string.format("#%02X%02X%02X", math.random(0, 255), math.random(0, 255), math.random(0, 255))
    minetest.register_node("default:mineral"..i, {
        description="Mineral "..i,
        tiles={"default_stone.png^(default_ore.png^[multiply:"..col..")"},
        groups={cracky=i},
        drop={
            items = {
                {items = {"default:mineral_drop"..i}}
            }
        }
    })
end
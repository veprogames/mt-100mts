Minerals = dofile(minetest.get_modpath("default").."/minerals.lua")

minetest.register_node("default:dirt", {
    description="Dirt",
    tiles={"default_dirt.png"},
    groups={cracky=0},
    drop={}
})

minetest.register_node("default:wood", {
    description="Wood Block",
    tiles={"default_wood.png"},
    groups={choppy = 1},
    drop={
        items = {
            {items = {"default:stick 2"}}
        }
    }
})

for i = 1, 100 do
    local col = Minerals.get_color(i)
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
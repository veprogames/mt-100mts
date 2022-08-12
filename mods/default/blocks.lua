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
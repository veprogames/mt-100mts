minetest.register_node("mts_bedrock:bedrock", {
    description = "Bedrock",
    tiles = {"mts_bedrock_bedrock.png"},
    groups = {bedrocky=1},
    drop = {}
})

-- never meant to be broken
minetest.register_node("mts_bedrock:end_of_map", {
    description = "Bedrock",
    tiles = {"mts_bedrock_endofmap.png"},
    pointable = false,
    diggable = false,
    drop = {}
})
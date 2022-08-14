minetest.register_chatcommand("mts_tutorial", {
    description = "Show instructions for the game",
    func = function (name, param)
        return true,
            "1. Dig down and mine Stones\n"..
            "2. Craft 5 Pebbles into a Rock\n"..
            "3. Craft a Pickaxe out of 3 Rocks and 2 Sticks\n"..
            "4. Mine Ores, craft Ingots / Gems etc. and craft better Pickaxes\n"
    end
})
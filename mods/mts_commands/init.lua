minetest.register_chatcommand("mts_tutorial", {
    description = "Show instructions for the game",
    func = function (name, param)
        return true,
            "1. Dig down and mine Stones\n"..
            "2. Craft 5 Pebbles into a Rock\n"..
            "3. Craft a Vortex Anvil out of 3 Rocks and 4 Pebble\n"..
            "4. Mine Minerals and craft stronger Pickaxes"
    end
})
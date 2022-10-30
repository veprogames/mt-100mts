Tutorial = {}

function Tutorial.get_formspec()
    local text = [[1. Dig down and mine Stones
2. Craft 5 Pebbles into a Rock
3. Craft a Vortex Anvil out of 3 Rocks and 4 Pebble
4. Right Click the Blacksmith, let your Blacksmith absorb Minerals and craft stronger Pickaxes

Avoid dying, as it will erase all minerals that are currently in your inventory]]

    return "formspec_version[6]"..
        "size[10.75,9.5]"..
        "style_type[label;font_size=*2;textcolor=#00ff00]"..
        "label[1,1;Tutorial]"..
        "style_type[label;font_size=*1]"..
        string.format("textarea[1,1.7;5,8;;;%s]", text)
end

return Tutorial
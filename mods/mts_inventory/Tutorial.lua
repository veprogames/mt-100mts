Tutorial = {}

function Tutorial.show_formspec(player)
    local text = [[1. Dig down and mine Stones
2. Craft 5 Pebbles into a Rock
3. Craft a Vortex Anvil out of 3 Rocks and 4 Pebble
4. Right Click the Blacksmith, let your Blacksmith absorb Minerals and craft stronger Pickaxes

Avoid dying, as it will erase all minerals that are currently in your inventory]]

    minetest.show_formspec(player:get_player_name(), "mts_inventory:tutorial",
    "formspec_version[6]"..
    "size[10.75,9.5]"..
    "background[0,0;10.75,9.5;mts_inventory_tutorial.png]"..
    "style_type[label;font_size=*2;textcolor=#00ff00]"..
    "label[1,1;Tutorial]"..
    "style_type[label;font_size=*1]"..
    string.format("textarea[1,1.7;5,8;;;%s]", text)..
    "container[6,1.7;4,4]"..
        "tooltip[0,0;3,3;Blacksmith Crafting Recipe]"..
        "item_image[0,0;1,1;mts_default:rock]"..
        "item_image[1,0;1,1;mts_default:rock]"..
        "item_image[2,0;1,1;mts_default:rock]"..
        "item_image[1,1;1,1;mts_default:pebble]"..
        "item_image[0,2;1,1;mts_default:pebble]"..
        "item_image[1,2;1,1;mts_default:pebble]"..
        "item_image[2,2;1,1;mts_default:pebble]"..
    "container_end[]"
)
end

return Tutorial
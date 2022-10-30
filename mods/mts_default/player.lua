-- erase all minerals in inventory
minetest.register_on_dieplayer(function(player, reason)
    local inv = player:get_inventory()
    local items = inv:get_list("main")
    for k, item in pairs(items) do
        local definition = item:get_definition()
        if definition._blacksmith_multiplier_id or definition._blacksmith_power_id then
            inv:remove_item("main", item)
        end
    end
end)

minetest.register_on_joinplayer(function(player, last_login)
    player:set_formspec_prepend(
        "background9[0,0;0,0;mts_default_formspec_bg.png;true;64]"..
        "bgcolor[#00000000]"..
        "listcolors[#5d6064;#9f9f9f;#00000000;#5d6064;#ffffff]"..
        "style_type[button;bgimg=mts_default_formspec_btn.png]"..
        "style_type[button:hovered;bgimg=mts_default_formspec_btn_hovered.png]"..
        "style_type[button:pressed;bgimg=mts_default_formspec_btn_pressed.png]"
    )
end)
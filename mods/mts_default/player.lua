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
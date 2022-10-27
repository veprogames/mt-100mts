Tutorial = dofile(minetest.get_modpath("mts_inventory").."/Tutorial.lua")

local inventory_formspec = ""
	.. "formspec_version[6]"
	.. "size[10.75,9.5]"
	.. "listcolors[#77777700;#00000020;#0000;#779;#fff]"
	.. "container[0.5,0.5]"
	.. "container[3.75,0]"
	.. "list[current_player;craft;0,0;3,3;]"
	.. "list[current_player;craftpreview;5,1.25;1,1;]"
	.. "container_end[]"
	.. "list[current_player;main;0,3.75;8,4;]"
	.. "listring[current_player;main]"
	.. "listring[current_player;craft]"
	.. "container_end[]"
	.. "button[1,1;2,1;inventory_tutorial;Tutorial]"
	.. "bgcolor[;neither;]"
	.. "background[0,0;10.75,9.5;mts_inventory_inventory.png;false]"

minetest.register_on_joinplayer(function(player, last_login)
	player:hud_set_hotbar_image("mts_inventory_hotbar.png")
	player:hud_set_hotbar_selected_image("mts_inventory_hotbar_selected.png")
	player:set_inventory_formspec(inventory_formspec)
end)

minetest.register_on_newplayer(function(player)
	minetest.chat_send_player(player:get_player_name(),
		"Welcome to 100 Minerals to Success! Type "..minetest.colorize("#00ff00", "/mts_tutorial").." for an introduction")
end)

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if fields.inventory_tutorial then
		Tutorial.show_formspec(player)
	end
end)

Tutorial = dofile(minetest.get_modpath("mts_inventory").."/Tutorial.lua")
Credits = dofile(minetest.get_modpath("mts_inventory").."/Credits.lua")

minetest.register_on_joinplayer(function(player, last_login)
	i3.new_tab("mts_inventory:tutorial", {
		description = "Tutorial",

		formspec = function (player, data, fs)
			fs(Tutorial.get_formspec())
		end
	})

	i3.new_tab("mts_inventory:credits", {
		description = "Credits",

		formspec = function (player, data, fs)
			fs(Credits.get_formspec())
		end
	})

	local nums = {}
	for i = 2, 100 do nums[#nums + 1] = tostring(i) end
	i3.compress("mts_default:stone1", {
		replace = "1",
		by = nums
	})
	i3.compress("mts_default:mineral1", {
		replace = "1",
		by = nums
	})
	i3.compress("mts_default:mineral_item1", {
		replace = "1",
		by = nums
	})
end)

minetest.register_on_newplayer(function(player)
	minetest.chat_send_player(player:get_player_name(),
		"Welcome to 100 Minerals to Success! Click "..minetest.colorize("#00ff00", "Tutorial").." in your inventory for an introduction")
end)
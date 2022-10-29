--[[
stretch goals:
	animated texture
	sounds
	particles
	hands free activation
--]]
local modstorage = minetest.get_mod_storage()

local active_teleporters = minetest.deserialize(modstorage:get_string("teleporters"), true) or {}

local function save_teleporters()
	local s = minetest.serialize(active_teleporters)
	modstorage:set_string("teleporters", s)
end

local function add_station(network, pos)
	if not active_teleporters[network] then active_teleporters[network] = {} end
	table.insert(active_teleporters[network], pos)

	local meta = minetest.get_meta(pos)
	meta:set_string("network", network)
	meta:set_string("infotext", "Network: " .. network)

	minetest.swap_node(pos, {name = "mts_teleporters:active"})

	save_teleporters()
end

local function remove_station(network, pos)
	for k, v in pairs(active_teleporters[network]) do
		if pos == v then
			table.remove(active_teleporters[network], k)
		end
	end
	if #active_teleporters[network] == 0 then
		active_teleporters[network] = nil
	end
	save_teleporters()
end

-- formspec for setting network label
local activate_fs = ""
	.. "formspec_version[6]"
	.. "size[7,5,false]"
	.. "textarea[0.5,0.5;6.25,3;;;"
	.. "Activate Teleporter and assign it to a Network."
	.. "\nUpon Teleportation, you will be teleported to another random Teleporter that is in the same Network."
	.. "\nBeware! Once a teleporter is activated it becomes entangled with the very fabric of space-time and becomes indestructible."
	.. "]"
	.. "field[2,4;3,0.75;network_name;Network name:;network_1]"
	.. "button_exit[0.25,4;1.5,0.75;confim;Activate]"
	.. "button_exit[5.25,4;1.5,0.75;exit;Cancel]"
	.. "background[0,0;7,5;mts_teleporters_activate.png;false]"

minetest.register_node("mts_teleporters:inactive", {
	description = "Telporter",
	tiles = {"mts_teleporters_inactive.png"},
	groups = {teleportey = 1},
	sounds = {
		dig = {name = "teleporter", pitch = 1.4}
	},
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		-- store position in player meta, so it doesn't have to be passed through the formspec
		local p_meta = clicker:get_meta()
		p_meta:set_string("tp_pos", minetest.pos_to_string(pos))

		minetest.show_formspec(clicker:get_player_name(), "mts_teleporters:set_network", activate_fs)
	end,
})

-- formspec for changing assigned network
local edit_fs = ""
	.. "formspec_version[6]"
	.. "size[4,4,false]"
	.. "label[0.5,0.75;Change network:]"
	.. "field[1,1.75;2,0.75;network_name;New name:;network_1]"
	.. "button_exit[0.25,3;1.5,0.75;confim;Change]"
	.. "button_exit[2.25,3;1.5,0.75;exit;Cancel]"
	.. "background[0,0;4,4;mts_teleporters_fs.png;false]"

minetest.register_node("mts_teleporters:active", {
	description = "Telporter (Active)",
	tiles = {"mts_teleporters_active.png"},
	light_source = 10,
	-- groups = {teleportey = 2}, -- intentionally not diggable
	drop = {},
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		local p_meta = clicker:get_meta()
		p_meta:set_string("tp_pos", minetest.pos_to_string(pos))

		local meta = minetest.get_meta(pos)
		local old_network = meta:get_string("network")

		minetest.show_formspec(clicker:get_player_name(), "mts_teleporters:edit_network", edit_fs:gsub("network_1", old_network))
	end,
	on_punch = function(pos, node, puncher, pointed_thing)
		-- allows to punch without immediate teleportation
		if puncher:get_player_control().sneak then return end

		local meta = minetest.get_meta(pos)
		local network = meta:get_string("network")
		local teleporters = active_teleporters[network]

		-- when network data got lost
		if teleporters == nil or #teleporters == 0 then
			minetest.chat_send_player(puncher:get_player_name(), "Something went wrong. Re-adding station to the " .. network .. " network.")
			add_station(network, pos)
			return
		end

		if #teleporters == 1 then
			minetest.chat_send_player(puncher:get_player_name(), "There are no other teleporters on the " .. network .. " network.")
			return
		end

		local dest = teleporters[math.random(1, #teleporters)]
		-- make sure the destination is different from the starting point
		while pos:equals(dest) do
			dest = teleporters[math.random(1, #teleporters)]
		end

		local p_meta = puncher:get_meta()
		local last_time = p_meta:get_int("last_teleport")
		local time = minetest.get_gametime()
		-- prevent immediate re-teleportation
		if time - last_time < 1 then return end

		puncher:set_pos(vector.new(dest.x, dest.y + 0.5, dest.z))
		p_meta:set_int("last_teleport", time)
	end,
	-- in case they ever become diggable
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		local network = oldmetadata.fields.network
		remove_station(network, pos)
	end,
})



minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname == "mts_teleporters:set_network" then
		if fields.confim then
			local p_meta = player:get_meta()

			local network = fields.network_name
			local pos = minetest.string_to_pos(p_meta:get_string("tp_pos"))

			if network == "" then
				minetest.chat_send_player(player:get_player_name(), "A network name must be specified.")
				return
			end

			local above1 = vector.new(pos.x, pos.y + 1, pos.z)
			local above2 = vector.new(pos.x, pos.y + 2, pos.z)
			if not (minetest.get_node(above1).name == "air" and minetest.get_node(above2).name == "air") then
				minetest.chat_send_player(player:get_player_name(), "Can't activate teleporter. Insufficient space.")
				return
			end

			add_station(network, pos)
		end
		return true
	elseif formname == "mts_teleporters:edit_network" then
		if fields.confim then
			local p_meta = player:get_meta()
			local pos = minetest.string_to_pos(p_meta:get_string("tp_pos"))

			local meta = minetest.get_meta(pos)
			local old_network = meta:get_string("network")

			local network = fields.network_name

			if network == "" then
				minetest.chat_send_player(player:get_player_name(), "A network name must be specified.")
				return
			end

			if network == old_network then return end

			remove_station(old_network, pos)
			add_station(network, pos)
		end
		return true
	else
		return false
	end
end)

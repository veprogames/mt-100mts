-- local modname = minetest.get_current_modname()
-- local modpath = minetest.get_modpath(modname)
--[[
TODO:
	make teleporters diggable
	a way to pass the node possition without it being editable by the player
		I am thinking player meta

	spawn teleporters in world
	proper textures for teleporter
	clean up formspec

stretch goals
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
local fs = ""
	.. "formspec_version[6]"
	.. "size[4,4,false]"
	.. "label[0,0.5;Activate teleporter and assign to \nnetwork]"
	.. "field[0,2;2,1;network_name;this is label;network]"
	.. "button_exit[0,3;1,1;confim;N]"
	.. "button_exit[2,3;1,1;exit;C]"

minetest.register_node("mts_teleporters:inactive", {
	description = "Telporter",
	tiles = {"mts_teleporters_inactive.png"},
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		-- TODO add pos to the formspec to pass along or move formspec to node meta
		local fs = fs .. "field[2,2;1,1;pos;pos;" .. minetest.pos_to_string(pos) .. "]"
		minetest.show_formspec(clicker:get_player_name(), "mts_teleporters:set_network", fs)
		-- show formspec to assign network label, which activates teleporter
	end,
})
minetest.register_node("mts_teleporters:active", {
	description = "Telporter (Active)",
	tiles = {"mts_teleporters_active.png"},
	light_source = 10,
	on_punch = function(pos, node, puncher, pointed_thing)
		local meta = minetest.get_meta(pos)
		local network = meta:get_string("network")
		local teleporters = active_teleporters[network]
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
		while pos:equals(dest) do
			dest = teleporters[math.random(1, #teleporters)]
		end

		local pmeta = puncher:get_meta()
		local last_time = pmeta:get_int("last_teleport")
		local time = minetest.get_gametime()

		if time - last_time < 1 then return end

		puncher:set_pos(vector.new(dest.x, dest.y + 0.5, dest.z))
		pmeta:set_int("last_teleport", time)
	end,
	drop = {},
	on_dig = function(pos, node, digger)
		local meta = minetest.get_meta(pos)
		local network = meta:get_string("network")
		remove_station(network, pos)
		-- minetest.remove_node(pos)
		return true
	end,
})

-- debug function
local function print_table(po)
	for k, v in pairs(po) do
		minetest.chat_send_all(type(k) .. " : " .. tostring(k) .. " | " .. type(v) .. " : " .. tostring(v))
	end
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "mts_teleporters:set_network" then return end
	if fields.confim then
		local network = fields.network_name
		local pos = minetest.string_to_pos(fields.pos)
		add_station(network, pos)


	end

	-- minetest.chat_send_all("Player: " .. player:get_player_name() .. " sends form " .. formname)
	-- print_table(fields)
end)

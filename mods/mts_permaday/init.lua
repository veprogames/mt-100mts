-- need to store setting to restore it later
local time_speed = minetest.settings:get("time_speed") or 72
minetest.settings:set("time_speed", 0)
-- this has nothing to do with player joining, but needs to be delayed until the world is active
minetest.register_on_joinplayer(function()
	minetest.set_timeofday(0.5)
end)
-- restore time_speed, so we don't mess up other games
minetest.register_on_shutdown(function()
	minetest.settings:set("time_speed", time_speed)
end)

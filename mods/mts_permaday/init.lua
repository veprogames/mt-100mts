-- override into a double sun system with permanent daylight
-- in contrast to changing time_scale, this doesn't mess with other games if the time_scale wasn't reverted on unexpected player leave
-- there is no way to extensively alter celestial bodies yet (e. g. changing sky coordinates manually)
minetest.register_on_joinplayer(function(player)
	player:set_stars({
		visible = false
	})
	player:set_sun({
		sunrise_visible = false,
		texture = "sun.png"
	})
	player:set_moon({
		texture = "sun.png",
		scale = 1.57
	})
	player:override_day_night_ratio(1)
end)

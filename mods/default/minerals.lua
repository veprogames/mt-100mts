Minerals = {}

function Minerals.get_color(tier)
    math.randomseed(tier)
    return string.format("#%02X%02X%02X", math.random(0, 255), math.random(0, 255), math.random(0, 255))
end

return Minerals
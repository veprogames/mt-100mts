Big = dofile(minetest.get_modpath("mts_bignumber").."/bignumber.lua")
Notations = dofile(minetest.get_modpath("mts_bignumber").."/notations.lua")

Formatter = {
    notation = Notations.DynamicNotation:new{big = Notations.LetterNotation:new(), limit = Big:new(10000)}
}

function Formatter.format(n, places_big, places_small)
    return Formatter.notation:format(n, places_big, places_small)
end

return Formatter
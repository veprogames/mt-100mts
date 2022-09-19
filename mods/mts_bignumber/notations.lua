Notations = {
    BaseLetterNotation = dofile(minetest.get_modpath("mts_bignumber").."/notations/baseletternotation.lua"),
    LetterNotation = dofile(minetest.get_modpath("mts_bignumber").."/notations/letternotation.lua"),
    CyrillicNotation = dofile(minetest.get_modpath("mts_bignumber").."/notations/cyrillicnotation.lua"),
    GreekNotation = dofile(minetest.get_modpath("mts_bignumber").."/notations/greeknotation.lua"),
    HebrewNotation = dofile(minetest.get_modpath("mts_bignumber").."/notations/hebrewnotation.lua"),
    ScientificNotation = dofile(minetest.get_modpath("mts_bignumber").."/notations/scientificnotation.lua"),
    EngineeringNotation = dofile(minetest.get_modpath("mts_bignumber").."/notations/engineeringnotation.lua"),
    DynamicNotation = dofile(minetest.get_modpath("mts_bignumber").."/notations/dynamicnotation.lua")
}

return Notations
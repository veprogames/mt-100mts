Credits = {}

function Credits.get_formspec()
    local contributors = [[veprogames - https://github.com/veprogames
Skamiz - https://github.com/Skamiz]]

    local mods = [[i3 - https://github.com/minetest-mods/i3]]

    local other_tools = [[Stable Diffusion:
https://github.com/CompVis/stable-diffusion
https://github.com/AUTOMATIC1111/stable-diffusion-webui]]

    return "formspec_version[6]"..
        "size[10.75,9.5]"..
        "style_type[label;font_size=*2;textcolor=#00ff00]"..
        "label[1,1;Contributors]"..
        "style_type[label;font_size=*1]"..
        string.format("textarea[1,1.7;8,2;;;%s]", minetest.formspec_escape(contributors))..

        "style_type[label;font_size=*2;textcolor=#00ff00]"..
        "label[1,4;Mods]"..
        "style_type[label;font_size=*1]"..
        string.format("textarea[1,4.7;8,2;;;%s]", minetest.formspec_escape(mods))..

        "style_type[label;font_size=*2;textcolor=#00ff00]"..
        "label[1,7;Other Tools]"..
        "style_type[label;font_size=*1]"..
        string.format("textarea[1,7.7;8,4;;;%s]", minetest.formspec_escape(other_tools))
end

return Credits
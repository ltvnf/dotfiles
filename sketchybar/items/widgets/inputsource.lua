local colors = require("colors")
local settings = require("settings")

sbar.add("event", "input_source_changed", "AppleSelectedInputSourcesChangedNotification")

local inputsource = sbar.add("item", "widgets.inputsource", {
    position = "right",
    padding_right = settings.paddings + 7,
    label = {
        -- get the string from the function
        string = "N/A",
        -- background = {
        -- },
        font = { family = settings.font.style_map["Heavy"] }
    },
})

local function get_input_source()
    sbar.exec(
        'defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources | grep "KeyboardLayout Name" | cut -c 33- | rev | cut -c 2- | rev',
        function(inputsource_info)
            inputsource_info = inputsource_info:gsub("\n", "")
            if inputsource_info == "Russian" then
                inputsource:set({
                    label = {
                        string = "RU"
                    },
                })
            elseif inputsource_info == "ABC" then
                inputsource:set({
                    label = {
                        string = "EN"
                    },
                })
            else
                inputsource:set({
                    label = "N/A",
                })
            end
        end)
end

get_input_source()

inputsource:subscribe({ "routine", "input_source_changed" }, function()
    get_input_source()
end)


sbar.add("bracket", "widgets.inputsource.bracket", { inputsource.name }, {
    background = {
        color = colors.bgt,
        corner_radius = 15,
        border_width = 0,
        height = 28,
    }
})

sbar.add("item", "widgets.inputsource.padding", {
    position = "right",
    width = settings.group_paddings
})

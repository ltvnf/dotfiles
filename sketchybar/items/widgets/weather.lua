local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

-- Execute the event provider binary which provides the event "weather_update"
-- for the weather data, which is fired every 600 seconds (10 minutes).
sbar.exec("killall weather_load >/dev/null; $CONFIG_DIR/helpers/event_providers/weather_load/bin/weather_load weather_update 600.0")

local weather = sbar.add("item", "widgets.weather", {
    position = "right",
    icon = {
        string = icons.weather.sunny,
        padding_right = 5,
    },
    label = {
        string = "??°",
        font = {
            family = settings.font.numbers,
            -- style = settings.font.style_map["Bold"],
            size = 13.0,
        },
        padding_right = 5,
    },
    background = {
        color = colors.transparent,
        border_width = 0,
        height = 22,
    },
})

local function condition_to_icon(condition)
    local c = string.lower(condition)
    if string.find(c, "thunder") or string.find(c, "lightning") then
        return icons.weather.thunder
    elseif string.find(c, "snow") or string.find(c, "sleet") or string.find(c, "blizzard") then
        return icons.weather.snow
    elseif string.find(c, "rain") or string.find(c, "drizzle") or string.find(c, "shower") then
        return icons.weather.rain
    elseif string.find(c, "fog") or string.find(c, "mist") or string.find(c, "haze") then
        return icons.weather.fog
    elseif string.find(c, "partly") or string.find(c, "partially") then
        return icons.weather.partly_cloudy
    elseif string.find(c, "cloud") or string.find(c, "overcast") then
        return icons.weather.cloudy
    else
        return icons.weather.sunny
    end
end

weather:subscribe("weather_update", function(env)
    local icon = condition_to_icon(env.condition)
    local temp_display = env.temp
    -- Strip leading + for cleaner display
    if string.sub(temp_display, 1, 1) == "+" then
        temp_display = string.sub(temp_display, 2)
    end

    weather:set({
        icon = { string = icon },
        label = temp_display,
    })
end)

weather:subscribe("mouse.clicked", function(env)
    sbar.exec("open -a Weather")
end)

-- Background around the weather item
sbar.add("bracket", "widgets.weather.bracket", { weather.name }, {
    background = {
        color = colors.bgt,
        corner_radius = 15,
        border_width = 0,
    }
})

sbar.add("item", "widgets.weather.padding", {
    position = "right",
    width = settings.group_paddings,
})

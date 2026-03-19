local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

-- Execute the event provider binary which provides the event "disk_update" for
-- the disk usage data, which is fired every 30.0 seconds.
sbar.exec("killall disk_load >/dev/null; $CONFIG_DIR/helpers/event_providers/disk_load/bin/disk_load disk_update 30.0")

local disk = sbar.add("graph", "widgets.disk", 42, {
    position = "right",
    graph = { color = colors.blue },
    background = {
        color = colors.transparent,
        border_width = 0,
        height = 22,
    },
    icon = {
        string = icons.disk,
        padding_right = 5,
    },
    label = {
        string = "disk ??%",
        font = {
            family = settings.font.numbers,
            style = settings.font.style_map["Bold"],
            size = 9.0,
        },
        align = "right",
        padding_right = 5,
        width = 7,
        y_offset = 4
    },
})

disk:subscribe("disk_update", function(env)
    local load = tonumber(env.used_percent)
    disk:push({ load / 100. })

    local color = colors.blue
    if load > 70 then
        if load < 80 then
            color = colors.yellow
        elseif load < 90 then
            color = colors.orange
        else
            color = colors.red
        end
    end

    disk:set({
        graph = { color = color },
        label = "disk " .. env.used_percent .. "%",
    })
end)

disk:subscribe("mouse.clicked", function(env)
    sbar.exec("open -a 'Disk Utility'")
end)

-- Background around the disk item
sbar.add("bracket", "widgets.disk.bracket", { disk.name }, {
    background = {
        color = colors.bgt,
        corner_radius = 15,
        border_width = 0,
    }
})

sbar.add("item", "widgets.disk.padding", {
    position = "right",
    width = settings.group_paddings,
})

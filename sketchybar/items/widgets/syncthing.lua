local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

local syncthing = sbar.add("item", "widgets.syncthing", {
    position = "right",
    update_freq = 30,
    icon = {
        string = icons.syncthing.offline,
        color = colors.grey,
        font = {
            style = settings.font.style_map["Bold"],
            size = 16.0,
        },
        padding_left = 5,
        padding_right = 5,
    },
    label = { drawing = false },
})

syncthing:subscribe({ "routine", "forced", "system_woke" }, function()
    sbar.exec(
        "curl -s --connect-timeout 2 http://localhost:8384/rest/noauth/health 2>/dev/null | grep -q OK && echo online || echo offline",
        function(result)
            local online = result:match("online")
            syncthing:set({
                icon = {
                    string = online and icons.syncthing.online or icons.syncthing.offline,
                    color = online and colors.green or colors.grey,
                },
            })
        end
    )
end)

syncthing:subscribe("mouse.clicked", function()
    sbar.exec("open http://localhost:8384")
end)

sbar.add("bracket", "widgets.syncthing.bracket", { syncthing.name }, {
    background = {
        color = colors.bgt,
        corner_radius = 15,
        border_width = 0,
        height = 28,
    }
})

sbar.add("item", "widgets.syncthing.padding", {
    position = "right",
    width = settings.group_paddings,
})

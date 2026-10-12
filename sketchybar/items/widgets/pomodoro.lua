local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

local durations = {
    work = math.floor(settings.pomodoro.work * 60),
    rest = math.floor(settings.pomodoro.rest * 60),
}

local mode = "work"
local running = false
local remaining = durations[mode]
-- Absolute end time while running, so late ticks and sleep don't cause drift
local deadline = 0

local pomodoro = sbar.add("item", "widgets.pomodoro", {
    position = "right",
    update_freq = 0,
    icon = {
        string = icons.pomodoro.work,
        padding_right = 5,
    },
    label = {
        string = "--:--",
        font = {
            family = settings.font.numbers,
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

local function render()
    local color = colors.grey
    if running then
        color = mode == "work" and colors.red or colors.green
    end

    pomodoro:set({
        icon = { string = icons.pomodoro[mode], color = color },
        label = {
            string = string.format("%02d:%02d", remaining // 60, remaining % 60),
            color = color,
        },
        update_freq = running and 1 or 0,
    })
end

local function switch_mode()
    mode = mode == "work" and "rest" or "work"
    remaining = durations[mode]
    deadline = os.time() + remaining
end

local function tick()
    if not running then return end

    remaining = deadline - os.time()
    if remaining <= 0 then
        local message = mode == "work" and "Work is over, time to rest" or "Rest is over, back to work"
        sbar.exec("osascript -e 'display notification \"" .. message .. "\" with title \"Pomodoro\" sound name \"Glass\"'")
        switch_mode()
        running = false
    end
    render()
end

pomodoro:subscribe({ "routine", "system_woke" }, tick)

pomodoro:subscribe("mouse.clicked", function(env)
    if env.BUTTON == "right" then
        switch_mode()
    else
        if running then
            remaining = math.max(deadline - os.time(), 0)
        else
            deadline = os.time() + remaining
        end
        running = not running
    end
    render()
end)

render()

-- Background around the pomodoro item
sbar.add("bracket", "widgets.pomodoro.bracket", { pomodoro.name }, {
    background = {
        color = colors.bgt,
        corner_radius = 15,
        border_width = 0,
    }
})

sbar.add("item", "widgets.pomodoro.padding", {
    position = "right",
    width = settings.group_paddings,
})

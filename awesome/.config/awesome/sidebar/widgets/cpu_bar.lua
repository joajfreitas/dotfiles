local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

-- Set colors
local active_color =  beautiful.cpu_bar_active_color or "#5AA3CC"
local active_background_color = beautiful.cpu_bar_background_color or "#222222"

local cpu_bar = wibox.widget{
    max_value     = 100,
    value         = 60,
    forced_height = dpi(10),
    margins       = {
        top = dpi(8),
        bottom = dpi(8),
		left = dpi(8),
		right = dpi(8),
    },
    forced_width  = dpi(200),
    shape         = gears.shape.rounded_bar,
    bar_shape     = gears.shape.rounded_bar,
    color         = active_color,
    background_color = active_background_color,
    border_width  = 0,
    border_color  = beautiful.border_color,
    widget        = wibox.widget.progressbar,
}

local cpu_text = wibox.widget {
	text = "ola",
	widget = wibox.widget.textbox,
	align = "center",
	color = "#FFFFFF",
	font = sidebar_font,
}


local cpu_widget = wibox.widget{
	{
		widget = cpu_bar
	},
	{
		widget = cpu_text
	},
	layout = wibox.layout.stack,
}

awesome.connect_signal("evil::cpu", function(value)
    -- Use this if you want to display usage percentage
    cpu_bar.value = value
	cpu_text.text = tostring(value)
    -- Use this if you want to display idle percentage
    -- cpu_bar.value = tonumber(100 - value)
end)

return cpu_widget

local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

-- Set colors
--local active_color = "#" -- beautiful.temperature_bar_active_color or "#5AA3CC"
--local background_color = "#FFFFFF" -- beautiful.temperature_bar_background_color or "#222222"

local active_color = beautiful.temperature_bar_active_color or "#5AA3CC"
local background_color = beautiful.temperature_bar_background_color or "#222222"

local temperature_bar = wibox.widget{
	max_value     = 100,
	value         = 100,
	forced_height = dpi(40),
	forced_width = dpi(200),
	color         = active_color,
	background_color = background_color,
	paddings      = 1,
	border_width  = 0,
	border_color  = "#5AA3CC", --beautiful.border_color,
	widget        = wibox.widget.progressbar,
	shape         = gears.shape.rounded_bar,
	bar_shape     = gears.shape.rounded_bar,
	margins       = {
		top = dpi(8),
		bottom = dpi(8),
		right= dpi(8),
		left = dpi(8),
	},
}

local temperature_text = wibox.widget {
	text = "ola",
	widget = wibox.widget.textbox,
	align = "center",
	color = "#FFFFFF",
	font = sidebar_font,
}


local temperature_widget = wibox.widget{
	{
		widget = temperature_bar
	},
	{
		widget = temperature_text
	},
	layout = wibox.layout.stack,
}

awesome.connect_signal("evil::temperature", function(value)
    temperature_bar.value = value 
	temperature_text.text = tostring(value)
end)

return temperature_widget

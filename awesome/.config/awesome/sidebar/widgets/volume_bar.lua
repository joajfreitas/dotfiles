local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

-- Set colors
local active_color = beautiful.volume_bar_active_color or "#5AA3CC"
local muted_color = beautiful.volume_bar_muted_color or "#666666"
local active_background_color = beautiful.volume_bar_active_background_color or "#222222"
local muted_background_color = beautiful.volume_bar_muted_background_color or "#222222"

local volume_bar = wibox.widget{
    max_value     = 100,
    value         = 50,
    forced_height = dpi(10),
    margins       = {
        top    = dpi(8),
        bottom = dpi(8),
        left   = dpi(8),
        right  = dpi(8),
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

local volume_text = wibox.widget {
	text = "ola",
	widget = wibox.widget.textbox,
	align = "center",
	color = "#FFFFFF",
	font = sidebar_font,
}


local volume_widget = wibox.widget{
	{
		widget = volume_bar
	},
	{
		widget = volume_text
	},
	layout = wibox.layout.stack,
}

awesome.connect_signal("evil::volume", function(volume, muted)
    local bg_color
    if muted then
        fill_color = muted_color
        bg_color = muted_background_color
    else
        fill_color = active_color
        bg_color = active_background_color
    end
    volume_bar.value = volume
    volume_bar.color = fill_color
    volume_bar.background_color = bg_color
	volume_text.text = tostring(volume)
end)

return volume_widget

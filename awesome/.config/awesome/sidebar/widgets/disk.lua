local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

local disk = wibox.widget{
    text = "disk space",
    align  = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
}

awesome.connect_signal("evil::disk", function (available)
	disk.markup = tostring(available) .. "GB free"
end)

return disk

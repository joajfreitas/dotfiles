local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")

local helpers = require("helpers")

local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local icons = require("icons")
local apps = require("apps")

-- Helper function that changes the appearance of progress bars and their icons
-- Create horizontal rounded bars
local function format_progress_bar(bar, icon)
    icon.forced_height = icon_size
    icon.forced_width = icon_size
    icon.resize = true
    bar.forced_width = progress_bar_width
    bar.shape = gears.shape.rounded_bar
    bar.bar_shape = gears.shape.rounded_bar

    -- bar.forced_height = dpi(30)
    -- bar.paddings = dpi(4)
    -- bar.border_width = dpi(2)
    -- bar.border_color = x.color8

    local w = wibox.widget{
        nil,
        {
            icon,
            bar,
            spacing = dpi(10),
            layout = wibox.layout.fixed.horizontal
        },
        expand = "none",
        layout = wibox.layout.align.horizontal
    }
    return w
end

-- sidebar_bg = x.background
-- sidebar_bg_alt = x.color0
-- sidebar_fg = x.color7
-- sidebar_opacity = 1
-- sidebar_position = "left" -- left or right
-- sidebar_width = dpi(300)
-- sidebar_y = 0
-- sidebar_border_radius = dpi(0)

sidebar = wibox({visible = false, ontop = true, type = "dock", screen = screen.primary})
sidebar.bg = "#111111"
sidebar.fg = "#ffffff"
sidebar.opacity = 1
sidebar.height = screen.primary.geometry.height
sidebar.width = dpi(300)
sidebar.y = 50

-- local radius = sidebar_border_radius or 0
awful.placement.left(sidebar)
sidebar.shape = helpers.prrect(0, false, true, true, false)


sidebar.visible = false

local volume_icon = wibox.widget.imagebox(icons.image.volume)
local volume_bar = require("noodle.volume_bar")
local volume = format_progress_bar(volume_bar, volume_icon)

volume:buttons(gears.table.join(
    -- Left click - Mute / Unmute
    awful.button({ }, 1, function ()
        helpers.volume_control(0)
    end),
    -- Right click - Run or raise pavucontrol
    awful.button({ }, 3, apps.volume),
    -- Scroll - Increase / Decrease volume
    awful.button({ }, 4, function ()
        helpers.volume_control(2)
    end),
    awful.button({ }, 5, function ()
        helpers.volume_control(-2)
    end)
))


local time = wibox.widget.textclock("%H:%M")
time.align = "center"
time.valign = "center"
time.font = "Fira Mono 55"

local date = wibox.widget.textclock("%B %d")
-- local date = wibox.widget.textclock("%A, %B %d")
-- local date = wibox.widget.textclock("%A, %B %d, %Y")
date.align = "center"
date.valign = "center"
date.font = "Fira Mono 16"


-- Weather widget with text icons
local weather_widget = require("noodle.text_weather")
local weather_widget_icon = weather_widget:get_all_children()[1]
weather_widget_icon.font = "Typicons 25"
local weather_widget_text = weather_widget:get_all_children()[2]
weather_widget_text.font = "Fira Mono 14"

local weather = wibox.widget{
    nil,
    weather_widget,
    nil,
    layout = wibox.layout.align.horizontal,
    expand = "none"
}

local disk_space = require("noodle.disk")
disk_space.font = "Fira Mono 14"
local disk_icon = wibox.widget.imagebox(icons.image.files)
disk_icon.resize = true
disk_icon.forced_width = icon_size
disk_icon.forced_height = icon_size
local disk = wibox.widget{
    nil,
    {
        disk_icon,
        disk_space,
        layout = wibox.layout.fixed.horizontal
    },
    nil,
    expand = "none",
    layout = wibox.layout.align.horizontal
}

disk:buttons(gears.table.join(
    awful.button({ }, 1, function ()
        awful.spawn(user.file_manager, {floating = true})
    end),
    awful.button({ }, 3, function ()
        awful.spawn(user.file_manager .. " /data", {floating = true})
    end)
))

local search_icon = wibox.widget.imagebox(icons.image.search)
search_icon.resize = true
search_icon.forced_width = icon_size
search_icon.forced_height = icon_size
local search_text = wibox.widget.textbox("Search")
search_text.font = "Fira Mono 14"

local search = wibox.widget{
    search_icon,
    search_text,
    layout = wibox.layout.fixed.horizontal
}
search:buttons(gears.table.join(
    awful.button({ }, 1, function ()
        awful.spawn.with_shell("rofi -matching fuzzy -show combi")
        sidebar.visible = false
    end),
    awful.button({ }, 3, function ()
        awful.spawn.with_shell("rofi -matching fuzzy -show run")
        sidebar.visible = false
    end)
))


local temperature_icon = wibox.widget.imagebox(icons.image.temperature)
local temperature_bar = require("noodle.temperature_bar")
local temperature = format_progress_bar(temperature_bar, temperature_icon)
temperature:buttons(
    gears.table.join(
        awful.button({ }, 1, apps.temperature_monitor)
))

local battery_icon = wibox.widget.imagebox(icons.image.battery)
awesome.connect_signal("evil::charger", function(plugged)
    if plugged then
        battery_icon.image = icons.image.battery_charging
    else
        battery_icon.image = icons.image.battery
    end
end)
local battery_bar = require("noodle.battery_bar")
local battery = format_progress_bar(battery_bar, battery_icon)

local cpu_icon = wibox.widget.imagebox(icons.image.cpu)
local cpu_bar = require("noodle.cpu_bar")
local cpu = format_progress_bar(cpu_bar, cpu_icon)

cpu:buttons(
    gears.table.join(
        awful.button({ }, 1, apps.process_monitor),
        awful.button({ }, 3, apps.process_monitor_gui)
))

local ram_icon = wibox.widget.imagebox(icons.image.ram)
local ram_bar = require("noodle.ram_bar")
local ram = format_progress_bar(ram_bar, ram_icon)

ram:buttons(
    gears.table.join(
        awful.button({ }, 1, apps.process_monitor),
        awful.button({ }, 3, apps.process_monitor_gui)
))

sidebar:setup {
	{
		time,
		date,
		volume,
		weather,
        disk,
		temperature,
		cpu,
		ram,
        search,
        layout = wibox.layout.fixed.vertical
	},
	--{
    --    helpers.vertical_pad(40),
	--},
	layout = wibox.layout.align.vertical
}

function toggle_sidebar()
  sidebar.visible = not sidebar.visible
end

-- joaj awesome wm config

-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- {{{ Standard Includes
-- Standard awesome library
local gears          = require("gears")
local awful          = require("awful")
require("awful.autofocus") -- https://www.reddit.com/r/awesomewm/comments/cj8cnv/requireawfulautofocus_doesnt_seem_to_work_how_can/
local wibox          = require("wibox") -- Widget and layout library
local beautiful      = require("beautiful") -- Theme handling library
local naughty        = require("naughty")     -- Notification library
local menubar        = require("menubar")
local hotkeys_popup  = require("awful.hotkeys_popup")
local battery_widget = require("battery-widget")
local volume_control = require("volume-control")
local math           = require("math")
-- }}}
-- {{{ Custom Config
local src = "src/"
local spotify_widget = require("awesome-wm-widgets.spotify-widget.spotify")

-- https://github.com/dluksza/screenful
-- automatic handle of multiple monitors
require("awful.remote")
require(src .. "screenful")

-- Make xresources colors global
x = require(src .. 'x_colors')

local icons = require("src/icons")
icons.init("linebit")

user = require(src .. 'user')

-- Custom configuration
-- mostly taken from https://github.com/elenapan/dotfiles
require("evil")
require("sidebar/sidebar")
--dpi = beautiful.xresources.apply_dpi
--require("dashboard/dashboard")
--require("lock_screen")
require(src .. "exit_screen")

-- define your volume control, using default settings:
volumecfg = volume_control({device="pulse"})

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")
local helpers = require(src .. "helpers")
-- }}}
-- {{{  Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
naughty.notify({ preset = naughty.config.presets.critical,
				 title = "Oops, there were errors during startup!",
				 text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
local in_error = false
awesome.connect_signal("debug::error", function (err)
	-- Make sure we don't go into an endless error loop
	if in_error then return end
	in_error = true

	naughty.notify({ preset = naughty.config.presets.critical,
					 title = "Oops, an error happened!",
					 text = tostring(err) })
	in_error = false
end)
end
-- }}}
-- {{{ Variable definitions
local file = string.format("%s/.config/awesome/themes/f_theme/theme.lua", os.getenv("HOME"), chosen_theme)
beautiful.init(file)

-- This is used later as the default terminal and editor to run.
terminal = "uxterm"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = require(src .. 'layouts')
-- }}}
-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

mymainmenu = awful.menu(
	{ items = 
		{ 
			{ "awesome", myawesomemenu, beautiful.awesome_icon },
			{ "terminal", terminal },
			{ "thunar", function() awful.spawn("thunar") end},
			{ "firefox", function() awful.spawn("firefox") end},
			{ "thunderbird", function() awful.spawn("thunderbird") end},
			{ "arandr", function() awful.spawn("arandr") end},
		}
    }
)

mylauncher = awful.widget.launcher(
	{ image = beautiful.awesome_icon, menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}
-- {{{ Set wallpaper
local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
		if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
		else
			awful.spawn("no wallpaper function")
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end
-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)
-- }}}
-- {{{ Wibar
-- {{{Taglist (Workspaces identifiers) functions
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )
-- }}}
-- {{{ Tasklist (windows miniatures) functions
local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, 
						 function (c)
							  if c == client.focus then
								  c.minimized = true
							  else
								  c:emit_signal(
									  "request::activate",
									  "tasklist",
									  {raise = true}
								  )
							  end
						  end),
                     awful.button({ }, 3, function()
                                              awful.menu.client_list({ theme = { width = 300 } })
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))
--- }}}
--- {{{ Setting wibar for each scree
awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
		style    = {
			shape_border_width = 1,
			shape_border_color = '#777777',
			shape  = gears.shape.powerline,
		},
		layout   = {
			layout  = wibox.layout.flex.horizontal
		},
    }

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            mylauncher,
            s.mytaglist,
            s.mypromptbox,
			spotify_widget,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            awful.widget.keyboardlayout(),
            wibox.layout.margin(wibox.widget.systray(),2,2,2,2),
            wibox.widget.textclock(),
			volumecfg.widget, 
			battery_widget{},
			require("brightness")({}).widget,
            s.mylayoutbox,
        },
    }
end)
-- }}}
-- }}}
-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}
-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = require(src .. 'keys'),
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
          "xtightvncviewer",
		  "mpv"},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
		  "Connection List",
		  "Form"
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = true }
    },

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
}
-- }}}
-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "left",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.minimizebutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

awful.spawn.with_shell("~/.config/awesome/autorun.sh")
--}}}
-- vim: set foldmethod=marker: set foldenable:

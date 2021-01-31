-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
local revelation=require("revelation")
local vicious = require("vicious")
local lain = require("lain")
local brightness = require("brightness")
local battery_widget = require("battery-widget")
-- load the widget code
local volume_control = require("volume-control")
local math = require("math")
local spotify_widget = require("awesome-wm-widgets.spotify-widget.spotify")
local common = require("awful.widget.common")

require("awful.remote")
require("screenful")


-- Theme handling library
local beautiful = require("beautiful")
local xrdb = beautiful.xresources.get_current_theme()
-- Make dpi function global
dpi = beautiful.xresources.apply_dpi
-- Make xresources colors global
x = {
    --           xrdb variable
    background = xrdb.background,
    foreground = xrdb.foreground,
    color0     = xrdb.color0,
    color1     = xrdb.color1,
    color2     = xrdb.color2,
    color3     = xrdb.color3,
    color4     = xrdb.color4,
    color5     = xrdb.color5,
    color6     = xrdb.color6,
    color7     = xrdb.color7,
    color8     = xrdb.color8,
    color9     = xrdb.color9,
    color10    = xrdb.color10,
    color11    = xrdb.color11,
    color12    = xrdb.color12,
    color13    = xrdb.color13,
    color14    = xrdb.color14,
    color15    = xrdb.color15,
}
-- Affects which icon theme will be used by widgets that display image icons.
local icon_themes = {
    "linebit",        -- 1 -- Neon + outline
    "drops",          -- 2 -- Pastel + filled
}
local icon_theme = icon_themes[1]

local icons = require("icons")
icons.init(icon_theme)


-- User variables and preferences
user = {
    -- >> Default applications <<
    -- Check apps.lua for more
    terminal = "kitty -1",
    floating_terminal = "kitty -1",
    browser = "firefox",
    file_manager = "kitty -1 --class files -e ranger",
    editor = "kitty -1 --class editor -e vim",
    email_client = "kitty -1 --class email -e neomutt",
    music_client = "kitty -o font_size=12 --class music -e ncmpcpp",

    -- >> Web Search <<
    web_search_cmd = "xdg-open https://duckduckgo.com/?q=",
    -- web_search_cmd = "xdg-open https://www.google.com/search?q=",

    -- >> User profile <<
    profile_picture = os.getenv("HOME").."/.config/awesome/profile.png",

    -- Directories with fallback values
    dirs = {
        downloads = os.getenv("XDG_DOWNLOAD_DIR") or "~/Downloads",
        documents = os.getenv("XDG_DOCUMENTS_DIR") or "~/Documents",
        music = os.getenv("XDG_MUSIC_DIR") or "~/Music",
        pictures = os.getenv("XDG_PICTURES_DIR") or "~/Pictures",
        videos = os.getenv("XDG_VIDEOS_DIR") or "~/Videos",
        -- Make sure the directory exists so that your screenshots
        -- are not lost
        screenshots = os.getenv("XDG_SCREENSHOTS_DIR") or "~/Pictures/Screenshots",
    },

    -- >> Sidebar <<
    sidebar = {
        hide_on_mouse_leave = true,
        show_on_mouse_screen_edge = true,
    },

    -- >> Battery <<
    -- You will receive notifications when your battery reaches these
    -- levels.
    battery_threshold_low = 20,
    battery_threshold_critical = 5,

    -- >> Weather <<
    -- Get your key and find your city id at
    -- https://openweathermap.org/
    -- (You will need to make an account!)
    openweathermap_key = "0d5089533d9410bdb177fd5e26bfd581",
    openweathermap_city_id = "2267057",
    -- > Use "metric" for Celcius, "imperial" for Fahrenheit
    weather_units = "metric",
	
	lock = "i3lock",
	
}

require("evil")

local xrdb = beautiful.xresources.get_current_theme()
dpi = beautiful.xresources.apply_dpi
x = {
    --           xrdb variable
    background = xrdb.background,
    foreground = xrdb.foreground,
    color0     = xrdb.color0,
    color1     = xrdb.color1,
    color2     = xrdb.color2,
    color3     = xrdb.color3,
    color4     = xrdb.color4,
    color5     = xrdb.color5,
    color6     = xrdb.color6,
    color7     = xrdb.color7,
    color8     = xrdb.color8,
    color9     = xrdb.color9,
    color10    = xrdb.color10,
    color11    = xrdb.color11,
    color12    = xrdb.color12,
    color13    = xrdb.color13,
    color14    = xrdb.color14,
    color15    = xrdb.color15,
}

require("sidebar/sidebar")
--require("dashboard/dashboard")
--require("lock_screen")
require("exit_screen")

-- define your volume control, using default settings:
volumecfg = volume_control({
	widget_text = {
		on = ' V: % 3d%% ',
		off = ' V: % 3dM',
	}
})
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

local helpers = require("helpers")


-- {{{ Error handling
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
-- Themes define colours, icons, font and wallpapers.
local themes = {
    "blackburn",       -- 1
    "copland",         -- 2
    "dremora",         -- 3
    "holo",            -- 4
    "multicolor",      -- 5
    "powerarrow",      -- 6
    "powerarrow-dark", -- 7
    "rainbow",         -- 8
    "steamburn",       -- 9
    "vertex",          -- 10
	"default",         -- 11
}

local chosen_theme = "f_theme" --themes[5]
beautiful.init(string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), chosen_theme))
-- beautiful.init(awful.util.getdir("config")  .. "/themes/default/theme.lua")
revelation.init()
-- beautiful.useless_gap = 5


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
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.tile.top,
    --awful.layout.suit.tile.left,
    --awful.layout.suit.tile.bottom,
    awful.layout.suit.floating,
    --awful.layout.suit.fair,
    --awful.layout.suit.fair.horizontal,
    --awful.layout.suit.spiral,
    --awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    --awful.layout.suit.max.fullscreen,
    --awful.layout.suit.magnifier,
    --awful.layout.suit.corner.nw,
}
-- }}}


-- {{{ Key bindings
globalkeys = gears.table.join(
    awful.key({ modkey, "Shift" }, "x",
        function ()
            exit_screen_show()
        end,
        {description = "quit awesome", group = "awesome"}),
	awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
			  {description="show help", group="awesome"}),
	awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
			  {description = "view previous", group = "tag"}),
	awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
			  {description = "view next", group = "tag"}),
	awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
			  {description = "go back", group = "tag"}),
	awful.key({ modkey,			  }, "e",      revelation,
			  {description = "revelation", group = "tag"}),

    -- Dashboard
    awful.key({ modkey }, "F1", function()
        if dashboard_show then
            dashboard_show()
        end
    end, {description = "dashboard", group = "custom"}),

	awful.key({ modkey,           }, "j",
		function ()
			awful.client.focus.byidx( 1)
		end,
		{description = "focus next by index", group = "client"}
	),
	awful.key({ modkey,           }, "k",
		function ()
			awful.client.focus.byidx(-1)
		end,
		{description = "focus previous by index", group = "client"}
	),
	awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
			  {description = "show main menu", group = "awesome"}),

	-- Layout manipulation
	awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
			  {description = "swap with next client by index", group = "client"}),
	awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
			  {description = "swap with previous client by index", group = "client"}),
	awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
			  {description = "focus the next screen", group = "screen"}),
	awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
			  {description = "focus the previous screen", group = "screen"}),
	awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
			  {description = "jump to urgent client", group = "client"}),
	awful.key({ modkey,           }, "Tab",
		function ()
			awful.client.focus.history.previous()
			if client.focus then
				client.focus:raise()
			end
		end,
		{description = "go back", group = "client"}),

	-- Standard program
	awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
			  {description = "open a terminal", group = "launcher"}),

	awful.key({ modkey, "Shift" }, "r", awesome.restart,
			  {description = "reload awesome", group = "awesome"}),

	awful.key({ modkey, "Shift"   }, "q", awesome.quit,
			  {description = "quit awesome", group = "awesome"}),

	awful.key({modkey,			  }, "d", function () awful.spawn("rofi -show run") end,
			  {description = "launch rofi", group = "awesome"}),

	awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
			  {description = "increase master width factor", group = "layout"}),
	awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
			  {description = "decrease master width factor", group = "layout"}),
	awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
			  {description = "increase the number of master clients", group = "layout"}),
	awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
			  {description = "decrease the number of master clients", group = "layout"}),
	awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
			  {description = "increase the number of columns", group = "layout"}),
	awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
			  {description = "decrease the number of columns", group = "layout"}),
	awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
			  {description = "select next", group = "layout"}),
	awful.key({ modkey, "Control"   }, "space", function () awful.layout.inc(-1)                end,
			  {description = "select previous", group = "layout"}),

	awful.key({ modkey, "Control" }, "n",
			  function ()
				  local c = awful.client.restore()
				  -- Focus restored client
				  if c then
					c:emit_signal(
						"request::activate", "key.unminimize", {raise = true}
					)
				  end
			  end,
			  {description = "restore minimized", group = "client"}),

	-- Prompt
	awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
			  {description = "run prompt", group = "launcher"}),

	--awful.key({ modkey, "Shift" }, "x",
	--		  function ()
	--			  awful.prompt.run {
	--				prompt       = "Run Lua code: ",
	--				textbox      = awful.screen.focused().mypromptbox.widget,
	--				exe_callback = awful.util.eval,
	--				history_path = awful.util.get_cache_dir() .. "/history_eval"
	--			  }
	--		  end,
	--		  {description = "lua execute prompt", group = "awesome"}),
	-- Menubar
	awful.key({ modkey, "Shift" }, "p", function() menubar.show() end,
			  {description = "show the menubar", group = "launcher"}),
	awful.key({ modkey}, "p", function() awful.spawn("rofi-pass") end,
			  {description = "show the menubar", group = "launcher"}),

	awful.key({ }, "XF86MonBrightnessDown", function ()
		awful.util.spawn("xbacklight -dec 5") end, {description="Decrease brightness", group="brightness"}),
	awful.key({ }, "XF86MonBrightnessUp", function ()
		awful.util.spawn("xbacklight -inc 5") end, {description="Increase brightness", group="brightness"})
)

clientkeys = gears.table.join(
	awful.key({ modkey, }, "F11",
		function (c)
			c.fullscreen = not c.fullscreen
			c:raise()
		end,
		{description = "toggle fullscreen", group = "client"}),

	awful.key({ modkey}, "x", function (c) c:kill() end, {description = "close", group = "client"}),

	awful.key({ modkey, "Shift" }, "space",  awful.client.floating.toggle, {description = "toggle floating", group = "client"}),

	awful.key({ modkey, "Shift" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
			  {description = "move to master", group = "client"}),

	awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
			  {description = "move to screen", group = "client"}),

	awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
			  {description = "toggle keep on top", group = "client"}),

	awful.key({ modkey,           }, "n",
		function (c)
			-- The client currently has the input focus, so it cannot be
			-- minimized, since minimized clients can't have the focus.
			c.minimized = true
		end ,
		{description = "minimize", group = "client"}),

	awful.key({ modkey, "Shift"          }, "s",
		function (c)
			c.sticky = not c.sticky
		end ,
		{description = "toggle sticky", group = "client"}),

	awful.key({ modkey,           }, "m",
		function (c)
			c.maximized = not c.maximized
			c:raise()
		end ,
		{description = "(un)maximize", group = "client"}),

	awful.key({ modkey, "Control" }, "m",
		function (c)
			c.maximized_vertical = not c.maximized_vertical
			c:raise()
		end ,
		{description = "(un)maximize vertically", group = "client"}),

	awful.key({ modkey, "Shift"   }, "m",
		function (c)
			c.maximized_horizontal = not c.maximized_horizontal
			c:raise()
		end ,
		{description = "(un)maximize horizontally", group = "client"}),


	awful.key({}, "XF86AudioRaiseVolume", function() volumecfg:up() end),
	awful.key({}, "XF86AudioLowerVolume", function() volumecfg:down() end),
	awful.key({}, "XF86AudioMute",        function() volumecfg:toggle() end),
	awful.key({}, "XF86AudioMicMute",        
		function() 
			awful.spawn("amixer set Capture toggle")
		end),

	awful.key({modkey, }, "t", toggle_sidebar,
		{description = "toggle visible sidebar", group = "layout"}),

	--awful.key({ modkey }, "b",
	--	function ()
	--	  myscreen = awful.screen.focused()
	--	  myscreen.mywibox.visible = not myscreen.mywibox.visible
	--	end,
	--	{description = "toggle statusbar"})
	awful.key({ modkey }, "b",
		function ()
			awful.spawn.with_shell("marcador rofi")
		end,
		{description = "launch bookmarks"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 0, 9 do
	globalkeys = gears.table.join(globalkeys,
		-- View tag only.
		awful.key({ modkey }, "#" .. i + 9,
				  function ()

						helpers.tag_back_and_forth(i)
						--local screen = awful.screen.focused()
						--local tag = screen.tags[i]
						--if tag then
						--   tag:view_only()
						--end
				  end,
				  {description = "view tag #"..i, group = "tag"}),
		-- Toggle tag display.
		awful.key({ modkey, "Control" }, "#" .. i + 9,
				  function ()
					  local screen = awful.screen.focused()
					  local tag = screen.tags[i]
					  if tag then
						 awful.tag.viewtoggle(tag)
					  end
				  end,
				  {description = "toggle tag #" .. i, group = "tag"}),
		-- Move client to tag.
		awful.key({ modkey, "Shift" }, "#" .. i + 9,
				  function ()
					  if client.focus then
						  local tag = client.focus.screen.tags[i]
						  if tag then
							  client.focus:move_to_tag(tag)
						  end
					 end
				  end,
				  {description = "move focused client to tag #"..i, group = "tag"}),
		-- Toggle tag on focused client.
		awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
				  function ()
					  if client.focus then
						  local tag = client.focus.screen.tags[i]
						  if tag then
							  client.focus:toggle_tag(tag)
						  end
					  end
				  end,
				  {description = "toggle focused client on tag #" .. i, group = "tag"})
	)
end



clientbuttons = gears.table.join(
	awful.button({ }, 1, function (c)
		c:emit_signal("request::activate", "mouse_click", {raise = true})
	end),
	awful.button({ modkey }, 1, function (c)
		c:emit_signal("request::activate", "mouse_click", {raise = true})
		awful.mouse.client.move(c)
	end),
	awful.button({ modkey }, 3, function (c)
		c:emit_signal("request::activate", "mouse_click", {raise = true})
		awful.mouse.client.resize(c)
	end)
)



-- Set keys
root.keys(globalkeys)



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

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock()

-- Create a wibox for each screen and add it
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

local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
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


function myupdate(w, buttons, label, data, objects)
    w:reset()
    local l = wibox.layout.fixed.horizontal()
    for i, o in ipairs(objects) do
        local cache = data[o]
        if cache then
            ib = cache.ib
        else
            ib = wibox.widget.imagebox()
            ib:buttons(common.create_buttons(buttons, o))

            data[o] = {
                ib = ib
            }
        end

        local text, bg, bg_image, icon = label(o)
        ib:set_image(icon)
    l:add(ib)
        --w:add(ib)
   end
   w:add(l)
end

--require("wibar")

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

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
		-- Notice that there is *NO* wibox.wibox prefix, it is a template,
		-- not a widget instance.
		widget_template = {
			{
				{
					{
						{
							id     = 'icon_role',
							widget = awful.widget.clienticon,
						},
						margins = 2,
						widget  = wibox.container.margin,
					},
					{
						id     = 'text_role',
						widget = wibox.widget.textbox,
					},
					layout = wibox.layout.fixed.horizontal,
				},
				left  = 10,
				right = 10,
				widget = wibox.container.margin
			},
			id     = 'background_role',
			widget = wibox.container.background,
		},
    }

	--s.mytasklist = awful.widget.tasklist {
	--	screen   = s,
	--	filter   = awful.widget.tasklist.filter.currenttags,
	--	buttons  = tasklist_buttons,
	--	layout   = {
	--		spacing_widget = {
	--			{
	--				forced_width  = 5,
	--				forced_height = 24,
	--				thickness     = 1,
	--				color         = '#777777',
	--				widget        = wibox.widget.separator
	--			},
	--			valign = 'center',
	--			halign = 'center',
	--			widget = wibox.container.place,
	--		},
	--		spacing = 1,
	--		layout  = wibox.layout.fixed.horizontal
	--	},
	--	-- Notice that there is *NO* wibox.wibox prefix, it is a template,
	--	-- not a widget instance.
	--	widget_template = {
	--		{
	--			wibox.widget.base.make_widget(),
	--			forced_height = 5,
	--			id            = 'background_role',
	--			widget        = wibox.container.background,
	--		},
	--		{
	--			{
	--				id     = 'clienticon',
	--				widget = awful.widget.clienticon,
	--			},
	--			margins = 5,
	--			widget  = wibox.container.margin
	--		},
	--		nil,
	--		create_callback = function(self, c, index, objects) --luacheck: no unused args
	--			self:get_children_by_id('clienticon')[1].client = c
	--		end,
	--		layout = wibox.layout.align.vertical,
	--	},
	--}

	local BAT = battery_widget{}
	local brightness = require("brightness")
	brightness_control = brightness({})

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
            mykeyboardlayout,
            wibox.layout.margin(wibox.widget.systray(),2,2,2,2),
            mytextclock,
			volumecfg.widget, 
			BAT,
			brightness_control.widget,
            s.mylayoutbox,
        },
    }
end)
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
                     keys = clientkeys,
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
            -- awful.titlebar.widget.iconwidget(c),
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
            --awful.titlebar.widget.floatingbutton (c),
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
-- }}}
--
awful.spawn.with_shell("~/.config/awesome/autorun.sh")

-- run lua code commands
prt = function(...) naughty.notify{text=table.concat({...}, '\t')} end
col = function(str) naughty.notify{text="   ", bg=str} end

local gears = require("gears")
local awful = require("awful")

local clientkeys = gears.table.join(
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
			volumecfg:mute()
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

return clientkeys

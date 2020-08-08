--[[

     Dremora Awesome WM theme 2.0
     github.com/lcpz

--]]

local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi   = require("beautiful.xresources").apply_dpi

local os = os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility


local gruvbox = {}
gruvbox.dark0_hard      = "#1d2021"
gruvbox.dark0           = "#282828"
gruvbox.dark0_soft      = "#32302f"
gruvbox.dark1           = "#3c3836"
gruvbox.dark2           = "#504945"
gruvbox.dark3           = "#665c54"
gruvbox.dark4           = "#7c6f64"
gruvbox.gray_245        = "#928374"
gruvbox.gray_244        = "#928374"
gruvbox.light0_hard     = "#f9f5d7"
gruvbox.light0          = "#fbf1c7"
gruvbox.light0_soft     = "#f2e5bc"
gruvbox.light1          = "#ebdbb2"
gruvbox.light2          = "#d5c4a1"
gruvbox.light3          = "#bdae93"
gruvbox.light4          = "#a89984"
gruvbox.bright_red      = "#fb4934"
gruvbox.bright_green    = "#b8bb26"
gruvbox.bright_yellow   = "#fabd2f"
gruvbox.bright_blue     = "#83a598"
gruvbox.bright_purple   = "#d3869b"
gruvbox.bright_aqua     = "#8ec07c"
gruvbox.bright_orange   = "#fe8019"
gruvbox.neutral_aqua    = "#689d6a"
gruvbox.neutral_blue    = "#458588"
gruvbox.neutral_green   = "#98971a"
gruvbox.neutral_orange  = "#d65d0e"
gruvbox.neutral_purple  = "#b16286"
gruvbox.neutral_red     = "#cc241d"
gruvbox.neutral_yellow  = "#d79921"
gruvbox.faded_aqua      = "#427b58"
gruvbox.faded_blue      = "#076678"
gruvbox.faded_green     = "#79740e"
gruvbox.faded_orange    = "#af3a03"
gruvbox.faded_purple    = "#8f3f71"
gruvbox.faded_red       = "#9d0006"
gruvbox.faded_yellow    = "#b57614"



local theme                                     = {}
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/themes/f_theme"
--theme.wallpaper                                 = theme.dir .. "/wall.png"
theme.font                                      = "Fira Mono 10"
theme.taglist_font                              = "Icons 10"
--theme.fg_normal                                 = "#747474"
theme.fg_normal                                 = gruvbox.light4
--theme.fg_focus                                  = "#DDDCFF"
theme.fg_focus                                  = gruvbox.ligth0
--theme.bg_normal                                 = "#121212"
theme.bg_normal                                 = gruvbox.dark1
--theme.bg_focus                                  = "#121212"
theme.bg_focus                                  = gruvbox.dark2
theme.fg_urgent                                 = gruvbox.light0
theme.bg_urgent                                 = gruvbox.dark0_hard
theme.border_width                              = dpi(3)
theme.border_normal                             = gruvbox.light4
theme.border_focus                              = gruvbox.bright_blue

theme.titlebar_bg_focus                         = gruvbox.dark1
theme.titlebar_fg_focus							= gruvbox.light0

theme.taglist_fg_focus                          = gruvbox.light4
theme.taglist_bg_focus                          = gruvbox.dark2
theme.menu_height                               = dpi(18)
theme.menu_width                                = dpi(200)
theme.menu_submenu_icon                         = theme.dir .. "/icons/submenu.png"
theme.awesome_icon                              = theme.dir .."/icons/awesome.svg"
theme.taglist_squares_sel                       = theme.dir .. "/icons/square_sel.png"
theme.taglist_squares_unsel                     = theme.dir .. "/icons/square_unsel.png"
theme.layout_tile                               = theme.dir .. "/icons/tile.png"
theme.layout_tileleft                           = theme.dir .. "/icons/tileleft.png"
theme.layout_tilebottom                         = theme.dir .. "/icons/tilebottom.png"
theme.layout_tiletop                            = theme.dir .. "/icons/tiletop.png"
theme.layout_fairv                              = theme.dir .. "/icons/fairv.png"
theme.layout_fairh                              = theme.dir .. "/icons/fairh.png"
theme.layout_spiral                             = theme.dir .. "/icons/spiral.png"
theme.layout_dwindle                            = theme.dir .. "/icons/dwindle.png"
theme.layout_max                                = theme.dir .. "/icons/max.png"
theme.layout_fullscreen                         = theme.dir .. "/icons/fullscreen.png"
theme.layout_magnifier                          = theme.dir .. "/icons/magnifier.png"
theme.layout_floating                           = theme.dir .. "/icons/floating.png"
theme.tasklist_plain_task_name                  = true
theme.tasklist_disable_icon                     = true
theme.useless_gap                               = dpi(3)

semaphore = "/icons/titlebar/semaphore"


theme.titlebar_floating_button_focus_active     = theme.dir .. semaphore .. "/bright_purple.svg"
theme.titlebar_floating_button_focus_active_hover     = theme.dir .. semaphore .. "/bright_purple.svg"
theme.titlebar_floating_button_focus_active_press     = theme.dir .. semaphore .. "/bright_purple.svg"
theme.titlebar_floating_button_normal_active		= theme.dir .. semaphore .. "/bright_purple.svg"
theme.titlebar_floating_button_focus_inactive   	= theme.dir .. semaphore .. "/faded_purple.svg"
theme.titlebar_floating_button_normal_inactive  	= theme.dir .. semaphore .. "/light4.svg"

theme.titlebar_sticky_button_focus_active       	= theme.dir .. semaphore .. "/neutral_blue.svg"
theme.titlebar_sticky_button_normal_active      	= theme.dir .. semaphore .. "/neutral_blue.svg"
theme.titlebar_sticky_button_focus_inactive     	= theme.dir .. semaphore .. "/faded_blue.svg"
theme.titlebar_sticky_button_normal_inactive    	= theme.dir .. semaphore .. "/light4.svg"

theme.titlebar_ontop_button_focus_active        	= theme.dir .. semaphore .. "/bright_aqua.svg"
theme.titlebar_ontop_button_normal_active       	= theme.dir .. semaphore .. "/bright_aqua.svg"
theme.titlebar_ontop_button_focus_inactive      	= theme.dir .. semaphore .. "/faded_aqua.svg"
theme.titlebar_ontop_button_normal_inactive     	= theme.dir .. semaphore .. "/light4.svg"

-- theme.titlebar_minimize_button_normal_hover     = theme.dir .. semaphore .. "/bright_green.svg"
-- theme.titlebar_minimize_button_normal_press     = theme.dir .. semaphore .. "/bright_green.svg"
theme.titlebar_minimize_button_focus            = theme.dir .. semaphore .. "/bright_green.svg"
theme.titlebar_minimize_button_normal           = theme.dir .. semaphore .. "/light4.svg"
-- theme.titlebar_minimize_button_focus_hover      = theme.dir .. semaphore .. "/bright_green.svg"
-- theme.titlebar_minimize_button_focus_press      = theme.dir .. semaphore .. "/bright_green.svg"

theme.titlebar_maximized_button_focus_active    = theme.dir .. semaphore .. "/bright_yellow.svg"
theme.titlebar_maximized_button_normal_active   = theme.dir .. semaphore .. "/bright_yellow.svg"
theme.titlebar_maximized_button_focus_inactive  = theme.dir .. semaphore .. "/faded_yellow.svg"
theme.titlebar_maximized_button_normal_inactive = theme.dir .. semaphore .. "/light4.svg"

theme.titlebar_close_button_focus               = theme.dir .. semaphore .. "/neutral_red.svg"
theme.titlebar_close_button_normal              = theme.dir .. semaphore .. "/light4.svg"
-- theme.titlebar_close_button_focus_hover               = theme.dir .. semaphore .. "/bright_red.svg"
-- theme.titlebar_close_button_focus_press               = theme.dir .. semaphore .. "/bright_red.svg"

awful.util.tagnames   = { "ƀ", "Ƅ", "Ɗ", "ƈ", "ƙ" }

local markup     = lain.util.markup
local separators = lain.util.separators
local white      = theme.fg_focus
local gray       = "#858585"

-- Textclock
local mytextclock = wibox.widget.textclock(markup(gray, " %a")
.. markup(white, " %d ") .. markup(gray, "%b ") ..  markup(white, "%H:%M "))
mytextclock.font = theme.font

-- Calendar
theme.cal = lain.widget.cal({
    attach_to = { mytextclock },
    notification_preset = {
        font = "Fira Mono 9",
        fg   = white,
        bg   = theme.bg_normal
}})

-- Mail IMAP check
--[[ commented because it needs to be set before use
theme.mail = lain.widget.imap({
    timeout  = 180,
    server   = "server",
    mail     = "mail",
    password = "keyring get mail",
    notification_preset = { fg = white }
    settings = function()
        mail  = ""
        count = ""

        if mailcount > 0 then
            mail = "Mail "
            count = mailcount .. " "
        end

        widget:set_markup(markup.font(theme.font, markup(gray, mail) .. markup(white, count)))
    end
})
--]]

-- MPD
theme.mpd = lain.widget.mpd({
    settings = function()
        mpd_notification_preset.fg = white
        artist = mpd_now.artist .. " "
        title  = mpd_now.title  .. " "

        if mpd_now.state == "pause" then
            artist = "mpd "
            title  = "paused "
        elseif mpd_now.state == "stop" then
            artist = ""
            title  = ""
        end

        widget:set_markup(markup.font(theme.font, markup(gray, artist) .. markup(white, title)))
    end
})

-- /home fs
--[[ commented because it needs Gio/Glib >= 2.54
theme.fs = lain.widget.fs({
    notification_preset = { fg = white, bg = theme.bg_normal, font = "Terminus 10.5" },
    settings  = function()
        fs_header = ""
        fs_p      = ""

        if fs_now["/home"].percentage >= 90 then
            fs_header = " Hdd "
            fs_p      = fs_now["/home"].percentage
        end

        widget:set_markup(markup.font(theme.font, markup(gray, fs_header) .. markup(white, fs_p)))
    end
})
--]]

-- Battery
local bat = lain.widget.bat({
    settings = function()
        bat_header = " Bat "
        bat_p      = bat_now.perc .. " "
        widget:set_markup(markup.font(theme.font, markup(gray, bat_header) .. markup(white, bat_p)))
    end
})

-- ALSA volume
theme.volume = lain.widget.alsa({
    --togglechannel = "IEC958,3",
    settings = function()
        header = " Vol "
        vlevel  = volume_now.level

        if volume_now.status == "off" then
            vlevel = vlevel .. "M "
        else
            vlevel = vlevel .. " "
        end

        widget:set_markup(markup.font(theme.font, markup(gray, header) .. markup(white, vlevel)))
    end
})

-- Weather
theme.weather = lain.widget.weather({
    city_id = 2643743, -- placeholder (London)
    notification_preset = { fg = white }
})

-- Separators
local first     = wibox.widget.textbox('<span font="Terminus 4"> </span>')
local arrl_pre  = separators.arrow_right("alpha", "#1A1A1A")
local arrl_post = separators.arrow_right("#1A1A1A", "alpha")

function theme.at_screen_connect(s)
    -- Quake application
    s.quake = lain.util.quake({ app = awful.util.terminal })

    -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)

    -- Tags
    awful.tag(awful.util.tagnames, s, awful.layout.layouts)

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(my_table.join(
                           awful.button({}, 1, function () awful.layout.inc( 1) end),
                           awful.button({}, 2, function () awful.layout.set( awful.layout.layouts[1] ) end),
                           awful.button({}, 3, function () awful.layout.inc(-1) end),
                           awful.button({}, 4, function () awful.layout.inc( 1) end),
                           awful.button({}, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = dpi(18), bg = theme.bg_normal, fg = theme.fg_normal })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            first,
            s.mytaglist,
            arrl_pre,
            s.mylayoutbox,
            arrl_post,
            s.mypromptbox,
            first,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.widget.systray(),
            first,
            theme.mpd.widget,
            --theme.mail.widget,
            --theme.fs.widget,
            bat.widget,
            theme.volume.widget,
            mytextclock,
        },
    }
end

return theme

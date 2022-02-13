# color scheme for i3 based on wall


set_from_resource $bg-color i3wm.color0
set_from_resource $text-color i3wm.color15
set_from_resource $urgent-bg-color i3wm.color2
set_from_resource $inactive-text-color i3wm.color7
set_from_resource $accent i3wm.color4

# vim:filetype=i3
# It will not be overwritten, so edit it as you like.
#
# Should you change your keyboard layout somewhen, delete
# this file and re-run i3-config-wizard(1).

# i3 config file (v4)
#
# Please see http://i3wm.org/docs/userguide.html for a complete reference!

# This file will be compiled with acompanying makefile

# The comment strings will be parsed

#Mod key: Mod1 = Alt, Mod4=Super
set $mod Mod4

# Font for window titles. Will also be used by the bar unless a different font
# is used in the bar {} block below. ISO 10646 = Unicode
font pango:Fira Mono 9
#font -misc-fixed-medium-r-normal--13-120-75-75-C-70-iso10646-1
# The font above is very space-efficient, that is, it looks good, sharp and
# clear in small sizes. However, if you need a lot of unicode glyphs or
# right-to-left text rendering, you should instead use pango for rendering and
# chose a FreeType font, such as:
# font pango:DejaVu Sans Mono 10

# Use Mouse+$mod to drag floating windows to their wanted position
floating_modifier $mod

# launch terminal
bindsym $mod+Return exec --no-startup-id wezterm
# launch a small terminal
bindsym $mod+Shift+Return exec uxterm -title launcher -geometry 150x20
# launch a terminal at the top of the window
#bindsym $mod+Control+Return exec xdotool type 'xterm -e "cd $(pwd) && /bin/zsh &"' && xdotool key Return

# kill focused window
bindsym $mod+x kill

# lock
bindsym $mod+Shift+x exec --no-startup-id notify-send locking && sleep 1 && ~/bin/lock -i ~/media/windows_resized.png

# lauch rofi
bindsym $mod+Shift+d exec rofi -modi run -show run 

# There also is the (new) i3-dmenu-desktop which only displays applications
# shipping a .desktop file. It is a wrapper around dmenu, so you need that
# installed.
# bindsym $mod+d exec --no-startup-id i3-dmenu-desktop

# change focus
# focus left
bindsym $mod+h focus left
# focus down
bindsym $mod+j focus down
# focus up
bindsym $mod+k focus up
# focus right
bindsym $mod+l focus right

# move focused window
# move left
bindsym $mod+Left  move left
# move down
bindsym $mod+Down  move down
# move up
bindsym $mod+Up    move up
# move right
bindsym $mod+Right move right

# move workspace to monitor
# move workspace to the left
bindsym $mod+Shift+Left move workspace to output left
# move workspace to the right
bindsym $mod+Shift+Right move workspace to output right
# move workspace up
bindsym $mod+Shift+Up move workspace to output up
# move workspace down
bindsym $mod+Shift+Down move workspace to output down

# split in horizontal orientation
bindsym $mod+c split h

# split in vertical orientation
bindsym $mod+v split v

# enter fullscreen mode for the focused container
bindsym $mod+F11 fullscreen

# change container layout (stacked, tabbed, toggle split)
# stack
bindsym $mod+s layout stacking
# tab
bindsym $mod+w layout tabbed
# toggle split
bindsym $mod+e layout toggle split
# toggle layouts
bindsym $mod+t layout toggle

# toggle tiling / floating
bindsym $mod+Shift+space floating toggle

# toggle sticking
bindsym $mod+Shift+s sticky toggle

bindsym $mod+Shift+m exec "i3-msg sticky toggle; i3-msg floating enable; i3-msg resize set width 500 px; i3-msg resize set height 300 px; i3-msg move position 850 px 450 px;"

# change borders
# no border
#bindsym $mod+u border none
# small border
#bindsym $mod+y border pixel 2
# normal border
bindsym $mod+n border normal

# toggle floating
bindsym $mod+space focus mode_toggle

# focus the parent container
bindsym $mod+a focus parent

# focus the child container
#bindsym $mod+d focus child

# cycle workspaces
bindsym $mod+Tab workspace next
# reverse cycle workspaces
bindsym $mod+Shift+Tab workspace prev

workspace_auto_back_and_forth yes

# toggke floating
bindsym $mod+button2 floating toggle

set $workspace1 "1"
set $workspace2 "2"
set $workspace3 "3"
set $workspace4 "4"
set $workspace5 "5"
set $workspace6 "6-vc"
set $workspace7 "7-show"
set $workspace8 "8-comms"
set $workspace9 "9-music"
set $workspace10 "0-web"



# switch to workspace
# switch to workspace 1
bindsym $mod+1 workspace $workspace1
# switch to workspace 2
bindsym $mod+2 workspace $workspace2
# switch to workspace 3
bindsym $mod+3 workspace $workspace3
# switch to workspace 4
bindsym $mod+4 workspace $workspace4
# switch to workspace 5
bindsym $mod+5 workspace $workspace5
# switch to workspace 6
bindsym $mod+6 workspace $workspace6
# switch to workspace 7
bindsym $mod+7 workspace $workspace7
# switch to workspace 8
bindsym $mod+8 workspace $workspace8
# switch to workspace 9
bindsym $mod+9 workspace $workspace9
# switch to workspace 10
bindsym $mod+0 workspace $workspace10

# move focused container to workspace
# move container to workspace 1
bindsym $mod+Shift+1 move container to workspace $workspace1
# move container to workspace 2
bindsym $mod+Shift+2 move container to workspace $workspace2
# move container to workspace 3
bindsym $mod+Shift+3 move container to workspace $workspace3
# move container to workspace 4
bindsym $mod+Shift+4 move container to workspace $workspace4
# move container to workspace 5
bindsym $mod+Shift+5 move container to workspace $workspace5
# move container to workspace 6
bindsym $mod+Shift+6 move container to workspace $workspace6
# move container to workspace 7
bindsym $mod+Shift+7 move container to workspace $workspace7
# move container to workspace 8
bindsym $mod+Shift+8 move container to workspace $workspace8
# move container to workspace 9
bindsym $mod+Shift+9 move container to workspace $workspace9
# move container to workspace 10
bindsym $mod+Shift+0 move container to workspace $workspace10

# reload configuration
bindsym $mod+Shift+c reload
# restart i3
bindsym $mod+Shift+r restart

# exit i3 (logs you out of your X session)
#bindsym $mod+Shift+e exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -b 'Yes, exit i3' 'i3-msg exit'"
# exit menu
bindsym $mod+Shift+e exec exit_menu

# resize window (you can also use the mouse for that)
mode "resize" {
        # These bindings trigger as soon as you enter the resize mode

        # shrink width
        bindsym h resize shrink width 2 px or 2 ppt
        # grow height
        bindsym j resize grow height 2 px or 2 ppt
        # shrink height
        bindsym k resize shrink height 2 px or 2 ppt
        # grow width
        bindsym l resize grow width 2 px or 2 ppt

        # shrink width
        bindsym Shift+h resize shrink width 40 px or 40 ppt
        # grow height
        bindsym Shift+j resize grow height 40 px or 40 ppt
        # shrink height
        bindsym Shift+k resize shrink height 40 px or 40 ppt
        # grow width
        bindsym Shift+l resize grow width 40 px or 40 ppt

        # back to normal: Enter or Escape
	# exit resize
        bindsym Return mode "default"
	# exit resize
        bindsym Escape mode "default"
}

# enter mode resize
bindsym $mod+r mode "resize"

# launch thunar
bindsym $mod+f exec uxterm -e "ranger"
bindsym $mod+Shift+f exec thunar

# take screenshot
bindsym Print exec scrot -e 'mv $f ~/media/screenshots/ && notify-send "screenshot saved in ~/media/screenshots/$f"'
# take screenshot of current window
bindsym Control+Print exec scrot -u -e 'mv $f ~/media/screenshots && notify-send "window saved in ~/media /screenshots/$f"'

#bindsym XF86AudioMicMute exec "amixer set Capture toggle ; killall -s USR1 py3status"
#bindsym XF86AudioLowerVolume exec "pamixer --decrease 5; killall -s USR1 py3status"
#bindsym XF86AudioMute exec "pamixer --toggle-mute ; killall -s USR1 py3status"
#bindsym XF86AudioRaiseVolume exec pamixer --increase 5
# toggle audio
bindsym XF86AudioMute exec "ponymix toggle && pkill -RTMIN+10 i3blocks"
# toggle mic
bindsym XF86AudioMicMute exec "amixer set Capture toggle; pkill -RTMIN+10 i3blocks"
# lower volume
bindsym XF86AudioLowerVolume exec "ponymix decrease 5; pkill -RTMIN+10 i3blocks"
# raise volume
bindsym XF86AudioRaiseVolume exec "ponymix increase 5; pkill -RTMIN+10 i3blocks"

# Screen brightness controls
# raise brightness
bindsym XF86MonBrightnessUp exec xbacklight -inc 5
# lower brightness
bindsym XF86MonBrightnessDown exec xbacklight -dec 5

# suspend
bindsym $mod+Ctrl+x exec systemctl suspend && i3lock -i ~/media/ubuntu_unity.png
# hibernate
bindsym $mod+Ctrl+Shift+x exec systemctl hibernate && i3lock -i ~/media/ubuntu_unity.png

# Touchpad controls
#bindsym XF86TouchpadToggle exec /some/path/toggletouchpad.sh # toggle touchpad

# Media player controls
# play/pause
bindsym $mod+Ctrl+p exec playerctl play-pause
bindsym $mod+Ctrl+n exec playerctl next
# next song
bindsym XF86AudioNext exec playerctl next
# previous song
bindsym XF86AudioPrev exec playerctl previous
# mpc play/pause
bindsym $mod+XF86AudioPlay exec "mpc toggle; killall -s USR1 py3status"
# mpc next song
bindsym $mod+XF86AudioNext exec "mpc next; killall -s USR1 py3status"
# mpc previous song
bindsym $mod+XF86AudioPrev exec "mpc prev; killall -s USR1 py3status"

# lauch rofi-bookmarks
bindsym $mod+b exec marcador rofi ~/Documents/books

# lauch hotkeys
bindsym $mod+i exec /home/joaj/bin/hotkeys

# move to scratchpad
#bindsym $mod+Shift+minus move scratchpad
# show scratchpad
#bindsym $mod+minus scratchpad show

# workspace assignments
assign [class="^Chromium$"]     $workspace10
assign [class="Brave-browser$"]        $workspace10
assign [class="^Firefox$"]      $workspace10
assign [class="qutebrowser"]    $workspace10
assign [class="Audacious"]      $workspace9
assign [class="Transmission"]   $workspace7
assign [class="MPlayer"]        $workspace7
assign [class="mpv"]            $workspace7
assign [class="^Thunderbird$"]  $workspace8
assign [class="^Discord"]  $workspace8
assign [class="Rambox"]         $workspace8
assign [class="^Rviz$"]			$workspace7

for_window [title="FST CAN Interface"]		move to workspace $workspace2

# window settings
for_window [class="^Spotify$"]  move to workspace $workspace9
for_window [class="Qalculate"]  floating enable
for_window [class="^Shutter$"]  floating enable
for_window [class="^Pidgin$"]   floating enable
for_window [class="^feh$"] 	floating enable
for_window [class="^.*"]        border pixel 3
for_window [class="^albert$"]   border pixel 0
for_window [class="^MATLAB$"]	move to workspace $workscape7
# launcher
for_window [title="launcher"]   floating enable
for_window [title="launcher"]   border pixel 2
for_window [title="hotkeys"]   	floating enable
for_window [title="Open File"] 	resize set 720 680
for_window [title="Open File"] 	move position center
for_window [title="pinentry"] 	floating enable
for_window [title="Slack$"]		move to workspace $workspace8

#gaps
#smart_gaps on
#smart_borders on
#gaps inner 10

#autostart
exec --no-startup-id nm-applet
#exec_always --no-startup-id conky
#exec --no-startup-id redshift-gtk
exec --no-startup-id /home/joaj/bin/battery.py > /dev/null 2>&1
#exec --no-startup-id compton -f
#exec --no-startup-id powertop --auto-tune
exec_always --no-startup-id xss-lock -- i3lock
exec --no-startup-id dunst
exec --no-startup-id thunderbird
exec --no-startup-id discord
#exec --no-startup-id ~/sources/inkscape-shortcut-manager
exec --no-startup-id ~/bin/wallpapers
exec --no-startup-id spotify
exec --no-startup-id brave --app="https://app.slack.com/client/T0102UM1UKA/C0102V8D8HW"
exec --no-startup-id brave --app="https://app.slack.com/client/T5KTEHKRV/CH88GF1DY"
exec --no-startup-id brave --app="https://web.whatsapp.com/"
exec --no-startup-id brave
exec --no-startup-id blueman-applet
exec --no-startup-id /home/joaj/bin/class-calendar
#exec_always --no-startup-id flashfocus
#exec_always --no-startup-id ~/bin/polybar.sh &

#no commands mode
mode "no-command" {
    # leave no-command
    bindsym $mod+q mode "default"
}
# enter no-command
bindsym $mod+q mode "no-command"


# window colors
#                       border              background         text      indicator
client.focused          $accent           $accent          $text-color  $accent
client.unfocused        $bg-color         $bg-color         $text-color  $bg-color
client.focused_inactive $bg-color         $accent         $text-color  $bg-color
client.urgent           $urgent-bg-color  $urgent-bg-color  $text-color  $urgent-bg-color

# launch rofi-pass
bindsym $mod+p exec rofi-pass
# launch rofi
bindsym $mod+d exec rofi -modi drun -show drun 
# launch clipmenu
bindsym $mod+g exec clipmenu
# launch qmenu_hud
bindsym $mod+o exec fullscreen disable; floating enable; resize set 422 240; sticky enable; move position 870 25
# launch window switcher
bindsym $mod+y exec rofi -combi-modi window -show combi -modi combi 
# expo
bindsym $mod+z exec --no-startup-id flash_window

bindsym $mod+u exec uxterm -e "cd vimwiki && vim +Wiki"

bindsym $mod+Shift+y exec xdotool click 4
bindsym $mod+Shift+u exec xdotool click 5

bindsym $mod+m exec gst-launch-1.0 v4l2src device=/dev/video0 ! xvimagesink

# Start i3bar to display a workspace bar (plus the system information i3status
# finds out, if available)
bar {
    	#status_command py3status --config ~/.config/py3status/config --include ~/.config/py3status/bin/
	#status_command py3status
	#status_command i3status
	#mode invisible
	#status_command i3status-rs /home/joaj/build/i3status-rust/example_config.toml
	#status_command i3status
	status_command i3blocks
    position top
	font pango: Awesome 9
    separator_symbol "•"
    #height 25
    colors {
		statusline $text-color
        background $bg-color
        separator $accent

        #                  border             background         text
        focused_workspace  $accent            $accent            $text-color
        inactive_workspace $bg-color          $bg-color          $inactive-text-color
        urgent_workspace   $urgent-bg-color   $urgent-bg-color   $text-color
    }
}
# vim:filetype=i3

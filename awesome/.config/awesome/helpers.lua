local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local awful = require("awful")

local helpers = {}


-- Tag back and forth:
-- If you try to focus the tag you are already at, go back to the previous tag.
-- Useful for quick switching after for example checking an incoming chat
-- message at tag 2 and coming back to your work at tag 1 with the same
-- keypress.
function helpers.tag_back_and_forth(tag_index)
    local s = mouse.screen
    local tag = s.tags[tag_index]
    if tag then
        if tag == s.selected_tag then
            awful.tag.history.restore()
        else
            tag:view_only()
        end
    end
end


function helpers.vertical_pad(height)
    return wibox.widget{
        forced_height = height,
        layout = wibox.layout.fixed.vertical
    }
end

function helpers.volume_control(step)
    local cmd
    if step == 0 then
        cmd = "pactl set-sink-mute @DEFAULT_SINK@ toggle"
    else
        sign = step > 0 and "+" or ""
        cmd = "pactl set-sink-mute @DEFAULT_SINK@ 0 && pactl set-sink-volume @DEFAULT_SINK@ "..sign..tostring(step).."%"
    end
    awful.spawn.with_shell(cmd)
end

helpers.prrect = function(radius, tl, tr, br, bl)
    return function(cr, width, height)
        gears.shape.partially_rounded_rect(cr, width, height, tl, tr, br, bl, radius)
    end
end

helpers.colorize_text = function(text, color)
    return "<span foreground='"..color.."'>"..text.."</span>"
end

-- Useful for periodically checking the output of a command that
-- requires internet access.
-- Ensures that `command` will be run EXACTLY once during the desired
-- `interval`, even if awesome restarts multiple times during this time.
-- Saves output in `output_file` and checks its last modification
-- time to determine whether to run the command again or not.
-- Passes the output of `command` to `callback` function.
function helpers.remote_watch(command, interval, output_file, callback)
    local run_the_thing = function()
        -- Pass output to callback AND write it to file
        awful.spawn.easy_async_with_shell(command.." | tee "..output_file, function(out) callback(out) end)
    end

    local timer
    timer = gears.timer {
        timeout = interval,
        call_now = true,
        autostart = true,
        single_shot = false,
        callback = function()
            awful.spawn.easy_async_with_shell("date -r "..output_file.." +%s", function(last_update, _, __, exitcode)
                -- Probably the file does not exist yet (first time
                -- running after reboot)
                if exitcode == 1 then
                    run_the_thing()
                    return
                end

                local diff = os.time() - tonumber(last_update)
                if diff >= interval then
                    run_the_thing()
                else
                    -- Pass the date saved in the file since it is fresh enough
                    awful.spawn.easy_async_with_shell("cat "..output_file, function(out) callback(out) end)

                    -- Schedule an update for when the remaining time to complete the interval passes
                    timer:stop()
                    gears.timer.start_new(interval - diff, function()
                        run_the_thing()
                        timer:again()
                    end)
                end
            end)
        end
    }
end

return helpers




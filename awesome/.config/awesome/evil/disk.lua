-- Provides:
-- evil::disk
--      used (integer - giga bytes)
--      total (integer - giga bytes)
local awful = require("awful")

local update_interval = 180 -- every 3 minutes

-- Use /dev/sdxY according to your setup
local disk_script = [[
    bash -c "
    df -kh / | tail -1 | awk '{printf \"%f\", $4, $3}'
    "
]]

-- Periodically get disk space info
awful.widget.watch(disk_script, update_interval, function(_, stdout)
    -- Get `available` and `used` instead of `used` and `total`,
    -- since the total size reported by the `df` command includes
    -- the 5% storage reserved for `root`, which is misleading.
    local available = stdout:match('^(.*)$')
    awesome.emit_signal("evil::disk", tonumber(available))
end)

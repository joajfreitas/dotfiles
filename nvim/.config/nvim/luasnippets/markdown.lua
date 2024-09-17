local function snippet_datetime(d) return os.date("%Y-%m-%dT%H:%M:%SZ", d) end

local function snippet_date(d) return os.date("%Y-%m-%d", d) end

local function end_of_day(t)
    d = os.date("*t", t)
    d.hour = 23
    d.min = 59
    d.sec = 59
    t = os.time(d)
    return snippet_datetime(t)
end

local function run(command)
    local handle = io.popen(
                       'brian task id /home/joaj/sources/wiki/journal/2024.md')
    local output = handle:read('*a')
    local result = output:gsub('[\n\r]', '')
    handle:close()
    return tostring(result)
end

return {
    s("date", {f(function() return snippet_date(os.time()) end)}),
    s("t0", {f(function() return snippet_datetime(os.time()) end)}), s("t1", {
        f(function()
            return snippet_datetime(os.time() + 1 * 24 * 60 * 60)
        end)
    }), s("t2", {
        f(function()
            return snippet_datetime(os.time() + 2 * 24 * 60 * 60)
        end)
    }), s("t3", {
        f(function()
            return snippet_datetime(os.time() + 3 * 24 * 60 * 60)
        end)
    }), s("t4", {
        f(function()
            return snippet_datetime(os.time() + 4 * 24 * 60 * 60)
        end)
    }), s("t5", {
        f(function()
            return snippet_datetime(os.time() + 5 * 24 * 60 * 60)
        end)
    }), s("t6", {
        f(function()
            return snippet_datetime(os.time() + 6 * 24 * 60 * 60)
        end)
    }), s("t7", {
        f(function()
            return snippet_datetime(os.time() + 7 * 24 * 60 * 60)
        end)
    }), s("t15", {
        f(function()
            return snippet_datetime(os.time() + 15 * 24 * 60 * 60)
        end)
    }), s("t30", {
        f(function()
            return snippet_datetime(os.time() + 30 * 24 * 60 * 60)
        end)
    }), s("t60", {
        f(function()
            return snippet_datetime(os.time() + 60 * 24 * 60 * 60)
        end)
    }), s("te0", {f(function() return end_of_day(os.time()) end)}),
    s("te1", {f(function() return end_of_day(os.time() + 1 * 24 * 60 * 60) end)}),
    s("te2", {f(function() return end_of_day(os.time() + 2 * 24 * 60 * 60) end)}),
    s("te3", {f(function() return end_of_day(os.time() + 3 * 24 * 60 * 60) end)}),
    s("te4", {f(function() return end_of_day(os.time() + 4 * 24 * 60 * 60) end)}),
    s("te5", {f(function() return end_of_day(os.time() + 5 * 24 * 60 * 60) end)}),
    s("te6", {f(function() return end_of_day(os.time() + 6 * 24 * 60 * 60) end)}),
    s("te7", {f(function() return end_of_day(os.time() + 7 * 24 * 60 * 60) end)}),
    s("te15",
      {f(function() return end_of_day(os.time() + 15 * 24 * 60 * 60) end)}),
    s("te30",
      {f(function() return end_of_day(os.time() + 30 * 24 * 60 * 60) end)}),
    s("te60",
      {f(function() return end_of_day(os.time() + 60 * 24 * 60 * 60) end)}),
    s("task-add", {
        t("(task-add "), f(function()
            return run(
                       "brian task task-id /home/joaj/sources/wiki/journal/2024.md")
        end), t(" d#"), f(function() return snippet_datetime(os.time()) end),
        t(" \""), i(1), t("\" :due d#"), i(2), t(")")
    }), s("task-done", {
        t("(task-done "), i(1), t(" d#"),
        f(function() return snippet_datetime(os.time()) end), t(")")
    }), s("task-drop", {
        t("(task-done "), i(1), t(" d#"),
        f(function() return snippet_datetime(os.time()) end), t(")")
    }), s("time-start", {
        t("(time-start "), t(" d#"),
        f(function() return snippet_datetime(os.time()) end), t(" )")
    }), s("time-stop", {
        t("(time-stop "), t(" d#"),
        f(function() return snippet_datetime(os.time()) end), t(" )")
    })
}

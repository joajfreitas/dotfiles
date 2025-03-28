local M = {}

local sunset = function(month)
    local sunset = {18, 18, 19, 20, 21, 22, 22, 21, 20, 19, 18, 18}
    return sunset[month]
end

local sunrise = function(month)
    local sunrise = {8, 8, 7, 6, 7, 6, 6, 7, 7, 8, 7, 8}
    return sunrise[month]
end

M.setup = function()
    vim.opt.termguicolors = true
    vim.cmd.colorscheme("gruvbox")
    local time = os.date("*t")

    if time.hour <= sunrise(time.month) or time.hour >= sunset(time.month) then
        vim.o.background = "ligth"
    else
        vim.o.background = "light"
    end
end

return M

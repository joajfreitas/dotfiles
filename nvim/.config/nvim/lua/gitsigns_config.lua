local M = {}

M.setup = function()
    require('gitsigns').setup {
        word_diff = false,
        current_line_blame = true,
        current_line_blame_opts = {
            delay = 200,
        },
        on_attach = function(bufnr)
            local gitsigns = require 'gitsigns'

            local function map(mode, l, r, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, l, r, opts)
            end
            -- Text object
            map({ 'o', 'x' }, 'ih', gitsigns.select_hunk)
        end,
    }
end

return M

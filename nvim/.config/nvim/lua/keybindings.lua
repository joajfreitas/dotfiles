local M = {}

M.setup = function()
    local telescope_builtin = require("telescope.builtin")
    local wk = require("which-key")
    wk.register({
        f = { telescope_builtin.find_files, "Find file" },
        g = { telescope_builtin.git_files, "Find git files" },
        t = {
            name = "telescope",
            g = { telescope_builtin.live_grep, "Live grep" },
            b = { telescope_builtin.buffers, "Buffers" },
            p = { telescope_builtin.builtin, "Builtin pickers" },
            h = { telescope_builtin.help_tags, "Help tags" },
        },
        e = { "<cmd>Neotree toggle<cr>", "File explorer" },
        s = { "<cmd>ClangdSwitchSourceHeader<cr>", "Switch between source and header" },
        D = { vim.lsp.buf.type_definition, "Lsp type definition" },
        a = { vim.lsp.buf.code_action, "Lsp code action" },
        r = { vim.lsp.buf.rename, "Lsp rename" },
        z = {
            name = "zen",
            n = { "<cmd>TZNarrow<cr>", "Narrow" },
            f = { "<cmd>TZFocus<cr>", "Focus" },
            m = { "<cmd>TZMinimalist<cr>", "Minimalist" },
            a = { "<cmd>TZAtaraxis<cr>", "Ataraxis" },
            l = { "<cmd>Limelight<cr>", "Limelight" },
        },
    }, { prefix = "<leader>" })

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { silent = true })
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { silent = true })
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { silent = true })
    vim.keymap.set("n", "go", vim.lsp.buf.type_definition, { silent = true })
    vim.keymap.set("n", "gr", vim.lsp.buf.references, { silent = true })
    vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, { silent = true })
    vim.keymap.set("n", "gl", vim.diagnostic.open_float, { silent = true })
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { silent = true })
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { silent = true })
end

return M

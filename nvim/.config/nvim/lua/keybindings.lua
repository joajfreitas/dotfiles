local M = {}

M.setup = function()
    local telescope_builtin = require("telescope.builtin")
    local wk = require("which-key")
    wk.add({
        {"<leader>f", telescope_builtin.find_files, desc="Find file"},
        {"<leader>g", telescope_builtin.git_files, desc="Find git files"},
        {"<leader>s", telescope_builtin.live_grep, desc="Live keyword search"},
        {"<leader>t", group = "telescope"},
        {"<leader>tb", telescope_builtin.buffers, desc="Buffers"},
        {"<leader>tp", telescope_builtin.builtin, desc="Builtin pickers"},
        {"<leader>th", telescope_builtin.help_tags, desc="Help tags"},
        {"<leader>e", "<cmd>NvimTreeToggle<cr>", desc="File explorer"},
        {"<leader>o", "<cmd>ClangdSwitchSourceHeader<cr>", desc="Switch between source and header"},
        {"<leader>D", vim.lsp.buf.type_definition, desc="Lsp type definition"},
        {"<leader>a", vim.lsp.buf.code_action, desc="Lsp code action"},
        {"<leader>r", vim.lsp.buf.rename, desc="Lsp rename"},
        {"<leader>z", group = "zen"},
        {"<leader>zn", "<cmd>TZNarrow<cr>", desc="Narrow"},
        {"<leader>zf", "<cmd>TZFocus<cr>", desc="Focus"},
        {"<leader>zm", "<cmd>TZMinimalist<cr>", desc="Minimalist"},
        {"<leader>za", "<cmd>TZAtaraxis<cr>", desc="Ataraxis"},
        {"<leader>zl", "<cmd>Limelight<cr>", desc="Limelight"},
        {
          '<leader>lk',
          function()
            local acronym = vim.fn.input {
              prompt = 'Acronym: ',
            }
            local result = require('acronym-viewer').lookup(acronym)
            if result == nil then
              vim.notify('Could not find a definition for ' .. acronym .. '.', vim.log.levels.ERROR)
            else
              vim.notify(result, vim.log.levels.INFO)
            end
          end,
        },
    })

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, {silent = true})
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {silent = true})
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {silent = true})
    vim.keymap.set("n", "go", vim.lsp.buf.type_definition, {silent = true})
    vim.keymap.set("n", "gr", vim.lsp.buf.references, {silent = true})
    vim.keymap.set("n", "gre", require('telescope.builtin').lsp_references, {silent=true})
    vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, {silent = true})
    vim.keymap.set("n", "gl", vim.diagnostic.open_float, {silent = true})
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, {silent = true})
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, {silent = true})



end

return M

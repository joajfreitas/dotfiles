local M = {}

M.setup = function()
    cmp = require 'cmp'
    lvim = require 'lvim'

    cmp.setup {
        mapping = cmp.mapping.preset.insert {
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm { select = true },
        },
        snippet = {
            expand = function(args)
                require('luasnip').lsp_expand(args.body)
            end,
        },
        sources = {
            { name = 'copilot' },
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
            { name = 'path' },
            { name = 'emoji' },
            { name = 'buffer' },
            { name = 'cmp_tabnine' },
            { name = 'ledger' },
        },
        formatting = {
            format = function(entry, vim_item)
                local max_width = 0 --lvim.builtin.cmp.formatting.max_width
                if max_width ~= 0 and #vim_item.abbr > max_width then
                    vim_item.abbr = string.sub(vim_item.abbr, 1, max_width - 1) .. lvim.icons.ui.Ellipsis
                end
                if lvim.use_icons then
                    vim_item.kind = lvim.icons.kind[vim_item.kind] --lvim.builtin.cmp.formatting.kind_icons[vim_item.kind]

                    if entry.source.name == 'copilot' then
                        vim_item.kind = lvim.icons.git.Octoface
                        vim_item.kind_hl_group = 'CmpItemKindCopilot'
                    end

                    if entry.source.name == 'cmp_tabnine' then
                        vim_item.kind = lvim.icons.misc.Robot
                        vim_item.kind_hl_group = 'CmpItemKindTabnine'
                    end

                    if entry.source.name == 'crates' then
                        vim_item.kind = lvim.icons.misc.Package
                        vim_item.kind_hl_group = 'CmpItemKindCrate'
                    end

                    if entry.source.name == 'lab.quick_data' then
                        vim_item.kind = lvim.icons.misc.CircuitBoard
                        vim_item.kind_hl_group = 'CmpItemKindConstant'
                    end

                    if entry.source.name == 'emoji' then
                        vim_item.kind = lvim.icons.misc.Smiley
                        vim_item.kind_hl_group = 'CmpItemKindEmoji'
                    end
                end
                vim_item.menu = lvim.formatting.source_names[entry.source.name]
                vim_item.dup = lvim.formatting.duplicates[entry.source.name] or lvim.formatting.duplicated_default

                return vim_item
            end,
        },
    }
end

return M

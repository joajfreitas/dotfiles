local builtin = require 'telescope.builtin'
local actions = require 'telescope.actions'
local act_layout = require 'telescope.actions.layout'
local act_state = require 'telescope.actions.state'
local util = require 'util'

local function yank_absolute_path(register)
  local entry = act_state.get_selected_entry()

  vim.fn.setreg(register or '', entry.path)
  vim.notify('Copied ' .. entry.path, vim.log.levels.INFO)
end

local function yank_relative_path(register)
  local entry = act_state.get_selected_entry()
  local relative_path = util.string_remove_prefix(entry.path, vim.fn.getcwd(0) .. '/')

  vim.fn.setreg(register or '', relative_path)
  vim.notify('Copied ' .. relative_path, vim.log.levels.INFO)
end

local fullscreen_setup_common = {
  prompt_position = 'top',
  width = function(_, cols, _)
    return math.min(math.floor(cols * 0.95), 200)
  end,
  height = function(_, _, rows)
    return math.floor(rows * 0.95)
  end,
  preview_cutoff = 10
}

local standard_setup = {
  preview = { hide_on_startup = true },
  layout_strategy = 'vertical',
  layout_config = {
    vertical = {
      mirror = true,
      prompt_position = 'top',
      width = function(_, cols, _)
        return math.min(math.floor(cols * 0.9), 120)
      end,
      height = function(_, _, rows)
        return math.floor(rows * 0.8)
      end,
      preview_cutoff = 10,
      preview_height = 0.4,
    },
  },
}

local fullscreen_setup = {
  preview = { hide_on_startup = false },
  layout_strategy = 'flex',
  layout_config = {
    flex = { flip_columns = 100 },
    horizontal = vim.tbl_extend('error', fullscreen_setup_common, { mirror = false, preview_width = 0.5 }),
    vertical = vim.tbl_extend('error', fullscreen_setup_common, { mirror = true, preview_height = 0.5 }),
  },
}

local lsp_common = {
  preview = { hide_on_startup = false },
  show_line = false,
}

local M = {}

M.fullscreen_spec = function()
  return fullscreen_setup
end

M.setup = function()
  require('telescope').setup {
    defaults = vim.tbl_extend('error', standard_setup, {
      winblend = 10,
      wrap_results = true,
      sorting_strategy = 'ascending',
      path_display = { 'filename_first' },
      mappings = {
        n = {
          ['o'] = act_layout.toggle_preview,
        },
        i = {
          ['<C-o>'] = act_layout.toggle_preview,
        },
      },
    }),
    pickers = {
      live_grep = fullscreen_setup,
      grep_string = fullscreen_setup,
      diagnostics = fullscreen_setup,

      lsp_implementations = lsp_common,
      lsp_definitions = lsp_common,
      lsp_references = vim.tbl_extend('error', lsp_common, {
        path_display = function(_, path)
          local relpath = util.string_remove_prefix(path, vim.fn.getcwd(0) .. '/')
          local tail = require('telescope.utils').path_tail(relpath)
          local highlights = {
            { { 0, #relpath - #tail }, #relpath == #path and 'Comment' or 'Conditional' },
            { { #relpath - #tail, #relpath }, #relpath == #path and 'Comment' or '@comment.note' },
          }
          return relpath, highlights
        end,
      }),

      find_files = {
        hidden = true,
        no_ignore = false,
        file_ignore_patterns = {
          '.git/.*',
        },
        mappings = {
          n = {
            ['ya'] = function()
              yank_absolute_path()
            end,
            ['yy'] = function()
              yank_relative_path()
            end,
            ['<Leader>ya'] = function()
              yank_absolute_path '+'
            end,
            ['<Leader>yy'] = function()
              yank_relative_path '+'
            end,
          },
          i = {
            ['<C-y>a'] = function()
              yank_absolute_path()
            end,
            ['<C-y>y'] = function()
              yank_absolute_path()
            end,
          },
        },
      },
      buffers = {
        sort_lastused = true,
        sort_mru = true,
        mappings = {
          i = {
            ['<c-d>'] = actions.delete_buffer,
            ['<C-y>a'] = function()
              yank_absolute_path()
            end,
            ['<C-y>y'] = function()
              yank_absolute_path()
            end,
          },
          n = {
            ['dd'] = actions.delete_buffer,
            ['ya'] = function()
              yank_absolute_path()
            end,
            ['yy'] = function()
              yank_relative_path()
            end,
            ['<Leader>ya'] = function()
              yank_absolute_path '+'
            end,
            ['<Leader>yy'] = function()
              yank_relative_path '+'
            end,
          },
        },
      },
    },
  }
end

M.keymaps = function()
  vim.keymap.set('n', '<leader>sa', function()
    builtin.find_files {
      hidden = true,
      no_ignore = true,
      prompt_title = 'Find Files including hidden & ignored',
    }
  end, { desc = '[S]earch [A]ll Files (hidden & ignored)' })

  vim.keymap.set('v', '<leader>s', builtin.grep_string, { desc = '[S]earch selection' })
  vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = 'List open buffers' })
end

M.autocmds = function()
  vim.api.nvim_create_autocmd('User', {
    pattern = 'TelescopePreviewerLoaded',
    callback = function()
      vim.wo.wrap = true
    end,
  })
end

return M

local M = {}

M.setup = function()
    local dap = require 'dap'
    dap.adapters.gdb = {
        type = 'executable',
        command = 'gdb',
        args = { '--interpreter=dap', '--eval-command', 'set print pretty on' },
    }

    dap.adapters.codelldb = {
        type = 'server',
        port = '${port}',
        executable = {
            command = '/home/joaj/.local/share/nvim/mason/bin/codelldb', -- I installed codelldb through mason.nvim
            args = { '--port', '${port}' },
        },
    }

    dap.configurations.c = {
        {
            name = 'Attach to gdbserver :1234',
            type = 'gdb',
            request = 'attach',
            target = 'localhost:1234',
            program = function()
                return vim.fn.input(
                    'Path to executable: ',
                    '/home/joaj/bmw/orion2/bazel-bin/test/planning/motion_planning/behavior/lane_change/lane_segment_sequence_test'
                )
            end,
            cwd = '${workspaceFolder}',
        },
    }

    dap.configurations.cpp = dap.configurations.c
    dap.configurations.rust = dap.configurations.c

    dap.configurations.lua = {
        {
            type = 'nlua',
            request = 'attach',
            name = 'Attach to running Neovim instance',
        },
    }

    dap.adapters.nlua = function(callback, config)
        callback { type = 'server', host = config.host or '127.0.0.1', port = config.port or 8086 }
    end
end

return M

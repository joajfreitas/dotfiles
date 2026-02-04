local M = {}

function code_companion_setup()
	  require('codecompanion').setup({
      adapters = {
        http = {
          copilot_enterprise = function()
            local adapter = require 'codecompanion.adapters.http.copilot_enterprise'
            adapter.opts.provider_url = "bmw.ghe.com" -- 'https://' can be removed but doesn't hurt.
            return adapter
          end,
        },
      },
      strategies = {
        chat = {
          -- Setup the custom adapter for each strategy. You can change default models as usual.
          -- See https://codecompanion.olimorris.dev/configuration/adapters.html#changing-the-default-adapter
          -- and https://codecompanion.olimorris.dev/configuration/adapters.html#changing-a-model
          adapter = {
            name = "copilot_enterprise",
            model = "claude-sonnet-4",
          },
        },
        inline = {
          adapter = "copilot_enterprise",
        },
        cmd = {
          adapter = "copilot_enterprise",
        },
      },
	  })
end

function copilot_setup()
  vim.g.copilot_enterprise_uri = 'https://bmw.ghe.com'
end

M.setup = function()
	vim.g.copilot_enterprise_uri = 'https://bmw.ghe.com'

	_G.__cc_copilot_enterprise_url = nil

	  do
	    local http = require("codecompanion.http")

	    -- keep original function CC captured
	    local orig_post = http.static.methods.post.default

	    http.static.methods.post.default = function(opts)
	      if opts
		and opts.url == "https://api.githubcopilot.com/chat/completions"
		and _G.__cc_copilot_enterprise_url
	      then
		opts = vim.tbl_deep_extend("force", opts, {
		  url = _G.__cc_copilot_enterprise_url,
		})
	      end
	      return orig_post(opts)
	    end
	  end

	  code_companion_setup()
    copilot_setup()
end

return M

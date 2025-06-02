local M = {}

M.setup = function()
	vim.opt.termguicolors = true
	vim.cmd.colorscheme("gruvbox")
	vim.opt.colorcolumn = "80"
	vim.api.nvim_set_hl(0, "Beacon", { bg = "white" })
end

return M

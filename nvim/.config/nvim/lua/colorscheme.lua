local M = {}

M.setup = function()
	vim.opt.termguicolors = true
	vim.cmd.colorscheme("gruvbox")
	vim.opt.colorcolumn = "80"
end

return M

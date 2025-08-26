local M = {}

M.setup = function()
	if vim.g.neovide then

		vim.g.neovide_opacity = 0.92
		vim.g.neovide_normal_opacity = 0.92
		vim.o.guifont = "Fira Code:h10"
		vim.g.neovide_cursor_animation_length = 0.01
		vim.g.neovide_scroll_animation_length = 0.01
        vim.g.neovide_position_animation_length = 0.01
		vim.g.neovide_theme = "auto"
		vim.g.neovide_hide_mouse_when_typing = false
	end
end

return M

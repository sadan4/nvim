require("hover").setup({
	init = function()
		require("hover.providers.diagnostic")
		require("hover.providers.lsp")
	end,
	preview_opts = {
		border = "rounded",
	},
	preview_window = false,
	title = true,
	mouse_providers = {
		"Diagnostics",
		"LSP",
	},
	mouse_delay = 0,
})
local h = require("hover")
vim.keymap.set("n", "K", h.hover)
vim.keymap.set("n", "gK", h.hover_select)
vim.keymap.set("n", "<RightMouse>", h.hover_mouse, {
	noremap = true,
})
vim.o.mousemoveevent = true

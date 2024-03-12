local tb = require("telescope.builtin")
-- find Files
vim.keymap.set("n", "<C-f>f", tb.find_files, {})
-- find Text
vim.keymap.set("n", "<C-f>t", tb.live_grep, {})
-- find Buffers
vim.keymap.set("n", "<C-f>b", tb.buffers, {})
-- find keyMaps
vim.keymap.set("n", "<C-f>m", tb.keymaps, {})
-- find Command
vim.keymap.set("n", "<C-f>c", tb.commands, {})
-- find Documentation
vim.keymap.set("n", "<C-f>d", tb.man_pages, {})
-- open tree
vim.keymap.set({ "i", "n" }, "<C-t>", vim.cmd.NvimTreeFocus, {})
-- move and copy lines
vim.keymap.set({ "i", "n" }, "<A-Up>", function()
	vim.api.nvim_feedkeys("ddkP", "x", false)
end, {})
vim.keymap.set({ "i", "n" }, "<A-Down>", function()
	vim.api.nvim_feedkeys("ddp", "x", false)
end, {})
vim.keymap.set({ "i", "n" }, "<A-S-Up>", function()
	vim.api.nvim_feedkeys("yyP", "x", false)
end, {})
vim.keymap.set({ "i", "n" }, "<A-S-Down>", function()
	vim.api.nvim_feedkeys("yyp", "x", false)
end, {})
-- on <C-Space> in normal, insert and start autoComp
vim.keymap.set("n", "<C-Space>", function()
	vim.api.nvim_feedkeys("i", "m", false)
	local key1 = vim.api.nvim_replace_termcodes("<C-Space>", true, false, true)
	vim.api.nvim_feedkeys(key1, "m", false)
end, {})
-- toggle function signature
vim.keymap.set("i", "<C-S-Space>", function()
	require("lsp_signature").toggle_float_win()
end, {})
-- format and vplit remaps
vim.keymap.set({ "n", "i" }, "<A-F>", vim.cmd.Format, {})
vim.keymap.set({ "i", "n" }, "<C-\\>", vim.cmd.vsplit, {})
-- vscode fold and unfold
vim.keymap.set("n", "<C-[>", "zc", {})
vim.keymap.set("n", "<C-]>", "zo", {})

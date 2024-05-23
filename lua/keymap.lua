local tb = require("telescope.builtin")

vim.g.mapleader = " "
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
-- clangd switch source/header
vim.keymap.set({ "n" }, "<leader>o", vim.cmd.ClangdSwitchSourceHeader, { silent = true })
-- goto mappings
vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
vim.keymap.set("n", "<C-.>", vim.lsp.buf.code_action, {})
-- copy and paste
vim.keymap.set("v", "<A-c>", '"+y', {})
vim.keymap.set("n", "<A-c>", '"+yy', {})
vim.keymap.set("v", "<A-v>", '"+p', {})
vim.keymap.set("n", "<A-v>", '"+p', {})
-- lsp rename
vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, {})
vim.keymap.set({ "n", "v" }, ";", ":")

vim.keymap.set("n", "<leader>/", ":call eregex#toggle()<CR>", {
	noremap = true,
})
vim.keymap.set("n", "<leader>w", ":SudaWrite<CR>", {
	noremap = true,
})
vim.keymap.set("n", "<leader>h", ":%S/", {
	noremap = true,
})
vim.keymap.set({ "n", "v" }, "<leader>se", require("nvim-emmet").wrap_with_abbreviation)
-- open command line with the path of current buffer already inserted
vim.keymap.set("n", "<leader>e", function()
    -- print((":e " .. string.gsub(vim.fn.expand("%"), '(.*/)(.*)', '%1')));
	vim.api.nvim_feedkeys((":e " .. string.gsub(vim.fn.expand("%"), "(.*/)(.*)", "%1")), "L", false)
end)

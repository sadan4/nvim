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
-- find symbols 
vim.keymap.set("n", "<C-f>v", tb.lsp_workspace_symbols, {})
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
vim.keymap.set("v", "<leader>h", ":S/", {
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
vim.keymap.set("n", "<leader>c", ":let @+=@\"<CR>")
-- training
vim.keymap.set("n", "<Left>", ':echoe "Use h"<CR>')
vim.keymap.set("n", "<Right>", ':echoe "Use l"<CR>')
vim.keymap.set("n", "<Up>", ':echoe "Use k"<CR>')
vim.keymap.set("n", "<Down>", ':echoe "Use j"<CR>')

vim.keymap.set("i", "<Left>", '<ESC>:echoe "Use h"<CR>i')
vim.keymap.set("i", "<Right>", '<ESC>:echoe "Use l"<CR>i')
vim.keymap.set("i", "<Up>", '<ESC>:echoe "Use k"<CR>i')
vim.keymap.set("i", "<Down>", '<ESC>:echoe "Use j"<CR>i')
-- https://stackoverflow.com/questions/1841480/how-to-use-lowercase-marks-as-global-in-vim
-- Use lowercase for global marks and uppercase for local marks.
local low = function(i) return string.char(97+i) end
local upp = function(i) return string.char(65+i) end

for i=0,25 do vim.keymap.set("n", "m"..low(i), "m"..upp(i)) end
for i=0,25 do vim.keymap.set("n", "m"..upp(i), "m"..low(i)) end
for i=0,25 do vim.keymap.set("n", "'"..low(i), "'"..upp(i)) end
for i=0,25 do vim.keymap.set("n", "'"..upp(i), "'"..low(i)) end

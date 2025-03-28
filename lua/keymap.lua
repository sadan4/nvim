local tb = require("telescope.builtin")

vim.g.mapleader = " "

vim.keymap.set("n", "<C-b>", "<Nop>");
vim.keymap.set("n", "<C-f>", "<Nop>");
vim.keymap.set("n", "<A-Left>", "<C-o>");
vim.keymap.set("n", "<A-Right>", "<C-i>");
-- <S-k> is mapped to hover
-- unmap <S-j>
vim.keymap.set({"v", "n"}, "J", "<Nop>")
-- use <S-h> for home and <S-l> for end
vim.keymap.set({"n", "v", "o"}, "H", "g^")
vim.keymap.set({"n", "v", "o"}, "L", "g_")
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
vim.keymap.set({ "n" }, "<C-t>", vim.cmd.NvimTreeFocus, {})
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
vim.keymap.set("v", "<A-S-Up>", function ()
    vim.api.nvim_feedkeys("yP", "x", false)
end)
vim.keymap.set("v", "<A-S-Down>", function ()
    vim.api.nvim_feedkeys("yp", "x", false)
end)
-- toggle function signature
-- Moved to noice
-- format and vplit remaps
vim.keymap.set({ "n", "i" }, "<A-F>", vim.cmd.Format, {})
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
-- open command line with the path of current buffer already inserted
vim.keymap.set("n", "<leader>r", function()
	-- print((":r " .. string.gsub(vim.fn.expand("%"), '(.*/)(.*)', '%1')));
	vim.api.nvim_feedkeys((":r " .. string.gsub(vim.fn.expand("%"), "(.*/)(.*)", "%1")), "L", false)
end)
vim.keymap.set("n", "<leader>c", ':let @+=@"<CR>')
-- training
vim.keymap.set("n", "<Left>", ':echoe "Use h"<CR>')
vim.keymap.set("n", "<Right>", ':echoe "Use l"<CR>')
vim.keymap.set("n", "<Up>", ':echoe "Use k"<CR>')
vim.keymap.set("n", "<Down>", ':echoe "Use j"<CR>')

vim.keymap.set({"i", "v", "n"}, "<C-c>", '<CMD>echoe "Use caps"<CR>')

vim.keymap.set("i", "<Left>", '<ESC>:echoe "Use h"<CR>i')
vim.keymap.set("i", "<Right>", '<ESC>:echoe "Use l"<CR>i')
vim.keymap.set("i", "<Up>", '<ESC>:echoe "Use k"<CR>i')
vim.keymap.set("i", "<Down>", '<ESC>:echoe "Use j"<CR>i')
vim.keymap.set({"n", "v", "i"}, "<MiddleMouse>", "<RightMouse>", {
    noremap = true
})

vim.cmd.aunmenu([[PopUp.How-to\ disable\ mouse]])
vim.cmd.aunmenu([[PopUp.Paste]])
vim.cmd.aunmenu([[PopUp.Select\ All]])
vim.cmd.aunmenu([[PopUp.Inspect]])
-- make #, closer to the cursor, fw search and * bw
vim.keymap.set("n", "#", "*", {
    noremap = true
})
vim.keymap.set("n", "*", "#", {
    noremap = true
})

-- moving bewteen splits
vim.keymap.set("n", "<M-C-S-L>", "<C-w>l");
vim.keymap.set("n", "<M-C-S-K>", "<C-w>k");
vim.keymap.set("n", "<M-C-S-J>", "<C-w>j");
vim.keymap.set("n", "<M-C-S-H>", "<C-w>h");
-- close
vim.keymap.set("n", "<M-C-S-C>", "<C-w>c");
-- quit
vim.keymap.set("n", "<M-C-S-Q>", "<C-w>q")
-- resizing
-- 3 lower width, 4 increace width
vim.keymap.set("n", "<M-C-S-3>", "<C-w><");
vim.keymap.set("n", "<M-C-S-4>", "<C-w>>");
-- e lower height, r increase height
vim.keymap.set("n", "<M-C-S-E>", "<C-w>>");
vim.keymap.set("n", "<M-C-S-R>", "<C-w>>");

-- movement:
-- o move left, p move right
vim.keymap.set("n", "<M-C-S-P>", "<C-w>L");
vim.keymap.set("n", "<M-C-S-O>", "<C-w>H");

-- 9 move down, 0 move up
vim.keymap.set("n", "<M-C-S-0>", "<C-w>K");
vim.keymap.set("n", "<M-C-S-9>", "<C-w>J");
-- ./init.lua
vim.keymap.set({ "i", "n" }, "<M-C-S-\\>", vim.cmd.vsplit, {})
vim.keymap.set({ "i", "n" }, "<M-C-S-5>", vim.cmd.split, {})
-- go to file under cursor
vim.keymap.set({"n"}, "<M-C-S-F>", "<C-w>F");
-- only
-- makes more sense to use O for moving splits
vim.keymap.set({ "n" }, "<M-C-S-U>", vim.cmd.only, {})
-- open Definition in split view
vim.keymap.set({ "n" }, "<M-C-S-D>", "<C-w>}", {})

-- vim.api.nvim_create_autocmd("BufAdd", {
-- 	callback = function(e)
--         vim.keymap.set({"n", "i", "v"}, "<MiddleMouse>", "<NOP>", {
--             buffer = e.buf
--         })
-- 	end,
-- })
-- vim.api.nvim_create_autocmd("User", {
--     pattern = "BufferLineHoverOver",
-- 	callback = function(e)
--         print("over")
--         vim.keymap.del({"n", "i", "v"}, "<MiddleMouse>", {
--             buffer = e.buf
--         })
-- 	end,
-- })
-- vim.api.nvim_create_autocmd("User", {
--     pattern = "BufferLineHoverOut",
-- 	callback = function(e)
--         print("out")
--         vim.keymap.set({"n", "i", "v"}, "<MiddleMouse>", "<NOP>", {
--             buffer = e.buf
--         })
-- 	end,
-- })
-- -- https://stackoverflow.com/questions/1841480/how-to-use-lowercase-marks-as-global-in-vim
-- -- Use lowercase for global marks and uppercase for local marks.
-- local low = function(i) return string.char(97+i) end
-- local upp = function(i) return string.char(65+i) end
--
-- for i=0,25 do vim.keymap.set("n", "m"..low(i), "m"..upp(i)) end
-- for i=0,25 do vim.keymap.set("n", "m"..upp(i), "m"..low(i)) end
-- for i=0,25 do vim.keymap.set("n", "'"..low(i), "'"..upp(i)) end
-- for i=0,25 do vim.keymap.set("n", "'"..upp(i), "'"..low(i)) end

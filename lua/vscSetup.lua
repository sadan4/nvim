vim.keymap.set("n", ";", ":")
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.smarttab = true
vim.opt.shiftround = true
vim.opt.shiftwidth = 4
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.scrolloff = 6
-- eregex.vim
vim.g.eregex_default_enable = 1
--KEYMAP
vim.g.mapleader = " "
local vsc = require("vscode")
vim.keymap.set("n", "<C-t>", function()
	vsc.action("workbench.action.toggleSidebarVisibility")
end)

vim.keymap.set("n", "<leader>`", function()
	vsc.action("workbench.action.terminal.toggleTerminal")
end)
vim.keymap.set("v", "<leader>se", function()
	vsc.action("editor.emmet.action.wrapWithAbbreviation")
end)
vim.keymap.set("n", "<leader>lg", function()
	vsc.action("lazygit.openLazygit")
end)
vim.keymap.set({ "n", "i", "v" }, "<C-c>", '<CMD>echoe "Use Caps"<CR>')
-- for some reason, this plugin does not work with keymaps that start with <C-f>
-- they are done through vsc
--
-- vim.keymap.set("n", "<C-f>v", function()
-- 	vsc.action("workbench.action.showAllSymbols")
-- end)
-- vim.keymap.set("n", "<C-f>f", function ()
--     vsc.action("workbench.action.quickOpen")
-- end)
-- vim.keymap.set("n", "<C-f>t", function ()
--     vsc.action("workbench.action.quickTextSearch")
-- end)
vim.keymap.set("n", "<leader>e", function()
	-- print((":e " .. string.gsub(vim.fn.expand("%"), '(.*/)(.*)', '%1')));
	vim.api.nvim_feedkeys((":e " .. string.gsub(vim.fn.expand("%"), "(.*/)(.*)", "%1")), "L", false)
end)
vim.keymap.set("n", "<leader>c", ':let @+=@"<CR>')
vim.keymap.set("n", "<C-k>z", function()
	vsc.action("workbench.action.toggleZenMode")
end)
vim.keymap.set("v", "<leader>h", ":S/", {
	noremap = true,
})
vim.keymap.set("n", "<leader>h", ":%S/", {
	noremap = true,
})
-- unmap <S-j>
vim.keymap.set({ "v", "n" }, "J", "<Nop>")
-- use <S-h> for home and <S-l> for end
vim.keymap.set({ "n", "v", "o" }, "H", "g^")
vim.keymap.set({ "n", "v", "o" }, "L", "g_")
-- make #, closer to the cursor, fw search and * bw
vim.keymap.set("n", "#", "*", {
	noremap = true,
})
vim.keymap.set("n", "*", "#", {
	noremap = true,
})
local function stupid(mode, lhs, rhs, args)
	vim.keymap.set(mode, lhs, function()
		vsc.action("vscode-neovim.send", {
			args = {
				rhs,
			},
		})
	end, args)
end
-- moving bewteen splits
vim.cmd("nmap <M-C-S-L> <C-w>l")
vim.cmd("nmap <M-C-S-K> <C-w>k")
vim.cmd("nmap <M-C-S-J> <C-w>j")
vim.cmd("nmap <M-C-S-H> <C-w>h")
-- close
vim.cmd("nmap <M-C-S-C> <C-w>c")
-- quit
vim.cmd("nmap <M-C-S-Q> <C-w>q")
-- resizing
-- 3 lower width, 4 increace width
vim.cmd("nmap <M-C-S-3> <C-w><")
vim.cmd("nmap <M-C-S-4> <C-w>>")
-- e lower height, r increase height
vim.cmd("nmap <M-C-S-E> <C-w>>")
vim.cmd("nmap <M-C-S-R> <C-w>>")

-- movement:
-- o move left, p move right
vim.cmd("nmap <M-C-S-P> <C-w>L")
vim.cmd("nmap <M-C-S-O> <C-w>H")

-- 9 move down, 0 move up
vim.cmd("nmap <M-C-S-0> <C-w>K")
vim.cmd("nmap <M-C-S-9> <C-w>J")
-- ./init.lua
vim.cmd("nmap <M-C-S-\\> <C-w>v")
vim.cmd("nmap <M-C-S-5> <C-w>s")
vim.cmd("imap <M-C-S-\\> <C-w>v")
vim.cmd("imap <M-C-S-5> <C-w>s")
-- go to file under cursor
vim.cmd("nmap <M-C-S-F> <C-w>F")
-- only
-- makes more sense to use O for moving splits
vim.cmd("nmap <M-C-S-U> <C-w><C-o>")
-- open Definition in split view
vim.cmd("nmap <M-C-S-D> <C-w>}")
-- move over folds
vim.cmd("nmap j gj")
vim.cmd("nmap k gk")

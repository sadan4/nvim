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
vim.keymap.set("v", "<leader>se", function ()
    vsc.action("editor.emmet.action.wrapWithAbbreviation")
end)
vim.keymap.set("n", "<leader>lg", function ()
    vsc.action("lazygit.openLazygit")
end)
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
vim.keymap.set("n", "<leader>c", ":let @+=@\"<CR>")
vim.keymap.set("n", "<C-k>z", function ()
    vsc.action("workbench.action.toggleZenMode")
end)
vim.keymap.set("v", "<leader>h", ":S/", {
	noremap = true,
})
vim.keymap.set("n", "<leader>h", ":%S/", {
	noremap = true,
})

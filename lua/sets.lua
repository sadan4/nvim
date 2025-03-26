vim.opt.rnu = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.smarttab = true
vim.opt.shiftround = true
vim.opt.shiftwidth = 4
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.scrolloff = 6
vim.opt.sloc = "statusline"
-- eregex.vim
vim.g.eregex_default_enable = 1

vim.api.nvim_create_autocmd({ "BufEnter" }, {

	callback = function()
        if package ~= nil and package.loaded ~= nil and package.loaded.presence ~= nil then
            package.loaded.presence:update()
        end
	end,
})

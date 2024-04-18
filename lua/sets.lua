vim.opt.rnu = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.smarttab = true
vim.opt.shiftround = true
vim.opt.shiftwidth = 4
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.scrolloff = 6

vim.api.nvim_create_autocmd({ "BufEnter" }, {

	callback = function()
		package.loaded.presence:update()
	end,
})

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

local function myOnAttach(bufnr)
    local api = require("nvim-tree.api")
    
    local function opts(desc)
      return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end
    -- defaults
    api.config.mappings.default_on_attach(bufnr)
    vim.keymap.set("n", "<C-t>", api.tree.close, opts("close tree with ctrl+t"))
end
-- OR setup with some options
require("nvim-tree").setup({
    on_attach = myOnAttach,
})

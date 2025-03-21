vim.g.mapleader = " "
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
if vim.g.vscode then
    require"vscodePlugins"
else
require"sets"
require"plugins"
require"setup"
require"keymap"
end
_G.dbg = function (obj)
    vim.notify(vim.inspect(obj))
end

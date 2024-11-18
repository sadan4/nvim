require("themesetup")
vim.cmd([[colorscheme tokyonight]])
require("setupnotify")
require("setupnoice")

require("mason").setup()
require("mason-lspconfig").setup()

require("masonDownload")

require("setuplsp")

require("setupformat")

require("setuptree")
require("setuptreesitter")
-- Has to be setup after treesitter
require("setuptabout")

require("setupufo")

require("setupcomment")
-- setup function signature
require("setupsig")

require("setuplualine")

require("setupDiscord")
require('telescope').load_extension('fzf')
require('telescope').load_extension("noice")
require("setupbufferline")
require("setupterminal")
require("setuphover")
require("colorizer").setup()

require("setupnotify")
require("setupnoice")

require("setuplsp")

require("setupformat")

-- Has to be setup after treesitter
require("setuptabout")

require("setupcomment")
-- setup function signature
require("setupsig")

require("setupDiscord")
require('telescope').load_extension("noice")
require("setuphover")

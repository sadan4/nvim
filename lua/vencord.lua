local lspConfig = require("lspconfig")
local configs = require("lspconfig.configs")

if not configs.vencord then
	configs.vencord = {
		default_config = {
			cmd = { "/home/meyer/dev/ts/vencord-ls/dist/index.js" },
			filetypes = { "typescript", "typescriptreact" },
			root_dir = function(fname)
				return lspConfig.util.find_git_ancestor(fname)
			end,
			settings = {},
		},
	}
end

lspConfig.vencord.setup{}

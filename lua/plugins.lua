local plugins = {
	{
		"marcussimonsen/let-it-snow.nvim",
		cmd = "LetItSnow", -- Wait with loading until command is run
		opts = {},
	},
	{
		"norcalli/nvim-colorizer.lua",
	},
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		init = function()
			vim.g.lazydev_enabled = true
		end,
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	{ "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
	-- { -- optional blink completion source for require statements and module annotations
	-- 	"saghen/blink.cmp",
	-- 	opts = {
	-- 		sources = {
	-- 			-- add lazydev to your completion providers
	-- 			completion = {
	-- 				enabled_providers = { "lsp", "path", "snippets", "buffer", "lazydev" },
	-- 			},
	-- 			providers = {
	-- 				-- dont show LuaLS require statements when lazydev has items
	-- 				lsp = { fallback_for = { "lazydev" } },
	-- 				lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
	-- 			},
	-- 		},
	-- 	},
	-- },
	{
		"echasnovski/mini.bufremove",
		version = "*",
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		-- opts = {
		-- 	-- add any options here
		-- },
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
	},
	{
		"lewis6991/hover.nvim",
	},
	{
		"christoomey/vim-titlecase",
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				keymaps = {
					visual = "<leader>s",
					visual_line = "<leader>s",
				},
			})
		end,
	},
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
	},
	{
		"akinsho/toggleterm.nvim",
	},
	{
		dir = "/home/meyer/dev/lua/vencord.nvim",
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
	},

	{
		"kdheepak/lazygit.nvim",
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		-- setting the keybinding for LazyGit with 'keys' is recommended in
		-- order to load the plugin when the command is run for the first time
		keys = {
			{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		},
	},
	{
		"mfussenegger/nvim-jdtls",
	},
	{
		"olrtg/nvim-emmet",
	},
	{
		"lambdalisue/suda.vim",
	},
	{
		"sadan4/eregex.vim",
	},
	{
		"windwp/nvim-ts-autotag",
	},
	{
		"barrett-ruth/live-server.nvim",
		build = "pnpm add -g live-server",
		cmd = { "LiveServerStart", "LiveServerStop" },
		config = true,
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"andweeb/presence.nvim",
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
	},
	-- {
	-- 	"MunifTanjim/eslint.nvim",
	-- },
	{
		"williamboman/mason.nvim",
	},
	{
		"ray-x/lsp_signature.nvim",
	},
	{
		"williamboman/mason-lspconfig.nvim",
	},
	{
		"neovim/nvim-lspconfig",
	},

	{
		"p00f/clangd_extensions.nvim",
	},
	{
		"abecodes/tabout.nvim",
		lazy = false,
		requires = {
			"nvim-treesitter/nvim-treesitter",
			"L3MON4D3/LuaSnip",
			"hrsh7th/nvim-cmp",
		},
		event = "InsertCharPre", -- Set the event to 'InsertCharPre' for better compatibility
		priority = 1000,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},
	{
		"numToStr/Comment.nvim",
		opts = {
			-- add any options here
		},
		lazy = false,
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		-- use opts = {} for passing setup options
		-- this is equalent to setup({}) function
		opts = {},
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
	{
		"mhartington/formatter.nvim",
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		opts = {
			extensions = {
				fzf = {
					fuzzy = true, -- false will only do exact matching
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = "ignore_case", -- or "ignore_case" or "respect_case" or smart_case
					-- the default case_mode is "smart_case"
				},
			},
		},
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"hrsh7th/cmp-nvim-lsp",
	},
	{
		"hrsh7th/nvim-cmp",
	},
	{
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		build = "make install_jsregexp",
	},
	{
		"saadparwaiz1/cmp_luasnip",
	},
	{
		"nvim-tree/nvim-tree.lua",
	},
	{
		"kevinhwang91/nvim-ufo",
		dependencies = {
			"kevinhwang91/promise-async",
			{
				"luukvbaal/statuscol.nvim",
				config = function()
					local builtin = require("statuscol.builtin")
					require("statuscol").setup({
						relculright = true,
						segments = {
							{ text = { builtin.foldfunc }, click = "v:lua.ScFa" },
							{ text = { "%s" }, click = "v:lua.ScSa" },
							{ text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
						},
					})
				end,
			},
		},
	},
	--{
	--	'mfussenegger/nvim-lint'
	--},
}
local opts = {}
require("lazy").setup(plugins, opts)

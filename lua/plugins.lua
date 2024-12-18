local plugins = {

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
		"sadan4/eregex.vim",
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
		"mhartington/formatter.nvim",
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
	--{
	--	'mfussenegger/nvim-lint'
	--},
}
local opts = {}
require("lazy").setup(plugins, opts)

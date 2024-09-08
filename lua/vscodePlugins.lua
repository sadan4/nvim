local plugins = {
    {
        "christoomey/vim-titlecase"
    },
	{
		vscode = true,
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
		vscode = true,
		"lambdalisue/suda.vim",
	},
	{
		"sadan4/eregex.vim",
	},
	{
		vscode = true,
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
}

require("lazy").setup(plugins, {})
require("vscSetup")

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
require("neodev").setup({
  -- add any options here, or leave empty to use the default settings
})
local capabilities = require("cmp_nvim_lsp").default_capabilities()

capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}

require("lspconfig").yamlls.setup({
	capabilities = capabilities,
	settings = {
		yaml = {
			schemas = {
				["/home/meyer/.config/nvim/clangdschema.json"] = "/.clangd",
			},
		},
	},
})
require("lspconfig").clangd.setup({
	capabilities = capabilities,
	cmd = {
		"clangd",
		"--header-insertion=iwyu",
	},
})
require("lspconfig").prismals.setup({
	capabilities = capabilities,
})
require("lspconfig").asm_lsp.setup({
	capabilities = capabilities,
})
require("lspconfig").pyright.setup({
	capabilities = capabilities,
})
require("lspconfig").tsserver.setup({
	capabilities = capabilities,
})
--
require("lspconfig").kotlin_language_server.setup({
	capabilities = capabilities,
})
--Java
require("lspconfig").java_language_server.setup({
	capabilities = capabilities,
})
--Lua
require("lspconfig").lua_ls.setup({
	capabilities = capabilities,
	on_init = function(client)
		local path = client.workspace_folders[1].name
		if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
			return
		end

		client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
			runtime = {
				-- Tell the language server which version of Lua you're using
				-- (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			-- Make the server aware of Neovim runtime files
			workspace = {
				checkThirdParty = false,
				-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
				library = vim.api.nvim_get_runtime_file("", true)
			},
		})
	end,
	settings = {
		Lua = {
			completion = {
				callSnippet = "Replace",
			},
		},
	},
})

local luasnip = require("luasnip")
local pairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")
cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		--    ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
		--  ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
		-- C-b (back) C-f (forward) for snippet placeholder navigation.
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "hrsh7th/cmp-nvim-lsp-signature-help" },
	},
})
cmp.event:on("confirm_done", pairs.on_confirm_done())
require("setupclangdext")

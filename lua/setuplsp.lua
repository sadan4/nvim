-- https://github.com/neovim/nvim-lspconfig/blob/master/dloc/server_configurations.md
require("neodev").setup({
	-- add any options here, or leave empty to use the default settings
})
local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}

-- jdtls
local function setupJDTLS()
	local mason_registry = require("mason-registry")
	local jdtls = require("jdtls")

	-- Early termination if jdtls is not installed
	if not mason_registry.is_installed("jdtls") then
		print("jdtls is not installed via Mason.")
		return
	end
	local function find_launcher_jar(jdtls_path)
		local plugins_path = jdtls_path .. "/plugins"
		local find_command = "find '"
			.. plugins_path
			.. "' -type f -name 'org.eclipse.equinox.launcher_*.jar' -print -quit"

		local handle = io.popen(find_command)

		if handle == nil then
			return
		end

		local result = handle:read("*l") -- Read only the first line of output
		handle:close()

		return result -- directly return the path
	end
	local jdtls_path = mason_registry.get_package("jdtls"):get_install_path()
	local path_to_launcher = find_launcher_jar(jdtls_path)
	local path_to_lsp_server = jdtls_path .. "/config_linux"
	local lombok_path = jdtls_path .. "/lombok.jar"

	--   local bundles = {
	--   vim.fn.glob(vim.fn.expand '~/.config/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-0.52.0.jar', true),
	-- }
	-- -- vim.list_extend(bundles, vim.split(vim.fn.glob(vim.fn.stdpath 'config' .. '/resources/vscode-java-test-main/server/*.jar', true), '\n'))
	local function makeandgetpath()
		local root = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" })
		if root == nil then
			return nil
		end
		local path = root .. "./data"
		os.execute("mkdir -p " .. path)
		return path
	end
	local config = {
		cmd = {
			os.getenv("JAVA_HOME") .. "/bin/java",
			"-Declipse.application=org.eclipse.jdt.ls.core.id1",
			"-Dosgi.bundles.defaultStartLevel=4",
			"-Declipse.product=org.eclipse.jdt.ls.core.product",
			"-Dlog.protocol=true",
			"-Dlog.level=ALL",
			-- '-javaagent:' .. lombok_path, -- Why?
			"-Xmx1g",
			"--add-modules=ALL-SYSTEM",
			"--add-opens",
			"java.base/java.util=ALL-UNNAMED",
			"--add-opens",
			"java.base/java.lang=ALL-UNNAMED",
			"-jar",
			path_to_launcher,
			"-configuration",
			path_to_lsp_server,
			"-data",
			makeandgetpath(),
		},

		root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),

		-- Further configuration
		settings = {
			java = {},
		},

		flags = {
			allow_incremental_sync = true,
		},

		init_options = {
			-- bundles = bundles,
			bundles = {},
		},
	}
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "java",
		callback = function()
			jdtls.start_or_attach(config)
			-- require("jdtls").setup_dap()
			vim.keymap.set({ "n", "i" }, "<A-F>", function()
				require("jdtls").organize_imports()
				vim.lsp.buf.format()
			end, {})
		end,
	})
end
setupJDTLS()
-- ENDjdtls
require("lspconfig").emmet_language_server.setup({
	capabilities = capabilities,
})
require("lspconfig").cssls.setup({
	capabilities = capabilities,
})
require("lspconfig").nginx_language_server.setup({
	capabilities = capabilities,
})
require("lspconfig").bashls.setup({
	capabilities = capabilities,
})
require("lspconfig").html.setup({
	capabilities = capabilities,
})
require("lspconfig").nil_ls.setup({
	capabilities = capabilities,
})
require("lspconfig").jsonls.setup({
	capabilities = capabilities,
})
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
				library = vim.api.nvim_get_runtime_file("", true),
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

require("null-ls").setup()

require("eslint").setup({
	bin = "eslint_d", -- or `eslint`
	code_actions = {
		enable = true,
		apply_on_save = {
			enable = true,
			types = { "directive", "problem", "suggestion", "layout" },
		},
		disable_rule_comment = {
			enable = true,
			location = "separate_line", -- or `same_line`
		},
	},
	diagnostics = {
		enable = true,
		report_unused_disable_directives = false,
		run_on = "type", -- or `save`
	},
})

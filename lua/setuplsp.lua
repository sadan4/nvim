-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}
local root_file = {
	".eslintrc",
	".eslintrc.js",
	".eslintrc.cjs",
	".eslintrc.yaml",
	".eslintrc.yml",
	".eslintrc.json",
	"eslint.config.js",
	"eslint.config.mjs",
	"eslint.config.cjs",
	"eslint.config.ts",
	"eslint.config.mts",
	"eslint.config.cts",
}
require("lspconfig").gopls.setup({})
require("lspconfig").lemminx.setup({})
require("lspconfig").vimls.setup({
	cmd = { "vim-language-server", "--stdio" },
	filetypes = { "vim" },
	init_options = {
		diagnostic = {
			enable = true,
		},
		indexes = {
			count = 3,
			gap = 100,
			projectRootPatterns = { "runtime", "nvim", ".git", "autoload", "plugin" },
			runtimepath = true,
		},
		isNeovim = true,
		iskeyword = "@,48-57,_,192-255,-#",
		runtimepath = "",
		suggest = {
			fromRuntimepath = true,
			fromVimruntime = true,
		},
		vimruntime = "",
	},
	single_file_support = true,
})
require("lspconfig").rust_analyzer.setup({
	settings = {
		["rust-analyzer"] = {
			imports = {
				granularity = {
					group = "module",
				},
				prefix = "self",
			},
			cargo = {
				buildScripts = {
					enable = true,
				},
			},
			procMacro = {
				enable = true,
			},
		},
	},
	on_attach = function(client, bufnr)
		vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
	end,
	capabilities = capabilities,
})
require("lspconfig").eslint.setup({
	capabilities = capabilities,
	-- root_dir = function (fname)
	--     local rootDir = vim.fs.dirname(vim.fs.find({"package.json", "pnpm-lock.yaml", "node_modules"}, {upward = true})[1])
	--     local eCode = os.execute([[bash -c "ls -alh -- ]].. rootDir ..[[ | grep --perl-regexp .eslintrc\..\{2,4\}\|eslint.config\..\{2,3\}"]])
	--     -- if eCode ~= 0 then
	--     --     print("funny")
	--     --     return vim.fs.normalize("~/src/estest")
	--     -- end
	--     local util = require"lspconfig.util"
	--     root_file = util.insert_package_json(root_file, 'eslintConfig', fname)
	--     local a = util.root_pattern(unpack(root_file))(fname)
	--     print(a)
	--     return a
	-- end,
	-- fix format command on attach
	on_attach = function(client, bufnr)
		vim.keymap.set({ "n" }, "<A-F>", "<cmd>EslintFixAll<cr>", {
			buffer = bufnr,
		})
	end,
})
-- jdtls
local function setupJDTLS()
	local mason_registry = require("mason-registry")

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
			return ""
		end
		local path = root .. "/data"
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
	return config
end
-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = "java",
-- 	callback = function()
-- 		local jdtls = require("jdtls")
-- 		jdtls.start_or_attach(setupJDTLS())
-- 		-- require("jdtls").setup_dap()
-- 		vim.keymap.set({ "n", "i" }, "<A-F>", function()
-- 			require("jdtls").organize_imports()
-- 			vim.lsp.buf.format()
-- 		end, {})
-- 	end,
-- })
-- ENDjdtls
require("lspconfig").emmet_language_server.setup({
	filetypes = { "css", "scss", "sass", "less", "html" },
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
require("lspconfig").nixd.setup({
	cmd = { "nixd", "--semantic-tokens=true", "--inlay-hints=true" },
	formatting = {
		command = { "nixfmt" },
	},
	capabilities = capabilities,
	settings = {
		nixd = {
			nixpkgs = {
				expr = "import <nixpkgs> {}",
			},
			options = {
				nixos = {
					expr = '(builtins.getFlake "/home/meyer/nixos").nixosConfigurations.nixd.options',
				},
				home_manager = {
					expr = '(builtins.getFlake "/home/meyer/nixos").homeConfigurations.nixd.options',
				},
				flake_parts = {
					expr = 'let flake = builtins.getFlake ("/home/meyer/nixos"); in flake.debug.options // flake.currentSystem.options',
				},
			},
		},
	},
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
		if client.workspace_folders then
			local path = client.workspace_folders[1].name
			if vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc") then
				return
			end
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
				library = {
					vim.env.VIMRUNTIME,
					-- Depending on the usage, you might want to add additional paths here.
					-- "${3rd}/luv/library"
					-- "${3rd}/busted/library",
				},
				-- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
				-- library = vim.api.nvim_get_runtime_file("", true)
			},
		})
	end,
	settings = {
		Lua = {},
	},
})
require("vencord")
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
		["<Tab>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<CR>"] = cmp.mapping(function(fallback)
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
		{
			name = "lazydev",
			group_index = 0,
		},
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "hrsh7th/cmp-nvim-lsp-signature-help" },
	},
})
cmp.event:on("confirm_done", pairs.on_confirm_done())
require("setupclangdext")

require("null-ls").setup()

-- require("eslint").setup({
-- 	bin = "eslint", -- or `eslint_d`
-- 	code_actions = {
-- 		enable = true,
-- 		apply_on_save = {
-- 			enable = true,
-- 			types = { "directive", "problem", "suggestion", "layout" },
-- 		},
-- 		disable_rule_comment = {
-- 			enable = true,
-- 			location = "separate_line", -- or `same_line`
-- 		},
-- 	},
-- 	diagnostics = {
-- 		enable = true,
-- 		report_unused_disable_directives = false,
-- 		run_on = "type", -- or `save`
-- 	},
-- })

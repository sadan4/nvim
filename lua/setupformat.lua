-- BY LANG
-- https://github.com/mhartington/formatter.nvim/tree/master/lua/formatter/filetypes
-- Utilities for creating configurations
local util = require("formatter.util")
local defaults = require("formatter.defaults")
-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup({
	-- Enable or disable logging
	logging = true,
	-- Set the log level
	log_level = vim.log.levels.WARN,
	-- All formatter configurations are opt-in
	filetype = {
		nix = {
			require("formatter.filetypes.nix").nixpkgs_fmt,
			function()
				return {
					exe = "nixpkgs-fmt",
					stdin = true,
					args = {},
				}
			end,
		},
		json = {
			require("formatter.filetypes.json").prettierd,
			function()
				return {
					exe = "prettierd",
					args = { util.escape_path(util.get_current_buffer_file_path()) },
					stdin = true,
				}
			end,
		},
		yaml = {
			require("formatter.filetypes.yaml").yamlfmt,
			function()
				return {
					exe = "yamlfmt",
					args = { "-in" },
					stdin = true,
				}
			end,
		},
		java = {
			require("formatter.filetypes.java").clangformat,
			function()
				return {
					exe = "clang-format",
					args = {
						"--style=Google",
						"--assume-filename=.java",
					},
					stdin = true,
				}
			end,
		},
		-- Formatter configurations for filetype "lua" go here
		-- and will be executed in order
		typescript = {
			require("formatter.filetypes.typescript").eslint_d,
			function()
				return {
					args = {
						"--stdin",
						"--fix-to-stdout",
					},
					exe = "eslint_d",
					stdin = true,
					try_node_modules = true,
				}
			end,
		},
		typescriptreact = {
			require("formatter.filetypes.typescriptreact").eslint_d,
			function()
				return {
					args = {
						"--stdin",
						"--fix-to-stdout",
					},
					exe = "eslint_d",
					stdin = true,
					try_node_modules = true,
				}
			end,
		},
        javascript = {
            require("formatter.filetypes.javascript").eslint_d,
            function ()
                return {
   					args = {
						"--stdin",
						"--fix-to-stdout",
					},
					exe = "eslint_d",
					stdin = true,
					try_node_modules = true,
             }
            end
        },
        javascriptreact = {
            require("formatter.filetypes.javascriptreact").eslint_d,
            function ()
                return {
   					args = {
						"--stdin",
						"--fix-to-stdout",
					},
					exe = "eslint_d",
					stdin = true,
					try_node_modules = true,
             }
            end
        },
		cpp = {
			require("formatter.filetypes.c").clangformat,
			function()
				return {
					util.copyf(defaults.clangformat),
				}
			end,
		},
		h = {
			require("formatter.filetypes.c").clangformat,
			function()
				return {
					util.copyf(defaults.clangformat),
				}
			end,
		},
		c = {
			require("formatter.filetypes.c").clangformat,
			function()
				return {
					util.copyf(defaults.clangformat),
				}
			end,
		},
		kotlin = {
			require("formatter.filetypes.kotlin").ktlint,
			function()
				return {
					exe = "ktlint",
					args = {
						"--stdin",
						"--format",
						"--log-level=none",
					},
					stdin = true,
				}
			end,
		},
		lua = {
			-- "formatter.filetypes.lua" defines default configurations for the
			-- "lua" filetype
			require("formatter.filetypes.lua").stylua,

			-- You can also define your own configuration
			function()
				-- Supports conditional formatting
				if util.get_current_buffer_file_name() == "special.lua" then
					return nil
				end

				-- Full specification of configurations is down below and in Vim help
				-- files
				return {
					exe = "stylua",
					args = {
						"--search-parent-directories",
						"--stdin-filepath",
						util.escape_path(util.get_current_buffer_file_path()),
						"--",
						"-",
					},
					stdin = true,
				}
			end,
		},

		-- Use the special "*" filetype for defining formatter configurations on
		-- any filetype
		["*"] = {
			-- "formatter.filetypes.any" defines default configurations for any
			-- filetype
			require("formatter.filetypes.any").remove_trailing_whitespace,
		},
	},
})

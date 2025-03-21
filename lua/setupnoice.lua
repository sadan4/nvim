-- this whole file is complete fucking horror
local logged = false

-- searches the list of keymaps (arr)
-- this can be gotten from vim.api.nvim_get_keymap(mode)
-- or vim.api.nvim_buf_get_keymap(buf, mode)
-- to see if it has any mappings with (lhs)
local function hasLHS(arr, lhs)
    for key, value in pairs(arr) do
        if value.lhs == lhs then
            return value
        end
    end
    return nil
end

local function makeOldRightClick()
    -- try buffer local mappings
    local toRet = hasLHS(vim.api.nvim_buf_get_keymap(0, ""), "<RightMouse>")
    if toRet == nil then
    elseif toRet.callback ~= nil then
        return toRet.callback
    elseif toRet.rhs then
        return toRet.rhs
    else
        error("how")
    end
    toRet = hasLHS(vim.api.nvim_get_keymap(""), "<RightMouse>")
    if toRet == nil then
        return function() end
    elseif toRet.callback ~= nil then
        return toRet.callback
    elseif toRet.rhs ~= nil then
        return toRet.rhs
    else
        error("how")
    end
end
local oldRightClick = nil
local function createOldRightClick()
    if oldRightClick == nil then
        oldRightClick = makeOldRightClick()
    end
end
---@generic T
---@param tbl table<T>
---@param el T
---@return number | -1
local function indexOf(tbl, el)
    for index, value in ipairs(tbl) do
        if value == el then
            return index
        end
    end
    return -1
end
local windows = {}
local openWindowCount = 0
---@param rhs string
local function runTextMapping(rhs)
    vim.keymap.set("", "<Plug>(NotifyTempRightClickMap)", rhs)
    vim.cmd([[exec "norm \<Plug>(NotifyTempRightClickMap)"]])
    vim.api.nvim_del_keymap("", "<Plug>(NotifyTempRightClickMap)")
end
local function runPassthruMapping()
    if type(oldRightClick) == "function" then
        oldRightClick()
    elseif type(oldRightClick) == "string" then
        runTextMapping(oldRightClick)
    else
        error("Unknown Type")
    end
end
local function makeCloseMap(windowHandle)
    openWindowCount = openWindowCount + 1
    table.insert(windows, windowHandle)
    if openWindowCount == 1 then
        createOldRightClick()
        vim.keymap.set("", "<RightMouse>", function()
            for _, v in pairs(windows) do
                local _pos = vim.api.nvim_win_get_position(v)
                local min_y = _pos[1]
                local min_x = _pos[2]
                local max_x = vim.api.nvim_win_get_width(v) + min_x
                local max_y = vim.api.nvim_win_get_height(v) + min_y
                local pos = vim.fn.getmousepos()
                local x = pos.screencol
                local y = pos.screenrow
                -- vim.notify(string.format("%s, %s, %s, %s, %s, %s", min_x, max_x, min_y, max_y, x, y))
                if (x >= min_x and x <= max_x) and (y >= min_y and y <= max_y) then
                    vim.api.nvim_win_close(v, true)
                    return
                end
            end
            runPassthruMapping()
        end)
    end
end
local function removeCloseMap(winHandle)
    openWindowCount = openWindowCount - 1
    local index = indexOf(windows, winHandle)
    if index ~= -1 then
        table.remove(windows, index)
    else
        vim.notify("how the fuck")
    end
    if openWindowCount == 0 then
        vim.api.nvim_del_keymap("", "<RightMouse>")
        vim.keymap.set("n", "<RightMouse>", oldRightClick)
        oldRightClick = nil
    end
end

require("notify").setup({
    max_width = 65,
    max_height = 7,
    on_open = makeCloseMap,
    on_close = removeCloseMap,
})
vim.api.nvim_create_user_command("Notifications", "Telescope notify", {
    force = true,
})
vim.notify = require("notify")
vim.keymap.set({"n", "i"}, "<C-S-Space>", function()
    local api = require("noice.lsp.docs")
    local message = api.get("signature")
    api.hide(message)
end)
require("noice").setup({
    cmdline = {
        enabled = true, -- enables the Noice cmdline UI
        view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
        opts = {}, -- global options for the cmdline. See section on views
        ---@type table<string, CmdlineFormat>
        format = {
            -- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
            -- view: (default is cmdline view)
            -- opts: any options passed to the view
            -- icon_hl_group: optional hl_group for the icon
            -- title: set to anything or empty string to hide
            cmdline = { pattern = "^:", icon = "", lang = "vim" },
            search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
            search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
            filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
            lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
            help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
            input = { view = "cmdline_input", icon = "󰥻 " }, -- Used by input()
            -- lua = false, -- to disable a format, set to `false`
        },
    },
    messages = {
        -- NOTE: If you enable messages, then the cmdline is enabled automatically.
        -- This is a current Neovim limitation.
        enabled = true, -- enables the Noice messages UI
        view = "notify", -- default view for messages
        view_error = "notify", -- view for errors
        view_warn = "notify", -- view for warnings
        view_history = "messages", -- view for :messages
        view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
    },
    popupmenu = {
        enabled = true, -- enables the Noice popupmenu UI
        ---@type 'nui'|'cmp'
        backend = "nui", -- backend to use to show regular cmdline completions
        ---@type NoicePopupmenuItemKind|false
        -- Icons for completion item kinds (see defaults at noice.config.icons.kinds)
        kind_icons = {}, -- set to `false` to disable icons
    },
    -- default options for require('noice').redirect
    -- see the section on Command Redirection
    ---@type NoiceRouteConfig
    redirect = {
        view = "popup",
        filter = { event = "msg_show" },
    },
    -- You can add any custom commands below that will be available with `:Noice command`
    ---@type table<string, NoiceCommand>
    commands = {
        history = {
            -- options for the message history that you get with `:Noice`
            view = "split",
            opts = { enter = true, format = "details" },
            filter = {
                any = {
                    { event = "notify" },
                    { error = true },
                    { warning = true },
                    { event = "msg_show", kind = { "" } },
                    { event = "lsp", kind = "message" },
                },
            },
        },
        -- :Noice last
        last = {
            view = "popup",
            opts = { enter = true, format = "details" },
            filter = {
                any = {
                    { event = "notify" },
                    { error = true },
                    { warning = true },
                    { event = "msg_show", kind = { "" } },
                    { event = "lsp", kind = "message" },
                },
            },
            filter_opts = { count = 1 },
        },
        -- :Noice errors
        errors = {
            -- options for the message history that you get with `:Noice`
            view = "popup",
            opts = { enter = true, format = "details" },
            filter = { error = true },
            filter_opts = { reverse = true },
        },
        all = {
            -- options for the message history that you get with `:Noice`
            view = "split",
            opts = { enter = true, format = "details" },
            filter = {},
        },
    },
    notify = {
        -- Noice can be used as `vim.notify` so you can route any notification like other messages
        -- Notification messages have their level and other properties set.
        -- event is always "notify" and kind can be any log level as a string
        -- The default routes will forward notifications to nvim-notify
        -- Benefit of using Noice for this is the routing and consistent history view
        enabled = true,
        view = "notify",
    },
    lsp = {
        progress = {
            enabled = true,
            -- Lsp Progress is formatted using the builtins for lsp_progress. See config.format.builtin
            -- See the section on formatting for more details on how to customize.
            --- @type NoiceFormat|string
            format = "lsp_progress",
            --- @type NoiceFormat|string
            format_done = "lsp_progress_done",
            throttle = 1000 / 30, -- frequency to update lsp progress message
            view = "mini",
        },
        override = {
            -- override the default lsp markdown formatter with Noice
            ["vim.lsp.util.convert_input_to_markdown_lines"] = false,
            -- override the lsp markdown formatter with Noice
            ["vim.lsp.util.stylize_markdown"] = false,
            -- override cmp documentation with Noice (needs the other options to work)
            ["cmp.entry.get_documentation"] = false,
        },
        hover = {
            enabled = true,
            silent = true, -- set to true to not show a message if hover is not available
            view = nil,
            ---@type NoiceViewOptions
            opts = {},
        },
        signature = {
            enabled = true,
            auto_open = {
                enabled = true,
                trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
                luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
                throttle = 50, -- Debounce lsp signature help request by 50ms
            },
            view = nil, -- when nil, use defaults from documentation
            ---@type NoiceViewOptions
            opts = {}, -- merged with defaults from documentation
        },
        message = {
            -- Messages shown by lsp servers
            enabled = true,
            view = "notify",
            opts = {},
        },
        -- defaults for hover and signature help
        documentation = {
            view = "hover",
            ---@type NoiceViewOptions
            opts = {
                lang = "markdown",
                replace = true,
                render = "plain",
                format = { "{message}" },
                win_options = { concealcursor = "n", conceallevel = 3 },
            },
        },
    },
    markdown = {
        hover = {
            ["|(%S-)|"] = vim.cmd.help, -- vim help links
            ["%[.-%]%((%S-)%)"] = require("noice.util").open, -- markdown links
        },
        highlights = {
            ["|%S-|"] = "@text.reference",
            ["@%S+"] = "@parameter",
            ["^%s*(Parameters:)"] = "@text.title",
            ["^%s*(Return:)"] = "@text.title",
            ["^%s*(See also:)"] = "@text.title",
            ["{%S-}"] = "@parameter",
        },
    },
    health = {
        checker = true, -- Disable if you don't want health checks to run
    },
    ---@type NoicePresets
    presets = {
        -- you can enable a preset by setting it to true, or a table that will override the preset config
        -- you can also add custom presets that you can enable/disable with enabled=true
        bottom_search = false, -- use a classic bottom cmdline for search
        command_palette = false, -- position the cmdline and popupmenu together
        long_message_to_split = false, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
    },
    throttle = 1000 / 30, -- how frequently does Noice need to check for ui updates? This has no effect when in blocking mode.
    ---@type NoiceConfigViews
    views = {}, ---@see section on views
    ---@type NoiceRouteConfig[]
    routes = {}, --- @see section on routes
    ---@type table<string, NoiceFilter>
    status = {}, --- @see section on statusline components
    ---@type NoiceFormatOptions
    format = {}, --- @see section on formatting
})

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true
local function myOnAttach(bufnr)
    local api = require("nvim-tree.api")

    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end
    -- defaults
    api.config.mappings.default_on_attach(bufnr)
    vim.keymap.set("n", "<C-t>", api.tree.close, opts("close tree with ctrl+t"))
    vim.keymap.set("n", "H", api.tree.collapse_all, opts("Collapse All"))
    vim.keymap.set("n", "h", function()
        --- @type Node
        local node = api.tree.get_node_under_cursor()
        api.node.navigate.parent_close(node)
    end, opts("Collapse Parent"))
    vim.keymap.set("n", "L", function()
        local node = api.tree.get_node_under_cursor()

        if node.nodes ~= nil then
            -- expand or collapse folder
            api.node.open.edit()
        else
            -- open file as vsplit
            api.node.open.vertical()
        end

        -- Finally refocus on tree if it was lost
        api.tree.focus()
    end, opts("VSplit open"))
    vim.keymap.set("n", "l", function()
        --- @type Node
        local node = api.tree.get_node_under_cursor()

        --- weird types
        ---@diagnostic disable-next-line: undefined-field
        if node.nodes ~= nil then
            api.node.open.edit()
        end
    end)
end
vim.keymap.set("n", "<A-t>", "<Cmd>NvimTreeFindFile<CR>")
-- OR setup with some options
require("nvim-tree").setup({
    on_attach = myOnAttach,
    hijack_cursor = true,
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    renderer = {
        indent_markers = {
            enable = true,
        },
    },
})

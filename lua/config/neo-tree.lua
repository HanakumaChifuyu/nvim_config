require('neo-tree').setup({
    filesystem = {
        group_empty_dirs = true,
        -- follow_current_file = {
        --     enabled = true,
        --     leave_dirs_open = true,
        -- },
    },
    mappings = {
        w = 'close_window',
    },
    window = {
        mappings = {
            ["c"] = function(state)
                local node = state.tree:get_node()
                local path = node:get_id()
                local rel_path = vim.fn.fnamemodify(path, ":.")
                vim.fn.setreg("+", rel_path)
                vim.notify("Copied relative path: " .. rel_path)
            end,
            ["l"] = "open",
            ["h"] = function(state)
                local node = state.tree:get_node()
                if node.type == 'directory' and node:is_expanded() then
                    require("neo-tree.sources.filesystem").toggle_directory(state, node)
                else
                    require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
                end
            end,
        }
    }
})

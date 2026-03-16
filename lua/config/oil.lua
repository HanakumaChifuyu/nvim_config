require("oil").setup({
    default_file_explorer = true,
    view_options = {
        show_hidden = true,
    },
    keymaps = {
        ["q"] = "actions.close",
        ["C"] = {
            desc = "Copy relative path to clipboard",
            callback = function()
                local oil = require("oil")
                local entry = oil.get_cursor_entry()
                local dir = oil.get_current_dir()

                if not entry or not dir then
                    return
                end

                local full_path = dir .. entry.name
                local relative_path = '@' .. vim.fn.fnamemodify(full_path, ":.")

                if entry.type == "directory" then
                    relative_path = relative_path .. "/"
                end
                vim.fn.setreg("+", relative_path)
            end,
        },
    },
    float = {
        padding = 2,
        max_width = 0,
        max_height = 0,
        border = "rounded",
        win_options = {
            winblend = 0,
        },
    },
})

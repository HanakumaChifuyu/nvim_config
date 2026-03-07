require("oil").setup({
    default_file_explorer = true,
    view_options = {
        show_hidden = true,
    },
    keymaps = {
        ["q"] = "actions.close",
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

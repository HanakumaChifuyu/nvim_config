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
                local relative_path = ' @' .. vim.fn.fnamemodify(full_path, ":.") .. ' '

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

require("oil-git").setup({
    debounce_ms = 50,
    show_file_highlights = true,
    show_directory_highlights = true,
    show_file_symbols = true,
    show_directory_symbols = true,
    show_ignored_files = false,       -- Show ignored file status
    show_ignored_directories = false, -- Show ignored directory status
    symbol_position = "eol",          -- "eol", "signcolumn", or "none"
    can_use_signcolumn = nil,         -- Optional callback(bufnr): nil|bool|string
    ignore_gitsigns_update = false,   -- Ignore GitSignsUpdate events (fallback for flickering)
    debug = "verbose",                -- false, "minimal", or "verbose"

    symbols = {
        file = {
            added = "",
            modified = " ",
            renamed = " ",
            deleted = " ",
            copied = "󰆏 ",
            conflict = "󰽜 ",
            untracked = "",
            ignored = " "
        },
        directory = {
            added = "",
            modified = " ",
            renamed = " ",
            deleted = " ",
            copied = "󰆏 ",
            conflict = "󰽜 ",
            untracked = "",
            ignored = " "
        },
    },

    -- Colors (only applied if highlight groups don't exist)
    highlights = {
        OilGitAdded = { fg = "#a6e3a1" },
        OilGitModified = { fg = "#f9e2af" },
        OilGitRenamed = { fg = "#cba6f7" },
        OilGitDeleted = { fg = "#f38ba8" },
        OilGitCopied = { fg = "#cba6f7" },
        OilGitConflict = { fg = "#fab387" },
        OilGitUntracked = { fg = "#89b4fa" },
        OilGitIgnored = { fg = "#6c7086" },
    },
})

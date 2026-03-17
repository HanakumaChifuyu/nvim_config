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
                local relative_path = ' @' .. vim.fn.fnamemodify(full_path, ":.")

                if entry.type == "directory" then
                    relative_path = relative_path .. "/ "
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
            untracked = " ",
            ignored = " "
        },
        directory = {
            added = "",
            modified = " ",
            renamed = " ",
            deleted = " ",
            copied = "󰆏 ",
            conflict = "󰽜 ",
            untracked = " ",
            ignored = " "
        },
    },

    -- Colors (only applied if highlight groups don't exist)
    highlights = {
        OilGitAdded = { fg = "#00d787" },     -- 鲜艳绿色
        OilGitModified = { fg = "#ffd700" },  -- 金黄色
        OilGitRenamed = { fg = "#af5fff" },   -- 鲜艳紫色
        OilGitDeleted = { fg = "#ff5f5f" },   -- 鲜艳红色
        OilGitCopied = { fg = "#00d7ff" },    -- 鲜艳青色
        OilGitConflict = { fg = "#ff6600" },  -- 鲜艳橙色
        OilGitUntracked = { fg = "#fc03ad" }, -- 鲜艳蓝色
        OilGitIgnored = { fg = "#808080" },   -- 灰色（保持低调）
    },
})

-- Force override existing highlight groups
vim.api.nvim_set_hl(0, "OilGitAdded", { fg = "#00d787" })
vim.api.nvim_set_hl(0, "OilGitModified", { fg = "#ffd700" })
vim.api.nvim_set_hl(0, "OilGitRenamed", { fg = "#af5fff" })
vim.api.nvim_set_hl(0, "OilGitDeleted", { fg = "#ff5f5f" })
vim.api.nvim_set_hl(0, "OilGitCopied", { fg = "#00d7ff" })
vim.api.nvim_set_hl(0, "OilGitConflict", { fg = "#ff6600" })
vim.api.nvim_set_hl(0, "OilGitUntracked", { fg = "#fc03ad" })
vim.api.nvim_set_hl(0, "OilGitIgnored", { fg = "#808080" })

vim.api.nvim_create_autocmd("User", {
    pattern = "OilActionsPost",
    callback = function(event)
        if event.data.actions[1].type == "move" then
            Snacks.rename.on_rename_file(event.data.actions[1].src_url, event.data.actions[1].dest_url)
        end
    end,
})

-- ============================================================================
-- Autocommands Management
-- ============================================================================
-- All autocommands are organized by category with augroups for better management
-- Using vim.api.nvim_create_autocmd for consistency and type safety

-- ============================================================================
-- File Type Specific Settings
-- ============================================================================

-- Text files auto-wrap
local text_files_group = vim.api.nvim_create_augroup("TextFilesSettings", { clear = true })

vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
    group = text_files_group,
    pattern = { "*.md", "*.txt", "*.text", "*.rst", "*.org", "*.adoc" },
    desc = "Enable line wrapping for text files",
    callback = function()
        local ft = vim.bo.filetype
        local text_types = {
            ["markdown"] = true,
            ["text"] = true,
            ["rst"] = true,
            ["org"] = true,
            ["asciidoc"] = true,
        }
        if text_types[ft] then
            vim.opt_local.wrap = true
            vim.opt_local.linebreak = true
        end
    end,
})

-- Help and man pages in current window only
local help_window_group = vim.api.nvim_create_augroup("HelpInCurrentWindow", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
    group = help_window_group,
    pattern = { "help", "man" },
    desc = "Open help and man pages in current window only",
    callback = function()
        vim.cmd("wincmd o")
    end,
})

-- Quickfix in current window only
local quickfix_window_group = vim.api.nvim_create_augroup("QuickfixInCurrentWindow", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
    group = quickfix_window_group,
    pattern = "qf",
    desc = "Open quickfix in current window only",
    callback = function()
        vim.cmd("wincmd o")
    end,
})

-- ============================================================================
-- File Auto-reload and Auto-save
-- ============================================================================

-- Auto-reload files when changed outside Neovim
local auto_reload_group = vim.api.nvim_create_augroup("AutoReload", { clear = true })

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
    group = auto_reload_group,
    desc = "Auto-reload files when changed outside Neovim",
    callback = function()
        if vim.api.nvim_get_mode().mode ~= 'c' then
            vim.cmd('checktime')
        end
    end,
})

-- Auto-save on text change
local autosave_group = vim.api.nvim_create_augroup("AutoSave", { clear = true })

vim.api.nvim_create_autocmd({ "TextChangedI", "TextChanged" }, {
    group = autosave_group,
    pattern = "*",
    desc = "Automatically save modifiable buffers on text change",
    callback = function()
        -- Only save modifiable, modified, and normal buffers
        -- Excludes special buffers like quickfix, help, terminal, etc.
        if vim.bo.modifiable and vim.bo.modified and vim.bo.buftype == "" then
            vim.cmd("silent! update")
        end
    end,
})

-- ============================================================================
-- LSP Settings
-- ============================================================================

local lsp_attach_group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
    group = lsp_attach_group,
    desc = "Configure LSP keybindings and settings when LSP attaches",
    callback = function(lsp_env)
        local opts = { buffer = lsp_env.buf }

        -- Configure inlay hint highlight
        vim.api.nvim_set_hl(0, 'LspInlayHint', {
            fg = '#565f89',
            bg = '#292e42',
            italic = true,
            bold = false,
            blend = 30,
        })

        -- Hover documentation
        vim.keymap.set('n', 'K', function()
            vim.lsp.buf.hover({ border = 'rounded' })
        end, vim.tbl_extend('force', opts, { desc = 'LSP Hover Documentation' }))

        -- Show diagnostics
        vim.keymap.set('n', 'ge', function()
            vim.diagnostic.open_float({ border = 'rounded' })
        end, vim.tbl_extend('force', opts, { desc = 'Show Diagnostics' }))
    end,
})

-- ============================================================================
-- Terminal Settings
-- ============================================================================

local terminal_group = vim.api.nvim_create_augroup("TerminalSettings", { clear = true })

vim.api.nvim_create_autocmd("TermOpen", {
    group = terminal_group,
    pattern = "term://*",
    desc = "Configure terminal keybindings",
    callback = function()
        local opts = { buffer = 0 }
        vim.o.timeoutlen = 300

        -- Exit terminal mode
        vim.keymap.set('t', 'jj', [[<C-\><C-n>]], opts)

        -- Window command prefix (useful for window navigation from terminal)
        vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
    end,
})

-- ============================================================================
-- Plugin-specific Autocommands
-- ============================================================================

-- Oil.nvim: Handle file rename/move operations
local oil_actions_group = vim.api.nvim_create_augroup("OilActions", { clear = true })

vim.api.nvim_create_autocmd("User", {
    group = oil_actions_group,
    pattern = "OilActionsPost",
    desc = "Notify Snacks plugin when Oil renames a file",
    callback = function(event)
        if event.data.actions[1].type == "move" then
            Snacks.rename.on_rename_file(event.data.actions[1].src_url, event.data.actions[1].dest_url)
        end
    end,
})

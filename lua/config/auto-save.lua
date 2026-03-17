-- ============================================================================
-- Auto-Save Configuration
-- ============================================================================
-- Automatically saves buffers when text changes in normal or insert mode
-- Only saves modifiable, modified, and normal buffers (excludes special buffers)

local autosave_group = vim.api.nvim_create_augroup("AutoSave", { clear = true })

vim.api.nvim_create_autocmd({ "TextChangedI", "TextChanged" }, {
    group = autosave_group,
    pattern = "*",
    callback = function()
        -- Only save modifiable, modified, and normal buffers
        -- Excludes special buffers like quickfix, help, terminal, etc.
        if vim.bo.modifiable and vim.bo.modified and vim.bo.buftype == "" then
            vim.cmd("silent! update")
        end
    end,
})

-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = "markdown",
--     callback = function()
--         vim.keymap.del("n", "K", { buffer = true })
--     end,
-- })

-- markdown wrap
vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
    end,
})

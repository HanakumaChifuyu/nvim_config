-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = "markdown",
--     callback = function()
--         vim.keymap.del("n", "K", { buffer = true })
--     end,
-- })

-- text file wrap
vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
    pattern = { "*.md", "*.txt", "*.text", "*.rst", "*.org", "*.adoc" },
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

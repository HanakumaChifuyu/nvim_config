-- 自动保存配置
local autosave_group = vim.api.nvim_create_augroup("AutoSave", { clear = true })

vim.api.nvim_create_autocmd({ "TextChangedI", "TextChanged" }, {
    group = autosave_group,
    pattern = "*",
    callback = function()
        -- 只保存可修改的普通 buffer
        if vim.bo.modifiable and vim.bo.modified and vim.bo.buftype == "" then
            vim.cmd("silent! update")
        end
    end,
})

require("mason").setup()


-- Setup LSP capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
-- Enable workspace/didChangeWatchedFiles so LSP can detect external file changes
capabilities.workspace = capabilities.workspace or {}
capabilities.workspace.didChangeWatchedFiles = {
    dynamicRegistration = true,
}
-- capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(args)
        require("conform").format({ bufnr = args.buf })
    end,
})

require("conform").setup({
    formatters_by_ft = {
        lua = { "luaformatter" },
        markdown = { "markdownlint" },
        bash = { "shfmt" },
        zsh = { "shfmt" },
        sh = { "shfmt" },
        java = { "google-java-format" },
        xml = { "xmlformat" },
        yaml = { "prettier" },
        toml = { "taplo" },
        conf = { "prettier" },
        fish = { "fish_indent" },
        python = { "ruff_format", "ruff_organize_imports", "ruff_fix" },
        rust = { "rustfmt" },
        json = { "biome", "prettier", stop_after_first = true },
        jsonc = { "biome" },
        javascript = { "prettier", stop_after_first = true },
        typescript = { "prettier", stop_after_first = true },
        javascriptreact = { "prettier", stop_after_first = true },
        typescriptreact = { "prettier", stop_after_first = true },
        vue = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        cpp = { "clang-format" },
        c = { "clang-format" },

        ["_"] = { "trim_whitespace", "trim_trailing_lines" }
    },
    formatters = {
        ["clang-format"] = {
            prepend_args = { "--style={IndentWidth: 4}" },
        },
    },
    format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_format = "fallback",
    },
})
vim.lsp.config('basedpyright', {
    capabilities = capabilities,
    settings = {
        basedpyright = {
            analysis = {
                typeCheckingMode = "basic",
            },
        },
    },
})


require("mason-lspconfig").setup({
    handlers = {
        function(server_name)
            require("lspconfig")[server_name].setup({
                capabilities = capabilities,
            })
        end,
    },
})

-- high light group
-- -- document_highlight有时候会跟很多很多别的插件冲突
-- vim.cmd([[
--   highlight LspReferenceText  guibg=#3c4c55 guifg=NONE gui=NONE
--   highlight LspReferenceRead  guibg=#3c4c55 guifg=NONE gui=NONE
--   highlight LspReferenceWrite guibg=#3c4c55 guifg=NONE gui=NONE
-- ]])
--
-- ---@type string[]
-- local ft_list = { "markdown" }
--
-- ---只在某些类型的下启动高光功能
-- ---@param file_types string[] 存放不启用高光功能的文件类型的列表
-- ---@param hover_delay_ms integer 鼠标悬浮触发高光操作的延迟，单位ms
-- ---@return boolean
-- local function show_highlight(file_types, hover_delay_ms)
--     local ft = vim.bo.filetype
--     for _, ft_value in ipairs(file_types) do
--         if ft == ft_value then
--             return false
--         end
--     end
--     vim.opt.updatetime = hover_delay_ms
--     vim.lsp.buf.document_highlight()
--     return true
-- end
--
-- ---@param file_types string[] 存放不启用高光功能的文件类型的列表
-- ---@return boolean
-- local function clear_highlight(file_types)
--     local ft = vim.bo.filetype
--     for _, ft_value in ipairs(file_types) do
--         if ft == ft_value then
--             return false
--         end
--     end
--     vim.lsp.buf.clear_references()
--     return true
-- end
--
-- vim.api.nvim_create_autocmd('CursorHold', {
--     pattern = '*',
--     callback = function()
--         show_highlight(ft_list, 200)
--     end
-- })
--
-- vim.api.nvim_create_autocmd('CursorMoved', {
--     pattern = '*',
--     callback = function()
--         clear_highlight(ft_list)
--     end
-- })

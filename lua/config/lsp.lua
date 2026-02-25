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

vim.lsp.config('rust_analyzer', {
    cmd = { 'rust-analyzer' },
    filetypes = { 'rust' },
    root_markers = { 'Cargo.toml', '.git' },
    settings = {
        ['rust-analyzer'] = {
            checkOnSave = { command = "clippy" },
            procMacro = { enable = true },
            diagnostics = { enable = true },
        },
    },
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

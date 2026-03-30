-- ============================================================================
-- Mason Setup
-- ============================================================================
require("mason").setup()

-- ============================================================================
-- LSP Capabilities Configuration
-- ============================================================================
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Enable workspace/didChangeWatchedFiles so LSP can detect external file changes
capabilities.workspace = capabilities.workspace or {}
capabilities.workspace.didChangeWatchedFiles = {
    dynamicRegistration = true,
}

-- ============================================================================
-- Diagnostic Configuration (LSP-specific)
-- ============================================================================
-- Note: This merges with the base diagnostic config in general.lua
vim.diagnostic.config({
    -- Enable real-time diagnostics while typing in insert mode
    update_in_insert = true,
    -- Improve diagnostic update responsiveness
    severity_sort = true,
})

-- ============================================================================
-- Conform (Formatter) Setup
-- ============================================================================
require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
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
        ["_"] = { "trim_whitespace", "trim_newlines", "squeeze_blanks" }
    },
    formatters = {
        ["clang-format"] = {
            prepend_args = { "--style={IndentWidth: 4}" },
        },
    },
    format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
    },
})

-- ============================================================================
-- LSP Server Configurations
-- ============================================================================

-- Rust Analyzer
vim.lsp.config('rust_analyzer', {
    cmd = { 'rust-analyzer' },
    filetypes = { 'rust' },
    root_markers = { 'Cargo.toml', '.git' },
    settings = {
        ['rust-analyzer'] = {
            procMacro = { enable = true },
            diagnostics = {
                enable = true,
                experimental = {
                    enable = true,
                },
            },
            check = {
                command = "check",
            },
            cargo = {
                autoreload = true,
                buildScripts = {
                    enable = true,
                },
            },
        },
    },
})

-- Python (BasedPyright)
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

-- ============================================================================
-- Mason LSP Config (Default Handler)
-- ============================================================================
require("mason-lspconfig").setup({
    handlers = {
        function(server_name)
            require("lspconfig")[server_name].setup({
                capabilities = capabilities,
            })
        end,
    },
})

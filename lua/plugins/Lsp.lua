return {
    "mason-org/mason.nvim",
    "mason-org/mason-lspconfig.nvim",
    'stevearc/conform.nvim',
    'mfussenegger/nvim-jdtls',


    'mrcjkb/rustaceanvim',
    version = '^6', -- Recommended
    lazy = false,   -- This plugin is already lazy
    config = function()
        vim.g.rustaceanvim = {
            server = {
                settings = {
                    ['rust-analyzer'] = {
                        check = {
                            command = "clippy",
                            extraArgs = { "--all-targets", "--all-features" },
                        },
                        diagnostics = {
                            enable = true,
                            experimental = {
                                enable = true,
                            },
                        },
                    },
                },
            },
        }
    end,
}

return {
    'stevearc/aerial.nvim',
    opts = {},
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons"
    },
    config = function()
        require("aerial").setup({
            layout = {
                default_direction = "right",
                max_width = { 40, 0.2 },
            },

            ignore = {
                filetypes = { "neo-tree" },
            },

            nerd_font = true,
        })
    end
}

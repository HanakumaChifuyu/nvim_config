return {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
        "SmiteshP/nvim-navic",     -- 必需：用于获取 LSP 上下文（函数名等）
        "nvim-tree/nvim-web-devicons", -- 可选：显示图标
    },
    opts = {
        -- 可以在这里配置，也可以使用默认
        show_dirname = true, -- 显示文件夹名
        show_basename = true, -- 显示文件名
        show_modified = true, -- 修改时不高亮，或者做标记
    },
}

vim.opt.termguicolors = true
require('bufferline').setup {
    options = {

        offsets = {
            {
                filetype = "neo-tree",  -- 这里填 neo-tree 的 filetype
                text = "File Explorer", -- 可选：侧边栏上方的标题
                text_align = "left",    -- 可选：标题对齐方式
                separator = true,       -- 可选：是否显示分割线
                highlight = "Directory" -- 可选：标题的高亮组
            }
        },

        -- 其他你可能需要的标准配置
        show_buffer_close_icons = false,
        show_close_icon = false,
    }
}

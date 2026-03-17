-- basic
vim.o.clipboard = "unnamedplus"
vim.o.number = true
vim.o.relativenumber = true
vim.o.laststatus = 2
vim.o.showcmd = true
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.fileencodings = "utf-8"
vim.o.wrap = false

-- init 颜色显示插件
vim.opt.termguicolors = true
require('nvim-highlight-colors').setup({})
vim.o.switchbuf = 'useopen,uselast'
vim.o.foldmethod = 'indent' -- 基于缩进折叠
vim.o.foldlevel = 99
vim.opt.autoread = true

vim.opt.iskeyword:append("-")

vim.cmd [[
  augroup HelpInCurrentWindow
    autocmd!
    autocmd FileType help,man wincmd o
  augroup END
]]

vim.cmd [[
  augroup QuickfixInCurrentWindow
    autocmd!
    autocmd FileType qf wincmd o
  augroup END
]]

-- color scheme
vim.cmd [[colorscheme tokyonight]]

vim.diagnostic.config({
    severity_sort = true,
    float = {
        border = "rounded",
        source = true,
        header = "",
        prefix = "",
    },
    virtual_text = false,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN]  = '󰀪 ',
            [vim.diagnostic.severity.HINT]  = '󰌶',
            [vim.diagnostic.severity.INFO]  = '󰋽 ',
        }
    },
    underline = true

})

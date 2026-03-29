-- ============================================================================
-- Basic Editor Settings
-- ============================================================================
vim.o.clipboard = "unnamedplus"
vim.o.number = true
vim.o.relativenumber = true
vim.o.laststatus = 2
vim.o.showcmd = true
vim.o.wrap = false
vim.o.fileencodings = "utf-8"
vim.opt.updatetime = 200
vim.opt.autoread = true
vim.opt.iskeyword:append("-")

-- ============================================================================
-- Search Settings
-- ============================================================================
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

-- =============== require('matugen').setup()=============================================================
-- Indentation Settings
-- ============================================================================
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.autoindent = true
vim.o.smartindent = true

-- ============================================================================
-- Folding Settings
-- ============================================================================
vim.o.foldmethod = 'indent'
vim.o.foldlevel = 99

-- ============================================================================
-- Window and Buffer Settings
-- ============================================================================
vim.o.switchbuf = 'useopen,uselast'

-- ============================================================================
-- Diagnostic Configuration
-- ============================================================================
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

-- Note: Autocommands moved to lua/config/autocmds.lua for centralized management


require('matugen').setup()

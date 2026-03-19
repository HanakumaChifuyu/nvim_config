-- ============================================================================
-- Basic Navigation & Editing
-- ============================================================================

-- File manager
vim.keymap.set('n', '<leader>e', '<cmd>Oil --float<CR>', { desc = 'Open Oil file manager (float)' })

-- Visual line navigation
vim.keymap.set({ 'n', 'v' }, 'j', 'gj', { noremap = true, silent = true })
vim.keymap.set({ 'n', 'v' }, 'k', 'gk', { noremap = true, silent = true })

-- Quick save and quit
vim.keymap.set('n', '<leader>w', ':wa<CR>', { noremap = true, desc = 'Save all buffers' })
vim.keymap.set('n', '<leader>q', ':q<CR>', { noremap = true, desc = 'Quit' })

-- Quick escape from insert mode
vim.keymap.set('i', 'jj', '<Esc>', { noremap = true, silent = true })

-- Buffer navigation
vim.keymap.set('n', 'H', '<cmd>bprevious<CR>', { desc = 'Previous buffer' })
vim.keymap.set('n', 'L', '<cmd>bnext<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<leader>c', function()
    Snacks.bufdelete()
end, { noremap = true, silent = true, desc = 'Close current buffer and go to previous' })

-- Insert blank lines without entering insert mode
vim.keymap.set('n', 'o', 'o[<BS>', { noremap = true })
vim.keymap.set('n', 'O', 'O[<BS>', { noremap = true })

-- Paste without overwriting register in visual mode
vim.keymap.set('x', 'p', '"_dP', { noremap = true })

-- Copy relative path to system clipboard
vim.keymap.set('n', 'C', function()
    local path = ' @' .. vim.fn.expand('%:.') .. ' '
    vim.fn.setreg('+', path)
end, { desc = 'Copy relative path' })

-- ============================================================================
-- Window Navigation & Management (keyd remapping compatible)
-- ============================================================================

-- Remap physical arrow keys to window navigation (for keyd compatibility)
vim.keymap.set({ 'n', 'v', 'o' }, '<Left>', '<C-h>', { remap = true })
vim.keymap.set({ 'n', 'v', 'o' }, '<Down>', '<C-j>', { remap = true })
vim.keymap.set({ 'n', 'v', 'o' }, '<Up>', '<C-k>', { remap = true })
vim.keymap.set({ 'n', 'v', 'o' }, '<Right>', '<C-l>', { remap = true })

-- Window navigation
vim.keymap.set('n', '<C-h>', [[<Cmd>wincmd h<CR>]], { noremap = true, silent = true })
vim.keymap.set('n', '<C-j>', [[<Cmd>wincmd j<CR>]], { noremap = true, silent = true })
vim.keymap.set('n', '<C-k>', [[<Cmd>wincmd k<CR>]], { noremap = true, silent = true })
vim.keymap.set('n', '<C-l>', [[<Cmd>wincmd l<CR>]], { noremap = true, silent = true })

-- Window resizing
vim.keymap.set('n', '<C-Up>', '<C-W>+', { desc = 'Increase window height' })
vim.keymap.set('n', '<C-Down>', '<C-W>-', { desc = 'Decrease window height' })
vim.keymap.set('n', '<C-Right>', '<C-W><', { desc = 'Increase window width' })
vim.keymap.set('n', '<C-Left>', '<C-W>>', { desc = 'Decrease window width' })

-- ============================================================================
-- LSP & Diagnostics
-- ============================================================================
-- Note: LspAttach autocmd moved to lua/config/autocmds.lua

-- LSP navigation (using Snacks picker)
vim.keymap.set('n', 'gd', function()
    Snacks.picker.lsp_definitions()
end, { desc = 'Goto Definition' })
vim.keymap.set('n', 'gr', function()
    Snacks.picker.lsp_references()
end, { nowait = true, desc = 'References' })
vim.keymap.set('n', '<leader>ss', function()
    Snacks.picker.lsp_symbols()
end, { desc = 'LSP Symbols' })
vim.keymap.set('n', '<leader>sS', function()
    Snacks.picker.lsp_workspace_symbols()
end, { desc = 'LSP Workspace Symbols' })

-- LSP actions
vim.keymap.set('n', 'gn', vim.lsp.buf.rename, { desc = 'LSP Rename' })
vim.keymap.set('n', 'ga', ':Lspsaga code_action<CR>', { desc = 'Lsp Actions' })

-- ============================================================================
-- Terminal Management
-- ============================================================================
-- Note: TermOpen autocmd moved to lua/config/autocmds.lua

-- Terminal utilities
local Terminal = require('toggleterm.terminal').Terminal

-- Lazygit terminal
local lazygit = Terminal:new({
    cmd = 'lazygit',
    hidden = true,
    direction = 'float',
    float_opts = {
        border = 'double',
    },
})

function _G._lazygit_toggle()
    lazygit:toggle()
end

vim.api.nvim_set_keymap('n', '<leader>tl', '<cmd>lua _lazygit_toggle()<CR>',
    { desc = 'Toggle lazygit', noremap = true, silent = true })

-- Yazi file manager terminal
local yazi = Terminal:new({
    cmd = 'yazi',
    hidden = true,
    direction = 'float',
    float_opts = {
        border = 'double',
    },
})

function _G._yazi_toggle()
    yazi:toggle()
end

vim.api.nvim_set_keymap('n', '<leader>ty', '<cmd>lua _yazi_toggle()<CR>',
    { desc = 'Toggle yazi', noremap = true, silent = true })

-- Float terminal
local float_terminal = Terminal:new({
    cmd = 'fish',
    hidden = true,
    direction = 'float',
    float_opts = {
        border = 'double',
    },
})

function _G._float_terminal()
    float_terminal:toggle()
end

vim.api.nvim_set_keymap('n', '<leader>tt', '<cmd>lua _float_terminal()<CR>',
    { desc = 'Toggle float terminal', noremap = true, silent = true })

-- Claude Code terminal
local float_claude_code = Terminal:new({
    cmd = 'cc',
    hidden = true,
    direction = 'float',
    float_opts = {
        border = 'double',
    },
})

function _G._float_claude_code()
    float_claude_code:toggle()
end

vim.api.nvim_set_keymap('n', '<leader>tc', '<cmd>lua _float_claude_code()<CR>',
    { desc = 'Toggle float claude_code', noremap = true, silent = true })

-- ============================================================================
-- Plugin-specific Keybindings
-- ============================================================================

-- Leap motion
vim.keymap.set({ 'n', 'x', 'o' }, 'f', '<Plug>(leap)')

-- Yanky (yank history)
vim.keymap.set({ 'n', 'x' }, 'gp', '<Plug>(YankyGPutAfter)')
vim.keymap.set({ 'n', 'x' }, 'gP', '<Plug>(YankyGPutBefore)')

vim.keymap.set('n', '<c-p>', '<Plug>(YankyPreviousEntry)')
vim.keymap.set('n', '<c-n>', '<Plug>(YankyNextEntry)')

vim.keymap.set('n', ']p', '<Plug>(YankyPutIndentAfterLinewise)')
vim.keymap.set('n', '[p', '<Plug>(YankyPutIndentBeforeLinewise)')

vim.keymap.set('n', '>p', '<Plug>(YankyPutIndentAfterShiftRight)')
vim.keymap.set('n', '<p', '<Plug>(YankyPutIndentAfterShiftLeft)')
vim.keymap.set('n', '>P', '<Plug>(YankyPutIndentBeforeShiftRight)')
vim.keymap.set('n', '<P', '<Plug>(YankyPutIndentBeforeShiftLeft)')

vim.keymap.set('n', '=p', '<Plug>(YankyPutAfterFilter)')
vim.keymap.set('n', '=P', '<Plug>(YankyPutBeforeFilter)')

-- ============================================================================
-- Snacks Picker (Fuzzy Finder)
-- ============================================================================

vim.keymap.set('n', '<leader>,', function()
    Snacks.picker.buffers()
end, { desc = 'Buffers' })
vim.keymap.set('n', '<leader>/', function()
    Snacks.picker.grep()
end, { desc = 'Grep' })
vim.keymap.set('n', '<leader>:', function()
    Snacks.picker.command_history()
end, { desc = 'Command History' })
vim.keymap.set('n', '<leader>n', function()
    Snacks.picker.notifications()
end, { desc = 'Notification History' })

-- Find files
vim.keymap.set('n', '<leader>fb', function()
    Snacks.picker.buffers()
end, { desc = 'Buffers' })
vim.keymap.set('n', '<leader>fc', function()
    Snacks.picker.files({ cwd = vim.fn.stdpath('config') })
end, { desc = 'Find Config File' })
vim.keymap.set('n', '<leader>ff', function()
    Snacks.picker.files()
end, { desc = 'Find Files' })
vim.keymap.set('n', '<leader>fg', function()
    Snacks.picker.git_files()
end, { desc = 'Find Git Files' })
vim.keymap.set('n', '<leader>fp', function()
    Snacks.picker.projects()
end, { desc = 'Projects' })
vim.keymap.set('n', '<leader>fr', function()
    Snacks.picker.recent({ filter = { cwd = true } })
end, { desc = 'Recent' })

-- Search commands
vim.keymap.set('n', '<leader>sc', function()
    Snacks.picker.command_history()
end, { desc = 'Command History' })
vim.keymap.set('n', '<leader>sC', function()
    Snacks.picker.commands()
end, { desc = 'Commands' })
vim.keymap.set('n', '<leader>sd', function()
    Snacks.picker.diagnostics()
end, { desc = 'Diagnostics' })
vim.keymap.set('n', '<leader>sD', function()
    Snacks.picker.diagnostics_buffer()
end, { desc = 'Buffer Diagnostics' })
vim.keymap.set('n', '<leader>si', function()
    Snacks.picker.icons()
end, { desc = 'Icons' })
vim.keymap.set('n', '<leader>sm', function()
    Snacks.picker.marks()
end, { desc = 'Marks' })

-- ============================================================================
-- Words Navigation (Navigate between word references)
-- ============================================================================

vim.keymap.set({ 'n', 't' }, ']]', function()
    Snacks.words.jump(vim.v.count1)
end, { desc = 'Next Reference' })

vim.keymap.set({ 'n', 't' }, '[[', function()
    Snacks.words.jump(-vim.v.count1)
end, { desc = 'Prev Reference' })

-- basic
vim.keymap.set('n', 'j', 'gj', { noremap = true, silent = true })
vim.keymap.set('n', 'k', 'gk', { noremap = true, silent = true })
vim.keymap.set('v', 'j', 'gj', { noremap = true, silent = true })
vim.keymap.set('v', 'k', 'gk', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>q', ':q<CR>', { noremap = true })
vim.keymap.set('n', '<leader>w', ':wa<CR>', { noremap = true })

vim.keymap.set('i', 'jj', '<Esc>', { noremap = true, silent = true })

vim.keymap.set('n', 'H', '<cmd>bprevious<CR>')
vim.keymap.set('n', 'L', '<cmd>bnext<CR>')

vim.keymap.set('n', 'o', 'o[<BS>', { noremap = true })
vim.keymap.set('n', 'O', 'O[<BS>', { noremap = true })

-- 在可视模式下粘贴时不覆盖寄存器内容
vim.keymap.set('x', 'p', [["_dP]])

-- 针对 keyd 转换后的物理方向键，直接执行最终动作
vim.keymap.set({ 'n', 'v', 'o' }, '<Left>', '<C-h>', { remap = true })
vim.keymap.set({ 'n', 'v', 'o' }, '<Down>', '<C-j>', { remap = true })
vim.keymap.set({ 'n', 'v', 'o' }, '<Up>', '<C-k>', { remap = true })
vim.keymap.set({ 'n', 'v', 'o' }, '<Right>', '<C-l>', { remap = true })

vim.keymap.set('n', '<C-h>', [[<Cmd>wincmd h<CR>]], { noremap = true, silent = true })
vim.keymap.set('n', '<C-j>', [[<Cmd>wincmd j<CR>]], { noremap = true, silent = true })
vim.keymap.set('n', '<C-k>', [[<Cmd>wincmd k<CR>]], { noremap = true, silent = true })
vim.keymap.set('n', '<C-l>', [[<Cmd>wincmd l<CR>]], { noremap = true, silent = true })

vim.keymap.set('n', '<C-Up>', '<C-W>+', { desc = '增加窗口高度' })
vim.keymap.set('n', '<C-Down>', '<C-W>-', { desc = '减少窗口高度' })
vim.keymap.set('n', '<C-Right>', '<C-W><', { desc = '增加窗口宽度' })
vim.keymap.set('n', '<C-Left>', '<C-W>>', { desc = '减少窗口宽度' })

vim.keymap.set("n", "<leader>c", function()
        Snacks.bufdelete()
    end,
    { noremap = true, silent = true, desc = "Close current buffer and go to previous" })

-- 复制相对路径到系统剪贴板
vim.keymap.set('n', 'C', function()
    local path = vim.fn.expand('%:.')
    vim.fn.setreg('+', path)
    print("Copied: " .. path)
end, { desc = "Copy relative path" })
-- neo-tree
vim.keymap.set('n', '<leader>e', ":Neotree toggle<CR>", { desc = "Toggle neo-tree" })

-- lsp
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(lsp_env)
        local opts = { buffer = lsp_env.buf }

        -- local client = vim.lsp.get_client_by_id(lsp_env.data.client_id)
        -- if not client then
        --     return
        -- end

        vim.api.nvim_set_hl(0, "LspInlayHint", {
            fg = "#565f89", -- 前景色
            bg = "#292e42", -- 背景色
            italic = true,
            bold = false,
            blend = 30 --透明度
        })

        -- if client.server_capabilities.inlayHintProvider then
        --     vim.lsp.inlay_hint.enable(true, { bufnr = lsp_env.buf })
        -- end

        vim.keymap.set("n", "K", function()
            vim.lsp.buf.hover({ border = "rounded" })
        end, opts)

        vim.keymap.set("n", "ge", function()
            vim.diagnostic.open_float({ border = "rounded" })
        end, opts)
    end,
})

vim.keymap.set("n", "gd", function() Snacks.picker.lsp_definitions() end, { desc = "Goto Definition" })
vim.keymap.set("n", "gr", function() Snacks.picker.lsp_references() end, { nowait = true, desc = "References" })
vim.keymap.set("n", "<leader>ss", function() Snacks.picker.lsp_symbols() end, { desc = "LSP Symbols" })
vim.keymap.set("n", "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end,
    { desc = "LSP Workspace Symbols" })

vim.keymap.set('n', 'gn', vim.lsp.buf.rename, { desc = 'LSP Rename' })
vim.keymap.set("n", "ga", ":Lspsaga code_action<CR>", { desc = "Lsp Actions" })


-- Toggle terminal

function _G.set_terminal_keymaps()
    local opts = { buffer = 0 }
    vim.o.timeoutlen = 300
    vim.keymap.set('t', 'jj', [[<C-\><C-n>]], opts)

    -- using float terminal to avoid conflict with keyd remap

    -- vim.keymap.set('t', '<Left>', [[<Cmd>wincmd h<CR>]], opts)
    -- vim.keymap.set('t', '<Down>', [[<Cmd>wincmd j<CR>]], opts)
    -- vim.keymap.set('t', '<Up>', [[<Cmd>wincmd k<CR>]], opts)
    -- vim.keymap.set('t', '<Right>', [[<Cmd>wincmd l<CR>]], opts)

    -- vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
    -- vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
    -- vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
    -- vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)

    vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
-- lazy git
local Terminal = require('toggleterm.terminal').Terminal
local lazygit  = Terminal:new({
    cmd = "lazygit",
    hidden = true,
    direction = "float",
    float_opts = {
        border = "double",
    },
})

function _G._lazygit_toggle()
    lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>tl", "<cmd>lua _lazygit_toggle()<CR>",
    { desc = "Toggle lazygit", noremap = true, silent = true })

-- yazi
local yazi = Terminal:new({
    cmd = "yazi",
    hidden = true,
    direction = "float",
    float_opts = {
        border = "double",
    },
})

function _G._yazi_toggle()
    yazi:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>ty", "<cmd>lua _yazi_toggle()<CR>",
    { desc = "Toggle yazi", noremap = true, silent = true })
-- float terminal
local float_terminal = Terminal:new({
    cmd = "fish",
    hidden = true,
    direction = "float",
    float_opts = {
        border = "double",
    },
})
function _G._float_terminal()
    float_terminal:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>tt", "<cmd>lua _float_terminal()<CR>",
    { desc = "Toggle float terminal", noremap = true, silent = true })

local float_claude_code = Terminal:new({
    cmd = "cc",
    hidden = true,
    direction = "float",
    float_opts = {
        border = "double",
    },
})

function _G._float_claude_code()
    float_claude_code:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>tc", "<cmd>lua _float_claude_code()<CR>",
    { desc = "Toggle float claude_code", noremap = true, silent = true })

-- leap
vim.keymap.set({ 'n', 'x', 'o' }, 'f', '<Plug>(leap)')

-- rust_analysis
-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = "rust",
--     callback = function()
--         vim.keymap.set(
--             "n",
--             "ga",
--             function()
--                 vim.cmd.RustLsp('codeAction')
--             end,
--             { silent = true, buffer = true }
--         )
--         vim.keymap.set(
--             "n",
--             "K", -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
--             function()
--                 vim.cmd.RustLsp({ 'hover', 'actions' })
--             end,
--             { silent = true, buffer = true }
--         )
--     end,
-- })
--


-- yanky

vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")

vim.keymap.set("n", "<c-p>", "<Plug>(YankyPreviousEntry)")
vim.keymap.set("n", "<c-n>", "<Plug>(YankyNextEntry)")

vim.keymap.set("n", "]p", "<Plug>(YankyPutIndentAfterLinewise)")
vim.keymap.set("n", "[p", "<Plug>(YankyPutIndentBeforeLinewise)")

vim.keymap.set("n", ">p", "<Plug>(YankyPutIndentAfterShiftRight)")
vim.keymap.set("n", "<p", "<Plug>(YankyPutIndentAfterShiftLeft)")
vim.keymap.set("n", ">P", "<Plug>(YankyPutIndentBeforeShiftRight)")
vim.keymap.set("n", "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)")

vim.keymap.set("n", "=p", "<Plug>(YankyPutAfterFilter)")
vim.keymap.set("n", "=P", "<Plug>(YankyPutBeforeFilter)")

-- picker
vim.keymap.set("n", "<leader>,", function() Snacks.picker.buffers() end, { desc = "Buffers" })
vim.keymap.set("n", "<leader>/", function() Snacks.picker.grep() end, { desc = "Grep" })
vim.keymap.set("n", "<leader>:", function() Snacks.picker.command_history() end, { desc = "Command History" })
vim.keymap.set("n", "<leader>n", function() Snacks.picker.notifications() end, { desc = "Notification History" })
vim.keymap.set("n", "<leader>fb", function() Snacks.picker.buffers() end, { desc = "Buffers" })
vim.keymap.set("n", "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end,
    { desc = "Find Config File" })
vim.keymap.set("n", "<leader>ff", function() Snacks.picker.files() end, { desc = "Find Files" })
vim.keymap.set("n", "<leader>fg", function() Snacks.picker.git_files() end, { desc = "Find Git Files" })
vim.keymap.set("n", "<leader>fp", function() Snacks.picker.projects() end, { desc = "Projects" })
vim.keymap.set("n", "<leader>fr", function() Snacks.picker.recent({ filter = { cwd = true } }) end, { desc = "Recent" })

vim.keymap.set("n", "<leader>sc", function() Snacks.picker.command_history() end, { desc = "Command History" })
vim.keymap.set("n", "<leader>sC", function() Snacks.picker.commands() end, { desc = "Commands" })
vim.keymap.set("n", "<leader>sd", function() Snacks.picker.diagnostics() end, { desc = "Diagnostics" })
vim.keymap.set("n", "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, { desc = "Buffer Diagnostics" })
vim.keymap.set("n", "<leader>si", function() Snacks.picker.icons() end, { desc = "Icons" })
vim.keymap.set("n", "<leader>sm", function() Snacks.picker.marks() end, { desc = "Marks" })

-- Words Navigation
vim.keymap.set({ "n", "t" }, "]]", function() Snacks.words.jump(vim.v.count1) end, { desc = "Next Reference" })
vim.keymap.set({ "n", "t" }, "[[", function() Snacks.words.jump(-vim.v.count1) end, { desc = "Prev Reference" })
vim.keymap.set({ "n", "t" }, "[[", function() Snacks.words.jump(-vim.v.count1) end, { desc = "Prev Reference" })
vim.keymap.set({ "n", "t" }, "[[", function() Snacks.words.jump(-vim.v.count1) end, { desc = "Prev Reference" })

-- copilot
-- vim.g.copilot_no_tab_map = true
-- vim.keymap.set({ "i" }, "<C-f>", 'copilot#Accept("<CR>")',
--     { expr = true, silent = true, desc = "Accept Copilot Suggestion" })

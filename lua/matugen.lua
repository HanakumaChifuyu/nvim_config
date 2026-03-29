local M = {}

function M.setup()
    require('base16-colorscheme').setup {
        -- Background tones
        base00 = '#16130e',             -- Default Background
        base01 = '#231f1a',   -- Lighter Background (status bars)
        base02 = '#2e2924', -- Selection Background
        base03 = '#9b8f80',             -- Comments, Invisibles
        -- Foreground tones
        base04 = '#d2c4b4',  -- Dark Foreground (status bars)
        base05 = '#eae1d9',          -- Default Foreground
        base06 = '#eae1d9',          -- Light Foreground
        base07 = '#eae1d9',       -- Lightest Foreground
        -- Accent colors
        base08 = '#ffb4ab',               -- Variables, XML Tags, Errors
        base09 = '#b6cea3',            -- Integers, Constants
        base0A = '#dcc3a1',           -- Classes, Search Background
        base0B = '#fdba4b',             -- Strings, Diff Inserted
        base0C = '#b6cea3',  -- Regex, Escape Chars
        base0D = '#fdba4b',   -- Functions, Methods
        base0E = '#dcc3a1', -- Keywords, Storage
        base0F = '#93000a',     -- Deprecated, Embedded Tags
    }
end

-- Register a signal handler for SIGUSR1 (matugen updates)
local signal = vim.uv.new_signal()
signal:start(
    'sigusr1',
    vim.schedule_wrap(function()
        package.loaded['matugen'] = nil
        require('matugen').setup()
    end)
)

return M

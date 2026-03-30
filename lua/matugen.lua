local M = {}

function M.setup()
    require('base16-colorscheme').setup {
        -- Background tones
        base00 = '#17130e',             -- Default Background
        base01 = '#241f1a',   -- Lighter Background (status bars)
        base02 = '#2e2924', -- Selection Background
        base03 = '#9d8e81',             -- Comments, Invisibles
        -- Foreground tones
        base04 = '#d5c3b5',  -- Dark Foreground (status bars)
        base05 = '#ebe1d9',          -- Default Foreground
        base06 = '#ebe1d9',          -- Light Foreground
        base07 = '#ebe1d9',       -- Lightest Foreground
        -- Accent colors
        base08 = '#ffb4ab',               -- Variables, XML Tags, Errors
        base09 = '#bfcc9b',            -- Integers, Constants
        base0A = '#e1c1a3',           -- Classes, Search Background
        base0B = '#ffb86d',             -- Strings, Diff Inserted
        base0C = '#bfcc9b',  -- Regex, Escape Chars
        base0D = '#ffb86d',   -- Functions, Methods
        base0E = '#e1c1a3', -- Keywords, Storage
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

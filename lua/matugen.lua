local M = {}

function M.setup()
    require('base16-colorscheme').setup {
        -- Background tones
        base00 = '#121316',             -- Default Background
        base01 = '#1e2023',   -- Lighter Background (status bars)
        base02 = '#292a2d', -- Selection Background
        base03 = '#8e9199',             -- Comments, Invisibles
        -- Foreground tones
        base04 = '#c4c6cf',  -- Dark Foreground (status bars)
        base05 = '#e3e2e6',          -- Default Foreground
        base06 = '#e3e2e6',          -- Light Foreground
        base07 = '#e3e2e6',       -- Lightest Foreground
        -- Accent colors
        base08 = '#ffb4ab',               -- Variables, XML Tags, Errors
        base09 = '#dbbde2',            -- Integers, Constants
        base0A = '#bdc7dc',           -- Classes, Search Background
        base0B = '#a7c8ff',             -- Strings, Diff Inserted
        base0C = '#dbbde2',  -- Regex, Escape Chars
        base0D = '#a7c8ff',   -- Functions, Methods
        base0E = '#bdc7dc', -- Keywords, Storage
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

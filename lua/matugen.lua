local M = {}

function M.setup()
    require('base16-colorscheme').setup {
        -- Background tones
        base00 = '#181d25',             -- Default Background
        base01 = '#28303e',   -- Lighter Background (status bars)
        base02 = '#242b37', -- Selection Background
        base03 = '#616875',             -- Comments, Invisibles
        -- Foreground tones
        base04 = '#afb1b6',  -- Dark Foreground (status bars)
        base05 = '#f2f2f3',          -- Default Foreground
        base06 = '#f2f2f3',          -- Light Foreground
        base07 = '#f2f2f3',       -- Lightest Foreground
        -- Accent colors
        base08 = '#fd4663',               -- Variables, XML Tags, Errors
        base09 = '#cc6682',            -- Integers, Constants
        base0A = '#6d5cd6',           -- Classes, Search Background
        base0B = '#6794e4',             -- Strings, Diff Inserted
        base0C = '#e996ad',  -- Regex, Escape Chars
        base0D = '#93b3ec',   -- Functions, Methods
        base0E = '#a196e9', -- Keywords, Storage
        base0F = '#900017',     -- Deprecated, Embedded Tags
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

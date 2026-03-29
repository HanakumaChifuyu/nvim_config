local M = {}

function M.setup()
    require('base16-colorscheme').setup {
        -- Background tones
        base00 = '#131313',             -- Default Background
        base01 = '#1f1f1f',   -- Lighter Background (status bars)
        base02 = '#2a2a2a', -- Selection Background
        base03 = '#919191',             -- Comments, Invisibles
        -- Foreground tones
        base04 = '#c6c6c6',  -- Dark Foreground (status bars)
        base05 = '#e2e2e2',          -- Default Foreground
        base06 = '#e2e2e2',          -- Light Foreground
        base07 = '#e2e2e2',       -- Lightest Foreground
        -- Accent colors
        base08 = '#ffb4ab',               -- Variables, XML Tags, Errors
        base09 = '#e2bbdc',            -- Integers, Constants
        base0A = '#c1c6dd',           -- Classes, Search Background
        base0B = '#b4c5ff',             -- Strings, Diff Inserted
        base0C = '#e2bbdc',  -- Regex, Escape Chars
        base0D = '#b4c5ff',   -- Functions, Methods
        base0E = '#c1c6dd', -- Keywords, Storage
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

-- Lualine theme using base16 colors
function M.lualine_theme()
    return {
        normal = { a = { fg = '#131313', bg = '#e2e2e2' }, b = { fg = '#131313', bg = '#c6c6c6' }, c = { fg = '#e2e2e2', bg = '#1f1f1f' } },
        insert = { a = { fg = '#131313', bg = '#b4c5ff' }, b = { fg = '#131313', bg = '#c1c6dd' }, c = { fg = '#e2e2e2', bg = '#1f1f1f' } },
        command = { a = { fg = '#131313', bg = '#e2bbdc' }, b = { fg = '#131313', bg = '#c1c6dd' }, c = { fg = '#e2e2e2', bg = '#1f1f1f' } },
        visual = { a = { fg = '#131313', bg = '#c1c6dd' }, b = { fg = '#131313', bg = '#919191' }, c = { fg = '#e2e2e2', bg = '#1f1f1f' } },
        replace = { a = { fg = '#131313', bg = '#ffb4ab' }, b = { fg = '#131313', bg = '#c1c6dd' }, c = { fg = '#e2e2e2', bg = '#1f1f1f' } },
        inactive = { a = { fg = '#919191', bg = '#1f1f1f' }, b = { fg = '#919191', bg = '#1f1f1f' }, c = { fg = '#919191', bg = '#1f1f1f' } },
    }
end

return M

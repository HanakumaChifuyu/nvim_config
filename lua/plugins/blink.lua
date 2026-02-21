return {
    'saghen/blink.cmp',
    dependencies = { 'rafamadriz/friendly-snippets',
        {
            'Kaiser-Yang/blink-cmp-dictionary',
            dependencies = { 'nvim-lua/plenary.nvim' }
        }
    },
    version = '1.*',
    opts = {
        keymap = {
            preset = 'default',

            -- ['<Tab>'] = {
            --     'select_next', "fallback" },
            -- ['<S-Tab>'] = {
            --     "select_prev", "fallback" },
            ['<CR>'] = { 'accept', "fallback" },
        }

    },
    appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        nerd_font_variant = 'mono'
    },


    completion = {

        trigger = {
            prefetch_on_insert = false,
            show_on_keyword = true,
            show_on_trigger_character = false,
            show_on_x_blocked_trigger_characters = { "'", '"', '(', '{', '[' },

        },
        menu = {
            border = 'rounded',
            draw = {
                columns = {
                    { "label",     "label_description", gap = 1 },
                    { "kind_icon", "source_name",       gap = 1 }
                },
            }
        },

        documentation = {
            window = { border = 'rounded' },
            auto_show = false,
        },

        list = { selection = { preselect = false, auto_insert = false } },

    },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
            dictionary = {
                module = 'blink-cmp-dictionary',
                name = 'Dict',
                -- Make sure this is at least 2.
                -- 3 is recommended
                min_keyword_length = 3,
                score_offset = 0,
                opts = {
                    -- options for blink-cmp-dictionary
                    dictionary_directories = { '/home/tohno/.dict' },
                }
            },
            -- buffer = {
            --     transform_items = function(_, items)
            --         return vim.tbl_filter(function(item)
            --             -- 我们只保留不匹配（not）非 ASCII 的项
            --             local is_ascii = not item.label:match("[^\1-\127]")
            --             if not is_ascii then
            --                 vim.notify("丢弃中文项: " .. item.label)
            --             end
            --             return not is_ascii
            --         end, items)
            --     end,
            --
            -- },
            path = {

                show_hidden_files_by_default = true,
            }
        },

        -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
        -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
        -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
        --
        -- See the fuzzy documentation for more information
    },

    fuzzy = { implementation = "prefer_rust_with_warning" },
}

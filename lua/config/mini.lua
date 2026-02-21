-- mini.surround
require('mini.surround').setup()

-- mini.comment
local mc = require("mini.comment")
local config = {
    mappings = {
        -- comment_line='<leader>/'
    }
}
mc.setup(config)

-- mini.pairs
require('mini.pairs').setup(

)
require('mini.diff').setup()
-- mini.animate
-- require('mini.animate').setup()

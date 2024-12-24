return {
    {
        "echasnovski/mini.nvim",
        config = function()
            local statusline = require "mini.statusline"
            statusline.setup { use_icons = true }

            local mini_files = require("mini.files")
            mini_files.version = false
            mini_files.setup()
            vim.keymap.set("n", "-", function() mini_files.open(vim.api.nvim_buf_get_name(0)) end)
        end
    }
}

return {
    {
        "echasnovski/mini.nvim",
        config = function()
            -- require("mini.statusline").setup { use_icons = true }
            -- require("mini.surround").setup()

            local mini_files = require("mini.files")
            mini_files.setup()

            vim.keymap.set("n", "-", function() mini_files.open(vim.api.nvim_buf_get_name(0)) end)
        end
    }
}

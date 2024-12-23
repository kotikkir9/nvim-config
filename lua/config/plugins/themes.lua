return {
    { "folke/tokyonight.nvim" },
    { "rebelot/kanagawa.nvim", },
    { "savq/melange-nvim" },
    {
        "ellisonleao/gruvbox.nvim",
        name = "gruvbox",
        config = function()
            -- require("gruvbox").setup({
            --     terminal_colors = true, -- add neovim terminal colors
            --     undercurl = true,
            --     underline = false,
            --     bold = true,
            --     italic = {
            --         strings = false,
            --         emphasis = true,
            --         comments = true,
            --         operators = false,
            --         folds = true,
            --     },
            --     strikethrough = true,
            --     invert_selection = false,
            --     invert_signs = false,
            --     invert_tabline = false,
            --     invert_intend_guides = false,
            --     inverse = true,    -- invert background for search, diffs, statuslines and errors
            --     contrast = "hard", -- can be "hard", "soft" or empty string
            --     palette_overrides = {},
            --     overrides = {},
            --     dim_inactive = false,
            --     transparent_mode = false,
            -- })
        end,
    },
}

return {
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            signs = false
        }
    },
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            dashboard = {
                enabled = true,
                -- example = "doom"
                -- example = "compact_files"
            },
        },
    },
    {
        {
            "folke/snacks.nvim",
            opts = {
                dashboard = {
                    sections = {
                        { section = "header" },
                        { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1, limit = 5 },
                        { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1, limit = 5 },
                        -- { section = "keys", gap = 1, padding = 1 },
                        { section = "startup" },
                    },
                }
            }
        }
    }
}

return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        dashboard = {
            enabled = true,
            -- example = "doom"
            sections = {
                { section = "header" },
                { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1, limit = 5 },
                { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1, limit = 5 },
                { section = "startup" },
            },
        }
    }
}

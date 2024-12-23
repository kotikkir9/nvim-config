return {
    "saghen/blink.cmp",
    enabled = true,
    dependencies = "rafamadriz/friendly-snippets",
    version = "v0.*",
    opts = {
        keymap = {
            preset = "default",
            -- ["<Tab>"] = { "select_and_accept" },
        },
        appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = "mono"
        },
        signature = { enabled = true }
    },
}

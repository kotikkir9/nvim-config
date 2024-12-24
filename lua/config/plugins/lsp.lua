-- Docs: https://cmp.saghen.dev/
return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "j-hui/fidget.nvim",
            {
                "saghen/blink.cmp",
                dependencies = "rafamadriz/friendly-snippets",
                version = "*",
            },
            {
                "folke/lazydev.nvim",
                ft = "lua", -- only load on lua files
                opts = {
                    library = {
                        -- See the configuration section for more details
                        -- Load luvit types when the `vim.uv` word is found
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    },
                },
            },
        },
        config = function()
            local blink = require("blink.cmp")
            local is_wsl = vim.fn.has("wsl") == 1

            blink.setup({
                keymap = {
                    preset = "default",
                    ["<C-space>"] = { "select_and_accept" },
                    ['<C-h>'] = { 'show', 'show_documentation', 'hide_documentation' },

                },
                appearance = {
                    use_nvim_cmp_as_default = true,
                    nerd_font_variant = "mono"
                },
                signature = {
                    enabled = true
                },
                sources = {
                    cmdline = function()
                        local type = vim.fn.getcmdtype()
                        local cmdline = vim.fn.getcmdline()
                        if type == '/' or type == '?' then return { 'buffer' } end
                        if type == ':' then
                            if is_wsl and cmdline:match("^.-!") then
                                return {} -- Otherwise it will load forever (using WSL).
                            end
                            return { 'cmdline' }
                        end
                        return {}
                    end
                },
                completion = {
                    list = { selection = 'auto_insert' },
                    menu = {
                        max_height = 15,
                        border = 'single',
                        draw = {
                            columns = {
                                { "label",    "label_description", gap = 1 },
                                { "kind_icon" }
                            }
                        }
                    },
                },
            })

            local capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                blink.get_lsp_capabilities())

            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    }
                }
            })

            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                },
                handlers = {
                    function(server_name) -- default handler (optional)
                        require("lspconfig")[server_name].setup {
                            capabilities = capabilities
                        }
                    end,
                }
            })

            require("fidget").setup({})
        end,
    }
}

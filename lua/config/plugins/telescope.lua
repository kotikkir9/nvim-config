return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "debugloop/telescope-undo.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release"
        }
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")

        -- NOTE: Fucking windows!
        -- https://github.com/nvim-telescope/telescope.nvim/issues/2446

        -- https://github.com/MagicDuck/grug-far.nvim/pull/305
        local is_windows = vim.fn.has('win64') == 1 or vim.fn.has('win32') == 1
        local vimfnameescape = vim.fn.fnameescape
        local winfnameescape = function(path)
            local escaped_path = vimfnameescape(path)
            if is_windows then
                local need_extra_esc = path:find('[%[%]`%$~]')
                local esc = need_extra_esc and '\\\\' or '\\'
                escaped_path = escaped_path:gsub('\\[%(%)%^&;]', esc .. '%1')
                if need_extra_esc then
                    escaped_path = escaped_path:gsub("\\\\['` ]", '\\%1')
                end
            end
            return escaped_path
        end

        local select_default = function(prompt_bufnr)
            vim.fn.fnameescape = winfnameescape
            local result = actions.select_default(prompt_bufnr, "default")
            vim.fn.fnameescape = vimfnameescape
            return result
        end

        telescope.setup {
            defaults = {
                mappings = {
                    i = {
                        ['<cr>'] = select_default,
                    },
                    n = {
                        ['<cr>'] = select_default,
                    }
                },
            },
            pickers = {
                buffers = {
                    show_all_buffers = true,
                    sort_lastused = true,
                    previewer = false,
                    theme = "dropdown",
                    mappings = {
                        i = {
                            ["<C-d>"] = "delete_buffer",
                            ["<M-b>"] = actions.close
                        },
                        n = {
                            ["<leader>b"] = actions.close,
                            ["d"] = "delete_buffer",
                        }
                    },
                },
                diagnostics = {
                    previewer = false,
                    theme = "ivy",
                },
                find_files = {
                    -- theme = "ivy"
                    -- find_command = {
                    --     "rg",
                    --     "--files",
                    --     "--glob",
                    --     "!{.git/*,.svelte-kit/*,target/*,node_modules/*}",
                    --     "--path-separator",
                    --     "/",
                    -- },
                },
                lsp_references = {
                    theme = "ivy"
                },
                lsp_definitions = {
                    theme = "ivy"
                },
                lsp_implementations = {
                    theme = "ivy"
                },
            },
            extensions = {
                fzf = {},
                undo = {},
            }
        }

        telescope.load_extension("fzf")
        telescope.load_extension("undo")

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[F]uzzy [H]elp' })
        vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[F]uzzy [K]eymaps' })
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]uzzy [F]iles' })
        vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[F]uzzy [D]iagnostics' })
        vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = '[F]uzzy [R]esume' })
        vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = '[F]uzzy [O]ld Files' })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = '[F]uzzy [B]uffers' })
        vim.keymap.set('n', '<leader>b', builtin.buffers, { desc = '[B]uffers' })
        -- vim.keymap.set('n', '<leader>fs', builtin.builtin, { desc = '[F]uzzy [S]earch [S]elect Telescope' })

        vim.keymap.set('n', '<leader>f.', function()
            -- You can pass additional configuration to Telescope to change the theme, layout, etc.
            builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                winblend = 10,
                previewer = false,
            })
        end, { desc = '[.] Fuzzily search in current buffer' })

        -- Shortcut for searching your Neovim configuration files
        vim.keymap.set('n', '<leader>fn', function()
            builtin.find_files { cwd = vim.fn.stdpath("config") }
        end, { desc = '[F]uzzy [N]eovim config files' })

        vim.keymap.set("n", "<space>u", "<cmd>Telescope undo<CR>")
        vim.keymap.set("n", "<leader>fg", require("config.telescope.multigrep").live_multigrep)

        -- vim.keymap.set("n", "<space>ep", function()
        --     ---@diagnostic disable-next-line: param-type-mismatch
        --     require("telescope.builti").find_files { cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy") }
        -- end)
    end
}

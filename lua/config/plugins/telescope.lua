return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "debugloop/telescope-undo.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
    },
    config = function()
        local telescope = require("telescope")

        telescope.setup {
            pickers = {
                find_files = {
                    -- theme = "ivy"
                },
                oldfiles = {
                    -- theme = "ivy"
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

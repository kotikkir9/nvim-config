return {
    "tamago324/lir.nvim",
    enabled = false,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "kyazdani42/nvim-web-devicons",
        -- "tamago324/lir-git-status.nvim"
    },
    config = function()
        local actions = require('lir.actions')
        local mark_actions = require('lir.mark.actions')
        local clipboard_actions = require('lir.clipboard.actions')
        local float = require('lir.float')

        vim.keymap.set("n", "-", float.toggle)
        -- vim.keymap.set("n", "<leader>pv", float.toggle)

        -- require("lir.git_status").setup({
        --   show_ignored = false
        -- })

        ---@diagnostic disable-next-line: missing-fields
        require("lir").setup({
            show_hidden_files = false,
            ignore = {}, -- { ".DS_Store", "node_modules" } etc.
            devicons = {
                enable = true,
                highlight_dirname = true
            },
            mappings = {
                ['l']     = actions.edit,
                ['<C-s>'] = actions.split,
                ['<C-v>'] = actions.vsplit,
                ['<C-t>'] = actions.tabedit,

                ['h']     = actions.up,
                ['q']     = actions.quit,

                ['K']     = actions.mkdir,
                ['N']     = actions.newfile,
                ['R']     = actions.rename,
                ['@']     = actions.cd,
                ['Y']     = actions.yank_path,
                ['.']     = actions.toggle_show_hidden,
                ['D']     = actions.delete,

                ['J']     = function()
                    ---@diagnostic disable-next-line: missing-parameter
                    mark_actions.toggle_mark()
                    vim.cmd('normal! j')
                end,
                ['C']     = clipboard_actions.copy,
                ['X']     = clipboard_actions.cut,
                ['P']     = clipboard_actions.paste,
            },
            ---@diagnostic disable-next-line: missing-fields
            float = {
                winblend = 0,
                curdir_window = {
                    enable = true,
                    highlight_dirname = true
                },

                -- -- You can define a function that returns a table to be passed as the third
                -- -- argument of nvim_open_win().
                -- win_opts = function()
                --   local width = math.floor(vim.o.columns * 0.8)
                --   local height = math.floor(vim.o.lines * 0.8)
                --   return {
                --     border = {
                --       "+", "─", "+", "│", "+", "─", "+", "│",
                --     },
                --     width = width,
                --     height = height,
                --     row = 1,
                --     col = math.floor((vim.o.columns - width) / 2),
                --   }
                -- end,
            },
            hide_cursor = true
        })

        vim.api.nvim_create_autocmd({ 'FileType' }, {
            pattern = { "lir" },
            callback = function()
                -- use visual mode
                vim.api.nvim_buf_set_keymap(
                    0,
                    "x",
                    "J",
                    ':<C-u>lua require"lir.mark.actions".toggle_mark("v")<CR>',
                    { noremap = true, silent = true }
                )

                -- echo cwd
                vim.api.nvim_echo({ { vim.fn.expand("%:p"), "Normal" } }, false, {})
            end
        })

        -- custom folder icon
        require 'nvim-web-devicons'.set_icon({
            lir_folder_icon = {
                icon = "",
                color = "#7ebae4",
                name = "LirFolderNode"
            }
        })
    end
}

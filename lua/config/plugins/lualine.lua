return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local problems = 0
        local cached_problems = nil
        local timer = nil
        local severity = { vim.diagnostic.severity.ERROR, vim.diagnostic.severity.WARN }

        local update_problems_count = function()
            local errors = #vim.diagnostic.get(nil, { severity = severity })
            if vim.api.nvim_get_mode().mode == "i" then
                cached_problems = errors
            else
                problems = errors
                cached_problems = nil
            end
        end

        vim.api.nvim_create_autocmd("InsertLeave", {
            callback = function()
                if cached_problems then
                    problems = cached_problems
                    cached_problems = nil
                end
            end
        })

        vim.api.nvim_create_autocmd("DiagnosticChanged", {
            callback = function()
                if timer then
                    timer:stop()
                    timer:close()
                end

                timer = vim.uv.new_timer()
                if timer then
                    timer:start(500, 0, update_problems_count)
                else
                    vim.notify("Failed to set debounce timer.", vim.log.levels.WARN)
                    update_problems_count()
                end
            end,
        })

        require("lualine").setup({
            options = {
                refresh = {
                    statusline = 500,
                    tabline = 500,
                    winbar = 500,
                },
                globalstatus = false,
                -- component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
                component_separators = { left = "›", right = "‹" },
                -- component_separators = "•",
            },
            sections = {
                lualine_a = {
                    {
                        "mode",
                        fmt = function(str)
                            return str:sub(1, 1)
                        end,
                    },
                },
                lualine_b = {
                    {
                        function()
                            if problems > 0 then
                                return problems
                            else
                                return ""
                            end
                        end,
                        icon = "",
                        color = function()
                            local color = vim.fn.synIDattr(vim.fn.hlID("DiagnosticError"), "fg")
                            if string.sub(color, 1, 1) ~= '#' then
                                color = "red"
                            end
                            return { fg = color }
                        end,
                        on_click = function()
                            require("telescope.builtin").diagnostics()
                        end
                    },
                    'branch',
                    'diff'
                },
                lualine_c = {
                    {
                        "filename",
                        path = 1,
                    },
                },
                lualine_x = {
                    "diagnostics",
                    'encoding',
                    'fileformat',
                    {
                        "filetype",
                        icon_only = true,
                    }
                },
                lualine_y = {},
                lualine_z = {
                    "%l:%L"
                },
            }
        })
    end
}

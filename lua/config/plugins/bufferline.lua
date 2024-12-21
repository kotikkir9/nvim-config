-- :bd          - deletes the current buffer, error if there are unwritten changes
-- :bd!         - deletes the current buffer, no error if unwritten changes
-- :bufdo bd    - deletes all buffers, stops at first error (unwritten changes)
-- :bufdo! bd   - deletes all buffers except those with unwritten changes
-- :bufdo! bd!  - deletes all buffers, no error on any unwritten changes
--
-- :bw          - completely deletes the current buffer, error if there are unwritten changes
-- :bw!         - completely deletes the current buffer, no error if unwritten changes
-- :bufdo bw    - completely deletes all buffers, stops at first error (unwritten changes)
-- :bufdo! bw   - completely deletes all buffers except those with unwritten changes
-- :bufdo! bw!  - completely deletes all buffers, no error on any unwritten changes
--
-- :set confirm - confirm changes (Yes, No, Cancel) instead of error
--
-- :ls          - list open buffers
-- :b N         - open buffer number N (as shown in ls)
-- :tabe +Nbuf  - open buffer number N in new tab
-- :bnext       - go to the next buffer (:bn also)
-- :bprevious   - go to the previous buffer (:bp also)

return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
        local bufferline = require("bufferline")


        vim.keymap.set("n", "<leader>n", "<cmd>bnext<CR>")
        vim.keymap.set("n", "<leader>p", "<cmd>bprev<CR>")
        vim.keymap.set("n", "<leader>dd", function()
            if vim.bo.buftype == "terminal" then
                vim.cmd("bd!")
            else
                vim.cmd("bd")
            end
        end)


        bufferline.setup {
            options = {
                mode = "buffers",
                -- mode = "tabs",
                separator_style = "thick",
                numbers = "both",
                indicator = {
                    -- icon = "| ",
                    -- style = "icon"
                },
                diagnostics = "nvim_lsp",
                diagnostics_indicator = function(_, _, diagnostics_dict, _)
                    -- local icon = level:match("error") and " " or " "
                    -- return " " .. icon .. count
                    local s = " "
                    for e, n in pairs(diagnostics_dict) do
                        local sym = e == "error" and " " or (e == "warning" and " " or " ")
                        s = s .. n .. sym
                    end
                    return s
                end
            }
        }
    end
}

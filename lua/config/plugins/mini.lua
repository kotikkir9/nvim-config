return {
  {
    "echasnovski/mini.nvim",
    config = function()
      local statusline = require "mini.statusline"
      statusline.setup { use_icons = true }

      -- local files = require "mini.files"
      -- files.version = false
      -- files.setup()
      -- vim.keymap.set("n", "-", require('mini.files').open)
    end
  }
}

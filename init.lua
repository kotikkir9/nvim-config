require("config.lazy")
require("config.keymap")
require("config.autocmd")

vim.cmd.colorscheme "kanagawa-wave"
-- vim.cmd.colorscheme "kanagawa-dragon"
-- vim.cmd.colorscheme "melange"
-- vim.cmd.colorscheme "gruvbox"

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.o.confirm = true

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.clipboard = "unnamedplus"
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes:1"
-- vim.opt.colorcolumn = "100"

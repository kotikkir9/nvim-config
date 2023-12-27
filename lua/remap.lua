vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set("i", "jj", "<ESC>")

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Insert mode test
vim.keymap.set('i', '<c-l>', '<Right>') -- Right
vim.keymap.set('i', '<c-h>', '<Left>')  -- Left
vim.keymap.set('i', '<c-k>', '<Up>')    -- Up
vim.keymap.set('i', '<c-j>', '<Down>')  -- Down
vim.keymap.set('i', '<c-w>', '<C-o>w')  -- Next word
vim.keymap.set('i', '<c-b>', '<C-o>b')  -- Prev word

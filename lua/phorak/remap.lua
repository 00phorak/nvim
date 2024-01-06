-- Remap some things

vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "File explorer" })

-- Map <Esc> to normal mode and clear search highlight
vim.api.nvim_set_keymap('n', '<Esc>', ':noh<CR>', { noremap = true, silent = true })

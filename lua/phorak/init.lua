require("phorak.remap")

local augroup = vim.api.nvim_create_augroup
local custom_group= augroup('custom_group', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({"BufWritePre"}, {
    group = custom_group,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

require("lazy").setup({
	opts = {
		change_detection = {
			notify = false,
		},
	},
    'nvim-lua/plenary.nvim',
    { import = "phorak.plugins"},
    "nvim-treesitter/nvim-treesitter-context",
    'mfussenegger/nvim-dap',
    "rcarriga/nvim-dap-ui",
})

-- vim.cmd[[colorscheme tokyonight-night]]
vim.cmd[[colorscheme rose-pine]]

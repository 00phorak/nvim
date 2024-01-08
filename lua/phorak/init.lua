require("phorak.remap")

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
		{
			import = "phorak.plugins",
		},
		{
			import = "phorak.lsp",
		},
		'nvim-lua/plenary.nvim',
		"nvim-treesitter/nvim-treesitter-context",
		'mfussenegger/nvim-dap',
		{
			"folke/neodev.nvim",
			dependencies = { "rcarriga/nvim-dap-ui" },
			opts = {
				library = { plugins = { "nvim-dap-ui" }, types = true },

			}
		}
	},
	{
		change_detection = {
			notify = false,
		},
	}
)

vim.cmd [[colorscheme rose-pine]]
-- vim.cmd[[colorscheme tokyonight-night]]

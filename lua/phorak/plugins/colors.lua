return {
	-- "utilyre/barbecue.nvim",
	-- name = "barbecue",
	-- version = "*",
	-- dependencies = {
	-- "SmiteshP/nvim-navic",
	-- "nvim-tree/nvim-web-devicons", -- optional dependency
	-- },
	-- opts = {
	-- -- configurations go here
	--     create_autocmd = false, -- prevent barbecue from updating itself automatically
	--     theme = 'tokyonight',
	-- },
	{
		'rose-pine/neovim',
		name = 'rose-pine',
		lazy = false,
		priority = 1000,
		-- config = function()
		-- 	require('rose-pine').setup({
		-- 		-- disable_background = true
		-- 	})
		-- end
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},

}

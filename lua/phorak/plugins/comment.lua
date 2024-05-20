return {
	'numToStr/Comment.nvim',
	config = function()
		require('Comment').setup {
			opleader = {
				-- Line-comment keymap
				line = '<leader>c',
			}
		}
	end
}

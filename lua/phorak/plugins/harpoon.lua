return {
	'theprimeagen/harpoon',
	config = function()
		local mark = require("harpoon.mark")
		local ui = require("harpoon.ui")


		vim.keymap.set("n", "<leader>a", mark.add_file, { desc = "Harpoon add file" })
		vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu, { desc = "Harpoon toggle menu" })

		vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end, { desc = "Harpoon nav file 1" })
		vim.keymap.set("n", "<C-j>", function() ui.nav_file(2) end, { desc = "Harpoon nav file 2" })
		vim.keymap.set("n", "<C-k>", function() ui.nav_file(3) end, { desc = "Harpoon nav file 3" })
		vim.keymap.set("n", "<C-l>", function() ui.nav_file(4) end, { desc = "Harpoon nav file 4" })

		vim.keymap.set("n", "<tab>", function() ui.nav_next() end, { desc = "Harpoon next file" })
		vim.keymap.set("n", "<S-tab>", function() ui.nav_prev() end, { desc = "Harpoon previous file" })
	end
}

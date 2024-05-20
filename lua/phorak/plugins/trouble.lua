return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("trouble").setup({
		})
		vim.keymap.set("n", "<leader>tt", function() require("trouble").toggle() end,
			{ remap = false, desc = "LSP Trouble Toggle" })
		vim.keymap.set("n", "gw", function() require("trouble").toggle("workspace_diagnostics") end,
			{ remap = false, desc = "LSP Trouble Workspace Diagnostics" })
		vim.keymap.set("n", "gl", function() require("trouble").toggle("document_diagnostics") end,
			{ remap = false, desc = "LSP Trouble Document Diagnostics" })
		vim.keymap.set("n", "gq", function() require("trouble").toggle("quickfix") end,
			{ remap = false, desc = "LSP Trouble QuickFix" })
		vim.keymap.set("n", "gr", function() require("trouble").toggle("lsp_references") end,
			{ remap = false, desc = "LSP Trouble Reference" })

		-- vim.keymap.set("n", "]d", function() require("trouble").next({ skip_groups = true, jump = true }) end,
		-- 	{ remap = false, desc = "LSP Trouble Next" })
		-- vim.keymap.set("n", "[d", function() require("trouble").previous({ skip_groups = true, jump = true }) end,
		-- 	{ remap = false, desc = "LSP Trouble Previous" })
	end,
}

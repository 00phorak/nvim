local set = vim.opt

-- set.clipboard = "unnamedplus"
set.completeopt = 'noinsert,menuone,noselect'
set.hidden = true
set.autoindent = true
set.mouse = 'a'
set.number = true
set.relativenumber = true
set.title = true
set.ttyfast = true
set.shiftwidth = 4
set.expandtab = false
set.tabstop = 4
set.hlsearch = true
set.incsearch = true
set.showmatch = true
set.list = false

vim.g.mapleader = " "
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
-- Remap some things
local custom_group = vim.api.nvim_create_augroup('custom_group', { clear = false })

local autocmd = vim.api.nvim_create_autocmd
local yank_group = vim.api.nvim_create_augroup('HighlightYank', { clear = false })

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>e", vim.cmd.Ex, { desc = "File explorer" })
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
local keymap = vim.keymap.set
keymap("n", "]d", vim.diagnostic.goto_next)
keymap("n", "[d", vim.diagnostic.goto_prev)

-- Move visual selection around
keymap("v", "J", ":m '>+1<CR>gv=gv")
keymap("v", "K", ":m '<-2<CR>gv=gv")
-- When jumping around _next_ search fields, center the screen
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")
-- Center it when jumping up and down
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")

-- Map <Esc> to normal mode and clear search highlight
vim.api.nvim_set_keymap('n', '<Esc>', ':noh<CR>', { noremap = true, silent = true })

-- Autocmds
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

autocmd({ "BufWritePre" }, {
	group = custom_group,
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

local lsp_format_on_save = function(bufnr)
	vim.api.nvim_create_autocmd('BufWritePre', {
		group = custom_group,
		buffer = bufnr,
		callback = function()
			vim.lsp.buf.format()
			-- filter = function(client)
			--   return client.name == "null-ls"
			-- end
		end,
	})
end
-- LSP
autocmd('LspAttach', {
	group = custom_group,
	callback = function(ev)
		lsp_format_on_save(ev.buf)

		vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end,
			{ buffer = ev.buf, remap = false, desc = "LSP Go Definition" })
		vim.keymap.set("n", "<leader>k", function() vim.lsp.buf.hover() end,
			{ buffer = ev.buf, remap = false, desc = "LSP Hover" })
		vim.keymap.set("n", "<leader>s", function() vim.lsp.buf.symbol() end,
			{ buffer = ev.buf, remap = false, desc = "LSP Symbol" })
		vim.keymap.set("n", "<leader>S", function() vim.lsp.buf.workspace_symbol() end,
			{ buffer = ev.buf, remap = false, desc = "LSP Workspace Symbol" })
		vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end,
			{ buffer = ev.buf, remap = false, desc = "LSP Open Flaot" })
		vim.keymap.set("n", "<leader>a", function() vim.lsp.buf.code_action() end,
			{ buffer = ev.buf, remap = false, desc = "LSP Code Action" })
		vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end,
			{ buffer = ev.buf, remap = false, desc = "LSP References" })
		vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end,
			{ buffer = ev.buf, remap = false, desc = "LSP Implementation" })
		vim.keymap.set("n", "<leader>r", function() vim.lsp.buf.rename() end,
			{ buffer = ev.buf, remap = false, desc = "LSP Rename" })
		vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end,
			{ buffer = ev.buf, remap = false, desc = "LSP Signature Help" })
	end
})
